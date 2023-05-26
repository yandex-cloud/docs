# Reading metrics

{% include [note-preview](../../../../_includes/monitoring/prometheus-preview.md) %}

You can read metrics written to {{ managed-prometheus-name }} in one of the following ways:

* [Connect](grafana.md) {{ managed-prometheus-name }} to an existing {{ grafana-name }} installation via the [{{ prometheus-name }} data source](https://grafana.com/docs/grafana/latest/datasources/prometheus/) and use {{ promql-name }} as a query language.
* Use the [HTTP API](https://prometheus.io/docs/prometheus/latest/querying/api/#expression-queries) to make requests in the {{ promql-name }} language.
* Set up the current {{ prometheus-name }} installation for metric [reads](remote-read.md) via the [Remote Read](https://prometheus.io/docs/prometheus/latest/configuration/configuration/#remote_read) protocol.

{% include [trademark](../../../../_includes/monitoring/trademark.md) %}
