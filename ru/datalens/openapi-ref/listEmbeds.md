---
editable: false
---

# DataLens API: List embeds

Lists embeddings of the specified entry.

## HTTP request

```
POST https://api.datalens.tech/rpc/listEmbeds
```

## Body parameters

**Request schema: application/json**

```json
{
  "entryId": "string"
}
```

#|
||Field | Description ||
|| entryId | **string**

Required field. ID of the entry to list embeddings for. ||
|#

## Response {#200}

**HTTP Code: 200**

Response

**Response schema: application/json**

```json
"array"
```