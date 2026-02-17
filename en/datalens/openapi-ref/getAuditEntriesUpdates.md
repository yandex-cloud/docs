---
editable: false
---

# DataLens API: Get updated entries for audit

## HTTP request

Returns the updated DataLens entries for audit.

```
POST https://api.datalens.yandex.net/rpc/getAuditEntriesUpdates
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

Required field. Start date for filtering entries by `updatedAt`. ||
|| to | **string** (date-time)

End date for filtering entries by `updatedAt`. ||
|| limit | **number**

Maximum number of entries to return. ||
|| pageToken | **string**

Token for pagination. ||
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

Required field. List of entries. ||
|| nextPageToken | **string**

Token for retrieving the next page of results. ||
|#

## EntriesItem {#EntriesItem}

#|
||Field | Description ||
|| entryId | **string**

Required field. Unique identifier of the entry. ||
|| key | **string \| null**

Required field. Entry key identifier. ||
|| isDeleted | **boolean**

Required field. Flag indicating if the entry is deleted. ||
|| workbookId | **string \| null**

Required field. ID of the workbook the entry belongs to. ||
|| collectionId | **string \| null**

Required field. ID of the collection the entry belongs to. ||
|| scope | **enum**

Required field. Type of the entry:

- `dash` — dashboard;
- `widget` — chart;
- `dataset` — dataset;
- `folder` — folder;
- `connection` — connection;
- `report` — report. ||
|| type | **string \| null**

Required field. Specified type of the entry from scope (e.g. type of the connection or visualization type for charts). ||
|| updatedAt | **string**

Required field. Timestamp of the last update. ||
|| userId | **string**

Required field. ID of the user who made the change. ||
|#