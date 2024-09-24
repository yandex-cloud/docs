---
editable: false
---

# {{ yagpt-full-name }} pricing policy

{% include [without-use-calculator](../_includes/pricing/without-use-calculator.md) %}

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}

{{ yagpt-full-name }} is at the [Preview stage](../overview/concepts/launch-stages.md) and is part of {{ foundation-models-full-name }}. The service is billed according to the [Special Terms of Use](https://yandex.ru/legal/cloud_specialterms/?lang=en#index__section_fk5_d4c_cgb). You can find {{ yagpt-full-name }} usage details in {{ billing-name }} as {{ foundation-models-full-name }} resource usage. 

In the [management console]({{ link-console-main }}/link/yandexgpt), {{ gpt-freetier }} free prompts per hour are available to new users without a [billing account](../billing/concepts/billing-account.md).

## What goes into the cost of using {{ yagpt-full-name }} {#rules}

### Billing unit {#unit}

Pricing is based on a billing unit. The cost of a billing unit is different for text generation and vectorization.

### Text generation {#rules-generating}

Text generation cost is based on the overall number of [prompt](concepts/tokens.md) and response [tokens](concepts/index.md#working-mode) and depends on the {{ yagpt-full-name }} request parameters. Namely, the cost depends on the following:

* [Model](concepts/models.md) that gets the request.
* Model's [working mode](concepts/index.md#working-mode). 

The number of [prompt](concepts/index.md) and response [tokens](concepts/tokens.md) for the same text may vary depending on model.

The number of billing units is based on the overall number of prompt and response tokens and is rounded up to a whole number after applying the multiplier.

#### Fine-tuned models {#rules-tuned-generating}

The use of summary models is charged according to the {{ gpt-lite }} policy. The use of models fine-tuned in {{ ml-platform-full-name }} is charged according to the {{ gpt-pro }} policy.

### Text vectorization {#rules-embedding}

The cost of text vectorization (getting text embeddings) depends on the size of the text submitted for vectorization.

### Internal server errors {#error-request}

{% include [error-request](../_includes/speechkit/error-request.md) %}

## Examples of {{ yagpt-full-name }} usage cost calculation {#price-examples}


### Calculating text vectorization cost {#price-example-embedding}

> Cost of using {{ yagpt-name }} for text vectorization with the following parameters:
> * Number of tokens in the request: 2,000
>
> The cost is calculated as follows:
>
> 2,000 × 1.0 × ($0.00008/1,000) = $0.00016
>
> Total: $0.00016.

Where:
* 2,000: Number of tokens in the request.
* 1.0: Multiplier for using text vectorization.
* $0.00008: Cost per 1,000 tokens.
* $0.00008 / 1,000: Cost per token.


## Pricing {#prices}

### Text generation in {{ yagpt-full-name }} {#pricing-generating}




{% include [usd-generating.md](../_pricing/yandexgpt/usd-generating_new.md) %}


### Text vectorization in {{ yagpt-full-name }} {#pricing-embedding}




{% include [usd-embedding.md](../_pricing/yandexgpt/usd-embedding.md) %}

