---
editable: false
sourcePath: en/_api-ref-grpc/storage/v1/api-ref/grpc/Bucket/create.md
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
  ]
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

To get the folder ID, make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/Folder/list#List) request. ||
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

- `PERMISSION_UNSPECIFIED`
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

- `GRANT_TYPE_UNSPECIFIED`
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

ID of the account who is a grantee. Required when the `grant_type` is `GRANT_TYPE_ACCOUNT`. ||
|#

## Tag {#yandex.cloud.storage.v1.Tag}

#|
||Field | Description ||
|| key | **string**

Key of the bucket tag. ||
|| value | **string**

Value of the bucket tag. ||
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
  "metadata": {
    "name": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "string",
    "name": "string",
    "folder_id": "string",
    "anonymous_access_flags": {
      "read": "google.protobuf.BoolValue",
      "list": "google.protobuf.BoolValue",
      "config_read": "google.protobuf.BoolValue"
    },
    "default_storage_class": "string",
    "versioning": "Versioning",
    "max_size": "int64",
    "policy": "google.protobuf.Struct",
    "acl": {
      "grants": [
        {
          "permission": "Permission",
          "grant_type": "GrantType",
          "grantee_id": "string"
        }
      ]
    },
    "created_at": "google.protobuf.Timestamp",
    "cors": [
      {
        "id": "string",
        "allowed_methods": [
          "Method"
        ],
        "allowed_headers": [
          "string"
        ],
        "allowed_origins": [
          "string"
        ],
        "expose_headers": [
          "string"
        ],
        "max_age_seconds": "google.protobuf.Int64Value"
      }
    ],
    "website_settings": {
      "index": "string",
      "error": "string",
      "redirect_all_requests": {
        "protocol": "Protocol",
        "hostname": "string"
      },
      "routing_rules": [
        {
          "condition": {
            "http_error_code_returned_equals": "string",
            "key_prefix_equals": "string"
          },
          "redirect": {
            "hostname": "string",
            "http_redirect_code": "string",
            "protocol": "Protocol",
            "replace_key_prefix_with": "string",
            "replace_key_with": "string"
          }
        }
      ]
    },
    "lifecycle_rules": [
      {
        "id": "google.protobuf.StringValue",
        "enabled": "bool",
        "filter": {
          "prefix": "string",
          "object_size_greater_than": "google.protobuf.Int64Value",
          "object_size_less_than": "google.protobuf.Int64Value",
          "tag": {
            "key": "string",
            "value": "string"
          },
          "and_operator": {
            "prefix": "string",
            "object_size_greater_than": "google.protobuf.Int64Value",
            "object_size_less_than": "google.protobuf.Int64Value",
            "tag": [
              {
                "key": "string",
                "value": "string"
              }
            ]
          }
        },
        "expiration": {
          "date": "google.protobuf.Timestamp",
          "days": "google.protobuf.Int64Value",
          "expired_object_delete_marker": "google.protobuf.BoolValue"
        },
        "transitions": [
          {
            "date": "google.protobuf.Timestamp",
            "days": "google.protobuf.Int64Value",
            "storage_class": "string"
          }
        ],
        "abort_incomplete_multipart_upload": {
          "days_after_expiration": "google.protobuf.Int64Value"
        },
        "noncurrent_expiration": {
          "noncurrent_days": "google.protobuf.Int64Value"
        },
        "noncurrent_transitions": [
          {
            "noncurrent_days": "google.protobuf.Int64Value",
            "storage_class": "string"
          }
        ],
        "noncurrent_delete_markers": {
          "noncurrent_days": "google.protobuf.Int64Value"
        }
      }
    ],
    "tags": [
      {
        "key": "string",
        "value": "string"
      }
    ],
    "object_lock": {
      "status": "ObjectLockStatus",
      "default_retention": {
        "mode": "Mode",
        // Includes only one of the fields `days`, `years`
        "days": "int64",
        "years": "int64"
        // end of the list of possible fields
      }
    },
    "encryption": {
      "rules": [
        {
          "kms_master_key_id": "string",
          "sse_algorithm": "string"
        }
      ]
    },
    "allowed_private_endpoints": {
      "enabled": "bool",
      "private_endpoints": [
        "string"
      ]
    }
  }
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
|| metadata | **[CreateBucketMetadata](#yandex.cloud.storage.v1.CreateBucketMetadata)**

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
|| response | **[Bucket](#yandex.cloud.storage.v1.Bucket)**

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

## CreateBucketMetadata {#yandex.cloud.storage.v1.CreateBucketMetadata}

#|
||Field | Description ||
|| name | **string**

Name of the bucket that is being created. ||
|#

## Bucket {#yandex.cloud.storage.v1.Bucket}

A bucket resource.
For details about the concept, see [documentation](/docs/storage/concepts/bucket).

#|
||Field | Description ||
|| id | **string**

ID of the bucket. Always equal to `name`, which has priority. ||
|| name | **string**

Name of the bucket.

The name is unique within the platform. For naming limitations and rules, see
[documentation](/docs/storage/concepts/bucket#naming). ||
|| folder_id | **string**

ID of the folder that the bucket belongs to. ||
|| anonymous_access_flags | **[AnonymousAccessFlags](#yandex.cloud.storage.v1.AnonymousAccessFlags2)**

Flags for configuring public (anonymous) access to the bucket's content and settings.
For details, see [documentation](/docs/storage/concepts/bucket#bucket-access). ||
|| default_storage_class | **string**

Default storage class for objects in the bucket. Supported classes are standard storage (`STANDARD`), cold storage
(`COLD`, `STANDARD_IA`, `NEARLINE` all synonyms), and ice storage (`ICE` and `GLACIER` are synonyms).
For details, see [documentation](/docs/storage/concepts/storage-class). ||
|| versioning | enum **Versioning**

Bucket versioning status.
For details, see [documentation](/docs/storage/concepts/versioning).

- `VERSIONING_UNSPECIFIED`
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
|| max_size | **int64**

Maximum size of the bucket, in bytes.
For details, see [documentation](/docs/storage/operations/buckets/limit-max-volume). ||
|| policy | **[google.protobuf.Struct](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/struct)**

Bucket policies that set permissions for actions with the bucket, its objects, and groups of objects.
For details, see [documentation](/docs/storage/concepts/policy). ||
|| acl | **[ACL](#yandex.cloud.storage.v1.ACL2)**

Access control list (ACL) of the bucket.
For details, see [documentation](/docs/storage/concepts/acl). ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| cors[] | **[CorsRule](#yandex.cloud.storage.v1.CorsRule)**

List of rules for cross-domain requests to objects in the bucket (cross-origin resource sharing, CORS).
For details, see [documentation](/docs/storage/concepts/cors). ||
|| website_settings | **[WebsiteSettings](#yandex.cloud.storage.v1.WebsiteSettings)**

Configuration for hosting a static website in the bucket.
For details, see [documentation](/docs/storage/concepts/hosting). ||
|| lifecycle_rules[] | **[LifecycleRule](#yandex.cloud.storage.v1.LifecycleRule)**

List of object lifecycle rules for the bucket.
For details, see [documentation](/docs/storage/concepts/lifecycles). ||
|| tags[] | **[Tag](#yandex.cloud.storage.v1.Tag2)**

List of tags for the bucket.
For details, see [documentation](/docs/resource-manager/concepts/labels). ||
|| object_lock | **[ObjectLock](#yandex.cloud.storage.v1.ObjectLock)**

Configuration for object lock on the bucket.
For details about the concept, see [documentation](/docs/storage/concepts/object-lock). ||
|| encryption | **[Encryption](#yandex.cloud.storage.v1.Encryption)**

Configuration for bucket's encryption
For details, see [documentation](/docs/storage/concepts/encryption) ||
|| allowed_private_endpoints | **[BucketAllowedPrivateEndpoints](#yandex.cloud.storage.v1.BucketAllowedPrivateEndpoints)**

Bucket allowed private endpoints. ||
|#

## AnonymousAccessFlags {#yandex.cloud.storage.v1.AnonymousAccessFlags2}

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

## ACL {#yandex.cloud.storage.v1.ACL2}

#|
||Field | Description ||
|| grants[] | **[Grant](#yandex.cloud.storage.v1.ACL.Grant2)**

List of permissions granted and the grantees. ||
|#

## Grant {#yandex.cloud.storage.v1.ACL.Grant2}

A grant resource, used to specify the permission granted and the grantee.

#|
||Field | Description ||
|| permission | enum **Permission**

Required field. Permission granted by the grant.

- `PERMISSION_UNSPECIFIED`
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

- `GRANT_TYPE_UNSPECIFIED`
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

ID of the account who is a grantee. Required when the `grant_type` is `GRANT_TYPE_ACCOUNT`. ||
|#

## CorsRule {#yandex.cloud.storage.v1.CorsRule}

A CORS rule resource.
For details about the concept, see [documentation](/docs/storage/concepts/cors).

#|
||Field | Description ||
|| id | **string**

ID of the CORS rule. ||
|| allowed_methods[] | enum **Method**

List of HTTP methods allowed by the CORS rule.

When a client sends a CORS-preflight `options` request with the `Access-Control-Request-Method` header (see
[S3-compatible API reference](/docs/storage/s3/api-ref/object/options)), the specified method is checked against
the list of the allowed methods. If there is a match, all the allowed methods are listed in the
`Access-Control-Allow-Methods` header of the response.

- `METHOD_UNSPECIFIED`
- `METHOD_GET`: HTTP `GET` method.
- `METHOD_HEAD`: HTTP `HEAD` method.
- `METHOD_POST`: HTTP `POST` method.
- `METHOD_PUT`: HTTP `PUT` method.
- `METHOD_DELETE`: HTTP `DELETE` method. ||
|| allowed_headers[] | **string**

List of HTTP headers allowed by the CORS rule.

When a client sends a CORS-preflight `options` request with the `Access-Control-Request-Headers` header (see
[S3-compatible API reference](/docs/storage/s3/api-ref/object/options)), the specified headers are checked against
the list of the allowed headers. If there is a match, the specified headers that are allowed are listed in the
`Access-Control-Allow-Headers` header of the response.

Each string in the list can contain at most one `*` wildcard character that matches 0 or more characters.
For example, `x-amz-*` value will allow all Amazon S3-compatible headers. ||
|| allowed_origins[] | **string**

List of request origins allowed by the CORS rule.

Each string in the list can contain at most one `*` wildcard character that matches 0 or more characters.
For example, `http://*.example.com` value will allow requests originating from all subdomains of `example.com`. ||
|| expose_headers[] | **string**

List of headers contained in responses to CORS requests that can be accessed by applications. ||
|| max_age_seconds | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Time in seconds that a client can cache the response to a CORS-preflight request as identified by the
object requested, the HTTP method, and the origin. ||
|#

## WebsiteSettings {#yandex.cloud.storage.v1.WebsiteSettings}

#|
||Field | Description ||
|| index | **string**

Key of the index page object that is returned when a response is made to the root of the website.

Either `index` or `redirect_all_requests` must be specified in order for the bucket to host a static website.

If specified, the index page object must be located in the root of the bucket. ||
|| error | **string**

Key of the error page object that is returned when an error occurs. ||
|| redirect_all_requests | **[Scheme](#yandex.cloud.storage.v1.WebsiteSettings.Scheme)**

Configuration for redirecting all requests sent to the website.

Either `redirect_all_requests` or `index` must be specified in order for the bucket to host a static website.
If `redirect_all_requests` is specified, it must be the only field in [Bucket.website_settings](#yandex.cloud.storage.v1.Bucket). ||
|| routing_rules[] | **[RoutingRule](#yandex.cloud.storage.v1.WebsiteSettings.RoutingRule)**

List of redirect rules. ||
|#

## Scheme {#yandex.cloud.storage.v1.WebsiteSettings.Scheme}

A configuration resource for redirecting all requests sent to the website.

#|
||Field | Description ||
|| protocol | enum **Protocol**

Scheme of the redirect URI.

- `PROTOCOL_UNSPECIFIED`
- `PROTOCOL_HTTP`: `http` scheme.
- `PROTOCOL_HTTPS`: `https` scheme. ||
|| hostname | **string**

Hostname of the redirect URI. ||
|#

## RoutingRule {#yandex.cloud.storage.v1.WebsiteSettings.RoutingRule}

List of redirect rules.

#|
||Field | Description ||
|| condition | **[Condition](#yandex.cloud.storage.v1.WebsiteSettings.Condition)**

Redirect condition. ||
|| redirect | **[Redirect](#yandex.cloud.storage.v1.WebsiteSettings.Redirect)**

Redirect instructions. ||
|#

## Condition {#yandex.cloud.storage.v1.WebsiteSettings.Condition}

#|
||Field | Description ||
|| http_error_code_returned_equals | **string**

HTTP status code (number only) that must match for the redirect to apply. ||
|| key_prefix_equals | **string**

Prefix of the object key from which requests are redirected. ||
|#

## Redirect {#yandex.cloud.storage.v1.WebsiteSettings.Redirect}

#|
||Field | Description ||
|| hostname | **string**

Hostname of the redirect URI. ||
|| http_redirect_code | **string**

HTTP status code of the redirect response.

Default value: `"301"`. ||
|| protocol | enum **Protocol**

Scheme of the redirect URI.

- `PROTOCOL_UNSPECIFIED`
- `PROTOCOL_HTTP`: `http` scheme.
- `PROTOCOL_HTTPS`: `https` scheme. ||
|| replace_key_prefix_with | **string**

Substitution for the prefix of the object key specified in [Condition.key_prefix_equals](#yandex.cloud.storage.v1.WebsiteSettings.Condition).

At most one of `replace_key_prefix_with` and `replace_key_with` can be specified. ||
|| replace_key_with | **string**

New object key.

At most one of `replace_key_with` and `replace_key_prefix_with` can be specified. ||
|#

## LifecycleRule {#yandex.cloud.storage.v1.LifecycleRule}

An object lifecycle rule resource for the bucket.
For details about the concept, see [documentation](/docs/storage/concepts/lifecycles).

#|
||Field | Description ||
|| id | **[google.protobuf.StringValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/string-value)**

ID of the rule. Provided by the client or generated at creation time. ||
|| enabled | **bool**

Indicates whether the rule is in effect. ||
|| filter | **[RuleFilter](#yandex.cloud.storage.v1.LifecycleRule.RuleFilter)**

Filter that identifies the objects to which the rule applies.

If not specified, the rule applies to all objects in the bucket. ||
|| expiration | **[Expiration](#yandex.cloud.storage.v1.LifecycleRule.Expiration)**

Expiration rule.

The expiration of an object is described as follows.

For the unversioned bucket ([Bucket.versioning](#yandex.cloud.storage.v1.Bucket) is `VERSIONING_DISABLED`), the object is deleted and cannot be
recovered.

For the bucket with versioning enabled ([Bucket.versioning](#yandex.cloud.storage.v1.Bucket) is `VERSIONING_ENABLED`), the current version of the
object (if it exists and is not a delete marker) is retained as a non-current version, and a delete marker becomes
the current version of the object.

For the bucket with versioning suspended ([Bucket.versioning](#yandex.cloud.storage.v1.Bucket) is `VERSIONING_SUSPENDED`), the current version of
the object is retained as a non-current version if it is not a delete marker, or is removed otherwise, and a
delete marker becomes the current version of the object. ||
|| transitions[] | **[Transition](#yandex.cloud.storage.v1.LifecycleRule.Transition)**

List of transition rules.

The transition of an object is described as follows.

For the unversioned bucket ([Bucket.versioning](#yandex.cloud.storage.v1.Bucket) is `VERSIONING_DISABLED`), the object is transitioned to the
specified storage class.

For the bucket with versioning enabled ([Bucket.versioning](#yandex.cloud.storage.v1.Bucket) is `VERSIONING_ENABLED`) or suspended
(`VERSIONING_SUSPENDED`), the current version of the object is transitioned to the specified storage class. ||
|| abort_incomplete_multipart_upload | **[AfterDays](#yandex.cloud.storage.v1.LifecycleRule.AfterDays)**

Configuration for aborting incomplete [multipart uploads](/docs/storage/concepts/multipart). ||
|| noncurrent_expiration | **[NoncurrentExpiration](#yandex.cloud.storage.v1.LifecycleRule.NoncurrentExpiration)**

Expiration rule for non-current versions of objects in a bucket with versioning enabled ([Bucket.versioning](#yandex.cloud.storage.v1.Bucket) is
`VERSIONING_ENABLED`) or suspended (`VERSIONING_SUSPENDED`).

At expiration, the non-current version of the object is deleted and cannot be recovered. ||
|| noncurrent_transitions[] | **[NoncurrentTransition](#yandex.cloud.storage.v1.LifecycleRule.NoncurrentTransition)**

List of transition rules for non-current versions of objects in a bucket with versioning enabled
([Bucket.versioning](#yandex.cloud.storage.v1.Bucket) is `VERSIONING_ENABLED`) or suspended (`VERSIONING_SUSPENDED`).

At transition, the non-current version of the object is transitioned to the specified storage class. ||
|| noncurrent_delete_markers | **[NoncurrentDeleteMarkers](#yandex.cloud.storage.v1.LifecycleRule.NoncurrentDeleteMarkers)**

Expiration rule for non-current delete markers of an objects in a bucket with versioning
enabled ([Bucket.versioning](#yandex.cloud.storage.v1.Bucket) is `VERSIONING_ENABLED`) or suspended (`VERSIONING_SUSPENDED`).
Works in the same way as noncurrent_expiration rule, but only for delete markers.

At expiration, the non-current delete marker of the object is deleted and cannot be recovered. ||
|#

## RuleFilter {#yandex.cloud.storage.v1.LifecycleRule.RuleFilter}

#|
||Field | Description ||
|| prefix | **string**

Key prefix that the object must have in order for the rule to apply. ||
|| object_size_greater_than | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Size that the object must be greater. ||
|| object_size_less_than | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Size that the object must be less t. ||
|| tag | **[Tag](#yandex.cloud.storage.v1.Tag2)**

Tags that the object's tag set must have for the rule to apply. ||
|| and_operator | **[And](#yandex.cloud.storage.v1.LifecycleRule.RuleFilter.And)**

Apply a logical AND to all of the predicates configured inside the And operator. ||
|#

## Tag {#yandex.cloud.storage.v1.Tag2}

#|
||Field | Description ||
|| key | **string**

Key of the bucket tag. ||
|| value | **string**

Value of the bucket tag. ||
|#

## And {#yandex.cloud.storage.v1.LifecycleRule.RuleFilter.And}

#|
||Field | Description ||
|| prefix | **string** ||
|| object_size_greater_than | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)** ||
|| object_size_less_than | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)** ||
|| tag[] | **[Tag](#yandex.cloud.storage.v1.Tag2)** ||
|#

## Expiration {#yandex.cloud.storage.v1.LifecycleRule.Expiration}

#|
||Field | Description ||
|| date | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Specific date of object expiration.

The rule continues to apply even after the date has passed, i.e. any new objects created in the bucket expire
immediately.

Exactly one of `date`, `days`, and `expired_object_delete_marker` fields can be specified. ||
|| days | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Time period, in number of days from the creation or modification of the object, after which an object expires.

Exactly one of `days`, `date`, and `expired_object_delete_marker` fields can be specified. ||
|| expired_object_delete_marker | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Indicates whether a delete marker of an object with no non-current versions (referred to as an expired object
delete marker) is removed at the object's expiration.

Exactly one of `expired_object_delete_marker`, `date`, and `days` fields can be specified. ||
|#

## Transition {#yandex.cloud.storage.v1.LifecycleRule.Transition}

List of transition rules.

The transition of an object is described as follows.

For the unversioned bucket ([Bucket.versioning](#yandex.cloud.storage.v1.Bucket) is `VERSIONING_DISABLED`), the object is transitioned to the
specified storage class.

For the bucket with versioning enabled ([Bucket.versioning](#yandex.cloud.storage.v1.Bucket) is `VERSIONING_ENABLED`) or suspended
(`VERSIONING_SUSPENDED`), the current version of the object is transitioned to the specified storage class.

#|
||Field | Description ||
|| date | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Specific date of object transition.

The rule continues to apply even after the date has passed, i.e. any new objects created in the bucket are
transitioned immediately.

At most one of `date` and `days` fields can be specified. ||
|| days | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Time period, in number of days from the creation or modification of the object, after which an object is
transitioned.

At most one of `days` and `date` fields can be specified. ||
|| storage_class | **string**

Required field. Storage class to which an object is transitioned from standard storage.

The only supported class is cold storage (`COLD`, `STANDARD_IA`, `NEARLINE` all synonyms). Transitions from cold
to standard storage and transitions to or from ice storage are not allowed. ||
|#

## AfterDays {#yandex.cloud.storage.v1.LifecycleRule.AfterDays}

#|
||Field | Description ||
|| days_after_expiration | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Time period, in number of days from the start of the multipart upload, after which the incomplete upload is
aborted. ||
|#

## NoncurrentExpiration {#yandex.cloud.storage.v1.LifecycleRule.NoncurrentExpiration}

#|
||Field | Description ||
|| noncurrent_days | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Time period, in number of days since the version of an object was classified as non-current, after which the
version expires. ||
|#

## NoncurrentTransition {#yandex.cloud.storage.v1.LifecycleRule.NoncurrentTransition}

List of transition rules for non-current versions of objects in a bucket with versioning enabled
([Bucket.versioning](#yandex.cloud.storage.v1.Bucket) is `VERSIONING_ENABLED`) or suspended (`VERSIONING_SUSPENDED`).

At transition, the non-current version of the object is transitioned to the specified storage class.

#|
||Field | Description ||
|| noncurrent_days | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Time period, in number of days since the version of an object was classified as non-current, after which the
version is transitioned. ||
|| storage_class | **string**

Required field. Storage class to which a non-current version of an object is transitioned from standard storage.

The only supported class is cold storage (`COLD`, `STANDARD_IA`, `NEARLINE` all synonyms). Transitions from cold
to standard storage and transitions to or from ice storage are not allowed. ||
|#

## NoncurrentDeleteMarkers {#yandex.cloud.storage.v1.LifecycleRule.NoncurrentDeleteMarkers}

#|
||Field | Description ||
|| noncurrent_days | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Time period, in number of days since the version of a delete marker was classified as non-current, after which
the delete marker expires. ||
|#

## ObjectLock {#yandex.cloud.storage.v1.ObjectLock}

A resource for Object Lock configuration of a bucket.
For details about the concept, see [documentation](/docs/storage/concepts/object-lock).

#|
||Field | Description ||
|| status | enum **ObjectLockStatus**

- `OBJECT_LOCK_STATUS_UNSPECIFIED`
- `OBJECT_LOCK_STATUS_DISABLED`
- `OBJECT_LOCK_STATUS_ENABLED` ||
|| default_retention | **[DefaultRetention](#yandex.cloud.storage.v1.ObjectLock.DefaultRetention)** ||
|#

## DefaultRetention {#yandex.cloud.storage.v1.ObjectLock.DefaultRetention}

Default lock configuration for added objects

#|
||Field | Description ||
|| mode | enum **Mode**

- `MODE_UNSPECIFIED`
- `MODE_GOVERNANCE`
- `MODE_COMPLIANCE` ||
|| days | **int64**

Number of days for locking

Includes only one of the fields `days`, `years`. ||
|| years | **int64**

Number of years for locking

Includes only one of the fields `days`, `years`. ||
|#

## Encryption {#yandex.cloud.storage.v1.Encryption}

#|
||Field | Description ||
|| rules[] | **[EncryptionRule](#yandex.cloud.storage.v1.Encryption.EncryptionRule)** ||
|#

## EncryptionRule {#yandex.cloud.storage.v1.Encryption.EncryptionRule}

#|
||Field | Description ||
|| kms_master_key_id | **string** ||
|| sse_algorithm | **string** ||
|#

## BucketAllowedPrivateEndpoints {#yandex.cloud.storage.v1.BucketAllowedPrivateEndpoints}

#|
||Field | Description ||
|| enabled | **bool**

if true, private endpoints white list check is enabled
even if private_endpoints list is empty ||
|| private_endpoints[] | **string**

white list of private endpoints bucket accessible from ||
|#