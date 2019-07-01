# Replication {{ CH }}

{{ mch-short-name }} helps enable replication for {{ CH }} clusters consisting of two or more hosts via Apache ZooKeeper. You just need to create tables of the required type. ZooKeeper hosts will be created and configured automatically.

{% note info %}

If you created a {{ CH }} cluster with two or more hosts, it is not yet possible to reduce the number of hosts to one. And vice versa, if you created a single-host cluster, you will not be able to add hosts to it.

{% endnote %}

### Replicated tables

{{ CH }} supports automatic replication only for `ReplicatedMergeTree` tables (see [Data replication](https://clickhouse.yandex/docs/en/table_engines/replication/) in the {{ CH }} documentation). To enable replication, you can create the tables on each host separately or use a distributed DDL query.

To create a `ReplicatedMergeTree` table on a specific {{ CH }} host, send a query of the following type:

```
CREATE TABLE db_01.table_01 (log_date Date, user_name String) \
 ENGINE = ReplicatedMergeTree('/table_01', '{replica}', log_date, (log_date, user_name), 8192);
```

Where:

* `db_01` is the DB name.

* `table_01` is the table name.

* `/table_01` is the path to the table in ZooKeeper, which must start with a forward slash <q>/</q>.

* `{replica}` is the host ID macro.

To create replicated tables on all hosts in the cluster, send a distributed DDL query (described in [the documentation for {{ CH }}](https://clickhouse.yandex/docs/en/query_language/queries/#ddl-on-cluster)):

```
CREATE TABLE db_01.table_01 ON CLUSTER '{cluster}' (log_date Date, user_name String) \
 ENGINE = ReplicatedMergeTree('/table_01', '{replica}', log_date, (log_date, user_name), 8192);
```

The `'{cluster}'` argument is automatically resolved to the {{ CH }} cluster ID.

### ZooKeeper hosts {#zookeeper-hosts}

For each {{ CH }} cluster consisting of two or more hosts, {{ mch-short-name }} creates a cluster of three ZooKeeper hosts. ZooKeeper hosts are taken into account when calculating [resource consumption]({{ link-console-quotas }}) and the cost of the cluster.

How ZooKeeper hosts are managed:

* By default, ZooKeeper hosts are created with a minimal [host class](instance-types.md). You can specify the necessary host class when creating a cluster [via the API](../api-ref/Cluster/create.md).

* {{ mch-short-name }} does not enable you to connect to ZopKeeper servers and configure them. However, you can change the resources allocated to ZooKeeper hosts by changing the host class.

* If you didn't specify any subnets for ZooKeeper hosts, {{ mch-short-name }} automatically distributes them among the subnets of the network to which a {{ CH }} cluster is connected.

To learn more about using ZooKeeper for replication management in {{ CH }}, see [the documentation {{ CH }}](https://clickhouse.yandex/docs/en/operations/table_engines/replication/).

