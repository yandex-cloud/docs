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

  Установите утилиты [gRPCurl](https://github.com/fullstorydev/grpcurl) и [jq](https://stedolan.github.io/jq).

{% endlist %}

## Создайте ассистента {#create-assistant}

{% list tabs group=programming_language %}

- cURL {#curl}

  Этот пример показывает, как создать [ассистента](../../concepts/assistant/index.md), который для ответов использует информацию из интернета. В примере будет задействован базовый алгоритм работы с {{ assistant-api }} через интерфейс [gRPC API](../../assistants/api-ref/grpc/index.md) — создание ассистента и треда, а также последующее обращение к ассистенту с запросом.
  
  В качестве внешних источников информации будут использованы [официальный сайт](https://cbr.ru/) Центрального банка Российской Федерации и сервис [Курсы валют](https://yandex.ru/finance/currencies) Яндекса. Если вы хотите искать информацию по всему интернету, то оставьте пустым значение поля `options` инструмента WebSearch.

  1. Создайте AI-ассистента:

      1. Создайте файл `assistant.json` с телом запроса на создание ассистента:

          **assistant.json**

          ```json
          {
            "folder_id": "<идентификатор_каталога>",
            "model_uri": "gpt://<идентификатор_каталога>/yandexgpt-lite/latest",
            "instruction": "Ты — умный помощник финансовой компании. Отвечай вежливо. Для ответов на вопросы воспользуйся инструментом поиска. Не придумывай ответ.",
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
                    "enable_nrfm_docs": true
                  },
                  "description": "Инструмент для получения информации об официальных курсах валют."
                }
              }
            ]
          }
          ```

          Где:
          * `folder_id` — [идентификатор](../../../resource-manager/operations/folder/get-id.md) каталога, на который у вашего аккаунта есть [роли](../../../iam/concepts/access-control/roles.md) [`ai.assistants.editor`](../../security/index.md#ai-assistants-editor) и [`{{ roles-yagpt-user }}`](../../security/index.md#languageModels-user) или выше.
          * `model_uri` — [URI](../../concepts/yandexgpt/models.md#generation) используемой модели генерации текста.
          * `instruction` — базовая инструкция, в соответствии с которой AI-ассистент будет выполнять запросы пользователя.
          * `tools` — настройки [инструмента](../../concepts/assistant/tools/index.md), который будет использоваться создаваемым ассистентом:

              * `site` — массив сайтов, на которых ассистент будет иметь возможность искать информацию.
              * `enable_nrfm_docs` — параметр, который определяет, попадут ли в результаты поиска документы, недоступные при прямом переходе с главных страниц заданных сайтов.
              * `description` — описание создаваемого инструмента, который позволяет ассистенту понять, нужно ли при генерации ответа на конкретный запрос использовать данный инструмент.

              Подробнее о доступных настройках инструмента WebSearch для поиска в интернете см. в разделе [{#T}](../../concepts/assistant/tools/web-search.md).
      1. Отправьте запрос на создание AI-ассистента, указав путь к созданному файлу `assistant.json` с телом запроса:

          ```bash
          export IAM_TOKEN=<IAM-токен>
          grpcurl \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d @ < <путь_к_телу_запроса> \
            assistant.{{ api-host }}:443 yandex.cloud.ai.assistants.v1.AssistantService/Create |
            jq
          ```

          Где:
          * `<IAM-токен>` — IAM-токен, полученный [перед началом работы](#before-begin).
          * `<путь_к_телу_запроса>` — путь к созданному ранее файлу с телом запроса `assistant.json`.

          {% cut "Результат" %}

          ```json
          {
            "id": "fvt1m68ugu04********",
            "folder_id": "b1gt6g8ht345********",
            "created_by": "ajeol2afu1js********",
            "created_at": "2025-08-05T08:26:24.145150Z",
            "updated_by": "ajeol2afu1js********",
            "updated_at": "2025-08-05T08:26:24.145150Z",
            "expiration_config": {
              "expiration_policy": "SINCE_LAST_ACTIVE",
              "ttl_days": "7"
            },
            "expires_at": "2025-08-12T08:26:24.145150Z",
            "model_uri": "gpt://b1gt6g8ht345********/yandexgpt-lite/latest",
            "instruction": "Ты — умный помощник финансовой компании. Отвечай вежливо. Для ответов на вопросы воспользуйся инструментом поиска. Не придумывай ответ.",
            "prompt_truncation_options": {
              "auto_strategy": {}
            },
            "completion_options": {},
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
                    "enable_nrfm_docs": true
                  },
                  "description": "Инструмент для получения информации об официальных курсах валют."
                }
              }
            ]
          }
          ```

          {% endcut %}

          В ответ сервис вернет идентификатор созданного AI-ассистента. Сохраните полученный идентификатор (значение поля `id`) — он понадобится при обращении к ассистенту.
  1. Создайте тред:

      1. Создайте файл `thread.json` с телом запроса на создание треда, указав идентификатор каталога:

          **thread.json**

          ```json
          {
            "folder_id": "<идентификатор_каталога>"
          }
          ```
      1. Отправьте запрос на создание треда, указав путь к созданному файлу `thread.json` с телом запроса:

          ```bash
          grpcurl \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d @ < <путь_к_телу_запроса> \
            assistant.{{ api-host }}:443 yandex.cloud.ai.assistants.v1.threads.ThreadService/Create |
            jq
          ```

          {% cut "Результат" %}

          ```json
          {
            "id": "fvt8tf1c3beu********",
            "folder_id": "b1gt6g8ht345********",
            "default_message_author_id": "fvt1qo9usone********",
            "created_by": "ajeol2afu1js********",
            "created_at": "2025-08-13T10:50:52.289620Z",
            "updated_by": "ajeol2afu1js********",
            "updated_at": "2025-08-13T10:50:52.289620Z",
            "expiration_config": {
              "expiration_policy": "SINCE_LAST_ACTIVE",
              "ttl_days": "7"
            },
            "expires_at": "2025-08-20T10:50:52.289620Z"
          }
          ```

          {% endcut %}

          Сохраните полученный идентификатор треда (значение поля `id`) — он понадобится позднее.
  1. Создайте сообщение в треде:

      1. Создайте файл `message.json` с телом запроса на создание сообщения, указав полученный ранее идентификатор треда и текст запроса:

          **message.json**

          ```json
          {
            "thread_id": "<идентификатор_треда>",
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
          grpcurl \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d @ < <путь_к_телу_запроса> \
            assistant.{{ api-host }}:443 yandex.cloud.ai.assistants.v1.threads.MessageService/Create |
            jq
          ```

          Результат:

          ```json
          {
            "id": "fvtfgeqhe4ct********",
            "thread_id": "fvth2n5v4i7e********",
            "created_by": "ajeol2afu1js********",
            "created_at": "2025-08-05T09:18:48.515453Z",
            "author": {
              "id": "fvtivd1j5ica********",
              "role": "USER"
            },
            "content": {
              "content": [
                {
                  "text": {
                    "content": "Какой курс доллара установлен Банком России на сегодня?"
                  }
                }
              ]
            },
            "status": "COMPLETED"
          }
          ```
  1. Выполните запуск ассистента с созданным ранее сообщением:

      1. Создайте файл `run.json` с телом запроса на запуск ассистента, указав полученные ранее идентификаторы ассистента и треда:

          **run.json**

          ```json
          {
            "assistant_id": "<идентификатор_ассистента>",
            "thread_id": "<идентификатор_треда>"
          }
          ```
      1. Отправьте запрос на запуск ассистента, указав путь к созданному файлу `run.json` с телом запроса:

          ```bash
          grpcurl \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d @ < <путь_к_телу_запроса> \
            assistant.{{ api-host }}:443 yandex.cloud.ai.assistants.v1.runs.RunService/Create |
            jq
          ```

          Результат:

          ```json
          {
            "id": "fvtqms73nvkl********",
            "assistant_id": "fvt1m68ugu04********",
            "thread_id": "fvtv9ikd6lme********",
            "created_by": "ajeol2afu1js********",
            "created_at": "2025-08-05T09:23:55.096007666Z",
            "state": {
              "status": "PENDING"
            }
          }
          ```

          Сервис вернул информацию о запуске: запуск находится в ожидании выполнения (статус `PENDING`). Сохраните идентификатор запуска (значение поля `id`) — он понадобится на следующем шаге.
  1. Получите результат запуска с ответом ассистента:

      1. Создайте файл `get_result.json` с телом запроса на получение ответа от AI-ассистента, указав полученный ранее идентификатор запуска:

          **get_result.json**

          ```json
          {
            "run_id": "<идентификатор_запуска>"
          }
          ```

      1. Отправьте запрос на получение ответа, указав путь к созданному файлу `get_result.json` с телом запроса:

          ```bash
          grpcurl \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d @ < <путь_к_телу_запроса> \
            assistant.{{ api-host }}:443 yandex.cloud.ai.assistants.v1.runs.RunService/Get |
            jq
          ```

          {% cut "Результат" %}

          ```json
          {
            "id": "fvtr0r43s94a********",
            "assistant_id": "fvtshcldmbcm********",
            "thread_id": "fvth2n5v4i7e********",
            "created_by": "ajeol2afu1js********",
            "created_at": "2025-08-04T19:01:56.736924537Z",
            "state": {
              "status": "COMPLETED",
              "completed_message": {
                "id": "fvtlspo6k12e********",
                "thread_id": "fvth2n5v4i7e********",
                "created_by": "ajeol2afu1js********",
                "created_at": "2025-08-04T19:01:58.960131555Z",
                "author": {
                  "id": "fvtshcldmbcm********",
                  "role": "ASSISTANT"
                },
                "content": {
                  "content": [
                    {
                      "text": {
                        "content": "Официальный курс доллара США на сегодня составляет 79,6736 рубля за 1 доллар. Эту информацию можно подтвердить на сайте Центрального банка Российской Федерации (cbr.ru/currency_base/daily/)."
                      }
                    }
                  ]
                },
                "status": "COMPLETED"
              }
            },
            "usage": {
              "prompt_tokens": "376",
              "completion_tokens": "59",
              "total_tokens": "435"
            }
          }
          ```

          {% endcut %}

          В поле `content` AI-ассистент вернул ответ модели, который был сгенерирован с использованием данных на сайтах, заданных в настройках ассистента и треда.

{% endlist %}

#### См. также {#see-also}

* [{#T}](./create.md)
* [{#T}](./create-with-searchindex.md)
* [{#T}](./create-with-labels.md)
* [{#T}](../../tutorials/pdf-searchindex-ai-assistant.md)
* [{#T}](../../concepts/assistant/tools/index.md)
* Примеры работы с {{ ml-sdk-name }} на [GitHub](https://github.com/yandex-cloud/yandex-cloud-ml-sdk/tree/master/examples/sync/assistants)
