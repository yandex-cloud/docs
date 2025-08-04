---
editable: false
apiPlayground:
  - '{"url":"https://{{ api-host-mdb }}/managed-opensearch/v1/clusters/{clusterId}/extensions/{extensionId}","method":"get","path":{"type":"object","properties":{"clusterId":{"description":"**string**\n\nRequired field. Required. ID of the cluster.","type":"string"},"extensionId":{"description":"**string**\n\nRequired field. Required. ID of the extension to return.","type":"string"}},"required":["clusterId","extensionId"],"additionalProperties":false},"query":null,"body":null,"definitions":null}'
sourcePath: en/_api-ref/mdb/opensearch/v1/api-ref/Extension/get.md
---

# Managed Service for OpenSearch API, REST: Extension.Get

Returns the specified extension of OpenSearch cluster.

## HTTP request

```
GET https://{{ api-host-mdb }}/managed-opensearch/v1/clusters/{clusterId}/extensions/{extensionId}
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. Required. ID of the cluster. ||
|| extensionId | **string**

Required field. Required. ID of the extension to return. ||
|#

## Response {#yandex.cloud.mdb.opensearch.v1.Extension}

**HTTP Code: 200 - OK**

```json
{
  "name": "string",
  "id": "string",
  "clusterId": "string",
  "version": "string",
  "active": "boolean",
  "type": "string"
}
```

#|
||Field | Description ||
|| name | **string**

Name of the extension. ||
|| id | **string**

Extension unique ID ||
|| clusterId | **string**

ID of the OpenSearch cluster the extension belongs to. ||
|| version | **string** (int64)

Extension version ||
|| active | **boolean**

Flag is extension active now ||
|| type | **enum** (ExtensionType)

Extension type

- `EXTENSION_TYPE_UNSPECIFIED`
- `EXTENSION_TYPE_SYNONYMS`
- `EXTENSION_TYPE_STOPWORDS` ||
|#