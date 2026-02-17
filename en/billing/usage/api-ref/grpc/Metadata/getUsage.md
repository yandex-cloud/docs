---
editable: false
---

# Billing Usage API, gRPC: MetadataService.GetUsage

GetUsage returns usage metadata including available clouds, services, SKUs, label keys, and date ranges
for a specific billing account and date range.

This method provides a view of all available entities
that can be used for usage reporting within the specified date range
for the billing account and all its sub-accounts including:
- List of available clouds in provided data range
- Available label keys that can be used for filtering or grouping
- Available services
- Available SKUs
- Available billing accounts (user billing account and his sub-accounts)

Implementation details:
- Empty cloud_id values are translated to a "Usage is out of scope of the Cloud" designation
- All data is filtered to only include items that had usage during the specified date range

Error handling:
- Returns INVALID_ARGUMENT if the request parameters fail validation
- Returns UNAUTHENTICATED if the user is not authenticated or the billing account does not exist
- Returns PERMISSION_DENIED if the user lacks required permissions
- Returns INTERNAL for internal server errors

Required permissions:
- `billing.accounts.getReport` on the specified billing account

## gRPC request

**rpc GetUsage ([GetUsageRequest](#yandex.cloud.billing.usage_records.v1.GetUsageRequest)) returns ([GetUsageResponse](#yandex.cloud.billing.usage_records.v1.GetUsageResponse))**

## GetUsageRequest {#yandex.cloud.billing.usage_records.v1.GetUsageRequest}

```json
{
  "billing_account_id": "string",
  "start_date": "google.protobuf.Timestamp",
  "end_date": "google.protobuf.Timestamp"
}
```

GetUsageRequest request for retrieving usage metadata

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
|#

## GetUsageResponse {#yandex.cloud.billing.usage_records.v1.GetUsageResponse}

```json
{
  "clouds": [
    {
      "id": "string",
      "name": "string"
    }
  ],
  "label_keys": [
    "string"
  ],
  "services": [
    {
      "id": "string",
      "name": "string",
      "description": "string"
    }
  ],
  "skus": [
    {
      "id": "string",
      "name": "string",
      "ru_translation": "string",
      "en_translation": "string",
      "pricing_unit": "string",
      "service_id": "string"
    }
  ],
  "billing_accounts": [
    {
      "id": "string",
      "name": "string"
    }
  ]
}
```

Response for usage metadata request

#|
||Field | Description ||
|| clouds[] | **[Cloud](#yandex.cloud.billing.usage_records.v1.Cloud)**

List of available clouds for the current user/context (billing_account_id with sub-accounts)
Contains cloud entities that the user has access to within the specified date range.

Note: Empty cloud_id values are considered as "consumption outside the cloud"
and represented with an empty string id and name "Usage is out of scope of the Cloud" ||
|| label_keys[] | **string**

List of available label keys for the current user/context (billing_account_id with sub-accounts)
Contains all label keys that exist in usage records
within the specified date range.
These keys can be used for filtering and grouping in reports or
passed to the GetLabel method to retrieve possible values. ||
|| services[] | **[Service](#yandex.cloud.billing.usage_records.v1.Service)**

List of available services for the current user/context (billing_account_id with sub-accounts)
Contains service entities with their IDs, names and descriptions that
have usage records within the specified billing account and date range.
Services represent the top-level grouping of cloud offerings. ||
|| skus[] | **[SKU](#yandex.cloud.billing.usage_records.v1.SKU)**

List of available SKUs for the current user/context (billing_account_id with sub-accounts)
Contains SKU entities with their IDs, names, translations and pricing units
that have usage records within the specified billing account and date range.
SKUs represent specific service offerings ||
|| billing_accounts[] | **[BillingAccount](#yandex.cloud.billing.usage_records.v1.BillingAccount)**

List of available BillingAccounts for the current user/context (billing_account_id with sub-accounts)
Contains billing account entities that the user has access to and
that have usage records within the specified date range.
Includes both the main account and any sub-accounts. ||
|#

## Cloud {#yandex.cloud.billing.usage_records.v1.Cloud}

Represents a cloud entity

#|
||Field | Description ||
|| id | **string**

Unique identifier of the cloud entity. ||
|| name | **string**

Human-readable display name of the cloud. ||
|#

## Service {#yandex.cloud.billing.usage_records.v1.Service}

Represents a service entity

#|
||Field | Description ||
|| id | **string**

Unique identifier of the service entity. ||
|| name | **string**

Service display name. ||
|| description | **string**

Service description. ||
|#

## SKU {#yandex.cloud.billing.usage_records.v1.SKU}

Represents a SKU (Stock Keeping Unit)

#|
||Field | Description ||
|| id | **string**

Unique identifier of the entity (SKU). ||
|| name | **string**

Product (SKU) name. ||
|| ru_translation | **string**

Russian-language display name ||
|| en_translation | **string**

English-language display name ||
|| pricing_unit | **string**

Unit of measurement for pricing (e.g., "hour", "byte", "1m*request"). ||
|| service_id | **string**

The service ID this SKU belongs to; ||
|#

## BillingAccount {#yandex.cloud.billing.usage_records.v1.BillingAccount}

Represents a billing account entity

#|
||Field | Description ||
|| id | **string**

Unique identifier of the billing_account entity. ||
|| name | **string**

Human-readable display name of the billing account. ||
|#