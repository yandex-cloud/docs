---
editable: false
sourcePath: en/_api-ref-grpc/ydb/v1/api-ref/grpc/Location/list.md
---

# Managed Service for YDB API, gRPC: LocationService.List {#List}

Returns the list of available locations.

## gRPC request

**rpc List ([ListLocationsRequest](#yandex.cloud.ydb.v1.ListLocationsRequest)) returns ([ListLocationsResponse](#yandex.cloud.ydb.v1.ListLocationsResponse))**

## ListLocationsRequest {#yandex.cloud.ydb.v1.ListLocationsRequest}

```json
{
  "pageSize": "int64",
  "pageToken": "string"
}
```

#|
||Field | Description ||
|| pageSize | **int64**

The maximum number of results per page that should be returned. If the number of available
results is larger than `page_size`, the service returns a `next_page_token` that can be used
to get the next page of results in subsequent ListLocations requests.
Acceptable values are 0 to 1000, inclusive. Default value: 100. ||
|| pageToken | **string**

Page token. Set `page_token` to the `next_page_token` returned by a previous ListLocations
request to get the next page of results. ||
|#

## ListLocationsResponse {#yandex.cloud.ydb.v1.ListLocationsResponse}

```json
{
  "locations": [
    {
      "id": "string",
      "description": "string"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| locations[] | **[Location](#yandex.cloud.ydb.v1.Location)**

Requested list of locations. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for ListLocations requests,
if the number of results is larger than `page_size` specified in the request.
To get the next page, specify the value of `next_page_token` as a value for
the `page_token` parameter in the next ListLocations request. Subsequent ListLocations
requests will have their own `next_page_token` to continue paging through the results. ||
|#

## Location {#yandex.cloud.ydb.v1.Location}

#|
||Field | Description ||
|| id | **string** ||
|| description | **string** ||
|#