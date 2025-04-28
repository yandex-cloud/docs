The `name` label contains the metric name.

Labels shared by all {{ cloud-logging-name }} metrics:

Label | Value
----|----
service | Service ID: `logging`
group | [Log group](../../../logging/concepts/log-group.md) name

Service metrics:

Metric name<br/>Type, unit | Description
--- | ---
`group.bytes`<br/>`IGAUGE`, bytes | Size of log data in a log group
`group.ingest_requests_duration_ms`<br/>`IGAUGE`, milliseconds | Average processing time of log write requests. This metric features the `bin` label containing histogram buckets.
`group.ingest_requests_duration_ms_count`<br/>`COUNTER`, requests | Total log write requests
`group.ingest_requests_duration_ms_sum`<br/>`COUNTER`, milliseconds | Total processing time of log write requests
`group.ingest_requests_per_second`<br/>`DGAUGE`, requests per second | Number of log write requests per second. This metric features the `status` label containing the request status:<ul><li>`OK`</li><li>`ERROR`</li></ul>
`group.ingested_records_per_second`<br/>`DGAUGE`, records per second | Log write frequency (per second) This metric features the `status` label containing the request status.
`group.read_records_per_second`<br/>`DGAUGE`, records per second | Log read frequency (per second)
`group.record_save_lag_milliseconds`<br/>`IGAUGE`, milliseconds | Average log write latency. This metric features the `bin` label containing histogram buckets.
`group.record_save_lag_milliseconds_count`<br/>`COUNTER`, requests | Total log write latencies
`group.record_save_lag_milliseconds_sum`<br/>`COUNTER`, milliseconds | Total log write latency time
`group.rows`<br/>`IGAUGE`, records | Current number of logs in a group
`group.saved_records_per_second`<br/>`DGAUGE`, records per second | Number of saved records per second. This metric features the `level` label containing the logging level:<ul><li>`TRACE`</li><li>`DEBUG`</li><li>`INFO`</li><li>`WARN`</li><li>`ERROR`</li><li>`FATAL`</li><li>`LEVEL_UNSPECIFIED`</li><li>`total`</li></ul>
`group.service.ingest_requests_duration_ms`<br/>`IGAUGE`, milliseconds | Average processing time of log write requests at the service level. This metric features the `bin` label containing histogram buckets.
`group.service.ingest_requests_duration_ms_count`<br/>`COUNTER`, requests | Total log write requests at the service level
`group.service.ingest_requests_duration_ms_sum`<br/>`COUNTER`, milliseconds | Total processing time of log write requests at the service level
`group.service.ingest_requests_per_second`<br/>`DGAUGE`, requests per second | Frequency of log write requests (per second) at the service level. This metric features the `status` label containing the request status.
`group.service.ingested_records_per_second`<br/>`DGAUGE`, records per second | Log write frequency (per second) at the service level. This metric features the `status` label containing the request status.
