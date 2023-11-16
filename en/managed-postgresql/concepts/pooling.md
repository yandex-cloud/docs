# Managing connections

{{ PG }} [allocates a separate process](https://www.postgresql.org/docs/current/connect-estab.html) for each established connection. With numerous client connections, it creates multiple processes and manages distributed data structures. As a result, there may be insufficient computing resources, which affects the DBMS performance.

To resolve the insufficient resources issue, connection poolers, e.g., [PgPool-II](https://www.pgpool.net) or [PgBouncer](https://www.pgbouncer.org/), are often added before a {{ PG }} cluster. The connection poolers manage connections to allow a large number of clients to connect to the DBMS without affecting performance. A relatively small number of re-usable connections are maintained between the connection pooler and the DBMS. After the client is disconnected, the connection is returned to the pool and can be reused by the same or a new client.

This deployment scenario complicates the administration, as the servers hosting the connection pooler are added to the DBMS infrastructure.

The {{ mpg-name }} architecture has a built-in connection pooler: [Odyssey](https://yandex.ru/dev/odyssey/) by Yandex.

Odyssey supports three modes of connection management:

* Session mode (default):


    In this mode, the client connection is established at the first query to the database and maintained until the client terminates the session. This connection can then be used by that or any other client. This approach is handy when establishing multiple client connections to the DBMS (for example, when starting applications that access databases).

    This mode is supported by all [{{ PG }} clients](supported-clients.md), but it is less efficient than the transaction mode.

* Transaction mode:


   In this mode, the client connection is established at the first query to the database and maintained until the transaction ends. This connection can then be used by that or any other client. This approach helps maintain a few server connections between the connection pooler and {{ PG }} hosts when there are many client connections.

   The transaction mode provides high performance and allows you to load the DBMS as efficiently as possible. However, this mode is not supported by certain {{ PG }} clients and does not allow using:

   * [Temporary tables](https://www.postgresql.org/docs/current/sql-createtable.html), [cursors](https://www.postgresql.org/docs/current/plpgsql-cursors.html), and [advisory locks](https://www.postgresql.org/docs/current/explicit-locking.html#ADVISORY-LOCKS) that exist beyond a single transaction.
   * [Prepared statements](https://www.postgresql.org/docs/current/sql-prepare.html).

   {% note info %}

   To create a prepared statement in {{ mpg-name }}, use the DBMS driver feature. Creating prepared statements with `PREPARE` SQL queries is not supported.

   {% endnote %}

* Query mode:

   In this mode, the client connection is only supported when making a query to the database. This connection can then be used by that or any other client. A single query is executed at a time. Transactions with multiple queries are prohibited and any attempts to execute them fail.

   This approach is helpful when the `AUTOCOMMIT` mode is enabled for client sessions and each transaction is already limited to a single query. However, not every {{ PG }} client supports query mode, and when both the `AUTOCOMMIT` mode and the `synchronous_commit = remote_apply` setting are enabled for a cluster simultaneously, this significantly degrades its performance.

You can [change](../operations/update.md#change-pooler-config) the connection pooler mode after the cluster is created.

{% note info %}

TTL of the longest active session/transaction is set in the cluster-level [Session duration timeout](./settings-list.md#setting-session-duration-timeout) DB setting.

{% endnote %}

When integrated with Odyssey, {{ mpg-name }} clusters:

* Support numerous client connections without affecting the DBMS performance.
* Require neither additional connection pooler configuration nor additional infrastructure for it to operate.
* Are less prone to running out of computing resources with multiple client connections. This is because of asynchronous multithreading built into the Odyssey architecture. This is especially important if most client connections to the DBMS use SSL/TLS.

   For example, PgBouncer uses a single-threaded architecture. This may lead to problems with resource consumption and scalability under high load.

* Allow limiting the number of connections both globally (at the cluster level) and [at the level of individual users](../operations/cluster-users.md#update-settings).
* Support advanced transaction pooling, i.e., automatic operation cancel and transaction rollback when the client connection is broken.

   In addition, Odyssey strives to keep the client connection alive as long as possible after the transaction ends in order to re-use it if this client returns with a new transaction. Unlike Odyssey, PgBouncer, another widely used connection pooler, seeks to return this kind of connection to the pool as quickly as possible.

* Provide improved logging and error handling capabilities:

   * Errors on the {{ PG }} side are sent to the client application without changes.

      For example, PgBouncer hides {{ PG }} error messages: for the client, all errors look like an error when connecting to PgBouncer.

   * Odyssey can log all events in detail. Each client connection is also assigned a unique ID, which helps track the entire process of establishing a connection.

   {% note tip %}

   If you have issues while connecting to a {{ mpg-name }} cluster, contact support. To have your issue resolved faster, provide the full text of the error message, including the connection ID.

   {% endnote %}

* Support [logical replication streams](https://www.postgresql.org/docs/current/logical-replication.html) passing through the connection pooler.

   To view examples of logical replication, see [{#T}](../tutorials/replication-overview.md).

In addition, {{ mpg-name }} automatically ensures fault tolerance of the connection pooler in multi-host clusters.
