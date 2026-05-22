---
editable: false
---

# DataLens API: Get workbook entries

## HTTP request

```
POST https://api.datalens.tech/rpc/getWorkbookEntries
```

## Body parameters

**Request schema: application/json**

```json
{
  "workbookId": "string",
  "includePermissionsInfo": "boolean",
  "page": "number",
  "pageSize": "number",
  "createdBy": "string",
  "scope": "unknown",
  "orderBy": {
    "field": "string",
    "direction": "string"
  },
  "filters": {
    "name": "string"
  }
}
```

#|
||Field | Description ||
|| workbookId | **string**

Required field.  ||
|| includePermissionsInfo | **boolean** ||
|| page | **number** ||
|| pageSize | **number** ||
|| createdBy | **string** ||
|| scope | Any of **string** \| **string** ||
|| orderBy | **[OrderBy](#OrderBy)**

Required field.  ||
|| filters | **[Filters](#Filters)**

Required field.  ||
|#

## OrderBy {#OrderBy}

#|
||Field | Description ||
|| field | **enum**

Required field. 

- `name`
- `createdAt` ||
|| direction | **enum**

Required field. 

- `asc`
- `desc` ||
|#

## Filters {#Filters}

#|
||Field | Description ||
|| name | **string**

Required field.  ||
|#

## Response {#200}

**HTTP Code: 200**

Response

**Response schema: application/json**

```json
{
  "entries": [
    {
      "entryId": "string",
      "scope": "string",
      "type": "string",
      "key": "string | null",
      "displayKey": "string | null",
      "createdBy": "string",
      "createdAt": "string",
      "updatedBy": "string",
      "updatedAt": "string",
      "savedId": "string | null",
      "publishedId": "string | null",
      "revId": "string",
      "meta": "object | null",
      "hidden": "boolean | null",
      "workbookId": "string | null",
      "collectionId": "string | null",
      "tenantId": "string | null",
      "isFavorite": "boolean",
      "isLocked": "boolean",
      "permissions": {
        "execute": "boolean",
        "read": "boolean",
        "edit": "boolean",
        "admin": "boolean"
      },
      "mirrored": "boolean | null"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| entries[] | **[EntriesItem](#EntriesItem)**

Required field.  ||
|| nextPageToken | **string** ||
|#

## EntriesItem {#EntriesItem}

#|
||Field | Description ||
|| entryId | **string**

Required field.  ||
|| scope | **enum**

Required field. 

- `dash`
- `widget`
- `dataset`
- `folder`
- `connection` ||
|| type | **string**

Required field.  ||
|| key | **string \| null**

Required field.  ||
|| displayKey | **string \| null**

Required field.  ||
|| createdBy | **string**

Required field.  ||
|| createdAt | **string**

Required field.  ||
|| updatedBy | **string**

Required field.  ||
|| updatedAt | **string**

Required field.  ||
|| savedId | **string \| null**

Required field.  ||
|| publishedId | **string \| null**

Required field.  ||
|| revId | **string**

Required field.  ||
|| meta | **object \| null**

Required field.  ||
|| hidden | **boolean \| null**

Required field.  ||
|| workbookId | **string \| null**

Required field.  ||
|| collectionId | **string \| null**

Required field.  ||
|| tenantId | **string \| null**

Required field.  ||
|| isFavorite | **boolean**

Required field.  ||
|| isLocked | **boolean**

Required field.  ||
|| permissions | **[Permissions](#Permissions)**

Required field.  ||
|| mirrored | **boolean \| null**

Required field.  ||
|#

## Permissions {#Permissions}

#|
||Field | Description ||
|| execute | **boolean**

Required field.  ||
|| read | **boolean**

Required field.  ||
|| edit | **boolean**

Required field.  ||
|| admin | **boolean**

Required field.  ||
|#