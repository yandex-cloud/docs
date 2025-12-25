#### Where can I track my disk space utilization to avoid exceeding the 95% limit triggering read-only mode? {#disk-space}

You can monitor your disk space usage:
* In the management console using the [cluster health monitoring tools](../../managed-postgresql/operations/monitoring.md#monitoring-cluster).
* In [{{ monitoring-full-name }}]({{ link-monitoring }}) that also allows you to [set up alerts](../../managed-postgresql/operations/monitoring.md#monitoring-integration) for specified metrics.

#### Are logs stored on the same disk as {{ PG }} data? How are they billed? {#logs-storage}

Logs are stored on separate disks from data and are rotated automatically. You can view log information using the following [CLI](../../cli/) command:

```bash
yc managed-postgresql cluster list-logs <cluster_ID>
```

Cluster log storage is free of charge.

{% include [log-duration](../../_includes/mdb/log-duration-qa.md) %}

#### What are WALs and what is their purpose? {#wal}

[Write-Ahead Logs](https://postgrespro.com/docs/postgresql/12/wal-intro) are used for writing data to the disk and for data replication. WALs are created during write requests and occupy disk space until log data is fully written to host disks, which ensures DBMS reliability and fault tolerance.

For more details on how {{ PG }} works, refer to its [official documentation](https://postgrespro.com/docs/postgresql/12).

#### What does Cached mean in the RAM monitoring of a {{ PG }} cluster host? {#cached}

`Cached` stands for cached data. Most operations are performed in RAM where the entire database working set is stored. Since caching occurs both for databases and the disk itself, the amount of cached data can exceed the storage size.

If application RAM consumption increases, some of the memory used for cache can be freed up.

For more details on disk data caching in Linux, refer to the following [guides](https://www.linuxatemyram.com/).


#### How do I get alerts on critical {{ PG }} cluster metrics? {#notifications}

Use [{{ monitoring-full-name }}]({{ link-monitoring }}) and [set up alerts](../../managed-postgresql/operations/monitoring.md#monitoring-integration) for the metrics critical for you.


#### How do I set up an alert that triggers when a certain percentage of disk space is used? {#disk-space-percentage}

[Create an alert](../../managed-postgresql/operations/monitoring.md#monitoring-integration) for the `disk.used_bytes` metric in {{ monitoring-full-name }}. This metric shows disk space utilization in the {{ mpg-name }} cluster.

For `disk.used_bytes`, use the following recommended notification thresholds:

* `{{ ui-key.yacloud_monitoring.alert.status_alarm }}`: 90% of disk space
* `{{ ui-key.yacloud_monitoring.alert.status_warn }}`: 80% of disk space

Thresholds values must be specified in bytes. For example, the recommended values for a 100 GB disk are as follows:

* `{{ ui-key.yacloud_monitoring.alert.status_alarm }}`: `96636764160` bytes (90%)
* `{{ ui-key.yacloud_monitoring.alert.status_warn }}`: `85899345920` bytes (80%)
