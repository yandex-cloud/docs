---
title: '{{ vector-store-name }} search indexes in {{ foundation-models-full-name }}'
description: In this section, you will learn about {{ vector-store-name }} search indexes you can use to implement vector search across knowledge bases in {{ foundation-models-full-name }} AI agents.
---

# {{ vector-store-name }} search indexes

[AI agents](../agents/index.md) can perform semantic search in the context obtained from external knowledge base files. This additional context is stored in {{ vector-store-name }} _search indexes_, which are dedicated {{ foundation-models-full-name }} vector storages created using the {{ vector-store-name }} API and where documents are represented as vectors ([embeddings](../embeddings.md)).

## Creating an index {#creating-index}

To create a search index, upload source files for the knowledge base into {{ vector-store-name }} and index them.

### Uploading files {#file-uploading}

In {{ vector-store-name }}, you can [upload](../../operations/agents/manage-searchindex.md#upload-files) up to 10,000 files with the maximum size of 128 MB per file. A single file can be included into multiple {{ vector-store-name }} search indexes at the same time.

{% include [searchindex-filetypes](../../../_includes/ai-studio/searchindex-filetypes.md) %}

### Indexing the uploaded files {#file-indexing}

When [creating](../../operations/agents/manage-searchindex.md#create-index) {{ vector-store-name }} search indexes, the uploaded files are automatically broken down into fragments which the embedding model, in turn, transforms into numeric vectors. A vector reflects the semantic meaning of a fragment, which allows searching the index not only by matching words, but also by semantic relevance.

When fragmenting the information, the semantics are ignored, so the text may be split mid-sentence. This creates incomplete context. To minimize information loss due to broken context, some text in adjacent fragments _overlaps_.

{% note tip %}

To avoid possible loss of meaning when fragmenting files, you can do it yourself and upload the chunks to the search index in [JSONL](https://jsonlines.org/) format. One fragment may contain a maximum of 8,000 characters. For more information, see [{#T}](../../operations/agents/create-prechunked-search-agent.md).

{% endnote %}

By default, when creating {{ vector-store-name }} search indexes, the standard {{ foundation-models-name }} [embedding models](../embeddings.md#yandexgpt-embeddings) are used. To improve vector search quality depending on the input file features, you may use [fine-tuned embedding models](../../operations/tuning/create-embeddings.md).

After you finish processing all the files and vectorizing all the resulting text fragments, the search index will be ready to use.

Here are the possible states of the {{ vector-store-name }} search index creation process:

* `in_progress`: Breaking the uploaded files down into fragments and vectorizing them.
* `completed`: Search index is ready to use.
* `failed`: Error occurred while creating the search index.

## Using the search index {#using-index}

You can use search indexes to implement a retrieval augmented generation ([RAG](https://en.wikipedia.org/wiki/Retrieval-augmented_generation)) scenario based on information from external sources, in which the [text generation model](../generation/models.md) will provide a response using the information from the search index.

You can add a {{ vector-store-name }} search index to an [AI agent](../agents/index.md) using the {{ retrieval-tool-name }} tool via the {{ responses-api }} or [{{ realtime-api }}](../agents/realtime.md#realtime-api). 

A [search](../../operations/agents/manage-searchindex.md#search-index) through a {{ vector-store-name }} index will return:
* List of relevant text fragments.

    A search through a {{ vector-store-name }} index ([similarity search](https://en.wikipedia.org/wiki/Similarity_search)) returns a list with the specified number of the most semantically relevant vectors (the `Top-k` method). 
* Relevance score for every fragment in the list.
* Fragment metadata.

    You can apply filters by _metadata_, i.e., additional search index attributes specified when creating a {{ vector-store-name }} index. Search index metadata are objects with `<key>:<value>` pairs. They can extend the search context with additional information, e.g., data category, update date, special labels, etc.

## Managing a search index {#managing-index}

You can add new files to existing {{ vector-store-name }} search indexes and [remove](../../operations/agents/manage-searchindex.md#remove-file) files from them. 

The {{ vector-store-name }} API enables you to set up automatic deletion of unused search indexes. To do this, in the `expires_after` field, specify a value for any one of these properties:
* `created_at`: Sets the search index lifetime since its creation.
* `last_active_at`: Sets the search index lifetime since its last use.

After the time specified in the `expires_after` field expires, the search index will be deleted automatically. You also can [delete](../../operations/agents/manage-searchindex.md#delete-index) a {{ vector-store-name }} search index manually at any moment.

## Possible use cases for {{ vector-store-name }} search indexes {#use-cases}

You can integrate {{ vector-store-name }} search indexes with AI agents to implement various use cases:

* **AI bot for customer service to answer common questions**

    * The knowledge base with instructions and answers to common customer questions is uploaded to a {{ vector-store-name }} search index.
    * The search index is connected to the AI agent.
    * The user asks a question: `How much luggage may I carry?`.
    * The search finds the relevant fragment in the knowledge base: `One bag up to 23 kg`.
    * The AI agent returns the response with a link to the document.

* **Internal corporate knowledge base**

    * Regulations, policies, and product guides are uploaded to a {{ vector-store-name }} search index.
    * A request to the search index returns semantically relevant answers even if the wordings do not fully match.

        For example, for the `dismissal` keyword, the system will find documents with such wordings as `employment termination` or `labor contract dissolution`.

* **Call center AI assistant**

    * The knowledge base with instructions and answers to common customer questions is uploaded to a {{ vector-store-name }} search index.
    * During a call, the agent types or says a question: `How do I reset the user password?`.
    * The AI agent connected to a search index immediately provides the relevant steps from the knowledge base.

* **Analysis of large documents**

    * Reports, studies, or contracts are uploaded to a {{ vector-store-name }} search index.
    * Send your request to the search index to quickly find the relevant fragments: `Show all mentions of KPIs for 2024`.
    
        This is especially helpful when processing hundreds of pages of information.

* **Chat with an AI agent based on corporate documents**

    * The AI agent is connected to a {{ vector-store-name }} search index containing the corporate knowledge base.
    * An employee asks a question to the AI agent: `Explain how the product return process works`.
    * The AI agent gets relevant fragments of documentation and uses them to provide a detailed and correct response.

* **Local search in applications**

    * A corporate application, e.g., a [CRM](https://en.wikipedia.org/wiki/Customer_relationship_management) system or [Wiki](https://en.wikipedia.org/wiki/Wiki), uses a {{ vector-store-name }} search index to search through internal content.
    * The user asks a question in a free form and finds relevant records even if the words do not match exactly.

* **Multi-language search**

    * The same {{ vector-store-name }} search index stores documents in English and Russian.
    * For the `baggage allowance` request, the index will also return fragments in Russian.

* **Integration with analytics**

    * [Call](../../../speechkit/stt/index.md) or chat transcripts are uploaded to a {{ vector-store-name }} search index.
    * The {{ vector-store-name }} API allows you to find similar customer tickets.
    * You can quickly group the obtained information, analyze it, find the most common questions, and identify problems.

Clearly, {{ vector-store-name }} search indexes are a versatile tool which can assist both users and chatbots with internal search, document analysis, and integration into corporate business processes (customer support, analytics, employee training, etc.).

#### See also {#see-also}

* [{#T}](../assistant/files.md)
* [{#T}](../../operations/agents/manage-searchindex.md)
* [{#T}](../../operations/assistant/create-with-searchindex.md)