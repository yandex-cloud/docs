---
title: YDS integration step
description: This article describes the fields for the YDS integration step.
---

# YDS

{% include [workflows-ai-studio-note](../../../../../_includes/serverless-integrations/workflows-ai-studio-note.md) %}

Sending messages to the [{{ yds-full-name }}](../../../../../data-streams/) topic.

Field name | Type | Required | Default value | [Templating](../../templating.md) supported | Description
--- | --- | --- | --- | --- | ---
`database` | `string` | Yes | None | None | Database ID.
`topic` | `string` | Yes | None | None | Topic ID.
`put` | `object` | Yes | [YdsPut](#YdsPut) | None | Configuring the `put` action to send messages to the data stream.

## YdsPut object {#YdsPut}

Field name | Type | Required | Default value | [Templating](../../templating.md) supported | Description
--- | --- | --- | --- | --- | ---
`body` | `string` | None | `""` | Yes | Message body.
`partitionKey` | `string` | None | `""` | Yes |  [Shard key](../../../../../data-streams/concepts/glossary.md#partition-key).

