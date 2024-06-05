The metric name is written in the `name` label.

All [{{ monitoring-name }}](../../../monitoring/) metrics share the `service=monitoring` label. Metrics may come from the {{ monitoring-short-name }} API or the {{ managed-prometheus-name }} API.

## {{ monitoring-short-name }} API

| Metric name<br/>Type, unit | Description<br/>Labels |
-------------------------------------- | ------------------
| `api.http.requests_count_per_second`<br/>`RATE`, requests/s | Number of {{ monitoring-full-name }} API requests per second. <br/>Labels:<br/>-*method*: {{ monitoring-full-name }} API method called, e.g., `/v2/prometheusMetrics`. |
| `api.http.errors_count_per_second`, <br/>`RATE`, requests/s | Number of failed {{ monitoring-full-name }} API requests per second. <br/>Labels:<br/>-*method*: {{ monitoring-full-name }} API method called, e.g., `/v2/prometheusMetrics`. |

## {{ managed-prometheus-name }} API

Common labels for all metrics:

| Label | Value |
--- | ---
| method | {{ managed-prometheus-name }} API method called, e.g., `/api/v1/write`. |
| workspace_id | {{ managed-prometheus-name }} workspace whose data is requested. |

Metrics:

| Metric name<br/>Type, unit | Description<br/>Labels |
-------------------------------------- | ------------------
| `api.prometheus.requests_count_per_second`, <br/>`RATE`, requests/s | Number of {{ managed-prometheus-name }} API requests per second. |
| `api.prometheus.errors_count_per_second`, <br/>`RATE`, requests/s | Number of failed {{ managed-prometheus-name }} API requests per second. |
| `api.prometheus.statuses_per_second`, <br/>`RATE`, requests/s | Statuses of running the {{ managed-prometheus-name }} API requests per second.<br/>The *code* additional label represents the HTTP status code, e.g., `200`. |