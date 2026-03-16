---
editable: false
---

# DataLens API: Delete editor chart

Deletes the specified Editor chart.

## HTTP request

```
POST https://api.datalens.tech/rpc/deleteEditorChart
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

Response

**Response schema: application/json**

```json
{}
```

#|
||Field | Description ||
|| Empty | > ||
|#