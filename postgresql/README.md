
This module creates/manages a set of PostgreSql database. For each database, we
first create a role which the same name as the database. Then, we create the
database, setting the newly-created role as DB owner. We then grant every
privilege for this role on the database.

A 'readonly' role is also created. It can read from every database tables.

Please note that, at this time (July 2021), the postgresql provider is not
perfectly stable. Among other known issues, it may raise a 'connection refused'
error while trying to connect to check object existence. Other issues were
observed when using a provider alias. That's why provider aliases are
removed now.

We manage a set of databases because the module cannot be inserted in a
for_each loop, as it contains a providers (terraform does not support a provider
definition within a for_each loop).

