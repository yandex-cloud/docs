---
title: Monitoring {{ SPRK }} cluster state
description: You can monitor the state of a {{ SPRK }} cluster using the monitoring tools in the management console. These tools display diagnostic information as charts. You can also configure alerts in {{ monitoring-full-name }} to monitor the cluster state automatically.
---

# Monitoring {{ SPRK }} cluster state

{% include [monitoring-introduction](../../_includes/mdb/monitoring-introduction.md) %}

Charts are updated every 15 seconds.

{% include [note-monitoring-auto-units](../../_includes/mdb/note-monitoring-auto-units.md) %}

{% include [alerts](../../_includes/mdb/alerts.md) %}

## Monitoring the cluster state {#monitoring-cluster}

To view detailed information on the state of a {{ SPRK }} cluster:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the relevant folder.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spark }}**.
  1. Click the cluster name and select the **{{ ui-key.yacloud.mdb.cluster.switch_monitoring }}** tab.

  1. {% include [open-in-yandex-monitoring](../../_includes/mdb/open-in-yandex-monitoring.md) %}

  The page displays the following charts:

  * Under **Cluster Resource Usage**:

    * **Total Allocated Nodes**: Number of used cluster hosts.
    * **Total Running Containers & Total Running Jobs**: Number of running jobs and containers.

      * **Spark Containers**: Number of running containers.
      * **Spark Jobs**: Number of running jobs.

    * **Pending Containers**: Number of containers waiting to run.
    * **CPU Resources**: Availability of processor cores.
  
      * **Allocated CPU**: Number of CPUs in use.
      * **Allocatable CPU**: Number of CPUs available to containers.
      * **Capacity CPU**: Total CPUs per cluster. Some CPUs may be reserved for system needs.

    * **Available CPU**: Number of available CPUs in the cluster.
    * **CPU Usage/Limits**: CPU utilization by containers.

      * **Additional containers CPU limited**: CPU usage limit for system containers.
      * **Additional containers CPU usage**: Number of CPUs used by the system containers.
      * **Spark containers CPU usage**: CPU usage limit for Spark application containers.
      * **Spark containers CPU limited**: Number of CPUs used by Spark application containers.

    * **Memory Resources**: Available RAM.

      * **Capacity Memory**: Total host RAM. Some RAM may be reserved for system needs.
      * **Allocatable Memory**: Host RAM available to containers.
      * **Allocated Memory**: Host RAM in use.

    * **Available Memory**: Available cluster RAM.
    * **Memory Usage/Limits**: RAM utilization by containers.

      * **Additional containers Memory limited**: RAM limit for system containers.
      * **Additional containers Memory usage**: RAM used by system containers.
      * **Spark containers Memory limited**: RAM limit for Spark application containers.
      * **Spark containers Memory usage**: RAM used by Spark application containers.

  * Under **Driver Pool**:

    * **Driver Pool: Allocated Nodes**: Number of {{ SPRK }} driver hosts.
    * **Driver Pool: Running Containers**: Number of running containers in the driver pool.
    * **Spark Drivers: Running Containers By Nodes**: Number of running containers on {{ SPRK }} driver hosts.
    * **Spark Drivers: CPU Limits By Nodes**: CPU limit for {{ SPRK }} driver hosts.
    * **Spark Drivers: Used CPU By Nodes**: CPUs used by {{ SPRK }} driver hosts.
    * **Driver Pool: Available CPU By Nodes**: CPUs available on {{ SPRK }} driver hosts.
    * **Spark Drivers: Memory Limits By Nodes**: RAM limit for {{ SPRK }} driver hosts.
    * **Spark Drivers: Used Memory By Nodes**: RAM used by {{ SPRK }} driver hosts.
    * **Driver Pool: Available Memory By Nodes**: RAM available on {{ SPRK }} driver hosts.

  * Under **Executor Pool**:

    * **Executor Pool: Allocated Nodes**: Number of {{ SPRK }} executor hosts.
    * **Executor Pool: Running Containers**: Number of running containers in the {{ SPRK }} executor pool.
    * **Spark Executors: Running Containers By Node**: Number of running containers on {{ SPRK }} executor hosts.
    * **Spark Executors: CPU Limits By Nodes**: CPUs limit for {{ SPRK }} executor hosts.
    * **Spark Executors: Used CPU By Nodes**: CPUs used by {{ SPRK }} executor hosts.
    * **Executor Pool: Available CPU By Nodes**: CPUs available on {{ SPRK }} executor hosts.
    * **Spark Executors: Memory Limits By Nodes**: RAM limit on {{ SPRK }} executor hosts.
    * **Spark Executors: Used Memory By Nodes**: RAM used by {{ SPRK }} executor hosts.
    * **Executor Pool: Available Memory By Nodes**: RAM available on {{ SPRK }} executor hosts.

  * Under **Spark Jobs**:

    * **Running Executors By Jobs**: Number of {{ SPRK }} executor hosts by jobs in progress.
    * **Spark Application: Running Stages**: Number of stages in progress by jobs.
    * **Spark Application: Active Tasks**: Number of tasks in progress by jobs.
    * **Spark CPU Limits By Jobs**: CPU limit for jobs.
    * **Spark Used CPU By Jobs**: CPUs used by jobs.
    * **Spark Application: Completed Stages**: Number of completed stages by jobs.
    * **Spark Memory Limits By Jobs**: RAM limit by jobs.
    * **Spark Used Memory By Jobs**: RAM used by jobs.
    * **Spark Application: Completed Tasks**: Number of completed tasks by jobs.
    * **Spark Application: Failed Stages**: Number of failed job stages, by jobs.
    * **Spark Application: Waiting Stages**: Number of pending job stages, by jobs.
    * **Spark Application: Failed Tasks**: Number of failed tasks, by jobs.

{% endlist %}

## Alert settings in {{ monitoring-full-name }} {#monitoring-integration}

To configure [cluster](#monitoring-cluster) state indicator alerts:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder with the cluster for which you want to configure alerts.
  1. In the list of services, select ![image](../../_assets/console-icons/display-pulse.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
  1. Under **{{ ui-key.yacloud_monitoring.dashboard.tab.service-dashboards }}**, select **{{ msp-name }} — Cluster Overview**.
  1. In the chart you need, click ![options](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud_monitoring.alert.button_create-alert }}**.
  1. If the chart shows multiple metrics, select a data query to generate a metric and click **{{ ui-key.yacloud_monitoring.dialog.confirm.button_continue }}**. You can learn more about the query language in the [{{ monitoring-full-name }} documentation](../../monitoring/concepts/querying.md).
  1. Set the `{{ ui-key.yacloud_monitoring.alert.label_alarm }}` and `{{ ui-key.yacloud_monitoring.alert.label_warning }}` threshold values to trigger the alert.
  1. Click **{{ ui-key.yacloud_monitoring.alert.button_create-alert }}**.

{% endlist %}

{% include [other-indicators](../../_includes/mdb/other-indicators.md) %}

For a complete list of supported metrics, see [this {{ monitoring-name }} article](../../monitoring/metrics-ref/managed-spark-ref.md).

## Cluster state and status {#cluster-health-and-status}

{% include [health-and-status](../../_includes/mdb/monitoring-cluster-health-and-status.md) %}

To view a state and status of a cluster:

1. Go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spark }}**.
1. Hover over the indicator in the cluster row of the **{{ ui-key.yacloud.mdb.clusters.column_availability }}** column.

### Cluster states {#cluster-health}

{% include [monitoring-cluster-health](../../_includes/mdb/monitoring-cluster-health.md) %}

### Cluster statuses {#cluster-status}

{% include [monitoring-cluster-status](../../_includes/mdb/monitoring-cluster-status.md) %}
