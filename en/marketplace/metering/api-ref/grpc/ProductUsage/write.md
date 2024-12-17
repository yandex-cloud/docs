---
editable: false
sourcePath: en/_api-ref-grpc/marketplace/metering/v1/metering/api-ref/grpc/ProductUsage/write.md
---

# Marketplace Metering API, gRPC: ProductUsageService.Write

Writes product's usage (authenticated by publisher's service account)

## gRPC request

**rpc Write ([WriteUsageRequest](#yandex.cloud.marketplace.metering.v1.WriteUsageRequest)) returns ([WriteUsageResponse](#yandex.cloud.marketplace.metering.v1.WriteUsageResponse))**

## WriteUsageRequest {#yandex.cloud.marketplace.metering.v1.WriteUsageRequest}

```json
{
  "dry_run": "bool",
  "product_instance_id": "string",
  "usage_records": [
    {
      "uuid": "string",
      "sku_id": "string",
      "quantity": "int64",
      "timestamp": "google.protobuf.Timestamp"
    }
  ]
}
```

#|
||Field | Description ||
|| dry_run | **bool**

Do not write usage, only validate ||
|| product_instance_id | **string**

Required field. Marketplace Product Instance's ID ||
|| usage_records[] | **[UsageRecord](#yandex.cloud.marketplace.metering.v1.UsageRecord)**

List of product usage records (up to 25 per request) ||
|#

## UsageRecord {#yandex.cloud.marketplace.metering.v1.UsageRecord}

#|
||Field | Description ||
|| uuid | **string**

Required field. Unique identifier of the usage record (UUID format). ||
|| sku_id | **string**

Required field. Consumed Marketplace SKU ID, linked to `UsageRecord.product_id`. ||
|| quantity | **int64**

Quantity of SKU consumed, measured in `sku.usage_unit` units (e.g. bytes). ||
|| timestamp | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Required field. Timestamp in UTC for which the usage is being reported. ||
|#

## WriteUsageResponse {#yandex.cloud.marketplace.metering.v1.WriteUsageResponse}

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