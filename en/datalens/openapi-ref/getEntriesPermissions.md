---
editable: false
---

# DataLens API: Get entries permissions

## HTTP request

Returns the specified DataLens entries permissions.

```
POST https://api.datalens.yandex.net/rpc/getEntriesPermissions
```

## Body parameters

**Request schema: application/json**

```json
{
  "entryIds": [
    "string"
  ]
}
```

#|
||Field | Description ||
|| entryIds[] | **string**

Required field. ID of the entries to get permissions for. ||
|#

## Response {#200}

**HTTP Code: 200**

Response

**Response schema: application/json**

```json
{}
```