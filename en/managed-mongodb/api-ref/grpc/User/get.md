---
editable: false
sourcePath: en/_api-ref-grpc/mdb/mongodb/v1/api-ref/grpc/User/get.md
---

# Managed Service for MongoDB API, gRPC: UserService.Get {#Get}

Returns the specified MongoDB User resource.

To get the list of available MongoDB User resources, make a [List](/docs/managed-mongodb/api-ref/grpc/User/list#List) request.

## gRPC request

**rpc Get ([GetUserRequest](#yandex.cloud.mdb.mongodb.v1.GetUserRequest)) returns ([User](#yandex.cloud.mdb.mongodb.v1.User))**

## GetUserRequest {#yandex.cloud.mdb.mongodb.v1.GetUserRequest}

```json
{
  "clusterId": "string",
  "userName": "string"
}
```

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the MongoDB cluster the user belongs to.
To get the cluster ID, use a [ClusterService.List](/docs/managed-mongodb/api-ref/grpc/Cluster/list#List) request. ||
|| userName | **string**

Required field. Name of the MongoDB User resource to return.
To get the name of the user, use a [UserService.List](/docs/managed-mongodb/api-ref/grpc/User/list#List) request. ||
|#

## User {#yandex.cloud.mdb.mongodb.v1.User}

```json
{
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
```

A MongoDB User resource. For more information, see the
[Developer's Guide](/docs/managed-mongodb/concepts).

#|
||Field | Description ||
|| name | **string**

Name of the MongoDB user. ||
|| clusterId | **string**

ID of the MongoDB cluster the user belongs to. ||
|| permissions[] | **[Permission](#yandex.cloud.mdb.mongodb.v1.Permission)**

Set of permissions granted to the user. ||
|#

## Permission {#yandex.cloud.mdb.mongodb.v1.Permission}

#|
||Field | Description ||
|| databaseName | **string**

Name of the database that the permission grants access to. ||
|| roles[] | **string**

MongoDB roles for the `databaseName` database that the permission grants. ||
|#