---
editable: false
sourcePath: en/_api-ref/mdb/clickhouse/v1/api-ref/ClusterExtension/get.md
---

# Managed Service for ClickHouse API, REST: ClusterExtension.Get

## HTTP request

```
GET https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/{clusterId}/extensions/{extensionName}
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field.  ||
|| extensionName | **string**

Required field.  ||
|#

## Response {#yandex.cloud.mdb.clickhouse.v1.ClusterExtension}

**HTTP Code: 200 - OK**

```json
{
  "name": "string",
  "clusterId": "string",
  "version": "string"
}
```

#|
||Field | Description ||
|| name | **string**

Required field. Required. Extension name. ||
|| clusterId | **string**

Required field. Required. ID of the ClickHouse cluster. ||
|| version | **string**

Required field. Required. Extension version. ||
|#