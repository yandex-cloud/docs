---
editable: false
sourcePath: en/_api-ref-grpc/mdb/greenplum/v1/api-ref/grpc/User/list.md
---

# Managed Service for Greenplum® API, gRPC: UserService.List

List all users

## gRPC request

**rpc List ([ListUsersRequest](#yandex.cloud.mdb.greenplum.v1.ListUsersRequest)) returns ([ListUsersResponse](#yandex.cloud.mdb.greenplum.v1.ListUsersResponse))**

## ListUsersRequest {#yandex.cloud.mdb.greenplum.v1.ListUsersRequest}

```json
{
  "cluster_id": "string"
}
```

#|
||Field | Description ||
|| cluster_id | **string**

Required field.  ||
|#

## ListUsersResponse {#yandex.cloud.mdb.greenplum.v1.ListUsersResponse}

```json
{
  "users": [
    {
      "name": "string",
      "password": "string",
      "resource_group": "string"
    }
  ]
}
```

#|
||Field | Description ||
|| users[] | **[User](#yandex.cloud.mdb.greenplum.v1.User)** ||
|#

## User {#yandex.cloud.mdb.greenplum.v1.User}

#|
||Field | Description ||
|| name | **string**

Required field. User name ||
|| password | **string**

User password. Used only in create and update requests ||
|| resource_group | **string**

Resource group for user's queries ||
|#