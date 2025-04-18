---
editable: false
sourcePath: en/_api-ref/mdb/clickhouse/v1/api-ref/Extension/list.md
---

# Managed Service for ClickHouse API, REST: Extension.List

## HTTP request

```
GET https://{{ api-host-mdb }}/managed-clickhouse/v1/extensions
```

## Query parameters {#yandex.cloud.mdb.clickhouse.v1.ListExtensionsRequest}

#|
||Field | Description ||
|| pageSize | **string** (int64) ||
|| pageToken | **string** ||
|| folderId | **string** ||
|#

## Response {#yandex.cloud.mdb.clickhouse.v1.ListExtensionsResponse}

**HTTP Code: 200 - OK**

```json
{
  "extensions": [
    {
      "name": "string",
      "versions": [
        {
          "id": "string",
          "default": "boolean",
          "deprecated": "boolean"
        }
      ]
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| extensions[] | **[Extension](#yandex.cloud.mdb.clickhouse.v1.Extension)** ||
|| nextPageToken | **string** ||
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
|| default | **boolean**

Is default version. ||
|| deprecated | **boolean**

Is version deprecated. ||
|#