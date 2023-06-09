# Assigning {{ PG }} roles

With {{ mpg-name }}, you cannot you access [predefined roles](https://www.postgresql.org/docs/current/predefined-roles.html). Instead, this service provides you with the following special roles:

* `mdb_admin`: For users who are not database owners but need administrative privileges.
* `mdb_monitor`: For users who need to read various configuration parameters, statistics, and other system information.
* `mdb_replication`: For users who need access to logical replication.

To assign a user a role, [use](../operations/grant.md) the {{ yandex-cloud }} CLI or API; the roles assigned by a `GRANT` request are revoked when the next database operation is performed.

## `mdb_admin` role {#mdb-admin}

The `mdb_admin` role includes the following privileges:

* Predefined role privileges:
   * `pg_monitor`
   * `pg_signal_backend`
      For more information about predefined roles, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/predefined-roles.html).
* Subscription for logical replication (`CREATE | DROP | ALTER SUBSCRIPTION`).
* Extensions:
   * `dblink`
   * `pg_repack`
   * `postgres_fdw`
   * `pg_cron`
* Extension-specific functions:
   * `pg_stat_kcache_reset()` from the `pg_stat_kcache` extension.
   * `pg_stat_reset()` and `pg_stat_statements_reset()` from the `pg_stat_statements` extension.

## `mdb_monitor` role {#mdb-monitor}

The `mdb_monitor` role includes the following privileges:

* Reading and executing various views and functions for monitoring.
* Extensions:
   * `pg_stat_statements`
* Functions for working with ordinary files:
   * `pg_ls_logdir()`
   * `pg_ls_waldir()`
   * `pg_ls_archive_statusdir()`
   * `pg_ls_tmpdir ()`

## `mdb_replication` role {#mdb-replication}

The `mdb_replication` role includes the following privileges:

* Connecting to a cluster using the logical replication protocol (`replication=database`).
* Replication functions:
   * `pg_create_logical_replication_slot()`
   * `pg_drop_replication_slot()`
