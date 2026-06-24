#### How do I connect to a router? {#how-to-connect-to-router}

You can connect to a router in a {{ mspqr-name }} cluster over {{ PG }}. Do it by running this command:

```bash
psql "host=<host_FQDN> \
      port={{ port-mpg }} \
      sslmode=verify-full \
      dbname=<DB_name> \
      user=<username> \
      target_session_attrs=read-write"
```

Where `target_session_attrs` defines the type of request to the host. For example, `read-write` enables both reading and writing. For more information, see [this SPQR guide](https://docs.pg-sharding.tech/routing/hints#__spqr__target_session_attrs).

After runing this command, enter the user password to complete your connection.

#### How do I connect to the {{ SPQR }} administrator console? {#how-to-connect-to-admin-console}

Use port `6432`, the `spqr-console` user, and the `spqr-console` database. Here is an example:

```bash
psql "host=<router_FQDN> port=6432 user=spqr-console dbname=spqr-console sslmode=verify-full"
```

#### What are the session and transaction modes? {#session-vs-transaction-modes}

In the session mode, the client connection is established upon the initial database query and maintained until the client terminates the session. This connection can then be used by that or any other client. This approach effectively handles large volumes of client connections to the DBMS, e.g., during application startup, but it is less performant than the transaction mode.

In the transaction mode, the client connection is established upon the initial database query and maintained until the transaction ends. This connection can then be used by that or any other client. This approach allows maintaining few server connections between the connection pooler and {{ PG }} hosts when there are many client connections.

The transaction mode provides high performance and optimizes DBMS resource usage, but it has no support for the following features:

* [Temporary tables](https://www.postgresql.org/docs/current/sql-createtable.html), [cursors](https://www.postgresql.org/docs/current/plpgsql-cursors.html), and [advisory locks](https://www.postgresql.org/docs/current/explicit-locking.html#ADVISORY-LOCKS) that persist beyond a single transaction.

* [Prepared statements](https://www.postgresql.org/docs/current/sql-prepare.html).

To configure this mode, use the `pool_mode` parameter in the router configuration. The transaction mode is enabled by default.

#### How do I get the statistics and statuses of connections? {#connections-monitoring}
The router provides an administrative console over the {{ PG }} protocol. You can use the console to run the `SHOW` commands to get statistics, for example:

* `SHOW clients WHERE dbname = <database_name>;`: Displays a list of clients, route, router address, and connection state.
* `SHOW shards`: Outputs a list of shards.
* `SHOW backend_connections`: Outputs a list of connections to shard hosts.

#### How do I set up an app connection to {{ SPQR }}? {#how-to-connect-app-to-spqr}

To connect from applications, use the standard {{ PG }} drivers, e.g., pgx. Specify all cluster routers in the configuration. Make sure the cluster security groups allow connections to the cluster.

For complex queries, e.g., with CTEs, use the `/* __spqr__engine_v2: true */` virtual parameter. You can set virtual parameters with comments in SQL or via `SET`. For more information on virtual parameters, see [this SPQR guide](https://docs.pg-sharding.tech/routing/hints#__spqr__target_session_attrs).

#### What options are there to manage connection routing? {#connection-routing-management}

You can only manage the type of query to a host. To do this, use the `/*__spqr__target_session_attrs */` virtual parameter or the `target_session_attrs` parameter to specify the query type: `read-write`, `smart-read-write`, `read-only`, `prefer-standby`, or `any`. 

The query type affects the cluster's behavior when processing the query. For example, `read-only` allows connections to replicas only, while `prefer-standby` selects a replica but switches to the master if no replicas are available. This is useful in environments with multiple servers and automatic master failover. For more about the request types, see [this SPQR guide](https://docs.pg-sharding.tech/routing/hints#__spqr__target_session_attrs).

You can set virtual parameters with comments in SQL or via `SET`.

