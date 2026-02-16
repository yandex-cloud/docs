* `DATABASE_ENGINE_ATOMIC` (default): `Atomic` engine; supports non-blocking `DROP TABLE` and `RENAME TABLE` queries, and atomic `EXCHANGE TABLES` queries.
* `DATABASE_ENGINE_REPLICATED`: `Replicated` engine; supports table metadata replication across all database replicas. The set of tables and their schemas will be the same for all replicas.
                    
  It is only available in [replicated](../../../managed-clickhouse/concepts/replication.md) clusters.

* `DATABASE_ENGINE_UNSPECIFIED`: This value will set the default engine, i.e., `DATABASE_ENGINE_ATOMIC`.
                    
You set the engine when creating a database and cannot change it for this database.