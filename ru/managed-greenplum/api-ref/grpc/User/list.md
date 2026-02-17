---
editable: false
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

Required field.

The maximum string length in characters is 50. ||
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

Required field. User name

The string length in characters must be 1-63. Value must match the regular expression ` ^[a-zA-Z_][a-zA-Z0-9_]{0,62}$ `. ||
|| password | **string**

User password. Used only in create and update requests

The string length in characters must be 6-200. ||
|| resource_group | **string**

Resource group for user's queries

Value must match the regular expression ``` ^[^\|/*?.,;'<>]+$ ```. ||
|#