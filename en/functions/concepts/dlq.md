---
title: "What is Dead Letter Queue (DLQ)?"
description: "Dead Letter Queue (DLQ) is a queue where messages that could not be processed by the function called by the trigger are forwarded. The message is considered processed if the function that received it completed without errors. Messages forwarded to DLQ are stored there for further diagnostics."
---

# Dead Letter Queue

_A Dead Letter Queue (DLQ)_ is a [queue](../../message-queue/concepts/queue.md) that messages which could not be processed by a triggered [function](./function.md) in {{ sf-name }} or [container](../../serverless-containers/concepts/container.md) in {{ serverless-containers-name }} are redirected to. A message is considered processed if its recipient function or container ran to completion without errors. Messages moved to the DLQ are stored there for further analysis.

If a function or a container failed to process a message over a specified number of attempts, it is redirected to the DLQ. The number of attempted function or container calls and the queue to serve as the DLQ are defined in a redirect policy.

If no redirect policy is configured, messages that a function or a container failed to process are deleted.

## Redrive policy {#redrive-policy}

The redrive policy defines the conditions for moving messages to the DLQ.

To configure the redrive policy for all triggers except a trigger for {{ message-queue-full-name }}, specify the following when creating a trigger:

* The queue to move messages to.
* [A service account](../../iam/concepts/users/service-accounts.md) with rights to write messages to the queue.
* A timeout for a repeat function or container call if the current call fails.
* The number of invocation retries before the trigger moves a message to the queue.

[The redrive policy](../../message-queue/concepts/dlq.md#redrive-policy) for a {{ message-queue-full-name }} trigger is configured when creating a queue whose messages are processed by a triggered function or container.

The message keeps its ID after moving to the DLQ.

