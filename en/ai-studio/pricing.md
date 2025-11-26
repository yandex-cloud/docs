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

## Prices for the Russia region {#prices}

{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

### {{ model-gallery-name }} {#rules-generating}

The cost of using {{ model-gallery-name }} models depends on:
* [Model's operating mode](concepts/generation/index.md#working-mode).
* Number of incoming and outgoing [tokens](concepts/generation/tokens.md). The [token](concepts/generation/tokens.md) count of the same text may vary from one model to the next.

[{{ billing-name }} represents](../billing/operations/check-charges.md) the use of {{ model-gallery-name }} models in _billing units_. The total number of billing units is rounded up to an integer.



{% include [rub-generating-units.md](../_pricing/yandexgpt/usd-generating_units.md) %}


#### Using common instance models {#text-sync-async}



{% include [usd-generating.md](../_pricing/yandexgpt/usd-generating_new.md) %}


{#example-generating}

{% cut "Cost calculation for a model in synchronous mode" %}

> Request parameters:
> * Number of prompt tokens: 225
> * Number of response tokens: 525
> * Model: {{ gpt-lite }}
> * Model operating mode: Synchronous


{% include [usd-generating-lite](../_pricing_examples/ai-studio/usd-generating-lite.md) %}

{% endcut %}

{% cut "Cost calculation for a model in asynchronous mode" %}

> Request parameters:
> * Number of prompt tokens: 115
> * Number of response tokens: 1,500
> * Model: {{ gpt-pro }}
> * Model operating mode: Asynchronous



{% include [usd-generating-pro](../_pricing_examples/ai-studio/usd-generating-pro.md) %}


{% endcut %}

#### Using models in batch mode {#batch}

With models in batch mode, the minimum cost per run is 200,000 tokens.



{% include [usd-generating.md](../_pricing/yandexgpt/usd-generating-batch.md) %}


#### Operation of dedicated instances {#rules-dedicated}

The cost of operation of a dedicated instance depends on the model and selected configuration. Dedicated instances are charged per second with rounding up to a billing unit. However, there is no charge for hardware maintenance and model deployment time.

_{{ price-per-hour-count-per-second }}_



{% include [usd-generating.md](../_pricing/yandexgpt/usd-dedicated.md) %}


#### Fine-tuning {#rules-tuned-generating}

At the [Preview](../overview/concepts/launch-stages.md) stage, you can fine-tune models free of charge. A fine-tuned {{ gpt-lite }} model will cost the same as the basic {{ gpt-lite }} model.

#### Text tokenization {#rules-tokens}

The use of tokenizer ([TokenizerService](./text-generation/api-ref/grpc/Tokenizer/index.md) calls and [Tokenizer](./text-generation/api-ref/Tokenizer/index.md) methods) is free of charge.

#### Text vectorization {#rules-embedding}

The cost of text [vectorization](./concepts/embeddings.md) (getting text embeddings) depends on the size of the text submitted for vectorization. [{{ billing-name }} represents](../billing/operations/check-charges.md) the creation of embeddings in _vectorization units_. 



{% include [usd-embedding.md](../_pricing/yandexgpt/usd-embedding.md) %}


{#price-example-embedding}

{% cut "Cost calculation for text vectorization" %}

> The cost of vectorizing a text of 2,000 tokens will be:



{% include [usd-embedding-k1](../_pricing_examples/ai-studio/usd-embedding-k1.md) %}


{% endcut %}

#### Text classifications {#rules-text-classifier}

The cost of text classification depends on the classification model you use and the number of [tokens](concepts/generation/tokens.md) you provide.

* When classifying with {{ gpt-lite }}, a billing unit is a request of up to 1,000 tokens.
* When classifying with {{ gpt-pro }} and fine-tuned classifiers, a billing unit is a request of up to 250 tokens.

Requests with less than one billing unit are rounded up to the next integer. Large texts are billed as multiple requests with rounding up.

> For example, classifying a text of 770 tokens with {{ gpt-lite }} will be billed as a single request, i.e., as one billing unit.
> The same 770-token text classified with {{ gpt-pro }} or a fine-tuned classifier will be billed as four requests.



{% include [usd-classifier.md](../_pricing/yandexgpt/usd-classifier.md) %}


#### Image generation {#rules-image-generation}

You are charged for each generation request in {{ yandexart-name }}. Requests are not idempotent; therefore, two requests with the same settings and generation prompt are two separate requests.



{% include [usd-embedding.md](../_pricing/yandexgpt/usd-image.md) %}


### {{ agents-atelier-name }} {#rules-agent}

#### Using assistants and text agents {#rules-assistant}

The {{ assistant-api }}, {{ responses-api }}, and the storage of files and search indexes are free of charge. For tokens you pay as per {{ model-gallery-name }} [model](#rules-generating) pricing plans. 

#### Using voice agents {#rules-voice-agents}

The cost of using voice agents consists of your fees for speech recognition (input audio), speech synthesis (output audio), and text generation using the speech-realtime-250923.



{% include [usd-speech-realtime.md](../_pricing/yandexgpt/usd-speech-realtime.md) %}


{#price-example-voice-assistant}

{% cut "Cost calculation for a voice agent" %}

> Cost of using a voice agent per a 60-second session, where:
> * Input audio: 60 seconds
> * Output audio: 20 seconds
> * Number of generated tokens: 2,000



{% include [usd-voice-assistant-pro](../_pricing_examples/ai-studio/usd-voice-assistant-pro.md) %}



{% endcut %}

#### Using tools in agents {#rules-tools}

The {{ assistant-api }} tools are free of charge. 

The File Search tool in text and voice agents is free of charge.

The Web Search tool in text and voice agents is free of charge until November 17, 2025. 

{% note info %}

The prices will apply starting November 20, 2025.

{% endnote %}



{% include [usd-embedding.md](../_pricing/yandexgpt/usd-tools.md) %}


### {{ mcp-hub-name }} {#mcp-hub}

{% include [note-preview](../_includes/note-preview.md) %}

At the Preview stage, [MCP servers](./concepts/mcp-hub/index.md#servers) are free of charge. However, you may still be charged for tools created in MCP servers. For example, [{{ sf-full-name }} function invocations](../functions/pricing.md#invoke).

When using external APIs, such as [Kontur.Focus](./concepts/mcp-hub/templates.md#kontur), or [amoCRM](./concepts/mcp-hub/templates.md#amocrm), you pay directly to the partner.

### Internal server errors {#error-request}

{% include [error-request](../_includes/speechkit/error-request.md) %}

