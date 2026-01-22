---
title: Monitoring {{ mtr-name }} cluster state
description: In this tutorial, you will learn how to monitor the state of {{ mtr-name }} clusters.
---

# Monitoring {{ mtr-name }} cluster state

{% include [monitoring-introduction](../../_includes/mdb/monitoring-introduction.md) %}

Charts are updated every 15 seconds.

{% include [note-monitoring-auto-units](../../_includes/mdb/note-monitoring-auto-units.md) %}

{% include [alerts](../../_includes/mdb/alerts.md) %}

## Monitoring the cluster state {#monitoring-cluster}

To view detailed information on the state of a {{ mtr-name }} cluster:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the relevant folder.
  1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-trino }}**.
  1. Click the name of your cluster and select the **{{ ui-key.yacloud.mdb.cluster.switch_monitoring }}** tab.

  1. {% include [open-in-yandex-monitoring](../../_includes/mdb/open-in-yandex-monitoring.md) %}

  The page displays the following charts:

  * Under **Cluster**:

    * **Total cluster nodes**: Number of cluster hosts.
    * **Total Available Processors**: Number of available CPUs.
    * **Cluster distributed memory (cluster memory pool)**: Amount of distributed cluster memory.
        
      * **Total Distributed Bytes**: Total memory (in GB).
      * **Free Distributed Bytes**: Available memory (in GB).

  * Under **Queries**:

    * **Queries (executing)**

      * **Running**: At least one part of the query plan is in progress.
      * **Queued**: Query is received and waiting to run.
      * **Progressing**: Query is in progress and not blocked.
      * **Finishing**: Query is almost complete.

    * **Queries (by status)**

      * **Submitted**: Received queries.
      * **Started**: Queries in progress.
      * **Failed**: Queries that resulted in an error.
      * **Completed**: Completed queries, including failed ones.
      * **Canceled**: Queries canceled by the user.
      * **Abandoned**: Completed queries with unclaimed results.

    * **Errors**: Errors and their types. The number of errors is given per second.

      * **UserError**: User-side errors.
      * **Internal**: Server-side error.
      * **InsufficientResources**: Errors caused by insufficient resources.
      * **External**: External errors.

  * Under **Execution**:

      * **Timings, p95 (One minute)**: 95th percentile of query execution time with a one minute window.

{% endlist %}

## Setting up alerts in {{ monitoring-full-name }} {#monitoring-integration}

To configure [cluster](#monitoring-cluster) state indicator alerts:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing the cluster for which you want to set up alerts.
  1. [Go](../../console/operations/select-service.md#select-service) to ![image](../../_assets/console-icons/display-pulse.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
  1. Under **{{ ui-key.yacloud_monitoring.dashboard.tab.service-dashboards }}**, select **{{ mtr-name }} — Cluster Overview**.
  1. In the chart you need, click ![options](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud_monitoring.alert.button_create-alert }}**.
  1. If the chart shows multiple metrics, select the data query to generate a metric and click **{{ ui-key.yacloud_monitoring.dialog.confirm.button_continue }}**. You can learn more about the query language in [this {{ monitoring-full-name }} article](../../monitoring/concepts/querying.md).
  1. Set the `{{ ui-key.yacloud_monitoring.alert.label_alarm }}` and `{{ ui-key.yacloud_monitoring.alert.label_warning }}` threshold values to trigger the alert.
  1. Click **{{ ui-key.yacloud_monitoring.alert.button_create-alert }}**.

{% endlist %}

{% include [other-indicators](../../_includes/mdb/other-indicators.md) %}

For a complete list of supported metrics, see [this {{ monitoring-name }} article](../../monitoring/metrics-ref/managed-trino-ref.md).

## Cluster state and status {#cluster-health-and-status}

A cluster’s _{{ ui-key.yacloud.mdb.cluster.overview.label_health }}_ indicates its health, while its _{{ ui-key.yacloud.mdb.cluster.overview.label_status }}_ shows whether the cluster is started, stopped, or in a transitory state.

To check the cluster’s state and status:

1. Go to the [folder page]({{ link-console-main }}).
1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-trino }}**.
1. In the cluster row, hover over the indicator in the **{{ ui-key.yacloud.mdb.clusters.column_availability }}** column.

### Cluster states {#cluster-health}

State | Description | Suggested actions
:--- | :--- | :---
**ALIVE** | The cluster is operating normally. | No action is required.
**DEGRADED** | The cluster is not running at its full capacity. | [Contact support]({{ link-console-support }}) and specify the following:<ul><li>Cluster ID.</li><li>IDs of the last operations performed on it.</li><li>Time when the cluster entered the `DEGRADED` state according to [availability charts](#monitoring-cluster).</li></ul>
**DEAD** | The cluster is out of order. | [Contact support]({{ link-console-support }}) and specify the following:<ul><li>Cluster ID.</li><li>IDs of the last operations performed on it.</li><li>Time when the cluster entered the `DEAD` state according to [availability charts](#monitoring-cluster).</li></ul>
**UNKNOWN** | The cluster’s state is unknown. | [Contact support]({{ link-console-support }}) and specify the following:<ul><li>Cluster ID.</li><li>IDs of the last operations performed on it.</li><li>Time when the cluster entered the `UNKNOWN` state according to [availability charts](#monitoring-cluster).</li></ul>

### Cluster statuses {#cluster-status}

{% include [monitoring-cluster-status](../../_includes/mdb/monitoring-cluster-status.md) %}
