---
editable: false
---

# DataLens API: 🚧 [Experimental] Get wizard chart

## HTTP request

```
POST https://api.datalens.tech/rpc/getWizardChart
```

## Body parameters

**Request schema: application/json**

```json
{
  "chartId": "string",
  "workbookId": "string | null",
  "revId": "string",
  "includePermissions": "boolean",
  "includeLinks": "boolean",
  "includeFavorite": "boolean",
  "branch": "string"
}
```

#|
||Field | Description ||
|| chartId | **string**

Required field.  ||
|| workbookId | **string \| null** ||
|| revId | **string** ||
|| includePermissions | **boolean** ||
|| includeLinks | **boolean** ||
|| includeFavorite | **boolean** ||
|| branch | **enum**

- `saved`
- `published` ||
|#

## Response {#200}

**HTTP Code: 200**

Response

**Response schema: application/json**

```json
"unknown"
```