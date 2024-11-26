---
editable: false
sourcePath: en/_api-ref-grpc/mdb/elasticsearch/v1/api-ref/grpc/Extension/get.md
---

# Managed Service for Elasticsearch API, gRPC: ExtensionService.Get

Returns the specified extension of Elasticsearch cluster.

## gRPC request

**rpc Get ([GetExtensionRequest](#yandex.cloud.mdb.elasticsearch.v1.GetExtensionRequest)) returns ([Extension](#yandex.cloud.mdb.elasticsearch.v1.Extension))**

## GetExtensionRequest {#yandex.cloud.mdb.elasticsearch.v1.GetExtensionRequest}

```json
{
  "cluster_id": "string",
  "extension_id": "string"
}
```

#|
||Field | Description ||
|| cluster_id | **string**

Required field. ID of the cluster. ||
|| extension_id | **string**

Required field. ID of the extension to return. ||
|#

## Extension {#yandex.cloud.mdb.elasticsearch.v1.Extension}

```json
{
  "name": "string",
  "id": "string",
  "cluster_id": "string",
  "version": "int64",
  "active": "bool"
}
```

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