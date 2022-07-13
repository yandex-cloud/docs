---
editable: false
sourcePath: en/_api-ref/apploadbalancer/api-ref/TargetGroup/create.md
---

# Method create
Creates a target group in the specified folder.
 

 
## HTTP request {#https-request}
```
POST https://alb.{{ api-host }}/apploadbalancer/v1/targetGroups
```
 
## Body parameters {#body_params}
 
```json 
{
  "folderId": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "targets": [
    {
      "subnetId": "string",
      "privateIpv4Address": true,
      "ipAddress": "string"
    }
  ]
}
```

 
Field | Description
--- | ---
folderId | **string**<br><p>Required. ID of the folder to create a target group in.</p> <p>To get the folder ID, make a <a href="/docs/resource-manager/api-ref/Folder/list">list</a> request.</p> 
name | **string**<br><p>Name of the target group. The name must be unique within the folder.</p> <p>Value must match the regular expression ``([a-z]([-a-z0-9]{0,61}[a-z0-9])?)?``.</p> 
description | **string**<br><p>Description of the target group.</p> <p>The maximum string length in characters is 256.</p> 
labels | **object**<br><p>Target group labels as ``key:value`` pairs. For details about the concept, see <a href="/docs/overview/concepts/services#labels">documentation</a>.</p> <p>No more than 64 per resource. The string length in characters for each key must be 1-63. Each key must match the regular expression ``[a-z][-_./\@0-9a-z]*``. The maximum string length in characters for each value is 63. Each value must match the regular expression ``[-_./\@0-9a-z]*``.</p> 
targets[] | **object**<br><p>List of targets in the target group.</p> 
targets[].<br>subnetId | **string**<br><p>ID of the subnet that the target is connected to.</p> 
targets[].<br>privateIpv4Address | **boolean** (boolean)<br><p>If set, will not require ``subnet_id`` to validate the target. Instead, the address should belong to one of the following ranges: 10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16 Only one of ``subnet_id`` or ``private_ipv4_address`` should be set.</p> 
targets[].<br>ipAddress | **string**<br><p>IP address of the target.</p> 
 
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