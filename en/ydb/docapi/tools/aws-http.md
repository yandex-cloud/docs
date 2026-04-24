---
sourcePath: overlay/quickstart/document-api/aws-http.md
---
# Data operations through the HTTP interface

In this section, you will learn how to create a table, populate it with data, and then read this data using the Document API HTTP interface.

In our examples below, we will be using [cURL](https://curl.se/) to run HTTP requests.

{% include [doc-tables-only.md](../../_includes/doc-tables-only.md) %}

## Getting started {#before-you-begin}

1. If you do not have the {{ yandex-cloud }} CLI yet, [install and initialize it](../../../cli/quickstart.md#install).
1. Prepare the Document API endpoint of [your database](../../operations/manage-databases.md).

    {% cut "Where to find the Document API endpoint of a database" %}

    1. Navigate to the [management console]({{ link-console-main }}).
    1. Select the folder and go to **{{ ui-key.yacloud.iam.folder.dashboard.label_ydb }}**.
    1. Select the database you want to query.
    1. In the menu on the left, go to the **{{ ui-key.yacloud.common.overview }}** section.
    1. The **{{ ui-key.yacloud.ydb.overview.label_document-endpoint }}** line shows the endpoint value.

        Here is an example of an endpoint value: `{{ ydb.aws-ep }}`.

    {% endcut %}

    {% note info %}

    For the Amazon DynamoDB compatibility mode, use a serverless database configuration.

    {% endnote %}

1. Set the `ENDPOINT` environment variable to the prepared value:

    ```bash
    export ENDPOINT=<Document_API_endpoint>
    ```

## Creating a table {#create-table}

{% list tabs %}

- HTTP interface

  Specify the table configuration in the `create.json` file:

    ```json
    {
      "TableName": "test/pets",
      "AttributeDefinitions":
      [
        {
          "AttributeName": "species",
          "AttributeType": "S"
        },
        {
          "AttributeName": "name",
          "AttributeType": "S"
        }
      ],
      "KeySchema":
      [
        {
          "AttributeName": "species",
          "KeyType": "HASH"
        },
        {
          "AttributeName": "name",
          "KeyType": "RANGE"
        }
      ]
    }
    ```

  Create a document table in the database using this command:

    ```bash
    curl \
      --header 'X-Amz-Target: DynamoDB_20120810.CreateTable' \
      --header "Authorization: Bearer $(yc iam create-token)" \
      --header "Content-Type: application.json" \
      --data @create.json $ENDPOINT
    ```

    For more information about the `CreateTable` method, see the [Document API reference](../../docapi/api-ref/actions/createTable.md).

{% endlist %}

## Adding data {#add}

{% list tabs %}

- HTTP interface

  Prepare the data to save to the document table by creating a file named `put.json`:

    ```json
    {
      "TableName": "test/pets",
      "Item":
      {
        "species": {"S": "cat"},
        "name":    {"S": "Tom"},
        "color":   {"S": "black"},
        "price":   {"N": "10.5"}
      }
    }
    ```

  Add the data to the table using this command:

    ```bash
    curl \
      --header 'X-Amz-Target: DynamoDB_20120810.PutItem' \
      --header "Authorization: Bearer $(yc iam create-token)" \
      --header "Content-Type: application.json" \
      --data @put.json $ENDPOINT
    ```

    For more information about the `PutItem` method, see the [Document API reference](../../docapi/api-ref/actions/putItem.md).

{% endlist %}

## Reading a record {#read}

{% list tabs %}

- HTTP interface

  To read data from a document table, run this command:

    ```bash
    curl \
      --header 'X-Amz-Target: DynamoDB_20120810.GetItem' \
      --header "Authorization: Bearer $(yc iam create-token)" \
      --header "Content-Type: application.json" \
      --data '{"TableName": "test/pets", "Key": {"species":{"S":"cat"}, "name":{"S":"Tom"}}}' \
      $ENDPOINT
    ```

    Result:

    ```text
    {"Item":{"name":{"S":"Tom"},"species":{"S":"cat"},"color":{"S":"black"},"price":{"N":"10.5"}}}
    ```

    For more information about the `GetItem` method, see the [Document API reference](../../docapi/api-ref/actions/getItem.md).

{% endlist %}
