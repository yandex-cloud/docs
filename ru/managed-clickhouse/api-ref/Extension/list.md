---
editable: false
apiPlayground:
  - url: https://{{ api-host-mdb }}/managed-clickhouse/v1/extensions
    method: get
    path: null
    query:
      type: object
      properties:
        pageSize:
          description: |-
            **string** (int64)
            Maximum number of extensions to return per response.
            The maximum value is 1000.
          type: string
          format: int64
        pageToken:
          description: |-
            **string**
            Token for fetching the next page of results.
            The maximum string length in characters is 100.
          type: string
        folderId:
          description: |-
            **string**
            ID of the folder.
            The maximum string length in characters is 50.
          type: string
      additionalProperties: false
    body: null
    definitions: null
---

# Managed Service for ClickHouse API, REST: Extension.List

Lists extensions available in the specified folder.

## HTTP request

```
GET https://{{ api-host-mdb }}/managed-clickhouse/v1/extensions
```

## Query parameters {#yandex.cloud.mdb.clickhouse.v1.ListExtensionsRequest}

#|
||Field | Description ||
|| pageSize | **string** (int64)

Maximum number of extensions to return per response.

The maximum value is 1000. ||
|| pageToken | **string**

Token for fetching the next page of results.

The maximum string length in characters is 100. ||
|| folderId | **string**

ID of the folder.

The maximum string length in characters is 50. ||
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
|| extensions[] | **[Extension](#yandex.cloud.mdb.clickhouse.v1.Extension)**

Requested extensions. ||
|| nextPageToken | **string**

Token to retrieve the next page of results. ||
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

Is version deprecated.
(-- api-linter: yc::1703::deprecated-annotation=disabled --) ||
|#