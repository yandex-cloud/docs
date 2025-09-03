---
title: '{{ assistant-api }}'
description: '{{ assistant-api }} is an interface for creating AI assistants. You can use it to set up an RAG scenario and develop an assistant for querying your knowledge base.'
keywords:
  - keyword: RAG
  - keyword: AI assistant
  - keyword: AI assistant
  - keyword: chat bot
---

# {{ assistant-api }}

{% include [assistants-preview-stage](../../../_includes/foundation-models/assistants-preview-stage.md) %}

{{ assistant-api }} is a {{ foundation-models-name }} tool for creating AI assistants. It can be used to create personalized assistants, implement a generative response scenario with access to information from external sources (known as _retrieval augmented generation_, or [RAG](https://en.wikipedia.org/wiki/Retrieval-augmented_generation)), and save the model's request context.

![ai-assistant](../../../_assets/foundation-models/ai-assistant.svg)

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

A [simple assistant](../../operations/assistant/create.md) may be of help in automating routine operations over various data. For example, if you have tailored an effective prompt and settings for a model, you can create an assistant and run it for different threads. However, your assistants can do much more if equipped with a number of supplementary _tools_.

With {{ assistant-api }}, your assistant can access RAG [tools](./tools/index.md) to retrieve information from external sources or function calling tools to invoke additional handlers and third-party APIs.

{% note info %}

The retention period for assistants, threads, search indexes, and users is limited. You can set this limit when creating an object using the `ExpirationConfig` parameter. By default, a file not used for seven days is deleted.

Once an object is created, you cannot change its retention period or policy.

{% endnote %}

## Use cases {#examples}

* [{#T}](../../operations/assistant/create.md)
* [{#T}](../../operations/assistant/create-with-searchindex.md)
* [{#T}](../../operations/assistant/request-chunked-response.md)
* [{#T}](../../tutorials/pdf-searchindex-ai-assistant.md)
* [{#T}](../../operations/assistant/create-with-labels.md)
* [{#T}](../../operations/assistant/rephraser.md)