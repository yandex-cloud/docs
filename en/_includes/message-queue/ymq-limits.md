#### Quotas {#ymq-quotas}

##### Messages {#ymq-quotas-messages}

| Type of limit | Value |
----- | -----
| Number of `SendMessage` and `SendMessageBatch` calls per queue | 300 calls per second for a standard queue |
| Number of `ReceiveMessage` calls per queue | 300 calls per second for a standard queue |
| Number of `DeleteMessage` and `DeleteMessageBatch` calls per queue | 300 calls per second for a standard queue |
| Number of `ChangeMessageVisibility` and `ChangeMessageVisibilityBatch` calls per queue | 300 calls per second for a standard queue |
| Number of `CreateQueue` calls per cloud | 2 calls per second |
| Number of `DeleteQueue` calls per cloud | 5 calls per second |
| Number of other request calls per cloud | 100 calls per second |
| Number of queues per cloud | 10 |

#### Limits {#ymq-limits}

##### Queues {#ymq-limits-queues}

| Type of limit | Value |
----- | -----
| Minimum message enqueue delay (`DelaySeconds` parameter) | 0 seconds |
| Maximum message enqueue delay (`DelaySeconds` parameter) | 900 seconds (15 minutes) |
| Number of messages being processed per standard queue | 120,000 |
| Number of messages being processed per FIFO queue | 20,000 |
| Queue name | Maximum of 80 characters, including numbers, lowercase and uppercase Latin letters, hyphens, and underscores. The name of a FIFO queue must end with the `.fifo` suffix. |

##### Messages {#ymq-limits-messages}

| Type of limit | Value |
----- | -----
| Number of `SendMessage` and `SendMessageBatch` calls per queue | 30 calls per second for a FIFO queue |
| Number of `ReceiveMessage` calls per queue | 30 calls per second for a FIFO queue |
| Number of `DeleteMessage` and `DeleteMessageBatch` calls per queue | 30 calls per second for a FIFO queue |
| Number of `ChangeMessageVisibility` and `ChangeMessageVisibilityBatch` calls per queue | 30 calls per second for a FIFO queue |
| Batch entry ID | Maximum of 80 characters, including numbers, lowercase and uppercase Latin letters, hyphens, and underscores |
| Maximum number of message attributes | 10 |
| Maximum number of entries per batch | 10 |
| Message content | XML, JSON, and unformatted text. The following Unicode characters are supported: <ul><li>`#x9`</li> <li>`#xA`</li> <li>`#xD`</li> <li>from `#x20` to `#xD7FF`</li> <li>from `#xE000` to `#xFFFD`</li> <li>from `#x10000` to `#x10FFFF`</li></ul> |
| Maximum period for retaining messages in a queue | 1,209,600 seconds (14 days) |
| Minimum period for retaining messages in a queue | 60 seconds (1 minute) |
| Maximum message enqueue delay (`DelaySeconds` parameter) | 900 seconds (15 minutes) |
| Minimum message enqueue delay (`DelaySeconds` parameter) | 0 seconds |
| Maximum message size | 262,144 bytes (256 KB) |
| Minimum message size | 1 byte |
| Maximum message visibility timeout | 12 hours |
| Minimum message visibility timeout | 0 seconds |
| Maximum client message [wait time](../../message-queue/concepts/long-polling.md) in an empty queue (`WaitTimeSeconds` parameter) | 20 seconds |
