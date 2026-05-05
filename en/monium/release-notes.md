---
title: '{{ monium-name }} release notes'
description: This section contains the {{ monium-name }} release notes.
---

# {{ monium-name }} release notes

## January – March 2026 {#jan-mar-2026}

* Released {{ monium-name }} for [General Availability](../overview/concepts/launch-stages.md).
* Added support for [Yandex Messenger](https://360.yandex.ru/business/messenger/) in [notification channels](concepts/alerting/notification-channel.md) and escalation policies.

* Updates in [dashboards](visualization/index.md):
  * Added the alert state widget. This widget automatically displays all project alerts for the specified query and adds new alerts as they appear.
  * Supported keyboard shortcuts for basic actions: expanding and collapsing sections, switching to full screen, saving the dashboard, adjusting the time scale and period.
  * Added the ability to set a custom time interval and an auto-update interval for a dashboard.
  * Added the ability to display multiple tooltips on charts at once and to drag them using the cursor.
  * In notebooks, added support for {{ prometheus-name }} charts and the ability to configure charts inside a notebook.
  * You can now change the project when copying a dashboard.
  * When splitting a chart, the default scale is aligned for all charts to highlight data correlations more effectively.

* Updates in [traces](traces/index.md):
  * Added the ability to configure displayed columns in span search and LLM monitoring. You can now display specific attributes in columns to instantly view their values without opening the trace.
  * Added a button for quick navigation to the LLM monitoring interface from a full trace provided it contains spans with LLM app attributes (`gen_ai.*`).
  * Enabled copying any span attribute value with a single click: the copy button appears when you hover over an attribute.
  * Added the ability to copy and share links to specific spans in LLM monitoring.
  * Optimized performance of the LLM monitoring interface when working with large traces.


## October – December 2025 {#oct-dec-2025}

* {{ monium-name }} is available at the [Technical Preview](../overview/concepts/launch-stages.md) stage. To get access, contact [support]({{ link-console-support }}).
* Implemented collection, aggregation, search, and storage of distributed [traces](traces/index.md) as per the [OpenTelemetry (OTLP)](https://opentelemetry.io/docs/) standard. This allows tracing the entire request path across all microservices and systems for simplified troubleshooting and performance analysis.
* Consolidated telemetry tools, such as metrics, logs, and traces, in a single interface. This enables you to explore data without switching between services, speeding up root cause analysis. It is also convenient for end-to-end diagnostics, so you can quickly navigate and group telemetry types for targeted and detailed analysis.
* Added the ability to track service reliability over specific time periods using service level objectives ([SLOs](slo/index.md)).
* Supported telemetry collection as per OTLP.
* When migrating to {{ monium-name }}, your data, dashboards, and alerts will be automatically transferred, eliminating the need for manual migration and setup.
