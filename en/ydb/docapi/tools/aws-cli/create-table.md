---
title: "Creating a table in the AWS CLI"
description: "Follow this guide to create a table in the AWS CLI."
---

# Creating a table in the AWS CLI

{% list tabs group=instructions %}

- AWS CLI {#cli}

   {% note warning %}

   To work with the AWS CLI from Windows, we recommend using the [WSL]({{ ms.docs }}/windows/wsl/).

   {% endnote %}

   If you do not have the AWS CLI yet, [install and configure it](../../../../ydb/docapi/tools/aws-setup.md).

   To create a series table with a partitioning key by series number and sort key by series name:

   1. [Prepare](index.md#before-you-begin) the Document API endpoint and specify it:

      ```bash
      endpoint=<your_DB_endpoint>
      ```

   1. Run this command:

      ```bash
      aws dynamodb create-table \
        --table-name <table_name> \
        --attribute-definitions \
          AttributeName=<series_number>,AttributeType=N \
          AttributeName=<series_name>,AttributeType=S \
          AttributeName=<series_description>,AttributeType=S \
          AttributeName=<series_release_date>,AttributeType=S \
        --key-schema \
          AttributeName=<series_number>,KeyType=HASH \
          AttributeName=<series_name>,KeyType=RANGE \
        --endpoint $endpoint
      ```

      Where:

      * `--table-name`: [Table](../../../../ydb/concepts/dynamodb-tables.md) name.
      * `--attribute-definitions`: Description of element attributes. `AttributeName`: Attribute name. `AttributeType`: Attribute type:
         * `N`: `Number` type.
         * `S`: `String` type.
         * `B`: `Binary` type.
      * `--key-schema`: Key schema for the table. `AttributeName`: Name of the key attribute. `KeyType`: Key type:
         * `HASH`: Partitioning key.
         * `RANGE`: Sort key.

      The `key-schema` attributes should also be defined in the `attribute-definitions` array.

   ## Example {#example}

   To create a table named `series` with the `series_id` partition key and the `title` sort key:

   ```bash
   endpoint="your-database-endpoint"
   ```

   ```bash
   aws dynamodb create-table \
     --table-name series \
     --attribute-definitions \
       AttributeName=series_id,AttributeType=N \
       AttributeName=title,AttributeType=S \
       AttributeName=series_info,AttributeType=S \
       AttributeName=release_date,AttributeType=S \
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
               },
               {
                   "AttributeName": "series_info",
                   "AttributeType": "S"
               },
               {
                   "AttributeName": "release_date",
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
