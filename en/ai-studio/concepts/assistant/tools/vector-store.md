---
title: '{{ retrieval-tool-name }} in {{ assistant-api }}'
description: This section describes {{ retrieval-tool-name }}, an {{ assistant-api }} tool you can use to create personalized assistants able to implement a retrieval augmented generation scenario based on information retrieved from search indexes.
noIndex: true
---

# {{ retrieval-tool-name }}

{% include [assistants-do-not-use](../../../../_includes/ai-studio/ai-assistant-disclaimer.md) %}

{{ retrieval-tool-name }} enables the AI assistant to search for information for the response in your own files (knowledge base). {{ retrieval-tool-name }} comes with the specially trained [paraphrase model](../rephraser.md), which rephrases users' queries to improve search quality.

To enable your AI assistant to use your knowledge base:

1. Upload the knowledge base [files](../files.md) using the API or {{ ml-sdk-name }}.
1. Create a [search index](../search-index.md) for your files. After that, you can delete the files you uploaded if you do not need citations.
1. Connect the search index to your assistant. You can enable [citations](../files.md#citations) if the search index files are not deleted.
1. Optionally, [configure](../../../operations/assistant/create-with-searchindex.md) a strategy for using search indexes so that the assistant would access them only when required.
1. Optionally, [enable](../../../operations/assistant/rephraser.md) the paraphrase model as an additional layer in your assistant.

{% include [rag-default-strategy-paragraph](../../../../_includes/ai-studio/assistants/rag-default-strategy-paragraph.md) %}

AI assistants do not always need to use a search index to respond to a user’s query: the general information available to the model is often enough to answer most questions. You can set up your assistant to use a _{{ retrieval-tool-name }} access strategy_ for its model itself to decide when to use the index to search for information.

For your AI assistant to be able to use {{ retrieval-tool-name }} based on an access strategy:

{% list tabs group=programming_language %}

- SDK {#sdk}

  In [{{ ml-sdk-name }}](../../../sdk/index.md), provide a search index access instruction for the model in the `call_strategy` parameter when creating {{ retrieval-tool-name }}. Then, when creating the AI assistant, provide the resulting object with {{ retrieval-tool-name }} in the `tools` parameter.

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

  In the [API](../../api.md), when [creating](../../../assistants/api-ref/Assistant/create.md) or [updating](../../../assistants/api-ref/Assistant/update.md) an AI assistant, provide a search index access instruction for the model in the `tools` array of the request body in the `callStrategy` object.

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
              "instruction": "<search_usage_instruction>"
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
"instruction": "Search through the knowledge base only if the user has specifically asked you to do so."
```

#### See also {#see-also}

* [{#T}](../files.md)
* [{#T}](../search-index.md)
* [{#T}](../rephraser.md)
* [{#T}](../../../operations/assistant/create-with-searchindex.md)
* [{#T}](./web-search.md)