
variable gateway_host {
  type = string
  default = null
}

variable gateway_user {
  type = string
  default = ""
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
#    [create = true]
#    username =
#    password =
#    [default_character_set = "utf8"]
#    [default_collation = "utf8_general_ci"]
#    [ro_username = default is <db_username>_ro
#    [ro_password =
#    [rw_privileges = ["ALL"]
#    [ro_privileges = ["SELECT"]
#  }

variable db {
  type = any
}

variable defaults {
  type = any
  default = {}
}

