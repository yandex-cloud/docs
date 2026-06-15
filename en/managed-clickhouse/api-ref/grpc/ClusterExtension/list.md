---
editable: false
---

# Managed Service for ClickHouse API, gRPC: ClusterExtensionService.List

Lists extensions installed in the specified cluster.

## gRPC request

**rpc List ([ListClusterExtensionsRequest](#yandex.cloud.mdb.clickhouse.v1.ListClusterExtensionsRequest)) returns ([ListClusterExtensionsResponse](#yandex.cloud.mdb.clickhouse.v1.ListClusterExtensionsResponse))**

## ListClusterExtensionsRequest {#yandex.cloud.mdb.clickhouse.v1.ListClusterExtensionsRequest}

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

Required field. ID of the ClickHouse cluster.

The maximum string length in characters is 50. ||
|| page_size | **int64**

Maximum number of extensions to return per response.

The maximum value is 1000. ||
|| page_token | **string**

Token for fetching the next page of results.

The maximum string length in characters is 100. ||
|#

## ListClusterExtensionsResponse {#yandex.cloud.mdb.clickhouse.v1.ListClusterExtensionsResponse}

```json
{
  "extensions": [
    {
      "name": "string",
      "cluster_id": "string",
      "version": "string"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| extensions[] | **[ClusterExtension](#yandex.cloud.mdb.clickhouse.v1.ClusterExtension)**

Requested extensions. ||
|| next_page_token | **string**

Token to retrieve the next page of results. ||
|#

## ClusterExtension {#yandex.cloud.mdb.clickhouse.v1.ClusterExtension}

#|
||Field | Description ||
|| name | **string**

Required field. Required. Extension name.

The maximum string length in characters is 63. ||
|| cluster_id | **string**

Required field. Required. ID of the ClickHouse cluster.

The maximum string length in characters is 50. ||
|| version | **string**

Required field. Required. Extension version. ||
|#