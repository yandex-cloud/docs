---
editable: false
sourcePath: en/_api-ref-grpc/mdb/clickhouse/v1/api-ref/grpc/Extension/list.md
---

# Managed Service for ClickHouse API, gRPC: ExtensionService.List

## gRPC request

**rpc List ([ListExtensionsRequest](#yandex.cloud.mdb.clickhouse.v1.ListExtensionsRequest)) returns ([ListExtensionsResponse](#yandex.cloud.mdb.clickhouse.v1.ListExtensionsResponse))**

## ListExtensionsRequest {#yandex.cloud.mdb.clickhouse.v1.ListExtensionsRequest}

```json
{
  "page_size": "int64",
  "page_token": "string",
  "folder_id": "string"
}
```

#|
||Field | Description ||
|| page_size | **int64** ||
|| page_token | **string** ||
|| folder_id | **string** ||
|#

## ListExtensionsResponse {#yandex.cloud.mdb.clickhouse.v1.ListExtensionsResponse}

```json
{
  "extensions": [
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
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| extensions[] | **[Extension](#yandex.cloud.mdb.clickhouse.v1.Extension)** ||
|| next_page_token | **string** ||
|#

## Extension {#yandex.cloud.mdb.clickhouse.v1.Extension}

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