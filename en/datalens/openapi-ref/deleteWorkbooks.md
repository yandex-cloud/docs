---
editable: false
---

# DataLens API: Delete workbooks

## HTTP request

```
POST https://api.datalens.tech/rpc/deleteWorkbooks
```

## Body parameters

**Request schema: application/json**

```json
{
  "workbookIds": [
    "string"
  ]
}
```

#|
||Field | Description ||
|| workbookIds[] | **string**

Required field.  ||
|#

## Response {#200}

**HTTP Code: 200**

Response

**Response schema: application/json**

```json
{
  "workbooks": [
    {
      "workbookId": "string",
      "collectionId": "string | null",
      "title": "string",
      "description": "string | null",
      "tenantId": "string",
      "meta": "unknown",
      "createdBy": "string",
      "createdAt": "string",
      "updatedBy": "string",
      "updatedAt": "string",
      "status": "string"
    }
  ]
}
```

#|
||Field | Description ||
|| workbooks[] | **[WorkbooksItem](#WorkbooksItem)**

Required field.  ||
|#

## WorkbooksItem {#WorkbooksItem}

#|
||Field | Description ||
|| workbookId | **string**

Required field.  ||
|| collectionId | **string \| null**

Required field.  ||
|| title | **string**

Required field.  ||
|| description | **string \| null**

Required field.  ||
|| tenantId | **string**

Required field.  ||
|| meta | All of **[Meta0](#Meta0)** & **object** (map<**string**, **unknown**>) ||
|| createdBy | **string**

Required field.  ||
|| createdAt | **string**

Required field.  ||
|| updatedBy | **string**

Required field.  ||
|| updatedAt | **string**

Required field.  ||
|| status | **enum**

- `creating`
- `deleting`
- `active` ||
|#

## Meta0 {#Meta0}

#|
||Field | Description ||
|| importId | **string** ||
|#