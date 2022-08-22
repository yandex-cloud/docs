---
editable: false
---

# Method create
Creates a bucket in the specified folder.
 

 
## HTTP request {#https-request}
```
POST https://storage.{{ api-host }}/storage/v1/buckets
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

 
Field | Description
--- | ---
name | **string**<br><p>Required. Name of the bucket.</p> <p>The name must be unique within the platform. For naming limitations and rules, see <a href="/docs/storage/concepts/bucket#naming">documentation</a>.</p> 
folderId | **string**<br><p>Required. ID of the folder to create a bucket in.</p> <p>To get the folder ID, make a <a href="/docs/resource-manager/api-ref/Folder/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
defaultStorageClass | **string**<br><p>Default storage class for objects in the bucket. Supported classes are standard storage (``STANDARD``), cold storage (``COLD``, ``STANDARD_IA``, ``NEARLINE`` all synonyms), and ice storage (``ICE`` and ``GLACIER`` are synonyms). For details, see <a href="/docs/storage/concepts/storage-class">documentation</a>.</p> 
maxSize | **string** (int64)<br><p>Maximum size of the bucket. For details, see <a href="/docs/storage/operations/buckets/limit-max-volume">documentation</a>.</p> 
anonymousAccessFlags | **object**<br><p>Flags for configuring public (anonymous) access to the bucket's content and settings. For details, see <a href="/docs/storage/concepts/bucket#bucket-access">documentation</a>.</p> 
anonymousAccessFlags.<br>read | **boolean** (boolean)<br><p>Specifies whether public (anonymous) access to read objects in the bucket is enabled.</p> 
anonymousAccessFlags.<br>list | **boolean** (boolean)<br><p>Specifies whether public (anonymous) access to the list of objects in the bucket is enabled.</p> 
anonymousAccessFlags.<br>configRead | **boolean** (boolean)<br><p>Specifies whether public (anonymous) access to read <a href="/docs/storage/concepts/cors">CORS</a>, <a href="/docs/storage/concepts/hosting">static website hosting</a>, and <a href="/docs/storage/concepts/lifecycles">object lifecycles</a> settings of the bucket is enabled.</p> 
acl | **object**<br><p>Access control list (ACL) of the bucket. For details, see <a href="/docs/storage/concepts/acl">documentation</a>.</p> 
acl.<br>grants[] | **object**<br><p>List of permissions granted and the grantees.</p> 
acl.<br>grants[].<br>permission | **string**<br><p>Required. Permission granted by the grant.</p> <ul> <li> <p>PERMISSION_FULL_CONTROL: Allows grantee the ``PERMISSION_WRITE``, ``PERMISSION_WRITE_ACP``, ``PERMISSION_READ``, and ``PERMISSION_READ_ACP`` on the bucket.</p> <p>Maps to ``x-amz-grant-full-control`` header for <a href="/docs/storage/s3/api-ref/acl/bucketput">bucketPutAcl</a> method of Amazon S3-compatible HTTP API.</p> </li> <li> <p>PERMISSION_WRITE: Allows grantee to create new objects in the bucket. For the bucket and object owners of existing objects, also allows deletions and overwrites of those objects.</p> <p>Maps to ``x-amz-grant-write`` header for <a href="/docs/storage/s3/api-ref/acl/bucketput">bucketPutAcl</a> method of Amazon S3-compatible HTTP API.</p> </li> <li> <p>PERMISSION_WRITE_ACP: Allows grantee to write the ACL for the bucket.</p> <p>Maps to ``x-amz-grant-write-acp`` header for <a href="/docs/storage/s3/api-ref/acl/bucketput">bucketPutAcl</a> method of Amazon S3-compatible HTTP API.</p> </li> <li> <p>PERMISSION_READ: Allows grantee to list the objects in the bucket.</p> <p>Maps to ``x-amz-grant-read`` header for <a href="/docs/storage/s3/api-ref/acl/bucketput">bucketPutAcl</a> method of Amazon S3-compatible HTTP API.</p> </li> <li> <p>PERMISSION_READ_ACP: Allows grantee to read the bucket ACL</p> <p>Maps to ``x-amz-grant-read-acp`` header for <a href="/docs/storage/s3/api-ref/acl/bucketput">bucketPutAcl</a> method of Amazon S3-compatible HTTP API.</p> </li> </ul> 
acl.<br>grants[].<br>grantType | **string**<br><p>Required. The grantee type for the grant.</p> <ul> <li> <p>GRANT_TYPE_ACCOUNT: A grantee is an <a href="/docs/iam/concepts/#accounts">account on the platform</a>.</p> <p>For this grantee type, you need to specify the user ID in <a href="/docs/storage/api-ref/Bucket#representation">Bucket.acl.grants.granteeId</a> field. To get user ID, see <a href="/docs/iam/operations/users/get">instruction</a>.</p> <p>Maps to using ``id="*"`` value for ``x-amz-grant-*`` header (<a href="/docs/storage/s3/api-ref/acl/bucketput">bucketPutAcl</a> method of Amazon S3-compatible HTTP API).</p> </li> <li> <p>GRANT_TYPE_ALL_AUTHENTICATED_USERS: Grantees are all authenticated users, both from your clouds and other users' clouds. Access permission to this group allows any account on the platform to access the resource via a signed (authenticated) request.</p> <p>Maps to using ``uri="http://acs.amazonaws.com/groups/global/AuthenticatedUsers"`` value for ``x-amz-grant-*`` header (<a href="/docs/storage/s3/api-ref/acl/bucketput">bucketPutAcl</a> method of Amazon S3-compatible HTTP API).</p> </li> <li> <p>GRANT_TYPE_ALL_USERS: Grantees are all internet users. Access permission to this group allows anyone in the world access to the resource via signed (authenticated) or unsigned (anonymous) requests.</p> <p>Maps to using ``uri="http://acs.amazonaws.com/groups/global/AllUsers"`` value for ``x-amz-grant-*`` header (<a href="/docs/storage/s3/api-ref/acl/bucketput">bucketPutAcl</a> method of Amazon S3-compatible HTTP API).</p> </li> </ul> 
acl.<br>grants[].<br>granteeId | **string**<br><p>ID of the account who is a grantee. Required when the ``grantType`` is ``GRANT_TYPE_ACCOUNT``.</p> 
 
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