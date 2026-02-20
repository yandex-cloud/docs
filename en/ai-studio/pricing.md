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

{% note warning %}

The pricing provided below for the common instance and batch processing models are effective until March 3, 2026. Starting March 3, the [new pricing policy](#rules-new) will apply. 

{% endnote %}

The cost of using {{ model-gallery-name }} models depends on:
* [Model's operating mode](concepts/generation/index.md#working-mode).
* Number of input and output [tokens](concepts/generation/tokens.md). The [token](concepts/generation/tokens.md) count in the same text may vary from one model to another. Here is a [cost calculation example](#example-generating) for processing the same text in synchronous mode using different models.

[{{ billing-name }} breaks down](../billing/operations/check-charges.md) the use of {{ model-gallery-name }} models in _billing units_. The total number of billing units is rounded up to an integer.



{% include [rub-generating-units.md](../_pricing/yandexgpt/usd-generating_units.md) %}


#### Using common instance models until March 3, 2026 {#text-sync-async}



{% include [usd-generating.md](../_pricing/yandexgpt/usd-generating_new.md) %}


{#example-generating}

{% cut "Example of cost calculation for a model in synchronous mode" %}

> Request parameters:
> * Instruction: «Проанализируй предоставленный текст и выполни его комплексную грамотную редактуру. Твоя задача — устранить любые грамматические, орфографические, стилистические и пунктуационные ошибки, не изменяя при этом исходного смысла и структуры высказывания. Сохраняй оригинальный порядок слов и не вноси дополнительных уточнений, пояснений или переформулировок, которые могут изменить тон или содержание текста. Внесённые правки должны быть минимально необходимыми для того, чтобы предложение стало корректным с точки зрения русского языка. Также убедись, что все слова употреблены в нормативной форме, а знаки препинания соответствуют литературным стандартам»
> * Request text: «Нейрасети оптемезируют бизнес-працесы розгружают техпадержку ускаряют праверку документов аналис и абработку данных генирируют отчёты за минуты и прогназируют спрос.»
> * The model's response: «Нейросети оптимизируют бизнес‑процессы: разгружают техподдержку, ускоряют проверку документов, анализ и обработку данных, генерируют отчёты за минуты и прогнозируют спрос.»
> Количество символов на вход: 782


{% include [usd-generating-sync](../_pricing_examples/ai-studio/usd-generating-sync.md) %}

{% endcut %}

{% cut "Example of cost calculation for a model in asynchronous mode" %}

> Request parameters:
> * Number of prompt tokens: 115
> * Number of response tokens: 1,500
> * Model: {{ gpt-pro }}
> * Model operating mode: Asynchronous



{% include [usd-generating-pro](../_pricing_examples/ai-studio/usd-generating-pro.md) %}


{% endcut %}

#### Using models in batch mode until March 3, 2026 {#batch}

With models in batch mode, the minimum cost per run is 200,000 tokens.



{% include [usd-generating.md](../_pricing/yandexgpt/usd-generating-batch.md) %}


#### Using {{ model-gallery-name }} models starting March 3, 2026 {#rules-new}

{% note warning %}

This pricing for the common instance models and batch processing is effective as of March 3, 2026.

{% endnote %}

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



{% include [usd-generating.md](../_pricing/yandexgpt/usd-dedicated.md) %}


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



{% include [usd-classifier.md](../_pricing/yandexgpt/usd-classifier.md) %}


#### Image generation {#rules-image-generation}

You are charged for each generation request in {{ yandexart-name }}. Requests are not idempotent; therefore, two requests with the same settings and generation prompt are considered as two separate requests.



{% include [usd-embedding.md](../_pricing/yandexgpt/usd-image.md) %}


### {{ agents-atelier-name }} {#rules-agent}

#### Voice agents {#rules-voice-agents}

The cost of using voice agents consists of the following:

* Cost of speech recognition (incoming audio).
* Cost of speech synthesis (outgoing audio).
* Cost of text generation using the [speech-realtime-250923 model](#text-sync-async).
* Cost of [tool invocation](#rules-tools).



{% include [usd-speech-realtime.md](../_pricing/yandexgpt/usd-speech-realtime.md) %}


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

At the Preview stage, [MCP servers](./concepts/mcp-hub/index.md#servers) are free of charge. However, you may still be charged for tools created in MCP servers, such as [{{ sf-full-name }} function invocations]({{ link-docs }}/functions/pricing.md#invoke).

When using external APIs, such as [Kontur.Focus](./concepts/mcp-hub/templates.md#kontur) or [amoCRM](./concepts/mcp-hub/templates.md#amocrm), you are charged directly by our respective partner.

### Internal server errors {#error-request}

{% include [error-request](../_includes/speechkit/error-request.md) %}

