# About {{ monium-name }}

{{ monium-name }} is a platform you can use to monitor and analyze {{ yandex-cloud }} services or your own infrastructure and applications.

## Telemetry types {#telemetry-types}

{{ monium-name }} supports collecting telemetry:

* _Metrics_: Numerical indicators measured over time (e.g., RPS, CPU load). Used for charts and alerts.

* _Logs_: structured records of events in applications or infrastructure (e.g., startup messages, errors). Used for system diagnostics.

* _Traces_: linked chain of operations for a specific request, showing the path and execution time of each step. Used for monitoring distributed systems.


## Transmitting telemetry {#send-telemetry}

To transmit telemetry, you can use:

* OpenTelemetry-compatible agents, e.g., [OTel Collector](collector/opentelemetry.md) for all telemetry types (recommended) or [Fluent Bit](logs/write/fluent-bit.md) for logs.
* {{ unified-agent-short-name }}, Yandex's data collection and delivery agent.
  
    {% include [ua-restriction](../_includes/monium/ua-restriction.md) %}

* Direct transmission from the application via the OpenTelemetry SDK.

{% include [data-transfer-light](../_mermaid/other/monium/data-transfer-light.md) %}

For metric collection, {{ prometheus-name }} integration is supported via [{{ managed-prometheus-name }}](operations/prometheus/).

{% include [otel-only](../_includes/monium/otel-only.md) %}

Going forward, the platform is going to get more observability tools.

{{ yandex-cloud }} [resource metrics](metrics-ref/) are sent to {{ monium-name }} automatically. Many services also provide dashboards with ready-made widgets showing the status of your cloud resources.

## Telemetry distribution {#save-telemetry}

{{ monium-name }} achieves logical separation of telemetry data using the following concepts:

{% include [configuration-model](../_includes/monium/configuration-model.md) %}

Find the description of other {{ monium-name }} objects and terms in the [Basic terms](concepts/glossary.md) section.

## Platform feature overview {#features}

### Metrics {#metrics}

Metrics are real time numerical indicators of system performance. Their common use cases include:

* Monitoring CPU, memory, and network usage.
* Analyzing trends and performance.
* Detecting anomalies and bottlenecks.

[Learn more about metrics](metrics/quickstart.md).

### Logs {#logs}

Logs are structured records of events and messages that help you:

* Investigate specific incidents in detail.
* Analyze errors and exceptions.
* Audit user and system activity.

You can temporarily disable alert notifications by creating a mute.

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

### Dashboards and Metric Explorer {#dashboards}

Real-time visualization of system data and key indicators enables you to:

* Gain a unified view of your system's health.
* Collect data from multiple sources.
* Analyze performance and forecast trends.
* Drill down from high-level overviews to granular details to investigate issues and their root causes.

Learn more about [dashboards](operations/dashboard/create.md) and [Metric Explorer](operations/metric/metric-explorer.md).

{{ monium-name }} delivers end-to-end visibility into your systems, reducing troubleshooting time and empowering data-driven decisions.

### Platform concepts {#concepts}

* [{#T}](concepts/glossary.md)
* [{#T}](concepts/data-model.md)
* [{#T}](concepts/querying.md)