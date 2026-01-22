---
editable: false
sourcePath: en/_api-ref/datalens-api/openapi-ref/getEntriesRelations.md
---

# DataLens API: Get entries relations

## HTTP request

Returns the specified DataLens entries relations.

```
POST https://api.datalens.yandex.net/rpc/getEntriesRelations
```

## Body parameters

**Request schema: application/json**

```json
{
  "entryIds": [
    "string"
  ],
  "linkDirection": "string",
  "includePermissionsInfo": "boolean",
  "limit": "number",
  "pageToken": "string",
  "scope": "string"
}
```

#|
||Field | Description ||
|| entryIds[] | **string**

Required field. ID of the entries to get relations for. ||
|| linkDirection | **enum**

The direction of the link relatively to the original entry:

- `from` — entries that are linked to the original entry;
- `to` — the original entry is linked to the entries. ||
|| includePermissionsInfo | **boolean** 

Include permission information in the response. ||
|| limit | **number** 

Maximum number of results to return. ||
|| pageToken | **string** 

Token for retrieving the next page of results. ||
|| scope | **enum**

Type of the entry:

- `dash` — dashboard;
- `widget` — chart;
- `dataset` — dataset;
- `folder` — folder;
- `connection` — connection. ||
|#

## Response {#200}

**HTTP Code: 200**

Response

**Response schema: application/json**

```json
{
  "relations": [
    {
      "entryId": "string",
      "key": "string | null",
      "scope": "string",
      "type": "string",
      "createdAt": "string",
      "public": "boolean",
      "tenantId": "string | null",
      "workbookId": "string | null",
      "collectionId": "string | null",
      "isLocked": "boolean",
      "permissions": {
        "execute": "boolean",
        "read": "boolean",
        "edit": "boolean",
        "admin": "boolean"
      },
      "fullPermissions": {
        "listAccessBindings": "boolean",
        "updateAccessBindings": "boolean",
        "limitedView": "boolean",
        "view": "boolean",
        "update": "boolean",
        "copy": "boolean",
        "move": "boolean",
        "delete": "boolean",
        "createEntryBinding": "boolean",
        "createLimitedEntryBinding": "boolean"
      }
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| relations[] | **[RelationsItem](#RelationsItem)**

Required field. List of related entries. ||
|| nextPageToken | **string** 

Token for retrieving the next page of results. ||
|#

## RelationsItem {#RelationsItem}

#|
||Field | Description ||
|| entryId | **string**

Required field. Unique identifier of the entry. ||
|| key | **string \| null**

Required field. Key identifier of the entry. ||
|| scope | **enum**

Required field. Type of the entry:

- `dash` — dashboard;
- `widget` — chart;
- `dataset` — dataset;
- `folder` — folder;
- `connection` — connection. ||
|| type | **string**

Required field. Specified type of the entry from scope (e.g. type of the connection or visualization type for charts). ||
|| createdAt | **string**

Required field. Creation timestamp. ||
|| public | **boolean**

Required field. Indicates if the entry is public. ||
|| tenantId | **string \| null**

Required field. ID of the DataLens tenant. ||
|| workbookId | **string \| null**

Required field. ID of the workbook the entry belongs to. ||
|| collectionId | **string \| null**

Required field. ID of the collection the entry belongs to. ||
|| isLocked | **boolean** ||
|| permissions | **[Permissions](#Permissions)**

Required field. Basic permissions for the entry. ||
|| fullPermissions | **[FullPermissions](#FullPermissions)**

Required field. Full permissions for the entry. ||
|#

## Permissions {#Permissions}

#|
||Field | Description ||
|| execute | **boolean**

Required field. Permission to execute. ||
|| read | **boolean**

Required field. Permission to read. ||
|| edit | **boolean**

Required field. Permission to edit. ||
|| admin | **boolean**

Required field. Permission to administer. ||
|#

## FullPermissions {#FullPermissions}

#|
||Field | Description ||
|| listAccessBindings | **boolean**

Required field. Permission to list access bindings. ||
|| updateAccessBindings | **boolean**

Required field. Permission to update access bindings. ||
|| limitedView | **boolean**

Required field. Permission for limited viewing. ||
|| view | **boolean**

Required field. Permission to view. ||
|| update | **boolean**

Required field. Permission to update. ||
|| copy | **boolean**

Required field. Permission to copy. ||
|| move | **boolean**

Required field. Permission to move. ||
|| delete | **boolean**

Required field. Permission to delete. ||
|| createEntryBinding | **boolean**

Required field. Permission to create entry binding. ||
|| createLimitedEntryBinding | **boolean**

Required field. Permission to create limited entry binding. ||
|#