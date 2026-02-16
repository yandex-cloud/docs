---
editable: false
sourcePath: en/_api-ref/datalens-api/openapi-ref/deleteEditorChart.md
---

# DataLens API: Delete Editor chart

## HTTP request

Deletes the specified Editor chart.

```
POST https://api.datalens.yandex.net/rpc/deleteEditorChart
```

## Body parameters

**Request schema: application/json**

```json
{
  "chartId": "string"
}
```

#|
||Field | Description ||
|| chartId | **string**

Required field. ID of the Editor chart to delete. ||
|#

## Response {#200}

**HTTP Code: 200**

**Response schema: application/json**

```json
{}
```

#|
||Field | Description ||
|| Empty | > ||
|#