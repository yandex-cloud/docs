---
editable: false
apiPlayground:
  - url: https://{{ api-host-mdb }}/managed-greenplum/v1/clusters/{clusterId}/users
    method: get
    path:
      type: object
      properties:
        clusterId:
          description: |-
            **string**
            Required field. 
          type: string
      required:
        - clusterId
      additionalProperties: false
    query: null
    body: null
    definitions: null
sourcePath: en/_api-ref/mdb/greenplum/v1/api-ref/User/list.md
---

# Managed Service for Greenplum® API, REST: User.List

List all users

## HTTP request

```
GET https://{{ api-host-mdb }}/managed-greenplum/v1/clusters/{clusterId}/users
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field.  ||
|#

## Response {#yandex.cloud.mdb.greenplum.v1.ListUsersResponse}

**HTTP Code: 200 - OK**

```json
{
  "users": [
    {
      "name": "string",
      "password": "string",
      "resourceGroup": "string"
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
|| resourceGroup | **string**

Resource group for user's queries ||
|#