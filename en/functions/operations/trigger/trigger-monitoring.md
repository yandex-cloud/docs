# Trigger monitoring

You can monitor triggers using the monitoring tools in your management console. These tools display diagnostic information in the form of charts. [{{ monitoring-name }}](../../../monitoring/) collects metric values and displays them in charts.

The chart update period is 15 seconds.

## Viewing monitoring charts {#charts}

{% list tabs %}

- Management console

    1. In the [management console]({{ link-console-main }}), go to the folder where the trigger is located.
    1. Select **{{ sf-name }}**.
    1. Select a trigger to view its monitoring charts.
    1. Go to the **Monitoring** tab.
    1. The following charts open on the page:
        * **Request latency**: The average time it takes a trigger to process a request.
        * **Function call errors**: The number of errors when calling a function or a container.
        * **Read events**: The number of events causing a trigger to fire.
        * **DLQ access errors**: The number of errors when accessing the [Dead Letter Queue](../../concepts/dlq.md).
        * **Function access errors**: The number of access errors when calling a function or a container.
        * **Send to DLQ errors**: The number of errors when sending messages to the Dead Letter Queue.

    You can select the time interval to display information for: hour, day, week, month, or a custom interval.

{% endlist %}

## Custom metrics {#metrics}

To work with [metrics](../../../monitoring/concepts/data-model.md#metric), [dashboards](../../../monitoring/concepts/visualization/dashboard.md), and [alerts](../../../monitoring/concepts/alerting.md#alert) in {{ monitoring-name }}, click **Open in Monitoring** in the upper right-hand corner.

| Metric name | Units of measure | Entity type | Explanations |
|----|----|----|----|
| `serverless.triggers.`<br/>`inflight` | Invocations | <ul><li>`request`: Function or container invocations.</li></ul> | Number of concurrent function or container invocations. |
| `serverless.triggers.`<br/>`error_per_second` | Errors per second | <ul><li>`request`: Function or container invocations.</li><li>`message_queue`: {{ message-queue-full-name }} requests.</li><li>`dlq`: Dead Letter Queue requests.</li></ul> | Error frequency when processing function or container invocations. |
| `serverless.triggers.`<br/>`access_error_per_second` | Errors per second | <ul><li>`request`: Function or container invocations.</li><li>`message_queue`: {{ message-queue-full-name }} requests.</li><li>`dlq`: Dead Letter Queue requests.</li> | Access error frequency when processing function or container invocations. |
| `serverless.triggers.`<br/>`retry_per_second` | Invocations per second | <ul><li>`request`: Function or container invocations.</li></ul> | The frequency of repeat function or container invocations in the event of an error. |
| `serverless.triggers.`<br/>`read_events_per_second` | Events per second | <ul><li>`incoming`: Events causing any trigger to fire except for a {{ message-queue-full-name }} trigger.</li><li>`message_queue`: Events causing a {{ message-queue-full-name }} trigger to fire.</li></ul> | Frequency of events causing a trigger to fire. |
| `serverless.triggers.`<br/>`execution_time_milliseconds` | Invocations per second | <ul><li>`request`: Function or container invocations.</li></ul> | Function or container invocation frequency distribution histogram by request processing time in milliseconds. Request processing time intervals are shown in the `bin` label. |

### Custom metrics labels {#labels}

| Label name | Possible values | Explanations |
|----|----|----|
| `trigger` | Trigger name | The label contains the name of the trigger that the metric values refer to. |
| `id` | Trigger ID | The label contains the ID of the trigger the metric values refer to. |
| `type` | Entity type | The label contains the entity type the metric values refer to. |
| `bin` | Interval of histogram values | For metrics represented by a histogram, the label value describes the interval of the measured value during which the event occurred. |

