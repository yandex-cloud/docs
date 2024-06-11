---
title: "Как отправлять асинхронные запросы в {{ yagpt-full-name }}"
description: "Следуя данной инструкции, вы научитесь отправлять асинхронные запросы к моделям в {{ yagpt-full-name }}."
---

# Отправить асинхронный запрос

Запросы к моделям {{ yagpt-full-name }} можно отправлять в [асинхронном режиме](../../concepts/index.md#working-mode). В ответ на асинхронный запрос модель вернет [объект Operation](../../../api-design-guide/concepts/operation.md), содержащий идентификатор операции, по которому можно [отследить ее выполнение](../../../api-design-guide/concepts/operation.md#monitoring) и получить результат после того, как генерация завершится. Этот режим подходит, если ваши задачи не требуют срочного ответа, поскольку асинхронные запросы выполняются дольше, чем [синхронные](./create-prompt.md).

## Перед началом работы {#before-begin}

{% include notitle [ai-before-beginning](../../../_includes/foundation-models/yandexgpt/ai-before-beginning.md) %}

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

   {% include [api-parameters](../../../_includes/foundation-models/yandexgpt/api-parameters.md) %}

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

   В ответе сервис вернет объект Operation:

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

1. Отправьте запрос на получение результата операции:

    ```bash
    curl -X GET \
      -H "Authorization: Bearer ${IAM_TOKEN}" \
      https://{{ api-host-operation }}/operations/<ID_операции>
    ```

    Пример результата:

    ```bash
    {
      "done": true,
      "response": {
        "@type": "type.googleapis.com/yandex.cloud.ai.foundation_models.v1.CompletionResponse",
        "alternatives": [
          {
            "message": {
              "role": "assistant",
              "text": "Быть или не быть: вот в чём вопрос."
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