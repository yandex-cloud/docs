---
editable: false
sourcePath: en/_api-ref/mdb/redis/v1/api-ref/User/get.md
---

# Managed Service for Redis API, REST: User.Get

Returns the specified Redis User resource.

To get the list of available Redis User resources, make a [List](/docs/managed-redis/api-ref/User/list#List) request.

## HTTP request

```
GET https://{{ api-host-mdb }}/managed-redis/v1/clusters/{clusterId}/users/{userName}
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the Redis cluster the user belongs to.
To get the cluster ID, use a [ClusterService.List](/docs/managed-redis/api-ref/Cluster/list#List) request. ||
|| userName | **string**

Required field. Name of the Redis User resource to return.
To get the name of the user, use a [UserService.List](/docs/managed-redis/api-ref/User/list#List) request. ||
|#

## Response {#yandex.cloud.mdb.redis.v1.User}

**HTTP Code: 200 - OK**

```json
{
  "name": "string",
  "clusterId": "string",
  "permissions": {
    "patterns": "string",
    "pubSubChannels": "string",
    "categories": "string",
    "commands": "string",
    "sanitizePayload": "string"
  },
  "enabled": "boolean",
  "aclOptions": "string"
}
```

A Redis User resource. For more information, see the
[Developer's Guide](/docs/managed-redis/concepts).

#|
||Field | Description ||
|| name | **string**

Name of the Redis user. ||
|| clusterId | **string**

ID of the Redis cluster the user belongs to. ||
|| permissions | **[Permissions](#yandex.cloud.mdb.redis.v1.Permissions)**

Set of permissions to grant to the user. ||
|| enabled | **boolean**

Is redis user enabled ||
|| aclOptions | **string**

Raw ACL string inside of Redis ||
|#

## Permissions {#yandex.cloud.mdb.redis.v1.Permissions}

#|
||Field | Description ||
|| patterns | **string**

Keys patterns user has permission to. ||
|| pubSubChannels | **string**

Channel patterns user has permissions to. ||
|| categories | **string**

Command categories user has permissions to. ||
|| commands | **string**

Commands user can execute. ||
|| sanitizePayload | **string**

SanitizePayload parameter. ||
|#