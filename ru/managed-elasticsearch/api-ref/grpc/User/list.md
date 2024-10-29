---
editable: false
sourcePath: en/_api-ref-grpc/mdb/elasticsearch/v1/api-ref/grpc/User/list.md
---

# Managed Service for Elasticsearch API, gRPC: UserService.List {#List}

Retrieves the list of Elasticsearch users in the specified cluster.

## gRPC request

**rpc List ([ListUsersRequest](#yandex.cloud.mdb.elasticsearch.v1.ListUsersRequest)) returns ([ListUsersResponse](#yandex.cloud.mdb.elasticsearch.v1.ListUsersResponse))**

## ListUsersRequest {#yandex.cloud.mdb.elasticsearch.v1.ListUsersRequest}

```json
{
  "clusterId": "string",
  "pageSize": "int64",
  "pageToken": "string"
}
```

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the Elasticsearch cluster to list Elasticsearch users in.

To get the cluster ID, use a [ClusterService.List](/docs/managed-elasticsearch/api-ref/grpc/Cluster/list#List) request. ||
|| pageSize | **int64**

The maximum number of results per page to return.

If the number of available results is larger than `page_size`, the service returns a [ListUsersResponse.nextPageToken](#yandex.cloud.mdb.elasticsearch.v1.ListUsersResponse) that can be used to get the next page of results in subsequent list requests. ||
|| pageToken | **string**

Page token.

To get the next page of results, set `page_token` to the [ListUsersResponse.nextPageToken](#yandex.cloud.mdb.elasticsearch.v1.ListUsersResponse) returned by the previous list request. ||
|#

## ListUsersResponse {#yandex.cloud.mdb.elasticsearch.v1.ListUsersResponse}

```json
{
  "users": [
    {
      "name": "string",
      "clusterId": "string"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| users[] | **[User](#yandex.cloud.mdb.elasticsearch.v1.User)**

List of Elasticsearch users. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests.

If the number of results is larger than [ListUsersRequest.pageSize](#yandex.cloud.mdb.elasticsearch.v1.ListUsersRequest), use the `next_page_token` as the value for the [ListUsersRequest.pageToken](#yandex.cloud.mdb.elasticsearch.v1.ListUsersRequest) parameter in the next list request.
Each subsequent list request will have its own `next_page_token` to continue paging through the results. ||
|#

## User {#yandex.cloud.mdb.elasticsearch.v1.User}

An Elasticsearch user.

#|
||Field | Description ||
|| name | **string**

Name of the Elasticsearch user. ||
|| clusterId | **string**

ID of the Elasticsearch cluster the user belongs to. ||
|#