---
title: Как отправить запрос в промт-режиме в {{ yagpt-full-name }}
description: Следуя данной инструкции, вы научитесь использовать {{ yagpt-full-name }} в промт-режиме.
---

# Отправить запрос в промт-режиме

Чтобы сгенерировать текст в [промт-режиме](../concepts/index.md#working-mode), отправьте запрос к модели с помощью метода [completion](../text-generation/api-ref/TextGeneration/completion.md).

## Перед началом работы {#before-begin}

{% include notitle [ai-before-beginning](../../_includes/foundation-models/yandexgpt/ai-before-beginning.md) %}

## Отправьте запрос к модели {#request}

1. Создайте файл с телом запроса (например, `body.json`):

   ```json
   {
     "modelUri": "gpt://<идентификатор_каталога>/yandexgpt-lite",
     "completionOptions": {
       "stream": false,
       "temperature": 0.1,
       "maxTokens": "1000"
     },
     "messages": [
       {
         "role": "system",
         "text": "Переведи текст"
       },
       {
         "role": "user",
         "text": "To be, or not to be: that is the question."
       }
     ]
   }
   ```

   Где:

   {% include [api-parameters](../../_includes/foundation-models/yandexgpt/api-parameters.md) %}

1. Отправьте запрос к модели, выполнив команду:

   ```bash
   export FOLDER_ID=<идентификатор_каталога>
   export IAM_TOKEN=<IAM-токен>
   curl --request POST \
     -H "Content-Type: application/json" \
     -H "Authorization: Bearer ${IAM_TOKEN}" \
     -H "x-folder-id: ${FOLDER_ID}" \
     -d "@<путь_до_файла_json>" \
     "https://llm.{{ api-host }}/foundationModels/v1/completion"
   ```

   Где:

   * `FOLDER_ID`— идентификатор каталога, на который у вашего аккаунта есть роль `{{ roles-yagpt-user }}` или выше.
   * `IAM_TOKEN` — IAM-токен, полученный [перед началом работы](#before-begin).

   В ответе сервис вернет сгенерированный текст:

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
