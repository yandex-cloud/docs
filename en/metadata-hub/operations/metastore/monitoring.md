---
title: '{{ metastore-name }} cluster state monitoring'
description: In this tutorial, you will learn how to monitor the state of {{ metastore-name }} clusters.
---

# Cluster state monitoring {{ metastore-name }}

{% include [monitoring-introduction](../../../_includes/mdb/monitoring-introduction.md) %}

Charts are updated every 15 seconds.

{% include [note-monitoring-auto-units](../../../_includes/mdb/note-monitoring-auto-units.md) %}

{% include [alerts](../../../_includes/mdb/alerts.md) %}

## Cluster state monitoring {#monitoring-cluster}

To view detailed information on the health state of a {{ metastore-name }} cluster:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder.
  1. [Navigate]({{ link-console-main }}/link/metadata-hub) to **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/database.svg) **{{ ui-key.yacloud.metastore.label_metastore }}**.
  1. Click the cluster name and open the **Monitoring** tab.

  1. {% include [open-in-yandex-monitoring](../../../_includes/mdb/open-in-yandex-monitoring.md) %}

  The page displays the following charts:

  * Under **API**:

    * **API Calls (rps)**: Methods with the largest number of executed requests for each cluster instance. The list of methods is updated dynamically. The chart may display up to ten methods.
    * **API Latency (p95)**: 95th percentile of the total request execution time broken down by instances.
    * **Active Calls**: Number of requests being processed.
    * **API Latency by method (p95)**: Methods with the largest 95th percentile of request execution time for each cluster instance. The list of methods is updated dynamically. The chart may display up to ten methods.

  * Under **Transactions & Errors**:

    * **Open Transactions / Connections**: Number of active transactions and connections:
      * **Open Transactions**: Number of active [ACID](https://ru.wikipedia.org/wiki/ACID) transactions.
      * **Open Connections**: Number of active connections to the {{ metastore-name }} cluster over the Thrift protocol.
    * **Compaction Cycle Duration**: Compression cycle duration.
    * **DirectSQL Errors**: Number of errors during DirectSQL queries after which {{ metastore-name }} proceeded to execute queries via JDO.

  * Under **Connection Pools** (only for {{ metastore-name }} version `4.2`):

    * **Connection States**: Number of JDBC connections:
      * **Active Connections**: Active connections.
      * **Idle Connections**: Idle connections.
      * **Pending Connections**: Number of queries awaiting connection allocation.
      * **Total Connections**: Total number of connections.

    * **Pool Usage (p95)**: 95th connection hold-time percentile of applications.
    * **Connection Creation (p95)**: 95th connection setup time percentile.
    * **Pool Connection Timeouts (rps)**: Number of queries per second that timed out due to absence of available connections.

  * Under **DB Objects**:

    * **Object Counts**: Number of databases, tables, and partitions in the {{ metastore-name }} cluster storage.
    * **Object Operations (rps)**: Number of create and delete operations for databases, tables, and partitions, per second.

  * Under **Resources**:

    * **Instances**: Number of instances per cluster.
    * **CPU Usage**: CPU time usage by each instance as a percentage of total available CPU time.
    * **Memory Usage**: RAM usage by each instance as a percentage of total available RAM.

  * Under **JVM Memory**:

    * **JVM Heap**: Maximum amount of JVM heap memory and its usage by each instance.
    * **JVM Memory Pools**: Pools with the largest amount of JVM memory used by each instance. The chart displays up to six pools. The list of pools is formed dynamically.

  * Under **JVM Runtime**:

    * **GC Rate**: Operating speed of G1_Old_Generator and G1_Young_Generation garbage collectors on each instance.
    * **JVM Pauses**: Number of stops of all JVM threads whose duration exceeded the notification and warning thresholds.

{% endlist %}

## Setting up alerts in {{ monitoring-full-name }} {#monitoring-integration}

To configure [cluster](#monitoring-cluster) state indicator alerts:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder with the cluster for which you want to set up alerts.
  1. [Go]({{ link-monitoring }}) to ![image](../../../_assets/console-icons/display-pulse.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
  1. Under **{{ ui-key.yacloud_monitoring.dashboard.tab.service-dashboards }}**, select  **Managed Service For Hive Metastore – Cluster Overview**.
  1. Click ![options](../../../_assets/console-icons/ellipsis.svg) on the relevant chart and select **{{ ui-key.yacloud_monitoring.alert.button_create-alert }}**.
  1. If the chart displays multiple metrics, select the data query for the relevant metric and click **{{ ui-key.yacloud_monitoring.dialog.confirm.button_continue }}**. Learn more about the query language in [this {{ monitoring-full-name }} guide](../../../monitoring/concepts/querying.md).
  1. Set the `{{ ui-key.yacloud_monitoring.alert.label_alarm }}` and `{{ ui-key.yacloud_monitoring.alert.label_warning }}` threshold values to trigger the alert.
  1. Click **{{ ui-key.yacloud_monitoring.alert.button_create-alert }}**.

{% endlist %}

{% include [other-indicators](../../../_includes/mdb/other-indicators.md) %}

Recommended threshold values for selected metrics:

| Metric                               | Designation                | `{{ ui-key.yacloud_monitoring.alert-template.threshold-status.alarm }}`                   | `{{ ui-key.yacloud_monitoring.alert-template.threshold-status.warn }}`                 |
|---------------------------------------|:--------------------------:|:-------------------------:|:-------------------------:|
| CPU usage                   | `cpu_usage` | 90%                      | 80%                       |
| RAM usage     | `memory_usage`        | 90% | 80% |
| 95th percentile of total request execution time     | `metastore_api_calls_duration_seconds`    | 10 seconds                         | 3 seconds                    |
| Number of queries awaiting connection allocation      | `metastore_pool_pending_connections`          | —  | Above zero for five minutes  |
| Number of queries that timed out due to absence of available connections | `metastore_pool_connection_timeouts_total` | Greater than zero | — |
| Number of errors during DirectSQL queries after which {{ metastore-name }} proceeded to execute queries via JDO | `metastore_directsql_errors_total` | — | Greater than zero |

For a full list of supported metrics, see [this {{ monitoring-name }} guide](../../../monitoring/metrics-ref/managed-metastore-ref.md).

## Cluster health and status {#cluster-health-and-status}

A cluster’s _{{ ui-key.yacloud.mdb.cluster.overview.label_health }}_ indicates its health, while its _{{ ui-key.yacloud.mdb.cluster.overview.label_status }}_ shows whether the cluster is started, stopped, or in a transitory state.

To view the health state and status of a cluster:

1. In the [management console]({{ link-console-main }}), select the folder.
1. [Navigate]({{ link-console-main }}/link/metadata-hub) to **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
1. In the left-hand panel, select ![image](../../../_assets/console-icons/database.svg) **{{ ui-key.yacloud.metastore.label_metastore }}**.
1. In the cluster row, hover over the indicator in the **{{ ui-key.yacloud.mdb.clusters.column_availability }}** column.

### Cluster health states {#cluster-health}

#|
|| State | Description | Suggested actions ||
|| **ALIVE** | The cluster is operating normally. | No action is required. ||
|| **DEGRADED** | The cluster is not running at its full capacity. |
[Contact support]({{ link-console-support }}) and specify the following:
* Cluster ID.
* IDs of the last operations performed on it.
* Time when the cluster entered the`DEGRADED` state according to [availability charts](#monitoring-cluster). ||
|| **DEAD** | The cluster is out of order. |
[Contact support]({{ link-console-support }}) and specify the following:
* Cluster ID.
* IDs of the last operations performed on it.
* Time when the cluster entered the`DEAD` state according to [availability charts](#monitoring-cluster). ||
|| **UNKNOWN** | The cluster’s state is unknown. |
[Contact support]({{ link-console-support }}) and specify the following:
* Cluster ID.
* IDs of the last operations performed on it.
* Time when the cluster entered the`UNKNOWN` state according to [availability charts](#monitoring-cluster). ||
|#

### Cluster statuses {#cluster-status}

{% include [monitoring-cluster-status](../../../_includes/mdb/monitoring-cluster-status.md) %}
