---
editable: false
---

# Method update

 

 
## HTTP request {#https-request}
```
PATCH https://vpc.{{ api-host }}/vpc/v1/securityGroups/{securityGroupId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
securityGroupId | <p>Required.</p> 
 
## Body parameters {#body_params}
 
```json 
{
  "updateMask": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "ruleSpecs": [
    {
      "description": "string",
      "labels": "object",
      "direction": "string",
      "ports": {
        "fromPort": "string",
        "toPort": "string"
      },

      // `ruleSpecs[]` includes only one of the fields `cidrBlocks`, `securityGroupId`, `predefinedTarget`
      "protocolName": "string",
      "protocolNumber": "string",
      // end of the list of possible fields`ruleSpecs[]`

      "cidrBlocks": {
        "v4CidrBlocks": [
          "string"
        ],
        "v6CidrBlocks": [
          "string"
        ]
      },
      "securityGroupId": "string",
      "predefinedTarget": "string"
    }
  ]
}
```

 
Field | Description
--- | ---
updateMask | **string**<br><p>A comma-separated names off ALL fields to be updated. Оnly the specified fields will be changed. The others will be left untouched. If the field is specified in ``updateMask`` and no value for that field was sent in the request, the field's value will be reset to the default. The default value for most fields is null or 0.</p> <p>If ``updateMask`` is not sent in the request, all fields' values will be updated. Fields specified in the request will be updated to provided values. The rest of the fields will be reset to the default.</p> 
name | **string**
description | **string**
labels | **object**
ruleSpecs[] | **object**<br><p>all existing rules will be replaced with given list</p> 
ruleSpecs[].<br>description | **string**
ruleSpecs[].<br>labels | **object**
ruleSpecs[].<br>direction | **string**<br>Required.
ruleSpecs[].<br>ports | **object**
ruleSpecs[].<br>ports.<br>fromPort | **string** (int64)<br><p>Acceptable values are 0 to 65535, inclusive.</p> 
ruleSpecs[].<br>ports.<br>toPort | **string** (int64)<br><p>Acceptable values are 0 to 65535, inclusive.</p> 
ruleSpecs[].<br>protocolName | **string** <br>`ruleSpecs[]` includes only one of the fields `protocolName`, `protocolNumber`<br>
ruleSpecs[].<br>protocolNumber | **string** (int64) <br>`ruleSpecs[]` includes only one of the fields `protocolName`, `protocolNumber`<br>
ruleSpecs[].<br>cidrBlocks | **object** <br>`ruleSpecs[]` includes only one of the fields `cidrBlocks`, `securityGroupId`, `predefinedTarget`<br>
ruleSpecs[].<br>cidrBlocks.<br>v4CidrBlocks[] | **string**
ruleSpecs[].<br>cidrBlocks.<br>v6CidrBlocks[] | **string**
ruleSpecs[].<br>securityGroupId | **string** <br>`ruleSpecs[]` includes only one of the fields `cidrBlocks`, `securityGroupId`, `predefinedTarget`<br>
ruleSpecs[].<br>predefinedTarget | **string** <br>`ruleSpecs[]` includes only one of the fields `cidrBlocks`, `securityGroupId`, `predefinedTarget`<br>
 
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
done | **boolean** (boolean)<br><p>If the value is ``false``, it means the operation is still in progress. If ``true``, the operation is completed, and either ``error`` or ``response`` is available.</p> 
metadata | **object**<br><p>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any.</p> 
error | **object**<br>The error result of the operation in case of failure or cancellation. <br> includes only one of the fields `error`, `response`<br>
error.<br>code | **integer** (int32)<br><p>Error code. An enum value of <a href="https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto">google.rpc.Code</a>.</p> 
error.<br>message | **string**<br><p>An error message.</p> 
error.<br>details[] | **object**<br><p>A list of messages that carry the error details.</p> 
response | **object** <br> includes only one of the fields `error`, `response`<br><br><p>The normal response of the operation in case of success. If the original method returns no data on success, such as Delete, the response is <a href="https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#empty">google.protobuf.Empty</a>. If the original method is the standard Create/Update, the response should be the target resource of the operation. Any method that returns a long-running operation should document the response type, if any.</p> 