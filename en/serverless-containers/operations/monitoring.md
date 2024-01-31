# Viewing container monitoring charts

You can monitor containers at runtime using the monitoring tools in your management console. These tools display diagnostic information as charts. Metric values are collected and charts are displayed by [{{ monitoring-name }}](../../monitoring/).

The chart update period is 15 seconds.

## Viewing monitoring charts {#charts}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder with your container.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-containers }}**.
   1. Select the container to view its monitoring charts.
   1. Go to the **{{ ui-key.yacloud.common.monitoring }}** tab.
   1. The following charts will open on the page:
      * **Requests**: Number of container calls
      * **Requests latency**: Average time for a container to process a call.
      * **Errors**: Number of errors generated while a container was processing a call.

      You can select the period to display information for: an hour, three hours, a day, week, month, or a custom interval.

{% endlist %}

## Custom {#metrics} metrics

 To get started with [metrics](../../monitoring/concepts/data-model.md#metric), [dashboards](../../monitoring/concepts/visualization/dashboard.md), and [alerts](../../monitoring/concepts/alerting.md#alert) in {{ monitoring-name }}, in the top-right corner, click **{{ ui-key.yacloud.monitoring.button_open-in-monitoring }}**.

| Metric name | Units | Explanations |
|----|----|----|
| `serverless.containers.inflight` | Invocations | Number of concurrent container invocations |
| `serverless.containers.started_per_second` | Invocations per second | Frequency of container invocations |
| `serverless.containers.finished_per_second` | Invocations per second | Frequency of completing container invocation processing |
| `serverless.containers.errors_per_second` | Errors per second | Frequency of errors when processing container invocations |
| `serverless.containers.initializations_per_second` | Initializations per second | Frequency of initializing new container instances |
| `serverless.containers.execution_time_milliseconds` | Invocations per second | Histogram of the container invocation frequency distribution by request processing time in milliseconds. Request processing time intervals are shown in the `bin` label. |
| `serverless.containers.used_memory_bytes` | Invocations per second | Histogram of the container invocation frequency distribution by RAM used in bytes. Intervals of the RAM used by the request are shown in the `bin` label. |

### Custom metrics labels {#labels}

 For more information about the labels concept, see the [{{ monitoring-full-name }}](../../monitoring/concepts/data-model.md#label)documentation. 

| Label name | Possible values | Explanations |
|----|----|----|
| `container` | Container name | The label contains the name of the container that the metric values pertain to. |
| `revision` | Revision ID | The label contains the container revision ID that the metric values pertain to. |
| `bin` | Interval of histogram values | For metrics represented by a histogram, the label value describes the interval of the measured value during which the event occurred. |
