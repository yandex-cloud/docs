---
editable: false
---

# {{ yagpt-full-name }} pricing

{{ yagpt-full-name }} is at the [Preview](../overview/concepts/launch-stages.md) stage and it is charged according to the [Special Terms of Use](https://yandex.ru/legal/cloud_specialterms/?lang=en#index__section_fk5_d4c_cgb).

{% note warning %}

This pricing will become effective on December 6, 2023.

{% endnote %}

## What is included in {{ yagpt-name }} cost {#rules}

### Pricing unit {#unit}

A pricing unit means a single billing unit. The cost of a billing unit is different for text generation and vectorization.

### Text generation {#rules-generating}

Text generation cost is based on the overall number of prompt and response tokens and depends on the {{ yagpt-name }} request parameters. Namely, the cost depends on these parameters:

* Model that is requested.
* Model working mode.

The number of prompt and response tokens for the same text may vary depending on the specific model.

The number of billing units is based on the overall number of prompt and response tokens and is rounded up to a whole number after applying the multiplier.

### Text vectorization {#rules-embedding}

The cost of providing text as vectors, i.e., getting text embeddings, depends on the size of the text being vectorized.

### Internal server errors {#error-request}

{% include [error-request](../_includes/speechkit/error-request.md) %}


## Pricing {#prices}

### Text generation in {{ yagpt-name }} {#pricing-generating}




{% include [usd-generating.md](../_pricing/yandexgpt/usd-generating.md) %}


### Text vectorization in {{ yagpt-name }} {#pricing-embedding}




{% include [usd-embedding.md](../_pricing/yandexgpt/usd-embedding.md) %}

