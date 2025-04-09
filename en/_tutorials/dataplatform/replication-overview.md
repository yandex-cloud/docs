# Logical replication {{ PG }}

{{ mpg-name }} supports [logical replication](https://www.postgresql.org/docs/current/logical-replication.html).

Logical replication streams for a {{ mpg-name }} cluster are free to pass through the [Odyssey connection pooler](../../managed-postgresql/concepts/pooling.md). This helps perform the following tasks using logical replication:
