---
title: Fine-tuning text generation models
description: In {{ foundation-models-full-name }}, you can tune {{ gpt-lite }} and {{ llama }} 8B text generation models.
---

# Fine-tuning text generation models

_Model tuning in {{ foundation-models-full-name }} is at the [Preview](../../../overview/concepts/launch-stages.md) stage._

In {{ foundation-models-full-name }}, you can tune {{ gpt-lite }} and {{ llama }} 8B^1^ text generation models.

{% include [logging](../../../_includes/foundation-models/yandexgpt/logging-disclaimer.md) %}

## Data required for tuning {#data}

{% include [fine-tuning-file-requirements](../../../_includes/datasphere/fine-tuning-file-requirements.md) %}

## Requests to fine-tuned models {#requests}

You can submit requests to a fine-tuned model through the [text generation API](../../text-generation/api-ref/index.md), [{{ assistant-api }}](../../assistants/api-ref/grpc/Assistant/index.md), or from {{ ml-platform-full-name }} and other applications. You can also use [{{ ml-sdk-full-name }}](../../sdk/index.md) to work with fine-tuned models: 

{% note info %}

To make sure the fine-tuned model works properly, specify the prompt used for training in the message with the `system` sender role.

{% endnote %}

To send API requests in [{{ ml-platform-name }}]({{ link-datasphere-main }}) notebooks, add the user or service account you are going to use for requests to the list of {{ ml-platform-name }} project members. The account must have the `ai.languageModels.user` role.

## Examples {#examples}

[{#T}](../../operations/tuning/create.md)
[{#T}](../../tutorials/models-fine-tuning.md)

^1^ {{ meta-disclaimer }}
