---
editable: false
---

# DataLens API: Create embed

Creates the specified embedding.

## HTTP request

```
POST https://api.datalens.tech/rpc/createEmbed
```

## Body parameters

**Request schema: application/json**

```json
{
  "title": "string",
  "embeddingSecretId": "string",
  "entryId": "string",
  "depsIds": [
    "string"
  ],
  "unsignedParams": [
    "string"
  ],
  "privateParams": [
    "string"
  ],
  "publicParamsMode": "boolean",
  "settings": {
    "enableExport": "boolean"
  }
}
```

#|
||Field | Description ||
|| title | **string**

Required field. Name of the embedding. ||
|| embeddingSecretId | **string**

Required field. ID of the key for embedding used for authentication. ||
|| entryId | **string**

Required field. ID of the entry to be privately embedded. ||
|| depsIds[] | **string**

Required field. Array of dependency entry IDs. ||
|| unsignedParams[] | **string**

Required field. Array of unsigned parameters to be provided in the embedding link. ||
|| privateParams[] | **string**

Required field. Array of signed parameters that are provided as part of the token. ||
|| publicParamsMode | **boolean**

Required field. Whether default parameters mode is enabled. ||
|| settings | **[Settings](#Settings)**

Required field. Embedding settings. ||
|#

## Settings {#Settings}

#|
||Field | Description ||
|| enableExport | **boolean**

Whether data export is enabled for the embedding. ||
|#

## Response {#200}

**HTTP Code: 200**

Response

**Response schema: application/json**

```json
{
  "embedId": "string",
  "title": "string",
  "embeddingSecretId": "string",
  "entryId": "string",
  "depsIds": [
    "string"
  ],
  "unsignedParams": [
    "string"
  ],
  "privateParams": [
    "string"
  ],
  "createdBy": "string",
  "createdAt": "string",
  "updatedAt": "string",
  "updatedBy": "string",
  "publicParamsMode": "boolean",
  "settings": {
    "enableExport": "boolean"
  }
}
```

#|
||Field | Description ||
|| embedId | **string**

Required field. Unique identifier of the embedding. ||
|| title | **string**

Required field. Name of the embedding. ||
|| embeddingSecretId | **string**

Required field. ID of the key for embedding used for authentication. ||
|| entryId | **string**

Required field. ID of the entry being privately embedded. ||
|| depsIds[] | **string**

Required field. Array of dependency entry IDs. ||
|| unsignedParams[] | **string**

Required field. Array of unsigned parameters to be provided in the embedding link. ||
|| privateParams[] | **string**

Required field. Array of signed parameters that are provided as part of the token. ||
|| createdBy | **string**

Required field. ID of the user who created the embedding. ||
|| createdAt | **string**

Required field. Timestamp when the embedding was created. ||
|| updatedAt | **string**

Required field. Timestamp when the embedding was last updated. ||
|| updatedBy | **string**

Required field. ID of the user who was the last to update the embedding. ||
|| publicParamsMode | **boolean**

Required field. Whether default parameters mode is enabled. ||
|| settings | **[Settings](#Settings-1)**

Required field. Embedding settings. ||
|#

## Settings {#Settings-1}

#|
||Field | Description ||
|| enableExport | **boolean**

Whether data export is enabled for the embedding. ||
|#