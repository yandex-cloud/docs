# Questions about [!KEYREF CH]

#### Why should I use [!KEYREF CH] in [!KEYREF mch-short-name] and not my own installation on a VM? {#clickhouse-advantages-vm}

[!KEYREF mch-short-name] automates routine database maintenance:

* Quick DB deployment with the necessary available resources.

* Data backup.

* Regular software updates.

* DB cluster failover.

* Database usage monitoring and statistics.

#### When should I use [!KEYREF CH] instead of [!KEYREF PG]? {#clickhouse-advantages-pg}

[!KEYREF CH] supports only adding and reading data, as it is designed primarily for analytics (OLAP). In other cases, it is probably more convenient to use [!KEYREF PG].

#### Is it possible to connect to individual [!KEYREF CH] hosts? {#connect-node}

Yes. You can connect to the hosts of a [!KEYREF CH] cluster via an encrypted connection:

* Using the [HTTPS interface](https://clickhouse.yandex/docs/ru/interfaces/http_interface/), port 8443.

* Using the [command-line client](https://clickhouse.yandex/docs/ru/interfaces/cli/), port 9440.

SSH connections are not supported.

#### How can I load data to [!KEYREF CH]? {#load-data}

Use the INSERT query described in the [ documentation on [!KEYREF CH]](https://clickhouse.yandex/docs/ru/query_language/queries.html#insert).

#### How do I load a very large amount of data to [!KEYREF CH]? {#loadalot}

Use the [CLI](https://clickhouse.yandex/docs/en/interfaces/cli/) for efficient data compression during transmission (the recommended frequency is no more than one INSERT command per second).

Data transfer from physical media is not yet supported.

#### What happens to a cluster if one of its nodes fails? {#node-out}

DB clusters consist of at least two replicas, so the cluster will continue working if one of its nodes is out.

Data may be lost only if a node with a [non-replicated table](https://clickhouse.yandex/docs/ru/table_engines/replication/) fails.

#### Is it possible to deploy a [!KEYREF CH] DB cluster in multiple availability zones? {#multiple-az}

Yes. A database cluster may consist of hosts that reside in different availability zones and even different availability regions.

#### How can I back up a [!KEYREF CH] database? {#backup}

Backups are created every 24 hours and stored for seven days after being created. You can restore data only as of backup creation time.

#### How does replication work for [!KEYREF CH]? {#zookeeper-access}

ZooKeeper is used for replication. [!KEYREF mch-short-name] creates a separate ZooKeeper cluster for each [!KEYREF CH] cluster.

Access to ZooKeeper and its setup are not available to Cloud users.

#### Why does a [!KEYREF CH] cluster take up 3 hosts more than it should?

When creating a [!KEYREF CH] cluster with two or more hosts, [!KEYREF mch-short-name] automatically creates a cluster of three ZooKeeper hosts for managing replication and fault tolerance. These hosts are included when calculating the [resource quotas](https://console.cloud.yandex.ru/?section=quotas) used in the cloud and when calculating the cost of the cluster. By default, ZooKeeper hosts are created with a minimal [host class](../concepts/instance-types.md).

For more information about using ZooKeeper, see [ClickHouse documentation](https://clickhouse.yandex/docs/ru/operations/table_engines/replication/).

