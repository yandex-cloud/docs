# Replication

In {{ mpg-name }} clusters, synchronous replication is used: the result of a data write request is reflected both on the master host and priority replica. Data is duplicated asynchronously to the other cluster replicas.

The master and synchronous replica are selected according to the priority that you can [set for a specific host](../operations/hosts.md#update). In addition, you can configure cascading replication by assigning a source of replication for each host.

For more information about how replication is done in {{ PG }}, see the [DBMS documentation](https://www.postgresql.org/docs/current/static/warm-standby.html).

