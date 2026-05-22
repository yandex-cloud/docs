---
editable: false
---

# DataLens API: Create collection

## HTTP request

```
POST https://api.datalens.tech/rpc/createCollection
```

## Body parameters

**Request schema: application/json**

```json
{
  "title": "string",
  "description": "string",
  "parentId": "string | null"
}
```

#|
||Field | Description ||
|| title | **string**

Required field.  ||
|| description | **string** ||
|| parentId | **string \| null**

Required field.  ||
|#

## Response {#200}

**HTTP Code: 200**

Response

**Response schema: application/json**

```json
{
  "collectionId": "string",
  "title": "string",
  "description": "string | null",
  "parentId": "string | null",
  "tenantId": "string",
  "createdBy": "string",
  "createdAt": "string",
  "updatedBy": "string",
  "updatedAt": "string",
  "meta": {
    "string": "unknown"
  },
  "operation": {
    "id": "string",
    "description": "string",
    "createdBy": "string",
    "createdAt": {
      "seconds": "string",
      "nanos": "number"
    },
    "modifiedAt": {
      "seconds": "string",
      "nanos": "number"
    },
    "metadata": {},
    "done": "boolean"
  }
}
```

#|
||Field | Description ||
|| collectionId | **string**

Required field.  ||
|| title | **string**

Required field.  ||
|| description | **string \| null**

Required field.  ||
|| parentId | **string \| null**

Required field.  ||
|| tenantId | **string**

Required field.  ||
|| createdBy | **string**

Required field.  ||
|| createdAt | **string**

Required field.  ||
|| updatedBy | **string**

Required field.  ||
|| updatedAt | **string**

Required field.  ||
|| meta | **object** (map<**string**, **unknown**>)

Required field.  ||
|| operation | **[Operation](#Operation)**

Required field.  ||
|#

## Operation {#Operation}

#|
||Field | Description ||
|| id | **string**

Required field.  ||
|| description | **string**

Required field.  ||
|| createdBy | **string**

Required field.  ||
|| createdAt | **[CreatedAt](#CreatedAt)**

Required field.  ||
|| modifiedAt | **[ModifiedAt](#ModifiedAt)**

Required field.  ||
|| metadata | **[Metadata](#Metadata)**

Required field.  ||
|| done | **boolean**

Required field.  ||
|#

## CreatedAt {#CreatedAt}

#|
||Field | Description ||
|| seconds | **string**

Required field.  ||
|| nanos | **number** ||
|#

## ModifiedAt {#ModifiedAt}

#|
||Field | Description ||
|| seconds | **string**

Required field.  ||
|| nanos | **number** ||
|#

## Metadata {#Metadata}

#|
||Field | Description ||
|| Empty | > ||
|#