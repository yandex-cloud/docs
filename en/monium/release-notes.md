---
title: '{{ monium-name }} release notes'
description: This section contains the {{ monium-name }} release notes.
---

# {{ monium-name }} release notes

## April – June 2026 {#apr-jun-2026}

* Updated navigation in the [{{ monium-name }}]({{ link-monium }}) interface, with items now grouped by thematic sections.
* Added the ability to view and manage resource [quotas](concepts/limits.md) for a project.

* Updates in [logs](logs/quickstart.md):
  * Added the ability to create [metrics from logs](logs/aggregates.md) directly in the interface without writing code. Previews on historical data, automatic value grouping, and the `uniqueNewFound` aggregation function are available during creation. This function allows you to find unique records that have not appeared in the last 48 hours.
  * Improved the [Errors and Statistics](logs/errors-and-stats.md) section in the log interface. In _Compare mode_, you can compare two time periods or two data slices by attribute values. The _New_ filter shows patterns that appeared in the current period but were absent in the baseline.
  * Added a [migration guide](logs/logging-migration.md) from {{ cloud-logging-name }} to the {{ monium-name }} platform.
  * Updated [log limits](logs/limits.md).

* Updates in [SLOs](slo/index.md):
  * Added the _Burn rate_ metric, i.e., the rate of error budget consumption over standard time windows (5m, 30m, 1h, 2h, 6h, 24h, 72h).
  * Added an alert for the burn rate metric that notifies about high error budget consumption rates.
  * Added the ability to create individual SLOs for specific resources from a common selector.

* Updates in alerts:
  * [Calls and escalations](concepts/alerting/escalations.md) have entered the [General Availability](../overview/concepts/launch-stages.md) stage. Now you can configure automatic calls and alert escalations in notification channels.
  * Starting June 18, 2026, [alert calculations](pricing.md) have become a paid feature. The cost depends on the number of alert calculations per month.
  * Added composite alerts, which send a single signal about an issue when multiple alerts are triggered simultaneously.
  * Added dependent checks to mutes. They disable notifications from one set of alerts when another set is triggered.
  * Improved applying of no data policies: the alert continues to be calculated when data is missing on individual metrics and only transitions to the `No data` status when data is missing on all metrics.
  * Added the ability to include links to dashboards and external resources in alert notifications.

* Updates in [traces](traces/index.md):
  * In span search, graphs are now displayed for these RED metrics: the number of spans by status and their execution duration.
  * Added built-in support for pipes (`|`) to the trace query language: autocompletion for attributes and values now works even with conditions using pipes.
  * Improved detection of AI agent spans: all such spans are now included in LLM monitoring search results, and the span tree is displayed more accurately.
  * The `>` and `<` operators now work for any numeric attributes, not only `duration`.
  * Added viewing of user and agent images in LLM monitoring spans.
  * Improved display of spans with tool calls in LLM monitoring search: now it shows tool name, input, and output data.

* Updates in [dashboards](visualization/index.md):
  * Added graph snapshots: full copies of data with a permanent link, preserving the widget configuration and loaded data.
  * Added parameter types (query, value set, text field) and dependencies between parameters.
  * Added a change history with the ability to compare and restore a selected dashboard version.
  * Added a **Recently deleted** tab for viewing and restoring deleted dashboards within 30 days after deletion.
  * Added the ability to disable highlighting of incomplete data in graph settings.
  * In modifications, added settings to hide lines on the graph, in tooltips, or in the legend.
  * Added the ability to display a heat map of logs over metric graphs for quick anomaly analysis.
  * Added the ability to save time intervals for the timeline.


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
  * Added the ability to configure displayed columns in span search and LLM monitoring. You can now display the attributes you need in the columns to see their values immediately, without opening the trace.
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
