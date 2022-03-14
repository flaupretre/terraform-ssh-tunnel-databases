
This module creates/manages a set of PostgreSql database. For each database, we
first create a role which the same name as the database. Then, we create the
database, setting the newly-created role as DB owner. We then grant every
privilege for this role on the database.

A 'readonly' role is also created. It can read from every database tables.

We manage a set of databases because the module cannot be inserted in a
for_each loop, as it contains a providers (terraform does not support a provider
definition within a for_each loop).


<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_postgresql.tunnel"></a> [postgresql.tunnel](#provider\_postgresql.tunnel) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_db_tunnel"></a> [db\_tunnel](#module\_db\_tunnel) | flaupretre/tunnel/ssh | 1.6.0 |

## Resources

| Name | Type |
|------|------|
| [postgresql_database.this](https://registry.terraform.io/providers/cyrilgdn/postgresql/latest/docs/resources/database) | resource |
| [postgresql_grant.ro](https://registry.terraform.io/providers/cyrilgdn/postgresql/latest/docs/resources/grant) | resource |
| [postgresql_grant.rw](https://registry.terraform.io/providers/cyrilgdn/postgresql/latest/docs/resources/grant) | resource |
| [postgresql_role.ro](https://registry.terraform.io/providers/cyrilgdn/postgresql/latest/docs/resources/role) | resource |
| [postgresql_role.rw](https://registry.terraform.io/providers/cyrilgdn/postgresql/latest/docs/resources/role) | resource |

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