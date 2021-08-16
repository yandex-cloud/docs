# Using the HTTP interface to work with the DB via the Document API

## Before you start

1. Install the [{{ yandex-cloud }} CLI](../../cli/quickstart.md).
1. [Create a serverless database](../quickstart/create-db.md) in {{ yandex-cloud }}.
1. In the properties of the created database, on the Overview tab, find and copy the `Document API endpoint` value.
1. Save the `Document API endpoint` value to the `ENDPOINT` environment variable.

## Create a document table

1. Set the table configuration in the `create.json` file:

   ```shell script
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

1. Create a table using the command:

   ```shell script
   curl -H 'X-Amz-Target: DynamoDB_20120810.CreateTable' \
   -H "Authorization: Bearer $(yc iam create-token)" \
   -H "Content-Type: application.json" \
   -d @create.json $ENDPOINT
   ```

   For more information about the CreateTable method, see the [Document API reference](../docapi/api-ref/actions/createTable.md).

## Add data to the table

1. Prepare data to save to the table in the `put.json` file:

   ```shell script
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

   ```shell script
   curl -H 'X-Amz-Target: DynamoDB_20120810.PutItem' \
   -H "Authorization: Bearer $(yc iam create-token)" \
   -H "Content-Type: application.json" \
   -d @put.json $ENDPOINT
   ```

   For more information about the PutItem method, see the [Document API reference](../docapi/api-ref/actions/putItem.md).

## Read the data from the table

1. To read the data, run the command:

   ```shell script
   curl -H 'X-Amz-Target: DynamoDB_20120810.GetItem' \
   -H "Authorization: Bearer $(yc iam create-token)" \
   -H "Content-Type: application.json" \
   -d '{"TableName": "test/pets", "Key": {"species":{"S":"cat"}, "name":{"S":"Tom"}}}' \
   $ENDPOINT
   ```

   Result:

   ```shell script
   {"Item":{"name":{"S":"Tom"},"species":{"S":"cat"},"color":{"S":"black"},"price":{"N":"10.5"}}}
   ```

   For more information about the GetItem method, see the [Document API reference](../docapi/api-ref/actions/getItem.md).

