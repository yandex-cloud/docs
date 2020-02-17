# Questions about {{ CH }}

#### Why should I use {{ CH }} in {{ mch-short-name }} rather than my own VM-based installation? {#clickhouse-advantages-vm}

{{ mch-short-name }} automates routine database maintenance:

* Quick DB deployment with the necessary available resources.

* Data backup.

* Regular software updates.

* DB cluster failover.

* Database usage monitoring and statistics.

#### When should I use {{ CH }} instead of {{ PG }}? {#clickhouse-advantages-pg}

{{ CH }} supports only adding and reading data, as it is designed primarily for analytics (OLAP). In other cases, it's probably more convenient to use {{ PG }}.

#### Is it possible to connect to individual {{ CH }} hosts? {#connect-node}

Yes. You can connect to {{ CH }} cluster hosts over an encrypted connection:

* Using the [HTTPS interface](https://clickhouse.yandex/docs/en/interfaces/http_interface/), port 8443.

* Using the [command-line client](https://clickhouse.yandex/docs/en/interfaces/cli/), port 9440.

SSH connections are not supported.

#### How do I upload data to {{ CH }}? {#load-data}

Use the INSERT query described in the [{{ CH }} documentation](https://clickhouse.yandex/docs/en/query_language/queries.html#insert).

#### How do I upload a very large amount of data to {{ CH }}? {#loadalot}

Use the [CLI](https://clickhouse.yandex/docs/en/interfaces/cli/) for efficient data compression during transmission (the recommended frequency is no more than one INSERT command per second).

Data transfer from physical media is not yet supported.

#### What happens to a cluster if one of its nodes fails? {#node-out}

DB clusters consist of at least two replicas, so the cluster will continue working if one of its nodes is out.

Data may be lost only if a node with a [non-replicated table](https://clickhouse.yandex/docs/en/table_engines/replication/) fails.

#### Is it possible to deploy a {{ CH }} DB cluster in multiple availability zones? {#multiple-az}

Yes. A database cluster may consist of hosts that reside in different availability zones and even different availability regions.

#### How do I back up a {{ CH }} database? {#backup}

Backups are created every 24 hours and stored for seven days after being created. You can restore data only as of backup creation time.

#### How does replication work for {{ CH }}? {#zookeeper-access}

ZooKeeper is used for replication. {{ mch-short-name }} creates a separate ZooKeeper cluster for each {{ CH }} cluster.

Access to ZooKeeper and its setup are not available to Cloud users.

#### Why does a {{ CH }} cluster take up 3 hosts more than it should? {#why-does-a-cluster-take-up-3-hosts-more-than-it-should}

When creating a {{ CH }} cluster with 2 or more hosts, {{ mch-short-name }} automatically creates a cluster of 3 ZooKeeper hosts for managing replication and fault tolerance. These hosts are considered when calculating the [resource quotas]({{ link-console-quotas }}) used by the cloud and the cluster cost. By default, ZooKeeper hosts are created with a minimal [host class](../concepts/instance-types.md).

For more information about using ZooKeeper, see [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/table_engines/replication/).

