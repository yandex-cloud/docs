The name of the metric is written in the `name` label.

All [{{ monitoring-name }}](../../../monitoring/) metrics share the `service=monitoring` label.

| Metric name<br/>Type, units of measurement | Description<br/>Labels |
| -------------------------------------- | ------------------ |
| `api.http.requests_count_per_second`<br/>`RATE`, requests/s | Number of {{ monitoring-full-name }} API calls per second. <br/>Labels:<br/>- *method*: The {{ monitoring-full-name }} API method called. For example, `/v2/prometheusMetrics`. |
| `api.http.errors_count_per_second`, <br/>`RATE`, requests/s | Number of failed {{ monitoring-full-name }} API calls per second. <br/>Labels:<br/>- *method*: The {{ monitoring-full-name }} API method called. For example, `/v2/prometheusMetrics`. |

