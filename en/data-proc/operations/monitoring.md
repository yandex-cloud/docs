# Monitoring the state of {{ dataproc-name }} clusters and hosts

You can track the state of a {{ dataproc-name }} cluster and its individual hosts using the monitoring tools in the management console. These tools display diagnostic information as charts.

{% include [monitoring-source](../../_includes/mdb/monitoring-provides.md) %}

{% include [monitoring-frequency](../../_includes/mdb/monitoring-freq.md) %}

{% include [monitoring-units](../../_includes/mdb/note-monitoring-auto-units.md) %}

## Cluster state monitoring {#monitoring-cluster}

To view detailed information on the state of a {{ dataproc-name }} cluster:

{% list tabs group=instructions %}

- Management console {#console}

  1. Open the [folder dashboard]({{ link-console-main }}).
  1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_data-proc }}**.
  1. Click the name of your cluster and select the **{{ ui-key.yacloud.mdb.cluster.switch_monitoring }}** tab.

  The tab displays the following charts:

  * **Active nodes**: Number of running hosts (other than master hosts).
  * **Apps failed**: Number of applications with runtime errors.
  * **Available RAM**: Amount of free RAM (in bytes) available in YARN for hosts in data storage and processing subclusters.
  * **Available virtual cores**: Number of cores available in YARN.
  * **Containers pending**: Number of containers waiting for the YARN Resource Manager to run them.
  * **Decommissioned nodes**: Number of hosts that have been [decommissioned](../concepts/decommission.md).

{% endlist %}

## Monitoring the state of hosts {#monitoring-hosts}

To view detailed information on the state of individual {{ dataproc-name }} hosts:

{% list tabs group=instructions %}

- Management console {#console}

  1. Open the [folder dashboard]({{ link-console-main }}).
  1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_data-proc }}**.
  1. Click the name of your cluster and select the **{{ ui-key.yacloud.mdb.cluster.switch_hosts }}** tab.
  1. Open the VM of the host you want to monitor and select the **{{ ui-key.yacloud.common.monitoring }}** tab.

  The tab displays charts with information on VM resource usage:

  * **CPU Utilization**: Processor core workload.
  * **Connections quota utilization**: Percentage of available host connections being used.
  * **Disk bytes**: Storage read and write speed (bytes per second).
  * **Disk operations**: Disk activity (ops per second).
  * **Network bytes**: Network data exchange rate, in bytes per second.
  * **Network packets**: Network packet exchange rate, in packets per second.

{% endlist %}


## Integration with {{ monitoring-full-name }} {#monitoring-integration}

{% list tabs group=instructions %}

- Management console {#console}

  To configure state indicator alerts for the [cluster](#monitoring-cluster) and [hosts](#monitoring-hosts):

  1. In the [management console]({{ link-console-main }}), select the folder with the cluster for which you want to configure alerts.
  1. [Go](../../console/operations/select-service.md#select-service) to ![image](../../_assets/console-icons/display-pulse.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
  1. Under **{{ ui-key.yacloud_monitoring.homepage.title_service-dashboards }}**, select **{{ dataproc-name }}**.
  1. In the indicator chart, click ![options](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud_monitoring.dashboard.dash.create-alert }}**.
  1. If the chart shows multiple indicators, select a data query to generate a metric and click **{{ ui-key.yacloud.common.continue }}**. For more information about the query language, see [this {{ monitoring-full-name }} guide](../../monitoring/concepts/querying.md).
  1. Set the `{{ ui-key.yacloud_monitoring.alert.status_alarm }}` and `{{ ui-key.yacloud_monitoring.alert.status_warn }}` thresholds for notifications.
  1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

{% include [other-indicators](../../_includes/mdb/other-indicators.md) %}

For a complete list of supported metrics, see [this {{ monitoring-name }} guide](../../monitoring/metrics-ref/data-processing-ref.md).


## Cluster state and status {#cluster-health-and-status}

{% include [health-and-status](../../_includes/mdb/monitoring-cluster-health-and-status.md) %}

To view the state and status of a cluster:

1. Open the [folder dashboard]({{ link-console-main }}).
1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_data-proc }}**.
1. Hover over the indicator in the cluster row of the **{{ ui-key.yacloud.mdb.clusters.column_availability }}** column.

### Cluster states {#cluster-health}

{% include [monitoring-cluster-health](../../_includes/mdb/monitoring-cluster-health.md) %}

### Cluster statuses {#cluster-status}

{% include [monitoring-cluster-status](../../_includes/mdb/monitoring-cluster-status.md) %}
