# Monitoring the state of {{ dataproc-name }} clusters and hosts

You can track the state of a {{ dataproc-name }} cluster and its individual hosts with the monitoring tools in the management console. These tools display diagnostic information as charts.

{% include [monitoring-source](../../_includes/mdb/monitoring-provides.md) %}

{% include [monitoring-frequency](../../_includes/mdb/monitoring-freq.md) %}

{% include [monitoring-units](../../_includes/mdb/note-monitoring-auto-units.md) %}

## Monitoring cluster state {#monitoring-cluster}

To view detailed information about the {{ dataproc-name }} cluster state:

{% list tabs group=instructions %}

- Management console {#console}

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_data-proc }}**.
   1. Click the cluster name and open the **{{ ui-key.yacloud.mdb.cluster.switch_monitoring }}** tab.

   The tab displays the following charts:

   * **Active nodes**: Number of running hosts (other than master hosts).
   * **Apps failed**: Number of applications with runtime errors.
   * **Available RAM**: Amount of free RAM (in bytes) available in YARN for hosts in data storage and processing subclusters.
   * **Available virtual cores**: Number of cores available in YARN.
   * **Containers pending**: Number of containers waiting to be launched by the YARN Resource Manager.
   * **Decommissioned nodes**: Number of hosts that have been [decommissioned](../concepts/decommission.md).

{% endlist %}

## Monitoring the state of hosts {#monitoring-hosts}

To view detailed information about the state of individual {{ dataproc-name }} hosts:

{% list tabs group=instructions %}

- Management console {#console}

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_data-proc }}**.
   1. Click the cluster name and open the **{{ ui-key.yacloud.mdb.cluster.switch_hosts }}** tab.
   1. Open the VM of the host you want to monitor and select the **{{ ui-key.yacloud.compute.instance.switch_monitoring }}** tab.

   The tab displays charts with information on VM resource usage:

   * **CPU Utilization**: Processor core workload.
   * **Connections quota utilization**: Percentage of the available host connections utilized.
   * **Disk bytes**: Storage read and write speed (bytes per second).
   * **Disk operations**: Disk activity (ops per second).
   * **Network bytes**: Speed of data exchange over the network, in bytes per second.
   * **Network packets**: Number of packets exchanged over the network, per second.

{% endlist %}


## Integration with {{ monitoring-full-name }} {#monitoring-integration}

{% list tabs group=instructions %}

- Management console {#console}

   To configure [cluster](#monitoring-cluster) and [host](#monitoring-hosts) state metric alerts:

   1. In the [management console]({{ link-console-main }}), select the folder with the cluster you want to configure alerts for.
   1. In the list of services, select ![image](../../_assets/console-icons/display-pulse.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
   1. Under **{{ ui-key.yacloud_monitoring.homepage.title_service-dashboards }}**, select **{{ dataproc-name }}**.
   1. In the chart with metrics, click ![options](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud_monitoring.dashboard.dash.create-alert }}**.
   1. If the chart shows multiple metrics, select a data query to generate a metric and click **{{ ui-key.yacloud.common.continue }}**. For more information about the query language, see the [{{ monitoring-full-name }} documentation](../../monitoring/concepts/querying.md).
   1. Set the `{{ ui-key.yacloud_monitoring.alert.status_alarm }}` and `{{ ui-key.yacloud_monitoring.alert.status_warn }}` thresholds for notifications.
   1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

{% include [other-indicators](../../_includes/mdb/other-indicators.md) %}

For a complete list of supported metrics, see the [{{ monitoring-name }} documentation](../../monitoring/metrics-ref/index.md#data-proc).


## Cluster state and status {#cluster-health-and-status}

{% include [health-and-status](../../_includes/mdb/monitoring-cluster-health-and-status.md) %}

To view a cluster's state and status:

1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_data-proc }}**.
1. Hover over the indicator in the **{{ ui-key.yacloud.mdb.clusters.column_availability }}** column in the required cluster row.

### Cluster states {#cluster-health}

{% include [monitoring-cluster-health](../../_includes/mdb/monitoring-cluster-health.md) %}

### Cluster statuses {#cluster-status}

{% include [monitoring-cluster-status](../../_includes/mdb/monitoring-cluster-status.md) %}
