# Logical PostgreSQL replication

{{ mpg-name }} supports [logical replication](https://www.postgresql.org/docs/current/logical-replication.html).

Logical replication streams for a {{ mpg-name }} cluster are transparently passed through the [Odyssey connection pooler](../concepts/pooling.md). This helps perform the following tasks using logical replication:

* [{#T}](../operations/data-migration.md).
* [{#T}](../tutorials/outbound-replication.md).
* [{#T}](../operations/logical-replica-from-rds.md).

