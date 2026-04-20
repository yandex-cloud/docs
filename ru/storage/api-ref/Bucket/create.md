---
editable: false
apiPlayground:
  - url: https://storage.{{ api-host }}/storage/v1/buckets
    method: post
    path: null
    query: null
    body:
      type: object
      properties:
        name:
          description: |-
            **string**
            Required field. Name of the bucket.
            The name must be unique within the platform. For naming limitations and rules, see
            [documentation](/docs/storage/concepts/bucket#naming).
          type: string
        folderId:
          description: |-
            **string**
            Required field. ID of the folder to create a bucket in.
            To get the folder ID, make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/Folder/list#List) request.
            The maximum string length in characters is 50.
          type: string
        defaultStorageClass:
          description: |-
            **string**
            Default storage class for objects in the bucket. Supported classes are standard storage (`STANDARD`), cold storage
            (`COLD`, `STANDARD_IA`, `NEARLINE` all synonyms), and ice storage (`ICE` and `GLACIER` are synonyms).
            For details, see [documentation](/docs/storage/concepts/storage-class).
          type: string
        maxSize:
          description: |-
            **string** (int64)
            Maximum size of the bucket.
            For details, see [documentation](/docs/storage/operations/buckets/limit-max-volume).
          type: string
          format: int64
        anonymousAccessFlags:
          description: |-
            **[AnonymousAccessFlags](#yandex.cloud.storage.v1.AnonymousAccessFlags)**
            Flags for configuring public (anonymous) access to the bucket's content and settings.
            For details, see [documentation](/docs/storage/concepts/bucket#bucket-access).
          $ref: '#/definitions/AnonymousAccessFlags'
        acl:
          description: |-
            **[ACL](#yandex.cloud.storage.v1.ACL)**
            Access control list (ACL) of the bucket.
            For details, see [documentation](/docs/storage/concepts/acl).
          $ref: '#/definitions/ACL'
        tags:
          description: |-
            **[Tag](#yandex.cloud.storage.v1.Tag)**
            List of tags for the bucket.
            For details, see [documentation](/docs/resource-manager/concepts/labels).
          type: array
          items:
            $ref: '#/definitions/Tag'
        encryption:
          description: |-
            **[Encryption](#yandex.cloud.storage.v1.Encryption)**
            Configuration for bucket's encryption.
            For details, see [documentation](/docs/storage/concepts/encryption).
          $ref: '#/definitions/Encryption'
        versioning:
          description: |-
            **enum** (Versioning)
            Bucket versioning status.
            For details, see [documentation](/docs/storage/concepts/versioning).
            - `VERSIONING_DISABLED`: The bucket is unversioned, i.e. versioning has never been enabled for the bucket, including at its creation.
            Objects that are stored in the bucket have a version ID of `null`.
            To enable versioning, change status to `VERSIONING_ENABLED` via a [BucketService.Update](/docs/storage/api-ref/Bucket/update#Update) request. Note that this
            action is irreversible, and a bucket with versioning enabled can never return to `VERSIONING_DISABLED` state.
            - `VERSIONING_ENABLED`: Bucket versioning is enabled, i.e. all new objects are versioned and given a unique version ID, and objects that
            already existed at the time versioning was enabled will be versioned and given a unique version ID when modified
            by future requests.
            To suspend versioning, change status to `VERSIONING_SUSPENDED` via a [BucketService.Update](/docs/storage/api-ref/Bucket/update#Update) request. You cannot
            disable versioning altogether for a bucket that already had it enabled; objects that had version IDs will keep
            them.
            - `VERSIONING_SUSPENDED`: Bucket versioning is suspended, i.e. new objects are not versioned, but objects that already existed at the time
            versioning was suspended are still versioned and keep their version IDs.
            To resume versioning, change status to `VERSIONING_ENABLED` via a [BucketService.Update](/docs/storage/api-ref/Bucket/update#Update) request.
          type: string
          enum:
            - VERSIONING_UNSPECIFIED
            - VERSIONING_DISABLED
            - VERSIONING_ENABLED
            - VERSIONING_SUSPENDED
        allowedPrivateEndpoints:
          description: |-
            **[BucketAllowedPrivateEndpoints](#yandex.cloud.storage.v1.BucketAllowedPrivateEndpoints)**
            Configuration for bucket's allowed private endpoints.
            requires permission s3:PutBucketAllowedPrivateEndpoints
          $ref: '#/definitions/BucketAllowedPrivateEndpoints'
        disabledStatickeyAuth:
          description: |-
            **boolean**
            An option to disable static key auth for a bucket.
            requires permission s3:UpdateBucketStaticKeyAuthSettings
          type: boolean
      required:
        - name
        - folderId
      additionalProperties: false
    definitions:
      AnonymousAccessFlags:
        type: object
        properties:
          read:
            description: |-
              **boolean**
              Specifies whether public (anonymous) access to read objects in the bucket is enabled.
            type: boolean
          list:
            description: |-
              **boolean**
              Specifies whether public (anonymous) access to the list of objects in the bucket is enabled.
            type: boolean
          configRead:
            description: |-
              **boolean**
              Specifies whether public (anonymous) access to read [CORS](/docs/storage/concepts/cors),
              [static website hosting](/docs/storage/concepts/hosting), and
              [object lifecycles](/docs/storage/concepts/lifecycles) settings of the bucket is enabled.
            type: boolean
      Grant:
        type: object
        properties:
          permission:
            description: |-
              **enum** (Permission)
              Required field. Permission granted by the grant.
              - `PERMISSION_FULL_CONTROL`: Allows grantee the `PERMISSION_WRITE`, `PERMISSION_WRITE_ACP`, `PERMISSION_READ`, and `PERMISSION_READ_ACP`
              on the bucket.
              Maps to `x-amz-grant-full-control` header for [bucketPutAcl](/docs/storage/s3/api-ref/acl/bucketput) method of
              Amazon S3-compatible HTTP API.
              - `PERMISSION_WRITE`: Allows grantee to create new objects in the bucket. For the bucket and object owners of existing objects, also
              allows deletions and overwrites of those objects.
              Maps to `x-amz-grant-write` header for [bucketPutAcl](/docs/storage/s3/api-ref/acl/bucketput) method of Amazon
              S3-compatible HTTP API.
              - `PERMISSION_WRITE_ACP`: Allows grantee to write the ACL for the bucket.
              Maps to `x-amz-grant-write-acp` header for [bucketPutAcl](/docs/storage/s3/api-ref/acl/bucketput) method of
              Amazon S3-compatible HTTP API.
              - `PERMISSION_READ`: Allows grantee to list the objects in the bucket.
              Maps to `x-amz-grant-read` header for [bucketPutAcl](/docs/storage/s3/api-ref/acl/bucketput) method of Amazon
              S3-compatible HTTP API.
              - `PERMISSION_READ_ACP`: Allows grantee to read the bucket ACL
              Maps to `x-amz-grant-read-acp` header for [bucketPutAcl](/docs/storage/s3/api-ref/acl/bucketput) method of
              Amazon S3-compatible HTTP API.
            type: string
            enum:
              - PERMISSION_UNSPECIFIED
              - PERMISSION_FULL_CONTROL
              - PERMISSION_WRITE
              - PERMISSION_WRITE_ACP
              - PERMISSION_READ
              - PERMISSION_READ_ACP
          grantType:
            description: |-
              **enum** (GrantType)
              Required field. The grantee type for the grant.
              - `GRANT_TYPE_ACCOUNT`: A grantee is an [account on the platform](/docs/iam/concepts/#accounts).
              For this grantee type, you need to specify the user ID in [Bucket.acl.grants.granteeId](#yandex.cloud.storage.v1.ACL.Grant) field. To get user ID, see
              [instruction](/docs/iam/operations/users/get).
              Maps to using `id="*"` value for `x-amz-grant-*` header ([bucketPutAcl](/docs/storage/s3/api-ref/acl/bucketput)
              method of Amazon S3-compatible HTTP API).
              - `GRANT_TYPE_ALL_AUTHENTICATED_USERS`: Grantees are all authenticated users, both from your clouds and other users' clouds. Access
              permission to this group allows any account on the platform to access the resource via a signed (authenticated)
              request.
              Maps to using `uri="http://acs.amazonaws.com/groups/global/AuthenticatedUsers"` value for `x-amz-grant-*`
              header ([bucketPutAcl](/docs/storage/s3/api-ref/acl/bucketput) method of Amazon S3-compatible HTTP API).
              - `GRANT_TYPE_ALL_USERS`: Grantees are all internet users. Access permission to this group allows anyone in the world access to the
              resource via signed (authenticated) or unsigned (anonymous) requests.
              Maps to using `uri="http://acs.amazonaws.com/groups/global/AllUsers"` value for `x-amz-grant-*` header
              ([bucketPutAcl](/docs/storage/s3/api-ref/acl/bucketput) method of Amazon S3-compatible HTTP API).
            type: string
            enum:
              - GRANT_TYPE_UNSPECIFIED
              - GRANT_TYPE_ACCOUNT
              - GRANT_TYPE_ALL_AUTHENTICATED_USERS
              - GRANT_TYPE_ALL_USERS
          granteeId:
            description: |-
              **string**
              ID of the account who is a grantee. Required when the [grantType](#yandex.cloud.storage.v1.ACL.Grant) is `GRANT_TYPE_ACCOUNT`.
              The maximum string length in characters is 50.
            type: string
        required:
          - permission
          - grantType
      ACL:
        type: object
        properties:
          grants:
            description: |-
              **[Grant](#yandex.cloud.storage.v1.ACL.Grant)**
              List of permissions granted and the grantees.
            type: array
            items:
              $ref: '#/definitions/Grant'
      Tag:
        type: object
        properties:
          key:
            description: |-
              **string**
              Key of the bucket tag.
            type: string
          value:
            description: |-
              **string**
              Value of the bucket tag.
            type: string
      EncryptionRule:
        type: object
        properties:
          kmsMasterKeyId:
            description: |-
              **string**
              KMS master key ID
            type: string
          sseAlgorithm:
            description: |-
              **string**
              SSE algorithm
            type: string
      Encryption:
        type: object
        properties:
          rules:
            description: |-
              **[EncryptionRule](#yandex.cloud.storage.v1.Encryption.EncryptionRule)**
              Rules
            type: array
            items:
              $ref: '#/definitions/EncryptionRule'
      BucketAllowedPrivateEndpoints:
        type: object
        properties:
          enabled:
            description: |-
              **boolean**
              if true, private endpoints white list check is enabled
              even if private_endpoints list is empty
            type: boolean
          privateEndpoints:
            description: |-
              **string**
              white list of private endpoints bucket accessible from
            type: array
            items:
              type: string
          forceCloudConsoleAccess:
            description: |-
              **boolean**
              if true, cloud console will be able to access a bucket
              regardless of private_endpoints list
            type: boolean
---

# Object Storage API, REST: Bucket.Create

Creates a bucket in the specified folder.

## HTTP request

```
POST https://storage.{{ api-host }}/storage/v1/buckets
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
  "disabledStatickeyAuth": "boolean"
}
```

#|
||Field | Description ||
|| name | **string**

Required field. Name of the bucket.
The name must be unique within the platform. For naming limitations and rules, see
[documentation](/docs/storage/concepts/bucket#naming). ||
|| folderId | **string**

Required field. ID of the folder to create a bucket in.
To get the folder ID, make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/Folder/list#List) request.

The maximum string length in characters is 50. ||
|| defaultStorageClass | **string**

Default storage class for objects in the bucket. Supported classes are standard storage (`STANDARD`), cold storage
(`COLD`, `STANDARD_IA`, `NEARLINE` all synonyms), and ice storage (`ICE` and `GLACIER` are synonyms).
For details, see [documentation](/docs/storage/concepts/storage-class). ||
|| maxSize | **string** (int64)

Maximum size of the bucket.
For details, see [documentation](/docs/storage/operations/buckets/limit-max-volume). ||
|| anonymousAccessFlags | **[AnonymousAccessFlags](#yandex.cloud.storage.v1.AnonymousAccessFlags)**

Flags for configuring public (anonymous) access to the bucket's content and settings.
For details, see [documentation](/docs/storage/concepts/bucket#bucket-access). ||
|| acl | **[ACL](#yandex.cloud.storage.v1.ACL)**

Access control list (ACL) of the bucket.
For details, see [documentation](/docs/storage/concepts/acl). ||
|| tags[] | **[Tag](#yandex.cloud.storage.v1.Tag)**

List of tags for the bucket.
For details, see [documentation](/docs/resource-manager/concepts/labels). ||
|| encryption | **[Encryption](#yandex.cloud.storage.v1.Encryption)**

Configuration for bucket's encryption.
For details, see [documentation](/docs/storage/concepts/encryption). ||
|| versioning | **enum** (Versioning)

Bucket versioning status.
For details, see [documentation](/docs/storage/concepts/versioning).

- `VERSIONING_DISABLED`: The bucket is unversioned, i.e. versioning has never been enabled for the bucket, including at its creation.
Objects that are stored in the bucket have a version ID of `null`.
To enable versioning, change status to `VERSIONING_ENABLED` via a [BucketService.Update](/docs/storage/api-ref/Bucket/update#Update) request. Note that this
action is irreversible, and a bucket with versioning enabled can never return to `VERSIONING_DISABLED` state.
- `VERSIONING_ENABLED`: Bucket versioning is enabled, i.e. all new objects are versioned and given a unique version ID, and objects that
already existed at the time versioning was enabled will be versioned and given a unique version ID when modified
by future requests.
To suspend versioning, change status to `VERSIONING_SUSPENDED` via a [BucketService.Update](/docs/storage/api-ref/Bucket/update#Update) request. You cannot
disable versioning altogether for a bucket that already had it enabled; objects that had version IDs will keep
them.
- `VERSIONING_SUSPENDED`: Bucket versioning is suspended, i.e. new objects are not versioned, but objects that already existed at the time
versioning was suspended are still versioned and keep their version IDs.
To resume versioning, change status to `VERSIONING_ENABLED` via a [BucketService.Update](/docs/storage/api-ref/Bucket/update#Update) request. ||
|| allowedPrivateEndpoints | **[BucketAllowedPrivateEndpoints](#yandex.cloud.storage.v1.BucketAllowedPrivateEndpoints)**

Configuration for bucket's allowed private endpoints.
requires permission s3:PutBucketAllowedPrivateEndpoints ||
|| disabledStatickeyAuth | **boolean**

An option to disable static key auth for a bucket.
requires permission s3:UpdateBucketStaticKeyAuthSettings ||
|#

## AnonymousAccessFlags {#yandex.cloud.storage.v1.AnonymousAccessFlags}

#|
||Field | Description ||
|| read | **boolean**

Specifies whether public (anonymous) access to read objects in the bucket is enabled. ||
|| list | **boolean**

Specifies whether public (anonymous) access to the list of objects in the bucket is enabled. ||
|| configRead | **boolean**

Specifies whether public (anonymous) access to read [CORS](/docs/storage/concepts/cors),
[static website hosting](/docs/storage/concepts/hosting), and
[object lifecycles](/docs/storage/concepts/lifecycles) settings of the bucket is enabled. ||
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
Maps to `x-amz-grant-full-control` header for [bucketPutAcl](/docs/storage/s3/api-ref/acl/bucketput) method of
Amazon S3-compatible HTTP API.
- `PERMISSION_WRITE`: Allows grantee to create new objects in the bucket. For the bucket and object owners of existing objects, also
allows deletions and overwrites of those objects.
Maps to `x-amz-grant-write` header for [bucketPutAcl](/docs/storage/s3/api-ref/acl/bucketput) method of Amazon
S3-compatible HTTP API.
- `PERMISSION_WRITE_ACP`: Allows grantee to write the ACL for the bucket.
Maps to `x-amz-grant-write-acp` header for [bucketPutAcl](/docs/storage/s3/api-ref/acl/bucketput) method of
Amazon S3-compatible HTTP API.
- `PERMISSION_READ`: Allows grantee to list the objects in the bucket.
Maps to `x-amz-grant-read` header for [bucketPutAcl](/docs/storage/s3/api-ref/acl/bucketput) method of Amazon
S3-compatible HTTP API.
- `PERMISSION_READ_ACP`: Allows grantee to read the bucket ACL
Maps to `x-amz-grant-read-acp` header for [bucketPutAcl](/docs/storage/s3/api-ref/acl/bucketput) method of
Amazon S3-compatible HTTP API. ||
|| grantType | **enum** (GrantType)

Required field. The grantee type for the grant.

- `GRANT_TYPE_ACCOUNT`: A grantee is an [account on the platform](/docs/iam/concepts/#accounts).
For this grantee type, you need to specify the user ID in `Bucket.acl.grants.granteeId` field. To get user ID, see
[instruction](/docs/iam/operations/users/get).
Maps to using `id="*"` value for `x-amz-grant-*` header ([bucketPutAcl](/docs/storage/s3/api-ref/acl/bucketput)
method of Amazon S3-compatible HTTP API).
- `GRANT_TYPE_ALL_AUTHENTICATED_USERS`: Grantees are all authenticated users, both from your clouds and other users' clouds. Access
permission to this group allows any account on the platform to access the resource via a signed (authenticated)
request.
Maps to using `uri="http://acs.amazonaws.com/groups/global/AuthenticatedUsers"` value for `x-amz-grant-*`
header ([bucketPutAcl](/docs/storage/s3/api-ref/acl/bucketput) method of Amazon S3-compatible HTTP API).
- `GRANT_TYPE_ALL_USERS`: Grantees are all internet users. Access permission to this group allows anyone in the world access to the
resource via signed (authenticated) or unsigned (anonymous) requests.
Maps to using `uri="http://acs.amazonaws.com/groups/global/AllUsers"` value for `x-amz-grant-*` header
([bucketPutAcl](/docs/storage/s3/api-ref/acl/bucketput) method of Amazon S3-compatible HTTP API). ||
|| granteeId | **string**

ID of the account who is a grantee. Required when the `grantType` is `GRANT_TYPE_ACCOUNT`.

The maximum string length in characters is 50. ||
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

An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).

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