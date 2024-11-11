---
title: How to send asynchronous requests to {{ yagpt-full-name }}
description: Follow this guide to learn how to send asynchronous requests to models in {{ yagpt-full-name }}.
---

# Sending an asynchronous request

You can send requests to the models [asynchronously](../concepts/index.md#working-mode). In response to such a request, you will get the operation ID you can use to track its progress.

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

   In the response, the service will return the [Operation object](../../api-design-guide/concepts/operation.md):

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

1. Send a request to [get information about the operation](../../api-design-guide/concepts/operation.md#monitoring):

   ```bash
   curl \
     --header "Authorization: Bearer ${IAM_TOKEN}" \
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
