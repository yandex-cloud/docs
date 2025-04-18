---
editable: false
sourcePath: en/_api-ref-grpc/mdb/opensearch/v1/api-ref/grpc/Extension/list.md
---

# Managed Service for OpenSearch API, gRPC: ExtensionService.List

Returns the list of available extensions for the specified OpenSearch cluster.

## gRPC request

**rpc List ([ListExtensionsRequest](#yandex.cloud.mdb.opensearch.v1.ListExtensionsRequest)) returns ([ListExtensionsResponse](#yandex.cloud.mdb.opensearch.v1.ListExtensionsResponse))**

## ListExtensionsRequest {#yandex.cloud.mdb.opensearch.v1.ListExtensionsRequest}

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

Required field. Required. ID of the cluster to list extensions in. ||
|| page_size | **int64**

The maximum number of results per page that should be returned. If the number of available
results is larger than `page_size`, the service returns a `next_page_token` that can be used
to get the next page of results in subsequent ListBackups requests.
Acceptable values are 0 to 1000, inclusive. Default value: 100. ||
|| page_token | **string**

Page token. Set `page_token` to the `next_page_token` returned by a previous ListBackups
request to get the next page of results. ||
|#

## ListExtensionsResponse {#yandex.cloud.mdb.opensearch.v1.ListExtensionsResponse}

```json
{
  "extensions": [
    {
      "name": "string",
      "id": "string",
      "cluster_id": "string",
      "version": "int64",
      "active": "bool",
      "type": "ExtensionType"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| extensions[] | **[Extension](#yandex.cloud.mdb.opensearch.v1.Extension)**

Requested list of extensions. ||
|| next_page_token | **string**

This token allows you to get the next page of results for ListBackups requests,
if the number of results is larger than `page_size` specified in the request.
To get the next page, specify the value of `next_page_token` as a value for
the `page_token` parameter in the next ListBackups request. Subsequent ListBackups
requests will have their own `next_page_token` to continue paging through the results. ||
|#

## Extension {#yandex.cloud.mdb.opensearch.v1.Extension}

#|
||Field | Description ||
|| name | **string**

Name of the extension. ||
|| id | **string**

Extension unique ID ||
|| cluster_id | **string**

ID of the OpenSearch cluster the extension belongs to. ||
|| version | **int64**

Extension version ||
|| active | **bool**

Flag is extension active now ||
|| type | enum **ExtensionType**

Extension type

- `EXTENSION_TYPE_UNSPECIFIED`
- `EXTENSION_TYPE_SYNONYMS`
- `EXTENSION_TYPE_STOPWORDS` ||
|#