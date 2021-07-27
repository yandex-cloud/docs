---

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответсвует заголовку","Другое"]}
---
# Создание таблицы

Чтобы создать таблицу `series` с ключом партицирования `series_id` и ключом сортировки `title`:

{% list tabs %}

* AWS CLI

    Выполните команду, заменив `https://your-database-endpoint` эндпоинтом вашей БД:

    ```bash
    endpoint="https://your-database-endpoint"
    aws dynamodb create-table \
        --table-name series \
        --attribute-definitions \
          AttributeName=series_id,AttributeType=N \
          AttributeName=title,AttributeType=S \
        --key-schema \
          AttributeName=series_id,KeyType=HASH \
          AttributeName=title,KeyType=RANGE \
        --endpoint $endpoint
    ```

    Результат выполнения:

    ```text
    {
        "TableDescription": {
            "AttributeDefinitions": [
                {
                    "AttributeName": "series_id",
                    "AttributeType": "N"
                },
                {
                    "AttributeName": "title",
                    "AttributeType": "S"
                }
            ],
            "TableName": "series",
            "KeySchema": [
                {
                    "AttributeName": "series_id",
                    "KeyType": "HASH"
                },
                {
                    "AttributeName": "title",
                    "KeyType": "RANGE"
                }
            ],
            "TableStatus": "ACTIVE",
            "CreationDateTime": "2020-12-27T13:21:10+00:00",
            "TableSizeBytes": 0,
            "ItemCount": 0
        }
    }
   ```

{% endlist %}
