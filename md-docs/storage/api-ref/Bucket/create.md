# Object Storage API, REST: Bucket.Create

Creates a bucket in the specified folder.

## HTTP request

```
POST https://storage.api.cloud.yandex.net/storage/v1/buckets
```

## Body parameters {#yandex.cloud.storage.v1.CreateBucketRequest}

```json
{
  "name": "string",
  "folderId": "string",
  "defaultStorageClass": "string",
  "maxSize": "string",
  "anonymousAccessFlags": {
    "read": "boolean",
    "list": "boolean",
    "configRead": "boolean"
  },
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
  "encryption": {
    "rules": [
      {
        "kmsMasterKeyId": "string",
        "sseAlgorithm": "string"
      }
    ]
  },
  "versioning": "string",
  "allowedPrivateEndpoints": {
    "enabled": "boolean",
    "privateEndpoints": [
      "string"
    ],
    "forceCloudConsoleAccess": "boolean"
  },
  "disabledStatickeyAuth": "boolean",
  "lifecycleRules": [
    {
      "id": "string",
      "enabled": "boolean",
      "filter": {
        "prefix": "string",
        "objectSizeGreaterThan": "string",
        "objectSizeLessThan": "string",
        "tag": {
          "key": "string",
          "value": "string"
        },
        "andOperator": {
          "prefix": "string",
          "objectSizeGreaterThan": "string",
          "objectSizeLessThan": "string",
          "tag": [
            {
              "key": "string",
              "value": "string"
            }
          ]
        }
      },
      "expiration": {
        "date": "string",
        "days": "string",
        "expiredObjectDeleteMarker": "boolean"
      },
      "transitions": [
        {
          "date": "string",
          "days": "string",
          "storageClass": "string"
        }
      ],
      "abortIncompleteMultipartUpload": {
        "daysAfterExpiration": "string"
      },
      "noncurrentExpiration": {
        "noncurrentDays": "string",
        "newerNoncurrentVersions": "string"
      },
      "noncurrentTransitions": [
        {
          "noncurrentDays": "string",
          "storageClass": "string",
          "newerNoncurrentVersions": "string"
        }
      ],
      "noncurrentDeleteMarkers": {
        "noncurrentDays": "string"
      }
    }
  ]
}
```

#|
||Field | Description ||
|| name | **string**

Required field. Name of the bucket.
The name must be unique within the platform. For naming limitations and rules, see
[documentation](../../concepts/bucket.md#naming). ||
|| folderId | **string**

Required field. ID of the folder to create a bucket in.
To get the folder ID, make a [yandex.cloud.resourcemanager.v1.FolderService.List](../../../resource-manager/api-ref/Folder/list.md#List) request.

The maximum string length in characters is 50. ||
|| defaultStorageClass | **string**

Default storage class for objects in the bucket. Supported classes are standard storage (`STANDARD`), cold storage
(`COLD`, `STANDARD_IA`, `NEARLINE` all synonyms), and ice storage (`ICE` and `GLACIER` are synonyms).
For details, see [documentation](../../concepts/storage-class.md). ||
|| maxSize | **string** (int64)

Maximum size of the bucket.
For details, see [documentation](../../operations/buckets/limit-max-volume.md). ||
|| anonymousAccessFlags | **[AnonymousAccessFlags](#yandex.cloud.storage.v1.AnonymousAccessFlags)**

Flags for configuring public (anonymous) access to the bucket's content and settings.
For details, see [documentation](../../concepts/bucket.md#bucket-access). ||
|| acl | **[ACL](#yandex.cloud.storage.v1.ACL)**

Access control list (ACL) of the bucket.
For details, see [documentation](../../concepts/acl.md). ||
|| tags[] | **[Tag](#yandex.cloud.storage.v1.Tag)**

List of tags for the bucket.
For details, see [documentation](../../../resource-manager/concepts/labels.md). ||
|| encryption | **[Encryption](#yandex.cloud.storage.v1.Encryption)**

Configuration for bucket's encryption.
For details, see [documentation](../../concepts/encryption.md). ||
|| versioning | **enum** (Versioning)

Bucket versioning status.
For details, see [documentation](../../concepts/versioning.md).

- `VERSIONING_DISABLED`: The bucket is unversioned, i.e. versioning has never been enabled for the bucket, including at its creation.
Objects that are stored in the bucket have a version ID of `null`.
To enable versioning, change status to `VERSIONING_ENABLED` via a [BucketService.Update](update.md#Update) request. Note that this
action is irreversible, and a bucket with versioning enabled can never return to `VERSIONING_DISABLED` state.
- `VERSIONING_ENABLED`: Bucket versioning is enabled, i.e. all new objects are versioned and given a unique version ID, and objects that
already existed at the time versioning was enabled will be versioned and given a unique version ID when modified
by future requests.
To suspend versioning, change status to `VERSIONING_SUSPENDED` via a [BucketService.Update](update.md#Update) request. You cannot
disable versioning altogether for a bucket that already had it enabled; objects that had version IDs will keep
them.
- `VERSIONING_SUSPENDED`: Bucket versioning is suspended, i.e. new objects are not versioned, but objects that already existed at the time
versioning was suspended are still versioned and keep their version IDs.
To resume versioning, change status to `VERSIONING_ENABLED` via a [BucketService.Update](update.md#Update) request. ||
|| allowedPrivateEndpoints | **[BucketAllowedPrivateEndpoints](#yandex.cloud.storage.v1.BucketAllowedPrivateEndpoints)**

Configuration for bucket's allowed private endpoints.
requires permission s3:PutBucketAllowedPrivateEndpoints ||
|| disabledStatickeyAuth | **boolean**

An option to disable static key auth for a bucket.
requires permission s3:UpdateBucketStaticKeyAuthSettings ||
|| lifecycleRules[] | **[LifecycleRule](#yandex.cloud.storage.v1.LifecycleRule)**

Configuration for bucket's lifecycle rules.
requires permission s3:PutLifecycleConfiguration ||
|#

## AnonymousAccessFlags {#yandex.cloud.storage.v1.AnonymousAccessFlags}

#|
||Field | Description ||
|| read | **boolean**

Specifies whether public (anonymous) access to read objects in the bucket is enabled. ||
|| list | **boolean**

Specifies whether public (anonymous) access to the list of objects in the bucket is enabled. ||
|| configRead | **boolean**

Specifies whether public (anonymous) access to read [CORS](../../concepts/cors.md),
[static website hosting](../../concepts/hosting.md), and
[object lifecycles](../../concepts/lifecycles.md) settings of the bucket is enabled. ||
|#

## ACL {#yandex.cloud.storage.v1.ACL}

#|
||Field | Description ||
|| grants[] | **[Grant](#yandex.cloud.storage.v1.ACL.Grant)**

List of permissions granted and the grantees. ||
|#

## Grant {#yandex.cloud.storage.v1.ACL.Grant}

A grant resource, used to specify the permission granted and the grantee.

#|
||Field | Description ||
|| permission | **enum** (Permission)

Required field. Permission granted by the grant.

- `PERMISSION_FULL_CONTROL`: Allows grantee the `PERMISSION_WRITE`, `PERMISSION_WRITE_ACP`, `PERMISSION_READ`, and `PERMISSION_READ_ACP`
on the bucket.
Maps to `x-amz-grant-full-control` header for [bucketPutAcl](../../s3/api-ref/acl/bucketput.md) method of
Amazon S3-compatible HTTP API.
- `PERMISSION_WRITE`: Allows grantee to create new objects in the bucket. For the bucket and object owners of existing objects, also
allows deletions and overwrites of those objects.
Maps to `x-amz-grant-write` header for [bucketPutAcl](../../s3/api-ref/acl/bucketput.md) method of Amazon
S3-compatible HTTP API.
- `PERMISSION_WRITE_ACP`: Allows grantee to write the ACL for the bucket.
Maps to `x-amz-grant-write-acp` header for [bucketPutAcl](../../s3/api-ref/acl/bucketput.md) method of
Amazon S3-compatible HTTP API.
- `PERMISSION_READ`: Allows grantee to list the objects in the bucket.
Maps to `x-amz-grant-read` header for [bucketPutAcl](../../s3/api-ref/acl/bucketput.md) method of Amazon
S3-compatible HTTP API.
- `PERMISSION_READ_ACP`: Allows grantee to read the bucket ACL
Maps to `x-amz-grant-read-acp` header for [bucketPutAcl](../../s3/api-ref/acl/bucketput.md) method of
Amazon S3-compatible HTTP API. ||
|| grantType | **enum** (GrantType)

Required field. The grantee type for the grant.

- `GRANT_TYPE_ACCOUNT`: A grantee is an [account on the platform](../../../iam/concepts/index.md#accounts).
For this grantee type, you need to specify the user ID in `Bucket.acl.grants.granteeId` field. To get user ID, see
[instruction](../../../organization/operations/users-get.md).
Maps to using `id="*"` value for `x-amz-grant-*` header ([bucketPutAcl](../../s3/api-ref/acl/bucketput.md)
method of Amazon S3-compatible HTTP API).
- `GRANT_TYPE_ALL_AUTHENTICATED_USERS`: Grantees are all authenticated users, both from your clouds and other users' clouds. Access
permission to this group allows any account on the platform to access the resource via a signed (authenticated)
request.
Maps to using `uri="http://acs.amazonaws.com/groups/global/AuthenticatedUsers"` value for `x-amz-grant-*`
header ([bucketPutAcl](../../s3/api-ref/acl/bucketput.md) method of Amazon S3-compatible HTTP API).
- `GRANT_TYPE_ALL_USERS`: Grantees are all internet users. Access permission to this group allows anyone in the world access to the
resource via signed (authenticated) or unsigned (anonymous) requests.
Maps to using `uri="http://acs.amazonaws.com/groups/global/AllUsers"` value for `x-amz-grant-*` header
([bucketPutAcl](../../s3/api-ref/acl/bucketput.md) method of Amazon S3-compatible HTTP API). ||
|| granteeId | **string**

ID of the account who is a grantee. Required when the `grantType` is `GRANT_TYPE_ACCOUNT`.

The maximum string length in characters is 100. ||
|#

## Tag {#yandex.cloud.storage.v1.Tag}

#|
||Field | Description ||
|| key | **string**

Key of the bucket tag. ||
|| value | **string**

Value of the bucket tag. ||
|#

## Encryption {#yandex.cloud.storage.v1.Encryption}

#|
||Field | Description ||
|| rules[] | **[EncryptionRule](#yandex.cloud.storage.v1.Encryption.EncryptionRule)**

Rules ||
|#

## EncryptionRule {#yandex.cloud.storage.v1.Encryption.EncryptionRule}

#|
||Field | Description ||
|| kmsMasterKeyId | **string**

KMS master key ID ||
|| sseAlgorithm | **string**

SSE algorithm ||
|#

## BucketAllowedPrivateEndpoints {#yandex.cloud.storage.v1.BucketAllowedPrivateEndpoints}

#|
||Field | Description ||
|| enabled | **boolean**

if true, private endpoints white list check is enabled
even if private_endpoints list is empty ||
|| privateEndpoints[] | **string**

white list of private endpoints bucket accessible from ||
|| forceCloudConsoleAccess | **boolean**

if true, cloud console will be able to access a bucket
regardless of private_endpoints list ||
|#

## LifecycleRule {#yandex.cloud.storage.v1.LifecycleRule}

An object lifecycle rule resource for the bucket.
For details about the concept, see [documentation](../../concepts/lifecycles.md).

#|
||Field | Description ||
|| id | **string**

ID of the rule. Provided by the client or generated at creation time. ||
|| enabled | **boolean**

Indicates whether the rule is in effect. ||
|| filter | **[RuleFilter](#yandex.cloud.storage.v1.LifecycleRule.RuleFilter)**

Filter that identifies the objects to which the rule applies.
If not specified, the rule applies to all objects in the bucket. ||
|| expiration | **[Expiration](#yandex.cloud.storage.v1.LifecycleRule.Expiration)**

Expiration rule.
The expiration of an object is described as follows.
For the unversioned bucket ([Bucket.versioning](list.md#yandex.cloud.storage.v1.Bucket) is `VERSIONING_DISABLED`), the object is deleted and cannot be
recovered.
For the bucket with versioning enabled ([Bucket.versioning](list.md#yandex.cloud.storage.v1.Bucket) is `VERSIONING_ENABLED`), the current version of the
object (if it exists and is not a delete marker) is retained as a non-current version, and a delete marker becomes
the current version of the object.
For the bucket with versioning suspended ([Bucket.versioning](list.md#yandex.cloud.storage.v1.Bucket) is `VERSIONING_SUSPENDED`), the current version of
the object is retained as a non-current version if it is not a delete marker, or is removed otherwise, and a
delete marker becomes the current version of the object. ||
|| transitions[] | **[Transition](#yandex.cloud.storage.v1.LifecycleRule.Transition)**

List of transition rules.
The transition of an object is described as follows.
For the unversioned bucket ([Bucket.versioning](list.md#yandex.cloud.storage.v1.Bucket) is `VERSIONING_DISABLED`), the object is transitioned to the
specified storage class.
For the bucket with versioning enabled ([Bucket.versioning](list.md#yandex.cloud.storage.v1.Bucket) is `VERSIONING_ENABLED`) or suspended
(`VERSIONING_SUSPENDED`), the current version of the object is transitioned to the specified storage class. ||
|| abortIncompleteMultipartUpload | **[AfterDays](#yandex.cloud.storage.v1.LifecycleRule.AfterDays)**

Configuration for aborting incomplete [multipart uploads](../../concepts/multipart.md). ||
|| noncurrentExpiration | **[NoncurrentExpiration](#yandex.cloud.storage.v1.LifecycleRule.NoncurrentExpiration)**

Expiration rule for non-current versions of objects in a bucket with versioning enabled ([Bucket.versioning](list.md#yandex.cloud.storage.v1.Bucket) is
`VERSIONING_ENABLED`) or suspended (`VERSIONING_SUSPENDED`).
At expiration, the non-current version of the object is deleted and cannot be recovered. ||
|| noncurrentTransitions[] | **[NoncurrentTransition](#yandex.cloud.storage.v1.LifecycleRule.NoncurrentTransition)**

List of transition rules for non-current versions of objects in a bucket with versioning enabled
([Bucket.versioning](list.md#yandex.cloud.storage.v1.Bucket) is `VERSIONING_ENABLED`) or suspended (`VERSIONING_SUSPENDED`).
At transition, the non-current version of the object is transitioned to the specified storage class. ||
|| noncurrentDeleteMarkers | **[NoncurrentDeleteMarkers](#yandex.cloud.storage.v1.LifecycleRule.NoncurrentDeleteMarkers)**

Expiration rule for non-current delete markers of an objects in a bucket with versioning
enabled ([Bucket.versioning](list.md#yandex.cloud.storage.v1.Bucket) is `VERSIONING_ENABLED`) or suspended (`VERSIONING_SUSPENDED`).
Works in the same way as noncurrent_expiration rule, but only for delete markers.
At expiration, the non-current delete marker of the object is deleted and cannot be recovered. ||
|#

## RuleFilter {#yandex.cloud.storage.v1.LifecycleRule.RuleFilter}

#|
||Field | Description ||
|| prefix | **string**

Key prefix that the object must have in order for the rule to apply. ||
|| objectSizeGreaterThan | **string** (int64)

Size that the object must be greater. ||
|| objectSizeLessThan | **string** (int64)

Size that the object must be less t. ||
|| tag | **[Tag](#yandex.cloud.storage.v1.Tag)**

Tags that the object's tag set must have for the rule to apply. ||
|| andOperator | **[And](#yandex.cloud.storage.v1.LifecycleRule.RuleFilter.And)**

Apply a logical AND to all of the predicates configured inside the And operator. ||
|#

## And {#yandex.cloud.storage.v1.LifecycleRule.RuleFilter.And}

#|
||Field | Description ||
|| prefix | **string**

Key prefix that the object must have in order for the rule to apply. ||
|| objectSizeGreaterThan | **string** (int64)

Size that the object must be greater. ||
|| objectSizeLessThan | **string** (int64)

Size that the object must be less than. ||
|| tag[] | **[Tag](#yandex.cloud.storage.v1.Tag)**

Tags that the object's tag set must have for the rule to apply. ||
|#

## Expiration {#yandex.cloud.storage.v1.LifecycleRule.Expiration}

#|
||Field | Description ||
|| date | **string** (date-time)

Specific date of object expiration.
The rule continues to apply even after the date has passed, i.e. any new objects created in the bucket expire
immediately.
Exactly one of `date`, `days`, and `expiredObjectDeleteMarker` fields can be specified.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| days | **string** (int64)

Time period, in number of days from the creation or modification of the object, after which an object expires.
Exactly one of `days`, `date`, and `expiredObjectDeleteMarker` fields can be specified. ||
|| expiredObjectDeleteMarker | **boolean**

Indicates whether a delete marker of an object with no non-current versions (referred to as an expired object
delete marker) is removed at the object's expiration.
Exactly one of `expiredObjectDeleteMarker`, `date`, and `days` fields can be specified. ||
|#

## Transition {#yandex.cloud.storage.v1.LifecycleRule.Transition}

List of transition rules.
The transition of an object is described as follows.
For the unversioned bucket ([Bucket.versioning](list.md#yandex.cloud.storage.v1.Bucket) is `VERSIONING_DISABLED`), the object is transitioned to the
specified storage class.
For the bucket with versioning enabled ([Bucket.versioning](list.md#yandex.cloud.storage.v1.Bucket) is `VERSIONING_ENABLED`) or suspended
(`VERSIONING_SUSPENDED`), the current version of the object is transitioned to the specified storage class.

#|
||Field | Description ||
|| date | **string** (date-time)

Specific date of object transition.
The rule continues to apply even after the date has passed, i.e. any new objects created in the bucket are
transitioned immediately.
At most one of `date` and `days` fields can be specified.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| days | **string** (int64)

Time period, in number of days from the creation or modification of the object, after which an object is
transitioned.
At most one of `days` and `date` fields can be specified. ||
|| storageClass | **string**

Required field. Storage class to which an object is transitioned from standard storage.
The only supported class is cold storage (`COLD`, `STANDARD_IA`, `NEARLINE` all synonyms). Transitions from cold
to standard storage and transitions to or from ice storage are not allowed. ||
|#

## AfterDays {#yandex.cloud.storage.v1.LifecycleRule.AfterDays}

#|
||Field | Description ||
|| daysAfterExpiration | **string** (int64)

Time period, in number of days from the start of the multipart upload, after which the incomplete upload is
aborted. ||
|#

## NoncurrentExpiration {#yandex.cloud.storage.v1.LifecycleRule.NoncurrentExpiration}

#|
||Field | Description ||
|| noncurrentDays | **string** (int64)

Time period, in number of days since the version of an object was classified as non-current, after which the
version expires. ||
|| newerNoncurrentVersions | **string** (int64)

Specifies how many noncurrent versions S3 will retain.
S3 will permanently delete any additional noncurrent versions beyond this specified number. ||
|#

## NoncurrentTransition {#yandex.cloud.storage.v1.LifecycleRule.NoncurrentTransition}

List of transition rules for non-current versions of objects in a bucket with versioning enabled
([Bucket.versioning](list.md#yandex.cloud.storage.v1.Bucket) is `VERSIONING_ENABLED`) or suspended (`VERSIONING_SUSPENDED`).
At transition, the non-current version of the object is transitioned to the specified storage class.

#|
||Field | Description ||
|| noncurrentDays | **string** (int64)

Time period, in number of days since the version of an object was classified as non-current, after which the
version is transitioned. ||
|| storageClass | **string**

Required field. Storage class to which a non-current version of an object is transitioned from standard storage.
The only supported class is cold storage (`COLD`, `STANDARD_IA`, `NEARLINE` all synonyms). Transitions from cold
to standard storage and transitions to or from ice storage are not allowed. ||
|| newerNoncurrentVersions | **string** (int64)

Specifies how many noncurrent versions S3 will retain.
S3 will permanently delete any additional noncurrent versions beyond this specified number. ||
|#

## NoncurrentDeleteMarkers {#yandex.cloud.storage.v1.LifecycleRule.NoncurrentDeleteMarkers}

#|
||Field | Description ||
|| noncurrentDays | **string** (int64)

Time period, in number of days since the version of a delete marker was classified as non-current, after which
the delete marker expires. ||
|#

## Response {#yandex.cloud.operation.Operation}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": "boolean",
  "metadata": "object",
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": "object"
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](../../../api-design-guide/concepts/operation.md).

#|
||Field | Description ||
|| id | **string**

ID of the operation. ||
|| description | **string**

Description of the operation. 0-256 characters long. ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **string** (date-time)

The time when the Operation resource was last modified.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| done | **boolean**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **object**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[Status](#google.rpc.Status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **object**

The normal response of the operation in case of success.
If the original method returns no data on success, such as Delete,
the response is [google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty).
If the original method is the standard Create/Update,
the response should be the target resource of the operation.
Any method that returns a long-running operation should document the response type, if any.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|#

## Status {#google.rpc.Status}

The error result of the operation in case of failure or cancellation.

#|
||Field | Description ||
|| code | **integer** (int32)

Error code. An enum value of [google.rpc.Code](https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto). ||
|| message | **string**

An error message. ||
|| details[] | **object**

A list of messages that carry the error details. ||
|#