# Using the HTTP interface to work with the DB via the Document API

Use the HTTP interface to work with the DB via the [Document API](../docapi/api-ref/index.md). Create a document table in the database, add data to it, and read it using `curl`.

## Before you start

1. {% include [cli-install](../../_includes/cli-install.md) %}

1. In the [management console]({{ link-console-main }}), go to the folder to create a database in.

1. Select **Yandex Database**.

1. [Create a serverless database](../quickstart/create-db.md) in {{ yandex-cloud }}.

1. In the properties of the created database, in the **Overview** tab, find and copy your database's `Document API endpoint` value.

1. Set the `ENDPOINT` environment variable to the previously copied value:

   ```bash
   export ENDPOINT=<Document API endpoint>
   ```

## Create a document table

To create a document table in the database:

1. Set the table configuration in the `create.json` file:

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

1. Create a document table in the database using the command:

   ```bash
   curl -H 'X-Amz-Target: DynamoDB_20120810.CreateTable' \
   -H "Authorization: Bearer $(yc iam create-token)" \
   -H "Content-Type: application.json" \
   -d @create.json $ENDPOINT
   ```

   For more information about the `CreateTable` method, see the [Document API reference](../docapi/api-ref/actions/createTable.md).

## Add data to the table

To add data to the document table:

1. Prepare data to save to the document table by creating a file named `put.json`:

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

1. Add the data to the table using the command:

   ```bash
   curl -H 'X-Amz-Target: DynamoDB_20120810.PutItem' \
   -H "Authorization: Bearer $(yc iam create-token)" \
   -H "Content-Type: application.json" \
   -d @put.json $ENDPOINT
   ```

   For more information about the `PutItem` method, see the [Document API reference](../docapi/api-ref/actions/putItem.md).

## Read the data from the table

To read the data from the document table:

1. Run the command:

   ```bash
   curl -H 'X-Amz-Target: DynamoDB_20120810.GetItem' \
   -H "Authorization: Bearer $(yc iam create-token)" \
   -H "Content-Type: application.json" \
   -d '{"TableName": "test/pets", "Key": {"species":{"S":"cat"}, "name":{"S":"Tom"}}}' \
   $ENDPOINT
   ```

   Result:

   ```
   {"Item":{"name":{"S":"Tom"},"species":{"S":"cat"},"color":{"S":"black"},"price":{"N":"10.5"}}}
   ```

   For more information about the `GetItem` method, see the [Document API reference](../docapi/api-ref/actions/getItem.md).

