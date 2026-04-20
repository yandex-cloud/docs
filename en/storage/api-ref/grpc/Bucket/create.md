---
editable: false
---

# Object Storage API, gRPC: BucketService.Create

Creates a bucket in the specified folder.

## gRPC request

**rpc Create ([CreateBucketRequest](#yandex.cloud.storage.v1.CreateBucketRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## CreateBucketRequest {#yandex.cloud.storage.v1.CreateBucketRequest}

```json
{
  "name": "string",
  "folder_id": "string",
  "default_storage_class": "string",
  "max_size": "int64",
  "anonymous_access_flags": {
    "read": "google.protobuf.BoolValue",
    "list": "google.protobuf.BoolValue",
    "config_read": "google.protobuf.BoolValue"
  },
  "acl": {
    "grants": [
      {
        "permission": "Permission",
        "grant_type": "GrantType",
        "grantee_id": "string"
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
        "kms_master_key_id": "string",
        "sse_algorithm": "string"
      }
    ]
  },
  "versioning": "Versioning",
  "allowed_private_endpoints": {
    "enabled": "bool",
    "private_endpoints": [
      "string"
    ],
    "force_cloud_console_access": "bool"
  },
  "disabled_statickey_auth": "bool"
}
```

#|
||Field | Description ||
|| name | **string**

Required field. Name of the bucket.
The name must be unique within the platform. For naming limitations and rules, see
[documentation](/docs/storage/concepts/bucket#naming). ||
|| folder_id | **string**

Required field. ID of the folder to create a bucket in.
To get the folder ID, make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/Folder/list#List) request.

The maximum string length in characters is 50. ||
|| default_storage_class | **string**

Default storage class for objects in the bucket. Supported classes are standard storage (`STANDARD`), cold storage
(`COLD`, `STANDARD_IA`, `NEARLINE` all synonyms), and ice storage (`ICE` and `GLACIER` are synonyms).
For details, see [documentation](/docs/storage/concepts/storage-class). ||
|| max_size | **int64**

Maximum size of the bucket.
For details, see [documentation](/docs/storage/operations/buckets/limit-max-volume). ||
|| anonymous_access_flags | **[AnonymousAccessFlags](#yandex.cloud.storage.v1.AnonymousAccessFlags)**

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
|| versioning | enum **Versioning**

Bucket versioning status.
For details, see [documentation](/docs/storage/concepts/versioning).

- `VERSIONING_DISABLED`: The bucket is unversioned, i.e. versioning has never been enabled for the bucket, including at its creation.
Objects that are stored in the bucket have a version ID of `null`.
To enable versioning, change status to `VERSIONING_ENABLED` via a [BucketService.Update](/docs/storage/api-ref/grpc/Bucket/update#Update) request. Note that this
action is irreversible, and a bucket with versioning enabled can never return to `VERSIONING_DISABLED` state.
- `VERSIONING_ENABLED`: Bucket versioning is enabled, i.e. all new objects are versioned and given a unique version ID, and objects that
already existed at the time versioning was enabled will be versioned and given a unique version ID when modified
by future requests.
To suspend versioning, change status to `VERSIONING_SUSPENDED` via a [BucketService.Update](/docs/storage/api-ref/grpc/Bucket/update#Update) request. You cannot
disable versioning altogether for a bucket that already had it enabled; objects that had version IDs will keep
them.
- `VERSIONING_SUSPENDED`: Bucket versioning is suspended, i.e. new objects are not versioned, but objects that already existed at the time
versioning was suspended are still versioned and keep their version IDs.
To resume versioning, change status to `VERSIONING_ENABLED` via a [BucketService.Update](/docs/storage/api-ref/grpc/Bucket/update#Update) request. ||
|| allowed_private_endpoints | **[BucketAllowedPrivateEndpoints](#yandex.cloud.storage.v1.BucketAllowedPrivateEndpoints)**

Configuration for bucket's allowed private endpoints.
requires permission s3:PutBucketAllowedPrivateEndpoints ||
|| disabled_statickey_auth | **bool**

An option to disable static key auth for a bucket.
requires permission s3:UpdateBucketStaticKeyAuthSettings ||
|#

## AnonymousAccessFlags {#yandex.cloud.storage.v1.AnonymousAccessFlags}

#|
||Field | Description ||
|| read | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Specifies whether public (anonymous) access to read objects in the bucket is enabled. ||
|| list | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Specifies whether public (anonymous) access to the list of objects in the bucket is enabled. ||
|| config_read | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

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
|| permission | enum **Permission**

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
|| grant_type | enum **GrantType**

Required field. The grantee type for the grant.

- `GRANT_TYPE_ACCOUNT`: A grantee is an [account on the platform](/docs/iam/concepts/#accounts).
For this grantee type, you need to specify the user ID in `Bucket.acl.grants.grantee_id` field. To get user ID, see
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
|| grantee_id | **string**

ID of the account who is a grantee. Required when the `grant_type` is `GRANT_TYPE_ACCOUNT`.

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
|| kms_master_key_id | **string**

KMS master key ID ||
|| sse_algorithm | **string**

SSE algorithm ||
|#

## BucketAllowedPrivateEndpoints {#yandex.cloud.storage.v1.BucketAllowedPrivateEndpoints}

#|
||Field | Description ||
|| enabled | **bool**

if true, private endpoints white list check is enabled
even if private_endpoints list is empty ||
|| private_endpoints[] | **string**

white list of private endpoints bucket accessible from ||
|| force_cloud_console_access | **bool**

if true, cloud console will be able to access a bucket
regardless of private_endpoints list ||
|#

## operation.Operation {#yandex.cloud.operation.Operation}

```json
{
  "id": "string",
  "description": "string",
  "created_at": "google.protobuf.Timestamp",
  "created_by": "string",
  "modified_at": "google.protobuf.Timestamp",
  "done": "bool",
  "metadata": "google.protobuf.Any",
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": "google.protobuf.Any"
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
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| created_by | **string**

ID of the user or service account who initiated the operation. ||
|| modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**

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