---
title: Replication in {{ mch-full-name }}
description: In this tutorial, you will learn how cluster host replication works in {{ mch-full-name }}.
---

# Replication in {{ mch-name }}

With {{ mch-name }}, you can use one of the following tools to manage replication and query distribution:

* [{{ CK }}](#ck).
* [{{ ZK }}](#zk) (default).

You can create [replicated tables](#replicated-tables) in a cluster with enabled replication. Meanwhile, the replication is managed automatically.

## {{ CK }} {#ck}

{% include [ClickHouse Keeper preview note](../../_includes/mdb/mch/note-ck-preview.md) %}

{{ CK }} is a service for data replication and running distributed DDL queries; it implements the {{ ZK }}-compatible client-server protocol. Unlike {{ ZK }}, {{ CK }} does not require separate hosts for its operation and runs on {{ CH }} hosts. You can enable {{ CK }} support only when [creating a cluster](../operations/cluster-create.md).

Using {{ CK }} is associated with the following limitations:

* You can only create clusters of three or more hosts.
* {{ CK }} support cannot be enabled or disabled after creating a cluster.
* You cannot switch clusters using {{ ZK }} hosts to {{ CK }}.
* [To migrate a host](../operations/host-migration.md) from {{ CK }} to a different availability zone, you have to contact [support]({{ link-console-support }}).

You can learn more about {{ CK }} in the [{{ CH }} documentation]({{ ch.docs }}/operations/clickhouse-keeper/).

## {{ ZK }} {#zk}

If your cluster consists of one host or several single-host shards and was originally created without {{ CK }} support, you must [enable fault tolerance for the cluster](../operations/zk-hosts.md#add-zk) before adding new hosts. In which case three {{ ZK }} hosts will be added to the cluster, which is the minimum number required for replication management and fault tolerance.


You can also configure {{ ZK }} hosts as soon as you create a multi-host cluster. In which case:

* If a cluster in the [virtual network](../../vpc/concepts/network.md) has subnets in each [availability zone](../../overview/concepts/geo-scope.md), a {{ ZK }} host is automatically added to each subnet if you do not explicitly specify the settings for such hosts. You can explicitly specify three {{ ZK }} hosts and their settings when creating a cluster, if required.
* If a cluster in the virtual network has subnets only in certain availability zones, you need to explicitly specify three {{ ZK }} hosts and their settings when creating a cluster.

* If you did not specify any subnets for these hosts, {{ mch-short-name }} will automatically distribute them among the subnets of the network the {{ CH }} cluster is connected to.


The minimum number of cores per {{ ZK }} host depends on the total number of cores on {{ CH }} hosts:

| Total number of {{ CH }} host cores | Minimum number of cores per {{ ZK }} host |
|-------------------------------------------|-------------------------------------------------------|
| Less than 48                                  | 2                                                     |
| 48 or higher                                | 4                                                     |

The {{ ZK }} host class can be changed when configuring fault tolerance or [cluster settings](../operations/update.md#change-resource-preset). You cannot change {{ ZK }} settings or connect to such hosts.

{% note warning %}

{{ ZK }} hosts, if any, are counted in when calculating [resource usage]({{ link-console-quotas }}) and cluster cost.

{% endnote %}

## Replicated tables {#replicated-tables}

{{ CH }} supports automatic replication only for tables on [the ReplicatedMergeTree engine]({{ ch.docs }}/engines/table-engines/mergetree-family/replication/). To enable replication, you can create the tables on each host separately or use a distributed DDL query.

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
* `/table_01`: Path to the table in {{ ZK }} or {{ CK }}, which must start with a forward slash `/`.
* `{replica}`: Host ID macro substitution.

To create replicated tables on all cluster hosts, send [a distributed DDL request]({{ ch.docs }}/sql-reference/distributed-ddl/):

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

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
