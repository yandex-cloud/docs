---
title: Creating an assistant with the VectorStore tool
description: Follow this guide to create a personalized assistant in {{ assistant-api }} to implement a generative response scenario with access to information from a search index using VectorStore.
---

# Creating a RAG assistant with the VectorStore tool

{% include [assistants-preview-stage](../../../_includes/foundation-models/assistants-preview-stage.md) %}

{{ assistant-api }} is a {{ foundation-models-name }} tool for creating [AI assistants](../../concepts/assistant/index.md). It can be used to create personalized assistants, implement a generative response scenario with access to information from external sources (known as _retrieval augmented generation_, or [RAG](https://en.wikipedia.org/wiki/Retrieval-augmented_generation)), and save the model's request context.

The VectorStore [tool](../../concepts/assistant/tools/vector-store.md) allows AI assistants to draw information from the knowledge base.

## Getting started {#before-begin}

To use the examples:

{% list tabs group=programming_language %}

- SDK {#sdk}

  {% include [sdk-before-begin-assistants](../../../_includes/foundation-models/sdk-before-begin-assistants.md) %}

- cURL {#curl}

  {% include notitle [ai-before-beginning](../../../_includes/foundation-models/yandexgpt/ai-before-beginning.md) %}

  To use the examples, install the [cURL](https://curl.haxx.se) and [jq](https://stedolan.github.io/jq) utilities.

{% endlist %}

## Create an assistant {#create-assistant}

{% list tabs group=programming_language %}

- SDK {#sdk}

  This example shows how to create an [assistant](../../concepts/assistant/index.md) that relies on information from files for responses. In the example, we will create an index for full-text search and a simplest chat.

  {% include [rag-default-strategy-paragraph](../../../_includes/foundation-models/assistants/rag-default-strategy-paragraph.md) %}

  To correct this behavior, in this example, we will set up an index access [strategy](../../concepts/assistant/tools/vector-store.md) for the assistant, according to which the model will access additional data sources only in cases mentioned in the instruction specified in the `instruction` variable.

  1. {% include [download-context-file-step](../../../_includes/foundation-models/assistants/download-context-file-step.md) %}
  1. Create a file named `search-assistant.py` and paste the following code into it:

      {% include [searchindex-assistant](../../../_includes/foundation-models/examples/searchindex-assistant.md) %}

      Where:

      * `<path_to_files_with_examples>`: Path to the directory containing the files you downloaded earlier, e.g., `/Users/myuser/tours-example/`.

      {% include [sdk-code-legend](../../../_includes/foundation-models/examples/sdk-code-legend.md) %}

      * `<instruction_for_search_strategy>`: Prompt with an instruction for the model on how to access the search index. Here is an example: `Search through the knowledge base only if the user has specifically asked you to do so`.

  1. Run the file you created:

      ```bash
      python3 search-assistant.py
      ```

      The example implements the simplest chat possible: enter your requests to the assistant from your keyboard and get answers. To search in the knowledge base, explicitly specify it in your request. To end the dialog, enter `exit`.

      {% cut "Approximate result" %}

      ```text
      Enter your question to the assistant ("exit" to end the dialog): How much is a visa to Bali?

      Response:  I have no information on how much a visa to Bali is. I recommend that you contact official sources or the Indonesian consulate for up-to-date information.

      Enter your question to the assistant ("exit" to end the dialog): How much is a visa to Bali? Please search in the knowledge base.

      Response:  According to the information I found, a visa to Bali is 300 rubles. However, note that requirements may change, so be sure to check the current information on the consulate or visa center's website when planning your trip.

      * Contents of fragment No. 1: ('**Bali is a tropical paradise full of unforgettable experiences!**\n\nWe invite you to spend an amazing vacation in Bali. This magical Indonesian island is famous for its beautiful beaches, unique culture, and warm hospitality of its people. Discover breathtaking landscapes, taste delicious local dishes, and make new friends. **What do I need for the trip?** To enter Indonesia, you must have a visa. To obtain it, you will need the following documents:\n* Passport valid for at least 6 months from your entry date. * Two photos meeting consulate requirements.',)
      * Search index ID in fragment No. 1: fvtacpbi0cg3********
      * Search index type settings in fragment No. 1: TextSearchIndexType(chunking_strategy=StaticIndexChunkingStrategy(max_chunk_size_tokens=700, chunk_overlap_tokens=300))
      * Source file ID for fragment No. 1: fvtg6bmrdvb3********
      * Source file MIME type for fragment No. 1: text/plain

      * Contents of fragment No. 2: ('* Round-trip booking or tickets. * Form filled out in English. Note that requirements may change, so be sure to check the current information on the consulate or visa center's website when planning your trip. The visa fee is 300 rubles. Don't miss your chance to visit this beautiful island and create unforgettable memories. Book your Bali vacation today. **We look forward to seeing you!**',)
      * Search index ID in fragment No. 2: fvtacpbi0cg3********
      * Search index type settings in fragment No. 2: TextSearchIndexType(chunking_strategy=StaticIndexChunkingStrategy(max_chunk_size_tokens=700, chunk_overlap_tokens=300))
      * Source file ID for fragment No. 2: fvtg6bmrdvb3********
      * Source file MIME type for fragment No. 2: text/plain

      * Contents of fragment No. 3: ('**What do I need for the trip?** To enter Indonesia, you must have a visa. To obtain it, you will need the following documents:\n* Passport valid for at least 6 months from your entry date. * Two photos meeting consulate requirements. * Hotel booking confirmation or a letter for alternative accommodation. * Round-trip booking or tickets. * Form filled out in English. Note that requirements may change, so be sure to check the current information on the consulate or visa center's website when planning your trip. The visa fee is 300 rubles.',)
      * Search index ID in fragment No. 3: fvtacpbi0cg3********
      * Search index type settings in fragment No. 3: TextSearchIndexType(chunking_strategy=StaticIndexChunkingStrategy(max_chunk_size_tokens=700, chunk_overlap_tokens=300))
      * Source file ID for fragment No. 3: fvtg6bmrdvb3********
      * Source file MIME type for fragment No. 3: text/plain

      * Contents of fragment No. 4: ('**Kazakhstan: Journey to the heart of Eurasia**\n\nDiscover Kazakhstan, a fascinating country where East meets West. Enjoy its endless steppes, majestic mountains, historical landmarks, and the warm hospitality of its people. **What do I need for the trip?** To enter Kazakhstan from Russia, you will need the following documents:\n* Passport valid for at least 3 months beyond your trip. * Migration card (issued in-flight or at the border). * Medical insurance (optional but recommended). Don't miss out on the opportunity to visit this beautiful country for a vibrant vacation.',)
      * Search index ID in fragment No. 4: fvtacpbi0cg3********
      * Search index type settings in fragment No. 4: TextSearchIndexType(chunking_strategy=StaticIndexChunkingStrategy(max_chunk_size_tokens=700, chunk_overlap_tokens=300))
      * Source file ID for fragment No. 4: fvttf5sq7u0j********
      * Source file MIME type for fragment No. 4: text/plain

      * Contents of fragment No. 5: ('* Migration card (issued in-flight or at the border). * Medical insurance (optional but recommended). Don't miss out on the opportunity to visit this beautiful country for a vibrant vacation! Book your Kazakhstan vacation today! **We look forward to seeing you!**',)
      * Search index ID in fragment No. 5: fvtacpbi0cg3********
      * Search index type settings in fragment No. 5: TextSearchIndexType(chunking_strategy=StaticIndexChunkingStrategy(max_chunk_size_tokens=700, chunk_overlap_tokens=300))
      * Source file ID for fragment No. 5: fvttf5sq7u0j********
      * Source file MIME type for fragment No. 5: text/plain

      Enter your question to the assistant ("exit" to end the dialog): exit
      ```

      {% endcut %}

      In the `run.text` property, the AI assistant returned the model-generated response based on the uploaded knowledge base. The `run.citations` property contains [source citations](../../concepts/assistant/index.md#citations), listing the knowledge base files and their fragments used to generate the response.

- cURL {#curl}

  This example shows how to create an [assistant](../../concepts/assistant/index.md) that relies on information from files for responses. In this example, we will show the basic algorithm for working with {{ assistant-api }} via the [REST API](../../assistants/api-ref/index.md) interface: creating an index for hybrid search, creating an assistant and a thread, and submitting a request to the assistant.

  {% include [rag-default-strategy-paragraph](../../../_includes/foundation-models/assistants/rag-default-strategy-paragraph.md) %}

  To correct this behavior, in this example, we will set up an index access [strategy](../../concepts/assistant/tools/vector-store.md) for the assistant, according to which the model will access additional data sources only in cases mentioned in the instruction specified in the `callStrategy` section.

  1. Upload the context file for the knowledge base using the [Files API](../../files/api-ref/File/index.md):
      1. {% include [download-context-file-step](../../../_includes/foundation-models/assistants/download-context-file-step.md) %}

          You will use the `bali.md` file from the downloaded archive as the knowledge base in this example.
      1. Encode the `bali.md` file into [Base64]({{ link-base64 }}):

          ```bash
          base64 -i bali.md -o bali-b64coded.txt
          ```
      1. Create a file named `file.json` with the body of the file upload request:

          **file.json**

          ```json
          {
            "folderId": "<folder_ID>",
            "mimeType": "text/markdown",
            "content": "<file_contents>"
          }
          ```

          Where:
          * `folderId`: [ID](../../../resource-manager/operations/folder/get-id.md) of the folder for which your account has the [`ai.assistants.editor`](../../security/index.md#ai-assistants-editor) and [`{{ roles-yagpt-user }}`](../../security/index.md#languageModels-user) [roles](../../../iam/concepts/access-control/roles.md) or higher.
          * `mimeType`: [MIME type](../../concepts/assistant/index.md#files) of the uploaded content. In the example, the `bali.md` file's type is `text/markdown`.
          * `content`: Contents of the `bali-b64coded.txt` file you got in the previous step in Base64 encoding.
      1. Send a request to create a file:

          ```bash
          export IAM_TOKEN=<IAM_token>
          curl \
            --request POST \
            --header "Authorization: Bearer ${IAM_TOKEN}" \
            --silent \
            --data "@<path_to_request_body>" \
            "https://rest-assistant.{{ api-host }}/files/v1/files" | \
            jq
          ```

          Where:
          * `<IAM_token>`: IAM token you got [before you started](#before-begin).
          * `<path_to_request_body>`: Path to the previously created request body file (`file.json`).

          Result:

          ```json
          {
            "id": "fvtjbljvmc0a********",
            "folder_id": "b1gt6g8ht345********",
            "name": "",
            "description": "",
            "mime_type": "text/markdown",
            "created_by": "ajeol2afu1js********",
            "created_at": "2025-08-27T08:25:45.544260Z",
            "updated_by": "ajeol2afu1js********",
            "updated_at": "2025-08-27T08:25:45.544260Z",
            "expiration_config": {
              "expiration_policy": "SINCE_LAST_ACTIVE",
              "ttl_days": "7"
            },
            "expires_at": "2025-09-03T08:25:45.544260Z",
            "labels": {}
          }
          ```

          In response, {{ assistant-api }} will return the ID of the downloaded file. Save this file ID (`id` field value). You will need it in the next step.
  1. Create a [search index](../../concepts/assistant/index.md#files):

      1. Create a file named `index.json` with the body of the index creation request by specifying the file ID you got earlier:

          **index.json**

          ```json
          {
            "folderId": "<folder_ID>",
            "fileIds": [
              "<file_ID>"
            ],
            "hybridSearchIndex": {}
          }
          ```
      1. Send a request to create a search index by specifying the path to the new `index.json` request body file:

          ```bash
          curl \
            --request POST \
            --header "Authorization: Bearer ${IAM_TOKEN}" \
            --silent \
            --data "@<path_to_request_body>" \
            "https://rest-assistant.{{ api-host }}/assistants/v1/searchIndex" | \
            jq
          ```

          Result:

          ```json
          {
            "id": "fvtcckldp96f********",
            "description": "search index creation",
            "created_at": "2025-08-27T08:27:25.755559Z",
            "created_by": "ajeol2afu1js********",
            "modified_at": "2025-08-27T08:27:25.755559Z",
            "done": false,
            "metadata": null
          }
          ```

          You will get the [Operation](../../../api-design-guide/concepts/operation.md) object's ID in response. Save this ID (`id` field value). You will need it in the next step.
      1. To check your readiness to create a search index, request the operation status by specifying the ID you saved earlier:

          ```bash
          curl \
            --request GET \
            --header "Authorization: Bearer ${IAM_TOKEN}" \
            --silent \
            "https://operation.{{ api-host }}/operations/<operation_ID>" | \
            jq
          ```

          {% cut "Result" %}

          ```json
          {
            "done": true,
            "response": {
              "@type": "type.googleapis.com/yandex.cloud.ai.assistants.v1.searchindex.SearchIndex",
              "expirationConfig": {
                "expirationPolicy": "SINCE_LAST_ACTIVE",
                "ttlDays": "7"
              },
              "hybridSearchIndex": {
                "textSearchIndex": {
                  "standardTokenizer": {},
                  "yandexLemmerAnalyzer": {}
                },
                "vectorSearchIndex": {
                  "docEmbedderUri": "emb://yc.ml.rag-prod.common/text-search-doc/latest",
                  "queryEmbedderUri": "emb://yc.ml.rag-prod.common/text-search-query/latest"
                },
                "chunkingStrategy": {
                  "staticStrategy": {
                    "maxChunkSizeTokens": "800",
                    "chunkOverlapTokens": "400"
                  }
                },
                "combinationStrategy": {
                  "meanCombination": {
                    "weights": [
                      0.5,
                      0.5
                    ],
                    "meanEvaluationTechnique": "ARITHMETIC"
                  }
                },
                "normalizationStrategy": "MIN_MAX"
              },
              "id": "fvti5snpooha********",
              "folderId": "b1gt6g8ht345********",
              "createdBy": "ajeol2afu1js********",
              "createdAt": "2025-08-27T08:27:25.791066Z",
              "updatedBy": "ajeol2afu1js********",
              "updatedAt": "2025-08-27T08:27:25.791066Z",
              "expiresAt": "2025-09-03T08:27:25.791066Z"
            },
            "id": "fvtcckldp96f********",
            "description": "search index creation",
            "createdAt": "2025-08-27T08:27:25.755559Z",
            "createdBy": "ajeol2afu1js********",
            "modifiedAt": "2025-08-27T08:27:31.930432Z"
          }
          ```

          {% endcut %}

          `true` in the `done` field indicates that the index has been created. Save the obtained search index ID (`response.id` field value). You will need it when creating the assistant and [thread](../../concepts/assistant/index.md#content).
  1. Create an AI assistant:

      1. Create a file named `assistant.json` with the body of the request to create an assistant:

          **assistant.json**

          ```json
          {
            "folderId": "<folder_ID>",
            "modelUri": "gpt://<folder_ID>/yandexgpt-lite/latest",
            "instruction": "You are an internal corporate documentation assistant. Answer politely. If the information is not in the documents below, don't make up your answer.",
            "tools": [
              {
                "searchIndex": {
                  "searchIndexIds": [
                    "<index_ID>"
                  ],
                  "callStrategy": {
                    "auto_call": {
                      "name": "knowledge_base_search",
                      "instruction": "<instruction_for_search_strategy>"
                    }
                  }
                }
              }
            ]
          }
          ```

          Where:
          * `modelUri`: [URI](../../concepts/generation/models.md#generation) of the text generation model.
          * `searchIndexIds`: Search index ID you got at the previous step.
          * `instruction`: Prompt with an instruction for the model on how to access the search index. Here is an example: `Search through the knowledge base only if the user has specifically asked you to do so`.
      1. Send a request to create an AI assistant by specifying the path to the new `assistant.json` request body file:

          ```bash
          curl \
            --request POST \
            --header "Authorization: Bearer ${IAM_TOKEN}" \
            --silent \
            --data "@<path_to_request_body>" \
            "https://rest-assistant.{{ api-host }}/assistants/v1/assistants" | \
            jq
          ```

          {% cut "Result" %}

          ```json
          {
            "id": "fvted8p4d1k1********",
            "folder_id": "b1gt6g8ht345********",
            "name": "",
            "description": "",
            "created_by": "ajeol2afu1js********",
            "created_at": "2025-08-27T08:42:09.842579Z",
            "updated_by": "ajeol2afu1js********",
            "updated_at": "2025-08-27T08:42:09.842579Z",
            "expiration_config": {
              "expiration_policy": "SINCE_LAST_ACTIVE",
              "ttl_days": "7"
            },
            "expires_at": "2025-09-03T08:42:09.842579Z",
            "labels": {},
            "model_uri": "gpt://b1gt6g8ht345********/yandexgpt-lite/latest",
            "instruction": "You are an internal corporate documentation assistant. Answer politely. If the information is not in the documents below, don't make up your answer.",
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
                "search_index": {
                  "search_index_ids": [
                    "fvti5snpooha********"
                  ],
                  "max_num_results": null,
                  "rephraser_options": null,
                  "call_strategy": {
                    "auto_call": {
                      "name": "knowledge_base_search",
                      "instruction": "Search through the knowledge base only if the user has specifically asked you to do so."
                    }
                  }
                }
              }
            ],
            "response_format": null
          }
          ```

          {% endcut %}

          In response, {{ assistant-api }} will return your new AI assistant's ID. Save the ID (`id` field value). You will need it when accessing the assistant.
  1. Create a thread:

      1. Create a file named `thread.json` with the body of the request to create a thread:

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

          Result:

          ```json
          {
            "id": "fvt8rn2ip0fg********",
            "folder_id": "b1gt6g8ht345********",
            "name": "",
            "description": "",
            "default_message_author_id": "fvtgsemis1k5********",
            "created_by": "ajeol2afu1js********",
            "created_at": "2025-08-27T08:51:05.255025Z",
            "updated_by": "ajeol2afu1js********",
            "updated_at": "2025-08-27T08:51:05.255025Z",
            "expiration_config": {
              "expiration_policy": "SINCE_LAST_ACTIVE",
              "ttl_days": "7"
            },
            "expires_at": "2025-09-03T08:51:05.255025Z",
            "labels": {},
            "tools": []
          }
          ```

          Save the obtained thread ID (`id` field value). You will need it later.
  1. In the thread, create a message without asking for access to the knowledge base:

      1. Create a file named `message.json` with the body of the request to create a message by specifying the previously obtained thread ID and the request text in the context of the downloaded knowledge base file:

          **message.json**

          ```json
          {
            "threadId": "<thread_ID>",
            "content": {
              "content": [
                {
                  "text": {
                    "content": "How much is a visa to Bali?"
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
            "id": "fvtel9i871ra********",
            "thread_id": "fvt8rn2ip0fg********",
            "created_by": "ajeol2afu1jsk89tn159",
            "created_at": "2025-08-27T08:58:47.758337Z",
            "author": {
              "id": "fvtgsemis1k5********",
              "role": "USER"
            },
            "labels": {},
            "content": {
              "content": [
                {
                  "text": {
                    "content": "How much is a visa to Bali?"
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
            "id": "fvtg5cv4pmc6********",
            "assistant_id": "fvted8p4d1k1********",
            "thread_id": "fvt8rn2ip0fg********",
            "created_by": "ajeol2afu1js********",
            "created_at": "2025-08-27T09:12:32.398612020Z",
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
            "id": "fvtg5cv4pmc6********",
            "assistant_id": "fvted8p4d1k1********",
            "thread_id": "fvt8rn2ip0fg********",
            "created_by": "ajeol2afu1js********",
            "created_at": "2025-08-27T09:12:32.398612020Z",
            "labels": {},
            "state": {
              "status": "COMPLETED",
              "completed_message": {
                "id": "fvt096hn7kf5********",
                "thread_id": "fvt8rn2ip0fg********",
                "created_by": "ajeol2afu1js********",
                "created_at": "2025-08-27T09:12:32.855568027Z",
                "author": {
                  "id": "fvted8p4d1k1********",
                  "role": "ASSISTANT"
                },
                "labels": {},
                "content": {
                  "content": [
                    {
                      "text": {
                        "content": "Unfortunately, I have no information in the knowledge base on how much a visa to Bali is."
                      }
                    }
                  ]
                },
                "status": "COMPLETED",
                "citations": []
              }
            },
            "usage": {
              "prompt_tokens": "114",
              "completion_tokens": "16",
              "total_tokens": "130"
            },
            "custom_prompt_truncation_options": null,
            "custom_completion_options": null,
            "tools": [],
            "custom_response_format": null
          }
          ```

          {% endcut %}

          As you can see from the result, in the `content` field, the AI ​​assistant returned the model's response generated without using the uploaded knowledge base. This is due to the fact that the index access [strategy](../../concepts/assistant/tools/vector-store.md) settings contain an instruction to use the knowledge base only if the user specifically asks for it.
  1. Now, in the thread, create a new message that asks for access to the knowledge base:

      1. Modify the `message.json` request body file to create a message by specifying the updated text of the request in the context of the uploaded knowledge base file:

          **message.json**

          ```json
          {
            "threadId": "<thread_ID>",
            "content": {
              "content": [
                {
                  "text": {
                    "content": "How much is a visa to Bali? Please search in the knowledge base."
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
            "id": "fvtpcs3ef1ve********",
            "thread_id": "fvt8rn2ip0fg********",
            "created_by": "ajeol2afu1js********",
            "created_at": "2025-08-27T09:35:00.209975Z",
            "author": {
              "id": "fvtgsemis1k5********",
              "role": "USER"
            },
            "labels": {},
            "content": {
              "content": [
                {
                  "text": {
                    "content": "How much is a visa to Bali? Please search in the knowledge base."
                  }
                }
              ]
            },
            "status": "COMPLETED",
            "citations": []
          }
          ```
  1. Run the assistant again by specifying the path to the `run.json` request body file you created earlier:

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
        "id": "fvtfn4h45gpj********",
        "assistant_id": "fvted8p4d1k1********",
        "thread_id": "fvt8rn2ip0fg********",
        "created_by": "ajeol2afu1js********",
        "created_at": "2025-08-27T09:37:48.807600598Z",
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
  1. Get the result of the run with the assistant's second response. To do this, make a request by specifying the run ID you got earlier:

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
        "id": "fvtfn4h45gpj********",
        "assistant_id": "fvted8p4d1k1********",
        "thread_id": "fvt8rn2ip0fg********",
        "created_by": "ajeol2afu1js********",
        "created_at": "2025-08-27T09:37:48.807600598Z",
        "labels": {},
        "state": {
          "status": "COMPLETED",
          "completed_message": {
            "id": "fvtusjjsbbv9********",
            "thread_id": "fvt8rn2ip0fg********",
            "created_by": "ajeol2afu1js********",
            "created_at": "2025-08-27T09:37:49.837330438Z",
            "author": {
              "id": "fvted8p4d1k1********",
              "role": "ASSISTANT"
            },
            "labels": {},
            "content": {
              "content": [
                {
                  "text": {
                    "content": "A visa to Bali is 300 rubles."
                  }
                }
              ]
            },
            "status": "COMPLETED",
            "citations": [
              {
                "sources": [
                  {
                    "chunk": {
                      "search_index": {
                        "id": "fvti5snpooha********",
                        "folder_id": "b1gt6g8ht345********",
                        "name": "",
                        "description": "",
                        "created_by": "ajeol2afu1js********",
                        "created_at": "2025-08-27T08:27:25.791066Z",
                        "updated_by": "ajeol2afu1js********",
                        "updated_at": "2025-08-27T08:27:31.925785Z",
                        "expiration_config": {
                          "expiration_policy": "SINCE_LAST_ACTIVE",
                          "ttl_days": "7"
                        },
                        "expires_at": "2025-09-03T09:12:32.856123Z",
                        "labels": {},
                        "hybrid_search_index": {
                          "text_search_index": {
                            "chunking_strategy": null,
                            "standard_tokenizer": {},
                            "yandex_lemmer_analyzer": {}
                          },
                          "vector_search_index": {
                            "doc_embedder_uri": "emb://yc.ml.rag-prod.common/text-search-doc/latest",
                            "query_embedder_uri": "emb://yc.ml.rag-prod.common/text-search-query/latest",
                            "chunking_strategy": null
                          },
                          "chunking_strategy": {
                            "static_strategy": {
                              "max_chunk_size_tokens": "800",
                              "chunk_overlap_tokens": "400"
                            }
                          },
                          "normalization_strategy": "MIN_MAX",
                          "combination_strategy": {
                            "mean_combination": {
                              "mean_evaluation_technique": "ARITHMETIC",
                              "weights": [
                                0.5,
                                0.5
                              ]
                            }
                          }
                        }
                      },
                      "source_file": {
                        "id": "fvtjbljvmc0a********",
                        "folder_id": "b1gt6g8ht345********",
                        "name": "",
                        "description": "",
                        "mime_type": "text/markdown",
                        "created_by": "ajeol2afu1js********",
                        "created_at": "2025-08-27T08:25:45.544260Z",
                        "updated_by": "ajeol2afu1js********",
                        "updated_at": "2025-08-27T08:25:45.544260Z",
                        "expiration_config": {
                          "expiration_policy": "SINCE_LAST_ACTIVE",
                          "ttl_days": "7"
                        },
                        "expires_at": "2025-09-03T08:27:25.817732Z",
                        "labels": {}
                      },
                      "content": {
                        "content": [
                          {
                            "text": {
                              "content": "**Bali is a tropical paradise full of unforgettable experiences.**\n\nWe invite you to spend an amazing vacation in Bali. This magical Indonesian island is famous for its beautiful beaches, unique culture, and warm hospitality of its people. Discover breathtaking landscapes, taste delicious local dishes, and make new friends. **What do I need for the trip?** To enter Indonesia, you must have a visa. To obtain it, you will need the following documents:\n* Passport valid for at least 6 months from your entry date. * Two photos meeting consulate requirements. * Hotel booking confirmation or a letter for alternative accommodation. * Round-trip booking or tickets. * Form filled out in English. Note that requirements may change, so be sure to check the current information on the consulate or visa center's website when planning your trip. The visa fee is 300 rubles. Don't miss your chance to visit this beautiful island and create unforgettable memories. Book your Bali vacation today. **We look forward to seeing you!**"
                            }
                          }
                        ]
                      }
                    }
                  }
                ]
              }
            ]
          }
        },
        "usage": {
          "prompt_tokens": "542",
          "completion_tokens": "29",
          "total_tokens": "571"
        },
        "custom_prompt_truncation_options": null,
        "custom_completion_options": null,
        "tools": [],
        "custom_response_format": null
      }
      ```

      {% endcut %}

      As you can see from the result, this time the AI assistant returned, in the `content` field, the model's response based on the uploaded knowledge base, because you had specifically asked it to do so. In addition, the `citations` section contains [source citations](../../concepts/assistant/index.md#citations), listing the knowledge base files and their fragments used to generate the response.

{% endlist %}

#### See also {#see-also}

* [{#T}](./create.md)
* [{#T}](./create-with-labels.md)
* [{#T}](./create-with-websearch.md)
* [{#T}](../../tutorials/pdf-searchindex-ai-assistant.md)
* [{#T}](../../concepts/assistant/tools/index.md)
* Examples of working with {{ ml-sdk-name }} on [GitHub](https://github.com/yandex-cloud/yandex-cloud-ml-sdk/tree/master/examples/sync/assistants)
