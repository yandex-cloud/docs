---
editable: false
---

# Billing Usage API, gRPC: MetadataService.GetCloud

GetCloud returns available folders for specified clouds within a billing account
with optional filtering by cloud IDs, folder IDs and pagination support.

This method returns a hierarchical view of clouds and their folders that the user
has access to within the specified date range. Results can be filtered by
specific cloud IDs and/or folder IDs, and pagination is supported for handling
large result sets.

Implementation details:
- The method result does not contain empty cloud id information
- Filtering is done using case-insensitive substring matching
- Only clouds with at least one folder are included in the response
- Folder pagination is based on folder IDs, ordered alphabetically
- NextPageToken is only returned when there are more results available
- Base64-encoded page tokens are used for pagination state

Error handling:
- Returns INVALID_ARGUMENT if the request parameters fail validation
- Returns UNAUTHENTICATED if the user is not authenticated or the billing account does not exist
- Returns PERMISSION_DENIED if the user lacks required permissions
- Returns INTERNAL for internal server errors

Required permissions:
- `billing.accounts.getReport` on the specified billing account

## gRPC request

**rpc GetCloud ([GetCloudRequest](#yandex.cloud.billing.usage_records.v1.GetCloudRequest)) returns ([GetCloudResponse](#yandex.cloud.billing.usage_records.v1.GetCloudResponse))**

## GetCloudRequest {#yandex.cloud.billing.usage_records.v1.GetCloudRequest}

```json
{
  "billing_account_id": "string",
  "start_date": "google.protobuf.Timestamp",
  "end_date": "google.protobuf.Timestamp",
  "cloud_ids": [
    "string"
  ],
  "folder_ids": [
    "string"
  ],
  "page_size": "int64",
  "page_token": "string"
}
```

Request for retrieving folder metadata

#|
||Field | Description ||
|| billing_account_id | **string**

Required field. Required. Billing account identifier.
The ID of the billing account to retrieve cloud and folder metadata for.
Must be a valid and accessible billing account ID. ||
|| start_date | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Required field. Start date for data retrieval.
The inclusive start of the date range for which to retrieve cloud and folder metadata.
Must be specified and cannot be empty.
The time portion is ignored; the date is considered to start at 00:00:00. ||
|| end_date | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Required field. End date for data retrieval.
The inclusive end of the date range for which to retrieve cloud and folder metadata.
Must be specified, cannot be empty, and must be greater than or equal to start_date.
The time portion is ignored; the date is considered to end at 23:59:59. ||
|| cloud_ids[] | **string**

Optional. List of cloud IDs to filter clouds by.
Note: cloud_id filtering supports case-insensitive substring matching.
No wildcards or regex patterns are supported - just simple substring matching.
The filter works with partial cloud IDs, and will match any cloud where
the provided substring appears anywhere in the cloud_id.
For example, filter "abc" will match cloud_ids like "abc123", "123abc", or "1abc2".
If empty, no filtering by cloud ID is applied. ||
|| folder_ids[] | **string**

Optional. List of folder IDs to filter folders by.
Note: folder_id filtering supports case-insensitive substring matching.
No wildcards or regex patterns are supported - just simple substring matching.
The filter works with partial folder IDs, and will match any folder where
the provided substring appears anywhere in the folder_id.
For example, filter "abc" will match folder_ids like "abc123", "123abc", or "1abc2".
If empty, no filtering by folder ID is applied. ||
|| page_size | **int64**

Optional. Page size for paginated results.
Specifies the maximum number of Folder objects to return per page.
Lack of page size value means 0 page size (0 label values in response)
Maximum allowed value: 10000. ||
|| page_token | **string**

Optional. Page token for paginated results.
Token from a previous GetCloudResponse used to retrieve the next page.
If empty, retrieves the first page.
The token encodes the pagination state. ||
|#

## GetCloudResponse {#yandex.cloud.billing.usage_records.v1.GetCloudResponse}

```json
{
  "items": [
    {
      "cloud": {
        "id": "string",
        "name": "string"
      },
      "folders": [
        {
          "id": "string",
          "name": "string"
        }
      ]
    }
  ],
  "next_page_token": "string"
}
```

Response for cloud metadata request

#|
||Field | Description ||
|| items[] | **[CloudInfo](#yandex.cloud.billing.usage_records.v1.GetCloudResponse.CloudInfo)**

List of clouds matching the request criteria
Contains CloudInfo objects for each cloud that matches the specified
filtering criteria

Note: only clouds with at least one folder are included in the response. ||
|| next_page_token | **string**

Token for getting the next page of results.
If empty, there are no more results.
Use this token in a subsequent request's page_token field to retrieve
the next page of results.
The token encodes the pagination state.

It should be passed verbatim in subsequent requests. ||
|#

## CloudInfo {#yandex.cloud.billing.usage_records.v1.GetCloudResponse.CloudInfo}

Information about a cloud and its folders

#|
||Field | Description ||
|| cloud | **[Cloud](#yandex.cloud.billing.usage_records.v1.Cloud)**

Cloud information ||
|| folders[] | **[Folder](#yandex.cloud.billing.usage_records.v1.Folder)**

List of folders belonging to this cloud
Contains folder entities that belong to this cloud
and match any folder ID filtering criteria from the request.
The list is sorted by folder ID in ascending order.

Only folders that had usage during the specified date range are included. ||
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

## Folder {#yandex.cloud.billing.usage_records.v1.Folder}

Represents a folder entity

#|
||Field | Description ||
|| id | **string**

Unique identifier of the folder entity. ||
|| name | **string**

Human-readable display name of the folder. ||
|#