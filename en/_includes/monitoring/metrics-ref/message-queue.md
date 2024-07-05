The metric name is written to the `name` label.

All {{ message-queue-name }} metrics share the `service=message-queue` label.

## HTTP API metrics {#mq-http-metrics}

| Metric name<br>Type, unit | Description<br>Labels |
| --- | --- |
| `api.http.errors_count_per_second`<br>`DGAUGE`, errors/s | Number of request errors per second.<br>Label: `method`, the {{ message-queue-full-name }} API method called. |
| `api.http.request_duration_milliseconds`<br>`DGAUGE`, milliseconds | Request execution duration.<br>Label: `method`, the {{ message-queue-full-name }} API method called. |
| `api.http.requests_count_per_second`<br>`DGAUGE`, requests/s | Number of requests processed per second.<br>Label: `method`, the {{ message-queue-full-name }} API method called. |

## Service metrics {#mq-metrics}

| Metric name<br>Type, unit | Description<br>Labels |
| --- | --- |
| `queue.messages.client_processing_duration_milliseconds`<br>`DGAUGE`, milliseconds | Message processing time spent by the recipient. |
| `queue.messages.deduplicated_count_per_second`<br>`DGAUGE`, messages/s | Message deduplication frequency shows the number of messages processed a certain number of times during the above-mentioned period, e.g. how many messages were processed once, how many were processed twice, etc. This metric allows you to determine excessive processing of repeating messages. |
| `queue.messages.deleted_count_per_second`<br>`DGAUGE`, messages/s | Message dequeuing frequency. |
| `queue.messages.empty_receive_attempts_count_per_second`<br>`DGAUGE`, attempts/s | Number of detected attempts to obtain an empty message per second. |
| `queue.messages.inflight_count`<br>`DGAUGE`, number | Number of messages received by their recipients but not dequeued (that are still within the [visibility timeout](../../../message-queue/concepts/visibility-timeout.md) window). |
| `queue.messages.oldest_age_milliseconds`<br>`DGAUGE`, milliseconds | Storage time of the earliest message in the queue.<br>The metric name is obsolete and its `milliseconds` component does not reflect the current units of measure. Currently, the metric is measured in seconds (`s`). |
| `queue.messages.purged_count_per_second`<br>`DGAUGE`, messages/s | Frequency of message deletion using the [PurgeQueue](../../../message-queue/api-ref/queue/PurgeQueue) method. |
| `queue.messages.receive_attempts_count_rate`<br>`DGAUGE`, number | Number of attempts to receive messages from the queue. |
| `queue.messages.received_bytes_per_second`<br>`DGAUGE`, bytes/s | Total size of messages received from the queue per second. |
| `queue.messages.received_count_per_second`<br>`DGAUGE`, messages/s | Number of messages received from the queue per second. |
| `queue.messages.request_timeouts_count_per_second`<br>`DGAUGE`, errors/s | Number of errors when executing the `ReceiveMessage` requests. |
| `queue.messages.reside_duration_milliseconds`<br>`DGAUGE`, milliseconds | Message processing time in the queue. |
| `queue.messages.sent_bytes_per_second`<br>`DGAUGE`, bytes/s | Total size of messages sent to the queue per second. |
| `queue.messages.sent_count_per_second`<br>`DGAUGE`, messages/s | Number of messages sent to the queue per second. |
| `queue.messages.stored_count`<br>`DGAUGE`, number | Number of messages currently enqueued. |
