---
editable: false
---

# DataLens API: Get updated entries for audit

## HTTP request

```
POST https://api.datalens.tech/rpc/getAuditEntriesUpdates
```

## Body parameters

**Request schema: application/json**

```json
{
  "from": "string",
  "to": "string",
  "limit": "number",
  "pageToken": "string"
}
```

#|
||Field | Description ||
|| from | **string** (date-time)

Required field. Start date for filtering entries by updatedAt ||
|| to | **string** (date-time)

End date for filtering entries by updatedAt ||
|| limit | **number**

Maximum number of entries to return ||
|| pageToken | **string**

Token for pagination ||
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
      "key": "string | null",
      "isDeleted": "boolean",
      "workbookId": "string | null",
      "collectionId": "string | null",
      "scope": "string",
      "type": "string | null",
      "updatedAt": "string",
      "userId": "string"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| entries[] | **[EntriesItem](#EntriesItem)**

Required field.  ||
|| nextPageToken | **string**

Token for the next page of results ||
|#

## EntriesItem {#EntriesItem}

#|
||Field | Description ||
|| entryId | **string**

Required field. Unique identifier of the entry ||
|| key | **string \| null**

Required field. Entry key identifier ||
|| isDeleted | **boolean**

Required field. Flag indicating if the entry is deleted ||
|| workbookId | **string \| null**

Required field. ID of the associated workbook ||
|| collectionId | **string \| null**

Required field. ID of the associated collection ||
|| scope | **enum**

Required field. Scope of the entry

- `dash`
- `widget`
- `dataset`
- `folder`
- `connection`
- `report` ||
|| type | **string \| null**

Required field. Type of the entry ||
|| updatedAt | **string**

Required field. Timestamp of the last update ||
|| userId | **string**

Required field. ID of the user who made the change ||
|#