---
title: How to send a request in prompt mode to {{ yagpt-full-name }}
description: Follow this guide to learn how to use {{ yagpt-full-name }} in prompt mode.
---

# Sending a request in prompt mode

To generate text in [prompt mode](../concepts/index.md#working-mode), send a request to the model using the [completion](../text-generation/api-ref/TextGeneration/completion.md) method.

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
       "maxTokens": "1000"
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

   Where:

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
     "https://llm.{{ api-host }}/foundationModels/v1/completion"
   ```

   Where:

   * `FOLDER_ID`: ID of the folder for which your account has the `{{ roles-yagpt-user }}` role or higher.
   * `IAM_TOKEN`: IAM token you got [before you started](#before-begin).

   In the response, the service will return the generated text:

   ```json
   {
     "result": {
       "alternatives": [
         {
           "message": {
             "role": "assistant",
             "text": "Быть или не быть - вот в чём вопрос."
           },
           "status": "ALTERNATIVE_STATUS_FINAL"
         }
       ],
       "usage": {
         "inputTextTokens": "28",
         "completionTokens": "10",
         "totalTokens": "38"
       },
       "modelVersion": "06.12.2023"
     }
   }
   ```
