---
title: VectorStore in {{ assistant-api }}
description: This section describes VectorStore, a {{ assistant-api }} tool which enables you to create personalized assistants capable of generating responses based on information retrieved from search indexes.
---

# VectorStore

VectorStore enables an AI assistant to search your own files, i.e., a knowledge base, for information to use in a response. Together with VectorStore, you can use a tailored [paraphrase model](../rephraser.md), which rephrases user queries to improve search quality.

To enable your AI assistant to use your knowledge base:

1. Upload the knowledge base [files](../files.md) using the API or {{ ml-sdk-name }}.
1. Create a [search index](../search-index.md) for your files. After that, you can delete the files you uploaded if you do not need citations.
1. Connect the search index to your assistant. You can enable [citations](../files.md#citations) if the search index files are not deleted.
1. Optionally, [configure](../../../operations/assistant/create-with-searchindex.md) a strategy for using search indexes so that the assistant would access them only when required.
1. Optionally, [enable](../../../operations/assistant/rephraser.md) the paraphrase model as an additional layer in your assistant.

{% include [rag-default-strategy-paragraph](../../../../_includes/foundation-models/assistants/rag-default-strategy-paragraph.md) %}

AI assistants do not always need to use a search index to respond to a user’s query: the general information available to the model is often enough to answer most questions. When setting up your assistant, you can define a _strategy for accessing VectorStore_ so that the assistant’s model would decide on its own when it should search for information in the index.

To enable your AI assistant to use VectorStore according to an access strategy, do the following:

{% list tabs group=programming_language %}

- SDK {#sdk}

  In [{{ ml-sdk-name }}](../../../sdk/index.md), provide search index access instructions to the model in the `call_strategy` parameter when creating the VectorStore tool. Then, when creating your AI assistant, provide the resulting object with VectorStore in the `tools` parameter.

  ```python
  ...
  tool = sdk.tools.search_index(
      search_index,
      call_strategy={
          "type": "function",
          "function": {"name": "search-function-name", "instruction": "<search_usage_instructions>"},
      },
  )

  assistant = sdk.assistants.create(
      "yandexgpt", 
      instruction = "You are an internal corporate documentation assistant. Answer politely. If the information is not in the documents below, don't make up your answer.", 
      tools=[tool])
  thread = sdk.threads.create()
  ...
  ```

- cURL {#curl}

  In the [API](../../api.md), when [creating](../../../assistants/api-ref/Assistant/create.md) or [updating](../../../assistants/api-ref/Assistant/update.md) an AI assistant, provide search index access instructions to the model in the `tools` array of the request body in the `callStrategy` object.

  ```json
  {
    ...
    "tools": [
      {
        "searchIndex": {
          "searchIndexIds": [
            "<search_index_ID>"
          ],
          "maxNumResults": "<maximum_number_of_returned_fragments>",
          "callStrategy": {
            "autoCall": {
              "instruction": "<search_usage_instructions>"
            }
          }
        }
      }
    ]
  }
  ```

  Where:
  * `searchIndexIds`: Array with IDs of [search indexes](../search-index.md) the assistant will use. Currently, you can specify only one index.
  * `maxNumResults`: Maximum number of results a search can return.
  * `instruction`: Search usage instructions with guidelines for the assistant on when it should access the search index.

{% endlist %}

Search usage instructions which you provide in a strategy is essentially a [prompt](../../index.md#prompt) telling the assistant when it should access the search index. Here is an example:

```json
"instruction": "Search through the knowledge base only when the user specifically asks you to do so."
```

#### See also {#see-also}

* [{#T}](../files.md)
* [{#T}](../search-index.md)
* [{#T}](../rephraser.md)
* [{#T}](../../../operations/assistant/create-with-searchindex.md)
* [{#T}](./web-search.md)