---
title: Как отправлять асинхронные запросы в API генерации текста
description: Следуя данной инструкции, вы научитесь отправлять асинхронные запросы к моделям {{ gpt-lite }} и {{ gpt-pro }}.
---

# Отправить асинхронный запрос

Запросы к моделям генерации текста можно отправлять в [асинхронном режиме](../../concepts/index.md#working-mode). В ответ на асинхронный запрос модель вернет [объект Operation](../../../api-design-guide/concepts/operation.md), содержащий идентификатор операции, по которому можно [отследить ее выполнение](../../../api-design-guide/concepts/operation.md#monitoring) и получить результат после того, как генерация завершится. Этот режим подходит, если ваши задачи не требуют срочного ответа, поскольку асинхронные запросы выполняются дольше, чем [синхронные](./create-prompt.md).

## Перед началом работы {#before-begin}

{% list tabs group=programming_language %}

- SDK {#sdk}

  Чтобы воспользоваться примерами запросов с использованием SDK:

  {% include [sdk-before-begin-ai-langmodel-user](../../../_includes/foundation-models/sdk-before-begin-ai-langmodel-user.md) %}

- cURL {#curl}

  {% include notitle [ai-before-beginning](../../../_includes/foundation-models/yandexgpt/ai-before-beginning.md) %}

  {% include [curl](../../../_includes/curl.md) %}

{% endlist %}

## Отправьте запрос к модели {#request}

{% list tabs group=programming_language %}

- SDK {#sdk}

  При использовании [{{ ml-sdk-full-name }}](../../sdk/index.md) ваш код может дождаться завершения выполнения операции и получения ответа. Для этого можно использовать либо функцию `sleep` модуля `time`, либо метод `wait`. В приведенном примере последовательно используются оба эти способа.

  1. Создайте файл `generate-deferred.py` и добавьте в него следующий код:

      {% include [yandexgpt-deferred-sdk](../../../_includes/foundation-models/examples/yandexgpt-deferred-sdk.md) %}

      Где:

      {% note info %}

      {% include [sdk-input-format](../../../_includes/foundation-models/sdk-input-format.md) %}

      {% endnote %}

      * `messages_1` и `messages_2` — массивы сообщений, которые задают контекст для модели и используются для разных способов получения результата выполнения асинхронного запроса:

          * `role` — роль отправителя сообщения:

              * `user` — предназначена для отправки пользовательских сообщений к модели.
              * `system` — позволяет задать контекст запроса и определить поведение модели.
              * `assistant` — используется для ответов, которые генерирует модель. При работе в режиме чата ответы модели, помеченные ролью `assistant`, включаются в состав сообщения для сохранения контекста беседы. Не передавайте сообщения пользователя с этой ролью.

      * `text` — текстовое содержимое сообщения.

      {% include [sdk-code-legend](../../../_includes/foundation-models/examples/sdk-code-legend.md) %}

      {% include [yandexgpt-model-version-sdk-info](../../../_includes/foundation-models/yandexgpt/yandexgpt-model-version-sdk-info.md) %}

  1. Выполните созданный файл:

      ```bash
      python3 generate-deferred.py
      ```

      Результат:

      ```text
      Variant 1:
      GPTModelResult(alternatives=(Alternative(role='assistant', text='Ламинат подойдёт для укладки на кухне или в детской комнате – он не боится влаги и механических повреждений благодаря защитному слою из облицованных меламиновых плёнок толщиной 0,2 мм и обработанным воском замкам.', status=<AlternativeStatus.FINAL: 3>),), usage=Usage(input_text_tokens=74, completion_tokens=46, total_tokens=120), model_version='23.10.2024')
      Variant 2:
      GPTModelResult(alternatives=(Alternative(role='assistant', text='Ошибки сами себя не исправят.\n\nАшипки → ошибки.', status=<AlternativeStatus.FINAL: 3>),), usage=Usage(input_text_tokens=32, completion_tokens=16, total_tokens=48), model_version='23.10.2024')
      ```

      Код дожидается получения результата сначала для первого способа, затем — для второго.

- cURL {#curl}

  {% include [curl](../../../_includes/curl.md) %}
  
  {% include [bash-windows-note-single](../../../_includes/translate/bash-windows-note-single.md) %}

  1. Создайте файл с телом запроса (например, `body.json`):
  
     ```json
     {
       "modelUri": "gpt://<идентификатор_каталога>/yandexgpt",
       "completionOptions": {
         "stream": false,
         "temperature": 0.1,
         "maxTokens": "2000",
         "reasoningOptions": {
           "mode": "DISABLED"
         }
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
     curl \
       --request POST \
       --header "Content-Type: application/json" \
       --header "Authorization: Bearer ${IAM_TOKEN}" \
       --header "x-folder-id: ${FOLDER_ID}" \
       --data "@<путь_до_файла_json>" \
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
      curl \
        --request GET \
        --header "Authorization: Bearer ${IAM_TOKEN}" \
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

{% endlist %}

#### См. также {#see-also}

* [{#T}](../../concepts/generation/index.md)
* Примеры работы с {{ ml-sdk-name }} на [GitHub](https://github.com/yandex-cloud/yandex-cloud-ml-sdk/tree/master/examples/sync/completions)