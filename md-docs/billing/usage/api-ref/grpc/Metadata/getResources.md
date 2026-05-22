# Billing Usage API, gRPC: MetadataService.GetResources

GetResources returns available resources for specified service instances within a billing account
with optional filtering by service instance IDs, resource IDs and pagination support.

This method returns a hierarchical view of service instances and their resources that the user
has access to within the specified date range. Results can be filtered by
specific service instance IDs and/or resource IDs, and pagination is supported for handling
large result sets.

Implementation details:
- Filtering by resources is done using case-insensitive substring matching
- Filtering is done using case-insensitive substring matching
- Only service instances with at least one resource are included in the response
- Resource pagination is based on resource IDs, ordered alphabetically
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

**rpc GetResources ([GetResourcesRequest](#yandex.cloud.billing.usage_records.v1.GetResourcesRequest)) returns ([GetResourcesResponse](#yandex.cloud.billing.usage_records.v1.GetResourcesResponse))**

## GetResourcesRequest {#yandex.cloud.billing.usage_records.v1.GetResourcesRequest}

```json
{
  "billing_account_id": "string",
  "start_date": "google.protobuf.Timestamp",
  "end_date": "google.protobuf.Timestamp",
  "service_instances_ids": [
    "string"
  ],
  "resource_ids": [
    "string"
  ],
  "page_size": "int64",
  "page_token": "string"
}
```

GetResourcesRequest request for retrieving resources with associated service instances.
This message defines the parameters needed to fetch and filter resources
associated with a billing account within a date range.

#|
||Field | Description ||
|| billing_account_id | **string**

Required field. Required. Billing account identifier.
The ID of the billing account to retrieve resources for.
Must be a valid and accessible billing account ID. ||
|| start_date | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Required field. Start date for data retrieval.
The inclusive start of the date range for which to retrieve resources.
Must be specified and cannot be empty.
The time portion is ignored; the date is considered to start at 00:00:00. ||
|| end_date | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Required field. End date for data retrieval.
The inclusive end of the date range for which to retrieve resources.
Must be specified, cannot be empty, and must be greater than or equal to start_date.
The time portion is ignored; the date is considered to end at 23:59:59. ||
|| service_instances_ids[] | **string**

Optional. List of service instances IDs to filter service instances by.
Note: service_instances_ids filtering supports case-insensitive substring matching.
No wildcards or regex patterns are supported - just simple substring matching.
The filter works with partial service instances IDs, and will match any service instances where
the provided substring appears anywhere in the service_instances_id.
For example, filter "abc" will match service_instances_ids like "abc123", "123abc", or "1abc2".
If empty, no filtering by service instance ID is applied. ||
|| resource_ids[] | **string**

Optional. List of resource IDs to filter resources by.
Note: resource_ids filtering supports case-insensitive substring matching.
No wildcards or regex patterns are supported - just simple substring matching.
The filter works with partial resource IDs, and will match any resource where
the provided substring appears anywhere in the resource_ids.
For example, filter "abc" will match resource_ids like "abc123", "123abc", or "1abc2".
If empty, no filtering by resource ID is applied. ||
|| page_size | **int64**

Optional. Page size for paginated results.
Specifies the maximum number of resource IDs to return per page.
If not specified or set to 0, defaults to 10.
If greater than 10000, will be coerced down to 10000. ||
|| page_token | **string**

Optional. Page token for paginated results.
Token from a previous GetResourceIDsResponse used to retrieve the next page.
If empty, retrieves the first page.
The token encodes the pagination state. ||
|#

## GetResourcesResponse {#yandex.cloud.billing.usage_records.v1.GetResourcesResponse}

```json
{
  "items": [
    {
      "service_instance": {
        "id": "string",
        "type": "string",
        "name": "string",
        "billing_account_id": "string"
      },
      "resources": [
        {
          "id": "string",
          "name": "string",
          "service_instance_type": "string"
        }
      ]
    }
  ],
  "next_page_token": "string"
}
```

The response for resources request.
This message contains a list of resource IDs splited by service instances that match the search criteria
specified in the request, along with pagination information.

#|
||Field | Description ||
|| items[] | **[ServiceInstanceInfo](#yandex.cloud.billing.usage_records.v1.GetResourcesResponse.ServiceInstanceInfo)**

List of service instances matching the request criteria
Contains ServiceInstanceInfo objects for each service instance that matches the specified
filtering criteria
The list is sorted by service instance name in ascending order.

Note: only service instances with at least one resource are included in the response. ||
|| next_page_token | **string**

Token for getting the next page of results.
If empty, there are no more results.
Use this token in a subsequent request's page_token field to retrieve
the next page of results.
The token encodes the pagination state.

It should be passed verbatim in subsequent requests. ||
|#

## ServiceInstanceInfo {#yandex.cloud.billing.usage_records.v1.GetResourcesResponse.ServiceInstanceInfo}

Information about a service instances and its resources

#|
||Field | Description ||
|| service_instance | **[ServiceInstance](#yandex.cloud.billing.usage_records.v1.ServiceInstance)**

Service instance information ||
|| resources[] | **[Resource](#yandex.cloud.billing.usage_records.v1.Resource)**

List of resources belonging to this service instances
Contains resource entities that belong to this service instance
and match any resource ID filtering criteria from the request.
The list is sorted by resource ID in ascending order.

Only resources that had usage during the specified date range are included. ||
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

Human-readable display name of the service instance. ||
|| billing_account_id | **string**

Optional billing account identifier associated with this service instance
for requested consumption period. ||
|#

## Resource {#yandex.cloud.billing.usage_records.v1.Resource}

Represents a resource entity

#|
||Field | Description ||
|| id | **string**

Unique identifier of the resource entity. ||
|| name | **string**

Human-readable display name of the resource. ||
|| service_instance_type | **string**

Type of the service instance this resource is bound to (e.g. "cloud", "tracker", "datalens"). ||
|#