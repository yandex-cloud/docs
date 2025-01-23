---
editable: false
sourcePath: en/_api-ref-grpc/mdb/redis/v1/api-ref/grpc/User/update.md
---

# Managed Service for Redis API, gRPC: UserService.Update

Updates the specified Redis user.

## gRPC request

**rpc Update ([UpdateUserRequest](#yandex.cloud.mdb.redis.v1.UpdateUserRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## UpdateUserRequest {#yandex.cloud.mdb.redis.v1.UpdateUserRequest}

```json
{
  "cluster_id": "string",
  "user_name": "string",
  "update_mask": "google.protobuf.FieldMask",
  "passwords": [
    "string"
  ],
  "permissions": {
    "patterns": "google.protobuf.StringValue",
    "pub_sub_channels": "google.protobuf.StringValue",
    "categories": "google.protobuf.StringValue",
    "commands": "google.protobuf.StringValue",
    "sanitize_payload": "google.protobuf.StringValue"
  },
  "enabled": "bool"
}
```

#|
||Field | Description ||
|| cluster_id | **string**

Required field. ID of the Redis cluster the user belongs to.
To get the cluster ID, use a [ClusterService.List](/docs/managed-redis/api-ref/grpc/Cluster/list#List) request. ||
|| user_name | **string**

Required field. Name of the Redis user to be updated. ||
|| update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**

Field mask that specifies which fields of the Redis User resource should be updated. ||
|| passwords[] | **string**

New passwords the Redis user. ||
|| permissions | **[Permissions](#yandex.cloud.mdb.redis.v1.Permissions)**

New set of permissions to grant to the user. ||
|| enabled | **bool**

Is Redis user enabled ||
|#

## Permissions {#yandex.cloud.mdb.redis.v1.Permissions}

#|
||Field | Description ||
|| patterns | **[google.protobuf.StringValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/string-value)**

Keys patterns user has permission to. ||
|| pub_sub_channels | **[google.protobuf.StringValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/string-value)**

Channel patterns user has permissions to. ||
|| categories | **[google.protobuf.StringValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/string-value)**

Command categories user has permissions to. ||
|| commands | **[google.protobuf.StringValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/string-value)**

Commands user can execute. ||
|| sanitize_payload | **[google.protobuf.StringValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/string-value)**

SanitizePayload parameter. ||
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
    "cluster_id": "string",
    "user_name": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "name": "string",
    "cluster_id": "string",
    "permissions": {
      "patterns": "google.protobuf.StringValue",
      "pub_sub_channels": "google.protobuf.StringValue",
      "categories": "google.protobuf.StringValue",
      "commands": "google.protobuf.StringValue",
      "sanitize_payload": "google.protobuf.StringValue"
    },
    "enabled": "bool",
    "acl_options": "string"
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
|| metadata | **[UpdateUserMetadata](#yandex.cloud.mdb.redis.v1.UpdateUserMetadata)**

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
|| response | **[User](#yandex.cloud.mdb.redis.v1.User)**

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

## UpdateUserMetadata {#yandex.cloud.mdb.redis.v1.UpdateUserMetadata}

#|
||Field | Description ||
|| cluster_id | **string**

ID of the Redis cluster the user belongs to. ||
|| user_name | **string**

Name of the user that is being updated. ||
|#

## User {#yandex.cloud.mdb.redis.v1.User}

A Redis User resource. For more information, see the
[Developer's Guide](/docs/managed-redis/concepts).

#|
||Field | Description ||
|| name | **string**

Name of the Redis user. ||
|| cluster_id | **string**

ID of the Redis cluster the user belongs to. ||
|| permissions | **[Permissions](#yandex.cloud.mdb.redis.v1.Permissions2)**

Set of permissions to grant to the user. ||
|| enabled | **bool**

Is redis user enabled ||
|| acl_options | **string**

Raw ACL string inside of Redis ||
|#

## Permissions {#yandex.cloud.mdb.redis.v1.Permissions2}

#|
||Field | Description ||
|| patterns | **[google.protobuf.StringValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/string-value)**

Keys patterns user has permission to. ||
|| pub_sub_channels | **[google.protobuf.StringValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/string-value)**

Channel patterns user has permissions to. ||
|| categories | **[google.protobuf.StringValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/string-value)**

Command categories user has permissions to. ||
|| commands | **[google.protobuf.StringValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/string-value)**

Commands user can execute. ||
|| sanitize_payload | **[google.protobuf.StringValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/string-value)**

SanitizePayload parameter. ||
|#