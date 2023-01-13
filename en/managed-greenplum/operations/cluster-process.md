# Managing client processes

{{ GP }} launches a new internal process for each client connection. An administrator or any other user with the `mdb_admin` [role](../concepts/cluster-users.md) can cancel or terminate these client server processes using two functions:

* [mdb_toolkit.gp_cancel_backend()](#cancel-backend)
* [mdb_toolkit.gp_terminate_backend()](#terminate-backend)

## Getting a list of processes {#list}

To get a list of processes, query the `pg_stat_activity` view:

```sql
SELECT usename, pid, waiting, state, query, datname
FROM pg_stat_activity;
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

## Terminating a specific process {#cancel-backend}

To terminate a specific server process, use the function below:

```sql
mdb_toolkit.gp_cancel_backend(<process ID>,<message text>)
```

You can get the process ID with the [list of cluster processes](#list). Message text is optional and is sent to the client when the function is run.

## Closing a database connection {#terminate-backend}

To close the client database connection completely, use the function below:

```sql
mdb_toolkit.gp_terminate_backend(<process ID>,<message text>)
```

You can get the process ID with the [list of cluster processes](#list). Message text is optional and is sent to the client when the function is run.

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
