---
editable: false
apiPlayground:
  - url: https://ydb.{{ api-host }}/ydb/v1/locations/{locationId}
    method: get
    path:
      type: object
      properties:
        locationId:
          description: |-
            **string**
            Required field. Required. ID of the location to return.
          type: string
      required:
        - locationId
      additionalProperties: false
    query: null
    body: null
    definitions: null
sourcePath: en/_api-ref/ydb/v1/api-ref/Location/get.md
---

# Managed Service for YDB API, REST: Location.Get

Returns the specified location.

## HTTP request

```
GET https://ydb.{{ api-host }}/ydb/v1/locations/{locationId}
```

## Path parameters

#|
||Field | Description ||
|| locationId | **string**

Required field. Required. ID of the location to return. ||
|#

## Response {#yandex.cloud.ydb.v1.Location}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "description": "string"
}
```

#|
||Field | Description ||
|| id | **string** ||
|| description | **string** ||
|#