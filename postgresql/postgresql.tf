
#----

module db_tunnel {
  source       = "flaupretre/tunnel/ssh"
  version      = "1.4.0"
#  source       = "/work/terraform-ssh-tunnel"

  target_host  = var.target_host
  target_port  = var.target_port
  gateway_host = var.gateway_host
}

#----

provider postgresql {
  #alias    = "tunnel"
  host     = module.db_tunnel.host
  port     = module.db_tunnel.port
  username = var.username
  password = var.password
  database = "postgres"
  superuser = false
}

#---- Database

resource postgresql_database this {
  for_each = var.db
  #provider = postgresql.tunnel

  name     = each.key
  owner = lookup(each.value, "master_is_owner", false) ? var.username : postgresql_role.rw[each.key].name

  encoding = lookup(each.value, "encoding", lookup(var.defaults, "encoding", "UTF8"))
  lc_collate = lookup(each.value, "lc_collate", lookup(var.defaults, "lc_collate", "C"))
  lc_ctype = lookup(each.value, "lc_ctype", lookup(var.defaults, "lc_ctype", "C"))
}

#---- DB user/role

resource postgresql_role rw {
  for_each = var.db
  #provider = postgresql.tunnel

  name     = each.value.username
  login    = true
  password = each.value.password
}

#---- Grant
# SQL: grant all on <db>.* to <user>@'%';

resource postgresql_grant rw {
  for_each = var.db
  #provider    = postgresql.tunnel

  object_type = "database"
  database    = postgresql_database.this[each.key].name
  role        = postgresql_role.rw[each.key].name
  privileges  = ["ALL"]
}

#---- DB user (Readonly)

resource postgresql_role ro {
  for_each = var.db
  #provider = postgresql.tunnel

  name     = lookup(each.value, "ro_username", "${each.value.username}_ro")
  login    = true
  password = each.value.ro_password
}

#---- Grant (Readonly)

resource postgresql_grant ro {
  for_each    = var.db
  #provider    = postgresql.tunnel

  object_type = "table"
  database    = postgresql_database.this[each.key].name
  schema      = "public"
  role        = postgresql_role.ro[each.key].name
  privileges  = ["SELECT"]
}
