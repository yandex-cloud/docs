---
editable: false
sourcePath: en/_api-ref-grpc/mdb/elasticsearch/v1/api-ref/grpc/Extension/list.md
---

# Managed Service for Elasticsearch API, gRPC: ExtensionService.List

Returns the list of available extensions for the specified Elasticsearch cluster.

## gRPC request

**rpc List ([ListExtensionsRequest](#yandex.cloud.mdb.elasticsearch.v1.ListExtensionsRequest)) returns ([ListExtensionsResponse](#yandex.cloud.mdb.elasticsearch.v1.ListExtensionsResponse))**

## ListExtensionsRequest {#yandex.cloud.mdb.elasticsearch.v1.ListExtensionsRequest}

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

Required field. ID of the cluster to list extensions in. ||
|| page_size | **int64**

The maximum number of results per page to return.

If the number of available results is larger than `page_size`, the API returns a [ListExtensionsResponse.next_page_token](#yandex.cloud.mdb.elasticsearch.v1.ListExtensionsResponse) that can be used to get the next page of results in subsequent [ExtensionService.List](#List) requests. ||
|| page_token | **string**

Page token that can be used to iterate through multiple pages of results.

To get the next page of results, set `page_token` to the [ListExtensionsResponse.next_page_token](#yandex.cloud.mdb.elasticsearch.v1.ListExtensionsResponse) returned by the previous [ExtensionService.List](#List) request. ||
|#

## ListExtensionsResponse {#yandex.cloud.mdb.elasticsearch.v1.ListExtensionsResponse}

```json
{
  "extensions": [
    {
      "name": "string",
      "id": "string",
      "cluster_id": "string",
      "version": "int64",
      "active": "bool"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| extensions[] | **[Extension](#yandex.cloud.mdb.elasticsearch.v1.Extension)**

Requested list of extensions. ||
|| next_page_token | **string**

The token that can be used to get the next page of results.

If the number of results is larger than [ListExtensionsRequest.page_size](#yandex.cloud.mdb.elasticsearch.v1.ListExtensionsRequest), use the `next_page_token` as the value for the [ListExtensionsRequest.page_token](#yandex.cloud.mdb.elasticsearch.v1.ListExtensionsRequest) in the subsequent [ExtensionService.List](#List) request to iterate through multiple pages of results.

Each of the subsequent [ExtensionService.List](#List) requests should use the `next_page_token` value returned in the previous request to continue paging through the results. ||
|#

## Extension {#yandex.cloud.mdb.elasticsearch.v1.Extension}

#|
||Field | Description ||
|| name | **string**

Name of the extension. ||
|| id | **string**

Unique ID of the extension. ||
|| cluster_id | **string**

ID of the Elasticsearch cluster the extension belongs to. ||
|| version | **int64**

Version of the extension. ||
|| active | **bool**

The flag shows whether the extension is active. ||
|#