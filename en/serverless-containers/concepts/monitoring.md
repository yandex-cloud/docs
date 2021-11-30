# Monitoring

The {{ serverless-containers-name }} service helps monitor container health and create [alerts](../../monitoring/concepts/alerting.md#alert) based on metrics in [{{ monitoring-full-name }}](../../monitoring/).

## Custom {#metrics} metrics

| Metric name | Units of measure | Explanations |
| ---- | ---- | ---- |
| serverless.containers.inflight | Invocations | Number of concurrent container invocations. |
| serverless.containers.started_per_second | Invocations per second | Frequency of container invocations. |
| serverless.containers.finished_per_second | Invocations per second | Frequency of completing container invocation processing. |
| serverless.containers.errors_per_second | Errors per second | Frequency of errors when processing container invocations. |
| serverless.containers.initializations_per_second | Initializations per second | Frequency of initializing new container instances. |
| serverless.containers.execution_time_milliseconds | Invocations per second | Histogram of the container invocation frequency distribution by request processing time in milliseconds. Request processing time intervals are shown in the `bin` label. |
| serverless.containers.used_memory_bytes | Invocations per second | Histogram of the container invocation frequency distribution by RAM used in bytes. Intervals of the RAM used by the request are shown in the `bin` label. |

## Custom metrics labels {#labels}

For more information about the labels concept, see the [{{ monitoring-full-name }} documentation](../../monitoring/concepts/data-model.md#label).

| Label name | Possible values | Explanations |
| ---- | ---- | ---- |
| `container` | Container name | The label contains the name of the container that the metric values pertain to. |
| `revision` | Revision ID | The label contains the container revision ID that the metric values pertain to |
| `bin` | Interval of histogram values | For metrics represented by a histogram, the label value describes the interval of the measured value during which the event occurred. |

