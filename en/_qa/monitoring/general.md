# General questions about {{ monitoring-name }}

{% include [logs](../logs.md) %}

#### How can I see the service dashboards? {#dont-see-dashboards}

Service dashboards appear automatically when you create {{ yandex-cloud }} resources. Add a resource and refresh the {{ monitoring-name }} [homepage]({{ link-monitoring }}).

#### The old data in {{ monitoring-name }} charts has disappeared. Why? {#lost-data-graphs}

If a metric has not received new data for 30 days, it is automatically deleted from {{ monitoring-name }}. This period is 60 days for {{ managed-prometheus-name }} and 7 days for {{ compute-full-name }}.

There is also a non-configurable decimation mechanism reducing the amount of stored data.

#### My metrics are not reported and I cannot create a {{ prometheus-name }} workspace. Why? {#prometheus-trouble}

This can happen if you do not have monitoring data-providing [resources](../../overview/roles-and-resources.md#resources) in your cloud. Start using any resource and wait for the metrics to show up in {{ monitoring-name }}.

#### Why do I see gaps in charts while the cloud resource runs normally? {#gaps-in-chart-lines}

A chart gap itself does not mean the cloud resource is not running. Check the delivery of metric values for the selected period: open the [table of values](../../monium/metrics/metric-explorer.md#view-source) under **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.explorer.title }}**.

If there are values, check the [decimation](../../monium/concepts/decimation.md#reading-decimation) settings. When the decimation interval does not have any values, the **Empty** fill method leaves a gap on the chart.

To check a chart without decimation:

1. Open the chart you need under **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.explorer.title }}** in [{{ monium-name }}]({{ link-monium }}).
1. Select a time range of no more than seven days, as you cannot disable decimation for a larger range.
1. At the top right, click ![Chart settings](../../_assets/console-icons/gear.svg).
1. In the settings panel, expand the **{{ ui-key.yacloud_monitoring.wizard.tab.downsampling }}** section and select **{{ ui-key.yacloud_monitoring.wizard.vis.downsampling.none }}** in the **{{ ui-key.yacloud_monitoring.channel.field_method }}** field.
1. Close the settings panel. Your updates will appear on the chart immediately.

If there is no data in the table too, make sure it is delivered and check the [`Metrics Write` quota usage](../../monium/concepts/limits.md#quota-resources). Once the quota is depleted, some dots are discarded, so the chart may start having gaps.

For more on chart settings, see [Customizing chart visualization](../../network-load-balancer/k8s-ref/networkpolicy.md).
