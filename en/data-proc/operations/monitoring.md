# Monitoring the state of {{ dataproc-name }} clusters and hosts

You can track the state of a {{ dataproc-name }} cluster and its individual hosts with monitoring tools in the management console. These tools display diagnostic information in the form of charts.

{% include [monitoring-source](../../_includes/mdb/monitoring-provides.md) %}

{% include [monitoring-frequency](../../_includes/mdb/monitoring-freq.md) %}

{% include [monitoring-units](../../_includes/mdb/note-monitoring-auto-units.md) %}

## Monitoring cluster status {#monitoring-cluster}

To view detailed information about the {{ dataproc-name }} cluster status:

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_data-proc }}**.
   1. Click the cluster name and open the **{{ ui-key.yacloud.mdb.cluster.switch_monitoring }}** tab.

   The tab displays the following charts:

   * **Active nodes**: The number of running hosts (except control hosts).
   * **Apps failed**: The number of applications with runtime errors.
   * **Available RAM**: The amount of free RAM (in bytes) available in YARN for hosts in data storage and processing subclusters.
   * **Available virtual cores**: The number of cores available in YARN.
   * **Containers pending**: The number of containers waiting to be launched by the YARN Resource Manager.
   * **Decommissioned nodes**: The number of hosts that have been [decommissioned](../concepts/decommission.md).

{% endlist %}

## Monitoring the state of hosts {#monitoring-hosts}

To view detailed information about the status of individual {{ dataproc-name }} hosts:

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_data-proc }}**.
   1. Click the cluster name and open the **{{ ui-key.yacloud.mdb.cluster.switch_hosts }}** tab.
   1. Open the VM of the host you want to monitor and select the **{{ ui-key.yacloud.compute.instance.switch_monitoring }}** tab.

   The tab displays charts with information on VM resource usage:

   * **CPU Utilization**: Processor core workload.
   * **Connections quota utilization**: Percentage of the available host connections utilized.
   * **Disk bytes**: Storage read and write speed (bytes per second).
   * **Disk operations**: Disk activity (ops per second).
   * **Network bytes**: Speed of data exchange over the network (bytes per second).
   * **Network packets**: Number of packets exchanged over the network, per second.

{% endlist %}


## Integration with {{ monitoring-full-name }} {#monitoring-integration}

{% list tabs %}

- Management console

   To configure [cluster](#monitoring-cluster) and [host](#monitoring-hosts) status metric alerts:

   1. In the [management console]({{ link-console-main }}), select the folder with the cluster you want to configure alerts for.
   1. In the list of services, select ![image](../../_assets/monitoring.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
   1. Under **{{ ui-key.yacloud_monitoring.homepage.title_service-dashboards }}**, select **{{ dataproc-name }}**.
   1. In the appropriate chart with metrics, click ![options](../../_assets/horizontal-ellipsis.svg) and select **{{ ui-key.yacloud_monitoring.dashboard.dash.create-alert }}**.
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
