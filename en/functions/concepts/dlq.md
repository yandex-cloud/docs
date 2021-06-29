---
title: Dead Letter Queue in Yandex Cloud Functions
description: "Dead Letter Queue (DLQ) is a queue where messages that could not be processed by the function called by the trigger are forwarded. The message is considered processed if the function that received it completed without errors. Messages forwarded to DLQ are stored there for further diagnostics."
---

# Dead Letter Queue

_A Dead Letter Queue (DLQ)_ is a [queue](../../message-queue/concepts/queue.md) where messages that a triggered function couldn't process are moved to. A message is considered processed if the function that received it ended successfully. Messages that are moved to the DLQ are stored there for analysis.

If the function failed to process a message within the specified number of attempts, the message is moved to the DLQ. The number of function invocation attempts and the DLQ are specified in the redrive policy.

If no redrive policy is configured, the messages that the function failed to process are deleted.

## Redrive policy

The redrive policy defines the conditions for moving messages to the DLQ.

To configure the redrive policy for all triggers except a trigger for {{ message-queue-full-name }}, specify the following when creating a trigger:

* The queue to move messages to.
* [A service account](../../iam/concepts/users/service-accounts.md) with rights to write messages to the queue.
* The time after which the function will be invoked again if the current attempt fails.
* The number of invocation retries before the trigger moves a message to the queue.

[The redrive policy](../../message-queue/concepts/dlq.md#redrive-policy) for the {{ message-queue-full-name }} trigger is configured when creating a source queue for messages that are processed by the triggered function.

The message keeps its ID after moving to the DLQ.

