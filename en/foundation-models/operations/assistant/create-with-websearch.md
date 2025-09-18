---
title: Creating an assistant with the WebSearch tool
description: Follow this guide to create a personalized assistant in {{ assistant-api }} which generates responses based on information obtained from a search engine using WebSearch.
---

# Creating an assistant with the WebSearch tool

{% include [assistants-preview-stage](../../../_includes/foundation-models/assistants-preview-stage.md) %}

{{ assistant-api }} is a {{ foundation-models-name }} tool for creating [AI assistants](../../concepts/assistant/index.md). It can be used to create personalized assistants, implement a generative response scenario with access to information from external sources (known as _retrieval augmented generation_, or [RAG](https://en.wikipedia.org/wiki/Retrieval-augmented_generation)), and save the model's request context.

The WebSearch [tool](../../concepts/assistant/tools/web-search.md) enables AI assistants to retrieve information from internet sources.

{% note info %}

Using WebSearch is billed as a [generative response](../../../search-api/pricing.md) in {{ search-api-full-name }}.

{% endnote %}

## Getting started {#before-begin}

To use the examples:

{% list tabs group=programming_language %}

- cURL {#curl}

  {% include notitle [ai-before-beginning](../../../_includes/foundation-models/yandexgpt/ai-before-beginning.md) %}

  To use the examples, install the [cURL](https://curl.haxx.se) and [jq](https://stedolan.github.io/jq) utilities.

{% endlist %}

## Create an assistant {#create-assistant}

{% list tabs group=programming_language %}

- cURL {#curl}

  This example shows how to create an [assistant](../../concepts/assistant/index.md) that relies on information from the internet for responses. In this example, we will use the basic algorithm for working with {{ assistant-api }} via the [REST API](../../assistants/api-ref/index.md) interface: creating an assistant and a thread and submitting a request to the assistant.
  
  As the external information sources, we will use the Central Bank of Russia [official website](https://cbr.ru/) and the [Currency rates](https://yandex.ru/finance/currencies) portal by Yandex. For internet-wide search, leave the `options` field in WebSearch empty.

  1. Create an AI assistant:

      1. Create a file named `assistant.json` with the body of the request to create an assistant:

          **assistant.json**

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

          Where:
          * `folder_id`: [ID](../../../resource-manager/operations/folder/get-id.md) of the folder for which your account has the [roles](../../../iam/concepts/access-control/roles.md) [`ai.assistants.editor`](../../security/index.md#ai-assistants-editor) and [`{{ roles-yagpt-user }}`](../../security/index.md#languageModels-user) or higher.
          * `modelUri`: [URI](../../concepts/generation/models.md#generation)of the text generation model.
          * `instruction`: Basic instruction that the AI assistant will use to run user queries.
          * `tools`: Settings for the [tool](../../concepts/assistant/tools/index.md) the assistant will use:

              * `site`: Array of websites the assistant will access to search for information.
              * `enableNrfmDocs`: Parameter that determines whether search results will include documents which are not directly accessible from the websites’ home pages.
              * `description`: Tool description the assistant will use to decide whether to use this tool when generating a response to a specific query.

              To learn more about internet search settings available in WebSearch, see [{#T}](../../concepts/assistant/tools/web-search.md).
      1. Send a request to create an AI assistant by specifying the path to the new `assistant.json` request body file:

          ```bash
          export IAM_TOKEN=<IAM_token>
          curl \
            --request POST \
            --header "Authorization: Bearer ${IAM_TOKEN}" \
            --silent \
            --data "@<path_to_request_body>" \
            "https://rest-assistant.{{ api-host }}/assistants/v1/assistants" | \
            jq
          ```

          Where:
          * `<IAM_token>`: IAM token you got [before you started](#before-begin).
          * `<path_to_request_body>`: Path to the previously created request body file (`assistant.json`).

          {% cut "Result" %}

          ```json
          {
            "id": "fvthd7m0d6up********",
            "folder_id": "b1gt6g8ht345********",
            "name": "",
            "description": "",
            "created_by": "ajeol2afu1js********",
            "created_at": "2025-08-27T11:07:37.532517Z",
            "updated_by": "ajeol2afu1js********",
            "updated_at": "2025-08-27T11:07:37.532517Z",
            "expiration_config": {
              "expiration_policy": "SINCE_LAST_ACTIVE",
              "ttl_days": "7"
            },
            "expires_at": "2025-09-03T11:07:37.532517Z",
            "labels": {},
            "model_uri": "gpt://b1gt6g8ht345********/yandexgpt-lite/latest",
            "instruction": "You are a smart assistant designed for a finance company. Answer politely. Use search to answer the questions. Do not make up your answer.",
            "prompt_truncation_options": {
              "max_prompt_tokens": null,
              "auto_strategy": {}
            },
            "completion_options": {
              "max_tokens": null,
              "temperature": null
            },
            "tools": [
              {
                "gen_search": {
                  "options": {
                    "site": {
                      "site": [
                        "https://cbr.ru/",
                        "https://yandex.ru/finance/currencies"
                      ]
                    },
                    "enable_nrfm_docs": true,
                    "search_filters": []
                  },
                  "description": "Tool to get information about official currency exchange rates."
                }
              }
            ],
            "response_format": null
          }
          ```

          {% endcut %}

          In response, {{ assistant-api }} will return your new AI assistant's ID. Save the obtained `id`. You will need it when accessing the assistant.
  1. Create a thread:

      1. Create a file named `thread.json` with the body of the request to create a thread and specify the folder ID:

          **thread.json**

          ```json
          {
            "folderId": "<folder_ID>"
          }
          ```
      1. Send a request to create a thread by specifying the path to the new `thread.json` request body file:

          ```bash
          curl \
            --request POST \
            --header "Authorization: Bearer ${IAM_TOKEN}" \
            --silent \
            --data "@<path_to_request_body>" \
            "https://rest-assistant.{{ api-host }}/assistants/v1/threads" | \
            jq
          ```

          {% cut "Result" %}

          ```json
          {
            "id": "fvtfq63a134i********",
            "folder_id": "b1gt6g8ht345********",
            "name": "",
            "description": "",
            "default_message_author_id": "fvtsnf3tqbhg********",
            "created_by": "ajeol2afu1js********",
            "created_at": "2025-08-27T11:22:28.999319Z",
            "updated_by": "ajeol2afu1js********",
            "updated_at": "2025-08-27T11:22:28.999319Z",
            "expiration_config": {
              "expiration_policy": "SINCE_LAST_ACTIVE",
              "ttl_days": "7"
            },
            "expires_at": "2025-09-03T11:22:28.999319Z",
            "labels": {},
            "tools": []
          }
          ```

          {% endcut %}

          Save the obtained thread ID (`id` field value). You will need it later.
  1. Create a message in your thread:

      1. Create a file named `message.json` with the body of the request to create a message and specify the previously obtained thread ID and request text:

          **message.json**

          ```json
          {
            "threadId": "<thread_ID>",
            "content": {
              "content": [
                {
                  "text": {
                    "content": "What is today’s official USD rate?"
                  }
                }
              ]
            }
          }
          ```
      1. Send a request to create a message by specifying the path to the new `message.json` request body file:

          ```bash
          curl \
            --request POST \
            --header "Authorization: Bearer ${IAM_TOKEN}" \
            --silent \
            --data "@<path_to_request_body>" \
            "https://rest-assistant.{{ api-host }}/assistants/v1/messages" | \
            jq
          ```

          Result:

          ```json
          {
            "id": "fvt6bpm6mbp5********",
            "thread_id": "fvtfq63a134i********",
            "created_by": "ajeol2afu1js********",
            "created_at": "2025-08-27T11:24:46.312977Z",
            "author": {
              "id": "fvtsnf3tqbhg********",
              "role": "USER"
            },
            "labels": {},
            "content": {
              "content": [
                {
                  "text": {
                    "content": "What is today’s official USD rate?"
                  }
                }
              ]
            },
            "status": "COMPLETED",
            "citations": []
          }
          ```
  1. Run the assistant with the message you created earlier:

      1. Create a file named `run.json` with the body of the request to run the assistant by specifying the assistant and thread IDs you got earlier:

          **run.json**

          ```json
          {
            "assistantId": "<assistant_ID>",
            "threadId": "<thread_ID>"
          }
          ```
      1. Send a request to run the assistant by specifying the path to the new `run.json` request body file:

          ```bash
          curl \
            --request POST \
            --header "Authorization: Bearer ${IAM_TOKEN}" \
            --silent \
            --data "@<path_to_request_body>" \
            "https://rest-assistant.{{ api-host }}/assistants/v1/runs" | \
            jq
          ```

          Result:

          ```json
          {
            "id": "fvtar74rehg7********",
            "assistant_id": "fvthd7m0d6up********",
            "thread_id": "fvtfq63a134i********",
            "created_by": "ajeol2afu1js********",
            "created_at": "2025-08-27T11:31:06.486275281Z",
            "labels": {},
            "state": {
              "status": "PENDING"
            },
            "usage": null,
            "custom_prompt_truncation_options": null,
            "custom_completion_options": null,
            "tools": [],
            "custom_response_format": null
          }
          ```

          {{ assistant-api }} has returned the run information: the launch is in `PENDING` status. Save the run ID (`id` field value). You will need it in the next step.
  1. Get the result of the run with the assistant's response. To do this, make a request by specifying the run ID you got earlier:

      ```bash
      curl \
        --request GET \
        --header "Authorization: Bearer ${IAM_TOKEN}" \
        --silent \
        "https://rest-assistant.{{ api-host }}/assistants/v1/runs/<execution_ID>" | \
        jq
      ```

      {% cut "Result" %}

      ```json
      {
        "id": "fvtar74rehg7********",
        "assistant_id": "fvthd7m0d6up********",
        "thread_id": "fvtfq63a134i********",
        "created_by": "ajeol2afu1js********",
        "created_at": "2025-08-27T11:31:06.486275281Z",
        "labels": {},
        "state": {
          "status": "COMPLETED",
          "completed_message": {
            "id": "fvt24upe31hh********",
            "thread_id": "fvtfq63a134i********",
            "created_by": "ajeol2afu1js********",
            "created_at": "2025-08-27T11:31:08.781561740Z",
            "author": {
              "id": "fvthd7m0d6up********",
              "role": "ASSISTANT"
            },
            "labels": {},
            "content": {
              "content": [
                {
                  "text": {
                    "content": "Today's official USD to RUB exchange rate is 80.5268 RUB per USD."
                  }
                }
              ]
            },
            "status": "COMPLETED",
            "citations": []
          }
        },
        "usage": {
          "prompt_tokens": "390",
          "completion_tokens": "44",
          "total_tokens": "434"
        },
        "custom_prompt_truncation_options": null,
        "custom_completion_options": null,
        "tools": [],
        "custom_response_format": null
      }
      ```

      {% endcut %}

      In the `content` field, the AI assistant returned the model-generated response based on the data from websites specified in the assistant settings.

{% endlist %}

#### See also {#see-also}

* [{#T}](./create.md)
* [{#T}](./create-with-searchindex.md)
* [{#T}](./create-with-labels.md)
* [{#T}](../../tutorials/pdf-searchindex-ai-assistant.md)
* [{#T}](../../concepts/assistant/tools/index.md)
* Examples of working with {{ ml-sdk-name }} on [GitHub](https://github.com/yandex-cloud/yandex-cloud-ml-sdk/tree/master/examples/sync/assistants)
