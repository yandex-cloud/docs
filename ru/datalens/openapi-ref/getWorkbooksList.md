---
editable: false
---

# DataLens API: Get workbooks list

## HTTP request

```
POST https://api.datalens.tech/rpc/getWorkbooksList
```

## Body parameters

**Request schema: application/json**

```json
{
  "collectionId": "string | null",
  "includePermissionsInfo": "boolean",
  "filterString": "string",
  "page": "number",
  "pageSize": "number",
  "orderField": "string",
  "orderDirection": "string",
  "onlyMy": "boolean"
}
```

#|
||Field | Description ||
|| collectionId | **string \| null** ||
|| includePermissionsInfo | **boolean** ||
|| filterString | **string** ||
|| page | **number** ||
|| pageSize | **number** ||
|| orderField | **enum**

- `title`
- `createdAt`
- `updatedAt` ||
|| orderDirection | **enum**

- `asc`
- `desc` ||
|| onlyMy | **boolean** ||
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
      "status": "string",
      "permissions": {
        "listAccessBindings": "boolean",
        "updateAccessBindings": "boolean",
        "limitedView": "boolean",
        "view": "boolean",
        "update": "boolean",
        "copy": "boolean",
        "move": "boolean",
        "publish": "boolean",
        "embed": "boolean",
        "delete": "boolean"
      }
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| workbooks[] | **[WorkbooksItem](#WorkbooksItem)**

Required field.  ||
|| nextPageToken | **string** ||
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
|| permissions | **[Permissions](#Permissions)**

Required field.  ||
|#

## Meta0 {#Meta0}

#|
||Field | Description ||
|| importId | **string** ||
|#

## Permissions {#Permissions}

#|
||Field | Description ||
|| listAccessBindings | **boolean**

Required field.  ||
|| updateAccessBindings | **boolean**

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
|| publish | **boolean**

Required field.  ||
|| embed | **boolean**

Required field.  ||
|| delete | **boolean**

Required field.  ||
|#