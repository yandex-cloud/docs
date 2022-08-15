# Monitoring

{% if audience == "external" %} You can monitor containers at runtime using the monitoring tools in your management console. These tools display diagnostic information in the form of charts. Cluster metric values are collected and charts are displayed by [{{ monitoring-name }}](../../monitoring/). {% endif %}

The chart update period is 15 seconds.

## Viewing monitoring charts {#charts}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder with your container.
   1. Select **{{ serverless-containers-name }}**.
   1. Select a container to view its monitoring charts.
   1. Go to the **Monitoring** tab.
   1. The following charts open on the page:
      * **Requests**: number of container calls.
      * **Requests latency**: average time for a container to process a call.
      * **Errors**: number of errors generated while a container was processing a call.

      You can select the period to display information for: an hour, three hours, a day, week, month, or a custom interval.

{% endlist %}

## Custom {#metrics} metrics

{% if audience == "external" %} To proceed to working with [metrics](../../monitoring/concepts/data-model.md#metric), [dashboards](../../monitoring/concepts/visualization/dashboard.md), and [alerts](../../monitoring/concepts/alerting.md#alert), in {{ monitoring-name }}, in the upper-right corner, click **Open in Monitoring**. {% endif %}

| Metric name | Units | Explanations |
|----|----|----|
| `serverless.containers.inflight` | Invocations | Number of concurrent container invocations. |
| `serverless.containers.started_per_second` | Calls per second | Frequency of container invocations. |
| `serverless.containers.finished_per_second` | Calls per second | Frequency of completing container invocation processing. |
| `serverless.containers.errors_per_second` | Errors per second | Frequency of errors when processing container invocations. |
| `serverless.containers.initializations_per_second` | Initializations per second | Frequency of initializing new container instances. |
| `serverless.containers.execution_time_milliseconds` | Calls per second | Histogram of the container invocation frequency distribution by request processing time in milliseconds. Request processing time intervals are shown in the `bin` label. |
| `serverless.containers.used_memory_bytes` | Calls per second | Histogram of the container invocation frequency distribution by RAM used in bytes. Intervals of the RAM used by the request are shown in the `bin` label. |

### Custom metrics labels {#labels}

{% if audience == "external" %} For more information about the labels concept, see the [{{ monitoring-full-name }}](../../monitoring/concepts/data-model.md#label)documentation. {% endif %}

| Label name | Possible values | Explanations |
|----|----|----|
| `container` | Container name | The label contains the name of the container that the metric values pertain to. |
| `revision` | Revision ID | The label contains the container revision ID that the metric values pertain to |
| `bin` | Interval of histogram values | For metrics represented by a histogram, the label value describes the interval of the measured value during which the event occurred. |