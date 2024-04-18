---
title: "How to send requests to fine-tuned models in {{ yagpt-full-name }}"
description: "Follow this guide to learn how to send requests to fine-tuned models."
---

# Sending requests to fine-tuned models

You can send requests to fine-tuned models in {{ yagpt-name }}. Requests to the following models are supported:

* {{ yagpt-name }} model fine-tuned for summarizing texts.
* [Fine-tuned foundation models](../../../datasphere/concepts/models/tuned-models.md) in {{ ml-platform-full-name }}.

## Getting started {#before-begin}

{% include notitle [ai-before-beginning](../../../_includes/yandexgpt/ai-before-beginning.md) %}

## Send a request for text summarization {#text-summarization}

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

   {% include [api-parameters](../../../_includes/yandexgpt/api-parameters.md) %}

1. To send the request to the model, run this command:

   ```bash
   export FOLDER_ID=<folder_ID>
   export IAM_TOKEN=<IAM_token>
   curl --request POST \
     -H "Content-Type: application/json" \
     -H "Authorization: Bearer ${IAM_TOKEN}" \
     -H "x-folder-id: ${FOLDER_ID}" \
     -d "@<path_to_json_file>" \
     "https://llm.{{ api-host }}/foundationModels/v1/completion"
   ```

   Where:

   * `FOLDER_ID`: ID of the folder for which your account has the `{{ roles-yagpt-user }}` role or higher.
   * `IAM_TOKEN`: IAM token received [before starting](#before-begin).

   Here is an example result for the SSH protocol article:

   ```json
   {
     "result": {
       "alternatives": [
         {
           "message": {
             "role": "assistant",
             "text": "- SSH is a network protocol for secure interaction between computers.\n
             - SSH is used for connecting to remote servers, executing commands, copying and editing files.\n
             - SSH is widely used in corporate infrastructure for installing updates and managing business-critical systems.\n
             - SSH support is built into Unix and Linux operating systems, as well as in Windows with free SSH clients.\n
             - SSH operation involves an SSH server and an SSH client, which establish a secure connection for transmitting encrypted data.\n
             - The reliability of SSH is ensured by user authentication and processing of transmitted data.\n
             - The SSH server supports three methods of authentication: by IP address, by login/password, and by key.\n
             - SSH keys provide a high degree of protection and convenience for use in scripts to automate routine operations."
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

