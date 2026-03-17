#### Quotas {#yandexgpt-quotas}

Type of limit | Value
----- | -----
**Text vectorization** |
Number of text vectorization requests per second | 10
**Dedicated instances** |
Number of concurrent dedicated instances | 1 
**Text generation** |
Number of concurrent generations in synchronous mode | 10
Number of requests per second, asynchronous mode (request) | 10
Number of requests per second, asynchronous mode (getting a response) | 50
Number of requests per hour, asynchronous mode (request) | 5,000
Number of tokenization requests per second | 50
**Model working mode: Batch**
Number of runs per hour | 10
Number of runs per day | 100
**Text classification** |
Number of text classification requests per second | 1
**Image generation** |
Number of generation requests per minute | 500
Number of generation requests per day | 5,000
Number of result requests per second | 50
**Model tuning** |
Number of fine-tuning runs per day | 10
Number of fine-tuning runs per hour | 3
**Datasets** |
Number of uploaded datasets | 100 
Maximum size of one dataset | 5 GB
Total size of datasets | 300 GB
**MCP servers** |
Number of MCP servers per cloud | 30 
Number of tools per server | 50
**Voice agents** (`{{ realtime-model }}` model) |
Number of concurrent sessions with the model | 10
Number of session creation queries per second | 10
**AI agents** |
Number of concurrent {{ code-interpreter }} launches | 3

#### Limits {#yandexgpt-limits}

Type of limit | Value
----- | -----
Period to store results of asynchronous requests on the server | 3 days
**Text vectorization** |
Number of input tokens | 2,048
Output vector size | {{ emb-vector }}
**Text generation** |
Maximum number of tokens per response in [AI Playground]({{ link-console-ai }}) | 1,000
**Text classification** |
Number of classes in prompt-based classifiers | 20
Number of classes in fine-tuned classifiers | 100
**Image generation** |
Maximum prompt length | 500 characters
**AI agents**|
Maximum number of agents | 1,000
Maximum number of files to upload | 10,000
Maximum file size | 128 MB
Number of files per upload | 100
Maximum number of files per search index | 10,000
Maximum number of search indexes | 1,000
Maximum number of indexing operations to run | 10
Maximum length of user chunks | 8,000 characters
**MCP servers**
Number of active cloud connections per [availability zone]({{ link-docs }}/overview/concepts/geo-scope) | 500
