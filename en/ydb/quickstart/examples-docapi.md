# Operations with data

In this section, you'll learn how to work with the Document API, which is compatible with AWS DynamoDB. You'll create a table, save data to it, and then read it.

## Before you start {#before-you-begin}

To work with the DB via the [Document API](../docapi/api-ref/index.md):

{% list tabs %}

- HTTP interface

     To create a document table in the database, add data to it, and read it using `curl`:

    1. {% if deploy != "arc" %} If you don't have the {{ yandex-cloud }} CLI, [install and initialize it](../../cli/quickstart.md#install) {% else %} Install the YC CLI{% endif %}.

    1. In the [management console]({{ link-console-main }}), go to the folder to create a database in.

    1. Select **Yandex Database**.

    1. [Create a serverless database](../quickstart/create-db.md) in {{ yandex-cloud }}.

    1. In the properties of the created database, in the **Overview** tab, find and copy your database's `Document API endpoint` value.

    1. Set the `ENDPOINT` environment variable to the previously copied value:

       ```bash
       export ENDPOINT=<Document API endpoint>
       ```

- Node.js

    Use a VM in {{ yandex-cloud }} and perform operations on document tables via the [Document API](../docapi/api-ref/index.md), an Amazon DynamoDB-compatible HTTP API.

    1. For database authentication, {% if deploy != "arc" %} [create a service account](../../iam/operations/sa/create) {% else %} create a service account {% endif %} and {% if deploy != "arc" %} [assign](../../iam/operations/sa/assign-role-for-sa.md) {% else %} assign {% endif %} it the `viewer` and `editor` roles.

    1. {% if deploy != "arc" %} [Create a VM](../../compute/operations/vm-create/create-linux-vm) {% else %} Create a VM {% endif %} in {{ yandex-cloud }}. When creating it, select the previously created service account in the Access section.

    1. Save the public IP address of the VM. To do this, go to the VM properties or {% if deploy != "arc" %} [use the command-line interface](../../compute/operations/vm-info/get-info#outside-instance) {% else %} use the command-line interface {% endif %}.

    1. {% if deploy != "arc" %} [Connect to the VM via SSH](../../compute/operations/vm-connect/ssh.md){% else %} Connect to the VM via SSH {% endif %}.

    1. Prepare the VM for operation:

       {% list tabs %}

       - Ubuntu

          1. Update the system packages with the command:

             ```bash
             sudo apt-get update
             ```

          1. Install Node.js and npm:

             ```bash
             sudo apt-install nodejs npm
             ```

          1. To install developer tools, run the command:

             ```bash
             npm install yandex-cloud
             ```

       {% endlist %}

{% endlist %}

## Creating a table {#create}

{% list tabs %}

- HTTP interface

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

- Node.js

    To create a document table in the database:

    1. Set the table configuration in the `create.js` file by replacing the `Document API endpoint` with the previously saved value:

       ```javascript
       const { DocAPIService } = require('yandex-cloud/lib/slydb/docapi/docapi')
       
       // Specify the Document API endpoint of your database
       const endpoint = '<Document API endpoint>';
       const docapi = new DocAPIService(endpoint)
       
       var params =
       {
         TableName: "test/pets",
         AttributeDefinitions:
         [
           {
             AttributeName: "species",
             AttributeType: "S"
           },
           {
             AttributeName: "name",
             AttributeType: "S"
           }
         ],
         KeySchema:
         [
           {
             AttributeName: "species",
             KeyType: "HASH"
           },
           {
             AttributeName: "name",
             KeyType: "RANGE"
           }
         ]
       };
       docapi.createTable(params).then(res => { console.log(res); }).catch(err => { console.log(err); });
       ```

    1. Run the file using Node.js:

       ```bash
       node create.js
       ```

       Result:

       ```
       { TableDescription:
         { AttributeDefinitions: [ [Object], [Object] ],
           TableName: 'test/pets',
           KeySchema: [ [Object], [Object] ],
           TableStatus: 'ACTIVE',
           CreationDateTime: 2020-11-03T22:39:51.000Z,
           TableSizeBytes: 0,
           ItemCount: 0 } }
       ```

{% endlist %}

## Adding an entry {#add}

{% list tabs %}

- HTTP interface

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

- Node.js

    To add an entry to the document table:

    1. Prepare data to save to the table by creating a file named `add.js` on the VM. Replace the `Document API endpoint` with the previously saved value:

       ```javascript
       const { DocAPIService } = require('yandex-cloud/lib/slydb/docapi/docapi')
       
       // Specify the Document API endpoint of your database
       const endpoint = '<Document API endpoint>';
       const docapi = new DocAPIService(endpoint)
       
       var params =
       {
         TableName: "test/pets",
         Item:
         {
           "species": "cat",
           "name": "Tom",
           "color": "Black",
           "price": "10.5"
         }
       };
       docapi.putItem(params).then(res => { console.log(res); }).catch(err => {   console.log(err); });
       ```

    1. Run the command:

       ```bash
       node add.js
       ```

{% endlist %}

## Reading entries {#read}

{% list tabs %}

- HTTP interface

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

- Node.js

    To read the data written to the document table:

    1. Create a file named `read.js` on the VM by replacing the `Document API endpoint` with the previously saved value:

       ```javascript
       const { DocAPIService } = require('yandex-cloud/lib/slydb/docapi/docapi')
       
       // Specify the Document API endpoint of your database
       const endpoint = '<Document API endpoint>';
       const docapi = new DocAPIService(endpoint)
       
       var params =
       {
         TableName: "test/pets",
         Key:
         {
           "species": "cat",
           "name": "Tom"
         }
       };
       docapi.getItem(params).then(res => { console.log(res); }).catch(err => console.  log(err));
       ```

    1. Run the command:

       ```bash
       node read.js
       ```

       Result:

       ```
       { Item:
       { name: 'Tom', species: 'cat', color: 'Black', price: '10.5' } }
       ```

{% endlist %}

