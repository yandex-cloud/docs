---
editable: false
---

# DataLens API: Delete embed

Deletes the specified embedding.

## HTTP request

```
POST https://api.datalens.tech/rpc/deleteEmbed
```

## Body parameters

**Request schema: application/json**

```json
{
  "embedId": "string"
}
```

#|
||Field | Description ||
|| embedId | **string**

Required field. ID of the embedding to delete. ||
|#

## Response {#200}

**HTTP Code: 200**

Response

**Response schema: application/json**

```json
{
  "embedId": "string"
}
```

#|
||Field | Description ||
|| embedId | **string**

Required field. ID of the deleted embedding. ||
|#