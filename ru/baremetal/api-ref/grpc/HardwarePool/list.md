---
editable: false
sourcePath: en/_api-ref-grpc/baremetal/v1alpha/api-ref/grpc/HardwarePool/list.md
---

# BareMetal API, gRPC: HardwarePoolService.List

Retrieves the list of HardwarePool resources.

## gRPC request

**rpc List ([ListHardwarePoolsRequest](#yandex.cloud.baremetal.v1alpha.ListHardwarePoolsRequest)) returns ([ListHardwarePoolsResponse](#yandex.cloud.baremetal.v1alpha.ListHardwarePoolsResponse))**

## ListHardwarePoolsRequest {#yandex.cloud.baremetal.v1alpha.ListHardwarePoolsRequest}

```json
{
  "page_size": "int64",
  "page_token": "string"
}
```

#|
||Field | Description ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is greater than `page_size`,
the service returns a [ListHardwarePoolsResponse.next_page_token](#yandex.cloud.baremetal.v1alpha.ListHardwarePoolsResponse)
that can be used to get the next page of results in subsequent list requests.
Default value is 20. ||
|| page_token | **string**

Page token. To get the next page of results, set `page_token` to the
[ListHardwarePoolsResponse.next_page_token](#yandex.cloud.baremetal.v1alpha.ListHardwarePoolsResponse) returned by a previous list request. ||
|#

## ListHardwarePoolsResponse {#yandex.cloud.baremetal.v1alpha.ListHardwarePoolsResponse}

```json
{
  "hardware_pools": [
    {
      "id": "string",
      "zone_id": "string"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| hardware_pools[] | **[HardwarePool](#yandex.cloud.baremetal.v1alpha.HardwarePool)**

List of HardwarePool resources. ||
|| next_page_token | **string**

Token for getting the next page of the list. If the number of results is greater than
[ListHardwarePoolsResponse.page_size], use `next_page_token` as the value
for the [ListHardwarePoolsResponse.page_token] parameter in the next list request.

Each subsequent page will have its own `next_page_token` to continue paging through the results. ||
|#

## HardwarePool {#yandex.cloud.baremetal.v1alpha.HardwarePool}

A HardwarePool resource.

#|
||Field | Description ||
|| id | **string**

ID of the hardware pool. ||
|| zone_id | **string**

ID of the zone where the hardware pool is located.

To get the zone ID use a [ZoneService.List](/docs/baremetal/api-ref/grpc/Zone/list#List) request. ||
|#