
This module creates/manages a MySql database, a user with every permissions on the database and, optionally, a user with readonly rights on the database.


<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_mysql.tunnel"></a> [mysql.tunnel](#provider\_mysql.tunnel) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_db_tunnel"></a> [db\_tunnel](#module\_db\_tunnel) | flaupretre/tunnel/ssh | 1.7.0 |

## Resources

| Name | Type |
|------|------|
| [mysql_database.this](https://registry.terraform.io/providers/terraform-providers/mysql/latest/docs/resources/database) | resource |
| [mysql_grant.ro](https://registry.terraform.io/providers/terraform-providers/mysql/latest/docs/resources/grant) | resource |
| [mysql_grant.rw](https://registry.terraform.io/providers/terraform-providers/mysql/latest/docs/resources/grant) | resource |
| [mysql_user.ro](https://registry.terraform.io/providers/terraform-providers/mysql/latest/docs/resources/user) | resource |
| [mysql_user.rw](https://registry.terraform.io/providers/terraform-providers/mysql/latest/docs/resources/user) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create"></a> [create](#input\_create) | n/a | `bool` | `true` | no |
| <a name="input_db"></a> [db](#input\_db) | n/a | `any` | n/a | yes |
| <a name="input_defaults"></a> [defaults](#input\_defaults) | n/a | `any` | `{}` | no |
| <a name="input_gateway_host"></a> [gateway\_host](#input\_gateway\_host) | n/a | `string` | n/a | yes |
| <a name="input_gateway_user"></a> [gateway\_user](#input\_gateway\_user) | n/a | `string` | n/a | yes |
| <a name="input_password"></a> [password](#input\_password) | n/a | `string` | n/a | yes |
| <a name="input_target_host"></a> [target\_host](#input\_target\_host) | n/a | `string` | n/a | yes |
| <a name="input_target_port"></a> [target\_port](#input\_target\_port) | n/a | `string` | n/a | yes |
| <a name="input_username"></a> [username](#input\_username) | n/a | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->