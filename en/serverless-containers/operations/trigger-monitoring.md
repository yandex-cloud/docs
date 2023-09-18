---
title: "Viewing monitoring charts in {{ serverless-containers-full-name }}"
description: "You can view a monitoring chart in {{ serverless-containers-full-name }} using the management console. To do this, select {{ serverless-containers-name }} and click the trigger to view monitoring charts for."
---

# Viewing trigger monitoring charts in {{ serverless-containers-name }}

 You can monitor triggers using the monitoring tools in your management console. These tools display diagnostic information in the form of charts. Metric values are collected and charts are displayed by [{{ monitoring-name }}](../../monitoring/). 

The chart update period is 15 seconds.

## Viewing monitoring charts {#charts}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder containing your trigger.

   1. Select **{{ serverless-containers-name }}**.

   1. Select a trigger to view its monitoring charts.

   1. Go to the **Monitoring** tab.

   1. The following charts open on the page:

      * **Request latency**: The average time it takes a trigger to process a request.
      * **Read events**: The number of events causing a trigger to fire.
      * **Function access errors**: The number of access errors when calling a container.
      * **Function call errors**: The number of errors when calling a container.
    
            
      * **DLQ access errors**: The number of errors when accessing the [Dead Letter Queue](../../serverless-containers/concepts/dlq.md).
      * **Send to DLQ errors**: The number of errors when sending messages to the Dead Letter Queue.
    

   You can select the time period to display information for: hour, day, week, month, or a custom interval.

{% endlist %}

## Custom {#metrics} metrics

 To proceed to working with [metrics](../../monitoring/concepts/data-model.md#metric), [dashboards](../../monitoring/concepts/visualization/dashboard.md), and [alerts](../../monitoring/concepts/alerting.md#alert), in {{ monitoring-name }}, in the upper-right corner, click **Open in Monitoring**. 

| Metric name | Units | Entity type | Explanations |
|----|----|----|----|
| `serverless.triggers.`<br/>`inflight` | Invocations | <ul><li>`request`: Container calls.</li></ul> | Number of concurrent container invocations. |
| `serverless.triggers.`<br/>`error_per_second` | Errors per second | <ul><li>`request`: Container calls.</li><li>`message_queue`: Accesses the {{ message-queue-full-name }}.</li><li>`dlq`: Accesses the Dead Letter Queue.</li></ul> | Frequency of errors when processing container invocations. |
| `serverless.triggers.`<br/>`access_error_per_second` | Errors per second | <ul><li>`request`: Container calls.</li><li>`message_queue`: Accesses the {{ message-queue-full-name }}.</li><li>`dlq`: Accesses the Dead Letter Queue.</li></ul> | Access error frequency when processing container calls. |
| `serverless.triggers.`<br/>`retry_per_second` | Calls per second | <ul><li>`request`: Container calls.</li></ul> | The frequency of repeat container calls in the event of an error. |
| `serverless.triggers.`<br/>`read_events_per_second` | Events per second | <ul><li>`incoming`: Events causing any trigger to fire except for a {{ message-queue-full-name }}.</li><li>`message_queue`: Events causing the trigger to fire for {{ message-queue-full-name }}.</li></ul> | Frequency of events causing a trigger to fire. |
| `serverless.triggers.`<br/>`execution_time_milliseconds` | Calls per second | <ul><li>`request`: Container calls.</li></ul> | Histogram of the container invocation frequency distribution by request processing time in milliseconds. Request processing time intervals are shown in the `bin` label. |

### Custom metrics labels {#labels}

| Label name | Possible values | Explanations |
|----|----|----|
| `trigger` | Trigger name | The label contains the name of the trigger that the metric values refer to. |
| `id` | Trigger ID | The label contains the ID of the trigger the metric values refer to. |
| `type` | Entity type | The label contains the entity type the metric values refer to. |
| `bin` | Interval of histogram values | For metrics represented by a histogram, the label value describes the interval of the measured value during which the event occurred. |
