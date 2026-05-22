---
editable: false
---

# DataLens API: Get collection

## HTTP request

```
POST https://api.datalens.tech/rpc/getCollection
```

## Body parameters

**Request schema: application/json**

```json
{
  "collectionId": "string",
  "includePermissionsInfo": "boolean"
}
```

#|
||Field | Description ||
|| collectionId | **string**

Required field.  ||
|| includePermissionsInfo | **boolean** ||
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
  },
  "permissions": {
    "listAccessBindings": "boolean",
    "updateAccessBindings": "boolean",
    "createSharedEntry": "boolean",
    "createCollection": "boolean",
    "createWorkbook": "boolean",
    "limitedView": "boolean",
    "view": "boolean",
    "update": "boolean",
    "copy": "boolean",
    "move": "boolean",
    "delete": "boolean"
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
|| permissions | **[Permissions](#Permissions)**

Required field.  ||
|#

## Permissions {#Permissions}

#|
||Field | Description ||
|| listAccessBindings | **boolean**

Required field.  ||
|| updateAccessBindings | **boolean**

Required field.  ||
|| createSharedEntry | **boolean**

Required field.  ||
|| createCollection | **boolean**

Required field.  ||
|| createWorkbook | **boolean**

Required field.  ||
|| limitedView | **boolean**

Required field.  ||
|| view | **boolean**

Required field.  ||
|| update | **boolean**

Required field.  ||
|| copy | **boolean**

Required field.  ||
|| move | **boolean**

Required field.  ||
|| delete | **boolean**

Required field.  ||
|#