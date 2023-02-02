---
editable: false
---

# Write method

Writes product image usage statistics. A user's service account is used for authentication.

## HTTP request {#https-request}

```
POST https://marketplace.api.cloud.yandex.net/marketplace/v1/metering/imageProductUsage/write
```

## Request parameters {#body_params}

```json
{
  "validateOnly": true,
  "productId": "string",
  "usageRecords": [
    {
      "uuid": "string",
      "skuId": "string",
      "quantity": "string",
      "timestamp": "string"
    }
  ]
}
```

| Field | Description |
| --- | --- |
| validateOnly | **boolean** (boolean)<br><p>A message with the `validateOnly: true` parameter checks if it's possible to send usage metrics.</p> |
| productId | **string**<br><p>Required field. Marketplace product ID.</p> <p>The maximum string length is 50 characters.</p> |
| usageRecords[] | **object**<br><p>Required field. List of product usage records (up to 25 records per request).</p> <p>List item numbers must be in the range from 1 to 25.</p> |
| usageRecords[].<br>uuid | **string**<br><p>Required field. Unique identifier of a usage record in UUID format.</p> <p>The maximum string length is 36 characters.</p> |
| usageRecords[].<br>skuId | **string**<br><p>Required field. Marketplace Sku ID indicating consumption, related to `UsageRecord.product_id`.</p> <p>The maximum string length is 50 characters.</p> |
| usageRecords[].<br>quantity | **string** (int64)<br><p>Number of consumed SKUs measured in `sku.usage_unit` (for example, bytes).</p> <p>The value must be greater than 0.</p> |
| usageRecords[].<br>timestamp | **string** (date-time)<br><p>Required field. Reporting period UTC Timestamp.</p> <p>String in the text format <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> |

## Response {#responses}

**HTTP Code: 200 — OK**

```json
{
  "accepted": [
    {
      "uuid": "string"
    }
  ],
  "rejected": [
    {
      "uuid": "string",
      "reason": "string"
    }
  ]
}
```


| Field | Description |
| --- | --- |
| accepted[] | **object**<br><p>List of accepted product consumption records.</p> |
| accepted[].<br>uuid | **string**<br><p>Unique ID of a consumption record in UUID format.</p> |
| rejected[] | **object**<br><p>List of rejected product consumption records with the reason specified.</p> |
| rejected[].<br>uuid | **string**<br><p>Unique ID of a consumption record in UUID format.</p> |
| rejected[].<br>reason | **string**<br><p>Reason for rejecting a record.</p> |