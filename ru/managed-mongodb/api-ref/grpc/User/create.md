---
editable: false
sourcePath: en/_api-ref-grpc/mdb/mongodb/v1/api-ref/grpc/User/create.md
---

# Managed Service for MongoDB API, gRPC: UserService.Create {#Create}

Creates a MongoDB user in the specified cluster.

## gRPC request

**rpc Create ([CreateUserRequest](#yandex.cloud.mdb.mongodb.v1.CreateUserRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## CreateUserRequest {#yandex.cloud.mdb.mongodb.v1.CreateUserRequest}

```json
{
  "clusterId": "string",
  "userSpec": {
    "name": "string",
    "password": "string",
    "permissions": [
      {
        "databaseName": "string",
        "roles": [
          "string"
        ]
      }
    ]
  }
}
```

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the MongoDB cluster to create a user in.
To get the cluster ID, use a [ClusterService.List](/docs/managed-mongodb/api-ref/grpc/Cluster/list#List) request. ||
|| userSpec | **[UserSpec](#yandex.cloud.mdb.mongodb.v1.UserSpec)**

Properties of the user to be created. ||
|#

## UserSpec {#yandex.cloud.mdb.mongodb.v1.UserSpec}

#|
||Field | Description ||
|| name | **string**

Required field. Name of the MongoDB user. ||
|| password | **string**

Required field. Password of the MongoDB user. ||
|| permissions[] | **[Permission](#yandex.cloud.mdb.mongodb.v1.Permission)**

Set of permissions to grant to the user. ||
|#

## Permission {#yandex.cloud.mdb.mongodb.v1.Permission}

#|
||Field | Description ||
|| databaseName | **string**

Name of the database that the permission grants access to. ||
|| roles[] | **string**

MongoDB roles for the `databaseName` database that the permission grants. ||
|#

## operation.Operation {#yandex.cloud.operation.Operation}

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "google.protobuf.Timestamp",
  "createdBy": "string",
  "modifiedAt": "google.protobuf.Timestamp",
  "done": "bool",
  "metadata": {
    "clusterId": "string",
    "userName": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "name": "string",
    "clusterId": "string",
    "permissions": [
      {
        "databaseName": "string",
        "roles": [
          "string"
        ]
      }
    ]
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
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[CreateUserMetadata](#yandex.cloud.mdb.mongodb.v1.CreateUserMetadata)**

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
|| response | **[User](#yandex.cloud.mdb.mongodb.v1.User)**

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

## CreateUserMetadata {#yandex.cloud.mdb.mongodb.v1.CreateUserMetadata}

#|
||Field | Description ||
|| clusterId | **string**

ID of the MongoDB cluster the user is being created in. ||
|| userName | **string**

Name of the user that is being created. ||
|#

## User {#yandex.cloud.mdb.mongodb.v1.User}

A MongoDB User resource. For more information, see the
[Developer's Guide](/docs/managed-mongodb/concepts).

#|
||Field | Description ||
|| name | **string**

Name of the MongoDB user. ||
|| clusterId | **string**

ID of the MongoDB cluster the user belongs to. ||
|| permissions[] | **[Permission](#yandex.cloud.mdb.mongodb.v1.Permission2)**

Set of permissions granted to the user. ||
|#

## Permission {#yandex.cloud.mdb.mongodb.v1.Permission2}

#|
||Field | Description ||
|| databaseName | **string**

Name of the database that the permission grants access to. ||
|| roles[] | **string**

MongoDB roles for the `databaseName` database that the permission grants. ||
|#