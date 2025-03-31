---
title: '{{ assistant-api }}'
description: '{{ assistant-api }} is a tool for creating AI assistants.'
---

# {{ assistant-api }}

{% include [assistants-preview-stage](../../../_includes/foundation-models/assistants-preview-stage.md) %}

{{ assistant-api }} is a tool for creating AI assistants. It can be used to create personalized assistants, implement a generative response scenario adapted based on external information (known as _retrieval augmented generation_, or RAG), and save the model's request context.

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

For your model to use external information sources to respond to requests, upload supplementary data files through the [Files API](../../files/api-ref/grpc/index.md) and [create](../../searchindex/api-ref/grpc/SearchIndex/create.md) a [_search index_](./search-index.md) for them. You can upload up to 10,000 files, with maximum size of 128 MB per file. A single file can be included in multiple search indexes at the same time.

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

When you create a search index, you define the [type of search](./search-index.md#search-types) it will support. Full-text, vector, and hybrid search types are supported. Indexing may take from a few seconds to several hours depending on the file type and size as well as service load. The files are indexed [asynchronously](../index.md#working-mode). The response to the request to create a serach index includes the [operation](../../../api-design-guide/concepts/async.md) ID. You can use it to find out when the search index will be ready.

Once a search index is created, you can configure an assistant to utilize it. In this case, the model will consider the contents of that search index and will primarily use information from it to generate responses. 

#### See also {#see-also}

* [{#T}](../../operations/assistant/create.md)
* [{#T}](../../operations/assistant/create-with-searchindex.md)