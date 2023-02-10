---
title: "What is Dead Letter Queue (DLQ)?"
description: "The Dead Letter Queue (DLQ) is a queue for messages that consumers couldn't process in standard queues. There are many reasons for problems with message processing, such as unexpected state changes in producers or consumers. Messages that are moved to the DLQ are stored there for analysis and no longer affect the activity of applications."
---

# Dead Letter Queue

The Dead Letter Queue (DLQ) is a queue for messages that consumers couldn't process in standard queues. There are many reasons for problems with message processing, such as unexpected state changes in producers or consumers. Messages that are moved to the DLQ are stored there for analysis and no longer affect the activity of applications.

A message can be moved to the DLQ after a set number of unsuccessful attempts to process it. Each queue has a redrive policy that defines the number of processing attempts and the ID of the DLQ.

## The redrive policy {#redrive-policy}

The redrive policy defines the conditions for moving messages to the DLQ.

To configure the redrive policy, use the `Redrive policy` attribute in the [CreateQueue](../api-ref/queue/CreateQueue.md) and [SetQueueAttributes](../api-ref/queue/SetQueueAttributes.md) methods.

This attribute specifies the DLQ to move the message to and the `maxReceiveCount` parameter, which indicates the maximum number of processing attempts before moving a message to the DLQ. When the `ReceiveCount` value for the message exceeds the value of `maxReceiveCount`, the message is moved to the DLQ. The message keeps its ID after moving to the DLQ.

## When to use a DLQ {#usage}

### With standard queues {#standard-queues}

Use a DLQ with standard queues when message delivery order is not important. Standard queues keep messages until the end of the retention period. When the retention period expires, the message is removed from the queue.

If you need to process a large number of messages including those unsuccessfully processed by consumers, use DLQs. This helps isolate problematic messages from a source queue after several unsuccessful processing attempts instead of saving them until the retention period expires. This can lower costs and reduce the load on hardware and virtual machines. A large number of unprocessed messages in standard queues may slow down your applications.

For standard queues, the DLQ must also be a standard queue.

### With FIFO queues {#fifo-queues}

Using a DLQ with FIFO queues may affect the message processing order. If processing fails for one of the messages in a group, processing is blocked for the entire group. A consumer can't continue processing this message group until the problematic message is successfully processed. Make sure that your application processes all messages successfully, otherwise the entire FIFO queue may be blocked because of a problematic message.

For FIFO queues, the DLQ must also be created as a FIFO queue.