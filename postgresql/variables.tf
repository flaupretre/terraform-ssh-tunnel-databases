
variable gateway_host {
  type = string
}

variable target_host {
  type = string
}

variable target_port {
  type = string
}

variable username {
  type = string
}

variable password {
  type = string
}

# Format: map of :
# <db_name> = {
#    username =
#    password =
#    [ro_username = default is <db_username>_ro
#    [ro_password =
#    [master_is_owner (bool)
#    [encoding
#    [lc_collate
#    [lc_ctype
#  }

variable db {
  type = any
}

variable defaults {
  type = any
  default = {}
}

