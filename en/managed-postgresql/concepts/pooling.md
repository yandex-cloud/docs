# Managing {{ PG }} connections

{{ PG }} [allocates a separate process](https://www.postgresql.org/docs/current/connect-estab.html) for each established connection. With numerous client connections, it creates multiple processes and manages distributed data structures. This may cause a lack of computing resources affecting the DBMS performance.

To address the lack of resources issue, a connection pooler is added before the {{ PG }} cluster. The pooler manages connections to allow large numbers of clients to connect to the DBMS without degrading performance. A relatively small number of re-usable connections are maintained between the connection pooler and the DBMS. After the client is disconnected, the connection is returned to the pool and can be reused by the same or a new client.

This deployment scenario complicates the administration, as the servers hosting the connection pooler are added to the DBMS infrastructure.

The {{ mpg-name }} architecture has a built-in connection pooler: [Odyssey](https://yandex.ru/dev/odyssey/) by Yandex.

Odyssey supports three modes of connection management:


* Session mode (default):


    In this mode, the client connection is established at the first query to the database and maintained until the client terminates the session. This connection can then be used by that or any other client. This approach is handy when establishing multiple client connections to the DBMS (for example, when starting applications that access databases). 

    This mode is supported by all [{{ PG }} clients](supported-clients.md), but less productive than transaction mode.


* Transaction mode:


    In this mode, the client connection is established at the first query to the database and maintained until the transaction ends. This connection can then be used by that or any other client. This approach allows maintaining few server connections between the connection pooler and {{ PG }} hosts when there are many client connections.

    The transaction mode provides high performance and allows you to load the DBMS as efficiently as possible. However, this mode is not supported by certain {{ PG }} clients and does not allow using:

    * [Temporary tables](https://www.postgresql.org/docs/current/sql-createtable.html), [cursors](https://www.postgresql.org/docs/current/plpgsql-cursors.html), and [advisory locks](https://www.postgresql.org/docs/current/explicit-locking.html#ADVISORY-LOCKS) that exist beyond a single transaction.

    * [Prepared statements](https://www.postgresql.org/docs/current/sql-prepare.html).

    {% note info %}

    To create a prepared statement in {{ mpg-name }}, use the DBMS driver feature. Creating a prepared statement using the `PREPARE` SQL query is not supported.

    {% endnote %}

* Query mode:

    In this mode, the client connection is only supported when making a query to the database. This connection can then be used by that or any other client. Only one query can be executed at a time. Transactions with multiple queries are prohibited and attempts to execute them fail.

    This approach pays off if the `AUTOCOMMIT` mode is enabled for client sessions, where each transaction is already limited to a single query. However, not all {{ PG }} clients support query mode, and when both `AUTOCOMMIT` and the `synchronous_commit = remote_apply` setting are enabled at the same time, the cluster's performance is greatly reduced.

You can [change](../operations/update.md#change-pooler-config) the connection pooler mode after the cluster is created.

{% note info %}

TTL of the longest active session/transaction is set in the cluster-level [Session duration timeout](./settings-list.md#setting-session-duration-timeout) DB setting.

{% endnote %}

## Odyssey features {#features}

Integrating {{ mpg-name }} with the Odyssey connection pooler has several advantages, e.g., if compared to the [PgBouncer](https://www.pgbouncer.org/) connection pooler:

| Comparison criterion | Odyssey | PgBouncer |
|------------------------|---------|-----------|
| Resource usage | {{ mpg-name }} clusters are less prone to running out of computing resources with multiple client connections. This is because of asynchronous multithreading built into the Odyssey architecture. This is especially important if most client connections to the DBMS use SSL/TLS. | PgBouncer uses a single-threaded architecture. This may lead to problems with resource consumption and scalability under high load. |
| Supporting client connections | Odyssey strives to keep the client connection alive as long as possible after the transaction ends in order to re-use it if this client returns with a new transaction. | PgBouncer seeks to return such kind of connection to the pool as quickly as possible. |
| Handling errors | {{ mpg-name }} clusters provide improved error handling capabilities, thus ensuring that errors on the {{ GP }} side are sent to the client application without any changes. | PgBouncer hides {{ GP }} error messages. As a result, all errors look like a PgBouncer connection error to the client. |

In addition, thanks to its integrated with Odyssey, a {{ mpg-name }} cluster:

* Supports numerous client connections without affecting the DBMS performance.
* Requires no extra connection pooler configuration effort or additional infrastructure for it to operate.
* Allows limiting the number of connections both globally (at the cluster level) and [at the individual user level](../operations/cluster-users.md#update-settings).
* Supports advanced transaction pooling, i.e., automatic operation cancellation and transaction rollback if the client connection breaks.
* Provides detailed logging of all events. Each client connection also gets a unique ID, which helps track the entire process of establishing a connection.

    {% note tip %}

    If you have issues connecting to a {{ mpg-name }} cluster, contact support. To have your issue resolved faster, provide the full text of the error message, including the connection ID.

    {% endnote %}

* Support [logical replication streams](https://www.postgresql.org/docs/current/logical-replication.html) passing through the connection pooler.

    To view examples of logical replication, see [Logical replication](../tutorials/replication-overview.md).

In addition, {{ mpg-name }} automatically ensures fault tolerance of the connection pooler in multi-host clusters.
