---
editable: false
---

# DataLens API: Create embedding secret

Creates the key for embedding.

## HTTP request

```
POST https://api.datalens.tech/rpc/createEmbeddingSecret
```

## Body parameters

**Request schema: application/json**

```json
{
  "title": "string",
  "workbookId": "string"
}
```

#|
||Field | Description ||
|| title | **string**

Required field. Name of the key for embedding to be created. ||
|| workbookId | **string**

Required field. ID of the workbook to associate with the key for embedding. ||
|#

## Response {#200}

**HTTP Code: 200**

Response

**Response schema: application/json**

```json
{
  "embeddingSecretId": "string",
  "privateKey": "string"
}
```

#|
||Field | Description ||
|| embeddingSecretId | **string**

Required field. ID of the newly created key for embedding. ||
|| privateKey | **string**

Required field. Private key for accessing the embedding. ||
|#