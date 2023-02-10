---
title: "What is message queues?"
description: "Message queues enable messaging between components of distributed applications. Messages can be sent to queues using the API or any of the supported tools. Enqueued messages are read by consumers, i.e., applications configured to receive messages from particular queues. Once a message is processed, the consumer deletes it from the queue."
---

# Message queues

Message queues enable messaging between components of distributed applications. Messages can be sent to queues using the [API](../api-ref/index.md) or any of the [supported tools](../instruments/index.md).

Enqueued messages are read by consumers, i.e., applications configured to receive messages from particular queues. Once a message is processed, the consumer deletes it from the queue.

## Standard queues {#standard-queues}

Consumers read messages from a standard queue in random order. Standard queues guarantee that each message is delivered at least once. In rare cases, a message can be received from a standard queue twice.

Use standard queues when you need maximum throughput.

## FIFO queues {#fifo-queues}

Messages are read from a FIFO queue in the order that they are received. FIFO queues guarantee exactly-once delivery.

Use FIFO queues if you need strictly ordered message delivery and exactly-once processing.

### Message groups {#group-id}

With group IDs, you can send multiple ordered message groups to different consumers within a single FIFO queue. The group ID is specified via the `MessageGroupId` parameter at sending. Within a single group, all messages are enqueued and processed in the order that they are sent.

### Deduplication on enqueueing {#deduplication}

FIFO queues deduplicate messages being enqueued by their deduplication ID or content. For more information, see [{#T}](deduplication.md).

{% note info %}

{{ message-queue-full-name }} automatically deletes messages that are in a queue beyond the retention period. The standard message retention period is 4 days. It can be changed within the range of 60 seconds to 14 days. You can change it when creating a queue or by using the [SetQueueAttributes](../api-ref/queue/SetQueueAttributes.md) method.

{% endnote %}