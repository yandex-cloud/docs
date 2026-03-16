---
editable: false
---

# DataLens API: Get entries permissions

## HTTP request

```
POST https://api.datalens.tech/rpc/getEntriesPermissions
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

Required field.  ||
|#

## Response {#200}

**HTTP Code: 200**

Response

**Response schema: application/json**

```json
{}
```