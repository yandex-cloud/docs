---
editable: false
sourcePath: en/_api-ref-grpc/mdb/elasticsearch/v1/api-ref/grpc/Extension/get.md
---

# Managed Service for Elasticsearch API, gRPC: ExtensionService.Get {#Get}

Returns the specified extension of Elasticsearch cluster.

## gRPC request

**rpc Get ([GetExtensionRequest](#yandex.cloud.mdb.elasticsearch.v1.GetExtensionRequest)) returns ([Extension](#yandex.cloud.mdb.elasticsearch.v1.Extension))**

## GetExtensionRequest {#yandex.cloud.mdb.elasticsearch.v1.GetExtensionRequest}

```json
{
  "clusterId": "string",
  "extensionId": "string"
}
```

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the cluster. ||
|| extensionId | **string**

Required field. ID of the extension to return. ||
|#

## Extension {#yandex.cloud.mdb.elasticsearch.v1.Extension}

```json
{
  "name": "string",
  "id": "string",
  "clusterId": "string",
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
|| clusterId | **string**

ID of the Elasticsearch cluster the extension belongs to. ||
|| version | **int64**

Version of the extension. ||
|| active | **bool**

The flag shows whether the extension is active. ||
|#