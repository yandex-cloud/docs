# {{ cloud-logging-name }} overview

{{ monium-logs-name }} is a distributed and highly available system for storing, searching, visualizing, and analyzing logs.

Logs are helpful when you need to get insights into your application and infrastructure performance: detect errors and exceptions, investigate incidents, track changes, and find out the causes of degradation.

{{ monium-logs-name }} is part of {{ monium-name }} and shares its basic components such as the project model, access management, data model, and interface.

With a single platform, you can access both logs and [traces](../traces/index.md) at the same time: use `trace_id` and `span_id` to quickly switch between a request’s log entry and its traces.

{{ monium-name }} only accepts OpenTelemetry data. To send logs, use the OpenTelemetry SDK in the application or any OTel-compatible agent, such as [Otel Collector](../collector/opentelemetry.md) or [Fluent Bit](write/fluent-bit.md).

{{ monium-logs-name }} benefits:

* Fast log search that allows you to diagnose errors in real time ([ad-hoc scenarios](https://en.wikipedia.org/wiki/Ad_hoc_testing)).
* Fault tolerance: data is replicated across data centers.
* Self-monitoring, where the system automatically collects metrics about incoming logs: data size, delivery delays, number of errors, etc. For tracking metrics, there is a service dashboard with pre-installed charts.