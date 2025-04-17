---
title: '{{ managed-prometheus-full-name }}'
description: '{{ managed-prometheus-full-name }} is a monitoring system compatible with {{ prometheus-name }}. You can use it to collect, store, and query metrics from your containers, applications, and infrastructure. The system leverages the {{ prometheus-name }} data model and {{ promql-name }}, enabling you to use your current {{ grafana-name }} dashboards.'
---

# {{ managed-prometheus-full-name }} overview



{{ managed-prometheus-full-name }} is a monitoring system compatible with [{{ prometheus-name }}](https://prometheus.io/docs/introduction/overview/). You can use it to collect, store, and query metrics from your containers, applications, and infrastructure. The system leverages the {{ prometheus-name }} data model and [{{ promql-name }}](https://prometheus.io/docs/prometheus/latest/querying/basics/), enabling you to use your current [{{ grafana-name }}](https://grafana.com/grafana/) dashboards.

{{ prometheus-name }} features multiple tools for collecting metrics, including [libraries](https://prometheus.io/docs/instrumenting/clientlibs/) for widely-used programming languages and support for [exporting metrics](https://prometheus.io/docs/instrumenting/exporters/) from external systems, such as databases, message queues, and more. {{ managed-prometheus-name }} enables you to use best practices of the {{ prometheus-name }} open-source community, while ensuring high scalability, availability, and security with no need to deploy {{ prometheus-name }} clusters and manage the internal monitoring infrastructure on your own. To get started with {{ managed-prometheus-name }}, install agents that support the [Remote Write](https://prometheus.io/docs/prometheus/latest/configuration/configuration/#remote_write) protocol.

{{ managed-prometheus-name }} is based on the system Yandex uses to monitor its internal services. The system automatically scales metric write, storage, and read operations depending on the workload. Monitoring data is replicated across two availability zones, ensuring high availability.

## Getting started {#access}

To start using {{ managed-prometheus-full-name }} in the current folder, you need to create a workspace. To do this:

1. Open the {{ monitoring-full-name }} [home page]({{ link-monitoring }}).
1. In the left-hand panel, select **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.prometheus.title }}**.
1. Click **Create workspace**.
1. On the page that opens, you will see links to the endpoints to use for the current folder.

To enable {{ prometheus-name }}-formatted metric [writing](ingestion/index.md) and [reading](querying/index.md), follow the relevant guides.

## Current features {#features}

{% note info %}

The system features will be enhanced in upcoming releases.

{% endnote %}


Feature | {{ prometheus-name }} | {{ managed-prometheus-full-name }}
--- | --- | ---
Collecting metrics | [Scrape](https://prometheus.io/docs/prometheus/latest/configuration/configuration/#scrape_config), [Pushgateway](https://prometheus.io/docs/instrumenting/pushing/), [Remote Write](https://prometheus.io/docs/prometheus/latest/configuration/configuration/#remote_write) | Metric writes via [Remote Write](https://prometheus.io/docs/prometheus/latest/configuration/configuration/#remote_write) are supported. You can use [{{ unified-agent-short-name }} from {{ yandex-cloud }}](ingestion/prometheus-agent.md) to send metrics from the virtual machine to {{ managed-prometheus-full-name }}. Any compatible metric collection agent will also be suitable, including {{ prometheus-name }} itself.
Long-term metric storage | Not intended for long-term metric storage, using [third-party solutions](https://prometheus.io/docs/prometheus/latest/storage/#existing-integrations) | Support for long-term metric storage, with time-unlimited storage possible through [decimation](../../concepts/decimation.md).
Reading metrics | Data and metadata reads via the [HTTP API](https://prometheus.io/docs/prometheus/latest/querying/api/) | Data and metadata reads via the [HTTP API](https://prometheus.io/docs/prometheus/latest/querying/api/) with some [restrictions](querying/grafana.md#restrictions)
Visualization | [Expression browser](https://prometheus.io/docs/visualization/browser/), [Grafana](https://prometheus.io/docs/visualization/grafana/) | Support for [{{ prometheus-name }} data source](https://grafana.com/docs/grafana/latest/datasources/prometheus/)
Aggregation | Aggregation via [recording rules](https://prometheus.io/docs/prometheus/latest/configuration/recording_rules/) | Support for existing [recording rule](recording-rules.md) files in YAML format, which you can upload and manage via the {{ monitoring-name }} UI and API.
Alerting | Alerting via [alerting rules](https://prometheus.io/docs/prometheus/latest/configuration/alerting_rules/) | Support for existing [alerting rule](alerting-rules.md) files in YAML format, which you can upload and manage via the {{ monitoring-name }} UI and API.
Integration | Client [libraries](https://prometheus.io/docs/instrumenting/clientlibs/) and [exporters](https://prometheus.io/docs/instrumenting/exporters/) | Existing libraries and exporters.

{% include [alerting-rules-preview](../../../_includes/monitoring/alerting-rules-preview.md) %}

## Current limitations {#restrictions}

* The `NaN` value is not supported and is treated as a missing point.
* The `+Inf`/`-Inf` values may be processed incorrectly.
* Alerting rules only support [email](https://prometheus.io/docs/alerting/latest/configuration/#email_config) and [Telegram](https://prometheus.io/docs/alerting/latest/configuration/#telegram_config) channels, with no [dynamic routing](https://prometheus.io/docs/alerting/latest/configuration/#route).
* `staleness markers`, `exemplars`, and `native histograms` are not supported.

## Quotas and limits {#limits}

{{ managed-prometheus-full-name }} has the following limits:

{% include [quotes-limits-def.md](../../../_includes/quotes-limits-def.md) %}

If you need more resources, contact support at [{{ link-support-mail }}](mailto:{{ link-support-mail }}), detailing which quotas you want increased and by how much.

### Quotas per endpoint {#quotas-per-endpoint}

Limit type | Value
----- | -----
Maximum data write speed in [Remote Write](https://prometheus.io/docs/prometheus/latest/configuration/configuration/#remote_write) format | 1,000 requests/s and 80 MB/s
Number of metrics per write request | 10,000
Number of [Remote Read API](https://prometheus.io/docs/prometheus/latest/querying/remote_read_api) read requests per second | 200
Number of [HTTP API](https://prometheus.io/docs/prometheus/latest/querying/api/) read requests per second | 200
Number of unique metrics | 20,000,000
Maximum retention period for [expired metrics](../../concepts/ttl.md) ^1^ | 60 days

^1^ Metrics getting no new values for 60 days are considered expired and removed. Metrics that keep getting new values are stored indefinitely.

Here is what you can do in **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.prometheus.title }}** > Workspace > **General information**:

* View the number of written metrics.
* Go to the page with service [dashboards](../../concepts/visualization/dashboard) and view the number of requests, errors, and HTTP status codes per second for various endpoints.

### Limits per endpoint {#limits-per-endpoint}

Limit type | Value
----- | -----
Number of unique labels per metric | 29

{% include [trademark](../../../_includes/monitoring/trademark.md) %}
