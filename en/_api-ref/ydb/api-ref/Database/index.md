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

  //  includes only one of the fields `zonalDatabase`, `regionalDatabase`, `dedicatedDatabase`, `serverlessDatabase`
  "zonalDatabase": {
    "zoneId": "string"
  },
  "regionalDatabase": {
    "regionId": "string"
  },
  "dedicatedDatabase": {
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
zonalDatabase | **object** <br> includes only one of the fields `zonalDatabase`, `regionalDatabase`, `dedicatedDatabase`, `serverlessDatabase`<br><br>
zonalDatabase.<br>zoneId | **string**<br><p>Required.</p> 
regionalDatabase | **object** <br> includes only one of the fields `zonalDatabase`, `regionalDatabase`, `dedicatedDatabase`, `serverlessDatabase`<br><br>
regionalDatabase.<br>regionId | **string**<br><p>Required.</p> 
dedicatedDatabase | **object** <br> includes only one of the fields `zonalDatabase`, `regionalDatabase`, `dedicatedDatabase`, `serverlessDatabase`<br><br>
dedicatedDatabase.<br>resourcePresetId | **string**<br>
dedicatedDatabase.<br>storageConfig | **object**<br>
dedicatedDatabase.<br>storageConfig.<br>storageOptions[] | **object**<br><p>Required. The minimum number of elements is 1.</p> 
dedicatedDatabase.<br>storageConfig.<br>storageOptions[].<br>storageTypeId | **string**<br>
dedicatedDatabase.<br>storageConfig.<br>storageOptions[].<br>groupCount | **string** (int64)<br>
dedicatedDatabase.<br>scalePolicy | **object**<br>
dedicatedDatabase.<br>scalePolicy.<br>fixedScale | **object**<br>
dedicatedDatabase.<br>scalePolicy.<br>fixedScale.<br>size | **string** (int64)<br><p>The minimum value is 1.</p> 
dedicatedDatabase.<br>networkId | **string**<br>
dedicatedDatabase.<br>subnetIds[] | **string**<br>
dedicatedDatabase.<br>assignPublicIps | **boolean** (boolean)<br>
serverlessDatabase | **object** <br> includes only one of the fields `zonalDatabase`, `regionalDatabase`, `dedicatedDatabase`, `serverlessDatabase`<br><br>

## Methods {#methods}
Method | Description
--- | ---
[create](create.md) | Creates a new database.
[delete](delete.md) | Deletes the specified database.
[get](get.md) | Returns the specified database.
[list](list.md) | Retrieves a list of databases.
[update](update.md) | Modifies the specified database.