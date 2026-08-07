---
title: Assigning {{ PG }} roles in {{ mpg-full-name }}
description: With {{ mpg-name }}, you cannot access predefined roles. Instead, this service provides special roles you can assign via the {{ yandex-cloud }} CLI or API.
---

# Assigning roles {{ PG }}

With {{ mpg-name }}, you cannot access [predefined roles](https://www.postgresql.org/docs/current/predefined-roles.html). Instead, this service provides the following special roles:

* [mdb_read_all_data](#mdb_read_all_data): Role that reads (`SELECT`) all data in the database.
* [mdb_write_all_data](#mdb_write_all_data): Role that can modify (`INSERT`, `UPDATE`, `DELETE`) all data in the database **but cannot perform the `SELECT` operations**.
* [mdb_superuser](#mdb_superuser): For users who are not database owners but have to be able to manage privileges same as owners.
* [mdb_admin](#mdb-admin): For users who are not database owners but need administrative privileges.
* [mdb_monitor](#mdb-monitor): For users who need to read various configuration settings, statistics, and other system information.
* [mdb_replication](#mdb-replication): For users who need to be able to perform logical replication.

{% include [users-and-roles](../../_includes/mdb/mpg/users-and-roles.md) %}

To assign a role to a user, use the [{{ yandex-cloud }} interfaces](../operations/grant.md): roles assigned by a `GRANT` request are revoked with the next database operation.

{% note info %}

You cannot create custom roles in {{ mpg-name }}. A user’s permissions are determined by the combination of granted privileges.

{% endnote %}

## mdb_read_all_data {#mdb_read_all_data}

The `mdb_read_all_data` role permits **only** to read all user data (DQL: `SELECT`) in the database in all schemas (except system folders).

{% note info %}

The `mdb_read_all_data` role is a more secure alternative to the standard {{ PG }} [pg_read_all_data](https://www.postgresql.org/docs/current/predefined-roles.html) role because it gives no access to system folders (`pg_catalog`). This prevents the possibility of reading confidential system information.

{% endnote %}

## mdb_write_all_data {#mdb_write_all_data}

The `mdb_write_all_data` role permits **only** to modify all user data (DML: `INSERT`, `UPDATE`, `DELETE`) in the database in all schemas (except system folders).

{% note info %}

The `mdb_write_all_data` role is a more secure alternative to the standard {{ PG }} [pg_write_all_data](https://www.postgresql.org/docs/current/predefined-roles.html) role because it gives no access to system folders (`pg_catalog`). This prevents the possibility of altering system configuration and metadata.

{% endnote %}

{% note warning %}

The `mdb_write_all_data` role permits only to modify data, **but does not include**:

* Permissions to read data (DQL: `SELECT`).
* Management of database structure and objects (DDL: `CREATE`, `DROP`, etc.).

For full access to data (**without DDL**, but with `SELECT`) you must also have the `mdb_read_all_data` role (automatically requested as a child IDM role along with `mdb_write_all_data`).

{% endnote %}

## mdb_superuser {#mdb_superuser}

The `mdb_superuser` role enables you to manage privileges for objects in a database.

## mdb_admin {#mdb-admin}

The `mdb_admin` role includes the following privileges:

* Predefined role privileges:
  * `pg_monitor`
  * `pg_signal_backend`
    Learn more about predefined roles in [this {{ PG }} guide](https://www.postgresql.org/docs/current/predefined-roles.html).
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
