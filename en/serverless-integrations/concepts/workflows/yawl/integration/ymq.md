---
title: YMQ integration step
description: This article describes the fields for the YMQ integration step.
---

# YMQ

Sending messages to the [{{ message-queue-full-name }}](../../../../../message-queue/) queue.

Field name | Type | Required | Default value | [Templating](../../templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`queueArn` | `string` | Yes | No | No | ARN of the queue.
`put` | [YmqPut](#YmqPut) | Yes | No | No | Configuring the `put` action to add messages to the queue.

## YmqPut object {#YmqPut}

Field name | Type | Required | Default value | [Templating](../../templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`body` | `string` | No | `""` | Yes | Message body.