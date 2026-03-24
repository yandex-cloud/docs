---
title: '{{ monium-name }}. Visualization'
description: '{{ monium-name }} allows presenting telemetry data as charts on dashboards.'
---

# Visualizing telemetry data

Visualization tools present metrics and logs on charts and diagrams to help you analyze the system's condition and diagnose issues.

Visualization addresses three primary objectives:

* Current state monitoring: Real-time tracking of key indicators.
* Incident analysis: Searching for causes of failures through correlation of data from multiple sources.
* Resource planning: Evaluating consumption trends and forecasting loads.

Visualization tools:

* [Dashboards](../operations/dashboard/create.md) combine multiple widgets on the same screen for integrated data presentation.
* Overview page gives a real-time view of the data. There is an overview page for each data type: [metrics](../operations/metric/metric-explorer.md), [logs](../logs/logs-explorer.md), and [traces](../traces/operations/traces-explorer.md).

You can filter chart data by time intervals, services, environments, etc. Also, you can also break the data down by specific attributes for a more detailed analysis.

You can create dashboards manually or use ready-made ones that come with the {{ yandex-cloud }} services.

## See also {#see-also}

* [Data model](../concepts/data-model.md)
* [Query language](../concepts/querying.md)
* [Query string](../concepts/visualization/query-string.md)