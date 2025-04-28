The `name` label contains the metric name.

All [{{ monitoring-name }}](../../../monitoring/) metrics share the `service=monitoring` label. Metrics may come from the {{ monitoring-short-name }} API or the {{ managed-prometheus-name }} API.

## {{ monitoring-short-name }} API

Metric name<br/>Type, unit | Description<br/>Labels
-------------------------------------- | ------------------
`api.http.requests_count_per_second`<br/>`RATE`, requests per second | Number of {{ monitoring-full-name }} API requests per second. <br/>Labels:<br/>- *method*: {{ monitoring-full-name }} API method called, e.g., `/v2/prometheusMetrics`.
`api.http.errors_count_per_second`, <br/>`RATE`, requests per second | Number of failed {{ monitoring-full-name }} API requests per second. <br/>Labels:<br/>- *method*: {{ monitoring-full-name }} API method called, e.g., `/v2/prometheusMetrics`.

## {{ managed-prometheus-name }} API

Labels shared by all metrics:

Label | Value
--- | ---
method | {{ managed-prometheus-name }} API method called, e.g., `/api/v1/write`.
workspace_id | {{ managed-prometheus-name }} workspace being queried

Metrics:

Metric name<br/>Type, unit | Description<br/>Labels
-------------------------------------- | ------------------
`api.prometheus.requests_count_per_second`, <br/>`RATE`, requests per second | Number of {{ managed-prometheus-name }} API requests per second
`api.prometheus.errors_count_per_second`, <br/>`RATE`, requests per second | Number of failed {{ managed-prometheus-name }} API requests per second
`api.prometheus.statuses_per_second`, <br/>`RATE`, requests per second | Number of status codes returned by the {{ managed-prometheus-name }} API per second.<br/>This metric features the *code* additional label containing the HTTP status code, e.g., `200`.