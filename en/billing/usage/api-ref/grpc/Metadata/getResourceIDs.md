---
editable: false
---

# Billing Usage API, gRPC: MetadataService.GetResourceIDs

GetResourceIDs returns all resource IDs for a specific billing account and date range
with pagination support.

This method retrieves a list of all resource IDs that have usage records
within the specified date range and billing account. The results can be
filtered by a case-insensitive substring search on the resource ID.

Implementation details:
- Filtering is done using case-insensitive substring matching
- Only resource IDs with actual usage in the period are returned

Error handling:
- Returns INVALID_ARGUMENT if the request parameters fail validation
- Returns UNAUTHENTICATED if the user is not authenticated or the billing account does not exist
- Returns PERMISSION_DENIED if the user lacks required permissions
- Returns INTERNAL for internal server errors

Required permissions:
- `billing.accounts.getReport` on the specified billing account

## gRPC request

**rpc GetResourceIDs ([GetResourceIDsRequest](#yandex.cloud.billing.usage_records.v1.GetResourceIDsRequest)) returns ([GetResourceIDsResponse](#yandex.cloud.billing.usage_records.v1.GetResourceIDsResponse))**

## GetResourceIDsRequest {#yandex.cloud.billing.usage_records.v1.GetResourceIDsRequest}

```json
{
  "billing_account_id": "string",
  "start_date": "google.protobuf.Timestamp",
  "end_date": "google.protobuf.Timestamp",
  "resource_id": "string",
  "page_size": "int64",
  "page_token": "string"
}
```

GetResourceIDsRequest request for retrieving resource IDs.
This message defines the parameters needed to fetch and filter resource IDs
associated with a billing account within a date range.

#|
||Field | Description ||
|| billing_account_id | **string**

Required field. Required. Billing account identifier.
The ID of the billing account to retrieve resource IDs for.
Must be a valid and accessible billing account ID. ||
|| start_date | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Required field. Start date for data retrieval.
The inclusive start of the date range for which to retrieve resource IDs.
Must be specified and cannot be empty.
The time portion is ignored; the date is considered to start at 00:00:00. ||
|| end_date | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Required field. End date for data retrieval.
The inclusive end of the date range for which to retrieve resource IDs.
Must be specified, cannot be empty, and must be greater than or equal to start_date.
The time portion is ignored; the date is considered to end at 23:59:59. ||
|| resource_id | **string**

Optional. Resource ID pattern for search filtering.
When provided, the response will include only resource IDs
that contain this string (case-insensitive substring match).
No wildcards or regex patterns are supported - just simple substring matching. ||
|| page_size | **int64**

Optional. Page size for paginated results.
Specifies the maximum number of resource IDs to return per page.
Lack of page size value means 0 page size (0 label values in response)
Maximum allowed value: 10000. ||
|| page_token | **string**

Optional. Page token for paginated results.
Token from a previous GetResourceIDsResponse used to retrieve the next page.
If empty, retrieves the first page.
The token encodes the pagination state. ||
|#

## GetResourceIDsResponse {#yandex.cloud.billing.usage_records.v1.GetResourceIDsResponse}

```json
{
  "resource_ids": [
    "string"
  ],
  "next_page_token": "string"
}
```

Response for resource IDs request.
This message contains a list of resource IDs that match the search criteria
specified in the request, along with pagination information.

#|
||Field | Description ||
|| resource_ids[] | **string**

List of resource IDs matching the request criteria.
These represent unique identifiers for resources within the billing account
that had usage during the specified date range.
If a resource_id filter was provided in the request, only IDs
containing that substring (case-insensitive) will be included.
Resource IDs are sorted alphabetically in ascending order. ||
|| next_page_token | **string**

Token for getting the next page of results.
This token should be passed in the page_token field of subsequent requests.
If empty, there are no more results available.
The token encodes the pagination state.

It should be passed verbatim in subsequent requests. ||
|#