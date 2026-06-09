# BareMetal API, REST: HardwarePool.List

Retrieves the list of HardwarePool resources.

## HTTP request

```
GET https://baremetal.{{ api-host }}/baremetal/v1alpha/hardwarePools
```

## Query parameters {#yandex.cloud.baremetal.v1alpha.ListHardwarePoolsRequest}

#|
||Field | Description ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is greater than `page_size`,
the service returns a [ListHardwarePoolsResponse.nextPageToken](#yandex.cloud.baremetal.v1alpha.ListHardwarePoolsResponse)
that can be used to get the next page of results in subsequent list requests.
Default value is 20.

The maximum value is 1000. ||
|| pageToken | **string**

Page token. To get the next page of results, set `page_token` to the
[ListHardwarePoolsResponse.nextPageToken](#yandex.cloud.baremetal.v1alpha.ListHardwarePoolsResponse) returned by a previous list request. ||
|#

## Response {#yandex.cloud.baremetal.v1alpha.ListHardwarePoolsResponse}

**HTTP Code: 200 - OK**

```json
{
  "hardwarePools": [
    {
      "id": "string",
      "zoneId": "string"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| hardwarePools[] | **[HardwarePool](#yandex.cloud.baremetal.v1alpha.HardwarePool)**

List of HardwarePool resources. ||
|| nextPageToken | **string**

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
|| zoneId | **string**

ID of the zone where the hardware pool is located.
To get the zone ID use a [ZoneService.List](../Zone/list.md#List) request. ||
|#