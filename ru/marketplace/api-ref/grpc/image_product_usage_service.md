---
editable: false
sourcePath: en/_api-ref-grpc/marketplace/metering-api/api-ref/grpc/image_product_usage_service.md
---

# Marketplace Metering API, gRPC: ImageProductUsageService

A set of methods for managing image product's usage.

| Call | Description |
| --- | --- |
| [Write](#Write) | Writes image product's usage. |

## Calls ImageProductUsageService {#calls}

## Write {#Write}

Writes image product's usage. Authentication is by user's service account.

**rpc Write ([WriteImageProductUsageRequest](#WriteImageProductUsageRequest)) returns ([WriteImageProductUsageResponse](#WriteImageProductUsageResponse))**

### WriteImageProductUsageRequest {#WriteImageProductUsageRequest}

Field | Description
--- | ---
validate_only | **bool**<br>Checks whether you have the access required for the emit usage. 
product_id | **string**<br>Required. Marketplace Product's ID. The maximum string length in characters is 50.
usage_records[] | **[UsageRecord](#UsageRecord)**<br>List of product usage records (up to 25 per request). The number of elements must be in the range 1-25.


### UsageRecord {#UsageRecord}

Field | Description
--- | ---
uuid | **string**<br>Required. Unique identifier of the usage record (UUID format). The maximum string length in characters is 36.
sku_id | **string**<br>Required. Consumed Marketplace SKU ID, linked to `UsageRecord.product_id`. The maximum string length in characters is 50.
quantity | **int64**<br>Quantity of SKU consumed, measured in `sku.usage_unit` units (e.g. bytes). Value must be greater than 0.
timestamp | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Required. Timestamp in UTC for which the usage is being reported. 


### WriteImageProductUsageResponse {#WriteImageProductUsageResponse}

Field | Description
--- | ---
accepted[] | **AcceptedUsageRecord**<br>List of accepted product usage records. 
rejected[] | **RejectedUsageRecord**<br>List of rejected product usage records (with reason). 


### AcceptedUsageRecord {#AcceptedUsageRecord}

Field | Description
--- | ---
uuid | **string**<br>Unique identifier of the usage record (UUID format). 


### RejectedUsageRecord {#RejectedUsageRecord}

Field | Description
--- | ---
uuid | **string**<br>Unique identifier of the usage record (UUID format). 
reason | enum **Reason**<br>The reason of rejection. 


