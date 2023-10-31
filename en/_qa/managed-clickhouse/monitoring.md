# Monitoring and logs

#### What metrics and processes can be tracked using monitoring? {#monitoring-metrics}

For all DBMS types, you can track:

- CPU, memory, network, or disk usage, in absolute terms.
- Memory, network, or disk usage as a percentage of the set limits for the corresponding cluster host class.
- The amount of data in the DB cluster and the remaining free space in data storage.

For DB hosts, you can track metrics specific to the corresponding type of DBMS. For example, for {{ PG }}, you can track:
- Average query execution time.
- Number of queries per second.
- Number of errors in logs.

Monitoring can be performed with a minimum granularity of 5 seconds.

#### How is log storage charged? {#logging-pricing}

Logs of any level are written to a disk's system partition with 20 GB allocated, so you are not charged for them separately. The size of the logs created only affects log rotation frequency.

{% include [log-duration](../../_includes/mdb/log-duration-qa.md) %}

#### How do I track the amount of free storage space on ZooKeeper hosts? {#zookeeper-storage}

Follow the instructions in [{#T}](../../managed-clickhouse/operations/monitoring.md) to track the host state or set up alerts.

#### How do I monitor space used by data in hybrid storage? {#hybrid}

Use the `ch_s3_disk_parts_size` metric in {{ monitoring-full-name }}. It shows the amount of space used by [MergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree/) table parts in {{ objstorage-name }}. The metric is only available for {{ mch-name }} clusters with the [hybrid storage](../../managed-clickhouse/concepts/storage.md#hybrid-storage-features) configured. You can learn how to make a request using the metric in [this guide](../../managed-clickhouse/tutorials/hybrid-storage.md#metrics).

#### How do I set up an alert that is triggered once a certain disk space percentage is used up? {#disk-space-percentage}

[Create an alert](../../managed-clickhouse/operations/monitoring.md#monitoring-integration) with the `disk.used_bytes` metric in {{ monitoring-full-name }}. This metric shows the disk space usage in the {{ mch-name }} cluster.

For `disk.used_bytes`, use notification thresholds. The recommended values are as follows:

* `{{ ui-key.yacloud_monitoring.alert.status_alarm }}`: 95% of the disk space.
* `{{ ui-key.yacloud_monitoring.alert.status_warn }}`: 80% of the disk space.

Thresholds are set in bytes only. For example, the recommended values for a 100 GB disk are as follows:

* `{{ ui-key.yacloud_monitoring.alert.status_alarm }}`: `102,005,473,280` bytes (95%).
* `{{ ui-key.yacloud_monitoring.alert.status_warn }}`: `85,899,345,920` bytes (80%).
