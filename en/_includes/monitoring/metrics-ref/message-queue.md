The `name` label contains the metric name.

All {{ message-queue-name }} metrics share the `service=message-queue` label.

## HTTP API metrics {#mq-http-metrics}

| Metric name<br>Type, units | Description<br>Labels |
| --- | --- |
| `api.http.errors_count_per_second`<br>`DGAUGE`, errors per second | Number of query execution errors per second.<br>Labels: `method` containing the {{ message-queue-full-name }} API method called. |
| `api.http.request_duration_milliseconds`<br>`DGAUGE`, milliseconds | Query execution duration.<br>Labels: `method` containing the {{ message-queue-full-name }} API method called. |
| `api.http.requests_count_per_second`<br>`DGAUGE`, requests per second | Number of processed requests per second.<br>Labels: `method` containing the {{ message-queue-full-name }} API method called. |

## Service metrics {#mq-metrics}

| Metric name<br>Type, units | Description<br>Labels |
| --- | --- |
| `queue.messages.client_processing_duration_milliseconds`<br>`DGAUGE`, milliseconds | Message processing duration on the receiving side |
| `queue.messages.deduplicated_count_per_second`<br>`DGAUGE`, messages per second | Message deduplication frequency shows the number of messages processed a certain number of times during the above-mentioned period, e.g. how many messages were processed once, how many were processed twice, etc. This metric is used to detect redundant processing of duplicate messages. |
| `queue.messages.deleted_count_per_second`<br>`DGAUGE`, messages per second | Message dequeuing frequency |
| `queue.messages.empty_receive_attempts_count_per_second`<br>`DGAUGE`, attempts per second | Number of detected attempts to obtain an empty message per second |
| `queue.messages.inflight_count`<br>`DGAUGE`, count | Number of in-flight messages, i.e., messages received by consumers but not dequeued (that are still within the [visibility timeout](../../../message-queue/concepts/visibility-timeout.md) window). |
| `queue.messages.oldest_age_milliseconds`<br>`DGAUGE`, milliseconds | Age of oldest message in the queue.<br>The metric name is deprecated, and the `milliseconds` substring does not align with the current units of measure. Currently, the metric is measured in seconds (`s`). |
| `queue.messages.purged_count_per_second`<br>`DGAUGE`, messages per second | Frequency of message deletion using the [PurgeQueue](../../../message-queue/api-ref/queue/PurgeQueue) method |
| `queue.messages.receive_attempts_count_rate`<br>`DGAUGE`, count | Number of attempts to receive messages from the queue |
| `queue.messages.received_bytes_per_second`<br>`DGAUGE`, bytes per second | Total size of messages received from the queue per second |
| `queue.messages.received_count_per_second`<br>`DGAUGE`, messages per second | Number of messages received from the queue per second |
| `queue.messages.request_timeouts_count_per_second`<br>`DGAUGE`, errors per second | Number of `ReceiveMessage` request errors |
| `queue.messages.reside_duration_milliseconds`<br>`DGAUGE`, milliseconds | Message processing time in the queue |
| `queue.messages.sent_bytes_per_second`<br>`DGAUGE`, bytes per second | Total size of messages enqueued per second |
| `queue.messages.sent_count_per_second`<br>`DGAUGE`, messages per second | Number of messages enqueued per second |
| `queue.messages.stored_count`<br>`DGAUGE`, count | Number of messages currently in the queue |