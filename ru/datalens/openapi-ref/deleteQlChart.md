---
editable: false
sourcePath: en/_api-ref/datalens-api/openapi-ref/deleteQlChart.md
---

# DataLens API: Delete QL chart

## HTTP request

Deletes the specified QL chart.

```
POST https://api.datalens.yandex.net/rpc/deleteQLChart
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

Required field. ID of the QL chart to delete. ||
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