---
editable: false
---

# DataLens API: Create workbook

## HTTP request

```
POST https://api.datalens.tech/rpc/createWorkbook
```

## Body parameters

**Request schema: application/json**

```json
{
  "collectionId": "string | null",
  "title": "string",
  "description": "string"
}
```

#|
||Field | Description ||
|| collectionId | **string \| null** ||
|| title | **string**

Required field.  ||
|| description | **string** ||
|#

## Response {#200}

**HTTP Code: 200**

Response

**Response schema: application/json**

```json
{
  "workbookId": "string",
  "collectionId": "string | null",
  "title": "string",
  "description": "string | null",
  "tenantId": "string",
  "meta": "unknown",
  "createdBy": "string",
  "createdAt": "string",
  "updatedBy": "string",
  "updatedAt": "string",
  "status": "string",
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
|| workbookId | **string**

Required field.  ||
|| collectionId | **string \| null**

Required field.  ||
|| title | **string**

Required field.  ||
|| description | **string \| null**

Required field.  ||
|| tenantId | **string**

Required field.  ||
|| meta | All of **[Meta0](#Meta0)** & **object** (map<**string**, **unknown**>) ||
|| createdBy | **string**

Required field.  ||
|| createdAt | **string**

Required field.  ||
|| updatedBy | **string**

Required field.  ||
|| updatedAt | **string**

Required field.  ||
|| status | **enum**

- `creating`
- `deleting`
- `active` ||
|| operation | **[Operation](#Operation)**

Required field.  ||
|#

## Meta0 {#Meta0}

#|
||Field | Description ||
|| importId | **string** ||
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