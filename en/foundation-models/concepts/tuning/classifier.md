---
title: Tuning classification models
description: In {{ foundation-models-full-name }}, you can tune classifiers based on {{ gpt-lite }}.
---

# Tuning classification models

_Model tuning in {{ foundation-models-full-name }} is at the [Preview](../../../overview/concepts/launch-stages.md) stage._

In {{ foundation-models-full-name }}, you can tune classifiers based on {{ gpt-lite }}.

{% include [logging](../../../_includes/foundation-models/yandexgpt/logging-disclaimer.md) %}

## Data required for tuning {#data}

For classifier tuning based on {{ gpt-lite }}, prepare a [UTF-8](https://jsonlines.org/) encoded file in [JSON Lines](https://en.wikipedia.org/wiki/UTF-8) format with examples of texts and their classifications. The data structure in the examples will depend on the [type of classification](../classifier/index.md) the model is trained for.

{% include [classifier-training](../../../_includes/datasphere/classifier-training.md) %}

## Requests to fine-tuned models {#requests}

After completing the training, you will get the ID of the model tuned for classification needs. Provide this ID in the `modelUri` field of the request body in the Text Classification API [classify](../../text-classification/api-ref/TextClassification/classify.md) method. You can also use [{{ ml-sdk-full-name }}](../../sdk/index.md) to work with fine-tuned classifiers.

{% note info %}

To make sure the fine-tuned model works properly, specify the prompt used for training in the message with the `system` sender role.

{% endnote %}

To send API requests in [{{ ml-platform-name }}]({{ link-datasphere-main }}) notebooks, add the user or service account you are going to use for requests to the list of {{ ml-platform-name }} project members. The account must have the `ai.languageModels.user` role.

## Examples {#examples}

[{#T}](../../operations/tuning/tune-classifiers.md)

