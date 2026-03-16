---
editable: false
---

# DataLens API: Delete embedding secret

Deletes the specified key for embedding.

## HTTP request

```
POST https://api.datalens.tech/rpc/deleteEmbeddingSecret
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

Required field. ID of the key for embedding to delete. ||
|#

## Response {#200}

**HTTP Code: 200**

Response

**Response schema: application/json**

```json
{
  "embeddingSecretId": "string"
}
```

#|
||Field | Description ||
|| embeddingSecretId | **string**

Required field. ID of the deleted key for embedding. ||
|#