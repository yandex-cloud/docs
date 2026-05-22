---
editable: false
---

# DataLens API: Get embedding secret

Returns the specified key for embedding.

## HTTP request

```
POST https://api.datalens.tech/rpc/getEmbeddingSecret
```

## Body parameters

**Request schema: application/json**

```json
{
  "embeddingSecretId": "string"
}
```

#|
||Field | Description ||
|| embeddingSecretId | **string**

Required field. ID of the key for embedding to retrieve. ||
|#

## Response {#200}

**HTTP Code: 200**

Response

**Response schema: application/json**

```json
{
  "embeddingSecretId": "string",
  "title": "string",
  "workbookId": "string",
  "createdBy": "string",
  "createdAt": "string"
}
```

#|
||Field | Description ||
|| embeddingSecretId | **string**

Required field. Unique identifier of the key for embedding. ||
|| title | **string**

Required field. Name of the key for embedding. ||
|| workbookId | **string**

Required field. ID of the workbook associated with the key for embedding. ||
|| createdBy | **string**

Required field. ID of the user who created the key for embedding. ||
|| createdAt | **string**

Required field. Date and time when the key for embedding was created. ||
|#