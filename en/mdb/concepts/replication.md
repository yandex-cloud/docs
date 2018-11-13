# Replication

[!KEYREF mdb-short-name] provides automatic and manual backups for all supported database management systems.

## [!KEYREF PG]

In [!KEYREF PG] clusters, synchronous replication is used: the result of a data write request is reflected both on the master host and priority replica. Data is duplicated asynchronously to the other cluster replicas.

The choice of the master and synchronous replicas is based on the priority that can be set by the MDB for a specific host. In addition, you can configure cascading replication by assigning a source of replication for each host.

For more information about how replication is done in [!KEYREF PG], see the [DBMS documentation](https://www.postgresql.org/docs/10/static/warm-standby.html).

## [!KEYREF CH]

[!KEYREF CH] supports automatic replication only for `ReplicatedMergeTree` tables (see the section [Data replication](https://clickhouse.yandex/docs/ru/table_engines/replication/) in the [!KEYREF CH] documentation). To implement replication, you can create such tables on each replica separately or use a distributed DDL query.

To create a `ReplicatedMergeTree` table on a specific [!KEYREF CH] host, send a query of the following type:

```
CREATE TABLE db_01.table_01 (log_date Date, user_name String) \
 ENGINE = ReplicatedMergeTree('/table_01', '{replica}', log_date, (log_date, user_name), 8192);
```

Where:

- `db_01` is the DB name.
- `table_01` is the table name.
- `/table_01` is the path to the table in ZooKeeper, which must start with a forward slash <q>/</q>.
- `{replica}` is the host ID macro.

To create replicated tables on all hosts in the cluster, send a distributed DDL query (described in [the documentation for [!KEYREF CH]](https://clickhouse.yandex/docs/ru/query_language/queries/#ddl-on-cluster)):

```
CREATE TABLE db_01.table_01 ON CLUSTER 'my_cluster' (log_date Date, user_name String) \
 ENGINE = ReplicatedMergeTree('/table_01', '{replica}', log_date, (log_date, user_name), 8192);
```

Where:

- `my_cluster` is the cluster name [!KEYREF mdb-short-name] that was received when [creating the cluster](../operations/clickhouse/cluster-create.md).

## [!KEYREF MG]

[!KEYREF MG] clusters support replication by default: if a cluster has multiple active hosts, the primary server that handles write requests is automatically selected among them.

For more information about how replication works in [!KEYREF MG], read the [DBMS documentation](https://docs.mongodb.com/manual/replication/).

