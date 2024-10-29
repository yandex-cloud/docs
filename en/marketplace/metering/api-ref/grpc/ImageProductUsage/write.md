---
editable: false
sourcePath: en/_api-ref-grpc/marketplace/metering/v1/metering/api-ref/grpc/ImageProductUsage/write.md
---

# Marketplace Metering API, gRPC: ImageProductUsageService.Write {#Write}

Writes image product's usage. Authentication is by user's service account.

## gRPC request

**rpc Write ([WriteImageProductUsageRequest](#yandex.cloud.marketplace.metering.v1.WriteImageProductUsageRequest)) returns ([WriteImageProductUsageResponse](#yandex.cloud.marketplace.metering.v1.WriteImageProductUsageResponse))**

## WriteImageProductUsageRequest {#yandex.cloud.marketplace.metering.v1.WriteImageProductUsageRequest}

```json
{
  "validateOnly": "bool",
  "productId": "string",
  "usageRecords": [
    {
      "uuid": "string",
      "skuId": "string",
      "quantity": "int64",
      "timestamp": "google.protobuf.Timestamp"
    }
  ]
}
```

#|
||Field | Description ||
|| validateOnly | **bool**

Checks whether you have the access required for the emit usage. ||
|| productId | **string**

Required field. Marketplace Product's ID. ||
|| usageRecords[] | **[UsageRecord](#yandex.cloud.marketplace.metering.v1.UsageRecord)**

List of product usage records (up to 25 per request). ||
|#

## UsageRecord {#yandex.cloud.marketplace.metering.v1.UsageRecord}

#|
||Field | Description ||
|| uuid | **string**

Required field. Unique identifier of the usage record (UUID format). ||
|| skuId | **string**

Required field. Consumed Marketplace SKU ID, linked to `UsageRecord.product_id`. ||
|| quantity | **int64**

Quantity of SKU consumed, measured in `sku.usage_unit` units (e.g. bytes). ||
|| timestamp | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Required field. Timestamp in UTC for which the usage is being reported. ||
|#

## WriteImageProductUsageResponse {#yandex.cloud.marketplace.metering.v1.WriteImageProductUsageResponse}

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
      "reason": "Reason"
    }
  ]
}
```

#|
||Field | Description ||
|| accepted[] | **[AcceptedUsageRecord](#yandex.cloud.marketplace.metering.v1.AcceptedUsageRecord)**

List of accepted product usage records. ||
|| rejected[] | **[RejectedUsageRecord](#yandex.cloud.marketplace.metering.v1.RejectedUsageRecord)**

List of rejected product usage records (with reason). ||
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
|| reason | enum **Reason**

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