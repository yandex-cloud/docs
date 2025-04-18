---
editable: false
sourcePath: en/_api-ref-grpc/mdb/opensearch/v1/api-ref/grpc/Extension/get.md
---

# Managed Service for OpenSearch API, gRPC: ExtensionService.Get

Returns the specified extension of OpenSearch cluster.

## gRPC request

**rpc Get ([GetExtensionRequest](#yandex.cloud.mdb.opensearch.v1.GetExtensionRequest)) returns ([Extension](#yandex.cloud.mdb.opensearch.v1.Extension))**

## GetExtensionRequest {#yandex.cloud.mdb.opensearch.v1.GetExtensionRequest}

```json
{
  "cluster_id": "string",
  "extension_id": "string"
}
```

#|
||Field | Description ||
|| cluster_id | **string**

Required field. Required. ID of the cluster. ||
|| extension_id | **string**

Required field. Required. ID of the extension to return. ||
|#

## Extension {#yandex.cloud.mdb.opensearch.v1.Extension}

```json
{
  "name": "string",
  "id": "string",
  "cluster_id": "string",
  "version": "int64",
  "active": "bool",
  "type": "ExtensionType"
}
```

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