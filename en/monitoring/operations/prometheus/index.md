# {{managed-prometheus-full-name}}

{% include [note-preview](../../../_includes/monitoring/prometheus-preview.md) %}

{{ managed-prometheus-full-name }} is a monitoring system compatible with [{{ prometheus-name }}](https://prometheus.io/docs/introduction/overview/). You can use it to collect, store, and read metrics from your containers, applications, and infrastructure. The system uses the {{ prometheus-name }} data model and the [{{ promql-name }}](https://prometheus.io/docs/prometheus/latest/querying/basics/) query language. This allows you to work with dashboards existing in [{{ grafana-name }}](https://grafana.com/grafana/).

{{ prometheus-name }} provides multiple mechanisms for collecting metrics, including [libraries](https://prometheus.io/docs/instrumenting/clientlibs/) for popular programming languages and support for [exporting metrics](https://prometheus.io/docs/instrumenting/exporters/) from third-party systems, like databases or message queues. {{ managed-prometheus-name }} allows you to use best practices of the {{ prometheus-name }} open source community, while ensuring high scalability, availability, and safety with no need to deploy {{ prometheus-name }} clusters and manage the internal monitoring infrastructure on your own. To get started with {{ managed-prometheus-name }}, just install agents that support the metric [Remote Write](https://prometheus.io/docs/prometheus/latest/configuration/configuration/#remote_write) protocol.

{{ managed-prometheus-name }} is based on the system that Yandex uses to monitor internal services. The system automatically scales metric writes, storage, and reads depending on the workload. High availability is ensured thanks to replication of the monitoring data in two availability zones.

## How to gain access {#access}

To enable {{ managed-prometheus-name }} in the current folder:

1. Open the [service home page]({{ link-monitoring }}) {{ monitoring-full-name }}.
1. In the left-hand panel, select **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.prometheus.title }}**.
1. Fill out the form and click **{{ ui-key.yacloud_monitoring.prometheus.form.submit-button.text }}**.
1. Wait until {{ yandex-cloud }} processes your request.
1. Once the request is approved, the page will show links to the endpoints to be used for the current folder.

To enable metric [writes](ingestion/index.md) and [reads](querying/index.md) in {{ prometheus-name }} format, follow the corresponding guides.

## Current features {#features}

{% note info %}

The system functionality will be enhanced in upcoming releases.

{% endnote %}


| Feature | {{ prometheus-name }} | {{ managed-prometheus-full-name }} |
--- | --- | ---
| Collecting metrics | [Scrape](https://prometheus.io/docs/prometheus/latest/configuration/configuration/#scrape_config), [Pushgateway](https://prometheus.io/docs/instrumenting/pushing/), [Remote Write](https://prometheus.io/docs/prometheus/latest/configuration/configuration/#remote_write) | Metric writes via the [Remote Write](https://prometheus.io/docs/prometheus/latest/configuration/configuration/#remote_write) protocol are supported. To deliver metrics to {{ managed-prometheus-full-name }}, you can use any compatible metric collection agent, including {{ prometheus-name }} itself. |
| Long-term metric storage | Not intended for long-term metric storage. [Third-party solutions](https://prometheus.io/docs/prometheus/latest/storage/#existing-integrations) are used for that. | Long-term metric storage is supported. If [decimation](../../concepts/decimation.md) is used, metrics can be stored for an unlimited amount of time. |
| Reading metrics | Data and metadata reads via the [HTTP API](https://prometheus.io/docs/prometheus/latest/querying/api/) are supported. | Data and metadata reads via the [HTTP API](https://prometheus.io/docs/prometheus/latest/querying/api/) are supported with some [restrictions](querying/grafana.md#restrictions). |
| Visualization | [Expression browser](https://prometheus.io/docs/visualization/browser/), [Grafana](https://prometheus.io/docs/visualization/grafana/) | [{{ prometheus-name }} data source](https://grafana.com/docs/grafana/latest/datasources/prometheus/) is supported. |
| Aggregation | Aggregation via [recording rules](https://prometheus.io/docs/prometheus/latest/configuration/recording_rules/) is supported. | To be implemented in future versions. Currently, recording rules can be calculated based on short-term data on local {{ prometheus-name }} instances. |
| Alerting | Supported via [alerting rules](https://prometheus.io/docs/prometheus/latest/configuration/alerting_rules/). | To be implemented in future versions. Currently, alerting rules can be calculated based on short-term data on local {{ prometheus-name }} instances. |
| Integrations | Client [libraries](https://prometheus.io/docs/instrumenting/clientlibs/) and [exporters](https://prometheus.io/docs/instrumenting/exporters/). | Existing libraries and exporters can be used. |


## Current limitations {#restrictions}

* The `NaN` value is not supported and is treated as a missing point.
* The `+Inf`/`-Inf` value may be processed incorrectly.
* No support for `recording rules` and `alerting rules`.
* No support for `staleness markers`, `exemplars`, and `native histograms`.

## Limits per endpoint {#limits-per-endpoint}

The limits specified below are not technical system restrictions and can be increased by sending a request to the [support team]({{ link-console-support }}).

* 350 requests per second and 5 MB/s per write in [Remote Write](https://prometheus.io/docs/prometheus/latest/configuration/configuration/#remote_write) format.
* 10000 metrics per request per write.
* 100 requests per second per read via the [Remote Read API](https://prometheus.io/docs/prometheus/latest/querying/remote_read_api).
* 100 requests per second per read via the [HTTP API](https://prometheus.io/docs/prometheus/latest/querying/api/).
* 1 million unique metrics.
* 29 unique labels per metric.
* [Expired metrics](../../concepts/ttl.md) are deleted in 60 days.

{% include [trademark](../../../_includes/monitoring/trademark.md) %}
