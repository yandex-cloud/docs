---
title: '{{ maf-full-name }} cluster state monitoring'
description: In this tutorial, you will learn how to monitor the state of your {{ maf-name }} cluster.
---

# {{ maf-name }} cluster state monitoring

{% include [monitoring-introduction](../../_includes/mdb/monitoring-introduction.md) %}

Charts are updated once a minute.

{% include [note-monitoring-auto-units](../../_includes/mdb/note-monitoring-auto-units.md) %}

{% include [alerts](../../_includes/mdb/alerts.md) %}

## Cluster state monitoring {#monitoring-cluster}

To view detailed information on the state of a {{ maf-name }} cluster:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the relevant folder.
  1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-airflow }}**.
  1. Click the name of your cluster and select the **{{ ui-key.yacloud.mdb.cluster.switch_monitoring }}** tab.

      The page that opens will display the performance charts for the {{ maf-name }} cluster.

  1. {% include [open-in-yandex-monitoring](../../_includes/mdb/open-in-yandex-monitoring.md) %}

{% endlist %}

### Available charts {#monitoring-dashboards}

* Under **Cluster**:

  * **CPU usage**: CPU usage by cluster components as a percentage of their limits.
  * **Memory usage**: RAM usage by cluster components as a percentage of their limits.
  * **Components Restarts**: Number of cluster component restarts.
  * **Components Count**: Number of active components in the cluster.

* Under **DAGs**:

  * **DAG import stats**: DAG import metrics.
  * **DAG parse timings**: Maximum time for processing DAGs.
  
* Under **Tasks**:

  * **Tasks completed, 5m window**: Number of tasks completed within a five-minute window.
  * **Tasks duration, p99**: 99th percentile of task execution time.
  * **Tasks duration sum, 5m window**: Total time it takes to complete tasks with a five-minute window.
  
* Under **Resources**:

  * **Pool usage**: Number of occupied slots per cluster pool.

## Setting up alerts in {{ monitoring-full-name }} {#monitoring-integration}

To configure [cluster](#monitoring-cluster) state indicator alerts:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder with the cluster for which you want to configure alerts.
  1. [Go](../../console/operations/select-service.md#select-service) to ![image](../../_assets/console-icons/display-pulse.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
  1. Under **{{ ui-key.yacloud_monitoring.dashboard.tab.service-dashboards }}**, select **{{ maf-name }} — Cluster Overview**.
  1. In the chart you need, click ![options](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud_monitoring.alert.button_create-alert }}**.
  1. If the chart shows multiple metrics, select the data query to generate a metric and click **{{ ui-key.yacloud_monitoring.dialog.confirm.button_continue }}**. You can learn more about the query language in [this {{ monitoring-full-name }} article](../../monitoring/concepts/querying.md).
  1. Set the `{{ ui-key.yacloud_monitoring.alert.label_alarm }}` and `{{ ui-key.yacloud_monitoring.alert.label_warning }}` threshold values to trigger the alert.
  1. Click **{{ ui-key.yacloud_monitoring.alert.button_create-alert }}**.

{% endlist %}

{% include [other-indicators](../../_includes/mdb/other-indicators.md) %}

For a complete list of supported metrics, see [this {{ monitoring-name }} article](../../monitoring/metrics-ref/managed-airflow-ref.md).

## Cluster state and status

{% include [health-and-status](../../_includes/mdb/monitoring-cluster-health-and-status.md) %}

To view the state and status of a cluster:

1. Open the [folder dashboard]({{ link-console-main }}).
1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-airflow }}**.
1. In the cluster row, hover over the indicator in the **{{ ui-key.yacloud.mdb.clusters.column_availability }}** column.

### Cluster states {#cluster-health}

State | Description | Suggested actions
:--- | :--- | :---
**ALIVE** | The cluster is operating normally. | No action is required.
**DEAD** | The cluster is out of order. | [Contact support]({{ link-console-support }}) and specify the following:<ul><li>Cluster ID.</li><li>IDs of the last operations performed on it.</li><li>Time when the cluster entered the `DEAD` state according to [availability charts](#monitoring-cluster).</li></ul>
**UNKNOWN** | The cluster’s state is unknown. | [Contact support]({{ link-console-support }}) and specify the following:<ul><li>Cluster ID.</li><li>IDs of the last operations performed on it.</li><li>Time when the cluster entered the `UNKNOWN` state according to [availability charts](#monitoring-cluster).</li></ul>

### Cluster statuses {#cluster-status}

{% include [monitoring-cluster-status](../../_includes/mdb/monitoring-cluster-status.md) %}