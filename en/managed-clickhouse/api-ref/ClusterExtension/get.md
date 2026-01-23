---
editable: false
apiPlayground:
  - url: https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/{clusterId}/extensions/{extensionName}
    method: get
    path:
      type: object
      properties:
        clusterId:
          description: |-
            **string**
            Required field.
            The maximum string length in characters is 50.
          type: string
        extensionName:
          description: |-
            **string**
            Required field.
            The maximum string length in characters is 63.
          type: string
      required:
        - clusterId
        - extensionName
      additionalProperties: false
    query: null
    body: null
    definitions: null
sourcePath: en/_api-ref/mdb/clickhouse/v1/api-ref/ClusterExtension/get.md
---

# Managed Service for ClickHouse API, REST: ClusterExtension.Get

## HTTP request

```
GET https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/{clusterId}/extensions/{extensionName}
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field.

The maximum string length in characters is 50. ||
|| extensionName | **string**

Required field.

The maximum string length in characters is 63. ||
|#

## Response {#yandex.cloud.mdb.clickhouse.v1.ClusterExtension}

**HTTP Code: 200 - OK**

```json
{
  "name": "string",
  "clusterId": "string",
  "version": "string"
}
```

#|
||Field | Description ||
|| name | **string**

Required field. Required. Extension name.

The maximum string length in characters is 63. ||
|| clusterId | **string**

Required field. Required. ID of the ClickHouse cluster.

The maximum string length in characters is 50. ||
|| version | **string**

Required field. Required. Extension version. ||
|#