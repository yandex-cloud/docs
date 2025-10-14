---
title: FoundationModelsCall integration step
description: This article describes the fields for the FoundationModelsCall integration step.
---

# FoundationModelsCall

Integration with [{{ foundation-models-full-name }}](../../../../../ai-studio/).

The `generate`, `classify`, and `fewShotClassify` fields are mutually exclusive: you can use only one of them.

Field name | Type | Required | Default value | [Templating](../../templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`modelUrl` | `string` | Yes | No | No | ID of the model to call.
`generate` | [FoundationModelsGenerate](#FoundationModelsGenerate) | No | No | No | Configuring a `generate` action to generate a text.
`classify` | [FoundationModelsClassify](#FoundationModelsClassify) | No | No | No | Configuring a `classify` action to tune a classification.
`fewShotClassify` | [FoundationModelsFewShotClassify](#FoundationModelsFewShotClassify) | No | No | No | Configuring a `fewShotClassify` action to classify based on a prompt.

## FoundationModelsGenerate object {#FoundationModelsGenerate}

The `json` and `messages` fields are mutually exclusive: you can use only one of them. The `jsonSchema` and `jsonObject` fields are mutually exclusive: you can use only one of them.

Field name | Type | Required | Default value | [Templating](../../templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`temperature` | `number` | Yes | `0.3` | No | With a higher temperature, you get a more creative and randomized response from the model. This parameter accepts values between 0 and 1, inclusive. 
`maxTokens` | `integer` | Yes | `5.0` | No | Maximum number of tokens to generate. Allows limiting the model's response if needed.
`json` | `string` | No | `""` | Yes | Context for the model, as a JSON string. For more information, see the `messages` field description in the [{{ foundation-models-name }}](../../../../../ai-studio/operations/generation/create-prompt.md#request) documentation.
`messages` | [FoundationModelsGenerate.Messages[]](#FoundationModelsGenerateMessages) | No | `""` | No | Context for the model, as a list of input messages.
`reasoningOptions` | [FoundationModelsGenerate.ReasoningOptions](#FoundationModelsGenerateReasoningOptions) | No | No  | No | Reasoning mode. For more information, see [this {{ foundation-models-name }}](../../../../../ai-studio/concepts/generation/chain-of-thought.md) article.
`jsonSchema` | `string` | No | No | Yes | Model's JSON-formatted response
`jsonObject` | `boolean` | No | No | No | If `true`, the model returns a response as a JSON object. Otherwise, the response is formatted using Markdown. For more information, see [this {{ foundation-models-name }}](../../../../../ai-studio/concepts/generation/structured-output.md) article.

## FoundationModelsGenerate.Messages object {#FoundationModelsGenerateMessages}

Field name | Type | Required | Default value | [Templating](../../templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`messages` | [FoundationModelsGenerate.Message](#FoundationModelsGenerateMessage) | Yes | No | Yes | Input messages

## FoundationModelsGenerate.Message object {#FoundationModelsGenerateMessage}

Field name | Type | Required | Default value | [Templating](../../templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`role` | `string` | Yes | No | No | Message sender ID. Values to choose from: `system`, `assistant`, and `user`. For more information, see [TextGeneration.completion](../../../../../ai-studio/text-generation/api-ref/TextGeneration/completion.md).
`text` | `string` | Yes | No | Yes | Message text. For more information, see [TextGeneration.completion](../../../../../ai-studio/text-generation/api-ref/TextGeneration/completion.md).

## FoundationModelsGenerate.ReasoningOptions object {#FoundationModelsGenerateReasoningOptions}

#|
|| **Field name** | **Type** | **This is a required field** | **Default value** | **[Templating](../../templating.md) is supported** | **Description** ||
|| `mode` | `string` | Yes | `REASONING_MODE_UNSPECIFIED` | No | Possible statuses of the reasoning mode:
* `REASONING_MODE_UNSPECIFIED`: Not specified.
* `DISABLED`: Disabled.
* `ENABLED_HIDDEN`: Enabled. ||
|#

## FoundationModelsClassify object {#FoundationModelsClassify}

Field name | Type | Required | Default value | [Templating](../../templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`text` | `string` | Yes | No | Yes | Text description of the message

## FoundationModelsFewShotClassify object {#FoundationModelsFewShotClassify}

The `labelsJson` and `labelsArray` fields are mutually exclusive: you can use only one of them. The `samplesJson` and `samplesArray` fields are mutually exclusive: you can use only one of them.

Field name | Type | Required | Default value | [Templating](../../templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`taskDescription` | `string` | Yes | No | Yes | Text description of the task for the classifier
`text`            | `string` | Yes | No | Yes | Text description of the message
`labelsJson`      | `string` | No | No | Yes | Classes as a JSON object
`labelsArray`     | [FoundationModelsFewShotClassify.Labels[]](#FoundationModelsFewShotClassifyLabels) | No | No | No | Classes as an array
`samplesJson`     | `string` | No | No | Yes | Examples of requests as a JSON object
`samplesArray`    | [FoundationModelsFewShotClassify.Samples[]](#FoundationModelsFewShotClassifySamples) | No | No | No | Examples of requests as an array

## FoundationModelsFewShotClassify.Labels object {#FoundationModelsFewShotClassifyLabels}

Field name | Type | Required | Default value | [Templating](../../templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`labels` | `string` | Yes | No | Yes | Classes

## FoundationModelsFewShotClassify.Samples object {#FoundationModelsFewShotClassifySamples}

Field name | Type | Required | Default value | [Templating](../../templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`samples` | [FoundationModelsFewShotClassify.Sample](#FoundationModelsFewShotClassifySample) | Yes | No | No | Request examples

## FoundationModelsFewShotClassify.Sample object {#FoundationModelsFewShotClassifySample}

Field name | Type | Required | Default value | [Templating](../../templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`text` | `string` | Yes | No | Yes | Text description of the message
`label` | `string` | Yes | No | Yes | Class
