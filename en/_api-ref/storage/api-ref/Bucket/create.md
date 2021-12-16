---
editable: false
---

# Method create
Create a new bucket in specified folder.
 

 
## HTTP request {#https-request}
```
POST https://storage.api.cloud.yandex.net/storage/v1/buckets
```
 
## Body parameters {#body_params}
 
```json 
{
  "name": "string",
  "folderId": "string",
  "defaultStorageClass": "string",
  "maxSize": "string",
  "anonymousAccessFlags": {
    "read": true,
    "list": true,
    "configRead": true
  },
  "acl": {
    "grants": [
      {
        "permission": "string",
        "grantType": "string",
        "granteeId": "string"
      }
    ]
  }
}
```
CreateBucketRequest creates bucket for S3.
 
Field | Description
--- | ---
name | **string**<br><p>Required. Unique name of the bucket. This name is treated as unique identifier and used among the whole Cloud. For naming limitations and rules, see <a href="/docs/storage/concepts/bucket#naming">Bucket naming</a></p> 
folderId | **string**<br><p>Required. ID of the folder to create a bucket in. To get the folder ID, use <a href="/docs/resource-manager/api-ref/Folder/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
defaultStorageClass | **string**<br><p>Class of the storage. For more information, see <a href="/docs/storage/concepts/storage-class">Storage Class</a></p> 
maxSize | **string** (int64)<br><p>Maximum size of bucket. For more information, see <a href="/docs/storage/operations/buckets/limit-max-volume">Size limits</a></p> 
anonymousAccessFlags | **object**<br><p>Access flags for anonymous access. For more information, see <a href="/docs/storage/concepts/bucket#bucket-access">Bucket Access</a></p> 
anonymousAccessFlags.<br>read | **boolean** (boolean)<br>
anonymousAccessFlags.<br>list | **boolean** (boolean)<br>
anonymousAccessFlags.<br>configRead | **boolean** (boolean)<br>
acl | **object**<br><p>ACL of bucket. For more information, see <a href="/docs/storage/concepts/acl">Bucket Policy</a></p> <p>ACL model.</p> 
acl.<br>grants[] | **object**<br>
acl.<br>grants[].<br>permission | **string**<br><p>Required.</p> <ul> <li>PERMISSION_FULL_CONTROL: header X-Amz-Grant-Full-Control</li> <li>PERMISSION_WRITE: header X-Amz-Grant-Write</li> <li>PERMISSION_WRITE_ACP: header X-Amz-Grant-Write-Acp</li> <li>PERMISSION_READ: header X-Amz-Grant-Read</li> <li>PERMISSION_READ_ACP: header X-Amz-Grant-Read-Acp</li> </ul> 
acl.<br>grants[].<br>grantType | **string**<br><p>Required.</p> <ul> <li>GRANT_TYPE_ACCOUNT: equal to 'id' grantee value</li> <li>GRANT_TYPE_ALL_AUTHENTICATED_USERS: equal to 'uri' authenticated users</li> <li>GRANT_TYPE_ALL_USERS: equal to 'uri' all users</li> </ul> 
acl.<br>grants[].<br>granteeId | **string**<br><p>[semi-optional] grantee id is used only when grant_type is TO_ACCOUNT</p> 
 
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
error | **object**<br>The error result of the operation in case of failure or cancellation. <br> includes only one of the fields `error`, `response`<br><br><p>The error result of the operation in case of failure or cancellation.</p> 
error.<br>code | **integer** (int32)<br><p>Error code. An enum value of <a href="https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto">google.rpc.Code</a>.</p> 
error.<br>message | **string**<br><p>An error message.</p> 
error.<br>details[] | **object**<br><p>A list of messages that carry the error details.</p> 
response | **object** <br> includes only one of the fields `error`, `response`<br><br><p>The normal response of the operation in case of success. If the original method returns no data on success, such as Delete, the response is <a href="https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#empty">google.protobuf.Empty</a>. If the original method is the standard Create/Update, the response should be the target resource of the operation. Any method that returns a long-running operation should document the response type, if any.</p> 