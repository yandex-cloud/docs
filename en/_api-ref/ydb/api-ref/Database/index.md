---
editable: false
---

# Database
A set of methods for managing databases.
## JSON Representation {#representation}
```json 
{
  "id": "string",
  "folderId": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "status": "string",
  "endpoint": "string",
  "resourcePresetId": "string",
  "storageConfig": {
    "storageOptions": [
      {
        "storageTypeId": "string",
        "groupCount": "string"
      }
    ]
  },
  "scalePolicy": {
    "fixedScale": {
      "size": "string"
    }
  },
  "networkId": "string",
  "subnetIds": [
    "string"
  ],
  "assignPublicIps": true,
  "locationId": "string",
  "labels": "object",

  //  includes only one of the fields `zonalDatabase`, `regionalDatabase`, `provisionedDatabase`, `serverlessDatabase`
  "zonalDatabase": {
    "zoneId": "string"
  },
  "regionalDatabase": {
    "regionId": "string"
  },
  "provisionedDatabase": {
    "resourcePresetId": "string",
    "storageConfig": {
      "storageOptions": [
        {
          "storageTypeId": "string",
          "groupCount": "string"
        }
      ]
    },
    "scalePolicy": {
      "fixedScale": {
        "size": "string"
      }
    },
    "networkId": "string",
    "subnetIds": [
      "string"
    ],
    "assignPublicIps": true
  },
  "serverlessDatabase": {},
  // end of the list of possible fields

}
```
 
Field | Description
--- | ---
id | **string**<br>
folderId | **string**<br>
createdAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
name | **string**<br>
description | **string**<br>
status | **string**<br>
endpoint | **string**<br>
resourcePresetId | **string**<br>
storageConfig | **object**<br>
storageConfig.<br>storageOptions[] | **object**<br><p>Required. The minimum number of elements is 1.</p> 
storageConfig.<br>storageOptions[].<br>storageTypeId | **string**<br>
storageConfig.<br>storageOptions[].<br>groupCount | **string** (int64)<br>
scalePolicy | **object**<br>
scalePolicy.<br>fixedScale | **object**<br>
scalePolicy.<br>fixedScale.<br>size | **string** (int64)<br><p>The minimum value is 1.</p> 
networkId | **string**<br>
subnetIds[] | **string**<br>
assignPublicIps | **boolean** (boolean)<br>
locationId | **string**<br>
labels | **object**<br>
zonalDatabase | **object** <br> includes only one of the fields `zonalDatabase`, `regionalDatabase`, `provisionedDatabase`, `serverlessDatabase`<br><br>
zonalDatabase.<br>zoneId | **string**<br><p>Required.</p> 
regionalDatabase | **object** <br> includes only one of the fields `zonalDatabase`, `regionalDatabase`, `provisionedDatabase`, `serverlessDatabase`<br><br>
regionalDatabase.<br>regionId | **string**<br><p>Required.</p> 
provisionedDatabase | **object** <br> includes only one of the fields `zonalDatabase`, `regionalDatabase`, `provisionedDatabase`, `serverlessDatabase`<br><br>
provisionedDatabase.<br>resourcePresetId | **string**<br>
provisionedDatabase.<br>storageConfig | **object**<br>
provisionedDatabase.<br>storageConfig.<br>storageOptions[] | **object**<br><p>Required. The minimum number of elements is 1.</p> 
provisionedDatabase.<br>storageConfig.<br>storageOptions[].<br>storageTypeId | **string**<br>
provisionedDatabase.<br>storageConfig.<br>storageOptions[].<br>groupCount | **string** (int64)<br>
provisionedDatabase.<br>scalePolicy | **object**<br>
provisionedDatabase.<br>scalePolicy.<br>fixedScale | **object**<br>
provisionedDatabase.<br>scalePolicy.<br>fixedScale.<br>size | **string** (int64)<br><p>The minimum value is 1.</p> 
provisionedDatabase.<br>networkId | **string**<br>
provisionedDatabase.<br>subnetIds[] | **string**<br>
provisionedDatabase.<br>assignPublicIps | **boolean** (boolean)<br>
serverlessDatabase | **object** <br> includes only one of the fields `zonalDatabase`, `regionalDatabase`, `provisionedDatabase`, `serverlessDatabase`<br><br>

## Methods {#methods}
Method | Description
--- | ---
[create](create.md) | Creates a new database.
[delete](delete.md) | Deletes the specified database.
[get](get.md) | Returns the specified database.
[list](list.md) | Retrieves a list of databases.
[update](update.md) | Modifies the specified database.