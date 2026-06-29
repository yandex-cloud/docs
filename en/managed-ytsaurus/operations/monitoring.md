---
title: '{{ myt-name }} cluster state monitoring'
description: In this tutorial, you will learn how to monitor the state of {{ myt-name }} clusters.
---

# {{ myt-name }} cluster state monitoring

{% include [monitoring-introduction](../../_includes/mdb/monitoring-introduction.md) %}

Charts are updated every 15 seconds.

{% include [note-monitoring-auto-units](../../_includes/mdb/note-monitoring-auto-units.md) %}

{% include [alerts](../../_includes/mdb/alerts.md) %}

## Cluster state monitoring {#monitoring-cluster}

To view detailed information on the health state of a {{ myt-name }} cluster:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the relevant folder.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-ytsaurus }}**.
  1. Click the name of your cluster and select the **{{ ui-key.yacloud.mdb.cluster.switch_monitoring }}** tab.
  1. To get started with metrics, dashboards, or alerts, select {{ monitoring-full-name }} in the list of services.

  The page has two tabs, **Cluster** and **Master**, with the following charts:

  * **Automaton thread CPU usage**: CPU utilization by the automaton thread, i.e., the master primary execution thread, as a percentage.
    * **TOTAL**: Aggregate CPU utilization across all master nodes.
    * **ms-N**: CPU utilization by the automaton thread on master node N.
  * **User write time** Time spent on user-initiated write operations.
    * **root**: Time spent on `root` user write operations.
    * **robot-odin**: Time spent on `robot-odin` user write operations.
    * **scheduler**: Time spent on scheduler write operations.
    * **tablet_cell_changelogger**: Time spent on `tablet_cell_changelogger` user write operations.
  * **User read time** Time spent on user-initiated read operations.
    * **tablet_cell_changelogger**: Time spent on `tablet_cell_changelogger` user read operations.
    * **root**: Time spent on `root` user read operations.
    * **operations_client**: Time spent on client user read operations.
  * **Master memory usage**: Memory usage by the master, GB.
    * **ms-N**: Memory usage on master node N.
  * **LocalRead thread CPU usage**: CPU utilization by the `LocalRead` thread.
    * **TOTAL**: Aggregate CPU utilization across all master nodes as a percentage.
    * **ms-N**: CPU utilization by the `LocalRead` thread on master node N.
  * **User write request rate**: User-initiated write request rate, writes per second.
    * **root**: `root` user write request rate.
    * **robot-odin**: `robot-odin` user write request rate.
    * **scheduler**: Scheduler-initiated write request rate.
    * **tablet_cell_changelogger**: `tablet_cell_changelogger` user write request rate.
  * **User read request rate**: User-initiated read request rate, reads per second.
    * **root**: `root` user read request rate.
    * **queue_agent**: `queue_agent` user read request rate.
    * **operations_client**: Client user read request rate.
  * **Create chunk requests**: Create chunk request rate, requests per second.
    * **TOTAL**: Total number of create chunk requests from all users.
    * **root**: Number of `root` user create chunk requests.
    * **robot-odin**: Number of `robot-odin` user create chunk requests.
    * **scheduler**: Number of scheduler-initiated create chunk requests.
    * **tablet_cell_snapshotter**: Number of `tablet_cell_snapshotter` user create chunk requests.
  * Under **Compute resources**:
    * **CPU distributed vs total**: Total and distributed CPU resources in the cluster.
      * **distributes_resources**: Amount of distributed CPU resources.
      * **total_cluster_resources**: Total CPU resources in the cluster.
    * **GPU distributed vs total**: Total and distributed GPU resources in the cluster.
      * **distributes_resources**: Amount of distributed GPU resources.
      * **total_cluster_resources**: Total GPU resources in the cluster.
    * **Memory distributed vs total**: Total and distributed memory resources in the cluster.
      * **distributes_resources**: Amount of distributed memory resources.
      * **total_cluster_resources**: Total memory resources in the cluster.
    * **Undistributed_resources**: Amount of undistributed resources.
      * **memory**: Amount of undistributed memory resources.
      * **cpu**: Amount of undistributed CPU resources.
  * Under **Scheduler pools**:
    * **CPU: usage, demand, guarantee**: CPU resource usage, demand, and guarantee.
      * **usage**: CPU resources currently in use.
      * **demand**: Requested CPU resources.
      * **guarantee**: Guaranteed CPU resources.
    * **RAM: usage, demand, guarantee**: RAM resource usage, demand, and guarantee.
      * **usage**: RAM currently in use.
      * **demand**: Requested RAM.
      * **guarantee**: Guaranteed RAM.
    * **GPU: usage, demand, guarantee**: GPU resource usage, demand, and guarantee.
      * **usage**: GPU resources currently in use.
      * **demand**: Requested GPU resources.
      * **guarantee**: Guaranteed GPU resources.
    * **Running operation count**: Number of `running` operations.
      * **lightweight usage**: Number of `running` lightweight operations.
      * **usage**: Number of `running` operations.
    * **Total operation count**: Total number of operations.
      **limit**: Maximum allowed operations.
      **usage**: Number of operations in use.
  * Under **Problems**:
    * **Offline nodes**: Nodes in `offline` status.
    * **Banned nodes**: Nodes in `banned` status.
    * **Decommissioned** nodes: Nodes in `decommissioned` status.
    * **Alerts**: Number of active alerts about issues on {{ ytsaurus-name }} cluster nodes.

{% endlist %}

## Setting up alerts in {{ monitoring-full-name }} {#monitoring-integration}

To configure [cluster](#monitoring-cluster) state indicator alerts:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder with the cluster for which you want to set up alerts.
  1. In the list of services, select ![image](../../_assets/console-icons/display-pulse.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
  1. Under **{{ ui-key.yacloud_monitoring.dashboard.tab.service-dashboards }}**, select **{{ myt-name }} — Cluster Resources**.
  1. In the chart you need, click ![options](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud_monitoring.alert.button_create-alert }}**.
  1. If the chart displays multiple metrics, select the data query for the relevant metric and click **{{ ui-key.yacloud_monitoring.dialog.confirm.button_continue }}**. You can learn more about the query language in [this {{ monitoring-full-name }} article](../../monitoring/concepts/querying.md).
  1. Set the `{{ ui-key.yacloud_monitoring.alert.label_alarm }}` and `{{ ui-key.yacloud_monitoring.alert.label_warning }}` threshold values to trigger the alert.
  1. Click **{{ ui-key.yacloud_monitoring.alert.button_create-alert }}**.

{% endlist %}

{% include [other-indicators](../../_includes/mdb/other-indicators.md) %}

For a complete list of supported metrics, see [this {{ monitoring-name }} guide](../../monitoring/metrics-ref/managed-ytsaurus-ref.md).

## Cluster status {#cluster-health-and-status}

_{{ ui-key.yacloud.mdb.cluster.overview.label_status }}_ shows whether the cluster is started, stopped, or in a transitory state.

To view the cluster status, proceed as follows:

1. Navigate to the folder dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-ytsaurus }}**.
1. In the cluster row, find the **{{ ui-key.yacloud.common.label_status }}** column.

#|
|| **Status** | **Description** | **Suggested actions** ||
|| **CREATING** | Preparing for the first start. | Wait a while and get started. The time it takes to create a cluster depends on the host class. ||
|| **RUNNING** | The cluster is operating normally. | No action is required. ||
|| **STOPPING** | The cluster is stopping. | After a while, the cluster status will switch to `STOPPED` and the cluster will be disabled. No action is required. ||
|| **STOPPED** | The cluster stopped. | Start the cluster to get it running again. ||
|| **STARTING** | Starting the cluster that was stopped earlier. | After a while, the cluster status will switch to `RUNNING`. Wait a while and get started. ||
|| **UPDATING** | Updating the cluster configuration. | Once the update is complete, the cluster will get the status it had prior to the update: `RUNNING` or `STOPPED`. ||
|| **DELETING** | Deleting the cluster. | Once cluster deletion is complete, the cluster will be disabled. No action is required. ||
|| **ERROR** | Error when performing an operation with the cluster or during a maintenance window. | If the cluster remains in this status for a long time, [contact support]({{ link-console-support }}). ||
|| **STATUS_UNKNOWN** | The cluster is unable to determine its status. | If the cluster remains in this status for a long time, [contact support]({{ link-console-support }}). ||
|#
