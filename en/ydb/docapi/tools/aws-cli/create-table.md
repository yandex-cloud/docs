---
title: Creating a table in the AWS CLI
description: Follow this guide to create a table in the AWS CLI.
---

# Creating a table in the AWS CLI

{% list tabs group=instructions %}

- AWS CLI {#cli}

    {% note warning %}

    To work with the AWS CLI on Windows, we recommend using the [WSL]({{ ms.docs }}/windows/wsl/).

    {% endnote %}

    If you do not have the AWS CLI yet, [install and configure it](../../../../ydb/docapi/tools/aws-setup.md).
    
    To create a series table with a series number partition key and a series title sort key:
    
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
           AttributeName=<series_title>,AttributeType=S \
           AttributeName=<series_description>,AttributeType=S \
           AttributeName=<series_release_date>,AttributeType=S \
         --key-schema \
           AttributeName=<series_number>,KeyType=HASH \
           AttributeName=<series_title>,KeyType=RANGE \
         --endpoint $endpoint
       ```

       Where:
       
       * `--table-name`: [Table](../../../../ydb/concepts/dynamodb-tables.md) name.
       * `--attribute-definitions`: Description of item attributes, consisting of `AttributeName` and `AttributeType`, which can be: 
         * `N`: `Number`
         * `S`: `String`
         * `B`: `Binary`
       * `--key-schema`: Key schema for the table, where `AttributeName` is the key attribute name, and `KeyType` can be:
         * `HASH`: Partition key.
         * `RANGE`: Sort key.
       
       The `key-schema` attributes should also be defined in the `attribute-definitions` array.

    ## Example {#example}
  
    To create a table named `series` with the `series_id` partition key and `title` sort key:
    
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
