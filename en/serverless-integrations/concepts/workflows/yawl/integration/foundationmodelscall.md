---
title: FoundationModelsCall integration step
description: This article describes the fields for the FoundationModelsCall integration step.
---

# FoundationModelsCall

Integration with [{{ foundation-models-full-name }}]({{ link-docs-ai }}ai-studio/).

The `generate`, `classify`, `fewShotClassify`, and `vision` fields are mutually exclusive: you can use only one of them.

Field name | Type | Required | Default value | [Templating](../../templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`modelUrl` | `string` | Yes | No | No | ID of the model to call.
`generate` | [FoundationModelsGenerate](#FoundationModelsGenerate) | No | No | No | Configuring a `generate` action to generate a text.
`classify` | [FoundationModelsClassify](#FoundationModelsClassify) | No | No | No | Configuring a `classify` action to tune a classification.
`fewShotClassify` | [FoundationModelsFewShotClassify](#FoundationModelsFewShotClassify) | No | No | No | Configuring a `fewShotClassify` action to classify based on a prompt.
`vision` | [FoundationModelsVision](#FoundationModelsVision) | No | No | No | Configuring a `vision` action to work with images.

## FoundationModelsGenerate object {#FoundationModelsGenerate}

The `json` and `messages` fields are mutually exclusive: you can use only one of them. The `jsonSchema` and `jsonObject` fields are mutually exclusive: you can use only one of them.

Field name | Type | Required | Default value | [Templating](../../templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`temperature` | `number` | Yes | `0.3` | No | With a higher temperature, you get a more creative and randomized response from the model. This parameter accepts values between 0 and 1, inclusive. 
`maxTokens` | `integer` | Yes | `5.0` | No | Maximum number of tokens to generate. Allows limiting the model's response if needed.
`json` | `string` | No | `""` | Yes | Context for the model, as a JSON string. For more information, see the `messages` field description in the [{{ foundation-models-name }}]({{ link-docs-ai }}ai-studio/operations/generation/create-prompt#request) documentation.
`messages` | [FoundationModelsGenerate.Messages[]](#FoundationModelsGenerateMessages) | No | `[]` | No | Context for the model, as a list of input messages.
`reasoningOptions` | [FoundationModelsGenerate.ReasoningOptions](#FoundationModelsGenerateReasoningOptions) | No | No  | No | Reasoning mode. For more information, see [this {{ foundation-models-name }} article]({{ link-docs-ai }}ai-studio/concepts/generation/chain-of-thought).
`jsonSchema` | `string` | No | No | Yes | Model's JSON-formatted response
`jsonObject` | `boolean` | No | No | No | If `true`, the model returns a response as a JSON object. Otherwise, the response is formatted using Markdown. For more information, see [this {{ foundation-models-name }} article]({{ link-docs-ai }}ai-studio/concepts/generation/structured-output).

## FoundationModelsGenerate.Messages object {#FoundationModelsGenerateMessages}

Field name | Type | Required | Default value | [Templating](../../templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`messages` | [FoundationModelsGenerate.Message](#FoundationModelsGenerateMessage) | Yes | No | Yes | Input messages

## FoundationModelsGenerate.Message object {#FoundationModelsGenerateMessage}

Field name | Type | Required | Default value | [Templating](../../templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`role` | `string` | Yes | No | No | Message sender ID. The available values are `system`, `assistant`, and `user`. For more information, see [TextGeneration.completion]({{ link-docs-ai }}ai-studio/text-generation/api-ref/TextGeneration/completion).
`text` | `string` | Yes | No | Yes | Message text. For more information, see [TextGeneration.completion]({{ link-docs-ai }}ai-studio/text-generation/api-ref/TextGeneration/completion).

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

## FoundationModelsVision object {#FoundationModelsVision}

The `json` and `messages` fields are mutually exclusive: you can use only one of them.

Field name | Type | Required | Default value | [Templating](../../templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`temperature` | `number` | Yes | `0.3` | No | With a higher temperature, you get a more creative and randomized response from the model. This parameter accepts values between 0 and 1, inclusive. 
`maxTokens` | `integer` | Yes | `5.0` | No | Maximum number of tokens to generate. Allows limiting the model's response if needed.
`json` | `string` | No | `""` | Yes | Context for the model, as a JSON string. For more information, see the `messages` field description in the [{{ foundation-models-name }} documentation]({{ link-docs-ai }}ai-studio/operations/generation/create-prompt#request).
`messages` | [FoundationModelsVision.Messages[]](#FoundationModelsVisionMessages) | No | `[]` | No | Context for the model, as a list of input messages.

## FoundationModelsVision.Messages object {#FoundationModelsVisionMessages}

Field name | Type | Required | Default value | [Templating](../../templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`messages` | [FoundationModelsVision.Message](#FoundationModelsVisionMessage) | Yes | No | Yes | Input messages

## FoundationModelsVision.Message object {#FoundationModelsVisionMessage}

Field name | Type | Required | Default value | [Templating](../../templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`role` | `string` | Yes | No | No | Message sender ID. The available values are `system`, `assistant`, and `user`. For more information, see [TextGeneration.completion]({{ link-docs-ai }}ai-studio/text-generation/api-ref/TextGeneration/completion). If the `images` field is not empty, specify `role: user`.
`text` | `string` | Yes | No | Yes | Message text. For more information, see [TextGeneration.completion]({{ link-docs-ai }}ai-studio/text-generation/api-ref/TextGeneration/completion).
`images` | [FoundationModelsVision.Image](#FoundationModelsVisionImage) | No | No | No | Images to add to the message.

## FoundationModelsVision.Image {#FoundationModelsVisionImage}

The `base64` and `file` fields are mutually exclusive: you can use only one of them.

Field name | Type | Required | Default value | [Templating](../../templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`base64` | `string` | No | No | Yes | Image in [Base64](https://{{ lang }}.wikipedia.org/wiki/Base64) format
`file` | [FoundationModelsVision.File](#FoundationModelsVisionFile) | No | No | No | Image from the provided source

## FoundationModelsVision.File {#FoundationModelsVisionFile}

The `url` and `objectStorage` fields are mutually exclusive: you can use only one of them.

Field name | Type | Required | Default value | [Templating](../../templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`url` | `string` | No | No | Yes | Publicly accessible image URL
`objectStorage` | [FoundationModelsVision.ObjectStorage](#FoundationModelsVisionObjectStorage) | No | No | No | Image from an {{ objstorage-name }} [bucket](../../../../../storage/concepts/bucket.md)

## FoundationModelsVision.ObjectStorage {#FoundationModelsVisionObjectStorage}

Field name | Type | Required | Default value | [Templating](../../templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`bucket` | `string` | Yes | No | No | Name of the {{ objstorage-name }} bucket containing the image
`object` | `string` | Yes | No | Yes | Name to the image object, e.g., `prefix/subprefix/data.json`
