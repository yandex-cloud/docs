# Replication {{ CH }}

{{ mch-short-name }} helps organize replication for {{ CH }} clusters with 2 or more hosts in the [shard](sharding.md). You just need to [add hosts {{ ZK }}](#zookeeper-hosts) in the cluster and create a table [with replication support](#replicated-tables). The process of replication is managed by Apache {{ ZK }} in automatic mode.

{% include [non-replicating-hosts](../../_includes/mdb/non-replicating-hosts.md) %}

## {{ ZK }} hosts {#zookeeper-hosts}

In {{ mch-name }}, before adding new hosts to a shard with a single host, you need to [enable fault tolerance for the cluster](../operations/zk-hosts.md#add-zk) if it isn't enabled. The minimum number of {{ ZK }} hosts is added to manage the replication process.

By default, all shards in the cluster are created with a single host and fault tolerance is disabled. When [creating a {{ CH }} cluster](../operations/cluster-create.md) with multiple hosts using the management console, you will see a suggestion to add {{ ZK }} hosts to enable fault tolerance. When creating such a cluster using the CLI or API:

- If a cluster in the[virtual network](../../vpc/concepts/network.md) has subnets in each of the [availability zones](../../overview/concepts/geo-scope.md), one {{ ZK }} host is automatically added to each subnet if you don't explicitly specify the settings for these hosts. If necessary, you can explicitly specify 3 {{ ZK }} hosts and their settings when creating a cluster.
- If a cluster in the virtual network has subnets only in certain availability zones, you need to explicitly specify 3 {{ ZK }} hosts and their settings when creating a cluster.

{% note warning %}

Note:

- {{ ZK }} hosts, if any, are taken into account when calculating [resource consumption]({{ link-console-quotas }}) and the cost of the cluster.
- In shards with multiple hosts, if you created a cluster and then enabled fault tolerance, you won't be able to reduce the number of hosts to one.
- If the cluster uses [hybrid storage](storage.md#hybrid-storage-features) at the [Preview](../../overview/concepts/launch-stages.md) stage, it isn't possible to configure replication. This restriction is removed at the General Availability stage.

{% endnote %}

## {{ ZK }} management in {{ mch-name }} {#zk-management}

To enable automatic replication, {{ mch-name }} manages {{ ZK }} hosts as follows:

- By default, these hosts are created with a minimal [host class](instance-types.md). But you can set the appropriate {{ ZK }} host class when you [create](../operations/cluster-create.md) a cluster or when [you enable fault tolerance for your cluster](../operations/zk-hosts.md#add-zk).

- {{ mch-short-name }} does not allow connecting to these hosts and configuring them. However, you can change the resources allocated to {{ ZK }} hosts by [changing the host class](../operations/update.md#change-resource-preset).


- If you didn't specify any subnets for these hosts, {{ mch-short-name }} automatically distributes them among the subnets of the network that the {{ CH }} cluster is connected to.

## Replicated tables {#replicated-tables}

{{ CH }} supports automatic replication only for tables on [the ReplicatedMergeTree engine](https://clickhouse.tech/docs/en/engines/table-engines/mergetree-family/replication/). To enable replication, you can create the tables on each host separately or use a distributed DDL query.

To create a `ReplicatedMergeTree` table on a specific {{ CH }} host, send the following query:

```
CREATE TABLE db_01.table_01 (log_date Date, user_name String) \
 ENGINE = ReplicatedMergeTree('/table_01', '{replica}') PARTITION BY log_date ORDER BY (log_date, user_name);
```

Where:

* `db_01` is the DB name.
* `table_01` is the table name.
* `/table_01` is the path to the table in {{ ZK }}, which must start with a forward slash <q>/</q>.
* `{replica}` is the host ID macro.

To create replicated tables on all cluster hosts, send [a distributed DDL request](https://clickhouse.tech/docs/en/sql-reference/distributed-ddl/):

```
CREATE TABLE db_01.table_01 ON CLUSTER '{cluster}' (log_date Date, user_name String) \
 ENGINE = ReplicatedMergeTree('/table_01', '{replica}') PARTITION BY log_date ORDER BY (log_date, user_name);
```

The `'{cluster}'` argument is automatically resolved to the {{ CH }} cluster ID.

To learn more about organizing interaction between replicated and distributed tables in a {{ CH }} cluster, see [{#T}](sharding.md).

