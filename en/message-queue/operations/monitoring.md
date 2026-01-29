# Monitoring processes in queues

You can monitor the handling processes for messages in queues using monitoring tools in the management console. These tools display diagnostic information as charts.

To view this information:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder the message queue belongs to.
  1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_message-queue }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/display-pulse.svg) **{{ ui-key.yacloud.common.monitoring }}**.

  Sections with charts appear on the page.

{% endlist %}

## Sending messages {#send}

**Sent messages stats** contains charts with information about sending messages:

* **Sent messages, count**: Number of messages sent to the queue per unit of time.

* **Sent messages, size**: The total size of messages sent to the queue per unit of time (in bytes).

* **SendMessage duration**: [SendMessage](../api-ref/message/SendMessage.md) request execution time.

  {% include [ymq-monitoring-query-duration.md](../../_includes/message-queue/ymq-monitoring-query-duration.md) %}

* **SendMessageBatch duration**: [SendMessageBatch](../api-ref/message/SendMessageBatch.md) request execution time.

  {% include [ymq-monitoring-query-duration.md](../../_includes/message-queue/ymq-monitoring-query-duration.md) %}

* **SendMessage errors**: Number of `SendMessage` and `SendMessageBatch` request execution errors.

## Receiving messages {#receive}

**Received messages & processing stats** contains charts with information about receiving and processing messages:

* **Received messages, size**: The total size of messages received from the queue per unit of time (in bytes).

* **Received messages, count**: Number of messages received from the queue per unit of time.

* **Messages in flight, count**: Number of messages received by recipients but not deleted from the queue (that are still within the [visibility timeout](../concepts/visibility-timeout.md) window).

* **ReceiveMessages requests**: Total number of [ReceiveMessage](../api-ref/message/ReceiveMessage) requests and number of requests with empty responses.

  An empty response to a request means that no messages available for reading have appeared within the specified waiting time (the `WaitTimeSeconds` attribute).
    
* **ReceiveMessages duration**: `ReceiveMessage` request execution time.

  {% include [ymq-monitoring-query-duration.md](../../_includes/message-queue/ymq-monitoring-query-duration.md) %}

* **ReceiveMessage errors**: Number of `ReceiveMessage` request execution errors.

* **Message processing on client duration**: Message processing time spent by the recipient.
      
  {% include [ymq-monitoring-message-duration.md](../../_includes/message-queue/ymq-monitoring-message-duration.md) %}

* **Receive attempts per message, count**: Number of registered attempts to receive a message.

  The value increases if a message was received by the recipient but returned to the queue after the [visibility timeout](../concepts/visibility-timeout.md) expired. The lines on the chart correspond to the number of receive attempts:
  * 0-1
  * 2
  * 3-5
  * More than 5

## Deleting messages {#delete}

**Delete messages stats** contains charts with information about deleting messages:
    
* **Deleted messages, count**: Number of messages deleted from the queue in a unit of time using the [DeleteMessage](../api-ref/message/DeleteMessage) or [DeleteMessageBatch](../api-ref/message/DeleteMessageBatch) method.
* **DeleteMessage duration**: `DeleteMessage` request execution time.

  {% include [ymq-monitoring-query-duration.md](../../_includes/message-queue/ymq-monitoring-query-duration.md) %}

* **DeleteMessageBatch duration**: `DeleteMessageBatch` request execution time.

  {% include [ymq-monitoring-query-duration.md](../../_includes/message-queue/ymq-monitoring-query-duration.md) %}

* **DeleteMessage errors**: Number of `DeleteMessage` and `DeleteMessageBatch` request execution errors.

* **Purged messages, count**: Number of messages purged from the queue in a unit of time using the [PurgeQueue](../api-ref/queue/PurgeQueue) method.

## Overall queue metrics {#queue}

**Overall queue stats** contains charts with general information about processes in queues:

* **Messages in queue, count** (metric name: `queue.messages.stored_count`): Number of messages currently enqueued. Measured in `pcs` (pieces).

* **Age of oldest message in queue** (metric name: `queue.messages.oldest_age_milliseconds`): Retention time of the oldest message in the queue. The metric name is deprecated, and the `milliseconds` substring does not align with the current units of measure. Currently, the metric is measured in seconds (`s`).

* **Message reside duration** (metric names: `p99` for the 99th percentile, `p95` for the 95th percentile, `p90` for the 90th percentile, `p50` for the 50th percentile): Enqueued message processing time. Measured in `ms` (milliseconds).
      
  {% include [ymq-monitoring-message-duration.md](../../_includes/message-queue/ymq-monitoring-message-duration.md) %}

#### See also {#see-also}

[{#T}](../metrics.md)