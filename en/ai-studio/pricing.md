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

### {{ model-gallery-name }} {#rules-model-gallery}

The cost of using the models depends on the [operating mode](concepts/generation/index.md#working-mode) and the number of [tokens](concepts/generation/tokens.md) for different consumption types:

* Input query tokens.
* Output model response tokens.
* Cached tokens, if certain information is re-used without additional computation, such as instructions for a model.
* Tool tokens provided to the model as a result of invoking any [tool](./concepts/agents/index.md#tools).

Caching is enabled automatically where possible and applicable. Caching is not guaranteed and does not apply to output tokens.

Tool tokens include all uncached tokens stored in the message history at the time the tool's results were transmitted. Tool tokens are calculated only for {{ ai-studio-name }} built-in tools and do not apply to the results of custom functions. [Use of tools](#rules-tools) is charged separately.

##### Synchronous mode {#common-instance-sync}



{% include [usd-common-sync](../_pricing/ai-studio/usd-common-instance-sync.md) %}


##### Asynchronous mode {#common-instance-async}



{% include [usd-common-sync](../_pricing/ai-studio/usd-common-instance-async.md) %}


#### Batch mode {#batch-instance}

With models in batch mode, the minimum cost per run is 200,000 tokens.



{% include [usd-generating.md](../_pricing/ai-studio/usd-batch-instance.md) %}


#### Dedicated instances {#rules-dedicated}

The cost of operation of a dedicated instance depends on the model and selected configuration. Dedicated instances are charged per second with rounding up to a billing unit. However, there is no charge for hardware maintenance and model deployment time.

_{{ price-per-hour-count-per-second }}_



{% include [usd-generating.md](../_pricing/ai-studio/usd-dedicated.md) %}


#### Fine-tuning {#rules-tuned-generating}

At the [Preview](../overview/concepts/launch-stages.md) stage, you can fine-tune models free of charge. A fine-tuned {{ gpt-lite }} model will cost the same as the basic {{ gpt-lite }} model.

#### Text tokenization {#rules-tokens}

The use of tokenizer ([TokenizerService](./text-generation/api-ref/grpc/Tokenizer/index.md) calls and [Tokenizer](./text-generation/api-ref/Tokenizer/index.md) methods) is free of charge.

#### Text vectorization {#rules-embedding}

The cost of text [vectorization](./concepts/embeddings.md) (getting text embeddings) depends on the size of the text submitted for vectorization. [{{ billing-name }}](../billing/operations/check-charges.md) breaks down the creation of embeddings in _vectorization units_. One unit equals one token.



{% include [usd-embedding.md](../_pricing/ai-studio/usd-embedding.md) %}


{#price-example-embedding}

{% cut "Example of cost calculation for text vectorization" %}

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



{% include [usd-classifier.md](../_pricing/ai-studio/usd-classifier.md) %}


#### Image generation {#rules-image-generation}

You are charged for each generation request in {{ yandexart-name }}. Requests are not idempotent; therefore, two requests with the same settings and generation prompt are considered as two separate requests.



{% include [usd-embedding.md](../_pricing/ai-studio/usd-image.md) %}


### {{ agents-atelier-name }} {#rules-agent}

#### Voice agents {#rules-voice-agents}

The cost of using voice agents consists of the following:

* Cost of speech recognition (incoming audio).
* Cost of speech synthesis (outgoing audio).
* Cost of text generation using the [speech-realtime-250923 model](#text-sync-async).
* Cost of [tool invocation](#rules-tools).



{% include [usd-speech-realtime.md](../_pricing/ai-studio/usd-speech-realtime.md) %}


{#price-example-voice-assistant}

{% cut "Example of cost calculation for a voice agent" %}

> Cost of using a voice agent per a 60-second session, where:
> * Input audio: 60 seconds
> * Output audio: 20 seconds
> * Number of generated tokens: 2,000


{% include [usd-voice-assistant-pro](../_pricing_examples/ai-studio/usd-voice-assistant-pro.md) %}

{% endcut %}

#### Text-based agents {#rules-assistant}

The cost of using text-based agents consists of the following:

* Consumption of tokens as per the pricing plans of the [{{ model-gallery-name }} models](#rules-generating).
* Cost of [tool invocation](#rules-tools).

#### Invoking tools in agents {#rules-tools}

{% note info %}

The cost of File Search invocations will change on March 12, 2026.

{% endnote %}



{% include [usd-tools](../_pricing/ai-studio/usd-tools.md) %}


### {{ ai-search-name }} {#ai-search}

Until March 12, 2026, storing search indexes and files uploaded to {{ ai-studio-name }} will be free or charge.

{% note info %}

The pricing policy below comes into effect on March 12, 2026.

{% endnote %}

The search index size is rounded up to the nearest whole gigabyte.

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}



{% include [usd-storage](../_pricing/ai-studio/usd-storage.md) %}


### {{ mcp-hub-name }} {#mcp-hub}

{% include [note-preview](../_includes/note-preview.md) %}

At the Preview stage, [MCP servers](./concepts/mcp-hub/index.md#servers) are free of charge. However, you may still be charged for tools created in MCP servers, such as [{{ sf-full-name }} function invocations](../functions/pricing.md#invoke).

When using external APIs, such as [Kontur.Focus](./concepts/mcp-hub/templates.md#kontur) or [amoCRM](./concepts/mcp-hub/templates.md#amocrm), you are charged directly by our respective partner.

### Internal server errors {#error-request}

{% include [error-request](../_includes/speechkit/error-request.md) %}

