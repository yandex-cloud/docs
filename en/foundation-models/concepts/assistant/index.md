---
title: '{{ assistant-api }}'
description: '{{ assistant-api }} is a tool for creating AI assistants. You can use it to set up an RAG scenario and develop an assistant for querying your knowledge base.'
---

# {{ assistant-api }}

{% include [assistants-preview-stage](../../../_includes/foundation-models/assistants-preview-stage.md) %}

{{ assistant-api }} is a tool for creating AI assistants. It can be used to create personalized assistants, implement a generative response scenario with access to information from external sources (known as _retrieval augmented generation_, or [RAG](https://en.wikipedia.org/wiki/Retrieval-augmented_generation)), and save the model's request context.


You can create your AI assistant using the [{{ ml-sdk-full-name }}](../../sdk/index.md) or through API requests in a programming language.

To use {{ assistant-api }} in {{ foundation-models-full-name }}, you need the `ai.assistants.editor` and `ai.languageModels.user` [roles](../../security/index.md#service-roles) or higher for the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder).

## Assistant components {#content}

{{ assistant-api }} offers a number of abstractions for building a custom chatbot or AI assistant. 

[_Assistant_](../../assistants/api-ref/grpc/Assistant/index.md) determines which model to use and what parameters and instructions to apply. This enables you to configure the model just once and use those settings in the future without needing to provide them every time.

[_Threads_](../../threads/api-ref/grpc/index.md) are used to maintain the historical context of user communication. Each user chat makes an individual thread. By [_running_](../../runs/api-ref/grpc/index.md) your assistant for a specific thread, you call the model and provide it with all the context stored in the thread. [Listen](../../runs/api-ref/grpc/Run/listen.md) the current run for intermediate generation results; the final response, once generated, will become part of the thread.

{% note tip %}

By default, each time the model starts running, it will reprocess the content of the thread. If a thread holds some large context and you start the assistant after each user message, running it can grow rather expensive. To optimize costs, consider limiting the size of the context to provide: set the [`customPromptTruncationOptions`](../../runs/api-ref/grpc/Run/create.md) parameter when starting your assistant.

For detailed costs of running an assistant, see [Assistant pricing policy](../../pricing.md#rules-assistant).

{% endnote %}

### Handling external information sources {#files}

For your model to use external information sources to respond to requests, upload supplementary data files through the [Files API](../../files/api-ref/grpc/index.md) and [create](../../searchindex/api-ref/grpc/SearchIndex/create.md) a [_search index_](./search-index.md) for them. You can upload up to 10,000 files with the maximum size of 128 MB per file. A single file can be included in multiple search indexes at the same time. 

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

[Markdown](https://en.wikipedia.org/wiki/Markdown) is the optimal search index source as many models are trained on this format and are more likely to interpret it correctly. Use the [docling](https://github.com/DS4SD/docling) [Python](https://www.python.org/) library to convert files, even those with complex formatting, into Markdown. To learn more, see [{#T}](../../tutorials/pdf-searchindex-ai-assistant.md).

{% note info %}

All uploaded files and search indexes are subject to expiration. When uploading a file, use the [ExpirationConfig](../../files/api-ref/grpc/File/create.md#yandex.cloud.ai.common.ExpirationConfig) parameter to configure the expiration period. By default, a file not used for seven days is deleted.

{% endnote %}

When you create a search index, you define the [type of search](./search-index.md#search-types) it will support. [Full-text](./search-index.md#text-search), [vector](./search-index.md#vector-search), and [hybrid](./search-index.md#hybrid-search) search types are supported. Indexing may take from a few seconds to several hours depending on the file type and size as well as service load. The files are indexed [asynchronously](../index.md#working-mode). The response to the request to create a serach index includes the [operation](../../../api-design-guide/concepts/async.md) ID. You can use it to find out when the search index will be ready.

Once a search index is created, you can configure an assistant to utilize it. In this case, the model will consider the contents of that search index and will primarily use information from it to generate responses.

### Source verification {#citations}

If the AI assistant uses search indexes with external information sources when generating a response, the model's answer contains _source citations_, i.e., the `citations` section with details about all the indexes, external files, and fragments used for the response.

When using {{ ml-sdk-name }}, source citations are available in the `citations` property of the `run` object. To get the source citations via the API, use the run ID and initiate the [Run.Get](../../runs/api-ref/Run/get.md) REST API method or the [RunService/Get](../../runs/api-ref/grpc/Run/get.md) gRPC API call. The section with source citations is also included in all assistant messages stored in the thread.

The `citations` section containing source citations has the following structure:
* `sources`: Array consisting of one or more fragments of source files that were used to generate the response:

    * `chunk`: Information on the file fragment that was used to generate the response:

        * `searchIndex`: Section of fields with information about the search index that includes the source file fragment used. This section contains the index ID, type, and other metadata, as well as information about index settings.
        * `sourceFile`: Section of fields with information about the source file, whose fragment was used to generate the response. This section contains the file ID and other metadata.
        * `content`: Section of fields with the fragment text that was used to generate the response.

To learn more about the `citations` section structure, see the [API reference](../../runs/api-ref/Run/create.md#yandex.cloud.ai.assistants.v1.runs.Run).

{% note tip %}

Once the search index is created, you can delete the files. However, if you do this, the information about the sources will be lost, and the `source` section will be returned empty. To keep source citations, do not delete the files used to build the search index.

{% endnote %}

For examples of how to work with source citations using the SDK and API, and for output examples, see [Creating an assistant with a search index](../../operations/assistant/create-with-searchindex.md#create-assistant).

#### See also {#see-also}

* [{#T}](../../operations/assistant/create.md)
* [{#T}](../../operations/assistant/create-with-searchindex.md)
* [{#T}](../../operations/assistant/request-chunked-response.md)