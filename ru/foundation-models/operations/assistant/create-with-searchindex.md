---
title: Создать ассистента с поисковым индексом
description: Следуя этой инструкции, с помощью {{ assistant-api }} вы сможете создать персонализированного ассистента, реализующего сценарий генеративного ответа с учетом информации из внешних источников (RAG).
---

# Создать ассистента с поисковым индексом

{% include [assistants-preview-stage](../../../_includes/foundation-models/assistants-preview-stage.md) %}

{{ assistant-api }} — это инструмент создания [AI-ассистентов](../../concepts/assistant/index.md). С его помощью можно создать персонализированных помощников, реализовывать сценарий генеративного ответа с учетом информации из внешних источников (RAG, Retrieval Augmented Generation), а также сохранять контекст запросов к модели.

## Перед началом работы {#before-begin}

Чтобы воспользоваться примерами:

{% list tabs group=programming_language %}

- SDK {#sdk}

  {% include [sdk-before-begin-assistants](../../../_includes/foundation-models/sdk-before-begin-assistants.md) %}

- cURL {#curl}

  {% include notitle [ai-before-beginning](../../../_includes/foundation-models/yandexgpt/ai-before-beginning.md) %}

  Чтобы воспользоваться примерами, установите утилиты [cURL](https://curl.haxx.se) и [jq](https://stedolan.github.io/jq).

{% endlist %}

## Создайте ассистента {#create-assistant}

{% list tabs group=programming_language %}

- SDK {#sdk}

  Этот пример показывает, как создать [ассистента](../../concepts/assistant/index.md), который для ответов использует информацию из файлов. В примере будет создан индекс для полнотекстового поиска и реализован простейший вариант чата.

  1. {% include [download-context-file-step](../../../_includes/foundation-models/assistants/download-context-file-step.md) %}
  1. Создайте файл `search-assistant.py` и добавьте в него следующий код:

      {% include [searchindex-assistant](../../../_includes/foundation-models/examples/searchindex-assistant.md) %}

      Где:

      * `mypath` — переменная, содержащая путь к директории, в которой сохранены скачанные ранее файлы. Например: `/Users/myuser/tours-example/`.

      {% include [sdk-code-legend](../../../_includes/foundation-models/examples/sdk-code-legend.md) %}

  1. Выполните созданный файл:

      ```bash
      python3 search-assistant.py
      ```

      В примере реализован простейший вариант чата: вводите с клавиатуры запросы ассистенту и получайте ответы на них. Чтобы прекратить диалог, введите `exit`.

      {% cut "Примерный результат выполнения" %}

      ```text
      Введите ваш вопрос ассистенту ("exit" - чтобы завершить диалог): Сколько стоит виза на Бали?
      Ответ:  300 рублей.
      * Содержимое фрагмента №1: ('* Бронь или билеты туда и обратно. * Анкета, заполненная на английском языке. Обратите внимание, что требования могут меняться, поэтому перед поездкой рекомендуется проверить актуальную информацию на сайте консульства или визового центра. Стоимость визы 300 рублей. Не упустите возможность посетить этот прекрасный остров и получить массу положительных эмоций! Бронируйте свой отдых на Бали уже сегодня! **Мы ждём вас!**',)
      * Идентификатор поискового индекса в фрагменте №1: fvtm4k885t5d********
      * Настройки типа поискового индекса в фрагменте №1: TextSearchIndexType(chunking_strategy=StaticIndexChunkingStrategy(max_chunk_size_tokens=700, chunk_overlap_tokens=300))
      * Идентификатор файла-источника для фрагмента №1: fvtki306biri********
      * MIME-тип файла-источника для фрагмента №1: text/plain

      * Содержимое фрагмента №2: ('**Что нужно для поездки?** Для въезда на территорию Индонезии вам потребуется виза. Вот список документов, которые необходимы для её оформления:\n* Загранпаспорт, срок действия которого составляет не менее 6 месяцев на момент въезда в страну. * Две фотографии, соответствующие требованиям консульства. * Подтверждение бронирования отеля или письмо другого жилья. * Бронь или билеты туда и обратно. * Анкета, заполненная на английском языке. Обратите внимание, что требования могут меняться, поэтому перед поездкой рекомендуется проверить актуальную информацию на сайте консульства или визового центра. Стоимость визы 300 рублей.',)
      * Идентификатор поискового индекса в фрагменте №2: fvtm4k885t5d********
      * Настройки типа поискового индекса в фрагменте №2: TextSearchIndexType(chunking_strategy=StaticIndexChunkingStrategy(max_chunk_size_tokens=700, chunk_overlap_tokens=300))
      * Идентификатор файла-источника для фрагмента №2: fvtki306biri********
      * MIME-тип файла-источника для фрагмента №2: text/plain

      * Содержимое фрагмента №3: ('**Бали — райский уголок, где вас ждут незабываемые впечатления!**\n\nПриглашаем вас провести незабываемый отпуск на Бали! Этот волшебный остров в Индонезии славится своими прекрасными пляжами, уникальной культурой и гостеприимными жителями. Здесь вы сможете насладиться красотой природы, попробовать местную кухню и познакомиться с новыми людьми. **Что нужно для поездки?** Для въезда на территорию Индонезии вам потребуется виза. Вот список документов, которые необходимы для её оформления:\n* Загранпаспорт, срок действия которого составляет не менее 6 месяцев на момент въезда в страну. * Две фотографии, соответствующие требованиям консульства.',)
      * Идентификатор поискового индекса в фрагменте №3: fvtm4k885t5d********
      * Настройки типа поискового индекса в фрагменте №3: TextSearchIndexType(chunking_strategy=StaticIndexChunkingStrategy(max_chunk_size_tokens=700, chunk_overlap_tokens=300))
      * Идентификатор файла-источника для фрагмента №3: fvtki306biri********
      * MIME-тип файла-источника для фрагмента №3: text/plain

      * Содержимое фрагмента №4: ('**Казахстан: путешествие в сердце Евразии**\n\nОткройте для себя Казахстан — удивительную страну, где встречаются Восток и Запад. Здесь вы сможете насладиться бескрайними степями, величественными горами, историческими памятниками и гостеприимством местных жителей. **Что нужно для поездки?** Чтобы попасть в Казахстан из России, вам потребуются следующие документы:\n* Загранпаспорт, срок действия которого составляет не менее 3 месяцев на момент окончания поездки. * Миграционная карта (выдаётся в самолете или на границе). * Медицинская страховка (не обязательна, но рекомендуется). Не упустите возможность посетить эту прекрасную страну и получить массу положительных эмоций!',)
      * Идентификатор поискового индекса в фрагменте №4: fvtm4k885t5d********
      * Настройки типа поискового индекса в фрагменте №4: TextSearchIndexType(chunking_strategy=StaticIndexChunkingStrategy(max_chunk_size_tokens=700, chunk_overlap_tokens=300))
      * Идентификатор файла-источника для фрагмента №4: fvtu162cbdfq********
      * MIME-тип файла-источника для фрагмента №4: text/plain

      Введите ваш вопрос ассистенту ("exit" - чтобы завершить диалог): exit
      ```

      {% endcut %}

      В свойстве `run.text` AI-ассистент вернул ответ модели, который был сгенерирован с использованием загруженной базы знаний. Свойство `run.citations` содержит [ссылки на источники](../../concepts/assistant/index.md#citations) — информацию об использованных в ответе файлах базы знаний и их фрагментах.

- cURL {#curl}

  Этот пример показывает, как создать [ассистента](../../concepts/assistant/index.md), который для ответов использует информацию из файлов. В примере будет показан базовый алгоритм работы с {{ assistant-api }} через интерфейс [REST API](../../assistants/api-ref/index.md) — создание индекса для гибридного поиска, создание ассистента и треда, а также последующее обращение к ассистенту с запросом.

  1. Загрузите файл с контекстом для базы знаний с помощью [Files API](../../files/api-ref/File/index.md):
      1. {% include [download-context-file-step](../../../_includes/foundation-models/assistants/download-context-file-step.md) %}

          В качестве базы знаний в этом примере вы будете использовать файл `bali.md`, содержащийся в скачанном архиве.
      1. Кодируйте файл `bali.md` в формат [Base64]({{ link-base64 }}):

          ```bash
          base64 -i bali.md -o bali-b64coded.txt
          ```
      1. Создайте файл `body.json` с телом запроса на загрузку файла:

          **body.json**

          ```json
          {
            "folderId": "<идентификатор_каталога>",
            "mimeType": "text/markdown",
            "content": "<содержимое_файла>"
          }
          ```

          Где:
          * `folderId` — [идентификатор](../../../resource-manager/operations/folder/get-id.md) каталога, на который у вашего аккаунта есть [роли](../../../iam/concepts/access-control/roles.md) [`ai.assistants.editor`](../../security/index.md#ai-assistants-editor) и [`{{ roles-yagpt-user }}`](../../security/index.md#languageModels-user) или выше.
          * `mimeType` — [MIME-тип](../../concepts/assistant/index.md#files) загружаемого контента. В приведенном примере файл `bali.md` имеет тип `text/markdown`.
          * `content` — содержимое полученного на предыдущем шаге файла `bali-b64coded.txt` в кодировке Base64.
      1. Отправьте запрос на создание файла:

          ```bash
          export IAM_TOKEN=<IAM-токен>
          curl \
            --request POST \
            --header "Authorization: Bearer ${IAM_TOKEN}" \
            --silent \
            --data "@<путь_к_телу_запроса>" \
            "https://rest-assistant.{{ api-host }}/files/v1/files" | \
            jq
          ```

          Где:
          * `<IAM-токен>` — IAM-токен, полученный [перед началом работы](#before-begin).
          * `<путь_к_телу_запроса>` — путь к созданному ранее файлу с телом запроса `body.json`.

          Результат:

          ```json
          {
            "id": "fvtrdof2njh********",
            "folder_id": "b1gt6g8ht345********",
            "name": "",
            "description": "",
            "mime_type": "text/markdown",
            "created_by": "ajeg2b2et02f********",
            "created_at": "2025-02-06T06:33:08.172814Z",
            "updated_by": "ajeg2b2et02f********",
            "updated_at": "2025-02-06T06:33:08.172814Z",
            "expiration_config": {
              "expiration_policy": "SINCE_LAST_ACTIVE",
              "ttl_days": "7"
            },
            "expires_at": "2025-02-13T06:33:08.172814Z",
            "labels": {}
          }
          ```

          В ответ сервис вернет идентификатор загруженного файла. Сохраните полученный идентификатор файла (значение поля `id`) — он понадобится на следующем шаге.
  1. Создайте [поисковый индекс](../../concepts/assistant/index.md#files):

      1. Создайте файл `index.json` с телом запроса на создание индекса, указав полученный ранее идентификатор файла:

          **index.json**

          ```json
          {
            "folderId": "<идентификатор_каталога>",
            "fileIds": [
              "<идентификатор_файла>"
            ],
            "hybridSearchIndex": {}
          }
          ```
      1. Отправьте запрос на создание поискового индекса, указав путь к созданному файлу `index.json` с телом запроса:

          ```bash
          curl \
            --request POST \
            --header "Authorization: Bearer ${IAM_TOKEN}" \
            --silent \
            --data "@<путь_к_телу_запроса>" \
            "https://rest-assistant.{{ api-host }}/assistants/v1/searchIndex" | \
            jq
          ```

          Результат:

          ```json
          {
            "id": "fvtkc1eg493r********",
            "description": "search index creation",
            "created_at": "2025-02-06T06:40:43.288447Z",
            "created_by": "ajeg2b2et02f********",
            "modified_at": "2025-02-06T06:40:43.288447Z",
            "done": false,
            "metadata": null
          }
          ```

          В ответе сервис вернет идентификатор объекта [Operation](../../../api-design-guide/concepts/operation.md). Сохраните этот идентификатор (значение поля `id`) — он понадобится на следующем шаге.
      1. Чтобы проверить готовность создания поискового индекса, запросите статус операции, указав сохраненный ранее идентификатор:

          ```bash
          curl \
            --request GET \
            --header "Authorization: Bearer ${IAM_TOKEN}" \
            --silent \
            "https://operation.{{ api-host }}/operations/<идентификатор_операции>" | \
            jq
          ```

          {% cut "Результат" %}

          ```json
          {
            "done": true,
            "response": {
              "@type": "type.googleapis.com/yandex.cloud.ai.assistants.v1.searchindex.SearchIndex",
              "expirationConfig": {
                "expirationPolicy": "SINCE_LAST_ACTIVE",
                "ttlDays": "7"
              },
              "hybridSearchIndex": {
                "textSearchIndex": {
                  "ngramTokenizer": {
                    "minGram": "3",
                    "maxGram": "4"
                  }
                },
                "vectorSearchIndex": {
                  "docEmbedderUri": "emb://yc.ml.rag-prod.common/text-search-doc/latest",
                  "queryEmbedderUri": "emb://yc.ml.rag-prod.common/text-search-query/latest"
                },
                "chunkingStrategy": {
                  "staticStrategy": {
                    "maxChunkSizeTokens": "800",
                    "chunkOverlapTokens": "400"
                  }
                },
                "combinationStrategy": {
                  "meanCombination": {
                    "weights": [
                      0.5,
                      0.5
                    ],
                    "meanEvaluationTechnique": "ARITHMETIC"
                  }
                },
                "normalizationStrategy": "MIN_MAX"
              },
              "id": "fvtjouke8mf8********",
              "folderId": "b1gt6g8ht345********",
              "createdBy": "ajeg2b2et02f********",
              "createdAt": "2025-02-06T10:58:02.705408Z",
              "updatedBy": "ajeg2b2et02f********",
              "updatedAt": "2025-02-06T10:58:02.705408Z",
              "expiresAt": "2025-02-13T10:58:02.705408Z"
            },
            "id": "fvtauj5naahe********",
            "description": "search index creation",
            "createdAt": "2025-02-06T10:58:02.745290Z",
            "createdBy": "ajeg2b2et02f********",
            "modifiedAt": "2025-02-06T10:58:14.870249Z"
          }
          ```

          {% endcut %}

          Значение `true` поля `done` говорит о том, что операция создания индекса завершена. Сохраните полученный идентификатор поискового индекса (значение поля `response.id`) — он понадобится при создании ассистента и [треда](../../concepts/assistant/index.md#content).
  1. Создайте AI-ассистента:

      1. Создайте файл `assistant.json` с телом запроса на создание ассистента:

          **assistant.json**

          ```json
          {
            "folderId": "<идентификатор_каталога>",
            "modelUri": "gpt://<идентификатор_каталога>/yandexgpt-lite/latest",
            "tools": [
              {
                "searchIndex": {
                  "searchIndexIds": [
                    "<идентификатор_индекса>"
                  ]
                }
              }
            ]
          }
          ```

          Где:
          * `modelUri` — [URI](../../concepts/yandexgpt/models.md#generation) используемой модели генерации текста.
          * `searchIndexIds` — полученный на предыдущем шаге идентификатор поискового индекса.
      1. Отправьте запрос на создание AI-ассистента, указав путь к созданному файлу `assistant.json` с телом запроса:

          ```bash
          curl \
            --request POST \
            --header "Authorization: Bearer ${IAM_TOKEN}" \
            --silent \
            --data "@<путь_к_телу_запроса>" \
            "https://rest-assistant.{{ api-host }}/assistants/v1/assistants" | \
            jq
          ```

          {% cut "Результат" %}

          ```json
          {
            "id": "fvtuc79tgfsj********",
            "folder_id": "b1gt6g8ht345********",
            "name": "",
            "description": "",
            "created_by": "ajeg2b2et02f********",
            "created_at": "2025-02-06T06:54:24.617824Z",
            "updated_by": "ajeg2b2et02f********",
            "updated_at": "2025-02-06T06:54:24.617824Z",
            "expiration_config": {
              "expiration_policy": "SINCE_LAST_ACTIVE",
              "ttl_days": "7"
            },
            "expires_at": "2025-02-13T06:54:24.617824Z",
            "labels": {},
            "model_uri": "gpt://b1gt6g8ht345********/yandexgpt-lite/latest",
            "instruction": "",
            "prompt_truncation_options": {
              "max_prompt_tokens": null
            },
            "completion_options": {
              "max_tokens": null,
              "temperature": null
            },
            "tools": [
              {
                "search_index": {
                  "search_index_ids": [
                    "fvtdso8kepkn********"
                  ],
                  "max_num_results": null
                }
              }
            ]
          }
          ```

          {% endcut %}

          В ответ сервис вернет идентификатор созданного AI-ассистента. Сохраните полученный идентификатор (значение поля `id`), он понадобится при обращении к ассистенту.
  1. Создайте тред:

      1. Создайте файл `thread.json` с телом запроса на создание треда, указав полученный ранее идентификатор поискового индекса:

          **thread.json**

          ```json
          {
            "folderId": "<идентификатор_каталога>",
            "tools": [
              {
                "searchIndex": {
                  "searchIndexIds": [
                    "<идентификатор_индекса>"
                  ]
                }
              }
            ]
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

          Результат:

          ```json
          {
            "id": "fvt48f07voik********",
            "folder_id": "b1gt6g8ht345********",
            "name": "",
            "description": "",
            "default_message_author_id": "fvtt5afqqige********",
            "created_by": "ajeg2b2et02f********",
            "created_at": "2025-02-06T07:11:36.729404Z",
            "updated_by": "ajeg2b2et02f********",
            "updated_at": "2025-02-06T07:11:36.729404Z",
            "expiration_config": {
              "expiration_policy": "SINCE_LAST_ACTIVE",
              "ttl_days": "7"
            },
            "expires_at": "2025-02-13T07:11:36.729404Z",
            "labels": {}
          }
          ```

          Сохраните полученный идентификатор треда (значение поля `id`) — он понадобится позднее.
  1. Создайте сообщение в треде:

      1. Создайте файл `message.json` с телом запроса на создание сообщения, указав полученный ранее идентификатор треда и текст запроса в контексте загруженного файла с базой знаний:

          **message.json**

          ```json
          {
            "threadId": "<идентификатор_треда>",
            "content": {
              "content": [
                {
                  "text": {
                    "content": "Сколько стоит виза на Бали?"
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
            "id": "fvt94qdq0a0h********",
            "thread_id": "fvt48f07voik********",
            "created_by": "ajeg2b2et02f********",
            "created_at": "2025-02-06T07:22:05.868535Z",
            "author": {
              "id": "fvtt5afqqige********",
              "role": "USER"
            },
            "labels": {},
            "content": {
              "content": [
                {
                  "text": {
                    "content": "Сколько стоит виза на Бали?"
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
            "id": "fvtvn4ier4kf********",
            "assistant_id": "fvtuc79tgfsj********",
            "thread_id": "fvt48f07voik********",
            "created_by": "ajeg2b2et02f********",
            "created_at": "2025-02-06T07:29:53.666326755Z",
            "labels": {},
            "state": {
              "status": "PENDING"
            },
            "usage": null,
            "custom_prompt_truncation_options": null,
            "custom_completion_options": null,
            "tools": []
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
            "id": "fvtvn4ier4kf********",
            "assistant_id": "fvtuc79tgfsj********",
            "thread_id": "fvt48f07voik********",
            "created_by": "ajeg2b2et02f********",
            "created_at": "2025-02-06T07:29:53.666326755Z",
            "labels": {},
            "state": {
              "status": "COMPLETED",
              "completed_message": {
                "id": "fvtae9fshgj7********",
                "thread_id": "fvt48f07voik********",
                "created_by": "ajeg2b2et02f********",
                "created_at": "2025-02-06T07:29:54.251043040Z",
                "author": {
                  "id": "fvtuc79tgfsj********",
                  "role": "ASSISTANT"
                },
                "labels": {},
                "content": {
                  "content": [
                    {
                      "text": {
                        "content": "Стоимость визы на Бали составляет 300 рублей."
                      }
                    }
                  ]
                },
                "status": "COMPLETED",
                "citations": [
                  {
                    "sources": [
                      {
                        "chunk": {
                          "search_index": {
                            "id": "fvtudtudvqpf********",
                            "folder_id": "b1gt6g8ht345********",
                            "name": "",
                            "description": "",
                            "created_by": "ajeol2afu1js********",
                            "created_at": "2025-03-15T20:47:48.256866Z",
                            "updated_by": "ajeol2afu1js********",
                            "updated_at": "2025-03-15T20:47:50.064687Z",
                            "expiration_config": {
                              "expiration_policy": "SINCE_LAST_ACTIVE",
                              "ttl_days": "7"
                            },
                            "expires_at": "2025-03-22T20:47:48.256866Z",
                            "labels": {},
                            "hybrid_search_index": {
                              "text_search_index": {
                                "chunking_strategy": null
                              },
                              "vector_search_index": {
                                "doc_embedder_uri": "emb://yc.ml.rag-prod.common/text-search-doc/latest",
                                "query_embedder_uri": "emb://yc.ml.rag-prod.common/text-search-query/latest",
                                "chunking_strategy": null
                              },
                              "chunking_strategy": {
                                "static_strategy": {
                                  "max_chunk_size_tokens": "800",
                                  "chunk_overlap_tokens": "400"
                                }
                              },
                              "normalization_strategy": "MIN_MAX",
                              "combination_strategy": {
                                "mean_combination": {
                                  "mean_evaluation_technique": "ARITHMETIC",
                                  "weights": [
                                    0.5,
                                    0.5
                                  ]
                                }
                              }
                            }
                          },
                          "source_file": {
                            "id": "fvtfu1n4p2bj********",
                            "folder_id": "b1gt6g8ht345********",
                            "name": "",
                            "description": "",
                            "mime_type": "text/markdown",
                            "created_by": "ajeol2afu1js********",
                            "created_at": "2025-03-15T20:45:51.079978Z",
                            "updated_by": "ajeol2afu1js********",
                            "updated_at": "2025-03-15T20:45:51.079978Z",
                            "expiration_config": {
                              "expiration_policy": "SINCE_LAST_ACTIVE",
                              "ttl_days": "7"
                            },
                            "expires_at": "2025-03-22T20:47:48.268776Z",
                            "labels": {}
                          },
                          "content": {
                            "content": [
                              {
                                "text": {
                                  "content": "**Бали — райский уголок, где вас ждут незабываемые впечатления!**\n\nПриглашаем вас провести незабываемый отпуск на Бали! Этот волшебный остров в Индонезии славится своими прекрасными пляжами, уникальной культурой и гостеприимными жителями. Здесь вы сможете насладиться красотой природы, попробовать местную кухню и познакомиться с новыми людьми. **Что нужно для поездки?** Для въезда на территорию Индонезии вам потребуется виза. Вот список документов, которые необходимы для её оформления:\n* Загранпаспорт, срок действия которого составляет не менее 6 месяцев на момент въезда в страну. * Две фотографии, соответствующие требованиям консульства. * Подтверждение бронирования отеля или письмо другого жилья. * Бронь или билеты туда и обратно. * Анкета, заполненная на английском языке. Обратите внимание, что требования могут меняться, поэтому перед поездкой рекомендуется проверить актуальную информацию на сайте консульства или визового центра. Стоимость визы 300 рублей. Не упустите возможность посетить этот прекрасный остров и получить массу положительных эмоций! Бронируйте свой отдых на Бали уже сегодня! **Мы ждём вас!**"
                                }
                              }
                            ]
                          }
                        }
                      }
                    ]
                  }
                ]
              }
            },
            "usage": {
              "prompt_tokens": "236",
              "completion_tokens": "11",
              "total_tokens": "247"
            },
            "custom_prompt_truncation_options": null,
            "custom_completion_options": null,
            "tools": []
          }
          ```

          {% endcut %}

          В поле `content` AI-ассистент вернул ответ модели, который был сгенерирован с использованием загруженной базы знаний. Секция `citations` содержит [ссылки на источники](../../concepts/assistant/index.md#citations) — информацию об использованных в ответе файлах базы знаний и их фрагментах.

{% endlist %}

#### См. также {#see-also}

* [{#T}](./create.md)
* [{#T}](../../tutorials/pdf-searchindex-ai-assistant.md)
* Примеры работы с {{ ml-sdk-name }} на [GitHub](https://github.com/yandex-cloud/yandex-cloud-ml-sdk/tree/master/examples/sync/assistants)
