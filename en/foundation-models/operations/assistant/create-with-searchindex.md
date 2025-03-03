# Creating an assistant with a search index

{% include [assistants-preview-stage](../../../_includes/foundation-models/assistants-preview-stage.md) %}

{{ assistant-api }} is a tool for creating [AI assistants](../../concepts/assistant/index.md). It can be used to create personalized assistants, implement a generative response scenario adapted based on external information (known as _retrieval augmented generation_, or RAG), and save the model's request context.

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

  This example shows you how to create an [assistant](../../concepts/assistant/index.md) that uses information from files for responses. In the example, we will create an index for full-text search and a simplest chat.

  1. {% include [download-context-file-step](../../../_includes/foundation-models/assistants/download-context-file-step.md) %}
  1. Create a file named `search-assistant.py` and paste the following code into it:

      {% include [searchindex-assistant](../../../_includes/foundation-models/examples/searchindex-assistant.md) %}

      Where:

      * `mypath`: Variable containing the path to the directory containing the files you downloaded earlier, e.g., `/Users/myuser/tours-example/`.

      {% include [sdk-code-legend](../../../_includes/foundation-models/examples/sdk-code-legend.md) %}

  1. Run the created file:

      ```bash
      python3 search-assistant.py
      ```

      The example implements the simplest chat possible: enter your requests to the assistant from your keyboard and get answers. To end the dialog, enter `exit`.

      {% cut "Estimated result" %}

      ```text
      Enter your question to the assistant: How much is a visa to Bali?
      Answer: 300 rubles.
      Enter your question to the assistant: Do I need a visa to enter Kazakhstan?
      Answer: The text above says that a passport is required to enter Kazakhstan from Russia. It does not mention a visa in the context of traveling to Kazakhstan.

      Answer: the given context provides no information about the cost and necessity of a visa to enter Kazakhstan, but it specifies that a valid passport is required.
      Enter your question to the assistant: Thank you!
      Answer: You are welcome! Is there anything else I can help you with?
      Enter your question to the assistant: exit
      Outputting the whole message history when exiting the chat:
          message=Message(id='fvtaegenk534********', parts=('You are welcome! Is there anything else I can help you with?',), thread_id='fvtm560nq0a5********', created_by='ajegtlf2q28a********', created_at=datetime.datetime(2024, 12, 15, 21, 23, 15, 874678), labels=None, author=Author(id='fvtdo7i9cjot********', role='ASSISTANT'))
          message.text='You are welcome! Is there anything else I can help you with?'

          message=Message(id='fvtrpbdnn8ar********', parts=('Thank you!',), thread_id='fvtm560nq0a5********', created_by='ajegtlf2q28a********', created_at=datetime.datetime(2024, 12, 15, 21, 23, 14, 896935), labels=None, author=Author(id='fvtjg25ejkk0********', role='USER'))
          message.text='Thank you!'

          message=Message(id='fvt1jbftbspp********', parts=('The text above says that a passport is required to enter Kazakhstan from Russia. It does not mention a visa in the context of traveling to Kazakhstan.\n\nAnswer: the given context provides no information about the cost and necessity of a visa to enter Kazakhstan, but it specifies that a valid passport is required.' that a valid passport is required.',), thread_id='fvtm560nq0a5********', created_by='ajegtlf2q28a********', created_at=datetime.datetime(2024, 12, 15, 21, 22, 42, 310047), labels=None, author=Author(id='fvtdo7i9cjot********', role='ASSISTANT'))
          message.text='The text above says that a passport is required to enter Kazakhstan from Russia. It does not mention a visa in the context of traveling to Kazakhstan.\n\nAnswer: the given context provides no information about the cost and necessity of a visa to enter Kazakhstan, but it specifies that a valid passport is required.'

          message=Message(id='fvt1ugupmhe4********', parts=('Do I need a visa to enter Kazakhstan?',), thread_id='fvtm560nq0a5********', created_by='ajegtlf2q28a********', created_at=datetime.datetime(2024, 12, 15, 21, 22, 39, 789471), labels=None, author=Author(id='fvtjg25ejkk0********', role='USER'))
          message.text='Do I need a visa to enter Kazakhstan?'

          message=Message(id='fvtif8psp9ve363c5irj', parts=('300 rubles.',), thread_id='fvtm560nq0a5********', created_by='ajegtlf2q28a********', created_at=datetime.datetime(2024, 12, 15, 21, 22, 27, 546395), labels=None, author=Author(id='fvtdo7i9cjot********', role='ASSISTANT'))
          message.text='300 rubles.'

          message=Message(id='fvt82ggg27ui********', parts=('How much is a visa to Bali?',), thread_id='fvtm560nq0a5********', created_by='ajegtlf2q28a********', created_at=datetime.datetime(2024, 12, 15, 21, 22, 26, 794009), labels=None, author=Author(id='fvtjg25ejkk0********', role='USER'))
          message.text='How much is a visa to Bali?'
      ```

      {% endcut %}

- cURL {#curl}

  This example shows you how to create an [assistant](../../concepts/assistant/index.md) that uses information from files for responses. In this example, we will show the basic algorithm for working with {{ assistant-api }} via the [REST API](../../assistants/api-ref/index.md) interface: creating an index for hybrid search, creating an assistant and a thread, and submitting a request to the assistant.

  1. Upload the context file for the knowledge base using the [Files API](../../files/api-ref/File/index.md):
      1. {% include [download-context-file-step](../../../_includes/foundation-models/assistants/download-context-file-step.md) %}

          You will use the `bali.md` file from the downloaded archive as the knowledge base in this example.
      1. Encode the `bali.md` file into [Base64]({{ link-base64 }}):

          ```bash
          base64 -i bali.md -o bali-b64coded.txt
          ```
      1. Create a file named `body.json` with the body of the file upload request:

          **body.json**

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
          * `<path_to_request_body>`: Path to the previously created request body file (`body.json`).

          Result:

          ```json
          {
            "id": "fvtrdof2njh********",
            "folder_id": "b1gt6g8ht345********",
            "name": "",
            "description": "",
            "mime_type": "text/markdown",
            "created_by": "ajeg2b2et02f********",
            "created_at": "2025-02-06T06:33:08.172814Z",
            "updated_by": "ajeg2b2et02f********",
            "updated_at": "2025-02-06T06:33:08.172814Z",
            "expiration_config": {
              "expiration_policy": "SINCE_LAST_ACTIVE",
              "ttl_days": "7"
            },
            "expires_at": "2025-02-13T06:33:08.172814Z",
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
            "id": "fvtkc1eg493r********",
            "description": "search index creation",
            "created_at": "2025-02-06T06:40:43.288447Z",
            "created_by": "ajeg2b2et02f********",
            "modified_at": "2025-02-06T06:40:43.288447Z",
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
                  "ngramTokenizer": {
                    "minGram": "3",
                    "maxGram": "4"
                  }
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
              "id": "fvtjouke8mf8********",
              "folderId": "b1gt6g8ht345********",
              "createdBy": "ajeg2b2et02f********",
              "createdAt": "2025-02-06T10:58:02.705408Z",
              "updatedBy": "ajeg2b2et02f********",
              "updatedAt": "2025-02-06T10:58:02.705408Z",
              "expiresAt": "2025-02-13T10:58:02.705408Z"
            },
            "id": "fvtauj5naahe********",
            "description": "search index creation",
            "createdAt": "2025-02-06T10:58:02.745290Z",
            "createdBy": "ajeg2b2et02f********",
            "modifiedAt": "2025-02-06T10:58:14.870249Z"
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
            "tools": [
              {
                "searchIndex": {
                  "searchIndexIds": [
                    "<index_ID>"
                  ]
                }
              }
            ]
          }
          ```

          Where:
          * `modelUri`: [URI](../../concepts/yandexgpt/models.md#generation) of the text generation model.
          * `searchIndexIds`: Search index ID you got at the previous step.
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
            "id": "fvtuc79tgfsj********",
            "folder_id": "b1gt6g8ht345********",
            "name": "",
            "description": "",
            "created_by": "ajeg2b2et02f********",
            "created_at": "2025-02-06T06:54:24.617824Z",
            "updated_by": "ajeg2b2et02f********",
            "updated_at": "2025-02-06T06:54:24.617824Z",
            "expiration_config": {
              "expiration_policy": "SINCE_LAST_ACTIVE",
              "ttl_days": "7"
            },
            "expires_at": "2025-02-13T06:54:24.617824Z",
            "labels": {},
            "model_uri": "gpt://b1gt6g8ht345********/yandexgpt-lite/latest",
            "instruction": "",
            "prompt_truncation_options": {
              "max_prompt_tokens": null
            },
            "completion_options": {
              "max_tokens": null,
              "temperature": null
            },
            "tools": [
              {
                "search_index": {
                  "search_index_ids": [
                    "fvtdso8kepkn********"
                  ],
                  "max_num_results": null
                }
              }
            ]
          }
          ```

          {% endcut %}

          In response, {{ assistant-api }} will return your new AI assistant's ID. Save the ID (`id` field value). You will need it when accessing the assistant.
  1. Create a thread:

      1. Create a file named `thread.json` with the body of the request to create a thread by specifying the search index ID you got earlier:

          **thread.json**

          ```json
          {
            "folderId": "<folder_ID>",
            "tools": [
              {
                "searchIndex": {
                  "searchIndexIds": [
                    "<index_ID>"
                  ]
                }
              }
            ]
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
            "id": "fvt48f07voik********",
            "folder_id": "b1gt6g8ht345********",
            "name": "",
            "description": "",
            "default_message_author_id": "fvtt5afqqige********",
            "created_by": "ajeg2b2et02f********",
            "created_at": "2025-02-06T07:11:36.729404Z",
            "updated_by": "ajeg2b2et02f********",
            "updated_at": "2025-02-06T07:11:36.729404Z",
            "expiration_config": {
              "expiration_policy": "SINCE_LAST_ACTIVE",
              "ttl_days": "7"
            },
            "expires_at": "2025-02-13T07:11:36.729404Z",
            "labels": {}
          }
          ```

          Save the obtained thread ID (`id` field value). You will need it later.
  1. Create a message in your thread:

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
            "id": "fvt94qdq0a0h********",
            "thread_id": "fvt48f07voik********",
            "created_by": "ajeg2b2et02f********",
            "created_at": "2025-02-06T07:22:05.868535Z",
            "author": {
              "id": "fvtt5afqqige********",
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
            "status": "COMPLETED"
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
            "id": "fvtvn4ier4kf********",
            "assistant_id": "fvtuc79tgfsj********",
            "thread_id": "fvt48f07voik********",
            "created_by": "ajeg2b2et02f********",
            "created_at": "2025-02-06T07:29:53.666326755Z",
            "labels": {},
            "state": {
              "status": "PENDING"
            },
            "usage": null,
            "custom_prompt_truncation_options": null,
            "custom_completion_options": null
          }
          ```

          {{ assistant-api }} has returned the launch information: the launch is in `PENDING` status. Save the launch ID (`id` field value). You will need it in the next step.

      1. Get the launch outcome with the assistant's response. To do this, run a request by specifying the launch ID you got earlier:

          ```bash
          curl \
            --request GET \
            --header "Authorization: Bearer ${IAM_TOKEN}" \
            --silent \
            "https://rest-assistant.{{ api-host }}/assistants/v1/runs/<launch_ID>" | \
            jq
          ```

          {% cut "Result" %}

          ```json
          {
            "id": "fvtvn4ier4kf********",
            "assistant_id": "fvtuc79tgfsj********",
            "thread_id": "fvt48f07voik********",
            "created_by": "ajeg2b2et02f********",
            "created_at": "2025-02-06T07:29:53.666326755Z",
            "labels": {},
            "state": {
              "status": "COMPLETED",
              "completed_message": {
                "id": "fvtae9fshgj7********",
                "thread_id": "fvt48f07voik********",
                "created_by": "ajeg2b2et02f********",
                "created_at": "2025-02-06T07:29:54.251043040Z",
                "author": {
                  "id": "fvtuc79tgfsj********",
                  "role": "ASSISTANT"
                },
                "labels": {},
                "content": {
                  "content": [
                    {
                      "text": {
                        "content": "A visa to Bali costs 300 rubles."
                      }
                    }
                  ]
                },
                "status": "COMPLETED"
              }
            },
            "usage": {
              "prompt_tokens": "306",
              "completion_tokens": "11",
              "total_tokens": "317"
            },
            "custom_prompt_truncation_options": null,
            "custom_completion_options": null
          }
          ```

          {% endcut %}

          In the `content` field, the AI ​​assistant has returned a response to the model based on the uploaded knowledge base.

{% endlist %}

#### See also {#see-also}

* [{#T}](./create.md)
* Examples of working with ML SDK on [GitHub](https://github.com/yandex-cloud/yandex-cloud-ml-sdk/tree/master/examples/sync/assistants)