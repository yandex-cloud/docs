---
editable: false
sourcePath: en/_api-ref-grpc/mdb/spqr/v1/api-ref/grpc/User/list.md
---

# Managed Service for SPQR API, gRPC: UserService.List

Retrieves the list of SPQR User resources in the specified cluster.

## gRPC request

**rpc List ([ListUsersRequest](#yandex.cloud.mdb.spqr.v1.ListUsersRequest)) returns ([ListUsersResponse](#yandex.cloud.mdb.spqr.v1.ListUsersResponse))**

## ListUsersRequest {#yandex.cloud.mdb.spqr.v1.ListUsersRequest}

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

Required field. ID of the cluster to list SPQR users in.
To get the cluster ID, use a [ClusterService.List](/docs/managed-spqr/api-ref/grpc/Cluster/list#List) request. ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `page_size`, the service returns a [ListUsersResponse.next_page_token](#yandex.cloud.mdb.spqr.v1.ListUsersResponse)
that can be used to get the next page of results in subsequent list requests. ||
|| page_token | **string**

Page token. To get the next page of results, set `page_token` to the
[ListUsersResponse.next_page_token](#yandex.cloud.mdb.spqr.v1.ListUsersResponse) returned by the previous list request. ||
|#

## ListUsersResponse {#yandex.cloud.mdb.spqr.v1.ListUsersResponse}

```json
{
  "users": [
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
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| users[] | **[User](#yandex.cloud.mdb.spqr.v1.User)**

List of SPQR User resources. ||
|| next_page_token | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListUsersRequest.page_size](#yandex.cloud.mdb.spqr.v1.ListUsersRequest), use the `next_page_token` as the value
for the [ListUsersRequest.page_token](#yandex.cloud.mdb.spqr.v1.ListUsersRequest) parameter in the next list request. Each subsequent
list request will have its own `next_page_token` to continue paging through the results. ||
|#

## User {#yandex.cloud.mdb.spqr.v1.User}

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