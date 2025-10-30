---
title: Assigning {{ PG }} roles in {{ mpg-full-name }}
description: With {{ mpg-name }}, you cannot access predefined roles. Instead, this service provides special roles you can assign via the {{ yandex-cloud }} CLI or API.
---

# Assigning roles {{ PG }}

With {{ mpg-name }}, you cannot access [predefined roles](https://www.postgresql.org/docs/current/predefined-roles.html). Instead, this service provides the following special roles:
* `mdb_superuser`: For users who are not database owners but need to manage privileges as owners.
* `mdb_admin`: For users who are not database owners but need administrative privileges.
* `mdb_monitor`: For users who need to be able to read various configuration parameters, statistics, and other system information.
* `mdb_replication`: For users who need to be able to perform logical replication.

{% include [users-and-roles](../../_includes/mdb/mpg/users-and-roles.md) %}

To assign a role to a user, use the [{{ yandex-cloud }} interfaces](../operations/grant.md): roles assigned by a `GRANT` request are revoked with the next database operation.

{% note info %}

You cannot create custom roles in {{ mpg-name }}. User permissions depend on a set of privileges the user is granted.

{% endnote %}


## mdb_superuser {#mdb_superuser}

The `mdb_superuser` role enables you to manage privileges for objects in a database.

## mdb_admin {#mdb-admin}

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

## mdb_monitor {#mdb-monitor}

The `mdb_monitor` role includes the following privileges:

* Reading and executing various views and functions for monitoring.
* Extensions:
  * `pg_stat_statements`
* Functions for working with ordinary files:
  * `pg_ls_logdir()`
  * `pg_ls_waldir()`
  * `pg_ls_archive_statusdir()`
  * `pg_ls_tmpdir ()`

## mdb_replication {#mdb-replication}

The `mdb_replication` role includes the following privileges:

* Connecting to a cluster using the logical replication protocol (`replication=database`).
* Replication functions:
  * `pg_create_logical_replication_slot()`
  * `pg_drop_replication_slot()`
