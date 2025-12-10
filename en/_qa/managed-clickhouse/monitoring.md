#### What metrics and processes can be monitored? {#monitoring-metrics}

For all DBMS types, you can monitor:

- CPU, memory, network, or disk usage, in absolute terms.
- Memory, network, and disk usage as a percentage of the set limits for the relevant cluster host class.
- Amount of data in a database cluster and the remaining free space in your data storage.

For all database hosts, you can monitor metrics specific to their DBMS type. For example, for {{ PG }}, you can monitor:
- Average query execution time.
- Number of queries per second.
- Number of errors in logs, and more.

You can monitor metrics with a minimum granularity of five seconds.

#### How is log storage billed? {#logging-pricing}

Logs of any level are written to a disk's system partition (with 20 GB allocated) and are not charged separately. The size of the logs only affects the frequency of their rotation.

{% include [log-duration](../../_includes/mdb/log-duration-qa.md) %}

#### How do I monitor free storage space on ZooKeeper hosts? {#zookeeper-storage}

Follow the steps in [this guide](../../managed-clickhouse/operations/monitoring.md) to monitor the host state or set up alerts.

#### How do I monitor space taken up by data in hybrid storage? {#hybrid}

Use the `ch_s3_disk_parts_size` metric in {{ monitoring-full-name }}. It shows the amount of space used by [MergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree/) table parts in {{ objstorage-name }}. The metric is only available for {{ mch-name }} clusters with [hybrid storage](../../managed-clickhouse/concepts/storage.md#hybrid-storage-features) configured. To learn more on how to run a query with a metric, see [this tutorial](../../managed-clickhouse/tutorials/hybrid-storage.md#metrics).

#### How do I set up an alert that triggers as soon as a certain percentage of disk space is used up? {#disk-space-percentage}

[Create an alert](../../managed-clickhouse/operations/monitoring.md#monitoring-integration) for the `disk.used_bytes` metric in {{ monitoring-full-name }}. This metric shows the disk space usage in the {{ mch-name }} cluster.

For `disk.used_bytes`, use notification thresholds. Their recommended values are as follows:

* `{{ ui-key.yacloud_monitoring.alert.status_alarm }}`: 95% of disk space
* `{{ ui-key.yacloud_monitoring.alert.status_warn }}`: 80% of disk space

Thresholds are set in bytes only. For example, the recommended values for a 100 GB disk are as follows:

* `{{ ui-key.yacloud_monitoring.alert.status_alarm }}`: `102,005,473,280` bytes (95%)
* `{{ ui-key.yacloud_monitoring.alert.status_warn }}`: `85,899,345,920` bytes (80%)
