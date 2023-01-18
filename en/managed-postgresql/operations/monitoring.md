---
title: "Monitoring the state of PostgreSQL clusters and hosts"
description: "Using monitoring tools in the management console, you can track the status of a {{ mpg-name }} cluster and its individual hosts. These tools display diagnostic information in the form of charts. You can also configure alerts in {{ monitoring-full-name }} to monitor cluster status automatically."
---

# Monitoring the state of {{ PG }} clusters and hosts

{% include [monitoring-introduction](../../_includes/mdb/monitoring-introduction.md) %}

{% include [monitoring-freq](../../_includes/mdb/monitoring-freq.md) %}

{% include [note-monitoring-auto-units](../../_includes/mdb/note-monitoring-auto-units.md) %}

{% include [alerts](../../_includes/mdb/alerts.md) %}

## Monitoring cluster status {#monitoring-cluster}

To view detailed information about the {{ mpg-name }} cluster status:

1. Go to the folder page and select **{{ mpg-name }}**.

1. Click on the name of the cluster and open the **Monitoring** tab.

1. {% include [open-in-yandex-monitoring](../../_includes/mdb/open-in-yandex-monitoring.md) %}

The following charts open on the page:

* **Age of oldest transaction/statement**: Oldest transaction processing and operator execution time.
* **Average transaction/statement time**: Average transaction processing and operator execution time.
* **CPU usage**: Usage of processor cores.
* **Disk read/write bytes**: Disk read and write speed (bytes per second).
* **Disk read/write IOPS**: Disk read and write activity (ops per second).
* **Disk usage by DB**: Disk usage by database (bytes).
* **Disk usage on primary**: Disk usage on a master host (bytes).
* **Inode usage by host**: The used number of inodes by host.
* **Inode usage on primary**: The used number of inodes on a master host.
* **Is Primary, [boolean]**: Indicates which host is the master and for how long.
* **Free space**: Free disk space for each host (in bytes).
* **Log errors**: Number of logged errors per second.
* **Memory usage**: The use of RAM in bytes. At high loads, the value of the **Free** parameter goes down while those of other parameters go up.
* **Network Bytes**: Network data transfer speed (bytes per second).
* **Packets received/sent**: Network packet transmission activity (packets per second).
* **Pooler is alive, [boolean]**: Pooler health for each host either as a master or as a replica.
* **PostgreSQL Alive, [boolean]**: PostgreSQL health for each host either as a master or as a replica.
* **Replication lag**: Replication delay.
* **Session CPU usage cores**: Number of utilized processor cores by session type.
* **Sessions per wait event**: Number of waiting sessions by wait type.
* **Sessions read bytes**: Amount of data read by session type (bytes).
* **Sessions write bytes**: Amount of data written by session type (bytes).
* **Statement quantiles**: Operator execution time by percentile.
* **TCP connections**: Number of TCP connections per second.
* **Total pooler connections**: Number of pooler connections, both client and server.
* **Total size of temporary files**: Total temporary file size (bytes).
* **Total size of WAL files**: Total [WAL file](../concepts/backup.md) size (bytes).
* **Transaction quantiles**: Transaction processing time by percentile.
* **Transactions/statements per second**: Number of transactions and operators per second.

## Monitoring the state of hosts {#monitoring-hosts}

To view detailed information about the status of individual {{ mpg-name }} hosts:

1. Go to the folder page and select **{{ mpg-name }}**.
1. Click the name of the desired cluster and select **Hosts** → **Monitoring**.
1. Select the host from the drop-down list.

This page displays charts showing the load on an individual host in the cluster:

* **CPU usage**: Usage of processor cores. As the load goes up, the **Idle** value goes down.
* **Disk IOPS**: The number of disk operations per second.
* **Disk read/write bytes**: The speed of disk operations (bytes per second).
* **Memory usage**: The use of RAM in bytes. At high loads, the value of the **Free** parameter goes down while those of other parameters go up.
* **Network Bytes**: The speed of data exchange over the network (bytes per second).
* **Network Packets**: The number of packets exchanged over the network per second.

The **Disk read/write bytes** and the **Disk IOPS** charts show that the **Read** property increases when active database reads are in progress, and that **Write** increases when database writes are in progress.

For hosts with the **Replica** role, it's normal that **Received** is greater than **Sent** on the **Network Bytes** and **Network Packets** charts.

{% if audience != "internal" %}

## Alert settings in {{ monitoring-full-name }} {#monitoring-integration}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder with the cluster you wish to configure alerts for.
   1. In the list of services, select ![image](../../_assets/monitoring.svg) **{{ monitoring-short-name }}**.
   1. Under **Service dashboards**, select:
      * **{{ mpg-name }} Cluster Overview** to configure cluster alerts.
      * **{{ mpg-name }} Host Overview** to configure host alerts.
   1. In the desired chart, click ![options](../../_assets/horizontal-ellipsis.svg) and select **Create alert**.
   1. If there are multiple metrics on a chart, select a data query to generate a metric and click **Continue**. For more information about the query language, see the [{{ monitoring-full-name }} documentation](../../monitoring/concepts/querying.md).
   1. Set the `Alarm` and `Warning` threshold values to trigger the alert.
   1. Click **Create alert**.

{% endlist %}

{% include [other-indicators](../../_includes/mdb/other-indicators.md) %}

Recommended threshold values:

| Metric | Parameter | `Alarm` | `Warning` |
|---------------------------------------|:--------------------------:|:-------------------------:|:-------------------------:|
| Replication delay | `postgres-replication_lag` | `60` | `5`   |
| Number of healthy hosts | `postgres-is_alive` | `<number of hosts> - 2` | `<number of hosts> - 1` |
| Average query execution time | `pooler-avg_query_time` | — | `2000` |
| Storage space used | `disk.used_bytes` | 90% of storage size | 80% of storage size |

You can view the current storage size in [detailed information about the cluster](cluster-list.md#get-cluster).

For a complete list of supported metrics, see the [{{ monitoring-name }} documentation](../../monitoring/metrics-ref/index.md#managed-postgresql).

{% endif %}

## Cluster state and status {#cluster-health-and-status}

{% include [health-and-status](../../_includes/mdb/monitoring-cluster-health-and-status.md) %}

To view a cluster's state and status:

1. Go to the folder page and select **{{ mpg-name }}**.
1. Hover over the indicator in the **Availability** column in the row of the cluster you need.

### Cluster states {#cluster-health}

{% include [monitoring-cluster-health](../../_includes/mdb/monitoring-cluster-health.md) %}

### Cluster statuses {#cluster-status}

{% include [monitoring-cluster-status](../../_includes/mdb/monitoring-cluster-status.md) %}

{% if audience == "internal" %}

## Solomon metrics {#solomon}

Here are the descriptions of the {{ mpg-name }} metrics that are automatically collected in Solomon.

The name of the metric is written in the `name` label.

{% cut "Labels shared by all metrics of the service" %}

| Label | Value |
----|----
| service | Service ID: `managed-postgresql` |
| resource_type | Resource type: `cluster` |
| resource_id | Cluster ID |
| host | Host FQDN |
| node | Host type: `primary`, `replica` |
| subcluster_name | Subcluster name |

{% endcut %}

{% cut "CPU metrics" %}

The load on processor cores.

{% include [CPU metrics](../../_includes/mdb/internal/metrics-cpu-avg.md) %}

{% endcut %}

{% cut "Disk metrics" %}

{% include [Disk metrics](../../_includes/mdb/internal/metrics-disk.md) %}

{% endcut %}

{% cut "Disk operation metrics" %}

{% include [Disk IO metrics](../../_includes/mdb/internal/metrics-disk-io.md) %}

{% endcut %}

{% cut "RAM metrics" %}

{% include [RAM metrics](../../_includes/mdb/internal/metrics-ram.md) %}

{% endcut %}

{% cut "Network metrics" %}

{% include [Network metrics](../../_includes/mdb/internal/metrics-network.md) %}

{% endcut %}

{% cut "Cluster metrics" %}

| Name<br/>Type, units | Description |
| ----- | ----- |
| `can_read`<br/>`DGAUGE`, 0/1 | Read access indicator.<br/>`1` if a cluster is available for reads, `0` if not. |
| `can_write`<br/>`DGAUGE`, 0/1 | Write access indicator.<br/>`1` if a cluster is available for writes, `0` if not. |
| `postgres-is_alive`<br/>`DGAUGE`, 0/1 | Host health indicator.<br/>`1` if a DB host is alive, `0` if not. |
| `postgres-is_primary`<br/>`DGAUGE`, 0/1 | Master host indicator.<br/>`1` if a DB host is a master, `0` if not. |
| `postgres-is_replica`<br/>`DGAUGE`, 0/1 | Replica host indicator.<br/>`1` if a DB host is a replica, `0` if not. |
| `postgres-log_errors`<br/>`DGAUGE`, messages per second | Number of errors logged per second. |
| `postgres-log_fatals`<br/>`DGAUGE`, messages per second | Number of fatal errors logged per second. |
| `postgres-log_slow_queries`<br/>`DGAUGE`, queries per second | Number of slow queries logged per second. |
| `postgres-log_warnings`<br/>`DGAUGE`, messages per second | Number of warnings logged per second. |
| `postgres-replication_lag`<br/>`DGAUGE`, seconds | Replication lag. |
| `postgres_max_connections`<br/>`DGAUGE`, pcs | Maximum number of connections. |
| `postgres_total_connections`<br/>`DGAUGE`, pcs | Number of connections. |

{% endcut %}

{% cut "DB metrics" %}

| Name<br/>Type, units | Description |
| ----- | ----- |
| `_pg_database_size`<br/>`DGAUGE`, bytes | DB size. <br/>Additional labels: `dbname` |
| `<database>_conn_aborted`<br/>`DGAUGE`, pcs | Number of `<database>` connections. Connection status: `aborted`. |
| `<database>_conn_active`<br/>`DGAUGE`, pcs | Number of `<database>` connections. Connection status: `active`. |
| `<database>_conn_idle`<br/>`DGAUGE`, pcs | Number of `<database>` connections. Connection status: `idle`. |
| `<database>_conn_idle_in_transaction`<br/>`DGAUGE`, pcs | Number of `<database>` connections. Connection status: `idle_in_transaction`. |
| `<database>_conn_waiting`<br/>`DGAUGE`, pcs | Number of `<database>` connections. Connection status: `waiting`. |
| `<database>_tup_deleted`<br/>`DGAUGE`, pcs | Number of rows deleted by queries in this `<database>`. |
| `<database>_tup_fetched`<br/>`DGAUGE`, pcs | Number of rows fetched by queries in this `<database>`. |
| `<database>_tup_inserted`<br/>`DGAUGE`, pcs | Number of rows inserted by queries in this `<database>`. |
| `<database>_tup_returned`<br/>`DGAUGE`, pcs | Number of rows returned by queries in this `<database>`. |
| `<database>_tup_updated`<br/>`DGAUGE`, pcs | Number of rows updated by queries in this `<database>`. |

{% endcut %}

{% cut "Connection pooler metrics" %}

| Name<br/>Type, units | Description |
| ----- | ----- |
| `pooler-avg_query_time`<br/>`DGAUGE`, ms | Average query execution time per DB host. |
| `pooler-avg_xact_time`<br/>`DGAUGE`, ms | Average execution time per transaction per DB host. |
| `pooler-bytes_recieved`<br/>`DGAUGE`, bytes | Bytes received. |
| `pooler-bytes_sent`<br/>`DGAUGE`, bytes | Bytes sent. |
| `pooler-free_clients`<br/>`DGAUGE`, pcs | Number of client connections available in the connection pooler. |
| `pooler-free_servers`<br/>`DGAUGE`, pcs | Number of server connections available in the connection pooler. |
| `pooler-is_alive`<br/>`DGAUGE`, 0/1 | Pooler health for each host either as a master or as a replica. |
| `pooler-pgbouncer_tcp_connections`<br/>`DGAUGE`, connections per second | Number of PostgreSQL TCP connections. |
| `pooler-postgres_tcp_connections`<br/>`DGAUGE`, connections per second | Number of PgBouncer TCP connections. |
| `pooler-query_0.5`<br/>`DGAUGE`, seconds | Query execution time, median value. |
| `pooler-query_0.75`<br/>`DGAUGE`, seconds | Query execution time, 0.75 percentile. |
| `pooler-query_0.9`<br/>`DGAUGE`, seconds | Query execution time, 0.9 percentile. |
| `pooler-query_0.95`<br/>`DGAUGE`, seconds | Query execution time, 0.95 percentile. |
| `pooler-query_0.99`<br/>`DGAUGE`, seconds | Query execution time, 0.99 percentile. |
| `pooler-query_0.999`<br/>`DGAUGE`, seconds | Query execution time, 0.999 percentile. |
| `pooler-query_count`<br/>`DGAUGE`, pcs | Number of queries executed on each DB host. |
| `pooler-total_tcp_connections`<br/>`DGAUGE`, connections per second | Number of PostgreSQL and PgBouncer TCP connections. |
| `pooler-transaction_0.5`<br/>`DGAUGE`, seconds | Transaction handling time, median value |
| `pooler-transaction_0.75`<br/>`DGAUGE`, seconds | Transaction handling time, 0.75 percentile. |
| `pooler-transaction_0.9`<br/>`DGAUGE`, seconds | Transaction handling time, 0.9 percentile. |
| `pooler-transaction_0.95`<br/>`DGAUGE`, seconds | Transaction handling time, 0.95 percentile. |
| `pooler-transaction_0.99`<br/>`DGAUGE`, seconds | Transaction handling time, 0.99 percentile. |
| `pooler-transaction_0.999`<br/>`DGAUGE`, seconds | Transaction handling time, 0.999 percentile. |
| `pooler-used_clients`<br/>`DGAUGE`, pcs | Number of client connections used in the connection pooler. |
| `pooler-used_servers`<br/>`DGAUGE`, pcs | Number of server connections used in the connection pooler. |
| `pooler-xact_count`<br/>`DGAUGE`, pcs | Number of transactions executed on each DB host. |

{% endcut %}

{% endif %}
