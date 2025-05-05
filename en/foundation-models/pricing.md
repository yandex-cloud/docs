---
title: '{{ foundation-models-full-name }} pricing policy'
description: This article covers the {{ foundation-models-name }} pricing policy.
editable: false
---

# {{ foundation-models-full-name }} pricing policy



{% include [without-use-calculator](../_includes/pricing/without-use-calculator.md) %}

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}

{% include [not-charged-foundation-models](../_includes/pricing/price-formula/not-charged-foundation-models.md) %}

## What goes into the cost of using {{ foundation-models-full-name }} {#rules}

### Billing unit {#unit}

{{ foundation-models-name }} usage is detailed out in _billing units_. The cost of a billing unit is different for text [generation](./concepts/yandexgpt/index.md) and [vectorization](./concepts/embeddings.md).

### Text generation {#rules-generating}

Text generation cost is based on the total number of [prompt](concepts/index.md#working-mode) and response [tokens](concepts/yandexgpt/tokens.md) and depends on the parameters of your request to the generative model. Namely, the cost depends on the following:

* [Model](concepts/yandexgpt/models.md) that gets the request.
* The model's [operating mode](concepts/index.md#working-mode).

The number of [prompt](concepts/yandexgpt/tokens.md) and response [tokens](concepts/index.md) for the same text may vary depending on model.

When using models in batch processing mode, there is a minimum launch cost of 200,000 tokens.

The total number of billing units is based on the overall number of prompt and response tokens and is rounded up to a whole number.

#### Tokenization {#rules-tokens}

The use of tokenizer ([TokenizerService](./text-generation/api-ref/grpc/Tokenizer/index.md) calls and [Tokenizer](./text-generation/api-ref/Tokenizer/index.md) methods) is not charged.

#### Fine-tuned models {#rules-tuned-generating}

At the [Preview](../overview/concepts/launch-stages.md) stage, you can fine-tune models free of charge. The use of fine-tuned models is charged according to the base model's pricing policy:

* The use of models fine-tuned in {{ ml-platform-full-name }} is charged according to the {{ gpt-pro }} policy.
* The use of a fine-tuned {{ gpt-lite }} model is charged according to the {{ gpt-lite }} policy.
* The use of a fine-tuned {{ llama }} 8B model is charged according to the {{ llama }} 8B policy.

### Text classification {#rules-text-classifier}

The cost of text classification depends on the classification model you use and the number of [tokens](concepts/yandexgpt/tokens.md) you provide.

* When classifying with {{ gpt-lite }}, a billing unit is a request of up to 1,000 tokens.
* When classifying with {{ gpt-pro }} and fine-tuned classifiers, a billing unit is a request of up to 250 tokens.

Requests with less than one billing unit are rounded up to the next integer. Large texts are billed as multiple requests with rounding up.

> For example, classifying a text of 770 tokens with {{ gpt-lite }} will be billed as a single request, i.e., as one billing unit.
> The same 770-token text classified with {{ gpt-pro }} or a fine-tuned classifier will be billed as four requests.

### Text vectorization {#rules-embedding}

The cost of text [vectorization](./concepts/embeddings.md) (getting text embeddings) depends on the size of the text submitted for vectorization.

### Work of assistants {#rules-assistant}

At the [Preview](../overview/concepts/launch-stages.md) stage, you can use {{ assistant-api }} and store files free of charge; however, you will be charged for models according to the [text generation](#rules-generating) rules.

### Image generation {#rules-image-generation}

You are charged for each generation request in {{ yandexart-name }}. The requests are not idempotent; therefore, two requests with the same settings and generation prompt are two separate requests.

### Internal server errors {#error-request}

{% include [error-request](../_includes/speechkit/error-request.md) %}

## Prices for the Russia region {#prices}

{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

### Text generation {#pricing-generating}



{% include [rub-generating-units.md](../_pricing/yandexgpt/usd-generating_units.md) %}


#### Cost of using models in synchronous and asynchronous mode {#text-sync-async}



{% include [usd-generating.md](../_pricing/yandexgpt/usd-generating_new.md) %}


#### Cost of using models in batch processing mode {#batch}

When using models in batch processing mode, there is a minimum launch cost of 200,000 tokens.



{% include [usd-generating.md](../_pricing/yandexgpt/usd-generating-batch.md) %}


### Text classification {#pricing-classifier}



{% include [usd-classifier.md](../_pricing/yandexgpt/usd-classifier.md) %}


### Text vectorization {#pricing-embedding}



{% include [usd-embedding.md](../_pricing/yandexgpt/usd-embedding.md) %}


### Image generation {#pricing-image-generation}



{% include [usd-embedding.md](../_pricing/yandexgpt/usd-image.md) %}


## Examples of {{ gpt-lite }} and {{ gpt-pro }} usage cost calculation {#price-examples}

### Calculating text generation cost {#price-example-generating}

#### Example 1 {#example-generating-1}

Cost of using {{ gpt-lite }} for text generation with the following parameters:

* Number of prompt tokens: 225
* Number of response tokens: 525
* Model: {{ gpt-lite }}
* Model working mode: Synchronous


{% include [usd-generating-lite](../_pricing_examples/foundation-models/usd-generating-lite.md) %}

#### Example 2 {#example-generating-2}

Cost of using {{ gpt-pro }} for text generation with the following parameters:

* Number of prompt tokens: 115
* Number of response tokens: 1,500
* Model: {{ gpt-pro }}
* Model working mode: Asynchronous



{% include [usd-generating-pro](../_pricing_examples/foundation-models/usd-generating-pro.md) %}


#### Example 3 {#example-generating-3}

Cost of using {{ gpt-pro }} and {{ ml-platform-name }} for text generation with the following parameters:

* Number of prompt tokens: 1,020
* Number of response tokens: 30
* Model: {{ gpt-pro }} fine-tuned in {{ ml-platform-name }}
* Model working mode: Synchronous



{% include [usd-generating-pro-ml](../_pricing_examples/foundation-models/usd-generating-pro-ml.md) %}


### Calculating text vectorization cost {#price-example-embedding}

Cost of using {{ foundation-models-full-name }} for text vectorization with the following parameter:

* Number of tokens in the request: 2,000



{% include [usd-embedding-k1](../_pricing_examples/foundation-models/usd-embedding-k1.md) %}



