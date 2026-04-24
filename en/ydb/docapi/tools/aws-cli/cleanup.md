---
title: How to delete the resources you created in {{ ydb-full-name }}
description: Follow this guide to delete the resources you created.
---

# Deleting the resources you created

If you no longer need the `series` table, delete it:

{% list tabs group=instructions %}

* AWS CLI {#cli}

    Run this command, replacing `https://your-database-endpoint` with the [previously prepared Document API endpoint](index.md#before-you-begin) of your database:

    {% note warning %}

    To work with the AWS CLI on Windows, we recommend using the [WSL]({{ ms.docs }}/windows/wsl/).

    {% endnote %}

    ```bash
    endpoint="https://your-database-endpoint"
    aws dynamodb delete-table \
        --table-name series \
        --endpoint $endpoint
    ```

   Result:

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
