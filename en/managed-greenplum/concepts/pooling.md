# Managing {{ GP }} connections

{{ GP }} allocates a separate process for each established connection. With numerous client connections, it creates multiple processes and manages distributed data structures. This may cause a lack of computing resources affecting the DBMS performance.

To address the lack of resources issue, a connection pooler is added before the {{ GP }} cluster. That pooler manages connections to allow a large number of clients to connect to the DBMS without affecting performance. A relatively small number of re-usable connections are maintained between the connection pooler and the DBMS. After the client is disconnected, the connection is returned to the pool and can be reused by the same or a new client.

This deployment method complicates the administration because the servers hosting the connection pooler are added to the DBMS infrastructure.

The {{ mgp-name }} architecture has a built-in connection pooler: [Odyssey](https://yandex.ru/dev/odyssey/) by Yandex.

Odyssey supports two modes of connection management:

* Session mode:

    In this mode, the client connection is established at the first query to the database and maintained until the client terminates the session. This connection can then be used by that or any other client. This approach allows you to efficiently process multiple repeat client connections to the DBMS (for example, when starting applications that access databases). 
    
    This mode is less productive than transaction mode.

* Transaction mode (default):

    In this mode, the client connection is established at the first query to the database and maintained until the transaction ends. This connection can then be used by that or any other client. This approach allows maintaining few server connections between the connection pooler and {{ GP }} hosts when there are many client connections.

    The transaction mode provides high performance and allows you to load the DBMS as efficiently as possible. However, this mode is not supported by certain {{ GP }} clients and does not allow using:

    * [Temporary tables]({{ gp.docs.broadcom }}/7/greenplum-database/ref_guide-sql_commands-CREATE_TABLE_AS.html), [cursors]({{ gp.docs.broadcom }}/7/greenplum-database/ref_guide-sql_commands-DECLARE.html), and [advisory locks]({{ gp.docs.broadcom }}/7/greenplum-database/ref_guide-system_catalogs-pg_locks.html) that exist beyond a single transaction.
    * [Prepared statements]({{ gp.docs.broadcom }}/7/greenplum-database/ref_guide-sql_commands-PREPARE.html).

    {% note info %}

    To create a prepared statement in {{ mgp-name }}, use the DBMS driver features. Creating a prepared statement using the `PREPARE` SQL query is not supported.

    {% endnote %}

You can [change](../operations/update.md#change-additional-settings) the connection pooler mode after the cluster is created.

## Odyssey features {#features}

Integrating {{ mgp-name }} with the Odyssey connection pooler has several advantages, e.g., compared to the [PgBouncer]({{ gp.docs.broadcom }}/7/greenplum-database/admin_guide-access_db-topics-pgbouncer.html) connection pooler:

| Comparison criterion | Odyssey | PgBouncer |
|------------------------|---------|-----------|
| Resource usage | {{ mgp-name }} clusters are less prone to running out of computing resources with multiple client connections. This is because of asynchronous multithreading built into the Odyssey architecture. This is especially important if most client connections to the DBMS use SSL/TLS. | PgBouncer uses a single-threaded architecture. This may lead to problems with resource consumption and scalability under high load. |
| Supporting client connections | Odyssey strives to keep the client connection alive as long as possible after the transaction ends in order to re-use it if this client returns with a new transaction. | PgBouncer seeks to return such kind of connection to the pool as quickly as possible. |
| Handling errors | {{ mgp-name }} clusters provide improved error handling capabilities, thus ensuring that errors on the {{ GP }} side are sent to the client application without changes. | PgBouncer hides {{ GP }} error messages. As a result, all errors look like a PgBouncer connection error to the client. |

In addition, thanks to its integration with Odyssey, a {{ mgp-name }} cluster:

* Supports numerous client connections without affecting the DBMS performance.
* Requires no extra connection pooler configuration effort or additional infrastructure for it to operate.
* Allow you to limit the number of concurrent cluster connections.
* Support advanced transaction pooling, such as automatic operation cancel and transaction rollback when a client connection is broken.
* Provides detailed logging of all events that occur. Each client connection also gets a unique ID, which helps track the entire process of establishing a connection.

    {% note tip %}

    If you have issues connecting to a {{ mgp-name }} cluster, [contact support](../../support/overview.md). To have your issue resolved faster, provide the full text of the error message, including the connection ID.

    {% endnote %}

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
