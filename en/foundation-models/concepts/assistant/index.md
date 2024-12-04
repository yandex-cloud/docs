# {{ assistant-api }}

_The {{ assistant-api }} feature is at the [Preview](../../../overview/concepts/launch-stages.md) stage._

{{ assistant-api }} is a tool for creating AI assistants. These personalized assistants are proficient with generative response scenarios that adapt based on external information (known as _retrieval augmented generation_, or RAG), along with maintaining the query context.

Create your AI assistant using [{{ ml-sdk-full-name }}](../../sdk/index.md) or by means of API requests in a programming language.

## Assistant components {#content}

{{ assistant-api }} offers a number of abstractions for building a custom chatbot or AI assistant. 

[_Assistant_](../../assistants/api-ref/grpc/Assistant/index.md) determines which model to use and what parameters and instructions to apply. This enables you to configure the model just once and use those settings in the future without needing to provide them every time.

[_Threads_](../../threads/api-ref/grpc/index.md) are used to maintain the historical context of user communication. Each user chat makes an individual thread. By [_running_](../../runs/api-ref/grpc/index.md) your assistant for a specific thread, you call the model and provide it with all the context stored in the thread. [Listen](../../runs/api-ref/grpc/Run/listen.md) the current run for intermediate generation results; the final response, once generated, will become part of the thread. 

{% note tip %}

By default, each time the model starts running, it will reprocess the content of the thread. If a thread holds some large context and you start the assistant after each user message, running it can grow rather expensive. To optimize costs, consider limiting the size of the context to provide: set the [`customPromptTruncationOptions`](../../runs/api-ref/grpc/Run/create.md) parameter when starting your assistant.

For detailed costs of running an assistant, see [Assistant pricing policy](../../pricing.md#rules-assistant).

{% endnote %}

### Handling external information sources {#files}

To enable your model to leverage external information sources for answering queries, upload supplementary files through the [Files API](../../files/api-ref/grpc/index.md) and create an associated [_search index_](../../searchindex/api-ref/grpc/SearchIndex/create.md). You can upload up to 1,000 files, with maximum size of 128 MB per file. A single file can be included in multiple search indexes at the same time. Currently, a search index can include up to 100 files.

For all {{ assistant-api }} limitations, see [{#T}](../limits.md).

The upload feature supports the following [MIME types](https://en.wikipedia.org/wiki/Media_type): 

* `application/json`
* `application/msword`
* `application/pdf`
* `application/vnd.ms-excel`
* `application/vnd.ms-excel.sheet.2`
* `application/vnd.ms-excel.sheet.3`
* `application/vnd.ms-excel.sheet.4`
* `application/vnd.ms-excel.workspace.3`
* `application/vnd.ms-excel.workspace.4`
* `application/vnd.ms-outlook`
* `application/vnd.ms-powerpoint`
* `application/vnd.ms-project`
* `application/vnd.ms-word2006ml`
* `application/vnd.openxmlformats-officedocument.spreadsheetml.sheet`
* `application/vnd.openxmlformats-officedocument.wordprocessingml.document`
* `application/x-latex`
* `application/x-ms-owner`
* `application/xhtml+xml`
* `text/csv`
* `text/html`
* `text/markdown`
* `text/plain`
* `text/xml`
* `application/rtf`

{% note info %}

All uploaded files and search indexes are subject to expiration. When uploading a file, use the [ExpirationConfig](../../files/api-ref/grpc/File/create.md#yandex.cloud.ai.common.ExpirationConfig) parameter to configure the expiration period. By default, a file not used for seven days is deleted.

{% endnote %}

When you create a search index, you define the type of search it will support, with options for both full-text and vector searches. The indexing speed can vary based on the file types, their sizes, and the system load, taking from a few seconds to several hours. Files are indexed [asynchronously](../index.md#working-mode). When requested to create a search index, the service will return an [Operation](../../../api-design-guide/concepts/async.md) object. You can use that object to check the status of the index creation operation.

Once a search index is created, you can configure an assistant to utilize it. In this case, the model will consider the contents of that search index and will primarily use information from it to generate responses. 

#### See also {#see-also}

* [{#T}](../../operations/assistant/create.md)
* [{#T}](../../operations/assistant/create-with-searchindex.md)