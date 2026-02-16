---
editable: false
apiPlayground:
  - url: https://ydb.{{ api-host }}/ydb/v1/resourcePresets/{resourcePresetId}
    method: get
    path:
      type: object
      properties:
        resourcePresetId:
          description: |-
            **string**
            Required field. Required. ID of the resource preset to return.
          type: string
      required:
        - resourcePresetId
      additionalProperties: false
    query: null
    body: null
    definitions: null
sourcePath: en/_api-ref/ydb/v1/api-ref/ResourcePreset/get.md
---

# Managed Service for YDB API, REST: ResourcePreset.Get

Returns the specified resource preset.

## HTTP request

```
GET https://ydb.{{ api-host }}/ydb/v1/resourcePresets/{resourcePresetId}
```

## Path parameters

#|
||Field | Description ||
|| resourcePresetId | **string**

Required field. Required. ID of the resource preset to return. ||
|#

## Response {#yandex.cloud.ydb.v1.ResourcePreset}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "cores": "string",
  "memory": "string"
}
```

#|
||Field | Description ||
|| id | **string** ||
|| cores | **string** (int64) ||
|| memory | **string** (int64) ||
|#