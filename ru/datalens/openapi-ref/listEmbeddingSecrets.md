---
editable: false
---

# DataLens API: List embedding secrets

Lists keys for embedding of the specified workbook.

## HTTP request

```
POST https://api.datalens.tech/rpc/listEmbeddingSecrets
```

## Body parameters

**Request schema: application/json**

```json
{
  "workbookId": "string"
}
```

#|
||Field | Description ||
|| workbookId | **string**

Required field. ID of the workbook to list its keys for embedding. ||
|#

## Response {#200}

**HTTP Code: 200**

Response

**Response schema: application/json**

```json
"array"
```