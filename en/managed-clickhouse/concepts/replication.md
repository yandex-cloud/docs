# Replication {{ CH }}

With {{ mch-name }}, you can use one of the following mechanisms to manage replication and distribution of queries:

* [{#T}](#ck).
* [{#T}](#zk) (default).

This lets you use [replicated tables](#replicated-tables) in a cluster with multiple hosts in a [shard](./sharding.md). At the same time, replication is managed automatically.

{% include [Non replicated hosts](../../_includes/mdb/non-replicating-hosts.md) %}

## {{ CK }} {#ck}

{% include [ClickHouse Keeper preview note](../../_includes/mdb/mch/note-ck-preview.md) %}

{{ CK }}: A service for data replication and execution of distributed DDL queries, implementing the {{ ZK }}-compatible client-server protocol. Unlike {{ ZK }}, {{ CK }} doesn't require separate hosts for its operation and runs on {{ CH }} hosts. You can enable {{ CK }} support only when [creating a cluster](../operations/cluster-create.md).

Using {{ CK }} is associated with the following limitations:

* You can only create clusters of three or more hosts.
* {{ CK }} support cannot be enabled or disabled after creating a cluster.
* To use {{ CK }}, you need {{ CH }} {{ mch-ck-version }} or higher.
* Clusters using {{ ZK }} hosts cannot be changed to use {{ CK }}.

For more information about {{ CK }}, see the [{{ CH }} documentation]({{ ch.docs }}/operations/clickhouse-keeper/).

## {{ ZK }} {#zk}

If the cluster was created without {{ CK }} support, before adding new hosts to a single-host shard, you need to [enable fault tolerance for the cluster](../operations/zk-hosts.md#add-zk) if it isn't enabled. In this case, 3 {{ ZK }} hosts, which is the minimum number of hosts required to manage replication and fault tolerance, are added to the cluster.

You can enable fault tolerance and configure {{ ZK }} hosts [after creating a cluster](../operations/zk-hosts.md#add-zk) with a single host.


You can also configure {{ ZK }} hosts immediately when creating a cluster with multiple hosts. In this case:

* If a cluster in the [virtual network](../../vpc/concepts/network.md) has subnets in each of the [availability zones](../../overview/concepts/geo-scope.md), one {{ ZK }} host is automatically added to each subnet if you don't explicitly specify the settings for these hosts. If necessary, you can explicitly specify 3 {{ ZK }} hosts and their settings when creating a cluster.
* If a cluster in the virtual network has subnets only in certain availability zones, you need to explicitly specify 3 {{ ZK }} hosts and their settings when creating a cluster.

* If you didn't specify any subnets for these hosts, {{ mch-short-name }} automatically distributes them among the subnets of the network that the {{ CH }} cluster is connected to.


The minimum number of cores per {{ ZK }} host depends on the total number of cores on {{ CH }} hosts.

| Total number of {{ CH }} host cores | The minimum number of cores per {{ ZK }} host |
|-------------------------------------------|-------------------------------------------------------|
| Less than 48 | 2 |
| 48 or higher | 4 |

A {{ ZK }} host class can be changed when configuring fault tolerance or [cluster settings](../operations/update.md#change-resource-preset). Changing {{ ZK }} settings or connecting to its hosts is not possible.

{% note warning %}

Note:

* {{ ZK }} hosts, if any, are taken into account when calculating [resource usage]({{ link-console-quotas }}) and the cost of the cluster.
* In shards with multiple hosts, if you created a cluster and then enabled fault tolerance, you won't be able to reduce the number of hosts to one.

{% endnote %}

## Replicated tables {#replicated-tables}

{{ CH }} only supports automatic replication for tables on the [ReplicatedMergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/replication/) engine. To enable replication, you can create the tables on each host separately or use a distributed DDL query.

{% note warning %}

We recommend creating replicated tables on all cluster hosts. Otherwise, data loss may occur after restoring a cluster from a backup. For more information, see [{#T}](backup.md).

{% endnote %}

To create a `ReplicatedMergeTree` table on a specific {{ CH }} host, send the following query:

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

* `db_01` is the DB name.
* `table_01` is the table name.
* `/table_01` is the path to the table in {{ ZK }} or {{ CK }}, which must start with the forward slash <q>/</q>.
* `{replica}` is the host ID macro.

To create replicated tables on all cluster hosts, make a [distributed DDL query]({{ ch.docs }}/sql-reference/distributed-ddl/):

```sql
CREATE TABLE db_01.table_01 ON CLUSTER '{cluster}' (
    log_date date,
    user_name String) ENGINE = ReplicatedMergeTree ('/table_01', '{replica}'
)
PARTITION BY log_date
ORDER BY
    (log_date, user_name);
```

The `'{cluster}'` argument is automatically resolved to the {{ CH }} cluster ID.

To learn more about organizing interaction between replicated and distributed tables in a {{ CH }} cluster, see [{#T}](sharding.md).
