
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

variable db_name {
  type = string
}

variable db_username {
  type = string
}

variable db_password {
  type = string
}

variable readonly_db_username {
  type = string
  default = ""
}

variable readonly_db_password {
  type = string
  default = ""
}
