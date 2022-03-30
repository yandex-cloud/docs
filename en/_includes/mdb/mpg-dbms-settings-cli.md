You can use the following settings:

- **`--conn-limit`**: The maximum number of connections per user.

  In session pooling, this setting limits the number of user connections to each host in a {{ PG }} cluster.
  When using this type of pooling, make sure the setting value is not less than the sum of all connections that can be opened by the service backends using {{ PG }}. Note that each open server connection slows {{ PG }} down a little for the OLTP (Online Transaction Processing) workload.

  In transaction pooling, this setting limits the number of simultaneous user connections per transaction. When using this type of pooling, the user can open thousands of connections, but only `N` connections can run concurrently (where `N` is the setting value).

  Everything described below is true for session pooling:
  - When adding a user, {{ mpg-name }} reserves 50 connections per host in a {{ PG }} cluster by default. The minimum number of connections per user is 10.
  - The total number of connections reserved for users must not exceed the `max_connections` parameter value that was specified [when creating the cluster](../../managed-postgresql/operations/cluster-create.md). Keep in mind that {{ mpg-name }} reserves 15 connections for service users per {{ PG }} host. For example, if the cluster has the setting `"max_connections": 100`, you can reserve a maximum of 85 connections per cluster host for users.
  - We recommend distributing different services that use {{ PG }} among different users and setting the desired value for each user.
  This way, if problems occur in a certain service when a large number of connections start being created, it won't affect other services and they will be able to create connections to {{ PG }}.

- **`--default-transaction-isolation`**: The isolation level is set for each transaction in SQL. This setting determines the default isolation level to set for new SQL transactions.

  Acceptable values:

  - `transaction-isolation-read-committed` (by default): A query only sees the strings that were committed before it is run.

  - `transaction-isolation-read-uncommitted`: The behavior of this isolation level in {{ PG }} is identical to that of `transaction-isolation-read-committed`.

  - `transaction-isolation-repeatable-read`: All queries in the current transaction only see those strings that were committed before the first query to select or update data executed in this transaction.

  - `transaction-isolation-serializable`: The strictest isolation level of all those mentioned.

    All queries in the current transaction only see the strings that were committed before the first query to select and update data that was executed in this transaction. If the overlap of read and write operations of parallel serializable transactions can lead to a situation that is impossible when executed sequentially, one of the transactions is rolled back with the "serialization failure" error.

  For more information about isolation levels, see the [documentation for {{ PG }}](https://www.postgresql.org/docs/current/transaction-iso.html).

- **`--login`**: Enables/disables user login to a {{ PG }} cluster.

  Default: `true` (the user is allowed to log in to the cluster).

- **`--lock-timeout`**: The maximum waiting time (in milliseconds) for any statement to get a lock on a table, index, row, or other DB object. If the timeout expires, the statement is aborted.

  The minimum and default value is `0` (time monitoring is disabled and there is no lock timeout).

- **`--log-statement`**: A filter for SQL statements to be logged for the specified user:
  - `log-statement-none` (default): The filter is disabled and SQL statements aren't logged.
  - `log-statement-ddl`: SQL statements that let you change data definitions are logged (such as `CREATE`, `ALTER`, and `DROP`).
  - `log-statement-mod`: SQL statements that fall under the `log-statement-ddl` filter and statements that let you change data (such as `INSERT` and `UPDATE`) are logged.
  - `log-statement-all`: All SQL statements are logged.

  For more information, see the [documentation for {{ PG }}](https://www.postgresql.org/docs/current/runtime-config-logging.html).

- **`--log-min-duration-statement`**: Configures logging of SQL statement duration.

  Logs the execution duration of all statements whose processing time is equal to or greater than the number of milliseconds specified in the setting value. For example, if this setting's value is `500`, a statement that took 300 milliseconds to complete isn't logged, while the one that took 2000 milliseconds to complete is logged.

  If `0`, the duration of all statements is logged.

  The default value is `-1`. It disables statement duration logging.

  We recommend determining what is considered slow query execution for each service and its corresponding user and setting the appropriate value to log "heavy" queries from the service. For example, for a web service, a query is considered slow if it runs for more than one second, while for the reporting service, a query that runs for more than 10 minutes is slow.

  For more information, see the [documentation for {{ PG }}](https://www.postgresql.org/docs/current/runtime-config-logging.html).

- **`--synchronous-commit`**: This setting determines whether the DBMS will perform a transaction commit synchronously.

  Synchronous execution means that a cluster will wait for synchronous operations that guarantee different levels of data persistence and visibility in the cluster before committing the transaction to the client.

  Acceptable values:
  - `synchronous-commit-off`: A transaction is committed even if its data is not yet in the WAL (Write Ahead Log). There is no synchronous write, and transaction data may be lost as a result of a disk subsystem failure.
  - `synchronous-commit-on` (default): A transaction is committed if the WAL is written to the master disk and synchronous replica disk.
  - `synchronous-commit-local`: A transaction is committed if the WAL is written to the master disk.
  - `synchronous-commit-remote-apply`: A transaction is committed if the WAL is written to the master disk, and the synchronous replica accepted the WAL and applied the changes from it.
  - `synchronous-commit-remote-write`: A transaction is committed if the WAL is written to the master disk, and the synchronous replica accepted the WAL and passed it to the OS for writing to the disk. If the master disk system is lost and the OS on the replica fails, transaction data with this level of synchronization may be lost.

  For more information, see the [documentation for {{ PG }}](https://www.postgresql.org/docs/current/runtime-config-wal.html#GUC-SYNCHRONOUS-COMMIT).

- **`--temp-file-limit`**: The maximum amount of disk space (KB) that a single process can use for temporary files. A transaction that tries to exceed this limit will be canceled.

  Large queries, due to their size, are executed in the disk space rather than in RAM. Queries that are too large can overload the disk and prevent other quieres from being executed. This setting prevents queries that can greatly affect performance by limiting the size of temporary files.

  The default value is `-1` (no limitations).

  For more information, see the [documentation for {{ PG }}](https://www.postgresql.org/docs/current/runtime-config-resource.html).

