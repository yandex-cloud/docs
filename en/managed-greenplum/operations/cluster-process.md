# Managing client processes and user sessions

{{ GP }} launches a new internal process for each client connection. An administrator or any other user with the `mdb_admin` [role](../concepts/cluster-users.md) can:

* [{#T}](#list).
* [{#T}](#cancel-sessions).
* [{#T}](#cancel-backend).
* [{#T}](#terminate-backend).
* [{#T}](#load-management).

## Getting a list of processes {#list}

Run a query to the `mdb_toolkit.pg_stat_activity()` function. The resulting list of processes will include user queries:

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
* `waiting`: Process waiting for a transaction:

   * `t`: Yes.
   * `f`: No.

* `state`: Process state:

   * `active`: Running.
   * `idle`: Idle.

* `query`: Query.
* `datname`: Database name.

## Canceling a user session {#cancel-sessions}

1. [Terminate the session process](#cancel-backend).
1. [Terminate the DB connection](#terminate-backend).

## Terminating a specific process {#cancel-backend}

Run a query to the `mdb_toolkit.gp_cancel_backend()` function:

```sql
SELECT *
FROM mdb_toolkit.gp_cancel_backend(<process ID>,<message text>);
```

You can get the process ID with the [list of cluster processes](#list). Message text is optional and is sent to the client when the function is run.

## Closing a database connection {#terminate-backend}

Run a query to the `mdb_toolkit.gp_terminate_backend()` function:

```sql
SELECT *
FROM mdb_toolkit.gp_terminate_backend(<process ID>,<message text>);
```

You can get the process ID with the [list of cluster processes](#list). Message text is optional and is sent to the client when the function is run.

## Load management {#load-management}

1. Run a query to the `gp_toolkit.gp_resgroup_config` file to get the resource group name and find out the current number of concurrent transactions:

   ```sql
   SELECT groupname, concurrency
   FROM gp_toolkit.gp_resgroup_config;
   ```

1. Set the number of concurrent transactions for a [resource group](../../managed-greenplum/concepts/resource-groups.md):

   ```sql
   ALTER RESOURCE GROUP <resource group name>
   SET concurrency <number of concurrent transactions>;
   ```

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
