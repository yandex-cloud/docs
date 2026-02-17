---
editable: false
---

# Billing Usage API, gRPC: MetadataService.GetLabel

GetLabel returns available label keys and values for a specific billing account
with pagination support.

This method retrieves all available label values for a specified label key
within the given date range. It supports filtering by label value substring
and provides pagination for handling large result sets.

The method can be used in several ways:
- With label_key only: Returns all values for that key with pagination
- With label_key and label_value: Returns array of matching labelValues with pagination
- With label_key and label_value_filter: Returns all values for that key with pagination
and a separate array of labelValues from the labelValueFilters parameter
- With label_key, label_value and label_value_filter: returns only an array of matching labelValues
with pagination and ignores labelValueFilters (i.e., labelValueFilters won't be returned)

Implementation details:
- Case-insensitive label value matching when label_value is provided
- When label_value is specified, label_value_filter is ignored
- Label values are sorted alphabetically
- Pagination occurs when results exceed page_size

Error handling:
- Returns INVALID_ARGUMENT if the request parameters fail validation
- Returns UNAUTHENTICATED if the user is not authenticated or the billing account does not exist
- Returns PERMISSION_DENIED if the user lacks required permissions
- Returns INTERNAL for internal server errors

Required permissions:
- `billing.accounts.getReport` on the specified billing account

## gRPC request

**rpc GetLabel ([GetLabelRequest](#yandex.cloud.billing.usage_records.v1.GetLabelRequest)) returns ([GetLabelResponse](#yandex.cloud.billing.usage_records.v1.GetLabelResponse))**

## GetLabelRequest {#yandex.cloud.billing.usage_records.v1.GetLabelRequest}

```json
{
  "billing_account_id": "string",
  "start_date": "google.protobuf.Timestamp",
  "end_date": "google.protobuf.Timestamp",
  "label_key": "string",
  "label_value": "string",
  "label_value_filter": [
    "string"
  ],
  "page_size": "int64",
  "page_token": "string"
}
```

Request for retrieving label metadata

#|
||Field | Description ||
|| billing_account_id | **string**

Required field. Required. Billing account identifier.
The ID of the billing account to retrieve label metadata for.
Must be a valid and accessible billing account ID. ||
|| start_date | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Required field. Start date for data retrieval.
The inclusive start of the date range for which to retrieve label metadata.
Must be specified and cannot be empty.
The time portion is ignored; the date is considered to start at 00:00:00. ||
|| end_date | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Required field. End date for data retrieval.
The inclusive end of the date range for which to retrieve label metadata.
Must be specified, cannot be empty, and must be greater than or equal to start_date.
The time portion is ignored; the date is considered to end at 23:59:59. ||
|| label_key | **string**

Required field. Label key to filter values for. If specified, response will contain values
for this specific key.
Must be a non-empty string representing a valid label key. ||
|| label_value | **string**

Optional. If provided along with label_key, the response will return
an array of matches for this label_value.
Used for exact matching of label values.
If specified, label_value_filter is ignored and pagination is not applied. ||
|| label_value_filter[] | **string**

Optional array of label values to filter results:
Returns in response as is if label_value is not provided, otherwise returns empty label_value_filter ||
|| page_size | **int64**

Optional. Page size for paginated results.
Specifies the maximum number of label values to return per page.
Lack of page size value means 0 page size (0 label values in response)
Maximum allowed value: 10000. ||
|| page_token | **string**

Optional. Page token for paginated results.
Token from a previous GetLabelResponse used to retrieve the next page.
If empty, retrieves the first page. ||
|#

## GetLabelResponse {#yandex.cloud.billing.usage_records.v1.GetLabelResponse}

```json
{
  "label_values": [
    "string"
  ],
  "label_value_filter": [
    "string"
  ],
  "next_page_token": "string"
}
```

Response for label metadata request

#|
||Field | Description ||
|| label_values[] | **string**

List of label values matching the request criteria
Contains label values that match the specified label key pattern.
Values are sorted alphabetically. ||
|| label_value_filter[] | **string**

List of label values from the label_value_filter in the request
Contains the same values as provided in the request's label_value_filter.
Included for convenience in the response.
This field is only populated when label_value_filter was specified in the request
and label_value was not specified. ||
|| next_page_token | **string**

Token for getting the next page of results.
If empty, there are no more results.
Use this token in a subsequent request's page_token field to retrieve
the next page of results.
The token encodes the pagination state.

It should be passed verbatim in subsequent requests. ||
|#