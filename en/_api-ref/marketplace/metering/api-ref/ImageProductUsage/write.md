---
editable: false
---

# Marketplace Metering API, REST: ImageProductUsage.write
Writes image product's usage. Authentication is by user's service account.
 

 
## HTTP request {#https-request}
```
POST https://marketplace.{{ api-host }}/marketplace/v1/metering/imageProductUsage/write
```
 
## Body parameters {#body_params}
 
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

 
Field | Description
--- | ---
validateOnly | **boolean** (boolean)<br><p>Checks whether you have the access required for the emit usage.</p> 
productId | **string**<br><p>Required. Marketplace Product's ID.</p> <p>The maximum string length in characters is 50.</p> 
usageRecords[] | **object**<br><p>Required. List of product usage records (up to 25 per request).</p> <p>The number of elements must be in the range 1-25.</p> 
usageRecords[].<br>uuid | **string**<br><p>Required. Unique identifier of the usage record (UUID format).</p> <p>The maximum string length in characters is 36.</p> 
usageRecords[].<br>skuId | **string**<br><p>Required. Consumed Marketplace SKU ID, linked to ``UsageRecord.product_id``.</p> <p>The maximum string length in characters is 50.</p> 
usageRecords[].<br>quantity | **string** (int64)<br><p>Quantity of SKU consumed, measured in ``sku.usage_unit`` units (e.g. bytes).</p> <p>Value must be greater than 0.</p> 
usageRecords[].<br>timestamp | **string** (date-time)<br><p>Required. Timestamp in UTC for which the usage is being reported.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

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

 
Field | Description
--- | ---
accepted[] | **object**<br><p>List of accepted product usage records.</p> 
accepted[].<br>uuid | **string**<br><p>Unique identifier of the usage record (UUID format).</p> 
rejected[] | **object**<br><p>List of rejected product usage records (with reason).</p> 
rejected[].<br>uuid | **string**<br><p>Unique identifier of the usage record (UUID format).</p> 
rejected[].<br>reason | **string**<br><p>The reason of rejection.</p> 