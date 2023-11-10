# Monitoring and logs in {{ mpg-name }}

#### Where can I track my use of disk space to avoid exceeding the 95% read-only limit? {#disk-space}

You can track your disk space:
* In the management console using [cluster status monitoring tools](../../managed-postgresql/operations/monitoring.md#monitoring-cluster).
   * In [{{ monitoring-full-name }}]({{ link-monitoring }}) that allows you to [set up alerts](../../managed-postgresql/operations/monitoring.md#monitoring-integration) for specified metrics.

#### Are logs stored on the same disk as {{ PG }} data? How are they charged? {#logs-storage}

Logs are stored on different disks than data and rotated automatically. You can view log information using the [CLI](../../cli/) command below:

```
yc managed-postgresql cluster list-logs <cluster_ID>
```

Cluster log storage is free of charge.

{% include [log-duration](../../_includes/mdb/log-duration-qa.md) %}

#### What is WAL and what is it used for? {#wal}

[Write-Ahead Logs](https://postgrespro.com/docs/postgresql/12/wal-intro) are required for data writes to disk and for data replication. These are created by write requests and take up disk space until log data is written out to host disks, making DBMS reliable and failure-tolerant.

For more information about {{ PG }}, see the [official documentation](https://postgrespro.com/docs/postgresql/12).

#### What does the Cached parameter mean for {{ PG }} cluster host RAM monitoring? {#cached}

Cached stores cached data. Most operations are performed in random-access memory, since this is where all database information is stored. Caching is applied both to databases and to disks, which may cause the amount of cached data to exceed the storage size.

If the amount of RAM used by applications increases, some of the cache memory may be released.

For more information about caching disk data in Linux, see the [documentation](https://www.linuxatemyram.com/).


#### How do I get alerts on critical {{ PG }} cluster parameters? {#notifications}

Use [{{ monitoring-full-name }}]({{ link-monitoring }}) and [set up alerts](../../managed-postgresql/operations/monitoring.md#monitoring-integration) for the parameters critical for you.


#### How do I set up an alert that is triggered once a certain disk space percentage is used up? {#disk-space-percentage}

[Create an alert](../../managed-postgresql/operations/monitoring.md#monitoring-integration) with the `disk.used_bytes` metric in {{ monitoring-full-name }}. This metric shows the disk space usage in the {{ mpg-name }} cluster.

For `disk.used_bytes`, use notification thresholds. The recommended values are as follows:

* `{{ ui-key.yacloud_monitoring.alert.status_alarm }}`: 90% of the disk space
* `{{ ui-key.yacloud_monitoring.alert.status_warn }}`: 80% of the disk space

Thresholds are set in bytes only. For example, the recommended values for a 100 GB disk are as follows:

* `{{ ui-key.yacloud_monitoring.alert.status_alarm }}`: `96,636,764,160` bytes (90%)
* `{{ ui-key.yacloud_monitoring.alert.status_warn }}`: `85,899,345,920` bytes (80%)
