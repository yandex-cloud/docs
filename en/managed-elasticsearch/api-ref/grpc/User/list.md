---
editable: false
sourcePath: en/_api-ref-grpc/mdb/elasticsearch/v1/api-ref/grpc/User/list.md
---

# Managed Service for Elasticsearch API, gRPC: UserService.List

Retrieves the list of Elasticsearch users in the specified cluster.

## gRPC request

**rpc List ([ListUsersRequest](#yandex.cloud.mdb.elasticsearch.v1.ListUsersRequest)) returns ([ListUsersResponse](#yandex.cloud.mdb.elasticsearch.v1.ListUsersResponse))**

## ListUsersRequest {#yandex.cloud.mdb.elasticsearch.v1.ListUsersRequest}

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

Required field. ID of the Elasticsearch cluster to list Elasticsearch users in.

To get the cluster ID, use a [ClusterService.List](/docs/managed-elasticsearch/api-ref/grpc/Cluster/list#List) request. ||
|| page_size | **int64**

The maximum number of results per page to return.

If the number of available results is larger than `page_size`, the service returns a [ListUsersResponse.next_page_token](#yandex.cloud.mdb.elasticsearch.v1.ListUsersResponse) that can be used to get the next page of results in subsequent list requests. ||
|| page_token | **string**

Page token.

To get the next page of results, set `page_token` to the [ListUsersResponse.next_page_token](#yandex.cloud.mdb.elasticsearch.v1.ListUsersResponse) returned by the previous list request. ||
|#

## ListUsersResponse {#yandex.cloud.mdb.elasticsearch.v1.ListUsersResponse}

```json
{
  "users": [
    {
      "name": "string",
      "cluster_id": "string"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| users[] | **[User](#yandex.cloud.mdb.elasticsearch.v1.User)**

List of Elasticsearch users. ||
|| next_page_token | **string**

This token allows you to get the next page of results for list requests.

If the number of results is larger than [ListUsersRequest.page_size](#yandex.cloud.mdb.elasticsearch.v1.ListUsersRequest), use the `next_page_token` as the value for the [ListUsersRequest.page_token](#yandex.cloud.mdb.elasticsearch.v1.ListUsersRequest) parameter in the next list request.
Each subsequent list request will have its own `next_page_token` to continue paging through the results. ||
|#

## User {#yandex.cloud.mdb.elasticsearch.v1.User}

An Elasticsearch user.

#|
||Field | Description ||
|| name | **string**

Name of the Elasticsearch user. ||
|| cluster_id | **string**

ID of the Elasticsearch cluster the user belongs to. ||
|#