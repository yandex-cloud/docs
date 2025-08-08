---
editable: false
apiPlayground:
  - url: https://{{ api-host-mdb }}/managed-elasticsearch/v1/clusters/{clusterId}/users
    method: get
    path:
      type: object
      properties:
        clusterId:
          description: |-
            **string**
            Required field. ID of the Elasticsearch cluster to list Elasticsearch users in.
            To get the cluster ID, use a [ClusterService.List](/docs/managed-elasticsearch/api-ref/Cluster/list#List) request.
          type: string
      required:
        - clusterId
      additionalProperties: false
    query:
      type: object
      properties:
        pageSize:
          description: |-
            **string** (int64)
            The maximum number of results per page to return.
            If the number of available results is larger than `page_size`, the service returns a [ListUsersResponse.nextPageToken](/docs/managed-elasticsearch/api-ref/User/list#yandex.cloud.mdb.elasticsearch.v1.ListUsersResponse) that can be used to get the next page of results in subsequent list requests.
          type: string
          format: int64
        pageToken:
          description: |-
            **string**
            Page token.
            To get the next page of results, set `page_token` to the [ListUsersResponse.nextPageToken](/docs/managed-elasticsearch/api-ref/User/list#yandex.cloud.mdb.elasticsearch.v1.ListUsersResponse) returned by the previous list request.
          type: string
      additionalProperties: false
    body: null
    definitions: null
sourcePath: en/_api-ref/mdb/elasticsearch/v1/api-ref/User/list.md
---

# Managed Service for Elasticsearch API, REST: User.List

Retrieves the list of Elasticsearch users in the specified cluster.

## HTTP request

```
GET https://{{ api-host-mdb }}/managed-elasticsearch/v1/clusters/{clusterId}/users
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the Elasticsearch cluster to list Elasticsearch users in.

To get the cluster ID, use a [ClusterService.List](/docs/managed-elasticsearch/api-ref/Cluster/list#List) request. ||
|#

## Query parameters {#yandex.cloud.mdb.elasticsearch.v1.ListUsersRequest}

#|
||Field | Description ||
|| pageSize | **string** (int64)

The maximum number of results per page to return.

If the number of available results is larger than `page_size`, the service returns a [ListUsersResponse.nextPageToken](#yandex.cloud.mdb.elasticsearch.v1.ListUsersResponse) that can be used to get the next page of results in subsequent list requests. ||
|| pageToken | **string**

Page token.

To get the next page of results, set `page_token` to the [ListUsersResponse.nextPageToken](#yandex.cloud.mdb.elasticsearch.v1.ListUsersResponse) returned by the previous list request. ||
|#

## Response {#yandex.cloud.mdb.elasticsearch.v1.ListUsersResponse}

**HTTP Code: 200 - OK**

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