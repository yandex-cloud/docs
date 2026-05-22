---
editable: false
---

# DataLens API: Update collection

## HTTP request

```
POST https://api.datalens.tech/rpc/updateCollection
```

## Body parameters

**Request schema: application/json**

```json
{
  "collectionId": "string",
  "title": "string",
  "description": "string"
}
```

#|
||Field | Description ||
|| collectionId | **string**

Required field.  ||
|| title | **string** ||
|| description | **string** ||
|#

## Response {#200}

**HTTP Code: 200**

Response

**Response schema: application/json**

```json
{
  "collectionId": "string",
  "title": "string",
  "description": "string | null",
  "parentId": "string | null",
  "tenantId": "string",
  "createdBy": "string",
  "createdAt": "string",
  "updatedBy": "string",
  "updatedAt": "string",
  "meta": {
    "string": "unknown"
  }
}
```

#|
||Field | Description ||
|| collectionId | **string**

Required field.  ||
|| title | **string**

Required field.  ||
|| description | **string \| null**

Required field.  ||
|| parentId | **string \| null**

Required field.  ||
|| tenantId | **string**

Required field.  ||
|| createdBy | **string**

Required field.  ||
|| createdAt | **string**

Required field.  ||
|| updatedBy | **string**

Required field.  ||
|| updatedAt | **string**

Required field.  ||
|| meta | **object** (map<**string**, **unknown**>)

Required field.  ||
|#