---
sourcePath: overlay/quickstart/document-api/aws-cli/cleanup.md
---
# Удаление созданных ресурсов

Если вам больше не нужна таблица `series`, удалите ее:

{% list tabs %}

* AWS CLI

    Выполните команду, заменив `https://your-database-endpoint` [подготовленным ранее Document API эндпоинтом](index.md#before-you-begin) эндпоинтом вашей БД:

    {% note warning %}

    Для работы с AWS CLI из Windows рекомендуется использовать [WSL]({{ ms.docs }}/windows/wsl/).

    {% endnote %}

    ```bash
    endpoint="https://your-database-endpoint"
    aws dynamodb delete-table \
        --table-name series \
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
         "TableStatus": "DELETING",
         "CreationDateTime": "2020-12-27T13:21:10+00:00",
         "TableSizeBytes": 0,
         "ItemCount": 0
      }
   }
   ```

{% endlist %}
