# Удаление созданных ресурсов

Если вам больше не нужна таблица `series`, удалите ее:

{% list tabs %}

* AWS CLI

    Выполните команду, заменив `https://your-database-endpoint` эндпоинтом вашей БД:

    ```bash
    endpoint="https://your-database-endpoint"
    aws dynamodb delete-table \
        --table-name series \
        --endpoint $endpoint
    ```

   Результат выполнения:

   ```bash
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
