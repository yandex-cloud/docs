* `DATABASE_ENGINE_ATOMIC` (default): `Atomic` engine; supports non-blocking `DROP TABLE` and `RENAME TABLE` queries, and atomic `EXCHANGE TABLES` queries.
* `DATABASE_ENGINE_REPLICATED`: `Replicated` engine; supports table metadata replication across all database replicas. The set of tables and their schemas will be the same for all replicas.
                    
  {% include [replicated-claster-engine](replicated-claster-engine.md) %}

* `DATABASE_ENGINE_UNSPECIFIED`: This value will set the default engine, i.e., `DATABASE_ENGINE_ATOMIC`.
                    
{% include [set-engine](set-engine.md) %}