---
editable: false
sourcePath: en/_api-ref-grpc/mdb/redis/v1/api-ref/grpc/User/get.md
---

# Managed Service for Redis API, gRPC: UserService.Get

Returns the specified Redis User resource.

To get the list of available Redis User resources, make a [List](/docs/managed-redis/api-ref/grpc/User/list#List) request.

## gRPC request

**rpc Get ([GetUserRequest](#yandex.cloud.mdb.redis.v1.GetUserRequest)) returns ([User](#yandex.cloud.mdb.redis.v1.User))**

## GetUserRequest {#yandex.cloud.mdb.redis.v1.GetUserRequest}

```json
{
  "cluster_id": "string",
  "user_name": "string"
}
```

#|
||Field | Description ||
|| cluster_id | **string**

Required field. ID of the Redis cluster the user belongs to.
To get the cluster ID, use a [ClusterService.List](/docs/managed-redis/api-ref/grpc/Cluster/list#List) request. ||
|| user_name | **string**

Required field. Name of the Redis User resource to return.
To get the name of the user, use a [UserService.List](/docs/managed-redis/api-ref/grpc/User/list#List) request. ||
|#

## User {#yandex.cloud.mdb.redis.v1.User}

```json
{
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
```

A Redis User resource. For more information, see the
[Developer's Guide](/docs/managed-redis/concepts).

#|
||Field | Description ||
|| name | **string**

Name of the Redis user. ||
|| cluster_id | **string**

ID of the Redis cluster the user belongs to. ||
|| permissions | **[Permissions](#yandex.cloud.mdb.redis.v1.Permissions)**

Set of permissions to grant to the user. ||
|| enabled | **bool**

Is redis user enabled ||
|| acl_options | **string**

Raw ACL string inside of Redis ||
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