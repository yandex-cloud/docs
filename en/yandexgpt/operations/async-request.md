---
title: How to send asynchronous requests to {{ yagpt-full-name }}
description: Follow this guide to send asynchronous requests to models in {{ yagpt-full-name }}
---

# Sending an asynchronous request

You can send requests to the models [asynchronously](../concepts/index.md#working-mode). In response to such a request, you will receive the operation ID and use it to track the operation progress.

## Getting started {#before-begin}

{% include notitle [ai-before-beginning](../../_includes/foundation-models/yandexgpt/ai-before-beginning.md) %}

## Send a request to the model {#request}

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

   {% include [api-parameters](../../_includes/foundation-models/yandexgpt/api-parameters.md) %}

1. To send the request to the model, run this command:

   ```bash
   export FOLDER_ID=<folder_ID>
   export IAM_TOKEN=<IAM_token>
   curl --request POST \
     -H "Content-Type: application/json" \
     -H "Authorization: Bearer ${IAM_TOKEN}" \
     -H "x-folder-id: ${FOLDER_ID}" \
     -d "@<path_to_json_file>" \
     "https://llm.{{ api-host }}/foundationModels/v1/completionAsync"
   ```

   Where:

   * `FOLDER_ID`: ID of the folder for which your account has the `{{ roles-yagpt-user }}` role or higher.
   * `IAM_TOKEN`: IAM token received [before starting](#before-begin).

   In response, the service will return an [Operation object](../../api-design-guide/concepts/operation.md):

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

   Save the operation `id` received in the response.

1. Send a request to [get information about the operation](../../api-design-guide/concepts/operation.md#monitoring):

   ```bash
   curl -H "Authorization: Bearer ${IAM_TOKEN}" \
     https://llm.{{ api-host }}/operations/<operation_ID>
   ```

   Result example:

   ```bash
   {
      "done": true,
      "response": {
         ...        
      },
      "id": "e03sup6d5h1q********",
      "createdAt": "2023-04-21T22:49:29Z",
      "createdBy": "ajes08feato8********",
      "modifiedAt": "2023-04-21T22:49:36Z"
   }
   ```
