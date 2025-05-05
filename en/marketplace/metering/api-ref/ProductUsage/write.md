---
editable: false
sourcePath: en/_api-ref/marketplace/metering/v1/metering/api-ref/ProductUsage/write.md
---

# Marketplace Metering API, REST: ProductUsage.Write

Writes product's usage (authenticated by publisher's service account)

## HTTP request

```
POST https://marketplace.{{ api-host }}/marketplace/metering/v1/productUsage/write
```

## Body parameters {#yandex.cloud.marketplace.metering.v1.WriteUsageRequest}

```json
{
  "dryRun": "boolean",
  "productInstanceId": "string",
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

#|
||Field | Description ||
|| dryRun | **boolean**

Do not write usage, only validate ||
|| productInstanceId | **string**

Required field. Marketplace Product Instance's ID ||
|| usageRecords[] | **[UsageRecord](#yandex.cloud.marketplace.metering.v1.UsageRecord)**

List of product usage records (up to 25 per request) ||
|#

## UsageRecord {#yandex.cloud.marketplace.metering.v1.UsageRecord}

#|
||Field | Description ||
|| uuid | **string**

Required field. Unique identifier of the usage record (UUID format). ||
|| skuId | **string**

Required field. Consumed Marketplace SKU ID, linked to `UsageRecord.product_id`. ||
|| quantity | **string** (int64)

Quantity of SKU consumed, measured in `sku.usage_unit` units (e.g. bytes). ||
|| timestamp | **string** (date-time)

Required field. Timestamp in UTC for which the usage is being reported.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|#

## Response {#yandex.cloud.marketplace.metering.v1.WriteUsageResponse}

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

#|
||Field | Description ||
|| accepted[] | **[AcceptedUsageRecord](#yandex.cloud.marketplace.metering.v1.AcceptedUsageRecord)**

List of accepted product usage records ||
|| rejected[] | **[RejectedUsageRecord](#yandex.cloud.marketplace.metering.v1.RejectedUsageRecord)**

List of rejected product usage records (with reason) ||
|#

## AcceptedUsageRecord {#yandex.cloud.marketplace.metering.v1.AcceptedUsageRecord}

#|
||Field | Description ||
|| uuid | **string**

Unique identifier of the usage record (UUID format). ||
|#

## RejectedUsageRecord {#yandex.cloud.marketplace.metering.v1.RejectedUsageRecord}

#|
||Field | Description ||
|| uuid | **string**

Unique identifier of the usage record (UUID format). ||
|| reason | **enum** (Reason)

The reason of rejection.

- `REASON_UNSPECIFIED`
- `DUPLICATE`
- `EXPIRED`
- `INVALID_TIMESTAMP`
- `INVALID_SKU_ID`
- `INVALID_PRODUCT_ID`
- `INVALID_QUANTITY`
- `INVALID_ID` ||
|#