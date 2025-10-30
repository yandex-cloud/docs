---
title: How to read metrics
description: Follow this guide to read metrics.
sourcePath: en/monitoring_includes/operations/prometheus/querying/index.md
---

# Reading metrics

You can read metrics written to {{ managed-prometheus-name }} in one of the following ways:

* Add requests to {{ prometheus-name }} metrics in [{{ monitoring-name }}](monitoring.md).
* [Connect](grafana.md) {{ managed-prometheus-name }} to a current {{ grafana-name }} instance via the [{{ prometheus-name }} data source](https://grafana.com/docs/grafana/latest/datasources/prometheus/) and use {{ promql-name }} as a query language.
* Use the [HTTP API](https://prometheus.io/docs/prometheus/latest/querying/api/#expression-queries) to run {{ promql-name }} queries.
* Set up {{ prometheus-name }} to [read](remote-read.md) metrics using [Remote Read](https://prometheus.io/docs/prometheus/latest/configuration/configuration/#remote_read).

{% include [trademark](../../../../_includes/monitoring/trademark.md) %}
