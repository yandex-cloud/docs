# Developing in NodeJS through the Document API

Use a VM in {{ yandex-cloud }} and perform operations on document tables via the [Document API](../docapi/api-ref/index.md), an Amazon DynamoDB-compatible HTTP API.

## Before you start

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

### Creating a table

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

## Adding an entry

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

## Reading entries

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

