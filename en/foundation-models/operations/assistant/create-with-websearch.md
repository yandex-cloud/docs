---
title: Creating an assistant with the WebSearch tool
description: Follow this guide to create a personalized assistant in {{ assistant-api }} to implement a generative response scenario with access to information obtained from a search engine using WebSearch.
---

# Creating an assistant with the WebSearch tool

{% include [assistants-preview-stage](../../../_includes/foundation-models/assistants-preview-stage.md) %}

{{ assistant-api }} is a {{ foundation-models-name }} tool for creating [AI assistants](../../concepts/assistant/index.md). It can be used to create personalized assistants, implement a generative response scenario with access to information from external sources (known as _retrieval augmented generation_, or [RAG](https://en.wikipedia.org/wiki/Retrieval-augmented_generation)), and save the model's request context.

The WebSearch [tool](../../concepts/assistant/tools/web-search.md) enables AI assistants to get information from internet sources.

{% note info %}

WebSearch tool usage is billed as a [generative response](../../../search-api/pricing.md) in {{ search-api-full-name }}.

{% endnote %}

## Getting started {#before-begin}

To use the examples:

{% list tabs group=programming_language %}

- cURL {#curl}

  {% include notitle [ai-before-beginning](../../../_includes/foundation-models/yandexgpt/ai-before-beginning.md) %}

  Install [gRPCurl](https://github.com/fullstorydev/grpcurl) and [jq](https://stedolan.github.io/jq).

{% endlist %}

## Create an assistant {#create-assistant}

{% list tabs group=programming_language %}

- cURL {#curl}

  This example shows how to create an [assistant](../../concepts/assistant/index.md) that relies on information from the internet for responses. In this example, we will use the basic algorithm for working with {{ assistant-api }} via the [gRPC API](../../assistants/api-ref/grpc/index.md) interface: creating an assistant and a thread, and submitting a request to the assistant.
  
  As the external information sources, we will use the Central Bank of Russia [official website](https://cbr.ru/) and the [Currency rates](https://yandex.ru/finance/currencies) service by Yandex. If you want to search information across the whole internet, leave the empty value in the WebSearch’s `options` field.

  1. Create an AI assistant:

      1. Create a file named `assistant.json` with the body of the request to create an assistant:

          **assistant.json**

          ```json
          {
            "folder_id": "<folder_ID>",
            "model_uri": "gpt://<folder_ID>/yandexgpt-lite/latest",
            "instruction": "You are a smart assistant of a financial company. Answer politely. Use the search tool to answer the questions. Do not make up the answer.",
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
                    "enable_nrfm_docs": true
                  },
                  "description": "Tool for getting information about official currency rates."
                }
              }
            ]
          }
          ```

          Where:
          * `folder_id`: [ID](../../../resource-manager/operations/folder/get-id.md) of the folder for which your account has the [roles](../../../iam/concepts/access-control/roles.md) [`ai.assistants.editor`](../../security/index.md#ai-assistants-editor) and [`{{ roles-yagpt-user }}`](../../security/index.md#languageModels-user) or higher.
          * `model_uri`: [URI](../../concepts/generation/models.md#generation) of the text generation model.
          * `instruction`: Basic instruction that the AI assistant will use to execute user queries.
          * `tools`: Settings for a [tool](../../concepts/assistant/tools/index.md) that the assistant will use:

              * `site`: Array of websites the assistant will be able to search information on.
              * `enable_nrfm_docs`: Parameter that determines whether search results will include documents which are not directly accessible from the home pages of the specified websites.
              * `description`: Description of the tool to create that enables the assistant to understand whether it should use that tool when generating a response to a specific request.

              To learn more about Websearch tool settings for searching on the internet, see [{#T}](../../concepts/assistant/tools/web-search.md).
      1. Send a request to create an AI assistant by specifying the path to the new `assistant.json` request body file:

          ```bash
          export IAM_TOKEN=<IAM_token>
          grpcurl \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d @ < <path_to_request_body> \
            assistant.{{ api-host }}:443 yandex.cloud.ai.assistants.v1.AssistantService/Create |
            jq
          ```

          Where:
          * `<IAM_token>`: IAM token you got [before you started](#before-begin).
          * `<path_to_request_body>`: Path to the previously created request body file (`assistant.json`).

          {% cut "Result" %}

          ```json
          {
            "id": "fvt1m68ugu04********",
            "folder_id": "b1gt6g8ht345********",
            "created_by": "ajeol2afu1js********",
            "created_at": "2025-08-05T08:26:24.145150Z",
            "updated_by": "ajeol2afu1js********",
            "updated_at": "2025-08-05T08:26:24.145150Z",
            "expiration_config": {
              "expiration_policy": "SINCE_LAST_ACTIVE",
              "ttl_days": "7"
            },
            "expires_at": "2025-08-12T08:26:24.145150Z",
            "model_uri": "gpt://b1gt6g8ht345********/yandexgpt-lite/latest",
            "instruction": "You are a smart assistant of a financial company. Answer politely. Use the search tool to answer the questions. Do not make up the answer.",
            "prompt_truncation_options": {
              "auto_strategy": {}
            },
            "completion_options": {},
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
                    "enable_nrfm_docs": true
                  },
                  "description": "Tool for getting information about official currency rates."
                }
              }
            ]
          }
          ```

          {% endcut %}

          In response, {{ assistant-api }} will return your new AI assistant's ID. Save the ID (`id` field value). You will need it when accessing the assistant.
  1. Create a thread:

      1. Create a file named `thread.json` with the body of the request to create a thread, specifying the folder ID:

          **thread.json**

          ```json
          {
            "folder_id": "<folder_ID>"
          }
          ```
      1. Send a request to create a thread by specifying the path to the new `thread.json` request body file:

          ```bash
          grpcurl \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d @ < <path_to_request_body> \
            assistant.{{ api-host }}:443 yandex.cloud.ai.assistants.v1.threads.ThreadService/Create |
            jq
          ```

          {% cut "Result" %}

          ```json
          {
            "id": "fvt8tf1c3beu********",
            "folder_id": "b1gt6g8ht345********",
            "default_message_author_id": "fvt1qo9usone********",
            "created_by": "ajeol2afu1js********",
            "created_at": "2025-08-13T10:50:52.289620Z",
            "updated_by": "ajeol2afu1js********",
            "updated_at": "2025-08-13T10:50:52.289620Z",
            "expiration_config": {
              "expiration_policy": "SINCE_LAST_ACTIVE",
              "ttl_days": "7"
            },
            "expires_at": "2025-08-20T10:50:52.289620Z"
          }
          ```

          {% endcut %}

          Save the obtained thread ID (`id` field value). You will need it later.
  1. Create a message in your thread:

      1. Create a file named `message.json` with the body of the request to create a message by specifying the previously obtained thread ID and the request text:

          **message.json**

          ```json
          {
            "thread_id": "<thread_ID>",
            "content": {
              "content": [
                {
                  "text": {
                    "content": "What is the official US dollar rate for today?"
                  }
                }
              ]
            }
          }
          ```
      1. Send a request to create a message by specifying the path to the new `message.json` request body file:

          ```bash
          grpcurl \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d @ < <path_to_request_body> \
            assistant.{{ api-host }}:443 yandex.cloud.ai.assistants.v1.threads.MessageService/Create |
            jq
          ```

          Result:

          ```json
          {
            "id": "fvtfgeqhe4ct********",
            "thread_id": "fvth2n5v4i7e********",
            "created_by": "ajeol2afu1js********",
            "created_at": "2025-08-05T09:18:48.515453Z",
            "author": {
              "id": "fvtivd1j5ica********",
              "role": "USER"
            },
            "content": {
              "content": [
                {
                  "text": {
                    "content": "What is the Bank of Russia USD rate for today?"
                  }
                }
              ]
            },
            "status": "COMPLETED"
          }
          ```
  1. Run the assistant with the message you created earlier:

      1. Create a file named `run.json` with the body of the request to run the assistant by specifying the assistant and thread IDs you got earlier:

          **run.json**

          ```json
          {
            "assistant_id": "<assistant_ID>",
            "thread_id": "<thread_ID>"
          }
          ```
      1. Send a request to run the assistant by specifying the path to the new `run.json` request body file:

          ```bash
          grpcurl \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d @ < <path_to_request_body> \
            assistant.{{ api-host }}:443 yandex.cloud.ai.assistants.v1.runs.RunService/Create |
            jq
          ```

          Result:

          ```json
          {
            "id": "fvtqms73nvkl********",
            "assistant_id": "fvt1m68ugu04********",
            "thread_id": "fvtv9ikd6lme********",
            "created_by": "ajeol2afu1js********",
            "created_at": "2025-08-05T09:23:55.096007666Z",
            "state": {
              "status": "PENDING"
            }
          }
          ```

          {{ assistant-api }} has returned the run information: the launch is in `PENDING` status. Save the run ID (`id` field value). You will need it in the next step.
  1. Get the run outcome with the assistant's response:

      1. Create a file named `get_result.json` with the body of the request to get a response from the AI assistant, specifying the run ID you got earlier:

          **get_result.json**

          ```json
          {
            "run_id": "<execution_ID>"
          }
          ```

      1. Send a request to get a response, specifying the path to the new `get_result.json` request body file:

          ```bash
          grpcurl \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d @ < <path_to_request_body> \
            assistant.{{ api-host }}:443 yandex.cloud.ai.assistants.v1.runs.RunService/Get |
            jq
          ```

          {% cut "Result" %}

          ```json
          {
            "id": "fvtr0r43s94a********",
            "assistant_id": "fvtshcldmbcm********",
            "thread_id": "fvth2n5v4i7e********",
            "created_by": "ajeol2afu1js********",
            "created_at": "2025-08-04T19:01:56.736924537Z",
            "state": {
              "status": "COMPLETED",
              "completed_message": {
                "id": "fvtlspo6k12e********",
                "thread_id": "fvth2n5v4i7e********",
                "created_by": "ajeol2afu1js********",
                "created_at": "2025-08-04T19:01:58.960131555Z",
                "author": {
                  "id": "fvtshcldmbcm********",
                  "role": "ASSISTANT"
                },
                "content": {
                  "content": [
                    {
                      "text": {
                        "content": "Official USD rate for today is RUB 79.6736 per USD. You can verify this information on the Central Bank of Russia website (cbr.ru/currency_base/daily/)."
                      }
                    }
                  ]
                },
                "status": "COMPLETED"
              }
            },
            "usage": {
              "prompt_tokens": "376",
              "completion_tokens": "59",
              "total_tokens": "435"
            }
          }
          ```

          {% endcut %}

          In the `content` field, the AI assistant returned the model-generated response based on the data from the websites specified in the assistant and thread settings.

{% endlist %}

#### See also {#see-also}

* [{#T}](./create.md)
* [{#T}](./create-with-searchindex.md)
* [{#T}](./create-with-labels.md)
* [{#T}](../../tutorials/pdf-searchindex-ai-assistant.md)
* [{#T}](../../concepts/assistant/tools/index.md)
* Examples of working with {{ ml-sdk-name }} on [GitHub](https://github.com/yandex-cloud/yandex-cloud-ml-sdk/tree/master/examples/sync/assistants)
