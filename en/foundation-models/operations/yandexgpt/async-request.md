---
title: How to send asynchronous requests to {{ yagpt-full-name }}
description: Follow this guide to learn how to send asynchronous requests to models in {{ yagpt-full-name }}.
---

# Sending an asynchronous request

You can request {{ yagpt-full-name }} models in [asynchronous mode](../../concepts/index.md#working-mode). In response to an asynchronous request, the model will return an [Operation object](../../../api-design-guide/concepts/operation.md) containing an operation ID, which you can use to [track its execution](../../../api-design-guide/concepts/operation.md#monitoring) and get the result after generation is completed. Use this mode if you do not need an urgent response, since asynchronous requests take longer to complete than [synchronous](./create-prompt.md) ones.

## Getting started {#before-begin}

{% include notitle [ai-before-beginning](../../../_includes/foundation-models/yandexgpt/ai-before-beginning.md) %}

## Send a request to the model {#request}

{% list tabs group=programming_language %}

- Bash {#bash}

  {% include [curl](../../../_includes/curl.md) %}
  
  {% include [bash-windows-note-single](../../../_includes/translate/bash-windows-note-single.md) %}

  1. Create a file with the request body, e.g., `body.json`:
  
     ```json
     {
       "modelUri": "gpt://<folder_ID>/yandexgpt-lite",
       "completionOptions": {
         "stream": false,
         "temperature": 0.1,
         "maxTokens": "2000"
       },
       "messages": [
         {
           "role": "system",
           "text": "Translate the text"
         },
         {
           "role": "user",
           "text": "To be, or not to be: that is the question."
         }
       ]
     }
     ```
  
     {% include [api-parameters](../../../_includes/foundation-models/yandexgpt/api-parameters.md) %}
  
  1. Send a request to the model by running this command:
  
     ```bash
     export FOLDER_ID=<folder_ID>
     export IAM_TOKEN=<IAM_token>
     curl \
       --request POST \
       --header "Content-Type: application/json" \
       --header "Authorization: Bearer ${IAM_TOKEN}" \
       --header "x-folder-id: ${FOLDER_ID}" \
       --data "@<path_to_JSON_file>" \
       "https://llm.{{ api-host }}/foundationModels/v1/completionAsync"
     ```
  
     Where:
  
     * `FOLDER_ID`: ID of the folder for which your account has the `{{ roles-yagpt-user }}` role or higher.
     * `IAM_TOKEN`: IAM token you got [before you started](#before-begin).
  
     In response, the service will return the Operation object:
  
     ```json
     {
       "id": "d7qi6shlbvo5********",
       "description": "Async GPT Completion",
       "createdAt": "2023-11-30T18:31:32Z",
       "createdBy": "aje2stn6id9k********",
       "modifiedAt": "2023-11-30T18:31:33Z",
       "done": false,
       "metadata": null
     }
     ```
  
     Save the operation `id` you get in the response.
  
  1. Send a request to get the operation result:
  
      ```bash
      curl \
        --request GET \
        --header "Authorization: Bearer ${IAM_TOKEN}" \
        https://{{ api-host-operation }}/operations/<operation_ID>
      ```
  
      Result example:
  
      ```bash
      {
        "done": true,
        "response": {
          "@type": "type.googleapis.com/yandex.cloud.ai.foundation_models.v1.CompletionResponse",
          "alternatives": [
            {
              "message": {
                "role": "assistant",
                "text": "To be, or not to be, that is the question."
              },
              "status": "ALTERNATIVE_STATUS_FINAL"
            }
          ],
          "usage": {
            "inputTextTokens": "31",
            "completionTokens": "10",
            "totalTokens": "41"
          },
          "modelVersion": "18.01.2024"
        },
        "id": "d7qo21o5fj1u********",
        "description": "Async GPT Completion",
        "createdAt": "2024-05-12T18:46:54Z",
        "createdBy": "ajes08feato8********",
        "modifiedAt": "2024-05-12T18:46:55Z"
      }
      ```

{% endlist %}