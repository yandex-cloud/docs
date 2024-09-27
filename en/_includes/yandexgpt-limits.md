#### Quotas {#yandexgpt-quotas}

Type of limit | Value
----- | -----
**[Text vectorization](../foundation-models/concepts/embeddings.md)** |
Number of text vectorization requests per second | 10
**[Text generation](../foundation-models/concepts/yandexgpt/index.md)** |
Number of concurrent generations | 1
Number of requests per second, [asynchronous mode](../foundation-models/concepts/index.md#working-mode) (request) | 10
Number of requests per second, asynchronous mode (getting a response) | 50
Number of requests per hour, asynchronous mode (request) | 5000
Number of [tokenization](../foundation-models/text-generation/api-ref/grpc/TokenizerService.md) requests per second | 50
**[Text classification](../foundation-models/concepts/classifier/index.md)** |
Number of text classification requests per second | 1
**[Image generation](../foundation-models/concepts/yandexart/index.md)** |
Number of generation requests per minute | 10
Number of generation requests per day | 500
Number of result requests per second | 50

#### Limits {#yandexgpt-limits}

Type of limit | Value
----- | -----
Period to store results of asynchronous requests on the server | 3 days
**[Text vectorization](../foundation-models/concepts/embeddings.md)** |
Number of input [tokens](../foundation-models/concepts/yandexgpt/tokens.md) | 2000
Output vector size | {{ emb-vector }}
**[Text generation](../foundation-models/concepts/yandexgpt/index.md)** |
Number of tokens per response | 2000 | 2000
Maximum number of tokens per response in the [management console]({{ link-console-main }}) | 500
Total number of tokens | {{ yagpt-max-tokens }}
Number of free requests per hour for users without a billing account. Available only in the management console | {{ gpt-freetier }}
**[Image generation](../foundation-models/concepts/yandexart/index.md)** |
Maximum [prompt](../foundation-models/concepts/index.md#prompt) length | 500 characters
Number of free requests per minute for users without a billing account. Available only in the management console | 2
Number of free requests per day for users without a billing account. Available only in the management console | {{ art-freetier }}