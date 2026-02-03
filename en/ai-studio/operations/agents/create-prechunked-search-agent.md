---
title: Creating an AI agent with search based on pre-created chunks
description: Follow this guide to create a text agent in {{ foundation-models-full-name }} to search for information in pre-chunked and pre-uploaded knowledge base files.
---

# Creating a text agent with search based on pre-created chunks

With [{{ vector-store-name }}](../../concepts/search/vectorstore.md), you can upload into the search index not only whole files but also pre-created data chunks in [JSONL](https://jsonlines.org/) format. This gives you full control over the data structure and improves the search and generative response accuracy by avoiding potential loss of meaning due to automatic fragmentation of documents.

## Getting started {#before-begin}

To use an example:

{% list tabs group=programming_language %}

- Python {#python}

  1. [Create](../../../iam/operations/sa/create.md) a service account and [assign](../../../iam/operations/sa/assign-role-for-sa.md) the `ai.assistants.editor` and `ai.languageModels.user` [roles](../../security/index.md#service-roles) to it.
  1. [Get](../get-api-key.md#run-client) and save the service account's [API key](../../../iam/concepts/authorization/api-key.md) with `yc.ai.foundationModels.execute` as the specified [scope](../../../iam/concepts/authorization/api-key.md#scoped-api-keys).

      {% include [sdk-windows-wsl-notice](../../../_includes/ai-studio/sdk-windows-wsl-notice.md) %}

  1. {% include [sdk-before-begin-step3](../../../_includes/ai-studio/sdk-before-begin-step3.md) %}
  1. {% include [sdk-before-begin-step4](../../../_includes/ai-studio/sdk-before-begin-step4.md) %}
  1. {% include [sdk-before-begin-step5](../../../_includes/ai-studio/sdk-before-begin-step5.md) %}
  1. Install the OpenAI [library](https://github.com/openai/openai-python) for Python:

      ```bash
      pip install openai
      ```

{% endlist %}

## Fragment the information {#fragment-info}

Split the information you want to upload into the search index into fragments. One fragment may contain a maximum of 8,000 characters. Save the resulting fragments in JSON Lines format as `"body":"<fragment_content>"` pairs. Here is an example:

```json
{ "body": "How to recover a password? Go to the password recovery page and enter your email." }
{ "body": "Can I work offline? Yes, the application supports offline mode." }
```

Save the resulting text fragments to a file named `chunks.jsonl`.

## Upload the file to {{ vector-store-name }} {#upload-file}

Before you create a search index, upload the resulting file in JSON Lines format to {{ vector-store-name }}:

{% list tabs group=programming_language %}

- Python {#python}

  1. Create a file named `upload.py` and paste the following code into it:

      ```python
      import pathlib
      import openai
      from openai import OpenAI

      YANDEX_API_KEY = "<API_key>"
      YANDEX_FOLDER_ID = "<folder_ID>"
      filename = "chunks.jsonl"


      # Local file for indexing
      def local_path(path: str) -> pathlib.Path:
          return pathlib.Path(__file__).parent / path


      def main():
          client = OpenAI(
              api_key=YANDEX_API_KEY,
              base_url="https://rest-assistant.{{ api-host }}/v1",
              project=YANDEX_FOLDER_ID,
          )

          print("Uploading the file...")

          with open(local_path(filename), "rb") as file:
              f = client.files.create(
                  file=(filename, file, "application/jsonlines"),
                  purpose="assistants",
                  expires_after=openai.types.file_create_params.ExpiresAfter(
                      anchor="created_at", seconds=3600
                  ),
                  extra_body={"format": "chunks"},
              )

          print(f"{filename} uploaded:", f.id)


      if __name__ == "__main__":
          main()
      ```

      Where:

      * `YANDEX_API_KEY`: Service account [API key](../../../iam/concepts/authorization/api-key.md) you got before you started.
      * `YANDEX_FOLDER_ID`: ID of the [folder](../../../resource-manager/operations/folder/get-id.md) for operations with the {{ vector-store-name }} API.

  1. Run the file you created:

      ```bash
      python3 upload.py
      ```

      Result:

      ```text
      Uploading the file...
      File chunks.jsonl uploaded: fvtnmsqdn2pq********
      ```

      Save the uploaded file's ID. You will need it later to create a search index.

{% endlist %}

## Create a {{ vector-store-name }} search index {#create-index}

Create a search index from the file uploaded in the previous step:

{% list tabs group=programming_language %}

- Python {#python}

  1. Create a file named `index.py` and paste the following code into it:

      ```python
      import time
      from openai import OpenAI

      YANDEX_API_KEY = "<API_key>"
      YANDEX_FOLDER_ID = "<folder_ID>"
      input_file_ids = ["<file_ID>"]


      def main():
          client = OpenAI(
              api_key=YANDEX_API_KEY,
              base_url="https://rest-assistant.{{ api-host }}/v1",
              project=YANDEX_FOLDER_ID,
          )

          # Creating a search index with several files
          print("Creating a search index...")
          vector_store = client.vector_stores.create(
              # Descriptive index name
              name="Support knowledge base",
              # Your file labels
              metadata={"key": "value"},
              # Index lifetime
              # last_active_at: since last active
              expires_after={"anchor": "last_active_at", "days": 1},
              # or created_at: since created
              # expires_after={"anchor": "created_at", "days": 1},
              file_ids=input_file_ids,  # <- list of files
          )
          vector_store_id = vector_store.id
          print("Vector store created:", vector_store_id)

          # Waiting for the search index to get ready
          while True:
              vector_store = client.vector_stores.retrieve(vector_store_id)
              print("Vector store status:", vector_store.status)
              if vector_store.status == "completed":
                  break
              time.sleep(2)

          print("Vector store is ready for use.")


      if __name__ == "__main__":
          main()
      ```

      Where `input_file_ids` is a list of IDs of uploaded source files. In our example, a single source file ID you got in the previous step will be added to the array.

  1. Run the file you created:

      ```bash
      python3 index.py
      ```

      Result:

      ```text
      Creating a search index...
      Vector store created: fvtol0geat8g********
      Vector store status: in_progress
      Vector store status: in_progress
      Vector store status: in_progress
      Vector store status: in_progress
      Vector store status: in_progress
      Vector store status: completed
      Vector store is ready for use.
      ```

      Save the index ID. You will need it later to execute a search query.

{% endlist %}

## Create an AI agent with index search {#use-search-index}

For the agent to be able to use the index you created, provide index ID in the `client.responses.create()` method's `tools` parameter:

{% list tabs group=programming_language %}

- Python {#python}

  1. Create a file named `query.py` and paste the following code into it:

      ```python
      import openai
      import json

      YANDEX_API_KEY = "<API_key>"
      YANDEX_FOLDER_ID = "<folder_ID>"
      VECTOR_STORE_ID = "<search_index_ID>"
      QUERY_TEXT = "How to recover a password?"
      YANDEX_CLOUD_MODEL = "yandexgpt"


      client = openai.OpenAI(
          api_key=YANDEX_API_KEY,
          base_url="https://rest-assistant.{{ api-host }}/v1",
          project=YANDEX_FOLDER_ID,
      )

      response = client.responses.create(
          model=f"gpt://{YANDEX_FOLDER_ID}/{YANDEX_CLOUD_MODEL}",
          instructions="You are a smart assistant. If asked about how to use the app, search through the connected index",
          tools=[{"type": "file_search", "vector_store_ids": [VECTOR_STORE_ID]}],
          input=QUERY_TEXT,
      )

      # Response for the user
      print("Response text:")
      print(response.output_text)
      print("\n" + "=" * 50 + "\n")

      # Full response
      print("Full response (JSON):")
      print(json.dumps(response.model_dump(), indent=2, ensure_ascii=False))
      ```

      Where `VECTOR_STORE_ID` is the {{ vector-store-name }} search index ID you got in the previous step.

  1. Run the file you created:

      ```bash
      python3 query.py
      ```

      Result:

      {% cut "Example of a brief response" %}

      ```text
      Response text:
      Go to the password recovery page and enter your email.
      ```

      {% endcut %}

      {% cut "Example of a full response" %}

      ```json
      Full response (JSON):
      {
        "id": "d70f114f-77c3-427b-b3cd-b70c********",
        "created_at": 1764746460.0,
        "error": null,
        "incomplete_details": null,
        "instructions": "You are a smart assistant. If asked about how to use the app, search in the connected index",
        "metadata": null,
        "model": "gpt://b1gt6g8ht345********/yandexgpt",
        "object": "response",
        "output": [
          {
            "id": "f170da63-5f61-4f9b-a4ba-49d4********",
            "queries": [
              "How to recover a password?"
            ],
            "status": "completed",
            "type": "file_search_call",
            "results": [
              {
                "attributes": {},
                "file_id": "fvtq3f79gjc7********",
                "filename": "chunks.jsonl",
                "score": 0.9034204,
                "text": "How to recover a password? Go to the password recovery page and enter your email.",
                "valid": true
              },
              {
                "attributes": {},
                "file_id": "fvtq3f79gjc7********",
                "filename": "chunks.jsonl",
                "score": 0.29538444,
                "text": "Can I work offline? Yes, the application supports offline mode.",
                "valid": true
              }
            ],
            "valid": true
          },
          {
            "id": "40d3b1e3-ffe6-4c8f-b332-ed71********",
            "content": [
              {
                "annotations": [
                  {
                    "file_id": "fvtq3f79gjc7********",
                    "filename": "chunks.jsonl",
                    "index": 0,
                    "type": "file_citation",
                    "valid": true
                  },
                  {
                    "file_id": "fvtq3f79gjc7********",
                    "filename": "chunks.jsonl",
                    "index": 0,
                    "type": "file_citation",
                    "valid": true
                  }
                ],
                "text": "Go to the password recovery page and enter your email.",
                "type": "output_text",
                "logprobs": null,
                "valid": true
              }
            ],
            "role": "assistant",
            "status": "completed",
            "type": "message",
            "valid": true
          }
        ],
        "parallel_tool_calls": true,
        "temperature": null,
        "tool_choice": "auto",
        "tools": [
          {
            "type": "file_search",
            "vector_store_ids": [
              "fvtneupef1s8********"
            ],
            "filters": null,
            "max_num_results": null,
            "ranking_options": null,
            "valid": true
          }
        ],
        "top_p": null,
        "background": false,
        "conversation": null,
        "max_output_tokens": null,
        "max_tool_calls": null,
        "previous_response_id": null,
        "prompt": null,
        "prompt_cache_key": null,
        "prompt_cache_retention": null,
        "reasoning": null,
        "safety_identifier": null,
        "service_tier": null,
        "status": "completed",
        "text": null,
        "top_logprobs": null,
        "truncation": null,
        "usage": {
          "input_tokens": 232,
          "input_tokens_details": {
            "cached_tokens": 0,
            "valid": true
          },
          "output_tokens": 8,
          "output_tokens_details": {
            "reasoning_tokens": 0,
            "valid": true
          },
          "total_tokens": 240,
          "valid": true
        },
        "user": "",
        "valid": true
      }
      ```

      {% endcut %}

{% endlist %}


#### See also {#see-also}

* [{#T}](./create-filesearch-text-agent.md)