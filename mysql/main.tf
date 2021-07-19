
#----

module db_tunnel {
  source       = "flaupretre/tunnel/ssh"
  version      = "1.3.1"
#  source       = "/work/terraform-ssh-tunnel"

  target_host  = var.target_host
  target_port  = var.target_port
  gateway_host = var.gateway_host
}

#----

provider mysql {
  alias    = "tunnel"
  endpoint = "127.0.0.1:${module.db_tunnel.port}"
  username = var.username
  password = var.password
}

#---- Database
# SQL: create database xxx;

resource mysql_database this {
  provider = mysql.tunnel
  lifecycle {
    prevent_destroy = true
  }

  name     = var.db_name
}

#---- DB user
# SQL: create user xxx@'%' identified by 'password';

resource mysql_user rw {
  provider           = mysql.tunnel
  user               = var.db_username
  host               = "%"
  plaintext_password = var.db_password
}

# SQL: grant all on <db>.* to <user>@'%';

resource mysql_grant rw {
  provider   = mysql.tunnel
  # This line forces the 'grant' to wait for the user to be ready
  user       = mysql_user.rw.user
  host       = "%"
  database   = mysql_database.this.name
  privileges = ["ALL"]
}

#---- DB user (Readonly)

resource mysql_user ro {
  count              = (var.readonly_db_username == "" ? 0 : 1)
  provider           = mysql.tunnel
  user               = var.readonly_db_username
  host               = "%"
  plaintext_password = var.readonly_db_password
}

# SQL: grant select on <db>.* to <readonly_user>@'%';

resource mysql_grant ro {
  count      = (var.readonly_db_username == "" ? 0 : 1)
  provider   = mysql.tunnel
  user       = mysql_user.ro.0.user
  host       = "%"
  database   = mysql_database.this.name
  privileges = ["SELECT"]
}
