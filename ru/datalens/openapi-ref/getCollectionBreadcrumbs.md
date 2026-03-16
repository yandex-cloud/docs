---
editable: false
---

# DataLens API: Get collection breadcrumbs

## HTTP request

```
POST https://api.datalens.tech/rpc/getCollectionBreadcrumbs
```

## Body parameters

**Request schema: application/json**

```json
{
  "collectionId": "string",
  "includePermissionsInfo": "boolean"
}
```

#|
||Field | Description ||
|| collectionId | **string**

Required field.  ||
|| includePermissionsInfo | **boolean** ||
|#

## Response {#200}

**HTTP Code: 200**

Response

**Response schema: application/json**

```json
"array"
```