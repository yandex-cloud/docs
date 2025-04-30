---
title: Получение информации о диалоге в REST API
description: Следуя данной инструкции, вы получите информацию о диалоге в REST API.
---

# Получение информации о диалоге в REST API

## Перед началом работы {#before-you-begin}

Чтобы получить данные о диалоге через REST API {{ yandex-cloud }}: 

{% include [before-you-begin](../../../_includes/speechsense/data/rest-search-before-you-begin.md) %}

1. Получите идентификатор нужного диалога при помощи [полнотекстового поиска](rest-full-text-search.md) или [фильтрации по параметрам](rest-search-filters.md).

## Получение информации о диалоге {#get-dialog-data}

1. Создайте в папке файл `get.json` с [параметрами](#get-query-ref) для получения нужного диалога: 

    ```json
    {
      "organizationId": "<идентификатор_организации>",
      "spaceId": "<идентификатор_пространства>",
      "connectionId": "<идентификатор_подключения>",
      "projectId": "<идентификатор_проекта>",
      "talkIds": [
        "<идентификатор_диалога>"
      ],
      "resultsMask": {
        "paths": [
          "<ключи_запрашиваемых_полей>"
        ]
      }
    }
    ```

    Где:

    {% include [id-parameters](../../../_includes/speechsense/data/api-id-parameters.md) %}

    * `talkIds` — идентификаторы диалогов, информацию о которых вы хотите получить. Чтобы узнать идентификаторы диалогов, используйте [search-запрос](#search-query).
    * `resultsMask` — маска результатов. Если этот параметр не передан, вернется вся информация о диалоге, а если параметр передан с пустым списком `paths`, вернется только базовая информация о диалоге: идентификаторы проекта, подключения и пространства, когда и кем создан и изменен, а также метаданные, добавленные при загрузке диалога. Чтобы выгрузить отдельные поля с данными, передайте в маске ключи нужных полей в списке `paths`:

      * `transcription` — текстовая расшифровка аудиозаписи или текстовые сообщения из чата;
      * `speechStatistics` — статистика речи;
      * `silenceStatistics` — статистика пауз в диалоге;
      * `interruptsStatistics` — статистика прерываний собеседника;
      * `conversationStatistics` — статистика диалога;
      * `points` — резюме диалога;
      * `textClassifiers` — статистика по классификаторам (тегам).

    Подробнее о параметрах get-запроса см. в [справочнике API](../../api-ref/Talk/get.md).  

1. Выполните get-запрос к API {{ speechsense-name }} при помощи cURL: 

    ```bash
    curl -X POST https://rest-api.speechsense.yandexcloud.net/speechsense/v1/talks/get \
       -H "Content-Type: application/json" \
       -H "authorization: Api-Key ${API_KEY}" \
       -d @get.json
    ```

    Где `Api-Key` — API-ключ для аутентификации. Если вы используете IAM-токен, укажите `Bearer ${IAM_TOKEN}` вместо `Api-Key ${API_KEY}`.

    Результаты будут выведены в терминал в JSON-формате.

## Пример тела запроса на получение информации о диалоге {#get-chat-info-example}

Например, нужно получить резюме диалога с техподдержкой, в котором оператор предлагал оформить заявку на выезд мастера. Чтобы получить идентификатор такого диалога, используйте [приведенный пример запроса для полнотекстового поиска](rest-full-text-search.md#full-text-search-example).

JSON-файл с параметрами запроса будет выглядеть так:

```json
{
  "organizationId": "yc.organization****************",
  "spaceId": "f3fuclf1kufs********",
  "connectionId": "eag0u346n4hn********",
  "projectId": "eag9t3rm3o43********",
  "talkIds": ["aud95sn63lra********"],
  "resultsMask": {
    "paths": ["points"]
  }
}
```

{% cut "Результат выполнения запроса" %}

```json
{
  "talk": [
    {
      "id": "aud95sn63lra********",
      "organizationId": "yc.organization****************",
      "spaceId": "f3fuclf1kufs********",
      "connectionId": "eag0u346n4hn********",
      "projectIds": [
        "eag9t3rm3o43********"
      ],
      "createdBy": "ajeugoqa16o5********",
      "createdAt": "2024-09-24T08:53:09.932Z",
      "modifiedBy": "CLASSIFIER",
      "modifiedAt": "2024-09-24T18:06:08.299Z",
      "talkFields": [
        {
          "name": "operator_name",
          "value": "Оператор",
          "type": "FIELD_TYPE_STRING"
        },
        {
          "name": "operator_id",
          "value": "operator_id",
          "type": "FIELD_TYPE_STRING"
        },
        {
          "name": "client_name",
          "value": "Клиент",
          "type": "FIELD_TYPE_STRING"
        },
        {
          "name": "client_id",
          "value": "customer_id",
          "type": "FIELD_TYPE_STRING"
        },
        {
          "name": "bot_name",
          "value": "Бот",
          "type": "FIELD_TYPE_STRING"
        },
        {
          "name": "bot_id",
          "value": "bot_id",
          "type": "FIELD_TYPE_STRING"
        },
        {
          "name": "date",
          "value": "2024-09-24T11:11:11.111Z",
          "type": "FIELD_TYPE_DATE"
        },
        {
          "name": "direction_outgoing",
          "value": "true",
          "type": "FIELD_TYPE_BOOLEAN"
        },
        {
          "name": "language",
          "value": "Russian",
          "type": "FIELD_TYPE_STRING"
        }
      ],
      "transcription": null,
      "speechStatistics": null,
      "silenceStatistics": null,
      "interruptsStatistics": null,
      "conversationStatistics": null,
      "points": {
        "quiz": [
          {
            "request": "1. Оператор был вежливым?",
            "response": "1. Да",
            "id": "1"
          },
          {
            "request": "2. Оператор был раздражен?",
            "response": "2. Нет",
            "id": "2"
          },
          {
            "request": "3. Оператор был вовлечен в диалог?",
            "response": "3. Нет",
            "id": "3"
          },
          {
            "request": "4. Оператор был эмпатичным?",
            "response": "4. Да",
            "id": "4"
          },
          {
            "request": "5. Оператор хамил?",
            "response": "5. Нет",
            "id": "5"
          },
          {
            "request": "6. Оператор решил проблему клиента?",
            "response": "6. Нет",
            "id": "6"
          },
          {
            "request": "7. Оператор был уверенным?",
            "response": "7. Да",
            "id": "7"
          },
          {
            "request": "8. Клиент ушел раздраженным?",
            "response": "8. Нет",
            "id": "8"
          },
          {
            "request": "9. Клиент остался доволен?",
            "response": "9. Да",
            "id": "9"
          },
          {
            "request": "10. Клиент хамил?",
            "response": "10. Нет",
            "id": "10"
          }
        ]
      },
      "textClassifiers": null
    }
  ]
}
```

{% endcut %}
