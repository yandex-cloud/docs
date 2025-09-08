# Paraphrasing queries

{{ assistant-api }} offers a model fine-tuned to correct typos and rephrase a query based on your chat history with the assistant. This is helpful when extensive search index data is used to generate responses in highly context-aware interactions.

You can connect the model as an additional tool for your assistant. For each new query, the paraphrase model will use the conversation context to decide whether the user's query has to be modified in any way before running a search on the connected search index and querying the main model. This means you do not need to edit your prompt to the assistant or give additional instructions to the paraphrase model.

| **Model** | **URI** | **Context** |
|---|---|---|
| **Paraphrasing** | `gpt://<folder_ID>/rephraser/latest` | 32,000 |

To use paraphrasing, add the `rephraser` tool to your assistant's list of tools. Requests to the paraphrase model are charged as per the [{{ gpt-lite }} pricing policy](../../pricing.md#rules-generating).

{% list tabs group=programming_language %}

- SDK {#sdk}

  ```python
  ...
  rephraser = sdk.tools.rephraser('rephraser', model_version='latest')
  sdk.tools.search_index(search_index, rephraser=True)
  ...
  ```

- cURL {#curl}

  ```json
  {
    "folderId": "<folder_ID>",
    "name": "<assistant_name>",
    },
    "labels": "object",
    "modelUri": "<assistant_model_URI>",
    "instruction": "<instruction>",
    ...
    "tools": [
      {
        "searchIndex": {
          "searchIndexIds": [
            "<search_index_ID>"
          ],
          "rephraserOptions": {
            "rephraserUri": "gpt://<folder_ID>/rephraser/latest"
          }
        }
      }
    ]
  }
  ```

{% endlist %}

To test the paraphrase model, you can [access](../../operations/generation/create-prompt.md) it directly.

## Usage example {#examples}

[{#T}](../../operations/assistant/rephraser.md)