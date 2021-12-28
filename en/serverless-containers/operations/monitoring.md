# Monitoring

You can monitor containers at runtime using the monitoring tools in your management console. These tools display diagnostic information in the form of charts. It is [{{ monitoring-name }}](../../monitoring/) that collects metric values and displays them in charts.

The chart update period is 15 seconds.

## Viewing monitoring charts {#charts}

1. In the [management console]({{ link-console-main }}), go to the folder where the container is located.
1. Open **{{ serverless-containers-name }}**.
1. Select a container to view its monitoring charts.
1. Go to the **Monitoring** tab.
1. The following charts open on the page:
	* **Requests**: number of container calls.
	* **Requests latency**: average time for a container to process a call.
	* **Errors**: number of errors generated while a container was processing a call.

	You can select the time period to display information for: hour, day, week, month, or a custom interval.

## Custom metrics {#metrics} 

To work with [metrics](../../monitoring/concepts/data-model.md#metric), [dashboards](../../monitoring/concepts/visualization/dashboard.md) and [alerts](../../monitoring/concepts/alerting.md#alert) in {{ monitoring-name }}, click **Open in Monitoring** in the upper right-hand corner.

| Metric name | Units of measure | Explanations |
|----|----|----|
| `serverless.containers.inflight` | Invocations | Number of concurrent container invocations. |
| `serverless.containers.started_per_second` | Invocations per second | Frequency of container invocations. |
| `serverless.containers.finished_per_second` | Invocations per second | Frequency of completing container invocation processing. |
| `serverless.containers.errors_per_second` | Errors per second | Frequency of errors when processing container invocations. |
| `serverless.containers.initializations_per_second` | Initializations per second | Frequency of initializing new container instances. |
| `serverless.containers.execution_time_milliseconds` | Invocations per second | Histogram of the container invocation frequency distribution by request processing time in milliseconds. Request processing time intervals are shown in the `bin` label. |
| `serverless.containers.used_memory_bytes` | Invocations per second | Histogram of the container invocation frequency distribution by RAM used in bytes. Intervals of the RAM used by the request are shown in the `bin` label. |

### Custom metrics labels {#labels}

For more information about the labels concept, see the [{{ monitoring-full-name }} documentation](../../monitoring/concepts/data-model.md#label).
 
| Label name | Possible values | Explanations |
|----|----|----|
| `container` | Container name | The label contains the name of the container that the metric values pertain to. |
| `revision` | Revision ID | The label contains the container revision ID that the metric values pertain to |
| `bin` | Interval of histogram values | For metrics represented by a histogram, the label value describes the interval of the measured value during which the event occurred. |

