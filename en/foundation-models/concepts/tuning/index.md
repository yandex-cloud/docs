---
title: Model tuning in {{ foundation-models-full-name }}
description: With {{ foundation-models-full-name }}, you can tune {{ gpt-lite }} and {{ llama }} 8b-1 text generation models and {{ gpt-lite }}-based classifiers using the {{ lora }} method.
---

# Model tuning

With {{ foundation-models-full-name }}, you can tune {{ gpt-lite }} and {{ llama }} 8b^1^ text generation models and {{ gpt-lite }}-based [classifiers](../classifier/index.md) using the [{{ lora }}](https://arxiv.org/abs/2106.09685) (_Low-Rank Adaptation of Large Language Models_) method.

_Model tuning in {{ foundation-models-full-name }} is at the [Preview](../../../overview/concepts/launch-stages.md) stage._

## Fine-tuning text generation models {#tuning-abilities}

{% include [tuning-abilities](../../../_includes/foundation-models/yandexgpt/tuning-abilities.md) %}


## Fine-tuning in {{ foundation-models-name }} {#fm-tuning}

For more information on tuning data requirements, see [{#T}](./generating.md) and [{#T}](./classifier.md).

You need to upload the prepared data to {{ yandex-cloud }} as a [_dataset_](../../dataset/api-ref/grpc/index.md). By default, you can upload up to 5 GB of tuning data into one dataset. For all limitations, see [{#T}](../limits.md).

After you upload a dataset, [start tuning](../../tuning/api-ref/grpc/Tuning/tune.md) by specifying its type and parameters (optional). Tuning can take from 1 to 24 hours depending on the amount of data and system workload.

For a model tuning example, see [{#T}](../../operations/tuning/create.md).

You will need an `ai.editor` [role](../../security/index.md) for model tuning in {{ foundation-models-name }}. This role allows you to upload data and start the tuning process.

## Examples {#examples}

[{#T}](../../operations/tuning/create.md).

^1^ {{ meta-disclaimer }}