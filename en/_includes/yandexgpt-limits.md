#### Quotas {#yandexgpt-quotas}

#|
|| **Type of limit** | **Value** ||
|| **{{ agents-atelier-name }}** {#agent-atelier-quotas} | > ||
|| [Voice agents]({{ link-docs-ai }}ai-studio/concepts/agents/realtime) {#voice-agents-quotas} |  ||
|| Number of concurrent sessions with Realtime models | 10 ||
|| Number of session creation requests per second | 10 ||
|| [Workflows]({{ link-docs-ai }}ai-studio/concepts/workflows/workflow) {#workflows-quotas} |  ||
|| Maximum number of [workflows]({{ link-docs-ai }}ai-studio/concepts/workflows/workflow) per cloud | 30 ||
|| Maximum number of active [workflow executions]({{ link-docs-ai }}ai-studio/concepts/workflows/execution) per cloud | 100 ||
|| Maximum execution duration | 48 hours ||
|| **{{ agent-core-name }}** {#agent-core-quotas} | > ||
|| [Code execution]({{ link-docs-ai }}ai-studio/concepts/agents/tools/code-interpreter) {#code-interpreter-quotas} |  ||
|| Number of concurrent {{ code-interpreter }} launches | 3 ||
|| [MCP servers]({{ link-docs-ai }}ai-studio/concepts/mcp-hub/index) {#mcp-server-quotas} |  ||
|| Number of MCP servers per cloud | 30 ||
|| Number of tools per server | 150 ||
|| [Search indexes]({{ link-docs-ai }}ai-studio/concepts/search/vectorstore) {#search-index-quotas} |  ||
|| Number of search indexes | 150 ||
|| **{{ model-gallery-name }}** {#model-gallery-quotas} | > ||
|| [Text generation]({{ link-docs-ai }}ai-studio/concepts/generation/index) {#text-generation-quotas} |  ||
|| Number of concurrent generations in synchronous mode without a subscription | 2 ||
|| Number of requests per second, asynchronous mode (request) | 10 ||
|| Number of requests per second, asynchronous mode (getting a response) | 50 ||
|| Number of requests per hour, asynchronous mode (request) | 5,000 ||
|| Number of tokenization requests per second | 50 ||
|| [Text classification]({{ link-docs-ai }}ai-studio/concepts/classifier/index) {#text-classification-quotas} |  ||
|| Number of text classification requests per second | 1 ||
|| [Text vectorization]({{ link-docs-ai }}ai-studio/concepts/embeddings) {#text-embedding-quotas} |  ||
|| Number of text vectorization requests per second | 10 ||
|| [Image generation]({{ link-docs-ai }}ai-studio/concepts/generation/index) {#image-generation-quotas} |  ||
|| Number of generation requests per minute | 500 ||
|| Number of generation requests per day | 5,000 ||
|| Number of result requests per second | 50 ||
|| [Datasets]({{ link-docs-ai }}ai-studio/concepts/resources/dataset) {#datasets-quotas} |  ||
|| Number of uploaded datasets | 100 ||
|| Maximum size of one dataset | 5 GB ||
|| Total size of datasets | 300 GB ||
|| [Text translation]({{ link-docs-ai }}translate/concepts/index) {#translate-quotas} |  ||
|| Calls to one API method per second | 20 ||
|| Characters sent for translation or language detection per hour | 1 million ||
|| [Text recognition in images]({{ link-docs-ai }}vision/concepts/ocr/index) {#vision-quotas} |  ||
|| Number of requests per second, synchronous mode | 1 ||
|| Number of requests per second, asynchronous mode | 10 ||
|| Number of requests per second, asynchronous mode (getting operation status) | 50 ||
|| Number of requests per second, asynchronous mode (getting a response) | 50 ||
|| **Subscriptions** {#subscription-quotas} | > ||
|| Number of subscriptions per cloud | 0 ||
|#

#### Limits {#yandexgpt-limits}

#|
|| **Type of limit** | **Value** ||
|| **{{ agents-atelier-name }}** {#agent-atelier-limits} | > ||
|| [Text agents]({{ link-docs-ai }}ai-studio/concepts/agents/text-agents) {#text-agents-limits} |  ||
|| Maximum number of saved Responses API configurations | 1,000 ||
|| Number of agents per folder | 100 ||
|| Number of published channels per agent | 10 ||
|| Number of concurrent operations per cloud | 10 ||
|| Number of messages per minute in a single conversation | 40 ||
|| Number of messages per minute through a web widget or testing interface | 1,200 ||
|| [Workflows]({{ link-docs-ai }}ai-studio/concepts/workflows/workflow) {#workflows-limits} |  ||
|| Maximum step execution time | 10 minutes ||
|| Maximum step execution time, including retries | 24 hours ||
|| Maximum number of step retries | 100 ||
|| Maximum input and output data size per workflow step | 2 MB ||
|| **{{ agent-core-name }}** {#agent-core-limits} | > ||
|| [Code execution]({{ link-docs-ai }}ai-studio/concepts/agents/tools/code-interpreter) {#code-interpreter-limits} |  ||
|| Container code execution timeout | 20 minutes ||
|| Container lifetime timeout | 20 minutes ||
|| [MCP servers]({{ link-docs-ai }}ai-studio/concepts/mcp-hub/index) {#mcp-server-limits} |  ||
|| Number of active cloud connections per [availability zone]({{ link-docs }}/overview/concepts/geo-scope) | 500 ||
|| [File search]({{ link-docs-ai }}ai-studio/concepts/agents/tools/filesearch) {#file-search-limits} |  ||
|| Maximum number of uploaded files | 10,000 ||
|| Maximum file size | 128 MB ||
|| Number of files per upload | 100 ||
|| [Search indexes]({{ link-docs-ai }}ai-studio/concepts/search/vectorstore) {#search-index-limits} |  ||
|| Maximum number of files per search index | 10,000 ||
|| Maximum number of search indexes | 1,000 ||
|| Maximum number of concurrent indexing operations | 10 ||
|| Maximum length of user-defined chunks | 8,000 characters ||
|| **{{ model-gallery-name }}** {#model-gallery-limits} | > ||
|| [Text generation]({{ link-docs-ai }}ai-studio/concepts/generation/index) {#text-generation-limits} |  ||
|| Storage period for asynchronous text request results on the server | 3 days ||
|| Maximum number of tokens per response in [Playground]({{ link-console-ai }}/link/models) | 1,000 ||
|| Synchronous request execution timeout | 15 minutes ||
|| Background (asynchronous) request execution timeout from the start of execution ^1^ | 2 hours ||
|| [Text vectorization]({{ link-docs-ai }}ai-studio/concepts/embeddings) {#text-embedding-limits} |  ||
|| Number of input tokens | 2,048 ||
|| Output vector size | {{ emb-vector }} ||
|| [Text classification]({{ link-docs-ai }}ai-studio/concepts/classifier/index) {#text-classification-limits} |  ||
|| Number of classes in prompt-based classifiers | 20 ||
|| Number of classes in fine-tuned classifiers | 100 ||
|| [Image generation]({{ link-docs-ai }}ai-studio/concepts/generation/index) {#image-generation-limits} |  ||
|| Maximum prompt length | 500 characters ||
|| Storage period for generated images | 12 hours ||
|| [Text translation]({{ link-docs-ai }}translate/concepts/glossary) {#translate-limits} |  ||
|| Maximum number of pairs in a glossary | 50 ||
|| Maximum number of characters in a glossary | 20,000 Unicode characters ||
|| Maximum number of characters in a glossary for source and translated text separately | 10,000 Unicode characters ||
|| [Text recognition in images]({{ link-docs-ai }}vision/concepts/ocr/index) {#vision-limits} |  ||
|| Storage period for recognition results on the server | 3 days ||
|| Maximum file size for the OCR API | {{ ocr-max-filesize }} ||
|| Maximum image size | 20 megapixels (length × width) ||
|| Maximum number of pages in a PDF when using the OCR API in asynchronous mode | 200 ||
|#

When a timeout is exceeded, the operation ends with an error.

^1^ A background request may wait in a queue before execution. The maximum queue time is 24 hours.

In addition to the limits above, there are limits on the number of steps and the total input and output data size across all steps of a workflow. If these limits are exceeded, the workflow execution fails with an error.
