---
editable: false
sourcePath: en/_api-ref-grpc/mdb/elasticsearch/v1/api-ref/grpc/Extension/list.md
---

# Managed Service for Elasticsearch API, gRPC: ExtensionService.List {#List}

Returns the list of available extensions for the specified Elasticsearch cluster.

## gRPC request

**rpc List ([ListExtensionsRequest](#yandex.cloud.mdb.elasticsearch.v1.ListExtensionsRequest)) returns ([ListExtensionsResponse](#yandex.cloud.mdb.elasticsearch.v1.ListExtensionsResponse))**

## ListExtensionsRequest {#yandex.cloud.mdb.elasticsearch.v1.ListExtensionsRequest}

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

Required field. ID of the cluster to list extensions in. ||
|| pageSize | **int64**

The maximum number of results per page to return.

If the number of available results is larger than `pageSize`, the API returns a [ListExtensionsResponse.nextPageToken](#yandex.cloud.mdb.elasticsearch.v1.ListExtensionsResponse) that can be used to get the next page of results in subsequent [ExtensionService.List](#List) requests. ||
|| pageToken | **string**

Page token that can be used to iterate through multiple pages of results.

To get the next page of results, set `pageToken` to the [ListExtensionsResponse.nextPageToken](#yandex.cloud.mdb.elasticsearch.v1.ListExtensionsResponse) returned by the previous [ExtensionService.List](#List) request. ||
|#

## ListExtensionsResponse {#yandex.cloud.mdb.elasticsearch.v1.ListExtensionsResponse}

```json
{
  "extensions": [
    {
      "name": "string",
      "id": "string",
      "clusterId": "string",
      "version": "int64",
      "active": "bool"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| extensions[] | **[Extension](#yandex.cloud.mdb.elasticsearch.v1.Extension)**

Requested list of extensions. ||
|| nextPageToken | **string**

The token that can be used to get the next page of results.

If the number of results is larger than [ListExtensionsRequest.pageSize](#yandex.cloud.mdb.elasticsearch.v1.ListExtensionsRequest), use the `nextPageToken` as the value for the [ListExtensionsRequest.pageToken](#yandex.cloud.mdb.elasticsearch.v1.ListExtensionsRequest) in the subsequent [ExtensionService.List](#List) request to iterate through multiple pages of results.

Each of the subsequent [ExtensionService.List](#List) requests should use the `nextPageToken` value returned in the previous request to continue paging through the results. ||
|#

## Extension {#yandex.cloud.mdb.elasticsearch.v1.Extension}

#|
||Field | Description ||
|| name | **string**

Name of the extension. ||
|| id | **string**

Unique ID of the extension. ||
|| clusterId | **string**

ID of the Elasticsearch cluster the extension belongs to. ||
|| version | **int64**

Version of the extension. ||
|| active | **bool**

The flag shows whether the extension is active. ||
|#