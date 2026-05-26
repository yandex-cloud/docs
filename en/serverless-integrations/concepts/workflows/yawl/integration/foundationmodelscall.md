---
title: FoundationModelsCall integration step
description: This article describes the fields for the FoundationModelsCall integration step.
---

# FoundationModelsCall

Integration with [{{ ai-studio-full-name }}]({{ link-docs-ai }}ai-studio/concepts/).

The `generate`, `classify`, `fewShotClassify`, and `vision` fields are mutually exclusive: you can use only one of them.

Field name | Type | Required | Default value | [Templating](../../templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`modelUrl` | `string` | Yes | None | None | ID of the model to call.
`generate` | [FoundationModelsGenerate](#FoundationModelsGenerate) | None | None | None | Configuring a `generate` action to generate a text.
`classify` | [FoundationModelsClassify](#FoundationModelsClassify) | None | None | None | Configuring a `classify` action to tune a classification.
`fewShotClassify` | [FoundationModelsFewShotClassify](#FoundationModelsFewShotClassify) | None | None | None | Configuring a `fewShotClassify` action to classify based on a prompt.
`vision` | [FoundationModelsVision](#FoundationModelsVision) | None | None | None | Configuring a `vision` action to work with images.
`dataLoggingEnabled` | `boolean` | None | `true` | None | Enabling request logging. If `false`, logging is disabled. For more information, see [this {{ ai-studio-name }} guide]({{ link-docs-ai }}ai-studio/operations/disable-logging).

## FoundationModelsGenerate object {#FoundationModelsGenerate}

The `json` and `messages` fields are mutually exclusive: you can use only one of them. The `jsonSchema` and `jsonObject` fields are mutually exclusive: you can use only one of them.

Field name | Type | Required | Default value | [Templating](../../templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`temperature` | `number` | Yes | `0.3` | None | With a higher temperature, you get a more creative and randomized response from the model. This parameter accepts values between 0 and 1, inclusive. 
`maxTokens` | `integer` | Yes | `5.0` | None | Maximum number of tokens to generate. Allows limiting the model's response if needed.
`json` | `string` | None | `""` | Yes | Context for the model, as a JSON string. For more information, see the `messages` field description in the [{{ foundation-models-name }}]({{ link-docs-ai }}ai-studio/operations/generation/create-prompt#request) documentation.
`messages` | [FoundationModelsGenerate.Messages[]](#FoundationModelsGenerateMessages) | None | `[]` | None | Context for the model, as a list of input messages.
`reasoningOptions` | [FoundationModelsGenerate.ReasoningOptions](#FoundationModelsGenerateReasoningOptions) | None | None  | None | Reasoning mode. For more information, see [this {{ foundation-models-name }} guide]({{ link-docs-ai }}ai-studio/concepts/generation/chain-of-thought).
`jsonSchema` | `string` | None | None | Yes | Model's JSON-formatted response
`jsonObject` | `boolean` | None | None | None | If `true`, the model returns a response as a JSON object. Otherwise, the response is formatted using Markdown. For more information, see [this {{ foundation-models-name }} guide]({{ link-docs-ai }}ai-studio/concepts/generation/structured-output).

## FoundationModelsGenerate.Messages object {#FoundationModelsGenerateMessages}

Field name | Type | Required | Default value | [Templating](../../templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`messages` | [FoundationModelsGenerate.Message](#FoundationModelsGenerateMessage) | Yes | None | Yes | Input messages

## FoundationModelsGenerate.Message object {#FoundationModelsGenerateMessage}

Field name | Type | Required | Default value | [Templating](../../templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`role` | `string` | Yes | None | None | Message sender ID. The available values are `system`, `assistant`, and `user`. For more information, see [TextGeneration.completion]({{ link-docs-ai }}ai-studio/text-generation/api-ref/TextGeneration/completion).
`text` | `string` | Yes | None | Yes | Message text. For more information, see [TextGeneration.completion]({{ link-docs-ai }}ai-studio/text-generation/api-ref/TextGeneration/completion).

## FoundationModelsGenerate.ReasoningOptions object {#FoundationModelsGenerateReasoningOptions}

#|
|| **Field name** | **Type** | **This is a required field** | **Default value** | **[Templating](../../templating.md) is supported** | **Description** ||
|| `mode` | `string` | Yes | `REASONING_MODE_UNSPECIFIED` | None | Possible statuses of the reasoning mode:
* `REASONING_MODE_UNSPECIFIED`: Not specified.
* `DISABLED`: Disabled.
* `ENABLED_HIDDEN`: Enabled. ||
|#

## FoundationModelsClassify object {#FoundationModelsClassify}

Field name | Type | Required | Default value | [Templating](../../templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`text` | `string` | Yes | None | Yes | Text description of the message

## FoundationModelsFewShotClassify object {#FoundationModelsFewShotClassify}

The `labelsJson` and `labelsArray` fields are mutually exclusive: you can use only one of them. The `samplesJson` and `samplesArray` fields are mutually exclusive: you can use only one of them.

Field name | Type | Required | Default value | [Templating](../../templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`taskDescription` | `string` | Yes | None | Yes | Text description of the task for the classifier
`text`            | `string` | Yes | None | Yes | Text description of the message
`labelsJson`      | `string` | None | None | Yes | Classes as a JSON object
`labelsArray`     | [FoundationModelsFewShotClassify.Labels[]](#FoundationModelsFewShotClassifyLabels) | None | None | None | Classes as an array
`samplesJson`     | `string` | None | None | Yes | Examples of requests as a JSON object
`samplesArray`    | [FoundationModelsFewShotClassify.Samples[]](#FoundationModelsFewShotClassifySamples) | None | None | None | Examples of requests as an array

## FoundationModelsFewShotClassify.Labels object {#FoundationModelsFewShotClassifyLabels}

Field name | Type | Required | Default value | [Templating](../../templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`labels` | `string` | Yes | None | Yes | Classes

## FoundationModelsFewShotClassify.Samples object {#FoundationModelsFewShotClassifySamples}

Field name | Type | Required | Default value | [Templating](../../templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`samples` | [FoundationModelsFewShotClassify.Sample](#FoundationModelsFewShotClassifySample) | Yes | None | None | Request examples

## FoundationModelsFewShotClassify.Sample object {#FoundationModelsFewShotClassifySample}

Field name | Type | Required | Default value | [Templating](../../templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`text` | `string` | Yes | None | Yes | Text description of the message
`label` | `string` | Yes | None | Yes | Class

## FoundationModelsVision object {#FoundationModelsVision}

The `json` and `messages` fields are mutually exclusive: you can use only one of them.

Field name | Type | Required | Default value | [Templating](../../templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`temperature` | `number` | Yes | `0.3` | None | With a higher temperature, you get a more creative and randomized response from the model. This parameter accepts values between 0 and 1, inclusive. 
`maxTokens` | `integer` | Yes | `5.0` | None | Maximum number of tokens to generate. Allows limiting the model's response if needed.
`json` | `string` | None | `""` | Yes | Context for the model, as a JSON string. For more information, see the `messages` field description in the [{{ foundation-models-name }} documentation]({{ link-docs-ai }}ai-studio/operations/generation/create-prompt#request).
`messages` | [FoundationModelsVision.Messages[]](#FoundationModelsVisionMessages) | None | `[]` | None | Context for the model, as a list of input messages.

## FoundationModelsVision.Messages object {#FoundationModelsVisionMessages}

Field name | Type | Required | Default value | [Templating](../../templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`messages` | [FoundationModelsVision.Message](#FoundationModelsVisionMessage) | Yes | None | Yes | Input messages

## FoundationModelsVision.Message object {#FoundationModelsVisionMessage}

Field name | Type | Required | Default value | [Templating](../../templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`role` | `string` | Yes | None | None | Message sender ID. The available values are `system`, `assistant`, and `user`. For more information, see [TextGeneration.completion]({{ link-docs-ai }}ai-studio/text-generation/api-ref/TextGeneration/completion). If the `images` field is not empty, specify `role: user`.
`text` | `string` | Yes | None | Yes | Message text. For more information, see [TextGeneration.completion]({{ link-docs-ai }}ai-studio/text-generation/api-ref/TextGeneration/completion).
`images` | [FoundationModelsVision.Image](#FoundationModelsVisionImage) | None | None | None | Images to add to the message.

## FoundationModelsVision.Image {#FoundationModelsVisionImage}

The `base64` and `file` fields are mutually exclusive: you can use only one of them.

Field name | Type | Required | Default value | [Templating](../../templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`base64` | `string` | None | None | Yes | Image in [Base64](https://{{ lang }}.wikipedia.org/wiki/Base64) format
`file` | [FoundationModelsVision.File](#FoundationModelsVisionFile) | None | None | None | Image from the provided source

## FoundationModelsVision.File {#FoundationModelsVisionFile}

The `url` and `objectStorage` fields are mutually exclusive: you can use only one of them.

Field name | Type | Required | Default value | [Templating](../../templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`url` | `string` | None | None | Yes | Publicly accessible image URL
`objectStorage` | [FoundationModelsVision.ObjectStorage](#FoundationModelsVisionObjectStorage) | None | None | None | Image from an {{ objstorage-name }} [bucket](../../../../../storage/concepts/bucket.md)

## FoundationModelsVision.ObjectStorage {#FoundationModelsVisionObjectStorage}

Field name | Type | Required | Default value | [Templating](../../templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`bucket` | `string` | Yes | None | None | Name of the {{ objstorage-name }} bucket containing the image
`object` | `string` | Yes | None | Yes | Name of the image object, e.g., `prefix/subprefix/image.png`
