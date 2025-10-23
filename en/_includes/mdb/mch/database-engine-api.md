* `DATABASE_ENGINE_ATOMIC` (default): The Atomic engine. Supports non-blocking `DROP TABLE` and `RENAME TABLE` operations, and atomic `EXCHANGE TABLES` operations.
* `DATABASE_ENGINE_REPLICATED`: The Replicated engine. Supports table metadata replication across all database replicas. The set of tables and their schemas will be the same for all replicas.
                    
  Available only in [replicated](../../../managed-clickhouse/concepts/replication.md) clusters.

* `DATABASE_ENGINE_UNSPECIFIED`: This value will set the default engine, i.e., `DATABASE_ENGINE_ATOMIC`.
                    
You set the engine when creating the database and cannot change it for this database.