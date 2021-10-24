
This module creates/manages a set of PostgreSql database. For each database, we
first create a role which the same name as the database. Then, we create the
database, setting the newly-created role as DB owner. We then grant every
privilege for this role on the database.

A 'readonly' role is also created. It can read from every database tables.

We manage a set of databases because the module cannot be inserted in a
for_each loop, as it contains a providers (terraform does not support a provider
definition within a for_each loop).

