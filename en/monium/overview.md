---
title: '{{ monium-name }} overview'
description: '{{ monium-name }} is a platform you can use to monitor and analyze services via metrics, logs, and traces. It provides a unified system to collect telemetry, visualize data on dashboards, and configure alerts.'
---

# About {{ monium-name }}

{{ monium-name }} is a platform you can use to monitor and analyze {{ yandex-cloud }} services or your own infrastructure and applications.

System monitoring and analysis are based on collecting telemetry, visualizing it on dashboards, and setting up alerts for automated notification of issues and anomalies. A unified tool helps you navigate from anomalies on a chart to error logs and traces of specific requests, allowing you to quickly identify the root cause of incidents.

## Telemetry types {#telemetry-types}

{{ monium-name }} supports collection of application and {{ yandex-cloud }} [resource](../resource-manager/concepts/resources-hierarchy.md) telemetry:

* _Metrics_: Numerical indicators measured over time (e.g., RPS, CPU load). Used for charts and alerts.

    {{ yandex-cloud }} [resource metrics](metrics-ref/) are sent to {{ monium-name }} automatically. Many services also provide [dashboards](visualization/index.md#service-dashboards) with ready-made widgets showing the status of your cloud resources.

* _Logs_: Structured records of events in an application or infrastructure (e.g., start messages, error messages). Used for system diagnostics.

    To collect {{ yandex-cloud }} resource logs, you will need to enable logging when creating or modifying a resource.

* _Traces_: Linked chain of operations for a specific request, showing the path and execution time of each step. Used to monitor distributed systems.

## Telemetry transmission {#send-telemetry}

If telemetry transmission is pre-configured for {{ yandex-cloud }} resources, you will need to manually configure the delivery of data from your applications and third-party infrastructure.

{% include [otel-only](../_includes/monium/otel-only.md) %}

You can use the following for telemetry transmission:

* OpenTelemetry-compatible agents, e.g., [OTel Collector](collector/opentelemetry.md) for all telemetry types (recommended) or [Fluent Bit](logs/write/fluent-bit.md) for logs and metrics.
* {{ unified-agent-short-name }}, Yandex's data collection and delivery agent (currently works with metrics only).
  
    {% include [ua-restriction](../_includes/monium/ua-restriction.md) %}

* Sending directly from the application via the OpenTelemetry SDK.

{% include [data-transfer-light](../_mermaid/other/monium/data-transfer-light.md) %}

For metric collection, {{ prometheus-name }} integration is supported via [{{ managed-prometheus-name }}](operations/prometheus/).

Going forward, the platform is going to get more observability tools.

## Telemetry distribution {#save-telemetry}

{{ monium-name }} achieves logical separation of telemetry data using the following concepts:

{% include [configuration-model](../_includes/monium/configuration-model.md) %}

Find the description of other {{ monium-name }} objects and terms in the [Basic terms](concepts/glossary.md) section.

## Platform feature overview {#features}

The platform provides a full cycle of telemetry management, from data collection to visualization and alerting.

### Data delivery {#data-ingestion}

The platform supports flexible configuration of telemetry delivery:

* Automatic collection of metrics for {{ yandex-cloud }} resources.
* Integration with applications via OpenTelemetry.
* Support for {{ prometheus-name }} via {{ managed-prometheus-name }}.

[Learn more about telemetry transmission](collector/index.md).

### Metrics {#metrics}

Metrics are real time numerical indicators of system performance. They are commonly used for:

* Monitoring CPU, memory, and network usage.
* Analyzing trends and performance.
* Detecting anomalies and bottlenecks.

[Learn more about metrics](metrics/quickstart.md).

### Logs {#logs}

Logs are structured records of events and messages that help you:

* Investigate specific incidents in detail.
* Analyze errors and exceptions.
* Audit user and system activity.

[Learn more about logs](logs/quickstart.md).

### Traces {#traces}

Traces are visual representations of request paths in distributed applications, which enable you to:

* Identify bottlenecks in microservice chains.
* Analyze latency between system components.
* Understand dependencies in complex architectures.
* Examine requests and responses during LLM agent monitoring.

[Learn more about traces](traces/index.md).

### Alerts {#alerts}

Alerts are automated notifications for critical events, for which you can set up the following:

* Event trigger rules, e.g., a sudden change in a metric.
* Notifications via messaging apps, email, phone call, or cloud function.

Alerts help you respond to issues before they affect users or at least minimize that impact.

[Learn more about alerts](operations/alert/create-alert.md).

### Visualization {#dashboards}

Create dashboards for system monitoring:

* Bring together metrics, logs, and traces in a single dashboard.
* Use ready-made service dashboards for {{ yandex-cloud }} resources.
* Customize charts, tables, and other widgets.
* Drill down to analyze issues in detail.

[Learn more about dashboards](visualization/index.md).

### Data integration {#integration}

Link different types of telemetry for comprehensive analysis:

* Navigate from metrics to logs and traces within a single interface.
* Use `trace_id` and `span_id` to link logs to traces.
* Leverage data from multiple sources to analyze incidents.

[Data model](concepts/data-model.md).

### Platform concepts {#concepts}

* [{#T}](concepts/glossary.md)
* [{#T}](concepts/data-model.md)
* [{#T}](concepts/querying.md)

