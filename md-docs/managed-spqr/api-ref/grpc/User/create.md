# Managed Service for SPQR API, gRPC: UserService.Create

Creates a SPQR user in the specified cluster.

## gRPC request

**rpc Create ([CreateUserRequest](#yandex.cloud.mdb.spqr.v1.CreateUserRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## CreateUserRequest {#yandex.cloud.mdb.spqr.v1.CreateUserRequest}

```json
{
  "cluster_id": "string",
  "user_spec": {
    "name": "string",
    "password": "string",
    "permissions": [
      {
        "database_name": "string"
      }
    ],
    "settings": {
      "connection_limit": "google.protobuf.Int64Value",
      "connection_retries": "google.protobuf.Int64Value"
    },
    "grants": [
      "string"
    ],
    "deletion_protection": "google.protobuf.BoolValue"
  }
}
```

#|
||Field | Description ||
|| cluster_id | **string**

Required field. ID of the SPQR cluster to create a user in.
To get the cluster ID, use a [ClusterService.List](../Cluster/list.md#List) request.

The maximum string length in characters is 50. ||
|| user_spec | **[UserSpec](#yandex.cloud.mdb.spqr.v1.UserSpec)**

Properties of the user to be created. ||
|#

## UserSpec {#yandex.cloud.mdb.spqr.v1.UserSpec}

#|
||Field | Description ||
|| name | **string**

Required field. Name of the SPQR user.

The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `. ||
|| password | **string**

Required field. Password of the SPQR user.

The string length in characters must be 8-128. ||
|| permissions[] | **[Permission](#yandex.cloud.mdb.spqr.v1.Permission)**

Set of permissions to grant to the user. ||
|| settings | **[UserSettings](#yandex.cloud.mdb.spqr.v1.UserSettings)**

SPQR Settings for this user ||
|| grants[] | **string**

User grants

The maximum string length in characters for each value is 63. Each value must match the regular expression ` [a-zA-Z0-9_-]* `. ||
|| deletion_protection | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Deletion Protection inhibits deletion of the user ||
|#

## Permission {#yandex.cloud.mdb.spqr.v1.Permission}

#|
||Field | Description ||
|| database_name | **string**

Name of the database that the permission grants access to. ||
|#

## UserSettings {#yandex.cloud.mdb.spqr.v1.UserSettings}

#|
||Field | Description ||
|| connection_limit | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)** ||
|| connection_retries | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)** ||
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

An Operation resource. For more information, see [Operation](../../../../api-design-guide/concepts/operation.md).

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