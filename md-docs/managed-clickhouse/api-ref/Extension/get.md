# Managed Service for ClickHouse API, REST: Extension.Get

Returns the specified extension.

## HTTP request

```
GET https://mdb.api.cloud.yandex.net/managed-clickhouse/v1/extensions/{extensionName}
```

## Path parameters

#|
||Field | Description ||
|| extensionName | **string**

Required field. Name of the extension.

The maximum string length in characters is 63. ||
|#

## Query parameters {#yandex.cloud.mdb.clickhouse.v1.GetExtensionRequest}

#|
||Field | Description ||
|| folderId | **string**

ID of the folder.

The maximum string length in characters is 50. ||
|#

## Response {#yandex.cloud.mdb.clickhouse.v1.Extension}

**HTTP Code: 200 - OK**

```json
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
|| default | **boolean**

Is default version. ||
|| deprecated | **boolean**

Is version deprecated.
(-- api-linter: yc::1703::deprecated-annotation=disabled --) ||
|#