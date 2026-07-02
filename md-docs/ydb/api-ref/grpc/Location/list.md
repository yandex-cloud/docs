[Документация Yandex Cloud](../../../../index.md) > [Yandex Managed Service for YDB](../../../index.md) > [Справочник API Yandex Cloud для Managed Service for YDB](../../overview.md) > [gRPC (англ.)](../index.md) > [Location](index.md) > List

# Managed Service for YDB API, gRPC: LocationService.List

Returns the list of available locations.

## gRPC request

**rpc List ([ListLocationsRequest](#yandex.cloud.ydb.v1.ListLocationsRequest)) returns ([ListLocationsResponse](#yandex.cloud.ydb.v1.ListLocationsResponse))**

## ListLocationsRequest {#yandex.cloud.ydb.v1.ListLocationsRequest}

```json
{
  "page_size": "int64",
  "page_token": "string"
}
```

#|
||Field | Description ||
|| page_size | **int64**

The maximum number of results per page that should be returned. If the number of available
results is larger than `page_size`, the service returns a `next_page_token` that can be used
to get the next page of results in subsequent ListLocations requests.
Acceptable values are 0 to 1000, inclusive. Default value: 100.

Acceptable values are 0 to 1000, inclusive. ||
|| page_token | **string**

Page token. Set `page_token` to the `next_page_token` returned by a previous ListLocations
request to get the next page of results.

The maximum string length in characters is 100. ||
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
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| locations[] | **[Location](#yandex.cloud.ydb.v1.Location)**

Requested list of locations. ||
|| next_page_token | **string**

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