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
Requests per second, asynchronous mode (getting a response) | 50
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
Number of tools per server | 150
**Text-based agents** |
Number of concurrent {{ code-interpreter }} launches | 3
**Voice agents** |
Number of concurrent sessions with Realtime models | 10
Number of session creation queries per second | 10
**Search indexes** |
Number of search indexes | 150
**{{ translate-name }}** {#translate-quotas}
Calls of one API method per second | 20
Characters sent for translation or language detection, per hour | 1 million
**{{ vision-name }}** {#vision-quotas} |
Requests per second, synchronous mode | 1
Requests per second, asynchronous mode | 10
Requests per second, asynchronous mode (getting an operation status) | 50
Requests per second, asynchronous mode (getting a response) | 50



#### Limits {#yandexgpt-limits}

Type of limit | Value
----- | -----
Storage period for results of text asynchronous requests on the server | 3 days
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
Storage period for generated images | 12 hours
**Text-based agents**|
Maximum number of agents | 1,000
Maximum number of files to upload | 10,000
Maximum file size | 128 MB
Number of files per upload | 100
Maximum number of files per search index | 10,000
Maximum number of search indexes | 1,000
Maximum number of indexing operations to run | 10
Maximum length of user chunks | 8,000 characters
**MCP servers** |
Number of active cloud connections per [availability zone]({{ link-docs }}/overview/concepts/geo-scope) | 500
**Operation timeouts** ^1^ |
Synchronous request execution timeout | 20 minutes
Container code execution timeout | 20 minutes
Container lifetime timeout | 20 minutes
Background (asynchronous) request execution timeout from the start of execution ^2^ | 2 hours
**{{ translate-name }}** {#translate-limits}
Maximum pairs provided per glossary | 50
Maximum number of characters per glossary | 20,000 Unicode characters
Maximum number of characters per glossary, separately for source and translated text | 10,000 Unicode characters
**{{ vision-name }}** {#vision-limits} |
Retention period for recognition results on the server | 3 days
Maximum file size for the OCR API | {{ ocr-max-filesize }}
Maximum image size | 20 megapixels (length × width)
Maximum number of pages in a PDF when using the OCR API in asynchronous mode | 200

^1^ As soon as a timeout is exceeded, the operation will be terminated with an error.
^2^ The execution of a background request may be delayed due to queuing. The maximum queue time is 24 hours.
