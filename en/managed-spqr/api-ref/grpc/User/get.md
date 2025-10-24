---
editable: false
sourcePath: en/_api-ref-grpc/mdb/spqr/v1/api-ref/grpc/User/get.md
---

# Managed Service for SPQR API, gRPC: UserService.Get

Returns the specified SPQR User resource.

To get the list of available SPQR User resources, make a [List](/docs/managed-spqr/api-ref/grpc/User/list#List) request.

## gRPC request

**rpc Get ([GetUserRequest](#yandex.cloud.mdb.spqr.v1.GetUserRequest)) returns ([User](#yandex.cloud.mdb.spqr.v1.User))**

## GetUserRequest {#yandex.cloud.mdb.spqr.v1.GetUserRequest}

```json
{
  "cluster_id": "string",
  "user_name": "string"
}
```

#|
||Field | Description ||
|| cluster_id | **string**

Required field. ID of the SPQR cluster the user belongs to.
To get the cluster ID, use a [ClusterService.List](/docs/managed-spqr/api-ref/grpc/Cluster/list#List) request. ||
|| user_name | **string**

Required field. Name of the SPQR User resource to return.
To get the name of the user, use a [UserService.List](/docs/managed-spqr/api-ref/grpc/User/list#List) request. ||
|#

## User {#yandex.cloud.mdb.spqr.v1.User}

```json
{
  "name": "string",
  "cluster_id": "string",
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
  ]
}
```

A SPQR User resource. For more information, see the
[Developer's Guide](/docs/managed-spqr/concepts).

#|
||Field | Description ||
|| name | **string**

Name of the SPQR user. ||
|| cluster_id | **string**

ID of the SPQR cluster the user belongs to. ||
|| permissions[] | **[Permission](#yandex.cloud.mdb.spqr.v1.Permission)**

Set of permissions granted to the user. ||
|| settings | **[UserSettings](#yandex.cloud.mdb.spqr.v1.UserSettings)**

SPQR Settings for this user ||
|| grants[] | **string**

User grants ||
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