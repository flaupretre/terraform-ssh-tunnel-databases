
The modules in this repository allow to create databases behind an SSH tunnel. The SSH tunnel is described [here](https://github.com/flaupretre/terraform-ssh-tunnel).

Using this code as example, it should be very easy to adapt it to any DBMS flavor.

## Setup

### Requirements

- A bation (`gateway_host`) with access to database server (`target_host`).

- Check access from bastion (`gateway_host`) to database (`target_host:target_port`). Enable Security Group or firewall.

- A SSH certificate recorded at the `~/.ssh/authorized_keys` of the remote user (`gateway_user`) at the bastion (`gateway_host`) to access without passphrase or password to remote host.  Also a passhprase protected certificate recorded to local ssh-agent may be used.

- The command `timeout`. MacOS users need to install it with `brew install coreutils`.

### Configuration examples

```
module db {
  source               = "git::git@github.com:flaupretre/terraform-ssh-tunnel-databases//mysql"

  target_host          = "your.remote.endpoint.rds.amazonaws.com"
  target_port          = "3306"
  gateway_host         = "IP.OF.YOUR.BASTION"
  gateway_user         = "bastion-user"
  username             = "rds-admin-user"
  password             = "rds-admin-password"
  db                   = {
    "mydatabase" = {
      username    = "mydatabase-user-rw"
      password    = "a-password"
      ro_username = "mydatabase-user-ro"
      ro_password = "a-password"
    },
     "anotherdatabase" = {
      username    = "anotherdatabase-user-wd"
      password    = "a-password"
      ro_password = "a-password"
    }
  }
}
```

```
module pg {
  source               = "git::git@github.com:flaupretre/terraform-ssh-tunnel-databases//postgresql"

  target_host          = "your.remote.endpoint.rds.amazonaws.com"
  target_port          = "5432"
  gateway_host         = "IP.OF.YOUR.BASTION"
  gateway_user         = "bastion-user"
  username             = "rds-admin-user"
  password             = "rds-admin-password"
  db                   = {
    "pgdatabase" = {
      username    = "pgdatabase-user-rw"
      password    = "a-password"
      ro_username = "pgdatabase-user-ro"
      ro_password = "a-password"
    },
     "otherdatabase" = {
      username    = "otherdatabase-user-rw"
      password    = "a-password"
      ro_password = "a-password"
    }
  }
}
```
