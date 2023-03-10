# Managing connections

{{ GP }} allocates a separate process for each established connection. With numerous client connections, the DBMS creates multiple processes and manages distributed data structures. As a result, there may be insufficient computing resources, which affects DBMS performance.

To resolve the insufficient resources issue, the [PgBouncer connection pooler](https://docs.vmware.com/en/VMware-Tanzu-Greenplum/6/greenplum-database/GUID-admin_guide-access_db-topics-pgbouncer.html) is added before a {{ GP }} cluster. The pooler manages connections to allow a large number of clients to connect to the DBMS without affecting performance. A relatively small number of connections are maintained between the pooler and the DBMS and can be reused. After the client is disconnected, the connection is returned to the pool and can be reused by the same or a new client.

This deployment method complicates the administration because the servers hosting the pooler are added to the DBMS infrastructure.


The {{ mgp-name }} architecture has a built-in connection pooler: [Odyssey by Yandex](https://yandex.ru/dev/odyssey/).


Odyssey supports two modes of connection management:

* Session (default):


    In this mode, the client connection is established at the first query to the database and maintained until the client terminates the session. This connection can then be used by another or the same client. This approach helps wait out the moment of establishing multiple client connections to the DBMS, e.g., when starting applications that access databases.

    This mode is less productive than transaction mode.

* Transaction:


   In this mode, the client connection is established at the first query to the database and maintained until the transaction ends. This connection can then be used by another or the same client. This approach helps maintain a few server connections between the pooler and {{ GP }} hosts when there are multiple client connections.

   Transaction mode provides high performance and allows the DBMS to load as efficiently as possible. However, this mode is not supported by all {{ GP }} clients and does not allow using:

   * [Temporary tables](https://docs.vmware.com/en/VMware-Tanzu-Greenplum/6/greenplum-database/GUID-ref_guide-sql_commands-CREATE_TABLE_AS.html), [cursors](https://docs.vmware.com/en/VMware-Tanzu-Greenplum/6/greenplum-database/GUID-ref_guide-sql_commands-DECLARE.html), and [advisory locks](https://docs.vmware.com/en/VMware-Tanzu-Greenplum/6/greenplum-database/GUID-ref_guide-system_catalogs-pg_locks.html) that exist beyond a single transaction.
   * [Prepared statements](https://docs.vmware.com/en/VMware-Tanzu-Greenplum/6/greenplum-database/GUID-ref_guide-sql_commands-PREPARE.html).

   {% note info %}

   To create a prepared statement in {{ mgp-name }}, use the DBMS driver features. Creating prepared statements with a `PREPARE` SQL query is not supported.

   {% endnote %}

Pooler mode can be [changed](../operations/update.md#change-additional-settings) after the cluster is created.

When integrated with Odyssey, {{ mgp-name }} clusters:

* Support numerous client connections without affecting DBMS performance.
* Require no additional configuration of the connection pooler or additional infrastructure for its operation.
* Are less prone to running out of computing resources because of multiple client connections thanks to asynchronous multithreading built into the Odyssey architecture. This is especially important if most client connections to the DBMS use SSL/TLS.

   For example, PgBouncer uses a single-threaded architecture. This may lead to problems with resource consumption and scalability under high load.

* Allow you to limit the number of concurrent cluster connections.
* Support advanced transaction pooling, such as automatic operation cancel and transaction rollback when a client connection is broken.

   In addition, Odyssey strives to keep the client connection alive as long as possible after the transaction ends in order to re-use it if this client returns with a new transaction. Unlike Odyssey, PgBouncer seeks to return such kind of connection to the pool as quickly as possible.

* Provide improved logging and error handling capabilities:

   * Errors on the {{ GP }} side are sent to the client application without changes.

      For example, PgBouncer hides {{ GP }} error messages: for the client, all errors look like an error connecting to PgBouncer.

   * Odyssey can log all events in detail. Each client connection is also assigned a unique ID, which helps track the entire process of establishing a connection.

   {% note tip %}

   If you have issues while connecting to a {{ mgp-name }} cluster, [contact support](../../support/overview.md). To have your issue resolved faster, provide the full text of the error message, including the connection ID.

   {% endnote %}

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
