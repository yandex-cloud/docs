---
title: '{{ monium-name }} release notes'
description: This section contains the {{ monium-name }} release notes.
---

# {{ monium-name }} release notes

## October – December 2025 {#oct-dec-2025}

* {{ monium-name }} is available at the [Technical Preview](../overview/concepts/launch-stages.md) stage. To get access, contact [support]({{ link-console-support }}).
* Implemented collection, aggregation, search, and storage of distributed [traces](traces/index.md) as per the [OpenTelemetry (OTLP)](https://opentelemetry.io/docs/) standard. This allows tracing the entire request path across all microservices and systems for simplified troubleshooting and performance analysis.
* Consolidated telemetry tools, such as metrics, logs, and traces, in a single interface. This enables you to explore data without switching between services, speeding up root cause analysis. It is also convenient for end-to-end diagnostics, so you can quickly navigate and group telemetry types for targeted and detailed analysis.
* Added the ability to track service reliability over specific time periods using service level objectives ([SLOs](slo/index.md)).
* Supported telemetry collection as per OTLP.
* When migrating to {{ monium-name }}, your data, dashboards, and alerts will be automatically transferred, eliminating the need for manual migration and setup.
