---
title: Replication in {{ mch-full-name }}
description: In this article, you will learn about cluster host replication in {{ mch-full-name }}.
---

# Replication in {{ mch-name }}

In {{ CH }}, replication is enabled if the cluster meets all these conditions:

* There is at least one shard with two or more hosts.
* Host [coordination](coordination-system.md) is configured.

A {{ mch-name }} cluster with replication is considered to be [highly available](high-availability.md). In such a cluster, you can create [replicated tables](#replicated-tables) and [replicated databases](#replicated-db).

## Replicated tables {#replicated-tables}

{{ CH }} only supports automatic replication for tables on [the ReplicatedMergeTree engine]({{ ch.docs }}/engines/table-engines/mergetree-family/replication/). To enable replication, you can create such tables on each host separately or use a distributed DDL query.

{% note warning %}

We recommend creating replicated tables on all cluster hosts. Otherwise, you may lose data when restoring a cluster from a [backup](backup.md) or [migrating cluster hosts](../operations/host-migration.md) to a different availability zone.

{% endnote %}

To create a `ReplicatedMergeTree` table on a specific {{ CH }} host, run the following query:

```sql
CREATE TABLE db_01.table_01 (
    log_date date,
    user_name String) ENGINE = ReplicatedMergeTree ('/table_01', '{replica}'
)
PARTITION BY log_date
ORDER BY
    (log_date, user_name);
```

Where:

* `db_01`: Database name.
* `table_01`: Table name.
* `/table_01`: Path to the table in {{ ZK }} or {{ CK }}, which must start with a forward slash, `/`.
* `{replica}`: Host ID macro substitution.

To create replicated tables on all cluster hosts, run this [distributed DDL query]({{ ch.docs }}/sql-reference/distributed-ddl/):

```sql
CREATE TABLE db_01.table_01 ON CLUSTER '{cluster}' (
    log_date date,
    user_name String) ENGINE = ReplicatedMergeTree ('/table_01', '{replica}'
)
PARTITION BY log_date
ORDER BY
    (log_date, user_name);
```

The `'{cluster}'` argument will be automatically resolved to the {{ CH }} cluster ID.

To learn how to manage the interaction between replicated and distributed tables in a {{ CH }} cluster, see [Sharding](sharding.md).

## Replicated databases {#replicated-db}

When [creating a database](../operations/databases.md#add-db) in {{ CH }}, you can select the **Replicated** engine that supports table metadata replication across all database replicas. The set of tables and their schemas will be the same for all replicas.

You can only set the engine when creating a database and cannot change it later.

## Use cases {#examples}

* [{#T}](../tutorials/rdbms-to-clickhouse.md)
* [{#T}](../tutorials/ydb-to-clickhouse.md)
* [{#T}](../tutorials/object-storage-to-clickhouse.md)
* [{#T}](../tutorials/mysql-to-clickhouse.md)

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
