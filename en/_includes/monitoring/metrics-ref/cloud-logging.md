The name of the metric is written in the `name` label.

Common labels for all {{ cloud-logging-name }} metrics:

Label | Value
----|----
service | Service ID: `logging`
group | [Log group](../../../logging/concepts/log-group.md) name

Service metrics:

Metric name<br/>Type, units | Description
--- | ---
`group.bytes`<br/>`IGAUGE`, bytes | Size of log data in a log group.
`group.ingest_requests_duration_ms`<br/>`IGAUGE`, ms | Average processing time of log write requests. `bin` label: Histogram buckets.
`group.ingest_requests_duration_ms_count`<br/>`COUNTER`, requests | Total number of log write requests.
`group.ingest_requests_duration_ms_sum`<br/>`COUNTER`, ms | Total processing time of log write requests.
`group.ingest_requests_per_second`<br/>`DGAUGE`, requests per second | Frequency of log write requests per second. `status` label: Status of requests:<ul><li>`OK`</li><li>`ERROR`</li></ul>
`group.ingested_records_per_second`<br/>`DGAUGE`, records per second | Log writing frequency per second. `status` label: Status of requests.
`group.read_records_per_second`<br/>`DGAUGE`, records per second | Log reading frequency per second.
`group.record_save_lag_milliseconds`<br/>`IGAUGE`, ms | Average log writing delay. `bin` label: Histogram buckets.
`group.record_save_lag_milliseconds_count`<br/>`COUNTER`, requests | Total number of log writing delays.
`group.record_save_lag_milliseconds_sum`<br/>`COUNTER`, ms | Total time of log writing delays.
`group.rows`<br/>`IGAUGE`, records | Current number of logs in a group.
`group.saved_records_per_second`<br/>`DGAUGE`, records per second | Number of saved records per second. `level` label: Logging level:<ul><li>`TRACE`</li><li>`DEBUG`</li><li>`INFO`</li><li>`WARN`</li><li>`ERROR`</li><li>`FATAL`</li><li>`LEVEL_UNSPECIFIED`</li><li>`total`</li></ul>
`group.service.ingest_requests_duration_ms`<br/>`IGAUGE`, ms | Average processing time of log write requests at the service level. `bin` label: Histogram buckets.
`group.service.ingest_requests_duration_ms_count`<br/>`COUNTER`, requests | Total number of log write requests at the service level.
`group.service.ingest_requests_duration_ms_sum`<br/>`COUNTER`, ms | Total processing time of log write requests at the service level.
`group.service.ingest_requests_per_second`<br/>`DGAUGE`, requests per second | Frequency of log write requests per second at the service level. `status` label: Status of requests.
`group.service.ingested_records_per_second`<br/>`DGAUGE`, records per second | Log writing frequency per second at the service level. `status` label: Status of requests.
