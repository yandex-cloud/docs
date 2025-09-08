---
title: Создать ассистента с инструментом WebSearch
description: Следуя этой инструкции, с помощью {{ assistant-api }} вы сможете создать персонализированного ассистента, реализующего сценарий генеративного ответа с учетом информации, получаемой из поисковой системы с использованием инструмента WebSearch
---

# Создать ассистента с инструментом WebSearch

{% include [assistants-preview-stage](../../../_includes/foundation-models/assistants-preview-stage.md) %}

{{ assistant-api }} — это функциональность {{ foundation-models-name }} для создания [AI-ассистентов](../../concepts/assistant/index.md). С его помощью можно создать персонализированных помощников, реализовывать сценарий генеративного ответа с учетом информации из внешних источников ([RAG](https://ru.wikipedia.org/wiki/Генерация,_дополненная_поиском), Retrieval Augmented Generation), а также сохранять контекст запросов к модели.

Получать информацию из источников в интернете AI-ассистентам позволяет [инструмент](../../concepts/assistant/tools/web-search.md) WebSearch.

{% note info %}

Использование инструмента WebSearch тарифицируется как [генеративный ответ](../../../search-api/pricing.md) сервиса {{ search-api-full-name }}.

{% endnote %}

## Перед началом работы {#before-begin}

Чтобы воспользоваться примерами:

{% list tabs group=programming_language %}

- cURL {#curl}

  {% include notitle [ai-before-beginning](../../../_includes/foundation-models/yandexgpt/ai-before-beginning.md) %}

  Чтобы воспользоваться примерами, установите утилиты [cURL](https://curl.haxx.se) и [jq](https://stedolan.github.io/jq).

{% endlist %}

## Создайте ассистента {#create-assistant}

{% list tabs group=programming_language %}

- cURL {#curl}

  Этот пример показывает, как создать [ассистента](../../concepts/assistant/index.md), который для ответов использует информацию из интернета. В примере будет задействован базовый алгоритм работы с {{ assistant-api }} через интерфейс [REST API](../../assistants/api-ref/index.md) — создание ассистента и треда, а также последующее обращение к ассистенту с запросом.
  
  В качестве внешних источников информации будут использованы [официальный сайт](https://cbr.ru/) Центрального банка Российской Федерации и сервис [Курсы валют](https://yandex.ru/finance/currencies) Яндекса. Если вы хотите искать информацию по всему интернету, то оставьте пустым значение поля `options` инструмента WebSearch.

  1. Создайте AI-ассистента:

      1. Создайте файл `assistant.json` с телом запроса на создание ассистента:

          **assistant.json**

          ```json
          {
            "folderId": "<идентификатор_каталога>",
            "modelUri": "gpt://<идентификатор_каталога>/yandexgpt-lite/latest",
            "instruction": "Ты — умный помощник финансовой компании. Отвечай вежливо. Для ответов на вопросы воспользуйся инструментом поиска. Не придумывай ответ.",
            "tools": [
              {
                "genSearch": {
                  "options": {
                    "site": {
                      "site": [
                        "https://cbr.ru/",
                        "https://yandex.ru/finance/currencies"
                      ]
                    },
                    "enableNrfmDocs": true
                  },
                  "description": "Инструмент для получения информации об официальных курсах валют."
                }
              }
            ]
          }
          ```

          Где:
          * `folderId` — [идентификатор](../../../resource-manager/operations/folder/get-id.md) каталога, на который у вашего аккаунта есть [роли](../../../iam/concepts/access-control/roles.md) [`ai.assistants.editor`](../../security/index.md#ai-assistants-editor) и [`{{ roles-yagpt-user }}`](../../security/index.md#languageModels-user) или выше.
          * `modelUri` — [URI](../../concepts/generation/models.md#generation) используемой модели генерации текста.
          * `instruction` — базовая инструкция, в соответствии с которой AI-ассистент будет выполнять запросы пользователя.
          * `tools` — настройки [инструмента](../../concepts/assistant/tools/index.md), который будет использоваться создаваемым ассистентом:

              * `site` — массив сайтов, на которых ассистент будет иметь возможность искать информацию.
              * `enableNrfmDocs` — параметр, который определяет, попадут ли в результаты поиска документы, недоступные при прямом переходе с главных страниц заданных сайтов.
              * `description` — описание создаваемого инструмента, который позволяет ассистенту понять, нужно ли при генерации ответа на конкретный запрос использовать данный инструмент.

              Подробнее о доступных настройках инструмента WebSearch для поиска в интернете см. в разделе [{#T}](../../concepts/assistant/tools/web-search.md).
      1. Отправьте запрос на создание AI-ассистента, указав путь к созданному файлу `assistant.json` с телом запроса:

          ```bash
          export IAM_TOKEN=<IAM-токен>
          curl \
            --request POST \
            --header "Authorization: Bearer ${IAM_TOKEN}" \
            --silent \
            --data "@<путь_к_телу_запроса>" \
            "https://rest-assistant.{{ api-host }}/assistants/v1/assistants" | \
            jq
          ```

          Где:
          * `<IAM-токен>` — IAM-токен, полученный [перед началом работы](#before-begin).
          * `<путь_к_телу_запроса>` — путь к созданному ранее файлу с телом запроса `assistant.json`.

          {% cut "Результат" %}

          ```json
          {
            "id": "fvthd7m0d6up********",
            "folder_id": "b1gt6g8ht345********",
            "name": "",
            "description": "",
            "created_by": "ajeol2afu1js********",
            "created_at": "2025-08-27T11:07:37.532517Z",
            "updated_by": "ajeol2afu1js********",
            "updated_at": "2025-08-27T11:07:37.532517Z",
            "expiration_config": {
              "expiration_policy": "SINCE_LAST_ACTIVE",
              "ttl_days": "7"
            },
            "expires_at": "2025-09-03T11:07:37.532517Z",
            "labels": {},
            "model_uri": "gpt://b1gt6g8ht345********/yandexgpt-lite/latest",
            "instruction": "Ты — умный помощник финансовой компании. Отвечай вежливо. Для ответов на вопросы воспользуйся инструментом поиска. Не придумывай ответ.",
            "prompt_truncation_options": {
              "max_prompt_tokens": null,
              "auto_strategy": {}
            },
            "completion_options": {
              "max_tokens": null,
              "temperature": null
            },
            "tools": [
              {
                "gen_search": {
                  "options": {
                    "site": {
                      "site": [
                        "https://cbr.ru/",
                        "https://yandex.ru/finance/currencies"
                      ]
                    },
                    "enable_nrfm_docs": true,
                    "search_filters": []
                  },
                  "description": "Инструмент для получения информации об официальных курсах валют."
                }
              }
            ],
            "response_format": null
          }
          ```

          {% endcut %}

          В ответ сервис вернет идентификатор созданного AI-ассистента. Сохраните полученный идентификатор (значение поля `id`) — он понадобится при обращении к ассистенту.
  1. Создайте тред:

      1. Создайте файл `thread.json` с телом запроса на создание треда, указав идентификатор каталога:

          **thread.json**

          ```json
          {
            "folderId": "<идентификатор_каталога>"
          }
          ```
      1. Отправьте запрос на создание треда, указав путь к созданному файлу `thread.json` с телом запроса:

          ```bash
          curl \
            --request POST \
            --header "Authorization: Bearer ${IAM_TOKEN}" \
            --silent \
            --data "@<путь_к_телу_запроса>" \
            "https://rest-assistant.{{ api-host }}/assistants/v1/threads" | \
            jq
          ```

          {% cut "Результат" %}

          ```json
          {
            "id": "fvtfq63a134i********",
            "folder_id": "b1gt6g8ht345********",
            "name": "",
            "description": "",
            "default_message_author_id": "fvtsnf3tqbhg********",
            "created_by": "ajeol2afu1js********",
            "created_at": "2025-08-27T11:22:28.999319Z",
            "updated_by": "ajeol2afu1js********",
            "updated_at": "2025-08-27T11:22:28.999319Z",
            "expiration_config": {
              "expiration_policy": "SINCE_LAST_ACTIVE",
              "ttl_days": "7"
            },
            "expires_at": "2025-09-03T11:22:28.999319Z",
            "labels": {},
            "tools": []
          }
          ```

          {% endcut %}

          Сохраните полученный идентификатор треда (значение поля `id`) — он понадобится позднее.
  1. Создайте сообщение в треде:

      1. Создайте файл `message.json` с телом запроса на создание сообщения, указав полученный ранее идентификатор треда и текст запроса:

          **message.json**

          ```json
          {
            "threadId": "<идентификатор_треда>",
            "content": {
              "content": [
                {
                  "text": {
                    "content": "Какой официальный курс доллара установлен на сегодня?"
                  }
                }
              ]
            }
          }
          ```
      1. Отправьте запрос на создание сообщения, указав путь к созданному файлу `message.json` с телом запроса:

          ```bash
          curl \
            --request POST \
            --header "Authorization: Bearer ${IAM_TOKEN}" \
            --silent \
            --data "@<путь_к_телу_запроса>" \
            "https://rest-assistant.{{ api-host }}/assistants/v1/messages" | \
            jq
          ```

          Результат:

          ```json
          {
            "id": "fvt6bpm6mbp5********",
            "thread_id": "fvtfq63a134i********",
            "created_by": "ajeol2afu1js********",
            "created_at": "2025-08-27T11:24:46.312977Z",
            "author": {
              "id": "fvtsnf3tqbhg********",
              "role": "USER"
            },
            "labels": {},
            "content": {
              "content": [
                {
                  "text": {
                    "content": "Какой официальный курс доллара установлен на сегодня?"
                  }
                }
              ]
            },
            "status": "COMPLETED",
            "citations": []
          }
          ```
  1. Выполните запуск ассистента с созданным ранее сообщением:

      1. Создайте файл `run.json` с телом запроса на запуск ассистента, указав полученные ранее идентификаторы ассистента и треда:

          **run.json**

          ```json
          {
            "assistantId": "<идентификатор_ассистента>",
            "threadId": "<идентификатор_треда>"
          }
          ```
      1. Отправьте запрос на запуск ассистента, указав путь к созданному файлу `run.json` с телом запроса:

          ```bash
          curl \
            --request POST \
            --header "Authorization: Bearer ${IAM_TOKEN}" \
            --silent \
            --data "@<путь_к_телу_запроса>" \
            "https://rest-assistant.{{ api-host }}/assistants/v1/runs" | \
            jq
          ```

          Результат:

          ```json
          {
            "id": "fvtar74rehg7********",
            "assistant_id": "fvthd7m0d6up********",
            "thread_id": "fvtfq63a134i********",
            "created_by": "ajeol2afu1js********",
            "created_at": "2025-08-27T11:31:06.486275281Z",
            "labels": {},
            "state": {
              "status": "PENDING"
            },
            "usage": null,
            "custom_prompt_truncation_options": null,
            "custom_completion_options": null,
            "tools": [],
            "custom_response_format": null
          }
          ```

          Сервис вернул информацию о запуске: запуск находится в ожидании выполнения (статус `PENDING`). Сохраните идентификатор запуска (значение поля `id`) — он понадобится на следующем шаге.
  1. Получите результат запуска с ответом ассистента. Для этого выполните запрос, указав полученный ранее идентификатор запуска:

      ```bash
      curl \
        --request GET \
        --header "Authorization: Bearer ${IAM_TOKEN}" \
        --silent \
        "https://rest-assistant.{{ api-host }}/assistants/v1/runs/<идентификатор_запуска>" | \
        jq
      ```

      {% cut "Результат" %}

      ```json
      {
        "id": "fvtar74rehg7********",
        "assistant_id": "fvthd7m0d6up********",
        "thread_id": "fvtfq63a134i********",
        "created_by": "ajeol2afu1js********",
        "created_at": "2025-08-27T11:31:06.486275281Z",
        "labels": {},
        "state": {
          "status": "COMPLETED",
          "completed_message": {
            "id": "fvt24upe31hh********",
            "thread_id": "fvtfq63a134i********",
            "created_by": "ajeol2afu1js********",
            "created_at": "2025-08-27T11:31:08.781561740Z",
            "author": {
              "id": "fvthd7m0d6up********",
              "role": "ASSISTANT"
            },
            "labels": {},
            "content": {
              "content": [
                {
                  "text": {
                    "content": "Официальный курс доллара США к рублю Российской Федерации на сегодня составляет 80,5268 рубля за 1 доллар."
                  }
                }
              ]
            },
            "status": "COMPLETED",
            "citations": []
          }
        },
        "usage": {
          "prompt_tokens": "390",
          "completion_tokens": "44",
          "total_tokens": "434"
        },
        "custom_prompt_truncation_options": null,
        "custom_completion_options": null,
        "tools": [],
        "custom_response_format": null
      }
      ```

      {% endcut %}

      В поле `content` AI-ассистент вернул ответ модели, который был сгенерирован с использованием данных на сайтах, заданных в настройках ассистента.

{% endlist %}

#### См. также {#see-also}

* [{#T}](./create.md)
* [{#T}](./create-with-searchindex.md)
* [{#T}](./create-with-labels.md)
* [{#T}](../../tutorials/pdf-searchindex-ai-assistant.md)
* [{#T}](../../concepts/assistant/tools/index.md)
* Примеры работы с {{ ml-sdk-name }} на [GitHub](https://github.com/yandex-cloud/yandex-cloud-ml-sdk/tree/master/examples/sync/assistants)
