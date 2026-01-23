---
editable: false
apiPlayground:
  - url: https://{{ api-host-mdb }}/managed-clickhouse/v1/extensions/{extensionName}
    method: get
    path:
      type: object
      properties:
        extensionName:
          description: |-
            **string**
            Required field.
            The maximum string length in characters is 63.
          type: string
      required:
        - extensionName
      additionalProperties: false
    query:
      type: object
      properties:
        folderId:
          description: |-
            **string**
            The maximum string length in characters is 50.
          type: string
      additionalProperties: false
    body: null
    definitions: null
sourcePath: en/_api-ref/mdb/clickhouse/v1/api-ref/Extension/get.md
---

# Managed Service for ClickHouse API, REST: Extension.Get

## HTTP request

```
GET https://{{ api-host-mdb }}/managed-clickhouse/v1/extensions/{extensionName}
```

## Path parameters

#|
||Field | Description ||
|| extensionName | **string**

Required field.

The maximum string length in characters is 63. ||
|#

## Query parameters {#yandex.cloud.mdb.clickhouse.v1.GetExtensionRequest}

#|
||Field | Description ||
|| folderId | **string**

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

Is version deprecated. ||
|#