---
editable: false
---

# DataLens API: Delete wizard chart

## HTTP request

Deletes the specified wizard chart.

```
POST https://api.datalens.yandex.net/rpc/deleteWizardChart
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

Required field. ID of the wizard chart to delete. ||
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