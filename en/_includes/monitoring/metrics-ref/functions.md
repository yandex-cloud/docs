The `name` label contains the metric name.

All {{ sf-name }} metrics share the `service=serverless-functions` label.

## Histogram metrics {#histogram}

Labels shared by all histogram metrics:

Label | Value
----|----
resource_id | [Function](../../../functions/concepts/function.md) ID
version_id | [Function version](../../../functions/concepts/function.md#version) ID

Metric name<br/>Type, unit | Description<br/>Labels
--- | ---
`duration_ms_histogram`<br/>`IGAUGE`, milliseconds | Distribution histogram for function execution time.<br/>This metric features the `bin` label containing histogram buckets.

## Function performance metrics {#functions-exec}

Labels shared by all function performance metrics:

Label | Value
----|----
resource_id | Function ID
version_id | Function version ID
resource_type | Resource type, which is always `function`.

Metric name<br/>Type, unit | Description
--- | ---
`functions_avg_duration`<br/>`DGAUGE`, milliseconds | Average function execution time
`functions_avg_init_duration`<br/>`DGAUGE`, milliseconds | Average function initialization time
`functions_avg_memory`<br/>`DGAUGE`, bytes | Average memory used by the function
`functions_avg_queue_duration`<br/>`DGAUGE`, milliseconds | Average function queue wait time
`functions_errors`<br/>`DGAUGE`, errors | Number of function execution errors
`functions_finished`<br/>`DGAUGE`, count | Number of completed function runs
`functions_inflight`<br/>`DGAUGE`, invocations | Number of concurrent function invocations
`functions_inits`<br/>`DGAUGE`, initializations | Number of function initializations
`functions_max_duration`<br/>`DGAUGE`, milliseconds | Maximum function execution time
`functions_max_init_duration`<br/>`DGAUGE`, milliseconds | Maximum function initialization time
`functions_max_memory`<br/>`DGAUGE`, bytes | Maximum memory used by the function
`functions_max_queue_duration`<br/>`DGAUGE`, milliseconds | Maximum function queue wait time
`functions_min_duration`<br/>`DGAUGE`, milliseconds | Minimum function execution time
`functions_min_init_duration`<br/>`DGAUGE`, milliseconds | Minimum function initialization time
`functions_min_memory`<br/>`DGAUGE`, bytes | Minimum memory used by the function
`functions_min_queue_duration`<br/>`DGAUGE`, milliseconds | Minimum function queue wait time
`functions_started`<br/>`DGAUGE`, count | Number of function runs
`functions_sum_duration`<br/>`DGAUGE`, milliseconds | Total function execution time
`functions_sum_init_duration`<br/>`DGAUGE`, milliseconds | Total function initialization time
`functions_sum_memory`<br/>`DGAUGE`, bytes | Total memory used by the function
`functions_sum_queue_duration`<br/>`DGAUGE`, milliseconds | Total function queue wait time
`functions_throttles`<br/>`DGAUGE`, count | Number of function invocation throttles

## Function metrics {#functions}

Labels shared by all [function](../../../functions/concepts/function.md) metrics:

Label | Value
----|----
function | Function ID
version | Function version ID

Metric name<br/>Type, unit | Description<br/>Labels
--- | ---
`serverless.functions.errors_per_second`<br/>`DGAUGE`, errors per second | Function invocation error rate
`serverless.functions.execution_time_milliseconds`<br/>`IGAUGE`, invocations per millisecond | Histogram of function invocation rate distribution by request processing time.<br/>Processing time buckets for the request are stored in the `bin` label.
`serverless.functions.finished_per_second`<br/>`DGAUGE`, invocations per second | Function invocation completion rate
`serverless.functions.inflight`<br/>`DGAUGE`, invocations | Number of concurrent function invocations
`serverless.functions.initializations_per_second`<br/>`DGAUGE`, initializations per second | New function instance initialization rate
`serverless.functions.started_per_second`<br/>`DGAUGE`, invocations per second | Function invocation rate
`serverless.functions.used_memory_bytes`<br/>`IGAUGE`, invocations per second | Histogram of function invocation rate distribution by memory usage in bytes.<br/>Memory usage intervals for the request are stored in the `bin` label.

## Trigger metrics {#triggers}

Labels shared by all [trigger](../../../functions/concepts/trigger/index.md) metrics:

Label | Value
----|----
trigger | Trigger ID
type | Trigger activation type, `incoming` or `request`

Metric name<br/>Type, unit | Description<br/>Labels
--- | ---
`serverless.triggers.access_error_per_second`<br/>`DGAUGE`, errors per second | Rate of access errors when processing function invocations
`serverless.triggers.error_per_second`<br/>`DGAUGE`, errors per second | Function invocation error rate
`serverless.triggers.execution_time_milliseconds`<br/>`IGAUGE`, invocations per millisecond | Histogram of function invocation rate distribution by request processing time.<br/>Processing time buckets for the request are stored in the `bin` label.
`serverless.triggers.inflight`<br/>`DGAUGE`, invocations | Number of concurrent function invocations
`serverless.triggers.read_events_per_second`<br/>`DGAUGE`, units per second | Frequency of events causing a trigger to fire.

## DB connection metrics {#db-connections}

Labels shared by all [DB connection](../../../functions/operations/database-connection.md) metrics:

Label | Value
----|----
mdbproxy | DB connection ID

Metric name<br/>Type, unit | Description<br/>Labels
--- | ---
`serverless.mdbproxy.connections_inflight`<br/>`DGAUGE`, count | Number of concurrent active DB connections
`serverless.mdbproxy.query_execution_time_milliseconds`<br/>`IGAUGE`, units per millisecond | Distribution histogram for DB query execution.<br/>This metric features the `bin` label containing histogram buckets.
