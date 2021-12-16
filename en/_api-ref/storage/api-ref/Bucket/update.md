---
editable: false
---

# Method update
Update the specified bucket.
 

 
## HTTP request {#https-request}
```
PATCH https://storage.api.cloud.yandex.net/storage/v1/buckets/{name}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
name | Required. Unique name of the bucket. To get the bucket name, use [list](/docs/storage/api-ref/Bucket/list) request.
 
## Body parameters {#body_params}
 
```json 
{
  "fieldMask": "string",
  "anonymousAccessFlags": {
    "read": true,
    "list": true,
    "configRead": true
  },
  "defaultStorageClass": "string",
  "maxSize": "string",
  "cors": [
    {
      "id": "string",
      "allowedMethods": [
        "string"
      ],
      "allowedHeaders": [
        "string"
      ],
      "allowedOrigins": [
        "string"
      ],
      "exposeHeaders": [
        "string"
      ],
      "maxAgeSeconds": "integer"
    }
  ],
  "websiteSettings": {
    "index": "string",
    "error": "string",
    "redirectAllRequests": {
      "protocol": "string",
      "hostname": "string"
    },
    "routingRules": [
      {
        "condition": {
          "httpErrorCodeReturnedEquals": "string",
          "keyPrefixEquals": "string"
        },
        "redirect": {
          "hostname": "string",
          "httpRedirectCode": "string",
          "protocol": "string",
          "replaceKeyPrefixWith": "string",
          "replaceKeyWith": "string"
        }
      }
    ]
  },
  "versioning": "string",
  "lifecycleRules": [
    {
      "id": "string",
      "enabled": true,
      "filter": {
        "prefix": "string"
      },
      "expiration": {
        "date": "string",
        "days": "integer",
        "expiredObjectDeleteMarker": true
      },
      "transitions": [
        {
          "date": "string",
          "days": "integer",
          "storageClass": "string"
        }
      ],
      "abortIncompleteMultipartUpload": {
        "daysAfterExpiration": "integer"
      },
      "noncurrentExpiration": {
        "noncurrentDays": "integer"
      },
      "noncurrentTransitions": [
        {
          "noncurrentDays": "integer",
          "storageClass": "string"
        }
      ]
    }
  ],
  "policy": "object",
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
UpdateBucketRequest acts like patch method in HTTP world
In order to update most of the properties, the user must
have the appropriate permissions.

In most cases, storage.editor permission should be enough, but
might be limited by the bucket's Policy.

For more information, see [Policy](/docs/storage/concepts/policy)
 
Field | Description
--- | ---
fieldMask | **string**<br><p>Required. field_maks defines fields that should be updated.</p> <p>A comma-separated names off ALL fields to be updated. Оnly the specified fields will be changed. The others will be left untouched. If the field is specified in ``updateMask`` and no value for that field was sent in the request, the field's value will be reset to the default. The default value for most fields is null or 0.</p> <p>If ``updateMask`` is not sent in the request, all fields' values will be updated. Fields specified in the request will be updated to provided values. The rest of the fields will be reset to the default.</p> 
anonymousAccessFlags | **object**<br><p>Access flags for anonymous access. For more information, see <a href="/docs/storage/concepts/bucket#bucket-access">Bucket Access</a></p> 
anonymousAccessFlags.<br>read | **boolean** (boolean)<br>
anonymousAccessFlags.<br>list | **boolean** (boolean)<br>
anonymousAccessFlags.<br>configRead | **boolean** (boolean)<br>
defaultStorageClass | **string**<br><p>Storage class of bucket. For more information, see <a href="/docs/storage/concepts/storage-class">Storage Class</a></p> 
maxSize | **string** (int64)<br><p>Maximum size of bucket. For more information, see <a href="/docs/storage/operations/buckets/limit-max-volume">Size limits</a></p> 
cors[] | **object**<br><p>CORS settings for bucket, hosted as website. For more information, see <a href="/docs/storage/concepts/cors">CORS</a></p> 
cors[].<br>id | **string**<br>
cors[].<br>allowedMethods[] | **string**<br><p>Required. Must contain at least one element.</p> 
cors[].<br>allowedHeaders[] | **string**<br><p>allowed_headers elements might be either as exact value (i.e. Test-Header-Field) or as pattern (i.e. Test-*-Field) But only one star allowed.</p> 
cors[].<br>allowedOrigins[] | **string**<br><p>Required. allowed_origins elements might be either as exact value (i.e. some-value) or as pattern (i.e. some*value) But only one star allowed.</p> <p>Must contain at least one element.</p> 
cors[].<br>exposeHeaders[] | **string**<br>
cors[].<br>maxAgeSeconds | **integer** (int64)<br>
websiteSettings | **object**<br><p>Website settings of bucket. For more information, see <a href="/docs/storage/concepts/hosting">Static site hosting</a></p> 
websiteSettings.<br>index | **string**<br><p>index points to entrypoint of the website. Either property &quot;index&quot; or &quot;redirect_all_requests&quot; should be set in order to operate.</p> 
websiteSettings.<br>error | **string**<br>
websiteSettings.<br>redirectAllRequests | **object**<br><p>redirect_all_requests redirects all requests to other uri. If this field  used, no other fields should be defined.</p> 
websiteSettings.<br>redirectAllRequests.<br>protocol | **string**<br><p>by default, http will be used.</p> 
websiteSettings.<br>redirectAllRequests.<br>hostname | **string**<br>
websiteSettings.<br>routingRules[] | **object**<br>
websiteSettings.<br>routingRules[].<br>condition | **object**<br>
websiteSettings.<br>routingRules[].<br>condition.<br>httpErrorCodeReturnedEquals | **string**<br>
websiteSettings.<br>routingRules[].<br>condition.<br>keyPrefixEquals | **string**<br>
websiteSettings.<br>routingRules[].<br>redirect | **object**<br>
websiteSettings.<br>routingRules[].<br>redirect.<br>hostname | **string**<br>
websiteSettings.<br>routingRules[].<br>redirect.<br>httpRedirectCode | **string**<br><p>http_redirect_code allowed values ranges between 301 and 399. by default value 301 will be used.</p> <p>Value must match the regular expression ``3(0[1-9]\|[1-9][0-9])``.</p> 
websiteSettings.<br>routingRules[].<br>redirect.<br>protocol | **string**<br>
websiteSettings.<br>routingRules[].<br>redirect.<br>replaceKeyPrefixWith | **string**<br>
websiteSettings.<br>routingRules[].<br>redirect.<br>replaceKeyWith | **string**<br>
versioning | **string**<br><p>Bucket's versioning mode. For more information, see <a href="/docs/storage/concepts/versioning">Versioning</a></p> 
lifecycleRules[] | **object**<br><p>Objects's lifecycle rules. For more information, see <a href="/docs/storage/concepts/lifecycles">Lifecycles</a></p> 
lifecycleRules[].<br>id | **string**<br>
lifecycleRules[].<br>enabled | **boolean** (boolean)<br>
lifecycleRules[].<br>filter | **object**<br>
lifecycleRules[].<br>filter.<br>prefix | **string**<br>
lifecycleRules[].<br>expiration | **object**<br>
lifecycleRules[].<br>expiration.<br>date | **string** (date-time)<br><p>If date is set, days parameter not allowed</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
lifecycleRules[].<br>expiration.<br>days | **integer** (int64)<br><p>If days are set, date parameter not allowed</p> 
lifecycleRules[].<br>expiration.<br>expiredObjectDeleteMarker | **boolean** (boolean)<br><p>if expired_object_delete_marker is set, other parameters are not allowed.</p> 
lifecycleRules[].<br>transitions[] | **object**<br>
lifecycleRules[].<br>transitions[].<br>date | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
lifecycleRules[].<br>transitions[].<br>days | **integer** (int64)<br>
lifecycleRules[].<br>transitions[].<br>storageClass | **string**<br><p>Required.</p> 
lifecycleRules[].<br>abortIncompleteMultipartUpload | **object**<br>
lifecycleRules[].<br>abortIncompleteMultipartUpload.<br>daysAfterExpiration | **integer** (int64)<br>
lifecycleRules[].<br>noncurrentExpiration | **object**<br>
lifecycleRules[].<br>noncurrentExpiration.<br>noncurrentDays | **integer** (int64)<br>
lifecycleRules[].<br>noncurrentTransitions[] | **object**<br>
lifecycleRules[].<br>noncurrentTransitions[].<br>noncurrentDays | **integer** (int64)<br>
lifecycleRules[].<br>noncurrentTransitions[].<br>storageClass | **string**<br><p>Required.</p> 
policy | **object**<br><p>Bucket's policy. For more information, see <a href="/docs/storage/concepts/policy">Bucket Policy</a></p> 
acl | **object**<br><p>Bucket's ACL. For more information, see <a href="/docs/storage/concepts/acl">ACL</a></p> <p>ACL model.</p> 
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