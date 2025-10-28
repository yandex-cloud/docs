---
title: '{{ foundation-models-full-name }} pricing policy'
description: This article covers the {{ foundation-models-name }} pricing policy.
editable: false
---

# {{ foundation-models-full-name }} pricing policy



{% include [without-use-calculator](../_includes/pricing/without-use-calculator.md) %}

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

{% include [vat](../_includes/vat.md) %}

## What goes into the cost of using {{ foundation-models-full-name }} {#rules}

[In {{ billing-name }}](../billing/operations/check-charges.md), {{ foundation-models-name }} usage is detailed in _billing units_. The billing unit value is different for [generation](concepts/generation/index.md), [vectorization](./concepts/embeddings.md), and [dedicated instances](concepts/generation/dedicated-instance.md).

### Text generation {#rules-generating}

Text generation cost is based on the total number of [prompt](concepts/generation/index.md#working-mode) and response [tokens](concepts/generation/tokens.md) and depends on the parameters of your request to the generative model. Namely, the cost depends on the following:

* [Model](concepts/generation/models.md) that gets the request.
* The model's [operating mode](concepts/generation/index.md#working-mode).

The number of [prompt](concepts/index.md) and response [tokens](concepts/generation/tokens.md) for the same text may vary depending on the model.

With models in batch mode, the minimum cost per run is 200,000 tokens.

The total number of billing units is based on the overall number of prompt and response tokens and is rounded up to an integer.

#### Tokenization {#rules-tokens}

The use of tokenizer ([TokenizerService](./text-generation/api-ref/grpc/Tokenizer/index.md) calls and [Tokenizer](./text-generation/api-ref/Tokenizer/index.md) methods) is free of charge.

#### Fine-tuned models {#rules-tuned-generating}

At the [Preview](../overview/concepts/launch-stages.md) stage, you can fine-tune models free of charge. The use of fine-tuned models is charged according to the base model's pricing policy: the use of a fine-tuned {{ gpt-lite }} model is charged according to the {{ gpt-lite }} pricing policy.

### Dedicated instances {#rules-dedicated}

The cost of operation of a dedicated instance depends on the model and selected configuration. Dedicated instances are charged per second of operation, rounded up to the billing unit. At the same time, there is no charge for the period of hardware maintenance and model deployment.

_{{ price-per-hour-count-per-second }}_

### Text classification {#rules-text-classifier}

The cost of text classification depends on the classification model you use and the number of [tokens](concepts/generation/tokens.md) you provide.

* When classifying with {{ gpt-lite }}, a billing unit is a request of up to 1,000 tokens.
* When classifying with {{ gpt-pro }} and fine-tuned classifiers, a billing unit is a request of up to 250 tokens.

Requests with less than one billing unit are rounded up to the next integer. Large texts are billed as multiple requests with rounding up.

> For example, classifying a text of 770 tokens with {{ gpt-lite }} will be billed as a single request, i.e., as one billing unit.
> The same 770-token text classified with {{ gpt-pro }} or a fine-tuned classifier will be billed as four requests.

### Text vectorization {#rules-embedding}

The cost of text [vectorization](./concepts/embeddings.md) (getting text embeddings) depends on the size of the text submitted for vectorization.

### Using assistants and text agents {#rules-assistant}

You can use the {{ assistant-api }}, {{ responses-api }} and store files free of charge; however, you will be charged for models according to the [text generation](#rules-generating) rules.

### Using voice agents {#rules-voice-assistant}

The cost of using voice agents consists of your fees for speech recognition (input audio), speech synthesis (output audio), and text generation using the speech-realtime-250923.

### Image generation {#rules-image-generation}

You are charged for each generation request in {{ yandexart-name }}. Requests are not idempotent; therefore, two requests with the same settings and generation prompt are two separate requests.

### {{ mcp-hub-name }} {#mcp-hub}

{% include [note-preview](../_includes/note-preview.md) %}

At the Preview stage, [MCP servers](./concepts/mcp-hub/index.md#servers) are free of charge. However, you may still be charged for tools created in MCP servers. For example, [{{ sf-full-name }} function invocations](../functions/pricing.md#invoke).

When using external APIs, such as [Kontur.Focus](./concepts/mcp-hub/templates.md#kontur), or [amoCRM](./concepts/mcp-hub/templates.md#amocrm), you pay directly to the partner.

### Internal server errors {#error-request}

{% include [error-request](../_includes/speechkit/error-request.md) %}

## Prices for the Russia region {#prices}

{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

### Text generation {#pricing-generating}



{% include [rub-generating-units.md](../_pricing/yandexgpt/usd-generating_units.md) %}


#### Cost of using models in synchronous and asynchronous mode {#text-sync-async}



{% include [usd-generating.md](../_pricing/yandexgpt/usd-generating_new.md) %}


#### Cost of using models in batch mode {#batch}

With models in batch mode, the minimum cost per run is 200,000 tokens.



{% include [usd-generating.md](../_pricing/yandexgpt/usd-generating-batch.md) %}


#### Dedicated instances {#dedicated}

_{{ price-per-hour-count-per-second }}_



{% include [usd-generating.md](../_pricing/yandexgpt/usd-dedicated.md) %}


### Text classification {#pricing-classifier}



{% include [usd-classifier.md](../_pricing/yandexgpt/usd-classifier.md) %}


### Text vectorization {#pricing-embedding}



{% include [usd-embedding.md](../_pricing/yandexgpt/usd-embedding.md) %}


### Using voice agents {#voice-assistant}



{% include [usd-speech-realtime.md](../_pricing/yandexgpt/usd-speech-realtime.md) %}


### Image generation {#pricing-image-generation}



{% include [usd-embedding.md](../_pricing/yandexgpt/usd-image.md) %}


## Examples of the {{ gpt-lite }} and {{ gpt-pro }} usage cost calculation {#price-examples}

### Calculating the text generation cost {#price-example-generating}

#### Example 1 {#example-generating-1}

Cost of using {{ gpt-lite }} for text generation with the following properties:

* Number of prompt tokens: 225
* Number of response tokens: 525
* Model: {{ gpt-lite }}
* Model working mode: Synchronous


{% include [usd-generating-lite](../_pricing_examples/ai-studio/usd-generating-lite.md) %}

#### Example 2 {#example-generating-2}

Cost of using {{ gpt-pro }} for text generation with the following properties:

* Number of prompt tokens: 115
* Number of response tokens: 1,500
* Model: {{ gpt-pro }}
* Model working mode: Asynchronous



{% include [usd-generating-pro](../_pricing_examples/ai-studio/usd-generating-pro.md) %}


#### Example 3 {#example-generating-3}

Cost of using {{ gpt-pro }} and {{ ml-platform-name }} for text generation with the following properties:

* Number of prompt tokens: 1,020
* Number of response tokens: 30
* Model: {{ gpt-pro }} fine-tuned in {{ ml-platform-name }}
* Model working mode: Synchronous



{% include [usd-generating-pro-ml](../_pricing_examples/ai-studio/usd-generating-pro-ml.md) %}


### Calculating the text vectorization cost {#price-example-embedding}

Cost of using {{ foundation-models-full-name }} for text vectorization with the following property:

* Number of tokens per request: 2,000



{% include [usd-embedding-k1](../_pricing_examples/ai-studio/usd-embedding-k1.md) %}



## Voice agent cost calculation example {#price-example-voice-assistant}

Cost of using the speech-realtime-250923 voice agent within a 60-second session:

* Input audio: 60 seconds
* Output audio: 20 seconds
* Number of tokens: 2,000



{% include [usd-voice-assistant-pro](../_pricing_examples/ai-studio/usd-voice-assistant-pro.md) %}


