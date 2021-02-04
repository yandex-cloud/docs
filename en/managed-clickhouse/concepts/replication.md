# Replication {{ CH }}

{{ mch-short-name }} helps enable replication for {{ CH }} clusters consisting of 2 or more hosts by using Apache ZooKeeper. You just need to create tables of the required type. ZooKeeper hosts will be created and configured automatically.

{% note info %}

If you created a {{ CH }} cluster with two or more hosts, you can't reduce the number of hosts to one.

{% endnote %}

{% include [non-replicating-hosts](../../_includes/mdb/non-replicating-hosts.md) %}

### Replicated tables {#replicated-tables}

{{ CH }} only supports automatic replication for `ReplicatedMergeTree` tables (see [Data replication](https://clickhouse.yandex/docs/en/table_engines/replication/) in the {{ CH }} documentation). To enable replication, you can create the tables on each host separately or use a distributed DDL query.

To create a `ReplicatedMergeTree` table on a specific {{ CH }} host, send the following query:

```
CREATE TABLE db_01.table_01 (log_date Date, user_name String) \
 ENGINE = ReplicatedMergeTree('/table_01', '{replica}') PARTITION BY log_date ORDER BY (log_date, user_name);
```

Where:

* `db_01` is the DB name.

* `table_01` is the table name.

* `/table_01` is the path to the table in ZooKeeper, which must start with a forward slash <q>/</q>.

* `{replica}` is the host ID macro.

To create replicated tables on every host in the cluster, send a distributed DDL query (as described in the [{{ CH }} documentation]( https://clickhouse.yandex/docs/en/query_language/queries/#ddl-on-cluster)):

```
CREATE TABLE db_01.table_01 ON CLUSTER '{cluster}' (log_date Date, user_name String) \
 ENGINE = ReplicatedMergeTree('/table_01', '{replica}') PARTITION BY log_date ORDER BY (log_date, user_name);
```

The `'{cluster}'` argument is automatically resolved to the {{ CH }} cluster ID.

### ZooKeeper hosts {#zookeeper-hosts}

For each {{ CH }} cluster consisting of 2 or more hosts, {{ mch-short-name }} creates a cluster of 3 ZooKeeper hosts. ZooKeeper hosts are taken into account when calculating [resource consumption]({{ link-console-quotas }}) and the cost of the cluster.

How ZooKeeper hosts are managed:

* By default, ZooKeeper hosts are created with a minimal [host class](instance-types.md). You can specify the necessary host class when creating a cluster [via the API](../api-ref/Cluster/create.md).

* {{ mch-short-name }} does not enable you to connect to ZopKeeper servers and configure them. However, you can change the resources allocated to ZooKeeper hosts by changing the host class.


* If you didn't specify any subnets for the ZooKeeper hosts, {{ mch-short-name }} automatically distributes them among the subnets of the network that the {{ CH }} cluster is connected to.

For more information about using ZooKeeper to manage replication in {{ CH }}, see the [{{ CH }} documentation](https://clickhouse.yandex/docs/en/operations/table_engines/replication/).

