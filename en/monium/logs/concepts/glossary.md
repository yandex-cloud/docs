# Overview and basic concepts

{{ monium-logs-name }} is a distributed system for storing, searching, visualizing, and analyzing logs.

Logs are helpful when you need to get insights into your application and infrastructure performance: detect errors and exceptions, investigate incidents, track changes, and find out the causes of degradation.

{{ monium-logs-name }} is part of {{ monium-name }} and shares its basic components such as the project model, access management, data model, and interface.

{{ monium-name }} only accepts OpenTelemetry data. Here is what you can use to send logs:
* OpenTelemetry SDK in the application.
* OTel supported agents: [Otel Collector](../../collector/opentelemetry.md) or [Fluent Bit](../write/fluent-bit.md).

You can use logs together with [traces](../../traces/index.md). To quickly switch between log entries and traces, use `trace_id` and `span_id`.

**Benefits**

* Fast log search for real-time error diagnostics.
* Fault tolerance: data is replicated across data centers.
* Self-monitoring: the system automatically collects incoming log metrics, including the data amount, delivery delays, and number of errors. For diagnostics, there is a [service dashboard](../logs-metrics.md) available with pre-installed charts.

## Basic terms {#terms}

Below are the key terms for setting up and using the system.

{% include [logs-terms](../../../_includes/monium/logs-terms.md) %}

For all terms, see [{#T}](../concepts/glossary.md).