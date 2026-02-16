The metric name goes into the `name` label.

## Container metrics {#containers-metrics}

Common labels for all [container](../../../serverless-containers/concepts/container.md) metrics:

Label | Value
----|----
container | Container ID
revision | [Container revision](../../../serverless-containers/concepts/container.md#revision) ID
service | Service label, always `serverless-containers`

Service metrics:

Name<br/>Type, units | Description<br/>Label
----|----
`serverless.containers.errors_per_second`<br/>`DGAUGE`, errors per second | Frequency of errors when processing container invocations.
`serverless.containers.execution_time_milliseconds`<br/>`IGAUGE`, invocations per millisecond | Histogram of the container invocation frequency distribution by request processing time.</br>This metric features the `bin` label containing histogram buckets.
`serverless.containers.execution_time_milliseconds_count`<br/>`COUNTER`, invocations | Total number of container invocations included in the request processing time histogram.
`serverless.containers.execution_time_milliseconds_sum`<br/>`COUNTER`, milliseconds | Total processing time of all container invocations included in the histogram.
`serverless.containers.finished_per_second`<br/>`DGAUGE`, invocations per second | Frequency of completing container invocation processing.
`serverless.containers.inflight`<br/>`DGAUGE`, invocations | Number of concurrent container invocations.
`serverless.containers.started_per_second`<br/>`DGAUGE`, invocations per second | Frequency of container invocations.
`serverless.containers.used_memory_bytes`<br/>`IGAUGE`, bytes | Histogram of the container invocation frequency distribution by RAM used.</br>This metric features the `bin` label containing histogram buckets.
`serverless.containers.used_memory_bytes_count`<br/>`COUNTER`, invocations | Total number of container invocations included in the RAM usage histogram.
`serverless.containers.used_memory_bytes_sum`<br/>`COUNTER`, bytes | Total RAM used by all container invocations included in the histogram.

## Trigger metrics {#triggers-metrics}

Labels shared by all [trigger](../../../serverless-containers/concepts/trigger/index.md) metrics:

Label | Value
----|----
trigger | Trigger ID
type | Entity type.
service | Service label, always `serverless-functions`

Metric name<br/>Type, unit | Entity type. | Description<br/>Labels
--- | --- | ---
`serverless.triggers.access_error_per_second`<br/>`DGAUGE`, errors per second | <ul><li>`request`: Container invocations.</li><li>`message_queue`: Accesses to {{ message-queue-full-name }}.</li><li>`dlq`: Accesses the dead letter queue.</li></ul> | Access error frequency when processing container invocations.
`serverless.triggers.error_per_second`<br/>`DGAUGE`, errors per second | <ul><li>`request`: Container invocations.</li><li>`message_queue`: Accesses to {{ message-queue-full-name }}.</li><li>`dlq`: Accesses the dead letter queue.</li></ul> | Frequency of errors when processing container invocations.
`serverless.triggers.execution_time_milliseconds`<br/>`IGAUGE`, invocations per millisecond | <ul><li>`request`: Container invocations.</li></ul> | Histogram of container invocation rate distribution by request processing time.<br/>Request processing intervals are stored in the `bin` label.
`serverless.triggers.inflight`<br/>`DGAUGE`, invocations | <ul><li>`request`: Container invocations.</li></ul> | Number of concurrent container invocations.
`serverless.triggers.read_events_per_second`<br/>`DGAUGE`, units per second | <ul><li>`incoming`: Events causing any trigger to fire except for a trigger for {{ message-queue-full-name }}.</li><li>`message_queue`: Events causing a trigger for {{ message-queue-full-name }} to fire.</li></ul> | Frequency of events causing a trigger to fire.
