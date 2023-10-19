---
title: "Creating a table in the AWS CLI"
description: "Follow this guide to create a table in the AWS CLI."
---

# Creating a table in the AWS CLI

{% list tabs %}

- AWS CLI

   {% note warning %}

   To work with the AWS CLI from Windows, we recommend using the [WSL]({{ ms.docs }}/windows/wsl/).

   {% endnote %}

   If you do not have the AWS CLI yet, [install and configure it](../../../../storage/tools/aws-cli.md).

   To create a table with a partitioning key and sort key:

   1. [Prepare](index.md#before-you-begin) the Document API endpoint and specify it:

      ```bash
      endpoint=<your_DB_endpoint>
      ```

   1. Run the following command:

      ```bash
      aws dynamodb create-table \
        --table-name <table_name> \
        --attribute-definitions \
          AttributeName=<partitioning_key>,AttributeType=N \
          AttributeName=<sort_key>,AttributeType=S \
        --key-schema \
          AttributeName=<partitioning_key>,KeyType=HASH \
          AttributeName=<sort_key>,KeyType=RANGE \
        --endpoint $endpoint
      ```

      Where:

      * `--table-name`: Table name.
      * `--attribute-definitions`: Attributes used to describe the key schema for the table and indexes. `AttributeName`: Attribute name, `AttributeType`: Attribute data type:
         * `N`: `Number` type. Used for partitioning keys.
         * `S`: `String` type. Used for sort keys.
         * `B`: `Binary` type.
      * `--key-schema`: Attributes used to create a primary key for the table or index. `AttributeName`: Name of the key attribute. `KeyType`: Role of the key attribute:
         * `HASH`: Partitioning key
         * `RANGE`: Sort key.

      The `key-schema` attributes should also be defined in the `attribute-definitions` array.

   ## Example {#example}

   Command to create a table named `series` with `series_id` as the partitioning key and `title` as the sort key:

   ```bash
   endpoint="https://your-database-endpoint"
   ```

   ```bash
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
