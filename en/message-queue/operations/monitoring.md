# Monitoring processes in queues

You can monitor the handling processes for messages in queues using monitoring tools in the management console. These tools display diagnostic information in the form of charts.

To view this information:

1. Go to the folder page and select **{{ message-queue-name }}**.
1. Select the **Monitoring** tab.

Sections with charts appear on the page.

## Sending messages {#send}

**Sent messages stats** contains charts with information about sending messages:

* **Sent messages, count**: The number of messages sent to the queue per unit of time.

* **Sent messages, size**: The total size of messages sent to the queue per unit of time (in bytes).

* **SendMessage duration**: The time it takes to execute a [SendMessage](../api-ref/message/SendMessage) request.

  {% include [ymq-monitoring-query-duration.md](../../_includes/message-queue/ymq-monitoring-query-duration.md) %}

* **SendMessageBatch duration**: The time it takes to execute a [SendMesssageBatch](../api-ref/message/SendMessageBatch) request.

  {% include [ymq-monitoring-query-duration.md](../../_includes/message-queue/ymq-monitoring-query-duration.md) %}

* **SendMessage errors**: The number of errors while executing `SendMessage` and `SendMessageBatch` requests.

## Receiving messages {#receive}

**Received messages & processing stats** contains charts with information about receiving and processing messages:

* **Received messages, count**: The number of messages received from the queue per unit of time.

* **Received messages, size**: The total size of messages received from the queue per unit of time (in bytes).

* **Messages in flight, count**: The number of messages that have been received by consumers, but not yet deleted from the queue (haven't reached the end of their [visibility timeout](../concepts/visibility-timeout.md)).

* **ReceiveMessages requests**: The total number of [ReceiveMessage](../api-ref/message/ReceiveMessage) requests and the number of requests with an empty response.

  An empty response to a request indicates that there were no messages available for reading within the specified waiting time (the `WaitTimeSeconds` attribute).

* **ReceiveMessages duration**: The time it takes to execute a `ReceiveMessage` request.

  {% include [ymq-monitoring-query-duration.md](../../_includes/message-queue/ymq-monitoring-query-duration.md) %}

* **ReceiveMessage errors**: The number of errors while executing `ReceiveMessage` requests.

* **Message processing on client duration**: Time the consumer spent handling messages.

  {% include [ymq-monitoring-message-duration.md](../../_includes/message-queue/ymq-monitoring-message-duration.md) %}

* **Receive attempts per message, count**: The number of registered attempts to receive a message.

  The value increases if a message was received by the consumer but returned to the queue after the [visibility timeout](../concepts/visibility-timeout.md) expired. The lines on the chart correspond to the number of receive attempts:
  * 0-1.
  * 2\.
  * 3-5.
  * More than 5.

## Deleting messages {#delete}

**Delete messages stats** contains charts with information about deleting messages:

* **Deleted messages, count**: The number of messages deleted from the queue per unit of time using the [DeleteMessage](../api-ref/message/DeleteMessage) or [DeleteMessageBatch](../api-ref/message/DeleteMessageBatch) method.

* **DeleteMessage duration**: The time it takes to execute a `DeleteMessage` request.

  {% include [ymq-monitoring-query-duration.md](../../_includes/message-queue/ymq-monitoring-query-duration.md) %}

* **DeleteMessageBatch duration**: The time it takes to execute a `DeleteMessageBatch` request.

  {% include [ymq-monitoring-query-duration.md](../../_includes/message-queue/ymq-monitoring-query-duration.md) %}

* **DeleteMessage errors**: The number of errors while executing `DeleteMessage` and `DeleteMessageBatch` requests.

* **Purged messages, count**: The number of messages deleted from the queue per unit of time using the [PurgeQueue](../api-ref/queue/PurgeQueue) method.

## Overall queue metrics {#queue}

**Overall queue stats** contains charts with general information about processes in queues:

* **Messages in queue, count**: The number of messages that are currently enqueued.

* **Age of oldest message in queue**: The retention time of the oldest message in the queue.

* **Message reside duration**: The time it takes to handle messages in the queue.

  {% include [ymq-monitoring-message-duration.md](../../_includes/message-queue/ymq-monitoring-message-duration.md) %}

