---
editable: false
---

# BareMetal API, gRPC: HardwarePoolService.ListHardwarePools

Retrieves the list of HardwarePool resources.


## gRPC request

**rpc ListHardwarePools ([ListHardwarePoolsRequest](#yandex.cloud.baremetal.v2.ListHardwarePoolsRequest)) returns ([ListHardwarePoolsResponse](#yandex.cloud.baremetal.v2.ListHardwarePoolsResponse))**

## ListHardwarePoolsRequest {#yandex.cloud.baremetal.v2.ListHardwarePoolsRequest}

```json
{
  "zone_id": "string",
  "page_size": "int64",
  "page_token": "string"
}
```

#|
||Field | Description ||
|| zone_id | **string**

ID of the zone where the hardware pool is located.

To get the zone ID, use a [ZoneService.List] request.

The maximum string length in characters is 20. ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is greater than `page_size`,
the service returns a [ListHardwarePoolsResponse.next_page_token](#yandex.cloud.baremetal.v2.ListHardwarePoolsResponse)
that can be used to get the next page of results in subsequent list requests.
Default value is 20.

The maximum value is 1000. ||
|| page_token | **string**

Page token. To get the next page of results, set `page_token` to the
[ListHardwarePoolsResponse.next_page_token](#yandex.cloud.baremetal.v2.ListHardwarePoolsResponse) returned by a previous list request. ||
|#

## ListHardwarePoolsResponse {#yandex.cloud.baremetal.v2.ListHardwarePoolsResponse}

```json
{
  "hardware_pools": [
    {
      "hardware_pool_id": "string",
      "zone_id": "string"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| hardware_pools[] | **[HardwarePool](#yandex.cloud.baremetal.v2.HardwarePool)**

List of HardwarePool resources. ||
|| next_page_token | **string**

Token for getting the next page of the list. If the number of results is greater than
[ListHardwarePoolsRequest.page_size](#yandex.cloud.baremetal.v2.ListHardwarePoolsRequest), use `next_page_token` as the value
for the [ListHardwarePoolsRequest.page_token](#yandex.cloud.baremetal.v2.ListHardwarePoolsRequest) parameter in the next list request.

Each subsequent page will have its own `next_page_token` to continue paging through the results. ||
|#

## HardwarePool {#yandex.cloud.baremetal.v2.HardwarePool}

A HardwarePool resource.

#|
||Field | Description ||
|| hardware_pool_id | **string**

ID of the hardware pool. ||
|| zone_id | **string**

ID of the zone where the hardware pool is located.

To get the zone ID use a [ZoneService.List] request. ||
|#