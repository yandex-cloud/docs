---
editable: false
sourcePath: en/_api-ref-grpc/mdb/clickhouse/v1/api-ref/grpc/Extension/get.md
---

# Managed Service for ClickHouse API, gRPC: ExtensionService.Get

## gRPC request

**rpc Get ([GetExtensionRequest](#yandex.cloud.mdb.clickhouse.v1.GetExtensionRequest)) returns ([Extension](#yandex.cloud.mdb.clickhouse.v1.Extension))**

## GetExtensionRequest {#yandex.cloud.mdb.clickhouse.v1.GetExtensionRequest}

```json
{
  "extension_name": "string",
  "folder_id": "string"
}
```

#|
||Field | Description ||
|| extension_name | **string**

Required field.  ||
|| folder_id | **string** ||
|#

## Extension {#yandex.cloud.mdb.clickhouse.v1.Extension}

```json
{
  "name": "string",
  "versions": [
    {
      "id": "string",
      "default": "bool",
      "deprecated": "bool"
    }
  ]
}
```

#|
||Field | Description ||
|| name | **string**

Required field. Required. Extension name. ||
|| versions[] | **[ExtensionVersion](#yandex.cloud.mdb.clickhouse.v1.ExtensionVersion)**

Required. All extension available versions. ||
|#

## ExtensionVersion {#yandex.cloud.mdb.clickhouse.v1.ExtensionVersion}

#|
||Field | Description ||
|| id | **string**

Required field. Required. Version ID. ||
|| default | **bool**

Is default version. ||
|| deprecated | **bool**

Is version deprecated. ||
|#