 
#----

module db_tunnel {
  source       = "flaupretre/tunnel/ssh"
  version      = "1.6.0"
#  source       = "/work/terraform-ssh-tunnel"

  target_host  = var.target_host
  target_port  = var.target_port
  gateway_host = var.gateway_host
  gateway_user = var.gateway_user
}

#----

provider mysql {
  alias    = "tunnel"
  endpoint = "${module.db_tunnel.host}:${module.db_tunnel.port}"
  username = var.username
  password = var.password
}

#---- Database
# SQL: create database xxx;

resource mysql_database this {
  for_each = var.db
  provider = mysql.tunnel

  name     = each.key
}

#---- DB user
# SQL: create user xxx@'%' identified by 'password';

resource mysql_user rw {
  for_each           = var.db
  provider           = mysql.tunnel
  user               = each.value.username
  host               = "%"
  plaintext_password = each.value.password
}

# SQL: grant all on <db>.* to <user>@'%';

resource mysql_grant rw {
  for_each   = var.db
  provider   = mysql.tunnel
  # This line forces the 'grant' to wait for the user to be ready
  user       = mysql_user.rw[each.key].user
  host       = "%"
  database   = mysql_database.this[each.key].name
  privileges = lookup(each.value, "rw_privileges", lookup(var.defaults, "rw_privileges", ["ALL"]))
}

#---- DB user (Readonly)

resource mysql_user ro {
  for_each           = var.db
  provider           = mysql.tunnel
  user               = lookup(each.value, "ro_username", "${each.value.username}_ro")
  host               = "%"
  plaintext_password = each.value.ro_password
}

# SQL: grant select on <db>.* to <readonly_user>@'%';

resource mysql_grant ro {
  for_each   = var.db
  provider   = mysql.tunnel
  user       = mysql_user.ro[each.key].user
  host       = "%"
  database   = mysql_database.this[each.key].name
  privileges = lookup(each.value, "ro_privileges", lookup(var.defaults, "ro_privileges", ["SELECT"]))
}
