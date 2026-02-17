---
editable: false
---

# DataLens API: 🚧 [Experimental] Get QL chart

## HTTP request

Returns the specified QL chart.

```
POST https://api.datalens.yandex.net/rpc/getQLChart
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

Required field. ID of the QL chart to return. You can find it in the chart settings in DataLens interface. ||
|| workbookId | **string \| null** 

ID of the workbook the QL chart belongs to. If navigation across folders is enabled and the QL chart belongs to a folder, the value must be `null`. ||
|| revId | **string** 

Version ID for the QL chart. For details, see [documentation](https://docs.yandex-team.ru/cloud/datalens/concepts/chart/versioning).

If the field is empty, you will get the current version of the QL chart. ||
|| includePermissions | **boolean** 

Include information on configured permissions in the response. ||
|| includeLinks | **boolean** 

Include information on configured links in the response. ||
|| includeFavorite | **boolean** 

Include favorite status in the response. ||
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