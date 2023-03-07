---
editable: false
---

# Object Storage API, REST: Bucket.update
Updates the specified bucket.
 
In most cases, `storage.editor` role (see [documentation](/docs/storage/security/#storage-editor)) should be enough
to update a bucket, subject to its [policy](/docs/storage/concepts/policy).
 
## HTTP request {#https-request}
```
PATCH https://storage.{{ api-host }}/storage/v1/buckets/{name}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
name | <p>Required. Name of the bucket to update.</p> <p>The name cannot be updated.</p> <p>To get the bucket name, make a <a href="/docs/storage/api-ref/Bucket/list">list</a> request.</p> 
 
## Body parameters {#body_params}
 
```json 
{
  "updateMask": "string",
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
        "prefix": "string",
        "objectSizeGreaterThan": "integer",
        "objectSizeLessThan": "integer"
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
  },
  "tags": [
    {
      "key": "string",
      "value": "string"
    }
  ],
  "objectLock": {
    "status": "string",
    "defaultRetention": {
      "mode": "string",

      // `objectLock.defaultRetention` includes only one of the fields `days`, `years`
      "days": "string",
      "years": "string",
      // end of the list of possible fields`objectLock.defaultRetention`

    }
  }
}
```

 
Field | Description
--- | ---
updateMask | **string**<br><p>Required. Update mask that specifies which attributes of the bucket should be updated. Use * for full update.</p> <p>A comma-separated names off ALL fields to be updated. Only the specified fields will be changed. The others will be left untouched. If the field is specified in ``updateMask`` and no value for that field was sent in the request, the field's value will be reset to the default. The default value for most fields is null or 0.</p> <p>If ``updateMask`` is not sent in the request, all fields' values will be updated. Fields specified in the request will be updated to provided values. The rest of the fields will be reset to the default.</p> 
anonymousAccessFlags | **object**<br><p>Flags for configuring public (anonymous) access to the bucket's content and settings. For details, see <a href="/docs/storage/concepts/bucket#bucket-access">documentation</a>.</p> 
anonymousAccessFlags.<br>read | **boolean** (boolean)<br><p>Specifies whether public (anonymous) access to read objects in the bucket is enabled.</p> 
anonymousAccessFlags.<br>list | **boolean** (boolean)<br><p>Specifies whether public (anonymous) access to the list of objects in the bucket is enabled.</p> 
anonymousAccessFlags.<br>configRead | **boolean** (boolean)<br><p>Specifies whether public (anonymous) access to read <a href="/docs/storage/concepts/cors">CORS</a>, <a href="/docs/storage/concepts/hosting">static website hosting</a>, and <a href="/docs/storage/concepts/lifecycles">object lifecycles</a> settings of the bucket is enabled.</p> 
defaultStorageClass | **string**<br><p>Default storage class for objects in the bucket. Supported classes are standard storage (``STANDARD``), cold storage (``COLD``, ``STANDARD_IA``, ``NEARLINE`` all synonyms), and ice storage (``ICE`` and ``GLACIER`` are synonyms). For details, see <a href="/docs/storage/concepts/storage-class">documentation</a>.</p> 
maxSize | **string** (int64)<br><p>Maximum size of the bucket, in bytes. For details, see <a href="/docs/storage/operations/buckets/limit-max-volume">documentation</a>.</p> 
cors[] | **object**<br><p>List of rules for cross-domain requests to objects in the bucket (cross-origin resource sharing, CORS). For details, see <a href="/docs/storage/concepts/cors">documentation</a>.</p> 
cors[].<br>id | **string**<br><p>ID of the CORS rule.</p> 
cors[].<br>allowedMethods[] | **string**<br><p>Required. List of HTTP methods allowed by the CORS rule.</p> <p>When a client sends a CORS-preflight ``options`` request with the ``Access-Control-Request-Method`` header (see <a href="/docs/storage/s3/api-ref/object/options">S3-compatible API reference</a>), the specified method is checked against the list of the allowed methods. If there is a match, all the allowed methods are listed in the ``Access-Control-Allow-Methods`` header of the response.</p> <p>Must contain at least one element.</p> <ul> <li>METHOD_GET: HTTP ``GET`` method.</li> <li>METHOD_HEAD: HTTP ``HEAD`` method.</li> <li>METHOD_POST: HTTP ``POST`` method.</li> <li>METHOD_PUT: HTTP ``PUT`` method.</li> <li>METHOD_DELETE: HTTP ``DELETE`` method.</li> </ul> 
cors[].<br>allowedHeaders[] | **string**<br><p>List of HTTP headers allowed by the CORS rule.</p> <p>When a client sends a CORS-preflight ``options`` request with the ``Access-Control-Request-Headers`` header (see <a href="/docs/storage/s3/api-ref/object/options">S3-compatible API reference</a>), the specified headers are checked against the list of the allowed headers. If there is a match, the specified headers that are allowed are listed in the ``Access-Control-Allow-Headers`` header of the response.</p> <p>Each string in the list can contain at most one ``*`` wildcard character that matches 0 or more characters. For example, ``x-amz-*`` value will allow all Amazon S3-compatible headers.</p> 
cors[].<br>allowedOrigins[] | **string**<br><p>Required. List of request origins allowed by the CORS rule.</p> <p>Each string in the list can contain at most one ``*`` wildcard character that matches 0 or more characters. For example, ``http://*.example.com`` value will allow requests originating from all subdomains of ``example.com``.</p> <p>Must contain at least one element.</p> 
cors[].<br>exposeHeaders[] | **string**<br><p>List of headers contained in responses to CORS requests that can be accessed by applications.</p> 
cors[].<br>maxAgeSeconds | **integer** (int64)<br><p>Time in seconds that a client can cache the response to a CORS-preflight request as identified by the object requested, the HTTP method, and the origin.</p> 
websiteSettings | **object**<br><p>Configuration for hosting a static website in the bucket. For details, see <a href="/docs/storage/concepts/hosting">documentation</a>.</p> 
websiteSettings.<br>index | **string**<br><p>Key of the index page object that is returned when a response is made to the root of the website.</p> <p>Either ``index`` or ``redirectAllRequests`` must be specified in order for the bucket to host a static website.</p> <p>If specified, the index page object must be located in the root of the bucket.</p> 
websiteSettings.<br>error | **string**<br><p>Key of the error page object that is returned when an error occurs.</p> 
websiteSettings.<br>redirectAllRequests | **object**<br><p>Configuration for redirecting all requests sent to the website.</p> <p>Either ``redirectAllRequests`` or ``index`` must be specified in order for the bucket to host a static website. If ``redirectAllRequests`` is specified, it must be the only field in <a href="/docs/storage/api-ref/Bucket#representation">Bucket.websiteSettings</a>.</p> <p>A configuration resource for redirecting all requests sent to the website.</p> 
websiteSettings.<br>redirectAllRequests.<br>protocol | **string**<br><p>Scheme of the redirect URI.</p> <ul> <li>PROTOCOL_HTTP: ``http`` scheme.</li> <li>PROTOCOL_HTTPS: ``https`` scheme.</li> </ul> 
websiteSettings.<br>redirectAllRequests.<br>hostname | **string**<br><p>Hostname of the redirect URI.</p> 
websiteSettings.<br>routingRules[] | **object**<br><p>List of redirect rules.</p> 
websiteSettings.<br>routingRules[].<br>condition | **object**<br><p>Redirect condition.</p> 
websiteSettings.<br>routingRules[].<br>condition.<br>httpErrorCodeReturnedEquals | **string**<br><p>HTTP status code (number only) that must match for the redirect to apply.</p> 
websiteSettings.<br>routingRules[].<br>condition.<br>keyPrefixEquals | **string**<br><p>Prefix of the object key from which requests are redirected.</p> 
websiteSettings.<br>routingRules[].<br>redirect | **object**<br><p>Redirect instructions.</p> 
websiteSettings.<br>routingRules[].<br>redirect.<br>hostname | **string**<br><p>Hostname of the redirect URI.</p> 
websiteSettings.<br>routingRules[].<br>redirect.<br>httpRedirectCode | **string**<br><p>HTTP status code of the redirect response.</p> <p>Default value: ``"301"``.</p> <p>Value must match the regular expression ``3(0[1-9]\|[1-9][0-9])``.</p> 
websiteSettings.<br>routingRules[].<br>redirect.<br>protocol | **string**<br><p>Scheme of the redirect URI.</p> <ul> <li>PROTOCOL_HTTP: ``http`` scheme.</li> <li>PROTOCOL_HTTPS: ``https`` scheme.</li> </ul> 
websiteSettings.<br>routingRules[].<br>redirect.<br>replaceKeyPrefixWith | **string**<br><p>Substitution for the prefix of the object key specified in ``keyPrefixEquals``.</p> <p>At most one of ``replaceKeyPrefixWith`` and ``replaceKeyWith`` can be specified.</p> 
websiteSettings.<br>routingRules[].<br>redirect.<br>replaceKeyWith | **string**<br><p>New object key.</p> <p>At most one of ``replaceKeyWith`` and ``replaceKeyPrefixWith`` can be specified.</p> 
versioning | **string**<br><p>Bucket versioning status. For details, see <a href="/docs/storage/concepts/versioning">documentation</a>.</p> <ul> <li> <p>VERSIONING_DISABLED: The bucket is unversioned, i.e. versioning has never been enabled for the bucket, including at its creation. Objects that are stored in the bucket have a version ID of ``null``.</p> <p>To enable versioning, change status to ``VERSIONING_ENABLED`` via a <a href="/docs/storage/api-ref/Bucket/update">update</a> request. Note that this action is irreversible, and a bucket with versioning enabled can never return to ``VERSIONING_DISABLED`` state.</p> </li> <li> <p>VERSIONING_ENABLED: Bucket versioning is enabled, i.e. all new objects are versioned and given a unique version ID, and objects that already existed at the time versioning was enabled will be versioned and given a unique version ID when modified by future requests.</p> <p>To suspend versioning, change status to ``VERSIONING_SUSPENDED`` via a <a href="/docs/storage/api-ref/Bucket/update">update</a> request. You cannot disable versioning altogether for a bucket that already had it enabled; objects that had version IDs will keep them.</p> </li> <li> <p>VERSIONING_SUSPENDED: Bucket versioning is suspended, i.e. new objects are not versioned, but objects that already existed at the time versioning was suspended are still versioned and keep their version IDs.</p> <p>To resume versioning, change status to ``VERSIONING_ENABLED`` via a <a href="/docs/storage/api-ref/Bucket/update">update</a> request.</p> </li> </ul> 
lifecycleRules[] | **object**<br><p>List of object lifecycle rules for the bucket. For details, see <a href="/docs/storage/concepts/lifecycles">documentation</a>.</p> 
lifecycleRules[].<br>id | **string**<br><p>ID of the rule. Provided by the client or generated at creation time.</p> 
lifecycleRules[].<br>enabled | **boolean** (boolean)<br><p>Indicates whether the rule is in effect.</p> 
lifecycleRules[].<br>filter | **object**<br><p>Filter that identifies the objects to which the rule applies.</p> <p>If not specified, the rule applies to all objects in the bucket.</p> 
lifecycleRules[].<br>filter.<br>prefix | **string**<br><p>Key prefix that the object must have in order for the rule to apply.</p> 
lifecycleRules[].<br>filter.<br>objectSizeGreaterThan | **integer** (int64)<br><p>Size that the object must be greater.</p> 
lifecycleRules[].<br>filter.<br>objectSizeLessThan | **integer** (int64)<br><p>Size that the object must be less t.</p> 
lifecycleRules[].<br>expiration | **object**<br><p>Expiration rule.</p> <p>The expiration of an object is described as follows.</p> <p>For the unversioned bucket (<a href="/docs/storage/api-ref/Bucket#representation">Bucket.versioning</a> is ``VERSIONING_DISABLED``), the object is deleted and cannot be recovered.</p> <p>For the bucket with versioning enabled (<a href="/docs/storage/api-ref/Bucket#representation">Bucket.versioning</a> is ``VERSIONING_ENABLED``), the current version of the object (if it exists and is not a delete marker) is retained as a non-current version, and a delete marker becomes the current version of the object.</p> <p>For the bucket with versioning suspended (<a href="/docs/storage/api-ref/Bucket#representation">Bucket.versioning</a> is ``VERSIONING_SUSPENDED``), the current version of the object is retained as a non-current version if it is not a delete marker, or is removed otherwise, and a delete marker becomes the current version of the object.</p> 
lifecycleRules[].<br>expiration.<br>date | **string** (date-time)<br><p>Specific date of object expiration.</p> <p>The rule continues to apply even after the date has passed, i.e. any new objects created in the bucket expire immediately.</p> <p>Exactly one of ``date``, ``days``, and ``expiredObjectDeleteMarker`` fields can be specified.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
lifecycleRules[].<br>expiration.<br>days | **integer** (int64)<br><p>Time period, in number of days from the creation or modification of the object, after which an object expires.</p> <p>Exactly one of ``days``, ``date``, and ``expiredObjectDeleteMarker`` fields can be specified.</p> 
lifecycleRules[].<br>expiration.<br>expiredObjectDeleteMarker | **boolean** (boolean)<br><p>Indicates whether a delete marker of an object with no non-current versions (referred to as an expired object delete marker) is removed at the object's expiration.</p> <p>Exactly one of ``expiredObjectDeleteMarker``, ``date``, and ``days`` fields can be specified.</p> 
lifecycleRules[].<br>transitions[] | **object**<br><p>List of transition rules.</p> <p>The transition of an object is described as follows.</p> <p>For the unversioned bucket (<a href="/docs/storage/api-ref/Bucket#representation">Bucket.versioning</a> is ``VERSIONING_DISABLED``), the object is transitioned to the specified storage class.</p> <p>For the bucket with versioning enabled (<a href="/docs/storage/api-ref/Bucket#representation">Bucket.versioning</a> is ``VERSIONING_ENABLED``) or suspended (``VERSIONING_SUSPENDED``), the current version of the object is transitioned to the specified storage class.</p> 
lifecycleRules[].<br>transitions[].<br>date | **string** (date-time)<br><p>Specific date of object transition.</p> <p>The rule continues to apply even after the date has passed, i.e. any new objects created in the bucket are transitioned immediately.</p> <p>At most one of ``date`` and ``days`` fields can be specified.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
lifecycleRules[].<br>transitions[].<br>days | **integer** (int64)<br><p>Time period, in number of days from the creation or modification of the object, after which an object is transitioned.</p> <p>At most one of ``days`` and ``date`` fields can be specified.</p> 
lifecycleRules[].<br>transitions[].<br>storageClass | **string**<br><p>Required. Storage class to which an object is transitioned from standard storage.</p> <p>The only supported class is cold storage (``COLD``, ``STANDARD_IA``, ``NEARLINE`` all synonyms). Transitions from cold to standard storage and transitions to or from ice storage are not allowed.</p> 
lifecycleRules[].<br>abortIncompleteMultipartUpload | **object**<br><p>Configuration for aborting incomplete <a href="/docs/storage/concepts/multipart">multipart uploads</a>.</p> 
lifecycleRules[].<br>abortIncompleteMultipartUpload.<br>daysAfterExpiration | **integer** (int64)<br><p>Time period, in number of days from the start of the multipart upload, after which the incomplete upload is aborted.</p> 
lifecycleRules[].<br>noncurrentExpiration | **object**<br><p>Expiration rule for non-current versions of objects in a bucket with versioning enabled (<a href="/docs/storage/api-ref/Bucket#representation">Bucket.versioning</a> is ``VERSIONING_ENABLED``) or suspended (``VERSIONING_SUSPENDED``).</p> <p>At expiration, the non-current version of the object is deleted and cannot be recovered.</p> 
lifecycleRules[].<br>noncurrentExpiration.<br>noncurrentDays | **integer** (int64)<br><p>Time period, in number of days since the version of an object was classified as non-current, after which the version expires.</p> 
lifecycleRules[].<br>noncurrentTransitions[] | **object**<br><p>List of transition rules for non-current versions of objects in a bucket with versioning enabled (<a href="/docs/storage/api-ref/Bucket#representation">Bucket.versioning</a> is ``VERSIONING_ENABLED``) or suspended (``VERSIONING_SUSPENDED``).</p> <p>At transition, the non-current version of the object is transitioned to the specified storage class.</p> 
lifecycleRules[].<br>noncurrentTransitions[].<br>noncurrentDays | **integer** (int64)<br><p>Time period, in number of days since the version of an object was classified as non-current, after which the version is transitioned.</p> 
lifecycleRules[].<br>noncurrentTransitions[].<br>storageClass | **string**<br><p>Required. Storage class to which a non-current version of an object is transitioned from standard storage.</p> <p>The only supported class is cold storage (``COLD``, ``STANDARD_IA``, ``NEARLINE`` all synonyms). Transitions from cold to standard storage and transitions to or from ice storage are not allowed.</p> 
policy | **object**<br><p>Bucket policies that set permissions for actions with the bucket, its objects, and groups of objects. For details, see <a href="/docs/storage/concepts/policy">documentation</a>.</p> 
acl | **object**<br><p>Access control list (ACL) of the bucket. For details, see <a href="/docs/storage/concepts/acl">documentation</a>.</p> 
acl.<br>grants[] | **object**<br><p>List of permissions granted and the grantees.</p> 
acl.<br>grants[].<br>permission | **string**<br><p>Required. Permission granted by the grant.</p> <ul> <li> <p>PERMISSION_FULL_CONTROL: Allows grantee the ``PERMISSION_WRITE``, ``PERMISSION_WRITE_ACP``, ``PERMISSION_READ``, and ``PERMISSION_READ_ACP`` on the bucket.</p> <p>Maps to ``x-amz-grant-full-control`` header for <a href="/docs/storage/s3/api-ref/acl/bucketput">bucketPutAcl</a> method of Amazon S3-compatible HTTP API.</p> </li> <li> <p>PERMISSION_WRITE: Allows grantee to create new objects in the bucket. For the bucket and object owners of existing objects, also allows deletions and overwrites of those objects.</p> <p>Maps to ``x-amz-grant-write`` header for <a href="/docs/storage/s3/api-ref/acl/bucketput">bucketPutAcl</a> method of Amazon S3-compatible HTTP API.</p> </li> <li> <p>PERMISSION_WRITE_ACP: Allows grantee to write the ACL for the bucket.</p> <p>Maps to ``x-amz-grant-write-acp`` header for <a href="/docs/storage/s3/api-ref/acl/bucketput">bucketPutAcl</a> method of Amazon S3-compatible HTTP API.</p> </li> <li> <p>PERMISSION_READ: Allows grantee to list the objects in the bucket.</p> <p>Maps to ``x-amz-grant-read`` header for <a href="/docs/storage/s3/api-ref/acl/bucketput">bucketPutAcl</a> method of Amazon S3-compatible HTTP API.</p> </li> <li> <p>PERMISSION_READ_ACP: Allows grantee to read the bucket ACL</p> <p>Maps to ``x-amz-grant-read-acp`` header for <a href="/docs/storage/s3/api-ref/acl/bucketput">bucketPutAcl</a> method of Amazon S3-compatible HTTP API.</p> </li> </ul> 
acl.<br>grants[].<br>grantType | **string**<br><p>Required. The grantee type for the grant.</p> <ul> <li> <p>GRANT_TYPE_ACCOUNT: A grantee is an <a href="/docs/iam/concepts/#accounts">account on the platform</a>.</p> <p>For this grantee type, you need to specify the user ID in <a href="/docs/storage/api-ref/Bucket#representation">Bucket.acl.grants.granteeId</a> field. To get user ID, see <a href="/docs/iam/operations/users/get">instruction</a>.</p> <p>Maps to using ``id="*"`` value for ``x-amz-grant-*`` header (<a href="/docs/storage/s3/api-ref/acl/bucketput">bucketPutAcl</a> method of Amazon S3-compatible HTTP API).</p> </li> <li> <p>GRANT_TYPE_ALL_AUTHENTICATED_USERS: Grantees are all authenticated users, both from your clouds and other users' clouds. Access permission to this group allows any account on the platform to access the resource via a signed (authenticated) request.</p> <p>Maps to using ``uri="http://acs.amazonaws.com/groups/global/AuthenticatedUsers"`` value for ``x-amz-grant-*`` header (<a href="/docs/storage/s3/api-ref/acl/bucketput">bucketPutAcl</a> method of Amazon S3-compatible HTTP API).</p> </li> <li> <p>GRANT_TYPE_ALL_USERS: Grantees are all internet users. Access permission to this group allows anyone in the world access to the resource via signed (authenticated) or unsigned (anonymous) requests.</p> <p>Maps to using ``uri="http://acs.amazonaws.com/groups/global/AllUsers"`` value for ``x-amz-grant-*`` header (<a href="/docs/storage/s3/api-ref/acl/bucketput">bucketPutAcl</a> method of Amazon S3-compatible HTTP API).</p> </li> </ul> 
acl.<br>grants[].<br>granteeId | **string**<br><p>ID of the account who is a grantee. Required when the ``grantType`` is ``GRANT_TYPE_ACCOUNT``.</p> 
tags[] | **object**<br><p>List of object tag for the bucket.</p> 
tags[].<br>key | **string**
tags[].<br>value | **string**
objectLock | **object**<br><p>Configuration for object lock on the bucket. For details about the concept, see <a href="/docs/storage/concepts/object-lock">documentation</a>.</p> <p>A resource for Object Lock configuration of a bucket. For details about the concept, see <a href="/docs/storage/concepts/object-lock">documentation</a>.</p> 
objectLock.<br>status | **string**<br><p>Activity status of the object lock settings on the bucket</p> 
objectLock.<br>defaultRetention | **object**<br><p>Default lock configuration for added objects</p> 
objectLock.<br>defaultRetention.<br>mode | **string**<br><p>Lock type</p> 
objectLock.<br>defaultRetention.<br>days | **string** (int64) <br>`objectLock.defaultRetention` includes only one of the fields `days`, `years`<br><br><p>Number of days for locking</p> 
objectLock.<br>defaultRetention.<br>years | **string** (int64) <br>`objectLock.defaultRetention` includes only one of the fields `days`, `years`<br><br><p>Number of years for locking</p> 
 
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
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
createdBy | **string**<br><p>ID of the user or service account who initiated the operation.</p> 
modifiedAt | **string** (date-time)<br><p>The time when the Operation resource was last modified.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
done | **boolean** (boolean)<br><p>If the value is ``false``, it means the operation is still in progress. If ``true``, the operation is completed, and either ``error`` or ``response`` is available.</p> 
metadata | **object**<br><p>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any.</p> 
error | **object**<br>The error result of the operation in case of failure or cancellation. <br> includes only one of the fields `error`, `response`<br>
error.<br>code | **integer** (int32)<br><p>Error code. An enum value of <a href="https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto">google.rpc.Code</a>.</p> 
error.<br>message | **string**<br><p>An error message.</p> 
error.<br>details[] | **object**<br><p>A list of messages that carry the error details.</p> 
response | **object** <br> includes only one of the fields `error`, `response`<br><br><p>The normal response of the operation in case of success. If the original method returns no data on success, such as Delete, the response is <a href="https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#empty">google.protobuf.Empty</a>. If the original method is the standard Create/Update, the response should be the target resource of the operation. Any method that returns a long-running operation should document the response type, if any.</p> 