# {{ dataproc-name }} cluster and host state monitoring

You can monitor the health of a {{ dataproc-name }} cluster and the state of its individual hosts using the monitoring tools in the management console. These tools display diagnostic information as charts.

{% include [monitoring-source](../../_includes/mdb/monitoring-provides.md) %}

{% include [monitoring-frequency](../../_includes/mdb/monitoring-freq.md) %}

{% include [monitoring-units](../../_includes/mdb/note-monitoring-auto-units.md) %}

## Cluster state monitoring {#monitoring-cluster}

To view detailed information on the health state of a {{ dataproc-name }} cluster:

{% list tabs group=instructions %}

- Management console {#console}

  1. Open the [folder dashboard]({{ link-console-main }}).
  1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_data-proc }}**.
  1. Click the name of your cluster and select the **{{ ui-key.yacloud.mdb.cluster.switch_monitoring }}** tab.

  This tab displays the following charts:

  * **Active nodes**: Number of running hosts (other than master hosts).
  * **Apps failed**: Number of applications with runtime errors.
  * **Available RAM**: Amount of free RAM (in bytes) available in YARN for hosts in data storage and data processing subclusters.
  * **Available virtual cores**: Number of available cores in YARN.
  * **Containers pending**: Number of containers pending execution in YARN ResourceManager.
  * **Decommissioned nodes**: Number of hosts that have been [decommissioned](../concepts/decommission.md).

{% endlist %}

## Host state monitoring {#monitoring-hosts}

To view detailed information on the state of individual {{ dataproc-name }} hosts:

{% list tabs group=instructions %}

- Management console {#console}

  1. Open the [folder dashboard]({{ link-console-main }}).
  1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_data-proc }}**.
  1. Click the name of your cluster and select the **{{ ui-key.yacloud.mdb.cluster.switch_hosts }}** tab.
  1. Open the VM of the host you want to monitor and select the **{{ ui-key.yacloud.common.monitoring }}** tab.

  This tab displays charts with VM resource usage details:

  * **CPU Utilization**: Processor core workload.
  * **Connections quota utilization**: Percentage of available host connections in use.
  * **Disk bytes**: Storage read and write rate, in bytes per second.
  * **Disk operations**: Number of disk operations per second.
  * **Network bytes**: Network data exchange rate, in bytes per second.
  * **Network packets**: Network packet exchange rate, in packets per second.

{% endlist %}


## Integration with {{ monitoring-full-name }} {#monitoring-integration}

{% list tabs group=instructions %}

- Management console {#console}

  To set up alerts for [cluster](#monitoring-cluster) health and [host](#monitoring-hosts) state metrics:

  1. In the [management console]({{ link-console-main }}), select the folder with the cluster for which you want to set up alerts.
  1. Navigate to ![image](../../_assets/console-icons/display-pulse.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
  1. Under **{{ ui-key.yacloud_monitoring.homepage.title_service-dashboards }}**, select **{{ dataproc-name }}**.
  1. In the relevant metric chart, click ![options](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud_monitoring.dashboard.dash.create-alert }}**.
  1. If the chart shows multiple metrics, select the data query to generate the metric and click **{{ ui-key.yacloud.common.continue }}**. Learn more about the query language in [this {{ monitoring-full-name }} guide](../../monitoring/concepts/querying.md).
  1. Set the `{{ ui-key.yacloud_monitoring.alert.status_alarm }}` and `{{ ui-key.yacloud_monitoring.alert.status_warn }}` thresholds for notifications.
  1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

{% include [other-indicators](../../_includes/mdb/other-indicators.md) %}

For a complete list of supported metrics, see [this {{ monitoring-name }} guide](../../monitoring/metrics-ref/data-processing-ref.md).



## Cluster health and status {#cluster-health-and-status}

{% include [health-and-status](../../_includes/mdb/monitoring-cluster-health-and-status.md) %}

To view the health state and status of a cluster:

1. Open the [folder dashboard]({{ link-console-main }}).
1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_data-proc }}**.
1. In the cluster row, hover over the indicator in the **{{ ui-key.yacloud.mdb.clusters.column_availability }}** column.

### Cluster health states {#cluster-health}

{% include [monitoring-cluster-health](../../_includes/mdb/monitoring-cluster-health.md) %}

### Cluster statuses {#cluster-status}

{% include [monitoring-cluster-status](../../_includes/mdb/monitoring-cluster-status.md) %}
