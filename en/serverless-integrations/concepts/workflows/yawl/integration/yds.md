---
title: YDS integration step
description: This article describes the fields for the YDS integration step.
---

# YDS

Sending messages to the [{{ yds-full-name }}](../../../../../data-streams/) topic.

Field name | Type | Required | Default value | [Templating](../../templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`database` | `string` | Yes | No | No | Database ID.
`topic` | `string` | Yes | No | No | Topic ID.
`put` | `object` | Yes | [YdsPut](#YdsPut) | No | Configuring the `put` action to send messages to the data stream.

## YdsPut object {#YdsPut}

Field name | Type | Required | Default value | [Templating](../../templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`body` | `string` | No | `""` | Yes | Message body.
`partitionKey` | `string` | No | `""` | Yes |  [Shard key](../../../../../data-streams/concepts/glossary.md#partition-key).

