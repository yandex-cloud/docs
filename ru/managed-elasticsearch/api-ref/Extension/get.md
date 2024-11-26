---
editable: false
sourcePath: en/_api-ref/mdb/elasticsearch/v1/api-ref/Extension/get.md
---

# Managed Service for Elasticsearch API, REST: Extension.Get

Returns the specified extension of Elasticsearch cluster.

## HTTP request

```
GET https://{{ api-host-mdb }}/managed-elasticsearch/v1/clusters/{clusterId}/extensions/{extensionId}
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the cluster. ||
|| extensionId | **string**

Required field. ID of the extension to return. ||
|#

## Response {#yandex.cloud.mdb.elasticsearch.v1.Extension}

**HTTP Code: 200 - OK**

```json
{
  "name": "string",
  "id": "string",
  "clusterId": "string",
  "version": "string",
  "active": "boolean"
}
```

#|
||Field | Description ||
|| name | **string**

Name of the extension. ||
|| id | **string**

Unique ID of the extension. ||
|| clusterId | **string**

ID of the Elasticsearch cluster the extension belongs to. ||
|| version | **string** (int64)

Version of the extension. ||
|| active | **boolean**

The flag shows whether the extension is active. ||
|#