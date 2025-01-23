---
editable: false
sourcePath: en/_api-ref/mdb/redis/v1/api-ref/User/list.md
---

# Managed Service for Redis API, REST: User.List

Retrieves the list of Redis User resources in the specified cluster.

## HTTP request

```
GET https://{{ api-host-mdb }}/managed-redis/v1/clusters/{clusterId}/users
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the cluster to list Redis users in.
To get the cluster ID, use a [ClusterService.List](/docs/managed-redis/api-ref/Cluster/list#List) request. ||
|#

## Query parameters {#yandex.cloud.mdb.redis.v1.ListUsersRequest}

#|
||Field | Description ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`, the service returns a [ListUsersResponse.nextPageToken](#yandex.cloud.mdb.redis.v1.ListUsersResponse)
that can be used to get the next page of results in subsequent list requests. ||
|| pageToken | **string**

Page token. To get the next page of results, set `pageToken` to the
[ListUsersResponse.nextPageToken](#yandex.cloud.mdb.redis.v1.ListUsersResponse) returned by the previous list request. ||
|#

## Response {#yandex.cloud.mdb.redis.v1.ListUsersResponse}

**HTTP Code: 200 - OK**

```json
{
  "users": [
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
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| users[] | **[User](#yandex.cloud.mdb.redis.v1.User)**

List of Redis User resources. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListUsersRequest.pageSize](#yandex.cloud.mdb.redis.v1.ListUsersRequest), use the `nextPageToken` as the value
for the [ListUsersRequest.pageToken](#yandex.cloud.mdb.redis.v1.ListUsersRequest) parameter in the next list request. Each subsequent
list request will have its own `nextPageToken` to continue paging through the results. ||
|#

## User {#yandex.cloud.mdb.redis.v1.User}

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