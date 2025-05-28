---
title: Model tuning in {{ foundation-models-full-name }}
description: With {{ foundation-models-full-name }}, you can tune {{ gpt-lite }} and {{ llama }} 8B text generation models and {{ gpt-lite }}-based classifiers using the {{ lora }} method.
---

# Model tuning

With {{ foundation-models-full-name }}, you can tune {{ gpt-lite }} and {{ llama }} 8B^1^ text generation models, {{ gpt-lite }}-based [classifiers](../classifier/index.md), and the [embedding](../embeddings.md) model using the [{{ lora }}](https://arxiv.org/abs/2106.09685) (_Low-Rank Adaptation of Large Language Models_) method.

_Model tuning in {{ foundation-models-full-name }} is at the [Preview](../../../overview/concepts/launch-stages.md) stage._

## Fine-tuning text generation models {#tuning-abilities}

{% include [tuning-abilities](../../../_includes/foundation-models/yandexgpt/tuning-abilities.md) %}


## Fine-tuning in {{ foundation-models-name }} {#fm-tuning}

For more information on tuning data requirements, see [{#T}](../resources/dataset.md#generating) and [{#T}](../resources/dataset.md#classifier).

You need to upload the prepared data to {{ yandex-cloud }} as a [_dataset_](../resources/dataset.md). By default, you can upload up to 5 GB of tuning data into one dataset. For all limitations, see [{#T}](../limits.md).

After you upload a dataset, [start tuning](../../tuning/api-ref/grpc/Tuning/tune.md) by specifying its type and parameters (optional). Tuning can take from 1 to 24 hours depending on the amount of data and system workload.

For a model tuning example, see [{#T}](../../operations/tuning/create.md).

You will need an `ai.editor` [role](../../security/index.md) for model tuning in {{ foundation-models-name }}. This role allows you to upload data and start the tuning process.

## Requests to fine-tuned models {#requests}

Once you complete tuning your model, you will get its ID. Provide this ID in the `modelUri` field of the request body. You can submit requests to a fine-tuned text generation model through the [text generation API](../../text-generation/api-ref/index.md), [{{ assistant-api }}](../../assistants/api-ref/grpc/Assistant/index.md), or from {{ ml-platform-full-name }} and other applications. To send a request to a fine-tuned classifier, use the [classify](../../text-classification/api-ref/TextClassification/classify.md) Text Classification API method. You can also use [{{ ml-sdk-full-name }}](../../sdk/index.md) to work with fine-tuned models: 

{% note info %}

To make sure the fine-tuned model works properly, specify the prompt used for training in the message with the `system` sender role.

{% endnote %}

To send API requests in [{{ ml-platform-name }}]({{ link-datasphere-main }}) notebooks, add the user or service account you are going to use for requests to the list of {{ ml-platform-name }} project members. The account must have the `ai.languageModels.user` role.

## Use cases {#examples}

* [{#T}](../../operations/tuning/create.md)
* [{#T}](../../operations/tuning/tune-classifiers.md)
* [{#T}](../../tutorials/models-fine-tuning.md)

^1^ {{ meta-disclaimer }}