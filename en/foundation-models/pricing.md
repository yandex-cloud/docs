---
editable: false
---

# {{ foundation-models-full-name }} pricing

{{ foundation-models-full-name }} is at the [Preview](../overview/concepts/launch-stages.md) stage. The service is at the Preview stage and is billed according to the [Special Terms of Use](https://yandex.ru/legal/cloud_specialterms/?lang=en#index__section_fk5_d4c_cgb). You can find {{ yagpt-full-name }} usage details in {{ billing-name }} as {{ foundation-models-full-name }} resource usage.

In the [management console]({{ link-console-main }}), new users without a [billing account](../billing/concepts/billing-account.md) have access to models for testing:
* {{ yagpt-full-name }}: {{ gpt-freetier }} free requests per hour.
* {{ yandexart-name }}: {{ art-freetier }} free requests per day.

## What goes into the cost of using {{ foundation-models-full-name }} {#rules}

### Pricing unit {#unit}

{{ foundation-models-name }} usage is detailed out in _billing units_. The cost of a billing unit is different for text generation and vectorization.

### Text generation {#rules-generating}

Text generation cost is based on the overall number of [prompt](concepts/index.md#working-mode) and response [tokens](concepts/yandexgpt/tokens.md) and depends on the {{ yagpt-full-name }} request parameters. Namely, the cost depends on these parameters:

* [Model](concepts/yandexgpt/models.md) that gets a request.
* Model [working mode](concepts/index.md#working-mode).

The number of [prompt](concepts/index.md) and response [tokens](concepts/yandexgpt/tokens.md) for the same text may vary depending on model.

The total number of billing units is based on the overall number of prompt and response tokens and is rounded up to a whole number.

#### Tokenization {#rules-tokens}

The use of tokenizer ([TokenizerService](./text-generation/api-ref/grpc/TokenizerService.md) calls and [Tokenizer](./text-generation/api-ref/Tokenizer/index.md) methods) is not charged.

#### Fine-tuned models {#rules-tuned-generating}

The use of summary models is charged according to the {{ gpt-lite }} policy. The use of models fine-tuned in {{ ml-platform-full-name }} is charged according to the {{ gpt-pro }} policy.

### Text classification {#rules-text-classifier}

At the [Preview](../overview/concepts/launch-stages.md) stage, the use of classifiers based on {{ yagpt-name }} is free of charge.

### Text vectorization {#rules-embedding}

The cost of text vectorization (getting text embeddings) depends on the size of the text submitted for vectorization.

### Image generation {#rules-image-generation}

At the [Preview](../overview/concepts/launch-stages.md) stage, {{ yandexart-name }} is free of charge.

### Internal server errors {#error-request}

{% include [error-request](../_includes/speechkit/error-request.md) %}


## Pricing {#prices}


### Text generation in {{ yagpt-full-name }} {#pricing-generating}




{% include [usd-generating.md](../_pricing/yandexgpt/usd-generating_new.md) %}


### Text vectorization in {{ yagpt-full-name }} {#pricing-embedding}




{% include [usd-embedding.md](../_pricing/yandexgpt/usd-embedding.md) %}


## Examples of {{ yagpt-full-name }} usage cost calculation {#price-examples}

### Calculating text generation cost {#price-example-generating}

> Cost of using {{ yagpt-full-name }} for text generation with the following parameters:
> * Number of prompt tokens: 225
> * Number of response tokens: 525
> * Model: {{ gpt-lite }}
> * Model working mode: Synchronous

The cost is calculated as follows:
Number of prompt and response tokens: 225 + 525 = 750
Number of units per token for the {{ gpt-lite }} model in synchronous mode: 1
Total number of units in the usage breakdown: 750

Total: ($0.0016 / 1,000 units) × 750 units = $0.0015.


> Cost of using {{ yagpt-full-name }} for text generation with the following parameters:
> * Number of prompt tokens: 115
> * Number of response tokens: 1,500
> * Model: {{ gpt-pro }}
> * Model working mode: Asynchronous

The cost is calculated as follows:
Number of prompt and response tokens: 115 + 1,500 = 1,615
Cost of 1,000 tokens for the {{ gpt-pro }} model in asynchronous mode: $0.0048
Number of units per token for the {{ gpt-pro }} model in asynchronous mode: 3
Total number of units in the usage breakdown: 1,615 × 3 = 4,845

Total: ($0.0048 / 1,000 tokens) × 1,615 tokens = $0.007752.


> Cost of using {{ yagpt-full-name }} for text generation with the following parameters:
> * Number of prompt tokens: 1,020
> * Number of response tokens: 30
> * {{ gpt-pro }} model fine-tuned in {{ ml-platform-name }}
> * Model working mode: Synchronous

The cost is calculated as follows:
Number of prompt and response tokens: 1,020 + 30 = 1,050
Cost of 1,000 tokens for the model fine-tuned in {{ ml-platform-name }}, synchronous mode: $0.0096
Number of units per token for the model fine-tuned in {{ ml-platform-name }}, synchronous mode: 6
Total number of units in the usage breakdown: 1,050 × 6 = 6,300

Total: ($0.0016 / 1,000 units) × 6,300 units = $0.01008 **or** ($0.0096 / 1,000 tokens) × 1,050 tokens = $0.01008.


### Calculating text vectorization cost {#price-example-embedding}

> Cost of using {{ yagpt-name }} for text vectorization with the following parameters:
> * Number of tokens in the request: 2,000

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

