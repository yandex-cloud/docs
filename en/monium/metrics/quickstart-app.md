# Getting started with application metrics

{{ monium-name }} allows you to work with the metrics of {{ yandex-cloud }} services as well as any other metrics uploaded to {{ monium-name }}, e.g., from your applications, infrastructure, or other clouds.

Follow this guide to set up sending metrics from your application to {{ monium-name }} and viewing them in the interface.

If you are new to {{ yandex-cloud }} or have no application with OTLP telemetry configured, start with [{#T}](../quickstart.md). It describes the basics of setting up your environment and sending data with the help of OTel Collector.

## Delivering metrics {#data-send}

### Connection settings {#main-parameters}

* {% include [otel-only](../../_includes/monium/otel-only.md) %}

* Address to write metrics to: `{{ api-host-monium }}:443`.

* To write metrics, you will need a [service account](../../iam/operations/sa/create.md) with the `monium.metrics.writer` role and an [API key](../../iam/operations/iam-token/create-for-sa.md) with the `yc.monium.metrics.write` scope.

* Metric viewing interface: [{{ monium-name }} home page]({{ link-monium }}) > **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.explorer.title }}**.

Metric delivery is configured the same way as for other telemetry data. See [Data delivery](../collector/index.md) for data delivery and distribution rules, agent configurations, and examples.

## Viewing metrics {#view-metrics}

1. On the [{{ monium-name }} home page,]({{ link-monium }}) select **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.explorer.title }}** on the left.
1. At the top, set the search interval using the timeline, a preset interval, or by entering the time value directly.
1. In the search bar, enter a query to search for application metrics:
   1. Select the `folder__<folder_ID>` project. By default, the current folder's project is selected.
   1. Select `cluster`, `service`, and the relevant metrics one by one.
   1. Click **{{ ui-key.yacloud_monitoring.querystring.action.execute-query }}**.
1. To view metric details, hover over the chart.

For additional metric features, see [{#T}](../operations/metric/metric-explorer.md).

#### See also {#see-also}

* [{#T}](../operations/metric/metric-explorer.md)
* [{#T}](../logs/quickstart.md)
* [{#T}](../traces/index.md)
