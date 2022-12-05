---
title: Dead Letter Queue in Yandex Serverless Containers
description: "The Dead Letter Queue (DLQ) is a queue for messages that could not be processed by a triggered container. A message is considered processed if the container that received it ended successfully. Messages moved to the DLQ are stored there for further analysis."
---

# Dead Letter Queue in {{ serverless-containers-name }}

The _Dead Letter Queue (DLQ)_ is a [queue](../../message-queue/concepts/queue.md) for messages that could not be processed by a triggered {{ serverless-containers-name }} [container](container.md). A message is considered processed if the container that received it ended successfully. Messages moved to the DLQ are stored there for further analysis.

If the container failed to process a message within the specified number of attempts, the message is moved to the DLQ. The number of container invocation attempts and the DLQ are specified in the redrive policy.

If no redrive policy is configured, the messages that the container failed to process are deleted.

## The redrive policy {#redrive-policy}

The redrive policy defines the conditions for moving messages to the DLQ.

To configure the redrive policy for all triggers except a trigger for {{ message-queue-full-name }}, specify the following when creating a trigger:

* The queue to move messages to.
* [service account](../../iam/concepts/users/service-accounts.md) with rights to write messages to the queue.
* The time after which the container will be invoked again if the current attempt fails.
* The number of invocation retries before the trigger moves a message to the queue.

The [redrive policy](../../message-queue/concepts/dlq.md#redrive-policy) for the {{ message-queue-full-name }} trigger is configured when creating a source queue for messages that are processed by the triggered container.

The message keeps its ID after moving to the DLQ.
