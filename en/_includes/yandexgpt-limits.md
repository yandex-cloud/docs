#### Quotas {#yandexgpt-quotas}

Type of limit | Value
----- | -----
**[Text vectorization](../foundation-models/concepts/embeddings.md)** |
Number of text vectorization requests per second | 10
**[Text generation](../foundation-models/concepts/yandexgpt/index.md)** |
Number of concurrent generations in [synchronous mode](../foundation-models/concepts/index.md#working-mode), {{ gpt-lite }} model | 10
Number of concurrent generations in synchronous mode, {{ gpt-pro }} model | 10
Number of concurrent generations, [{{ gpt-pro }} 32k](../foundation-models/concepts/yandexgpt/models.md#generation) | 1
Number of concurrent generations in synchronous mode, {{ llama }} 8b^1^ model | 10
Number of concurrent generations, {{ llama }} 70b model | 1
Number of requests per second, [asynchronous mode](../foundation-models/concepts/index.md#working-mode) (request) | 10
Number of requests per second, asynchronous mode (getting a response) | 50
Number of requests per hour, asynchronous mode (request) | 5,000
Number of [tokenization](../foundation-models/text-generation/api-ref/grpc/Tokenizer/index.md) requests per second | 50
**[Text classification](../foundation-models/concepts/classifier/index.md)** |
Number of text classification requests per second | 1
**[Image generation](../foundation-models/concepts/yandexart/index.md)** |
Number of generation requests per minute | 500
Number of generation requests per day | 5,000
Number of result requests per second | 50
**[Model tuning](../foundation-models/concepts/tuning/index.md)**
Number of uploaded datasets | 10 
Maximum size of one dataset | 5 GB
Total size of datasets | 300 GB
Number of fine-tuning runs per day | 10
Number of fine-tuning runs per hour | 3

#### Limits {#yandexgpt-limits}

Type of limit | Value
----- | -----
Period to store results of asynchronous requests on the server | 3 days
**[Text vectorization](../foundation-models/concepts/embeddings.md)** |
Number of input [tokens](../foundation-models/concepts/yandexgpt/tokens.md) | 2,000
Output vector size | {{ emb-vector }}
**[Text generation](../foundation-models/concepts/yandexgpt/index.md)** |
Maximum number of tokens in response via API | 2,000 
Maximum number of tokens per response in the [management console]({{ link-console-main }}) | 1,000
Total number of tokens in request and response, [3rd generation models](../foundation-models/concepts/yandexgpt/models.md) | {{ yagpt-max-tokens }}
Total number of tokens in request and response, synchronous mode of [4th generation models](../foundation-models/concepts/yandexgpt/models.md) | {{ yagpt-max-tokens }}
Total number of tokens in request and response, asynchronous mode of [4th generation models](../foundation-models/concepts/yandexgpt/models.md) | 32,000
Total number of tokens in request and response, {{ gpt-pro }} 32k model | 32,000
Number of free requests per hour for users without a billing account. Available only in the management console | {{ gpt-freetier }}
**[Assistants](../foundation-models/concepts/assistant/index.md)**|
Maximum number of assistants | 1,000
Maximum number of threads | 1,000
Maximum number of users | 10,000
Maximum number of files to upload | 1,000
Maximum file size | 128 MB
Maximum number of files per search index | 100
Maximum number of messages per thread | 10,000
Maximum number of search indexes | 1,000
Maximum number of indexing operations to run | 10
**[Image generation](../foundation-models/concepts/yandexart/index.md)** |
Maximum [prompt](../foundation-models/concepts/index.md#prompt) length | 500 characters
Number of free requests per minute for users without a billing account. Available only in the management console | 2
Number of free requests per day for users without a billing account. Available only in the management console | {{ art-freetier }}


^1^ {{ meta-disclaimer }}