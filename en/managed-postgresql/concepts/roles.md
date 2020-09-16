# Assigning roles {{ PG }}

{{ mpg-name }} lets you [create your own roles](https://www.postgresql.org/docs/current/sql-createrole.html) in {{ PG }} databases, but it doesn't let you access the [default roles](https://www.postgresql.org/docs/current/default-roles.html). A special `mdb_admin` role is provided for users who aren't DB owners, but need administrative privileges.

To assign a user role, [use](../operations/grant.md) the Yandex.Cloud CLI or API: role assignment from a `GRANT` request is canceled when the next database operation is performed.

## The mdb_admin role {#mdb-admin}

The `mdb_admin` role includes the following privileges:

* Use system role privileges:
  * `pg_monitor`
  * `pg_signal_backend`
* Use subscriptions for logical replication (`CREATE | DROP | ALTER SUBSCRIPTION`).
* Use extensions:
  * `dblink`
  * `pg_repack`
  * `postgres_fdw`
* Use extension-specific functions:
  * `pg_stat_kcache_reset()` from the `pg_stat_kcache` extension.
  * `pg_stat_reset()` and `pg_stat_statements_reset()` from the `pg_stat_statements` extension.

