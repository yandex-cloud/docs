---
title: Как отправлять асинхронные запросы в {{ yagpt-full-name }}
description: Следуя данной инструкции, вы научитесь отправлять асинхронные запросы к моделям в {{ yagpt-full-name }}
---

# Отправить асинхронный запрос

Запросы к моделям можно отправлять в [асинхронном режиме](../concepts/index.md#working-mode). В ответ на такой запрос вернется идентификатор операции, по которому можно отслеживать ее выполнение.

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
       "maxTokens": "2000"
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
     "https://llm.{{ api-host }}/foundationModels/v1/completionAsync"
   ```

   Где:

   * `FOLDER_ID`— идентификатор каталога, на который у вашего аккаунта есть роль `{{ roles-yagpt-user }}` или выше.
   * `IAM_TOKEN` — IAM-токен, полученный [перед началом работы](#before-begin).

   В ответе сервис вернет [объект Operation](../../api-design-guide/concepts/operation.md):

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

   Сохраните идентификатор (`id`) операции, полученный в ответе.

1. Отправьте запрос на [получение информации об операции](../../api-design-guide/concepts/operation.md#monitoring):

   ```bash
   curl -H "Authorization: Bearer ${IAM_TOKEN}" \
     https://llm.{{ api-host }}/operations/<идентификатор_операции>
   ```

   Пример результата:

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
