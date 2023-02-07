---
editable: false
sourcePath: en/_api-ref/storage/api-ref/Bucket/list.md
---

# Object Storage API, REST: Bucket.list
Retrieves the list of buckets in the specified folder.
 
The following fields will not be returned for buckets in the list: [Bucket.policy](/docs/storage/api-ref/Bucket#representation), [Bucket.acl](/docs/storage/api-ref/Bucket#representation), [Bucket.cors](/docs/storage/api-ref/Bucket#representation),
[Bucket.websiteSettings](/docs/storage/api-ref/Bucket#representation), [Bucket.lifecycleRules](/docs/storage/api-ref/Bucket#representation).
 
## HTTP request {#https-request}
```
GET https://storage.{{ api-host }}/storage/v1/buckets
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | <p>Required. ID of the folder to list buckets in.</p> <p>To get the folder ID, make a <a href="/docs/resource-manager/api-ref/Folder/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "buckets": [
    {
      "id": "string",
      "name": "string",
      "folderId": "string",
      "anonymousAccessFlags": {
        "read": true,
        "list": true,
        "configRead": true
      },
      "defaultStorageClass": "string",
      "versioning": "string",
      "maxSize": "string",
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
      "createdAt": "string",
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

          // `buckets[].objectLock.defaultRetention` includes only one of the fields `days`, `years`
          "days": "string",
          "years": "string",
          // end of the list of possible fields`buckets[].objectLock.defaultRetention`

        }
      }
    }
  ]
}
```

 
Field | Description
--- | ---
buckets[] | **object**<br><p>List of buckets in the specified folder.</p> 
buckets[].<br>id | **string**<br><p>ID of the bucket. Always equal to <a href="/docs/storage/api-ref/Bucket#representation">name</a>, which has priority.</p> 
buckets[].<br>name | **string**<br><p>Name of the bucket.</p> <p>The name is unique within the platform. For naming limitations and rules, see <a href="/docs/storage/concepts/bucket#naming">documentation</a>.</p> 
buckets[].<br>folderId | **string**<br><p>ID of the folder that the bucket belongs to.</p> 
buckets[].<br>anonymousAccessFlags | **object**<br><p>Flags for configuring public (anonymous) access to the bucket's content and settings. For details, see <a href="/docs/storage/concepts/bucket#bucket-access">documentation</a>.</p> 
buckets[].<br>anonymousAccessFlags.<br>read | **boolean** (boolean)<br><p>Specifies whether public (anonymous) access to read objects in the bucket is enabled.</p> 
buckets[].<br>anonymousAccessFlags.<br>list | **boolean** (boolean)<br><p>Specifies whether public (anonymous) access to the list of objects in the bucket is enabled.</p> 
buckets[].<br>anonymousAccessFlags.<br>configRead | **boolean** (boolean)<br><p>Specifies whether public (anonymous) access to read <a href="/docs/storage/concepts/cors">CORS</a>, <a href="/docs/storage/concepts/hosting">static website hosting</a>, and <a href="/docs/storage/concepts/lifecycles">object lifecycles</a> settings of the bucket is enabled.</p> 
buckets[].<br>defaultStorageClass | **string**<br><p>Default storage class for objects in the bucket. Supported classes are standard storage (``STANDARD``), cold storage (``COLD``, ``STANDARD_IA``, ``NEARLINE`` all synonyms), and ice storage (``ICE`` and ``GLACIER`` are synonyms). For details, see <a href="/docs/storage/concepts/storage-class">documentation</a>.</p> 
buckets[].<br>versioning | **string**<br><p>Bucket versioning status. For details, see <a href="/docs/storage/concepts/versioning">documentation</a>.</p> <ul> <li> <p>VERSIONING_DISABLED: The bucket is unversioned, i.e. versioning has never been enabled for the bucket, including at its creation. Objects that are stored in the bucket have a version ID of ``null``.</p> <p>To enable versioning, change status to ``VERSIONING_ENABLED`` via a <a href="/docs/storage/api-ref/Bucket/update">update</a> request. Note that this action is irreversible, and a bucket with versioning enabled can never return to ``VERSIONING_DISABLED`` state.</p> </li> <li> <p>VERSIONING_ENABLED: Bucket versioning is enabled, i.e. all new objects are versioned and given a unique version ID, and objects that already existed at the time versioning was enabled will be versioned and given a unique version ID when modified by future requests.</p> <p>To suspend versioning, change status to ``VERSIONING_SUSPENDED`` via a <a href="/docs/storage/api-ref/Bucket/update">update</a> request. You cannot disable versioning altogether for a bucket that already had it enabled; objects that had version IDs will keep them.</p> </li> <li> <p>VERSIONING_SUSPENDED: Bucket versioning is suspended, i.e. new objects are not versioned, but objects that already existed at the time versioning was suspended are still versioned and keep their version IDs.</p> <p>To resume versioning, change status to ``VERSIONING_ENABLED`` via a <a href="/docs/storage/api-ref/Bucket/update">update</a> request.</p> </li> </ul> 
buckets[].<br>maxSize | **string** (int64)<br><p>Maximum size of the bucket, in bytes. For details, see <a href="/docs/storage/operations/buckets/limit-max-volume">documentation</a>.</p> 
buckets[].<br>policy | **object**<br><p>Bucket policies that set permissions for actions with the bucket, its objects, and groups of objects. For details, see <a href="/docs/storage/concepts/policy">documentation</a>.</p> 
buckets[].<br>acl | **object**<br><p>Access control list (ACL) of the bucket. For details, see <a href="/docs/storage/concepts/acl">documentation</a>.</p> 
buckets[].<br>acl.<br>grants[] | **object**<br><p>List of permissions granted and the grantees.</p> 
buckets[].<br>acl.<br>grants[].<br>permission | **string**<br><p>Required. Permission granted by the grant.</p> <ul> <li> <p>PERMISSION_FULL_CONTROL: Allows grantee the ``PERMISSION_WRITE``, ``PERMISSION_WRITE_ACP``, ``PERMISSION_READ``, and ``PERMISSION_READ_ACP`` on the bucket.</p> <p>Maps to ``x-amz-grant-full-control`` header for <a href="/docs/storage/s3/api-ref/acl/bucketput">bucketPutAcl</a> method of Amazon S3-compatible HTTP API.</p> </li> <li> <p>PERMISSION_WRITE: Allows grantee to create new objects in the bucket. For the bucket and object owners of existing objects, also allows deletions and overwrites of those objects.</p> <p>Maps to ``x-amz-grant-write`` header for <a href="/docs/storage/s3/api-ref/acl/bucketput">bucketPutAcl</a> method of Amazon S3-compatible HTTP API.</p> </li> <li> <p>PERMISSION_WRITE_ACP: Allows grantee to write the ACL for the bucket.</p> <p>Maps to ``x-amz-grant-write-acp`` header for <a href="/docs/storage/s3/api-ref/acl/bucketput">bucketPutAcl</a> method of Amazon S3-compatible HTTP API.</p> </li> <li> <p>PERMISSION_READ: Allows grantee to list the objects in the bucket.</p> <p>Maps to ``x-amz-grant-read`` header for <a href="/docs/storage/s3/api-ref/acl/bucketput">bucketPutAcl</a> method of Amazon S3-compatible HTTP API.</p> </li> <li> <p>PERMISSION_READ_ACP: Allows grantee to read the bucket ACL</p> <p>Maps to ``x-amz-grant-read-acp`` header for <a href="/docs/storage/s3/api-ref/acl/bucketput">bucketPutAcl</a> method of Amazon S3-compatible HTTP API.</p> </li> </ul> 
buckets[].<br>acl.<br>grants[].<br>grantType | **string**<br><p>Required. The grantee type for the grant.</p> <ul> <li> <p>GRANT_TYPE_ACCOUNT: A grantee is an <a href="/docs/iam/concepts/#accounts">account on the platform</a>.</p> <p>For this grantee type, you need to specify the user ID in <a href="/docs/storage/api-ref/Bucket#representation">Bucket.acl.grants.granteeId</a> field. To get user ID, see <a href="/docs/iam/operations/users/get">instruction</a>.</p> <p>Maps to using ``id="*"`` value for ``x-amz-grant-*`` header (<a href="/docs/storage/s3/api-ref/acl/bucketput">bucketPutAcl</a> method of Amazon S3-compatible HTTP API).</p> </li> <li> <p>GRANT_TYPE_ALL_AUTHENTICATED_USERS: Grantees are all authenticated users, both from your clouds and other users' clouds. Access permission to this group allows any account on the platform to access the resource via a signed (authenticated) request.</p> <p>Maps to using ``uri="http://acs.amazonaws.com/groups/global/AuthenticatedUsers"`` value for ``x-amz-grant-*`` header (<a href="/docs/storage/s3/api-ref/acl/bucketput">bucketPutAcl</a> method of Amazon S3-compatible HTTP API).</p> </li> <li> <p>GRANT_TYPE_ALL_USERS: Grantees are all internet users. Access permission to this group allows anyone in the world access to the resource via signed (authenticated) or unsigned (anonymous) requests.</p> <p>Maps to using ``uri="http://acs.amazonaws.com/groups/global/AllUsers"`` value for ``x-amz-grant-*`` header (<a href="/docs/storage/s3/api-ref/acl/bucketput">bucketPutAcl</a> method of Amazon S3-compatible HTTP API).</p> </li> </ul> 
buckets[].<br>acl.<br>grants[].<br>granteeId | **string**<br><p>ID of the account who is a grantee. Required when the ``grantType`` is ``GRANT_TYPE_ACCOUNT``.</p> 
buckets[].<br>createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
buckets[].<br>cors[] | **object**<br><p>List of rules for cross-domain requests to objects in the bucket (cross-origin resource sharing, CORS). For details, see <a href="/docs/storage/concepts/cors">documentation</a>.</p> 
buckets[].<br>cors[].<br>id | **string**<br><p>ID of the CORS rule.</p> 
buckets[].<br>cors[].<br>allowedMethods[] | **string**<br><p>Required. List of HTTP methods allowed by the CORS rule.</p> <p>When a client sends a CORS-preflight ``options`` request with the ``Access-Control-Request-Method`` header (see <a href="/docs/storage/s3/api-ref/object/options">S3-compatible API reference</a>), the specified method is checked against the list of the allowed methods. If there is a match, all the allowed methods are listed in the ``Access-Control-Allow-Methods`` header of the response.</p> <p>Must contain at least one element.</p> <ul> <li>METHOD_GET: HTTP ``GET`` method.</li> <li>METHOD_HEAD: HTTP ``HEAD`` method.</li> <li>METHOD_POST: HTTP ``POST`` method.</li> <li>METHOD_PUT: HTTP ``PUT`` method.</li> <li>METHOD_DELETE: HTTP ``DELETE`` method.</li> </ul> 
buckets[].<br>cors[].<br>allowedHeaders[] | **string**<br><p>List of HTTP headers allowed by the CORS rule.</p> <p>When a client sends a CORS-preflight ``options`` request with the ``Access-Control-Request-Headers`` header (see <a href="/docs/storage/s3/api-ref/object/options">S3-compatible API reference</a>), the specified headers are checked against the list of the allowed headers. If there is a match, the specified headers that are allowed are listed in the ``Access-Control-Allow-Headers`` header of the response.</p> <p>Each string in the list can contain at most one ``*`` wildcard character that matches 0 or more characters. For example, ``x-amz-*`` value will allow all Amazon S3-compatible headers.</p> 
buckets[].<br>cors[].<br>allowedOrigins[] | **string**<br><p>Required. List of request origins allowed by the CORS rule.</p> <p>Each string in the list can contain at most one ``*`` wildcard character that matches 0 or more characters. For example, ``http://*.example.com`` value will allow requests originating from all subdomains of ``example.com``.</p> <p>Must contain at least one element.</p> 
buckets[].<br>cors[].<br>exposeHeaders[] | **string**<br><p>List of headers contained in responses to CORS requests that can be accessed by applications.</p> 
buckets[].<br>cors[].<br>maxAgeSeconds | **integer** (int64)<br><p>Time in seconds that a client can cache the response to a CORS-preflight request as identified by the object requested, the HTTP method, and the origin.</p> 
buckets[].<br>websiteSettings | **object**<br><p>Configuration for hosting a static website in the bucket. For details, see <a href="/docs/storage/concepts/hosting">documentation</a>.</p> 
buckets[].<br>websiteSettings.<br>index | **string**<br><p>Key of the index page object that is returned when a response is made to the root of the website.</p> <p>Either ``index`` or ``redirectAllRequests`` must be specified in order for the bucket to host a static website.</p> <p>If specified, the index page object must be located in the root of the bucket.</p> 
buckets[].<br>websiteSettings.<br>error | **string**<br><p>Key of the error page object that is returned when an error occurs.</p> 
buckets[].<br>websiteSettings.<br>redirectAllRequests | **object**<br><p>Configuration for redirecting all requests sent to the website.</p> <p>Either ``redirectAllRequests`` or ``index`` must be specified in order for the bucket to host a static website. If ``redirectAllRequests`` is specified, it must be the only field in <a href="/docs/storage/api-ref/Bucket#representation">Bucket.websiteSettings</a>.</p> <p>A configuration resource for redirecting all requests sent to the website.</p> 
buckets[].<br>websiteSettings.<br>redirectAllRequests.<br>protocol | **string**<br><p>Scheme of the redirect URI.</p> <ul> <li>PROTOCOL_HTTP: ``http`` scheme.</li> <li>PROTOCOL_HTTPS: ``https`` scheme.</li> </ul> 
buckets[].<br>websiteSettings.<br>redirectAllRequests.<br>hostname | **string**<br><p>Hostname of the redirect URI.</p> 
buckets[].<br>websiteSettings.<br>routingRules[] | **object**<br><p>List of redirect rules.</p> 
buckets[].<br>websiteSettings.<br>routingRules[].<br>condition | **object**<br><p>Redirect condition.</p> 
buckets[].<br>websiteSettings.<br>routingRules[].<br>condition.<br>httpErrorCodeReturnedEquals | **string**<br><p>HTTP status code (number only) that must match for the redirect to apply.</p> 
buckets[].<br>websiteSettings.<br>routingRules[].<br>condition.<br>keyPrefixEquals | **string**<br><p>Prefix of the object key from which requests are redirected.</p> 
buckets[].<br>websiteSettings.<br>routingRules[].<br>redirect | **object**<br><p>Redirect instructions.</p> 
buckets[].<br>websiteSettings.<br>routingRules[].<br>redirect.<br>hostname | **string**<br><p>Hostname of the redirect URI.</p> 
buckets[].<br>websiteSettings.<br>routingRules[].<br>redirect.<br>httpRedirectCode | **string**<br><p>HTTP status code of the redirect response.</p> <p>Default value: ``"301"``.</p> <p>Value must match the regular expression ``3(0[1-9]\|[1-9][0-9])``.</p> 
buckets[].<br>websiteSettings.<br>routingRules[].<br>redirect.<br>protocol | **string**<br><p>Scheme of the redirect URI.</p> <ul> <li>PROTOCOL_HTTP: ``http`` scheme.</li> <li>PROTOCOL_HTTPS: ``https`` scheme.</li> </ul> 
buckets[].<br>websiteSettings.<br>routingRules[].<br>redirect.<br>replaceKeyPrefixWith | **string**<br><p>Substitution for the prefix of the object key specified in ``keyPrefixEquals``.</p> <p>At most one of ``replaceKeyPrefixWith`` and ``replaceKeyWith`` can be specified.</p> 
buckets[].<br>websiteSettings.<br>routingRules[].<br>redirect.<br>replaceKeyWith | **string**<br><p>New object key.</p> <p>At most one of ``replaceKeyWith`` and ``replaceKeyPrefixWith`` can be specified.</p> 
buckets[].<br>lifecycleRules[] | **object**<br><p>List of object lifecycle rules for the bucket. For details, see <a href="/docs/storage/concepts/lifecycles">documentation</a>.</p> 
buckets[].<br>lifecycleRules[].<br>id | **string**<br><p>ID of the rule. Provided by the client or generated at creation time.</p> 
buckets[].<br>lifecycleRules[].<br>enabled | **boolean** (boolean)<br><p>Indicates whether the rule is in effect.</p> 
buckets[].<br>lifecycleRules[].<br>filter | **object**<br><p>Filter that identifies the objects to which the rule applies.</p> <p>If not specified, the rule applies to all objects in the bucket.</p> 
buckets[].<br>lifecycleRules[].<br>filter.<br>prefix | **string**<br><p>Key prefix that the object must have in order for the rule to apply.</p> 
buckets[].<br>lifecycleRules[].<br>filter.<br>objectSizeGreaterThan | **integer** (int64)<br><p>Size that the object must be greater.</p> 
buckets[].<br>lifecycleRules[].<br>filter.<br>objectSizeLessThan | **integer** (int64)<br><p>Size that the object must be less t.</p> 
buckets[].<br>lifecycleRules[].<br>expiration | **object**<br><p>Expiration rule.</p> <p>The expiration of an object is described as follows.</p> <p>For the unversioned bucket (<a href="/docs/storage/api-ref/Bucket#representation">Bucket.versioning</a> is ``VERSIONING_DISABLED``), the object is deleted and cannot be recovered.</p> <p>For the bucket with versioning enabled (<a href="/docs/storage/api-ref/Bucket#representation">Bucket.versioning</a> is ``VERSIONING_ENABLED``), the current version of the object (if it exists and is not a delete marker) is retained as a non-current version, and a delete marker becomes the current version of the object.</p> <p>For the bucket with versioning suspended (<a href="/docs/storage/api-ref/Bucket#representation">Bucket.versioning</a> is ``VERSIONING_SUSPENDED``), the current version of the object is retained as a non-current version if it is not a delete marker, or is removed otherwise, and a delete marker becomes the current version of the object.</p> 
buckets[].<br>lifecycleRules[].<br>expiration.<br>date | **string** (date-time)<br><p>Specific date of object expiration.</p> <p>The rule continues to apply even after the date has passed, i.e. any new objects created in the bucket expire immediately.</p> <p>Exactly one of ``date``, ``days``, and ``expiredObjectDeleteMarker`` fields can be specified.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
buckets[].<br>lifecycleRules[].<br>expiration.<br>days | **integer** (int64)<br><p>Time period, in number of days from the creation or modification of the object, after which an object expires.</p> <p>Exactly one of ``days``, ``date``, and ``expiredObjectDeleteMarker`` fields can be specified.</p> 
buckets[].<br>lifecycleRules[].<br>expiration.<br>expiredObjectDeleteMarker | **boolean** (boolean)<br><p>Indicates whether a delete marker of an object with no non-current versions (referred to as an expired object delete marker) is removed at the object's expiration.</p> <p>Exactly one of ``expiredObjectDeleteMarker``, ``date``, and ``days`` fields can be specified.</p> 
buckets[].<br>lifecycleRules[].<br>transitions[] | **object**<br><p>List of transition rules.</p> <p>The transition of an object is described as follows.</p> <p>For the unversioned bucket (<a href="/docs/storage/api-ref/Bucket#representation">Bucket.versioning</a> is ``VERSIONING_DISABLED``), the object is transitioned to the specified storage class.</p> <p>For the bucket with versioning enabled (<a href="/docs/storage/api-ref/Bucket#representation">Bucket.versioning</a> is ``VERSIONING_ENABLED``) or suspended (``VERSIONING_SUSPENDED``), the current version of the object is transitioned to the specified storage class.</p> 
buckets[].<br>lifecycleRules[].<br>transitions[].<br>date | **string** (date-time)<br><p>Specific date of object transition.</p> <p>The rule continues to apply even after the date has passed, i.e. any new objects created in the bucket are transitioned immediately.</p> <p>At most one of ``date`` and ``days`` fields can be specified.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
buckets[].<br>lifecycleRules[].<br>transitions[].<br>days | **integer** (int64)<br><p>Time period, in number of days from the creation or modification of the object, after which an object is transitioned.</p> <p>At most one of ``days`` and ``date`` fields can be specified.</p> 
buckets[].<br>lifecycleRules[].<br>transitions[].<br>storageClass | **string**<br><p>Required. Storage class to which an object is transitioned from standard storage.</p> <p>The only supported class is cold storage (``COLD``, ``STANDARD_IA``, ``NEARLINE`` all synonyms). Transitions from cold to standard storage and transitions to or from ice storage are not allowed.</p> 
buckets[].<br>lifecycleRules[].<br>abortIncompleteMultipartUpload | **object**<br><p>Configuration for aborting incomplete <a href="/docs/storage/concepts/multipart">multipart uploads</a>.</p> 
buckets[].<br>lifecycleRules[].<br>abortIncompleteMultipartUpload.<br>daysAfterExpiration | **integer** (int64)<br><p>Time period, in number of days from the start of the multipart upload, after which the incomplete upload is aborted.</p> 
buckets[].<br>lifecycleRules[].<br>noncurrentExpiration | **object**<br><p>Expiration rule for non-current versions of objects in a bucket with versioning enabled (<a href="/docs/storage/api-ref/Bucket#representation">Bucket.versioning</a> is ``VERSIONING_ENABLED``) or suspended (``VERSIONING_SUSPENDED``).</p> <p>At expiration, the non-current version of the object is deleted and cannot be recovered.</p> 
buckets[].<br>lifecycleRules[].<br>noncurrentExpiration.<br>noncurrentDays | **integer** (int64)<br><p>Time period, in number of days since the version of an object was classified as non-current, after which the version expires.</p> 
buckets[].<br>lifecycleRules[].<br>noncurrentTransitions[] | **object**<br><p>List of transition rules for non-current versions of objects in a bucket with versioning enabled (<a href="/docs/storage/api-ref/Bucket#representation">Bucket.versioning</a> is ``VERSIONING_ENABLED``) or suspended (``VERSIONING_SUSPENDED``).</p> <p>At transition, the non-current version of the object is transitioned to the specified storage class.</p> 
buckets[].<br>lifecycleRules[].<br>noncurrentTransitions[].<br>noncurrentDays | **integer** (int64)<br><p>Time period, in number of days since the version of an object was classified as non-current, after which the version is transitioned.</p> 
buckets[].<br>lifecycleRules[].<br>noncurrentTransitions[].<br>storageClass | **string**<br><p>Required. Storage class to which a non-current version of an object is transitioned from standard storage.</p> <p>The only supported class is cold storage (``COLD``, ``STANDARD_IA``, ``NEARLINE`` all synonyms). Transitions from cold to standard storage and transitions to or from ice storage are not allowed.</p> 
buckets[].<br>tags[] | **object**<br><p>List of object tag for the bucket. TODO: documentation details.</p> 
buckets[].<br>tags[].<br>key | **string**
buckets[].<br>tags[].<br>value | **string**
buckets[].<br>objectLock | **object**<br><p>Configuration for object lock on the bucket. For details about the concept, see <a href="/docs/storage/concepts/object-lock">documentation</a>.</p> <p>A resource for Object Lock configuration of a bucket. For details about the concept, see <a href="/docs/storage/concepts/object-lock">documentation</a>.</p> 
buckets[].<br>objectLock.<br>status | **string**<br><p>Activity status of the object lock settings on the bucket</p> 
buckets[].<br>objectLock.<br>defaultRetention | **object**<br><p>Default lock configuration for added objects</p> 
buckets[].<br>objectLock.<br>defaultRetention.<br>mode | **string**<br><p>Lock type</p> 
buckets[].<br>objectLock.<br>defaultRetention.<br>days | **string** (int64) <br>`buckets[].objectLock.defaultRetention` includes only one of the fields `days`, `years`<br><br><p>Number of days for locking</p> 
buckets[].<br>objectLock.<br>defaultRetention.<br>years | **string** (int64) <br>`buckets[].objectLock.defaultRetention` includes only one of the fields `days`, `years`<br><br><p>Number of years for locking</p> 