# Logical PostgreSQL replication

{{ mpg-name }} supports [logical replication](https://www.postgresql.org/docs/current/logical-replication.html).

Logical replication streams for a {{ mpg-name }} cluster are transparently passed through the [Odyssey connection pooler](../../managed-postgresql/concepts/pooling.md). This helps perform the following tasks using logical replication:

* [{#T}](../../managed-postgresql/tutorials/data-migration.md).
* [Migrating databases from {{ mpg-name }}](../../managed-postgresql/tutorials/outbound-replication.md).
{% if audience != "internal" %}
* [{#T}](../../managed-postgresql/operations/logical-replica-from-rds.md).
{% endif %}