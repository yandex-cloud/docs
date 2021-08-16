# Assigning roles {{ PG }}

{{ mpg-name }} doesn't let you access [default roles](https://www.postgresql.org/docs/current/default-roles.html). Instead, it provides special roles:

* `mdb_admin`: For users who aren't database owners, but need administrative privileges.
* `mdb_replication`: For users who need logical replication.

To assign a user a role, [use](../operations/grant.md) the {{ yandex-cloud }} CLI or API: role assignment from a `GRANT` query is canceled when the next database operation is performed.

## mdb_admin role {#mdb-admin}

The `mdb_admin` role includes the following privileges:

* System role privileges:
    * `pg_monitor`
    * `pg_signal_backend`
Learn more about system role in [{{ PG }} documentation](https://www.postgresql.org/docs/current/default-roles.html).
* Subscription for logical replication (`CREATE | DROP | ALTER SUBSCRIPTION`).
* Extensions:
    * `dblink`
    * `pg_repack`
    * `postgres_fdw`
* Extension-specific functions:
    * `pg_stat_kcache_reset()` from the `pg_stat_kcache` extension.
    * `pg_stat_reset()` and `pg_stat_statements_reset()` from the `pg_stat_statements` extension.

## mdb_replication role {#mdb-replication}

The `mdb_replication` role includes the following privileges:

* Connecting to a cluster using the logical replication protocol (`replication=database`).
* Using the replication function:
    * `pg_create_logical_replication_slot`
    * `pg_drop_replication_slot`

