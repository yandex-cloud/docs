#### Quotas {#yandexgpt-quotas}

Type of limit | Value
----- | -----
**[Text vectorization](../ai-studio/concepts/embeddings.md)** |
Number of text vectorization requests per second | 10
**[Text generation](../ai-studio/concepts/generation/index.md)** |
Number of concurrent generations in [synchronous mode](../ai-studio/concepts/generation/index.md#working-mode) | 10
Number of requests per second, [asynchronous mode](../ai-studio/concepts/generation/index.md#working-mode) (request) | 10
Number of requests per second, asynchronous mode (getting a response) | 50
Number of requests per hour, asynchronous mode (request) | 5,000
Number of [tokenization](../ai-studio/text-generation/api-ref/grpc/Tokenizer/index.md) requests per second | 50
**Model working mode: Batch**
Number of runs per hour | 10
Number of runs per day | 100
**[Text classification](../ai-studio/concepts/classifier/index.md)** |
Number of text classification requests per second | 1
**[Image generation](../ai-studio/concepts/generation/index.md)** |
Number of generation requests per minute | 500
Number of generation requests per day | 5,000
Number of result requests per second | 50
**[Model tuning](../ai-studio/concepts/tuning/index.md)** |
Number of fine-tuning runs per day | 10
Number of fine-tuning runs per hour | 3
**[Datasets](../ai-studio/concepts/resources/dataset.md)** |
Number of uploaded datasets | 100 
Maximum size of one dataset | 5 GB
Total size of datasets | 300 GB
**[MCP servers](../ai-studio/concepts/mcp-hub/index.md#servers)**
Number of MCP servers per cloud | 30 
Number of [tools](../ai-studio/concepts/assistant/tools/index.md) per server | 50
**[Voice agents](../ai-studio/concepts/agents/realtime.md)** (`{{ realtime-model }}` [model](../ai-studio/concepts/agents/realtime.md#model)) |
Number of concurrent sessions with the model | 10
Number of session creation queries per second | 10

#### Limits {#yandexgpt-limits}

Type of limit | Value
----- | -----
Period to store results of asynchronous requests on the server | 3 days
**[Text vectorization](../ai-studio/concepts/embeddings.md)** |
Number of input [tokens](../ai-studio/concepts/generation/tokens.md) | 2,000
Output vector size | {{ emb-vector }}
**[Text generation](../ai-studio/concepts/generation/index.md)** |
Maximum number of tokens per response in the [management console]({{ link-console-main }}) | 1,000
**[Assistants](../ai-studio/concepts/assistant/index.md)**|
Maximum number of assistants | 1,000
Maximum number of threads | 10,000
Maximum number of users | 10,000
Maximum number of files to upload | 10,000
Maximum file size | 128 MB
Number of files per upload | 100
Maximum number of files per search index | 10,000
Maximum number of messages per thread | 100,000
Maximum number of search indexes | 1,000
Maximum number of indexing operations to run | 10
**[Image generation](../ai-studio/concepts/generation/index.md)** |
Maximum [prompt](../ai-studio/concepts/index.md#prompt) length | 500 characters
**[MCP servers](../ai-studio/concepts/mcp-hub/index.md#servers)**
Number of active cloud connections per [availability zone](../overview/concepts/geo-scope.md) | 500
