[Документация Yandex Cloud](../../../index.md) > [Yandex Managed Service for ClickHouse®](../../index.md) > Справочник API > [REST (англ.)](../index.md) > [ClusterExtension](index.md) > List

# Managed Service for ClickHouse API, REST: ClusterExtension.List

Lists extensions installed in the specified cluster.

## HTTP request

```
GET https://mdb.api.cloud.yandex.net/managed-clickhouse/v1/clusters/{clusterId}/extensions
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the ClickHouse cluster.

The maximum string length in characters is 50. ||
|#

## Query parameters {#yandex.cloud.mdb.clickhouse.v1.ListClusterExtensionsRequest}

#|
||Field | Description ||
|| pageSize | **string** (int64)

Maximum number of extensions to return per response.

The maximum value is 1000. ||
|| pageToken | **string**

Token for fetching the next page of results.

The maximum string length in characters is 100. ||
|#

## Response {#yandex.cloud.mdb.clickhouse.v1.ListClusterExtensionsResponse}

**HTTP Code: 200 - OK**

```json
{
  "extensions": [
    {
      "name": "string",
      "clusterId": "string",
      "version": "string"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| extensions[] | **[ClusterExtension](#yandex.cloud.mdb.clickhouse.v1.ClusterExtension)**

Requested extensions. ||
|| nextPageToken | **string**

Token to retrieve the next page of results. ||
|#

## ClusterExtension {#yandex.cloud.mdb.clickhouse.v1.ClusterExtension}

#|
||Field | Description ||
|| name | **string**

Required field. Required. Extension name.

The maximum string length in characters is 63. ||
|| clusterId | **string**

Required field. Required. ID of the ClickHouse cluster.

The maximum string length in characters is 50. ||
|| version | **string**

Required field. Required. Extension version. ||
|#