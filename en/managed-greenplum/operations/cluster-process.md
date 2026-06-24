---
title: How to manage client processes and user sessions in {{ mgp-full-name }}
description: 'Follow this guide to manage client processes and user sessions: get a list of processes, cancel a user session, terminate a process, close a database connection, and manage load.'
---

# Managing client processes and user sessions

{{ mgp-name }} launches a new internal process for each client connection. An administrator or any other user with the `mdb_admin` [role](../concepts/cluster-users.md#mdb_admin) can do the following:

* [Get a list of processes](#list).
* [Manage load](#load-management).
* [Cancel a user session](#cancel-sessions).

## Getting a list of processes {#list}

Requests for lists of processes are different for {{ GP }} and {{ CB }}. {{ GP }} uses the `waiting` field, while {{ CB }}, the `wait_event_type` and `wait_event` fields.

Learn more about [available database management systems in {{ mgp-name }}](../concepts/overview.md).

{% list tabs group=instructions %}

- {{ GP }} {#gp}

  To get a list of processes, including user requests, call the `mdb_toolkit.pg_stat_activity()` function:

  ```sql
  SELECT usename, pid, waiting, state, query, datname
  FROM mdb_toolkit.pg_stat_activity();
  ```

  Result:

  ```text
   usename |  pid     | waiting | state  |         query          | datname
  ---------+----------+---------+--------+------------------------+---------
    sammy  |   31861  |    f    | idle   | SELECT * FROM testtbl; | testdb
    billy  |   31905  |    t    | active | SELECT * FROM topten;  | testdb
  ```

  Where:

  * `usename`: Username.
  * `pid`: Process ID.
  * `waiting`: Process is awaiting a transaction:

    * `t`: Yes.
    * `f`: No.

  * `state`: Process state:

    * `active`: Running.
    * `idle`: Idle.

  * `query`: Query.
  * `datname`: Database name.

- {{ CB }} {#cb}

  To get a list of processes, including user requests, call the `mdb_toolkit.pg_stat_activity()` function:

  ```sql
  SELECT usename, pid, wait_event_type, wait_event, state, query, datname
  FROM mdb_toolkit.pg_stat_activity();
  ```

  Result:

  ```text
   usename |    pid   | wait_event_type | wait_event | state  |             query              | datname
  ---------+----------+-----------------+------------+--------+--------------------------------+---------
    user1  |  1798921 |     Timeout     |  PgSleep   | active | SELECT pg_sleep(25);           |  mydb
    user2  |  1798938 |     Lock        |  advisory  | active | SELECT pg_advisory_lock(1234); |  mydb
  ```

  Where:

  * `usename`: Username.
  * `pid`: Process ID.
  * `wait_event_type`: Event type awaited by the backend. If `NULL`, the backend is not awaiting any event.
  * `wait_event`: Event name awaited by the backend. If `NULL`, the backend is not awaiting any event.
  * `state`: Process state:

    * `active`: Running.
    * `idle`: Idle.

  * `query`: Query.
  * `datname`: Database name.

  For more information about the `pg_stat_activity` view fields, see [this {{ CB }} guide](https://cloudberry.apache.org/docs/sys-catalogs/sys-views/gp-stat-activity).

{% endlist %}

## Load management {#load-management}

1. Run a query to the `gp_toolkit.gp_resgroup_config` file to get the resource group name and find out the current number of concurrent transactions:

    ```sql
    SELECT groupname, concurrency
    FROM gp_toolkit.gp_resgroup_config;
    ```

1. Set the number of concurrent transactions for a [resource group](../../managed-greenplum/concepts/resource-groups.md):

    ```sql
    ALTER RESOURCE GROUP <resource_group_name>
    SET concurrency <number_of_concurrent_transactions>;
    ```

## Canceling a user session {#cancel-sessions}

You can terminate a user session using one of the following methods:

1. [Terminate the process containing the session](#cancel-backend).
1. [Close the database connection](#terminate-backend).
1. [Terminate all user sessions](#terminate-all-user-backends).

### Terminating a process {#cancel-backend}

Call the `mdb_toolkit.gp_cancel_backend()` function:

```sql
SELECT *
FROM mdb_toolkit.gp_cancel_backend(<process_ID>);
```

You can get the process ID with the [list of cluster processes](#list).

### Closing a database connection {#terminate-backend}

Call the `mdb_toolkit.gp_terminate_backend()` function:

```sql
SELECT *
FROM mdb_toolkit.gp_terminate_backend(<process_ID>);
```

You can get the process ID with the [list of cluster processes](#list).

### Terminating all user sessions {#terminate-all-user-backends}

To terminate all user sessions in the cluster, call the `mdb_toolkit.terminate_all_user_backends()` function:

```sql
SELECT *
FROM mdb_toolkit.terminate_all_user_backends();
```

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}

{% include [cloudberry-trademark](../../_includes/mdb/mgp/trademark-cloudberry.md) %}