---
title: Switching from the {{ assistant-api }} to {{ responses-api }}
description: Follow this guide to rebuild in the {{ responses-api }} your the existing AI assistants built based on the {{ assistant-api }} in {{ foundation-models-full-name }}.
---

# Switching from the {{ assistant-api }} to {{ responses-api }}

The {{ assistant-api }} allowed creating AI assistants that stored the context of communication with the user in threads, were able to use {{ retrieval-tool-name }} [tools](../assistant/tools/index.md) and WebSearch, and get intermediate responses from the model.

For new and current projects, we recommend using the {{ responses-api }}, which is a simple and flexible interface that allows saving the dialog context. The {{ responses-api }} has [built-in tools](./index.md#tools) for file and web search, offers its own feature set and integration with external tools via MCP servers for overall high performance.

{% note warning %}

Starting December 10, 2025, {{ ai-studio-full-name }}'s [{{ assistant-api }}](../assistant/index.md) functionality will no longer be supported and will be completely discontinued from January 26, 2026. You should migrate all your current projects to the {{ responses-api }} before January 26, 2026.

{% endnote %}

Follow this guide to convert your existing AI assistants built with the {{ assistant-api }} into {{ responses-api }}-based AI agents.

A {{ responses-api }} [_AI agent_](./index.md) is a model instance with a specified configuration: an instruction, configured tools, and communication context. An AI agent determines the model's behavior and how it communicates with users and other systems.

## Differences between the {{ assistant-api }} and {{ responses-api }} {#differences}

The concepts and tools used in the {{ assistant-api }} and {{ responses-api }} are different:

| **{{ assistant-api }}** | **{{ responses-api }}** |
| --- | --- |
| **Assistant**: AI assistant as a resource. | When using the API, no separate resource is created; all settings are provided directly in the `responses.create()` method. In the [management console]({{ link-console-main }}), you can save the AI agent configuration with a unique ID and then use it in the {{ responses-api }}. |
| **Thread**: Dialog thread. | There are no threads that contain the context of all messages. You can provide the conversation history as the context of the new `response` call in the `previous_response_id` field. |
| **Run**: Run of the AI assistant for a thread. | A `response` object is the result of the `responses.create()` method. Each `response` object is similar to a `Run` in the {{ assistant-api }} which contains the final response. |
| **Retrieval**: Tool for search through indexes. | A [built-in `file_search` tool](tools/filesearch.md). To run a search, specify an array of {{ vector-store-name }} indexes. |
| **WebSearch**: Web search tool. | A [built-in `web_search` tool](tools/websearch.md). You can specify search domain and region. |
| **Streaming**: Getting intermediate model responses. | `client.responses.stream()` method. |

### Conceptual differences {#basic-differences}

Main conceptual differences between the {{ responses-api }} and {{ assistant-api }}:

1. In the {{ responses-api }}, there are no assistants as separate {{ ai-studio-name }} resources.

    #|
    || **{{ assistant-api }}** | **{{ responses-api }}** ||
    ||
    In the {{ assistant-api }}, you need to create an AI assistant just once. With that done, you can run it in different threads.
    |
    In the Responses API, you need to specify the following for each request:
    * Model (`model`)
    * Instructions (`instructions`)
    * Tools to use `tools`
    * Model properties (`temperature`, `max_output_tokens`, etc.)
    ||
    |#

    To adapt your code to the {{ responses-api }}, use one of the following options to save your model settings:
    * Export the configuration of your AI assistant from the {{ assistant-api }} into the your application code.
    * Specify and save the model configuration under **{{ ui-key.yacloud.yagpt.YaGPT.navigation-group_agents_eDBFf }}** in the [management console]({{ link-console-main }}/link/ml/ai-studio/agents). Once you do that, you will be able to use it in your application code by specifying the ID of the saved agent in the request.

1. Context is transmitted in messages (in the `previous_response_id` field), not in threads.

    #|
    || **{{ assistant-api }}** | **{{ responses-api }}** ||
    ||
    The {{ assistant-api }} stores context in threads (`thread`), and each run (`run`) reads it over again.
    |
    The {{ responses-api }} implements a mechanism allowing you to transmit the ID of the previous message in the `previous_response_id` field to keep track of the message history.
    ||
    |#

    {% note info %}

    Message retention period is limited to 30 days from when they are created by the `responses.create()` method.

    {% endnote %}

1. The tools the {{ responses-api }} comes with are built in and require no extra libraries.

    #|
    || **{{ assistant-api }}** | **{{ responses-api }}** ||
    ||
    The {{ retrieval-tool-name }} and WebSearch components you find in the {{ assistant-api }} are configured globally as assistant tools and use external sources and separate search indexes.
    |
    In the {{ responses-api }}, the file and web search scenarios are implemented via the `tools` field where you can customize your tool set for each request. This field may take the following values:

    * `{"type": "file_search"}`
    * `{"type": "web_search"}`
    ||
    |#

## How to migrate a simple text assistant to the {{ responses-api }} {#migrate-simple-assistant}

### AI assistant workflow via the {{ assistant-api }} {#simple-assistant-api}

{% include [assistant-api-chart](../../../_mermaid/other/ai-studio/assistant-api-chart.md) %}

In the {{ assistant-api }}, you go through these steps to use an assistant:

* Creating an AI assistant to store model settings, tools, and basic instructions.
* Creating a thread (dialog container).
* Creating a message in the thread (user message).
* Running the assistant to process the thread.
* Status polling the run pending its completion.
* Getting a message from the thread (model response).

### AI agent workflow via the {{ responses-api }} {#simple-responses-api}

In the {{ responses-api }}, an AI agent is a set of parameters in the code, whereas the context of the previous dialog is provided via the `previous_response_id` field.

The logic of your application must preserve the `response.id` identifier, same as a thread in the {{ assistant-api }}. To get a response based on the conversation history, provide the ID of the last message (`response.id`) in the `previous_response_id` field with each next user message.

Here is an example of how a simple {{ responses-api }}-based AI agent works:

{% list tabs %}

- Python SDK

  ```python
  from openai import OpenAI

  YANDEX_CLOUD_FOLDER = "<folder_ID>"
  YANDEX_CLOUD_MODEL = "<model_URI>"
  YANDEX_CLOUD_API_KEY = "<service_account_API_key>"
  # or YANDEX_CLOUD_IAM_TOKEN = "<IAM_token>"

  previous_id = None  # saving the ID of the last assistant response

  client = OpenAI(
      api_key=YANDEX_CLOUD_API_KEY,
      project=YANDEX_CLOUD_FOLDER,
      base_url="https://rest-assistant.{{ api-host }}/v1",
  )

  print("Agent chat (to exit, type ‘exit')\n")

  while True:
      user_input = input("You: ")
      if user_input.lower() in ("exit", "quit"):
          print("Chat session ended.")
          break

      response = client.responses.create(
          model=f"gpt://{YANDEX_CLOUD_FOLDER}/{YANDEX_CLOUD_MODEL}",
          input=[{"role": "user", "content": user_input}],
          instructions="You are a text agent that maintains a conversation and provides meaningful responses to the user’s questions.",
          previous_response_id=previous_id,  # providing context, if any
      )

      # saving the ID for the next step
      previous_id = response.id

      # outputting the agent's response
      print("Agent:", response.output_text)
  ```

{% endlist %}

## How to migrate an assistant with tools to the {{ responses-api }} {#migrate-tooled-assistant}

The process of migrating an AI assistant to the {{ responses-api }} depends on what tools are connected and how you get the generation results.

### RAG scenarios with {{ retrieval-tool-name }} {#rag-tools}

In file and internal knowledge base search scenarios, you use the {{ assistant-api }} search indexes and the {{ retrieval-tool-name }} tool: the AI assistant generates responses based on documents uploaded to the indexes and returns the metadata of the files it used.

In the {{ assistant-api }}, the {{ retrieval-tool-name }} tool was linked to the assistant:
  
{% list tabs group=programming_language %}

- SDK {#sdk}

  ```python
  # First, a tool is created to work with the existing search index.
  tool = sdk.tools.search_index(
      search_index,
      call_strategy={
          "type": "function",
          "function": {"name": "guide", "instruction": instruction},
      },
  )

  # Next, an assistant is created which is going to use that tool.
  assistant = sdk.assistants.create(
      "yandexgpt",
      instruction="You are an internal corporate documentation assistant. Answer politely. If the information is not in the documents below, don't make up your answer.",
      tools=[tool],
  )
  thread = sdk.threads.create()
  ```

{% endlist %}

To migrate an AI assistant with the {{ retrieval-tool-name }} tool connected, follow these steps:

1. Upload all documents of the connected search index to the [vector store](../search/vectorstore.md) used by the {{ responses-api }}.
1. When putting together a request in your application, add the `file_search` tool settings:

  {% list tabs group=programming_language %}

  - Python SDK {#sdk}

    ```python
    import openai
    import json

    YANDEX_CLOUD_FOLDER = "<folder_ID>"
    YANDEX_CLOUD_MODEL = "<model_URI>"
    VECTOR_STORE_ID = "<Vector_Store_instance_ID>"
    YANDEX_CLOUD_API_KEY = "<service_account_API_key>"
    # or YANDEX_CLOUD_IAM_TOKEN = "<IAM_token>"


    client = openai.OpenAI(
        api_key=YANDEX_CLOUD_API_KEY,
        base_url="https://rest-assistant.{{ api-host }}/v1",
        project=YANDEX_CLOUD_FOLDER,
    )

    response = client.responses.create(
        model=f"gpt://{YANDEX_CLOUD_FOLDER}/{YANDEX_CLOUD_MODEL}",
        instructions="You are a smart assistant. If asked about ..., search through the index for information",
        tools=[
            {
                "type": "file_search", 
                "vector_store_ids": [VECTOR_STORE_ID],
            }
        ],
        input="what is ...",
    )

    print("Response text:")
    print(response.output_text)
    print("\n" + "=" * 50 + "\n")

    # Full response
    print("Full response (JSON):")
    print(json.dumps(response.model_dump(), indent=2, ensure_ascii=False))
    ```

  {% endlist %}

### Web search scenarios {#websearch-tool}

In the {{ assistant-api }}, you used to configure the `WebSearch` tool when creating your AI assistant:

{% list tabs group=programming_language %}

- cURL {#curl}

  ```json
  {
    "folderId": "<folder_ID>",
    "modelUri": "gpt://<folder_ID>/yandexgpt-lite/latest",
    "instruction": "You are a smart assistant designed for a finance company. Answer politely. Use search to answer the questions. Do not make up your answer.",
    "tools": [
      {
        "genSearch": {
          "options": {
            "site": {
              "site": [
                "https://cbr.ru/",
                "https://yandex.ru/finance/currencies"
              ]
            },
            "enableNrfmDocs": true
          },
          "description": "Tool to get information about official currency exchange rates."
        }
      }
    ]
  }
  ```

{% endlist %}

In the {{ responses-api }}, the `web_search` tool settings are provided directly in the request.

To migrate an AI assistant with `WebSearch`, provide the `file_search` tool settings in the request:

{% list tabs group=programming_language %}

- Python SDK {#sdk}

  ```python
  import openai
  import json

  YANDEX_CLOUD_FOLDER = "<folder_ID>"
  YANDEX_CLOUD_MODEL = "<model_URI>"
  YANDEX_CLOUD_API_KEY = "<service_account_API_key>"
  # or YANDEX_CLOUD_IAM_TOKEN = "<IAM_token>"


  client = openai.OpenAI(
      api_key=YANDEX_CLOUD_API_KEY,
      base_url="https://rest-assistant.{{ api-host }}/v1",
      project=YANDEX_CLOUD_FOLDER,
  )

  response = client.responses.create(
      model=f"gpt://{YANDEX_CLOUD_FOLDER}/{YANDEX_CLOUD_MODEL}",
      input="Create a brief overview of the latest LLM news in 2025, only facts, no specualtion.",
      # Providing tool setting
      tools=[
          {
              "type": "web_search",
              "filters": {
                  "allowed_domains": [
                      "habr.ru",
                  ],
                  "user_location": {
                      "region": "213",
                  }
              }
          }
        ],
      temperature=0.3,
      max_output_tokens=1000,
  )
  ```

{% endlist %}


### Getting intermediate response generation results {#streaming}

The {{ assistant-api }} allowed access to intermediate response generation results. For example, in {{ ml-sdk-name }}, the `run_stream()` method was used:

{% list tabs group=programming_language %}

- SDK {#sdk}

  ```python
  run = assistant.run_stream(thread)

  # Intermediate results you are getting as the model is generating its response
  for event in run:
      print(event._message.parts)

  # All fields of the final result
  print(f"run {event=}")
  ```

{% endlist %}

The {{ responses-api }} also allows getting intermediate generation results, e.g., via the `responses.stream()` method:

{% list tabs group=programming_language %}

- Python SDK {#sdk}

  ```python
  import openai

  YANDEX_CLOUD_FOLDER = "<folder_ID>"
  YANDEX_CLOUD_MODEL = "<model_URI>"
  YANDEX_CLOUD_API_KEY = "<service_account_API_key>"
  # or YANDEX_CLOUD_IAM_TOKEN = "<IAM_token>"

  client = openai.OpenAI(
      api_key=YANDEX_CLOUD_API_KEY,
      base_url="https://rest-assistant.{{ api-host }}/v1",
      project=YANDEX_CLOUD_FOLDER,
  )

  # Creating a streaming request
  with client.responses.stream(
      model=f"gpt://{YANDEX_CLOUD_FOLDER}/{YANDEX_CLOUD_MODEL}",
      input="Write a short friendly and funny birthday toast.",
  ) as stream:
      for event in stream:
          # Text response deltas
          if event.type == "response.output_text.delta":
              print(event.delta, end="", flush=True)
          # Event showing that the response is completed
          # elif event.type == "response.completed":
          #     print("\n---\nResponse completed")

      # You can get the full text of the response if you need to
      # final_response = stream.get_final_response()
      # print("\nFull response text:\n", final_response.output_text)
  ```

{% endlist %}