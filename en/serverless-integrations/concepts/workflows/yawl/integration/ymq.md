---
title: YMQ integration step
description: This article describes the fields for the YMQ integration step.
---

# YMQ

{% include [workflows-ai-studio-note](../../../../../_includes/serverless-integrations/workflows-ai-studio-note.md) %}

Sending messages to the [{{ message-queue-full-name }}](../../../../../message-queue/) queue.

Field name | Type | Required | Default value | [Templating](../../templating.md) supported | Description
--- | --- | --- | --- | --- | ---
`queueArn` | `string` | Yes | None | None | ARN of the queue.
`put` | [YmqPut](#YmqPut) | Yes | None | None | Configuring the `put` action to add messages to the queue.

## YmqPut object {#YmqPut}

Field name | Type | Required | Default value | [Templating](../../templating.md) supported | Description
--- | --- | --- | --- | --- | ---
`body` | `string` | None | `""` | Yes | Message body.