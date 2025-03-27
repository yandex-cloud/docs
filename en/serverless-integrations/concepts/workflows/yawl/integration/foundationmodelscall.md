---
title: FoundationModelsCall integration step
description: This article describes the fields for the FoundationModelsCall integration step.
---

# FoundationModelsCall

Integration with [{{ foundation-models-full-name }}](../../../../../foundation-models/). Currently, the only supported integration is the one with [{{ yagpt-full-name }}](../../../../../foundation-models/concepts/yandexgpt/index.md) for text generation.

Field name | Type | Required | Default value | [Templating](../../templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`modelUrl` | `string` | Yes | No | No | ID of the model to call.
`generate` | [FoundationModelsCallGenerate](#FoundationModelsCallGenerate) | Yes | No | No | Configuring the `generate` action to generate a text.

## FoundationModelsCallGenerate object {#FoundationModelsCallGenerate}

The `json` and `messages` are mutually exclusive: you can either specify a JSON string or explicitly list the messages.

Field name | Type | Required | Default value | [Templating](../../templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`temperature` | `double` | No | `0` | No | With a higher temperature, you get a more creative and randomized response from the model. This parameter accepts values between 0 and 1, inclusive. 
`maxTokens` | `int64` | Yes | No | No | Maximum number of tokens to generate. Allows limiting the model's response if needed.
`json` | `string` | No | `""` | Yes | Context for the model, as a JSON string. For more information, see the `messages` field description in the [{{ foundation-models-name }} documentation](../../../../../foundation-models/operations/yandexgpt/create-prompt.md#request).
`messages` | [FoundationModelsCallGenerateMessage](#FoundationModelsCallGenerateMessage)[] | No | `""` | No | Context for the model, as a list of input messages.

## FoundationModelsCallGenerateMessage object {#FoundationModelsCallGenerateMessage}

Field name | Type | Required | Default value | [Templating](../../templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`role` | `string` | Yes | No | Yes | Message sender ID. For more information, see [TextGeneration.completion](../../../../../foundation-models/text-generation/api-ref/TextGeneration/completion.md).
`text` | `string` | Yes | No | Yes | Message text. For more information, see [TextGeneration.completion](../../../../../foundation-models/text-generation/api-ref/TextGeneration/completion.md).