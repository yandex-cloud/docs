# Questions about {{ CH }}

#### Why should I use {{ CH }} in {{ mch-short-name }} rather than my own VM-based installation? {#clickhouse-advantages-vm}

{{ mch-short-name }} automates routine database maintenance:

* Quick DB deployment with the necessary available resources.

* Data backup.

* Regular software updates.

* Providing DB cluster failover.

* Database usage monitoring and statistics.

#### When should I use {{ CH }} instead of {{ PG }}? {#clickhouse-advantages-pg}

{{ CH }} supports only adding and reading data because it is designed primarily for analytics (OLAP). In other cases, it's probably more convenient to use {{ PG }}.

#### How do I upload data to {{ CH }}? {#load-data}

Use the `INSERT` statement described in the [{{ CH }} documentation](https://{{ ch-domain }}/docs/en/sql-reference/statements/insert-into/).

#### How do I upload very large data to {{ CH }}? {#loadalot}

Use the [CLI](https://{{ ch-domain }}/docs/en/interfaces/cli/) for efficient data compression during transmission (the recommended frequency is no more than one `INSERT` command per second).

Data transfer from physical media is not yet supported.

#### What happens to a cluster if one of its nodes fails? {#node-out}

DB clusters consist of at least two replicas, so the cluster will continue working if one of its nodes is out.

Data may be lost only if a node with a [non-replicated table](https://{{ ch-domain }}/docs/en/engines/table-engines/mergetree-family/replication/) fails.

#### Is it possible to deploy a {{ CH }} database cluster in multiple availability zones? {#multiple-az}

Yes. A database cluster may consist of hosts that reside in different availability zones and even different availability regions.

#### How does replication work for {{ CH }}? {#zookeeper-access}

{{ mch-short-name }} clusters use replication using {{ CK }} or {{ ZK }}. In the first case, no additional settings are required — replication and fault tolerance are enabled by default. In the second case, for each {{ CH }} cluster, a {{ ZK }} cluster with at least three hosts is created.

Access to {{ ZK }} and its setup are not available to {{ yandex-cloud }} users.

#### Why does a {{ CH }} cluster take up 3 hosts more than it should? {#why-does-a-cluster-take-up-3-hosts-more-than-it-should}

When creating a {{ CH }} cluster with 2 or more hosts, {{ mch-short-name }} automatically creates a cluster with 3 {{ ZK }} hosts to manage replication and fault tolerance, if {{ CK }} support is not enabled. These hosts are taken into account when calculating the consumed cloud [resource quota]({{ link-console-quotas }}) and cluster cost. By default, {{ ZK }} hosts are created with a minimal [host class](../concepts/instance-types.md).

For more information about using {{ ZK }}, see the [ClickHouse documentation](https://{{ ch-domain }}/docs/en/operations/table_engines/replication/).
