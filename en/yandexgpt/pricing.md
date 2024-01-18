---
editable: false
---

# {{ yagpt-full-name }} pricing

{{ yagpt-full-name }} is at the [Preview stage](../overview/concepts/launch-stages.md) and is part of {{ foundation-models-full-name }}. The service is at the Preview stage and is billed according to the [Special Terms of Use](https://yandex.ru/legal/cloud_specialterms/?lang=en#index__section_fk5_d4c_cgb). You can find {{ yagpt-full-name }} usage details in {{ billing-name }} as {{ foundation-models-full-name }} resource usage.

{% note warning %}

This pricing will become effective on December 6, 2023.

{% endnote %}

## What is included in the {{ yagpt-full-name }} cost {#rules}

### Pricing unit {#unit}

A pricing unit means a single billing unit. The cost of a billing unit is different for text generation and vectorization.

### Text generation {#rules-generating}

Text generation cost is based on the overall number of [prompt](concepts/index.md#working-mode) and response [tokens](concepts/tokens.md) and depends on the {{ yagpt-full-name }} request parameters. Namely, the cost depends on these parameters:

* [Model](concepts/models.md) that gets a request.
* Model [working mode](concepts/index.md#working-mode).

The number of [prompt](concepts/index.md) and response [tokens](concepts/tokens.md) for the same text may vary depending on model.

The number of billing units is based on the overall number of prompt and response tokens and is rounded up to a whole number after applying the multiplier.

### Text vectorization {#rules-embedding}

The cost of providing text as vectors, i.e., getting text embeddings, depends on the size of the text submitted for vectorization.

### Internal server errors {#error-request}

{% include [error-request](../_includes/speechkit/error-request.md) %}

## Examples of {{ yagpt-full-name }} usage cost calculation {#price-examples}

### Calculating text generation cost {#price-example-generating}

> In this example, we will calculate the cost of using {{ yagpt-name }} for text generation with the following parameters:
> * Number of prompt tokens: 20.
> * Number of response tokens: 32.
> * Model: {{ yagpt-name }} Lite.
> * Model working mode: Synchronous.
>
> The cost is calculated as follows:
>
> (20 + 32) × 1.0 × ($0.0032/1000) = $0.000166
>
> Total: $0.000166.

Where:
* 20: Number of prompt tokens.
* 32: Number of response tokens.
* 1.0: Multiplier for using the {{ yagpt-name }} Lite model in synchronous mode.
* $0.0032: Cost per 1,000 tokens.
* $0.0032/1000: Cost per token.


> Here is another example, where we will calculate the cost of using {{ yagpt-name }} for text generation with the following parameters:
> * Number of prompt tokens: 115.
> * Number of response tokens: 1,500.
> * Model: {{ yagpt-name }}.
> * Model working mode: Asynchronous.
>
> The cost is calculated as follows:
>
> (115 + 1500) × 2.5 = 4037.5 = 4038.0 (rounding up to the integer)
> 4038.0 × ($0.0032/1000) = $0.012922
>
> Total: $0.012922.

Where:
* 115: Number of prompt tokens.
* 1500: Number of response tokens.
* 2.5: Multiplier for using the {{ yagpt-name }} model in asynchronous mode.
* 4038.0: Total number of billing units.
* $0.0032: Cost per 1,000 tokens.
* $0.0032/1000: Cost per token.

### Calculating text vectorization cost {#price-example-embedding}

> In this example, we will calculate the cost of using {{ yagpt-name }} for text vectorization with the following parameters:
> * Number of tokens in the request: 2,000.
>
> The cost is calculated as follows:
>
> 2000 × 1.0 × ($0.00008/1000) = $0.00016
>
> Total: $0.00016.

Where:
* 2000: Number of tokens in the request.
* 1.0: Multiplier for using text vectorization.
* $0.00008: Cost per 1,000 tokens.
* $0.00008/1000: Cost per token.


## Pricing {#prices}

### Text generation in {{ yagpt-full-name }} {#pricing-generating}




{% include [usd-generating.md](../_pricing/yandexgpt/usd-generating.md) %}


### Text vectorization in {{ yagpt-full-name }} {#pricing-embedding}




{% include [usd-embedding.md](../_pricing/yandexgpt/usd-embedding.md) %}

