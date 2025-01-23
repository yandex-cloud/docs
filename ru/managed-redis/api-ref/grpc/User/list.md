---
editable: false
sourcePath: en/_api-ref-grpc/mdb/redis/v1/api-ref/grpc/User/list.md
---

# Managed Service for Redis API, gRPC: UserService.List

Retrieves the list of Redis User resources in the specified cluster.

## gRPC request

**rpc List ([ListUsersRequest](#yandex.cloud.mdb.redis.v1.ListUsersRequest)) returns ([ListUsersResponse](#yandex.cloud.mdb.redis.v1.ListUsersResponse))**

## ListUsersRequest {#yandex.cloud.mdb.redis.v1.ListUsersRequest}

```json
{
  "cluster_id": "string",
  "page_size": "int64",
  "page_token": "string"
}
```

#|
||Field | Description ||
|| cluster_id | **string**

Required field. ID of the cluster to list Redis users in.
To get the cluster ID, use a [ClusterService.List](/docs/managed-redis/api-ref/grpc/Cluster/list#List) request. ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `page_size`, the service returns a [ListUsersResponse.next_page_token](#yandex.cloud.mdb.redis.v1.ListUsersResponse)
that can be used to get the next page of results in subsequent list requests. ||
|| page_token | **string**

Page token. To get the next page of results, set `page_token` to the
[ListUsersResponse.next_page_token](#yandex.cloud.mdb.redis.v1.ListUsersResponse) returned by the previous list request. ||
|#

## ListUsersResponse {#yandex.cloud.mdb.redis.v1.ListUsersResponse}

```json
{
  "users": [
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
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| users[] | **[User](#yandex.cloud.mdb.redis.v1.User)**

List of Redis User resources. ||
|| next_page_token | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListUsersRequest.page_size](#yandex.cloud.mdb.redis.v1.ListUsersRequest), use the `next_page_token` as the value
for the [ListUsersRequest.page_token](#yandex.cloud.mdb.redis.v1.ListUsersRequest) parameter in the next list request. Each subsequent
list request will have its own `next_page_token` to continue paging through the results. ||
|#

## User {#yandex.cloud.mdb.redis.v1.User}

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