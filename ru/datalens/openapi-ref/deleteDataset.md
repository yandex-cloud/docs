---
editable: false
sourcePath: en/_api-ref/datalens-api/openapi-ref/deleteDataset.md
---

# DataLens API: Delete dataset

## HTTP request

Deletes the specified dataset.

```
POST https://api.datalens.yandex.net/rpc/deleteDataset
```

## Body parameters

**Request schema: application/json**

```json
{
  "datasetId": "string"
}
```

#|
||Field | Description ||
|| datasetId | **string**

Required field. ID of the dataset to delete. ||
|#

## Response {#200}

**HTTP Code: 200**

**Response schema: application/json**

```json
"unknown"
```