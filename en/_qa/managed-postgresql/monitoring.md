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

#### How to enable SQL query logging? {#sql-query-logging}

To enable SQL query logging:

1. Check that the database has the [`pg_stat_statements` extension installed](../../managed-postgresql/operations/extensions/cluster-extensions.md#list-extensions): If the extension is not installed, [add it](../../managed-postgresql/operations/extensions/cluster-extensions.md#update-extensions).

   When using the CLI, run this command:

   ```bash
   {{ yc-mdb-pg }} database update <DB_name> \
      --cluster-name <cluster_name> \
      --extensions <list_of_installed_extensions>,pg_stat_statements
   ```

   In the `--extensions` parameter, specify `pg_stat_statements` and all other extensions that need to remain enabled. If there are no other extensions in the database, only specify `pg_stat_statements`.

1. [Update the DBMS settings](../../managed-postgresql/operations/update.md#change-postgresql-config):

   * Set [**Log min duration statement**](../../managed-postgresql/concepts/settings-list.md#setting-log-min-duration-statement) to `60000` ms. The system will log queries of one minute or longer. You can gradually decrease this value if required. The `0` value enables logging of all queries and can significantly increase the amount of logs and cluster load.
   * Set [**Auto explain sample rate**](../../managed-postgresql/concepts/settings-list.md#setting-auto-explain-sample-rate) to `1`.
   * If you need to log query plans, add `auto_explain` to [**Shared preload libraries**](../../managed-postgresql/concepts/settings-list.md#setting-shared-libraries), set [**Auto explain log min duration**](../../managed-postgresql/concepts/settings-list.md#setting-auto-explain-log-min-duration) to `60000` ms, and enable [**Auto explain log analyze**](../../managed-postgresql/concepts/settings-list.md#setting-auto-explain-log-analyze).

   You can update all these settings using the management console, CLI, API, or {{ TF }}. For example, to enable logging of queries and query plans via the CLI, run this command:

   ```bash
   {{ yc-mdb-pg }} cluster update-config <cluster_name_or_ID> \
      --set log_min_duration_statement=60000 \
      --set auto_explain_sample_rate=1 \
      --set auto_explain_log_min_duration=60000 \
      --set auto_explain_log_analyze=true \
      --set shared_preload_libraries=SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN
   ```

   If you do not need query plans, do not provide `auto_explain_log_min_duration`, `auto_explain_log_analyze`, and `shared_preload_libraries`. If other shared libraries are connected to the cluster, specify them together with `SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN` in the `shared_preload_libraries` setting.

1. [View cluster logs](../../managed-postgresql/operations/cluster-logs.md#get-log). To do this, view access to cluster logs is sufficient. To run queries to the `pg_stat_statements` view, having a permission for connecting to the database is sufficient: the `mdb_monitor` role is not required.

#### What are WALs and what is their purpose? {#wal}

[Write-Ahead Logs](https://postgrespro.com/docs/postgresql/12/wal-intro) are used for writing data to the disk and for data replication. WALs are created during write requests and occupy disk space until log data is fully written to host disks, which ensures DBMS reliability and fault tolerance.

For more details on how {{ PG }} works, refer to its [official documentation](https://postgrespro.com/docs/postgresql/12).

#### What does `Cached` mean in the RAM monitoring of a {{ PG }} cluster host? {#cached}

`Cached` stands for cached data. Most operations are performed in RAM where the entire database working set is stored. Since caching occurs both for databases and the disk itself, the amount of cached data can exceed the storage size.

If application RAM consumption increases, some of the memory used for cache can be freed up.

For more details on disk data caching in Linux, refer to the relevant [guides](https://www.linuxatemyram.com/).


#### How do I get alerts on critical {{ PG }} cluster metrics? {#notifications}

Use [{{ monitoring-full-name }}]({{ link-monitoring }}) and [set up alerts](../../managed-postgresql/operations/monitoring.md#monitoring-integration) for the metrics critical for you.


#### How do I configure an alert for when disk space usage reaches a certain percentage? {#disk-space-percentage}

[Create an alert](../../managed-postgresql/operations/monitoring.md#monitoring-integration) for the `disk.used_bytes` metric in {{ monitoring-full-name }}. This metric shows the disk space usage in a {{ mpg-name }} cluster.

For `disk.used_bytes`, use notification thresholds with the following recommended values:

* `{{ ui-key.yacloud_monitoring.alert.status_alarm }}`: 90% of disk space.
* `{{ ui-key.yacloud_monitoring.alert.status_warn }}`: 80% of disk space.

Thresholds are set in bytes only. For example, the recommended values for a 100 GB disk are as follows:

* `{{ ui-key.yacloud_monitoring.alert.status_alarm }}`: `96636764160` bytes (90%).
* `{{ ui-key.yacloud_monitoring.alert.status_warn }}`: `85899345920` bytes (80%).
