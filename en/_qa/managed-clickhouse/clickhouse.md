#### Why should I use {{ CH }} in {{ mch-short-name }} rather than my own VM-based installation? {#clickhouse-advantages-vm}

{{ mch-short-name }} automates routine database maintenance:

* Quick DB deployment with the required available resources.

* Data backup.

* Regular software updates.

* Ensuring [high availability](../../managed-clickhouse/concepts/high-availability.md) of database clusters.

* Database usage monitoring and statistics.

#### When should I use {{ CH }} rather than {{ PG }}? {#clickhouse-advantages-pg}

{{ CH }} only supports adding and reading data since it is primarily designed for analytics (OLAP). For other purposes, you might want to use {{ PG }}.

#### How do I load data into {{ CH }}? {#load-data}

Use the `INSERT` statement described in [this {{ CH }} article]({{ ch.docs }}/sql-reference/statements/insert-into/).

#### How do I load a large data volume into {{ CH }}? {#loadalot}

Use the [CLI]({{ ch.docs }}/interfaces/cli/) to efficiently compress data when transferring it (we recommend issuing no more than one `INSERT` command per second).

Currently, data transfer from physical media is not supported.

#### What will happen to my cluster if one of its nodes fails? {#node-out}

DB clusters consist of at least two replicas, so if one node is down, the cluster will keep running.

You may lose data only if a node with a [non-replicated table]({{ ch.docs }}/engines/table-engines/mergetree-family/replication/) fails.

#### Can I deploy a {{ CH }} database cluster in multiple availability zones? {#multiple-az}

Yes. A database cluster may consist of hosts residing in different availability [zones](../../overview/concepts/geo-scope.md) or even regions.

#### How does replication work for {{ CH }}? {#zookeeper-access}

{{ mch-short-name }} clusters use {{ CK }} or {{ ZK }} for replication. In both cases, to ensure replication and [high availability](../../managed-clickhouse/concepts/high-availability.md), a minimum of three {{ CK }} or {{ ZK }} hosts are created in the cluster.

#### Why does my {{ CH }} cluster use three extra hosts? {#why-does-a-cluster-take-up-3-hosts-more-than-it-should}

When you create a {{ CH }} cluster of two or more hosts, {{ mch-short-name }} automatically creates three hosts for the selected coordination service,{{ CK }} or {{ ZK }}, to manage replication and high availability. These hosts are counted towards both the cloud [resource quota]({{ link-console-quotas }}) and the cluster cost. By default, {{ CK }} or {{ ZK }} hosts come with the minimum [host class](../../managed-clickhouse/concepts/instance-types.md).

For more information about using {{ ZK }}, see [this {{ CH }} article]({{ ch.docs }}/engines/table-engines/mergetree-family/replication).

#### How does {{ CH }} handles data deletion based on TTL? {#how-ttl-data-processing-works}

With [TTL]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree/#mergetree-table-ttl), data is deleted in [parts]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree/#table_engine-mergetree-multiple-volumes) or during merges rather than in rows.

Deleting entire data parts is more efficient and uses less server resources, but requires the TTL expression and [partitioning key]({{ ch.docs }}/engines/table-engines/mergetree-family/custom-partitioning-key/) to match or be of the same granularity for all rows in a data part.

Deleting data during merges uses more resources and takes place either along with regular background merges or during unscheduled merges. Merge frequency is defined by the `merge_with_ttl_timeout` parameter, which indicates the minimum time in seconds before a repeat merge to process data with expired TTL. You set this parameter when [creating]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree/#table_engine-mergetree-creating-a-table) the table. The default value is 14,400 seconds (4 hours).

We recommend managing data with TTL so that old data is always deleted in data parts. To do this, set [ttl_only_drop_parts]({{ ch.docs }}/operations/settings/settings/#ttl_only_drop_parts) to `true` when creating tables.

#### Can I use JSON data for tables in {{ CH }}? {#how-to-use-json}

Yes, you can. However, JSON is currently an experimental data type in {{ CH }}. To allow creating tables of this type, run this query:

```sql
SET allow_experimental_object_type=1;
```

{% note info %}

The `SET` queries are [not supported](../../managed-clickhouse/operations/web-sql-query#query-restrictions-in-the-management-console.md) when connecting to a cluster via the management console. To run such a query, use a different cluster connection method, e.g., [via clickhouse-client](../../managed-clickhouse/operations/connect#clickhouse-client).

Make sure you have the latest client version installed.

{% endnote %}

For more information, see [this {{ CH }} article](https://clickhouse.com/docs/en/guides/developer/working-with-json/json-semi-structured/#json-object-type).

#### Why is my cluster slow even though the computing resources are not fully utilized? {#throttling}

{% include [throttling](../throttling.md) %}

To increase the maximum IOPS and bandwidth values and make throttling less likely, expand the storage when [updating your cluster](../../managed-clickhouse/operations/update.md#change-disk-size).

If you are using the `network-hdd` storage, consider switching to `network-ssd` or `network-ssd-nonreplicated` by [restoring the cluster](../../managed-clickhouse/operations/cluster-backups.md#restore) from a backup.
