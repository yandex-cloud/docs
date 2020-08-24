---
editable: false
---

# Method update
Modifies the specified database.
 

 
## HTTP request {#https-request}
```
PATCH https://ydb.api.cloud.yandex.net/ydb/v1/databases/{databaseId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
databaseId | 
 
## Body parameters {#body_params}
 
```json 
{
  "folderId": "string",
  "updateMask": "string",
  "name": "string",
  "description": "string",
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
folderId | **string**<br>
updateMask | **string**<br><p>A comma-separated names off ALL fields to be updated. Оnly the specified fields will be changed. The others will be left untouched. If the field is specified in <code>updateMask</code> and no value for that field was sent in the request, the field's value will be reset to the default. The default value for most fields is null or 0.</p> <p>If <code>updateMask</code> is not sent in the request, all fields' values will be updated. Fields specified in the request will be updated to provided values. The rest of the fields will be reset to the default.</p> 
name | **string**<br>
description | **string**<br>
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
zonalDatabase | **object**<br>deprecated field <br> includes only one of the fields `zonalDatabase`, `regionalDatabase`, `dedicatedDatabase`, `serverlessDatabase`<br><br>
zonalDatabase.<br>zoneId | **string**<br><p>Required.</p> 
regionalDatabase | **object**<br>deprecated field <br> includes only one of the fields `zonalDatabase`, `regionalDatabase`, `dedicatedDatabase`, `serverlessDatabase`<br><br>
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
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": true,
  "metadata": "object",

  //  includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": "object",
  // end of the list of possible fields

}
```
An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).
 
Field | Description
--- | ---
id | **string**<br><p>ID of the operation.</p> 
description | **string**<br><p>Description of the operation. 0-256 characters long.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
createdBy | **string**<br><p>ID of the user or service account who initiated the operation.</p> 
modifiedAt | **string** (date-time)<br><p>The time when the Operation resource was last modified.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
done | **boolean** (boolean)<br><p>If the value is <code>false</code>, it means the operation is still in progress. If <code>true</code>, the operation is completed, and either <code>error</code> or <code>response</code> is available.</p> 
metadata | **object**<br><p>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any.</p> 
error | **object**<br>The error result of the operation in case of failure or cancellation. <br> includes only one of the fields `error`, `response`<br><br><p>The error result of the operation in case of failure or cancellation.</p> 
error.<br>code | **integer** (int32)<br><p>Error code. An enum value of <a href="https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto">google.rpc.Code</a>.</p> 
error.<br>message | **string**<br><p>An error message.</p> 
error.<br>details[] | **object**<br><p>A list of messages that carry the error details.</p> 
response | **object** <br> includes only one of the fields `error`, `response`<br><br><p>The normal response of the operation in case of success. If the original method returns no data on success, such as Delete, the response is <a href="https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#empty">google.protobuf.Empty</a>. If the original method is the standard Create/Update, the response should be the target resource of the operation. Any method that returns a long-running operation should document the response type, if any.</p> 