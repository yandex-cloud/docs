[Документация Yandex Cloud](../../../../index.md) > [Yandex Managed Service for Valkey™](../../../index.md) > Справочник API > [gRPC (англ.)](../index.md) > [User](index.md) > Get

# Managed Service for Redis API, gRPC: UserService.Get

Returns the specified Valkey User resource.
To get the list of available Valkey User resources, make a [List](list.md#List) request.

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

Required field. ID of the Valkey cluster the user belongs to.
To get the cluster ID, use a [ClusterService.List](../Cluster/list.md#List) request.

The maximum string length in characters is 50. ||
|| user_name | **string**

Required field. Name of the Valkey User resource to return.
To get the name of the user, use a [UserService.List](list.md#List) request.

The maximum string length in characters is 32. Value must match the regular expression ` ^[a-zA-Z0-9_][a-zA-Z0-9_@.-]*$ `. ||
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
    "sanitize_payload": "google.protobuf.StringValue",
    "databases": "google.protobuf.StringValue"
  },
  "enabled": "bool",
  "acl_options": "string",
  "connection_manager": {
    "connection_id": "string"
  },
  "auth_type": "AuthType"
}
```

A Valkey User resource. For more information, see the
[Developer's Guide](../../../concepts/index.md).

#|
||Field | Description ||
|| name | **string**

Name of the Valkey user. ||
|| cluster_id | **string**

ID of the Valkey cluster the user belongs to. ||
|| permissions | **[Permissions](#yandex.cloud.mdb.redis.v1.Permissions)**

Set of permissions to grant to the user. ||
|| enabled | **bool**

Is Valkey user enabled ||
|| acl_options | **string**

Raw ACL string inside of Valkey ||
|| connection_manager | **[ConnectionManager](#yandex.cloud.mdb.redis.v1.ConnectionManager)**

Connection Manager connection configuration. ||
|| auth_type | enum **AuthType**

Authentication type for the user

- `AUTH_TYPE_PASSWORD`: Password-based authentication
- `AUTH_TYPE_IAM`: IAM-based authentication ||
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

Deprecated. This parameter is ignored. ||
|| databases | **[google.protobuf.StringValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/string-value)**

Databases parameter. ||
|#

## ConnectionManager {#yandex.cloud.mdb.redis.v1.ConnectionManager}

Connection Manager connection configuration.

#|
||Field | Description ||
|| connection_id | **string**

ID of Connection Manager connection. ||
|#