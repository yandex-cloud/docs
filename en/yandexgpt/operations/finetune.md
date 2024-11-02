---
title: How to send requests to fine-tuned models in {{ yagpt-full-name }}
description: Follow this guide to learn how to send requests to fine-tuned models.
---

# Sending a request to a fine-tuned model

You can send requests to fine-tuned models in {{ yagpt-name }}. Requests to the following models are supported:

* {{ yagpt-name }} model fine-tuned for summarizing texts.
* [Fine-tuned foundation models](../../datasphere/concepts/models/tuned-models.md) in {{ ml-platform-full-name }}.

## Getting started {#before-begin}

{% include notitle [ai-before-beginning](../../_includes/foundation-models/yandexgpt/ai-before-beginning.md) %}

## Sending a request for text summarization {#text-summarization}

1. Create a file with the request body, e.g., `body.json`:

   ```json
   {
     "modelUri": "gpt://<folder_ID>/summarization",
     "completionOptions": {
       "stream": false,
       "temperature": 0.1,
       "maxTokens": "2000"
     },
     "messages": [
       {
         "role": "user",
         "text": "<article_text>"
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
     "https://llm.{{ api-host }}/foundationModels/v1/completion"
   ```

   Where:

   * `FOLDER_ID`: ID of the folder for which your account has the `{{ roles-yagpt-user }}` role or higher.
   * `IAM_TOKEN`: IAM token you got [before you started](#before-begin).

   Here is an example of the result for the SSH protocol article:

   ```json
   {
     "result": {
       "alternatives": [
         {
           "message": {
             "role": "assistant",
             "text": "- SSH is a network protocol for secure communication between computers.\n
             - SSH is used to connect to remote servers, run commands, copy and edit files.\n
             - SSH is widely used in enterprise infrastructures to install updates and manage business-critical systems.\n
             - Unix and Linux support SSH natively. Windows also supports it through free SSH clients.\n
             - The use of SSH involves an SSH server and an SSH client that create a secure connection to transmit encrypted data.\n
             - SSH ensures reliability through user authentication and processing the transmitted data.\n
             - SSH servers support these three authentication methods: IP address authentication, username/password authentication, and key authentication.\n
             - SSH keys provide a high level of security and are easy to use in scripts to automate routine operations."
           },
           "status": "ALTERNATIVE_STATUS_FINAL"
         }
       ],
       "usage": {
         "inputTextTokens": "1609",
         "completionTokens": "168",
         "totalTokens": "1777"
       },
       "modelVersion": "06.12.2023"
     }
   }
   ```

