The metric name is written to the `name` label.

All {{ sf-name }} metrics share the `service=serverless-functions` label.

## Histogram metrics {#histogram}

Labels common for all histogram metrics:

| Label | Value |
----|----
| resource_id | [Function](../../../functions/concepts/function.md) ID |
| version_id | [Function version](../../../functions/concepts/function.md#version) ID |

| Metric name<br/>Type, unit | Description<br/>Labels |
--- | ---
| `duration_ms_histogram`<br/>`IGAUGE`, milliseconds | Histogram of distribution of function run time.<br/>`bin` label: Histogram buckets. |

## Function performance metrics {#functions-exec}

Common labels for all function performance metrics:

| Label | Value |
----|----
| resource_id | Function ID |
| version_id | Function version ID |
| resource_type | Resource type. The value is always `function`. |

| Metric name<br/>Type, unit | Description |
--- | ---
| `functions_avg_duration`<br/>`DGAUGE`, milliseconds | Average function execution time. |
| `functions_avg_init_duration`<br/>`DGAUGE`, milliseconds | Average function initialization time. |
| `functions_avg_memory`<br/>`DGAUGE`, bytes | Average memory used by the function. |
| `functions_avg_queue_duration`<br/>`DGAUGE`, milliseconds | Average execution wait time for a queued function. |
| `functions_errors`<br/>`DGAUGE`, errors | Number of errors when executing a function. |
| `functions_finished`<br/>`DGAUGE`, number | Number of completed function executions. |
| `functions_inflight`<br/>`DGAUGE`, invocations | Number of concurrent function invocations. |
| `functions_inits`<br/>`DGAUGE`, initializations | Number of function initializations. |
| `functions_max_duration`<br/>`DGAUGE`, milliseconds | Maximum function execution time. |
| `functions_max_init_duration`<br/>`DGAUGE`, milliseconds | Maximum function initialization time. |
| `functions_max_memory`<br/>`DGAUGE`, bytes | Maximum memory used by the function. |
| `functions_max_queue_duration`<br/>`DGAUGE`, milliseconds | Maximum execution wait time for a queued function. |
| `functions_min_duration`<br/>`DGAUGE`, milliseconds | Minimum function execution time. |
| `functions_min_init_duration`<br/>`DGAUGE`, milliseconds | Minimum function initialization time. |
| `functions_min_memory`<br/>`DGAUGE`, bytes | Minimum memory used by the function. |
| `functions_min_queue_duration`<br/>`DGAUGE`, milliseconds | Minimum execution wait time for a queued function. |
| `functions_started`<br/>`DGAUGE`, number | Number of function runs. |
| `functions_sum_duration`<br/>`DGAUGE`, milliseconds | Total function execution time. |
| `functions_sum_init_duration`<br/>`DGAUGE`, milliseconds | Total function initialization time. |
| `functions_sum_memory`<br/>`DGAUGE`, bytes | Total memory used by the function. |
| `functions_sum_queue_duration`<br/>`DGAUGE`, milliseconds | Total execution wait time for a queued function. |
| `functions_throttles`<br/>`DGAUGE`, number | Number of times the function got run restrictions. |

## Function metrics {#functions}

Common labels for all [function](../../../functions/concepts/function.md) metrics:

| Label | Value |
----|----
| function | Function ID |
| version | Function version ID |

| Metric name<br/>Type, unit | Description<br/>Labels |
--- | ---
| `serverless.functions.errors_per_second`<br/>`DGAUGE`, errors/s | Error frequency when processing function invocations. |
| `serverless.functions.execution_time_milliseconds`<br/>`IGAUGE`, invocations/ms | Histogram of function invocation frequency distribution by request processing time.<br/>Request processing time intervals are presented in the `bin` label. |
| `serverless.functions.finished_per_second`<br/>`DGAUGE`, invocations/s | Frequency of completing function invocation processing. |
| `serverless.functions.inflight`<br/>`DGAUGE`, invocations | Number of concurrent function invocations. |
| `serverless.functions.initializations_per_second`<br/>`DGAUGE`, initializations/s | Frequency of new function instance initializations. |
| `serverless.functions.started_per_second`<br/>`DGAUGE`, invocations/s | Function invocation frequency. |
| `serverless.functions.used_memory_bytes`<br/>`IGAUGE`, invocations/s | Histogram of function invocation frequency distribution by the amount of memory used in bytes.<br/>Intervals of the amount of memory used by the request are presented in the `bin` label. |

## Trigger metrics {#triggers}

Common labels for all [trigger](../../../functions/concepts/trigger/index.md) metrics:

| Label | Value |
----|----
| trigger | Trigger ID |
| type | Trigger activation type: `incoming` or `request`. |

| Metric name<br/>Type, unit | Description<br/>Labels |
--- | ---
| `serverless.triggers.access_error_per_second`<br/>`DGAUGE`, errors/s | Access error frequency when processing function invocations. |
| `serverless.triggers.error_per_second`<br/>`DGAUGE`, errors/s | Error frequency when processing function invocations. |
| `serverless.triggers.execution_time_milliseconds`<br/>`IGAUGE`, invocations/ms | Histogram of function invocation frequency distribution by request processing time.<br/>Request processing time intervals are presented in the `bin` label. |
| `serverless.triggers.inflight`<br/>`DGAUGE`, invocations | Number of concurrent function invocations. |
| `serverless.triggers.read_events_per_second`<br/>`DGAUGE`, number/s | Frequency of events causing a trigger to fire. |

## DB connection metrics {#db-connections}

Common labels for all [DB connection](../../../functions/operations/database-connection.md) metrics:

| Label | Value |
----|----
| mdbproxy | DB connection ID |

| Metric name<br/>Type, unit | Description<br/>Labels |
--- | ---
| `serverless.mdbproxy.connections_inflight`<br/>`DGAUGE`, number | Number of simultaneous active DB connections. |
| `serverless.mdbproxy.query_execution_time_milliseconds`<br/>`IGAUGE`, number/ms | Histogram of DB query execution distribution.<br/>`bin` label: Histogram buckets. |
