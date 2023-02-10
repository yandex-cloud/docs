# Managing connections

{{ PG }} [allocates a separate process](https://www.postgresql.org/docs/current/connect-estab.html) for each established connection. With numerous client connections, the DBMS creates multiple processes and manages distributed data structures. As a result, there may be insufficient computing resources, which affects DBMS performance.

To solve the problem of insufficient resources, connection poolers (such as [PgPool-II](https://www.pgpool.net) or [PgBouncer](https://www.pgbouncer.org/)) are often added before a {{ PG }} cluster. The poolers manage connections to allow a large number of clients to connect to the DBMS without affecting performance. A relatively small number of connections are maintained between the pooler and the DBMS and can be reused. After the client is disconnected, the connection is returned to the pool and can be reused by the same or a new client.

This deployment method makes administration more difficult because servers hosting the pooler are added to the DBMS infrastructure.

The {{ mpg-name }} architecture has a built-in connection pooler: [Odyssey](https://yandex.ru/dev/odyssey/) by Yandex.

Odyssey supports three modes of connection management:

* Session (default):


In this mode, the client connection is established at the first query to the database and maintained until the client terminates the session. This connection can then be used by another or the same client. This approach helps wait out the moment of establishing multiple client connections to the DBMS (for example, when starting applications that access databases).

This mode is supported by all [{{ PG }} clients](supported-clients.md), but it is less efficient than transaction mode.

* Transaction:


   In this mode, the client connection is established at the first query to the database and maintained until the transaction ends. This connection can then be used by another or the same client. This approach helps maintain a few server connections between the pooler and {{ PG }} hosts when there are multiple client connections.

   Transaction mode provides high performance and allows the DBMS to load as efficiently as possible. However, this mode is not supported by all {{ PG }} clients and doesn't allow using:

   * [Temporary tables](https://www.postgresql.org/docs/current/sql-createtable.html), [cursors](https://www.postgresql.org/docs/current/plpgsql-cursors.html), and [advisory locks](https://www.postgresql.org/docs/current/explicit-locking.html#ADVISORY-LOCKS) that exist beyond a single transaction.
   * [Prepared statements](https://www.postgresql.org/docs/current/sql-prepare.html).

   {% note info %}

   Prepared statements in {{ mpg-name }} are created using the DBMS driver functionality. You can't create a prepared statement with a `PREPARE` SQL query.

   {% endnote %}

* Query mode:

   In this mode, the client connection is only supported when making a query to the database. This connection can then be used by another or the same client. A single query is executed at a time. Transactions with multiple queries are prohibited and attempts to execute them fail.

   This approach is helpful when `AUTOCOMMIT` mode is enabled for client sessions and each transaction is already limited to a single query. However, not every {{ PG }} client supports query mode, and when both `AUTOCOMMIT` mode and the `synchronous_commit = remote_apply` setting are enabled for a cluster simultaneously, this significantly degrades its performance.

Pooler mode can be [changed](../operations/update.md#change-pooler-config) after the cluster is created.

{% note warning %}

{{ mpg-name }} clusters have a connection time-to-live quota of 12 hours. To have it increased, please contact [technical support](../../support/overview.md).

{% endnote %}

Integrated with Odyssey, {{ mpg-name }} clusters:

* Support numerous client connections without affecting DBMS performance.
* Require no additional configuration of the connection pooler or additional infrastructure for its operation.
* Are less prone to running out of computing resources because of multiple client connections thanks to asynchronous multithreading built into the Odyssey architecture. This is especially important if most client connections to the DBMS use SSL/TLS.

   For example, PgBouncer uses a single-threaded architecture. This may lead to problems with resource consumption and scalability under high load.

* Allows limiting the number of connections both globally at the cluster level and [at the level of individual users](../operations/cluster-users.md#update-settings).
* Support advanced transaction pooling: automatic operation cancel and transaction rollback when the client connection is broken.

   In addition, Odyssey strives to keep the client connection alive as long as possible after the transaction ends in order to re-use it if this client returns with a new transaction. Unlike Odyssey, PgBouncer, another popular pooler, seeks to return this kind of connection to the pool as quickly as possible.

* Provide improved logging and error handling capabilities:

   * Errors on the {{ PG }} side are passed to the client application without changes.

      For example, PgBouncer hides {{ PG }} error messages: for the client, all errors look like an error connecting to PgBouncer.

   * Odyssey can log all events in detail. Each client connection is also assigned a unique ID, which helps track the entire process of establishing a connection.

   {% note tip %}

   If you have problems connecting to a {{ mpg-name }} cluster, contact support. For faster solutions to your problem, provide the full text of the error message, including the connection ID.

   {% endnote %}

* Enable passing of [logical replication streams](https://www.postgresql.org/docs/current/logical-replication.html) via a pooler.

   See [{#T}](../tutorials/replication-overview.md) for examples of logical replication.

In addition, {{ mpg-name }} automatically ensures fault tolerance of the connection pooler in clusters with multiple hosts.
