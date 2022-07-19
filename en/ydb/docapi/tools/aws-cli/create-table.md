---
sourcePath: overlay/quickstart/document-api/aws-cli/create-table.md
---
# Creating a table

To create a table named `series` with `series_id` as the partition key and `title` as the sort key:

{% list tabs %}

* AWS CLI

   Run the command by replacing `https://your-database-endpoint` the [previously prepared Document API endpoint](index.md#before-you-begin) your DB:

   {% note warning %}

   To work with the AWS CLI from Windows, we recommend using the [WSL]({{ ms.docs }}/windows/wsl/).

   {% endnote %}

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
           "TableStatus": "ACTIVE",
           "CreationDateTime": "2020-12-27T13:21:10+00:00",
           "TableSizeBytes": 0,
           "ItemCount": 0
       }
   }
   ```

{% endlist %}
