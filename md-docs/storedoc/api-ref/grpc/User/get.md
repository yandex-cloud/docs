[Документация Yandex Cloud](../../../../index.md) > [Yandex StoreDoc](../../../index.md) > Справочник API > [gRPC (англ.)](../index.md) > [User](index.md) > Get

# Managed Service for MongoDB API, gRPC: UserService.Get

Returns the specified MongoDB User resource.
To get the list of available MongoDB User resources, make a [List](list.md#List) request.

## gRPC request

**rpc Get ([GetUserRequest](#yandex.cloud.mdb.mongodb.v1.GetUserRequest)) returns ([User](#yandex.cloud.mdb.mongodb.v1.User))**

## GetUserRequest {#yandex.cloud.mdb.mongodb.v1.GetUserRequest}

```json
{
  "cluster_id": "string",
  "user_name": "string"
}
```

#|
||Field | Description ||
|| cluster_id | **string**

Required field. ID of the MongoDB cluster the user belongs to.
To get the cluster ID, use a [ClusterService.List](../Cluster/list.md#List) request.

The maximum string length in characters is 50. ||
|| user_name | **string**

Required field. Name of the MongoDB User resource to return.
To get the name of the user, use a [UserService.List](list.md#List) request.

The maximum string length in characters is 63. Value must match the regular expression ` ^[a-zA-Z0-9_][a-zA-Z0-9_-]*$ `. ||
|#

## User {#yandex.cloud.mdb.mongodb.v1.User}

```json
{
  "name": "string",
  "cluster_id": "string",
  "permissions": [
    {
      "database_name": "string",
      "roles": [
        "string"
      ]
    }
  ],
  "auth_type": "AuthType",
  "deletion_protection": "google.protobuf.BoolValue"
}
```

A MongoDB User resource. For more information, see the
[Developer's Guide](../../../concepts/index.md).

#|
||Field | Description ||
|| name | **string**

Name of the MongoDB user. ||
|| cluster_id | **string**

ID of the MongoDB cluster the user belongs to. ||
|| permissions[] | **[Permission](#yandex.cloud.mdb.mongodb.v1.Permission)**

Set of permissions granted to the user. ||
|| auth_type | enum **AuthType**

Authentication type for the user.

- `AUTH_TYPE_PASSWORD`: Password-based authentication (SCRAM).
- `AUTH_TYPE_IAM`: IAM-based authentication via iam-auth-proxy (SASL/PLAIN, $external). ||
|| deletion_protection | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Deletion Protection inhibits deletion of the user ||
|#

## Permission {#yandex.cloud.mdb.mongodb.v1.Permission}

#|
||Field | Description ||
|| database_name | **string**

Name of the database that the permission grants access to. ||
|| roles[] | **string**

MongoDB roles for the `database_name` database that the permission grants. ||
|#