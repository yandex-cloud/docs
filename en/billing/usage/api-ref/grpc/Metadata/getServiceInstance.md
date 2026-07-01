---
editable: false
---

# Billing Usage API, gRPC: MetadataService.GetServiceInstance

GetServiceInstance returns service instance usage metadata for a specific billing account and date range.
This method provides a view of all available service instance entities
that can be used for usage reporting within the specified date range
for the billing account and all its sub-accounts including:
Implementation details:
- All data is filtered to only include items that had usage during the specified date range
Error handling:
- Returns INVALID_ARGUMENT if the request parameters fail validation
- Returns UNAUTHENTICATED if the user is not authenticated or the billing account does not exist
- Returns PERMISSION_DENIED if the user lacks required permissions
- Returns INTERNAL for internal server errors
This method supports additional filtering by service_instance_ids.
These filters work as supplementary conditions to the primary billing_account_id and date range filters.
When provided, they further narrow down the results by applying additional OR conditions for each filter type.
Required permissions:
- `billing.accounts.getReport` or `billingInternal.accounts.getReport` on the specified billing account

## gRPC request

**rpc GetServiceInstance ([GetServiceInstanceRequest](#yandex.cloud.billing.usage_records.v1.GetServiceInstanceRequest)) returns ([GetServiceInstanceResponse](#yandex.cloud.billing.usage_records.v1.GetServiceInstanceResponse))**

## GetServiceInstanceRequest {#yandex.cloud.billing.usage_records.v1.GetServiceInstanceRequest}

```json
{
  "billing_account_id": "string",
  "start_date": "google.protobuf.Timestamp",
  "end_date": "google.protobuf.Timestamp",
  "service_instance_ids": [
    "string"
  ]
}
```

GetServiceInstanceRequest request for retrieving service instance usage metadata

#|
||Field | Description ||
|| billing_account_id | **string**

Required field. Required. Billing account identifier.
The ID of the billing account to retrieve usage metadata for.
Must be a valid and accessible billing account ID. ||
|| start_date | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Required field. Start date for data retrieval.
The inclusive start of the date range for which to retrieve usage metadata.
Must be specified and cannot be empty.
The time portion is ignored; the date is considered to start at 00:00:00. ||
|| end_date | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Required field. End date for data retrieval.
The inclusive end of the date range for which to retrieve usage metadata.
Must be specified, cannot be empty, and must be greater than or equal to start_date.
The time portion is ignored; the date is considered to end at 23:59:59. ||
|| service_instance_ids[] | **string**

Optional. Service instance IDs filter.
Additional filter that works alongside the billing_account_id and date range.
When specified, includes usage records where service_instance_id matches any of the provided values.
Acts as an OR condition (service_instance_id IN service_instance_ids).
If empty, this filter is not applied. ||
|#

## GetServiceInstanceResponse {#yandex.cloud.billing.usage_records.v1.GetServiceInstanceResponse}

```json
{
  "service_instances": [
    {
      "id": "string",
      "type": "string",
      "name": "string",
      "billing_account_id": "string"
    }
  ]
}
```

Response for service instance usage metadata request

#|
||Field | Description ||
|| service_instances[] | **[ServiceInstance](#yandex.cloud.billing.usage_records.v1.ServiceInstance)**

List of available service instances for the current user/context (billing_account_id with sub-accounts)
Contains service instance entities that the user has access to within the specified date range. ||
|#

## ServiceInstance {#yandex.cloud.billing.usage_records.v1.ServiceInstance}

Represents a service instance entity

#|
||Field | Description ||
|| id | **string**

Identifier of the service instance entity. ||
|| type | **string**

Type of the service instance: tracker, datalens, cloud, etc. ||
|| name | **string**

Human-readable display name of the serice instance. ||
|| billing_account_id | **string**

Optional billing account identifier associated with this service instance
for requested consumption period. ||
|#