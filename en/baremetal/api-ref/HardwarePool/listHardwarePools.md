---
editable: false
apiPlayground:
  - url: https://baremetal.{{ api-host }}/baremetal/v2/zones/{zoneId}/hardwarePools
    method: get
    path:
      type: object
      properties:
        zoneId:
          description: |-
            **string**
            ID of the zone where the hardware pool is located.
            To get the zone ID, use a [ZoneService.List] request.
            The maximum string length in characters is 20.
          type: string
      additionalProperties: false
    query:
      type: object
      properties:
        pageSize:
          description: |-
            **string** (int64)
            The maximum number of results per page to return. If the number of available
            results is greater than `page_size`,
            the service returns a [ListHardwarePoolsResponse.nextPageToken](#yandex.cloud.baremetal.v2.ListHardwarePoolsResponse)
            that can be used to get the next page of results in subsequent list requests.
            Default value is 20.
            The maximum value is 1000.
          type: string
          format: int64
        pageToken:
          description: |-
            **string**
            Page token. To get the next page of results, set `page_token` to the
            [ListHardwarePoolsResponse.nextPageToken](#yandex.cloud.baremetal.v2.ListHardwarePoolsResponse) returned by a previous list request.
          type: string
      additionalProperties: false
    body: null
    definitions: null
---

# BareMetal API, REST: HardwarePool.ListHardwarePools

Retrieves the list of HardwarePool resources.

https://google.aip.dev/130 --)

## HTTP request

```
GET https://baremetal.{{ api-host }}/baremetal/v2/zones/{zoneId}/hardwarePools
```

## Path parameters

#|
||Field | Description ||
|| zoneId | **string**

Required field. ID of the zone where the hardware pool is located.

To get the zone ID, use a [ZoneService.List] request.

The maximum string length in characters is 20. ||
|#

## Query parameters {#yandex.cloud.baremetal.v2.ListHardwarePoolsRequest}

#|
||Field | Description ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is greater than `page_size`,
the service returns a [ListHardwarePoolsResponse.nextPageToken](#yandex.cloud.baremetal.v2.ListHardwarePoolsResponse)
that can be used to get the next page of results in subsequent list requests.
Default value is 20.

The maximum value is 1000. ||
|| pageToken | **string**

Page token. To get the next page of results, set `page_token` to the
[ListHardwarePoolsResponse.nextPageToken](#yandex.cloud.baremetal.v2.ListHardwarePoolsResponse) returned by a previous list request. ||
|#

## Response {#yandex.cloud.baremetal.v2.ListHardwarePoolsResponse}

**HTTP Code: 200 - OK**

```json
{
  "hardwarePools": [
    {
      "hardwarePoolId": "string",
      "zoneId": "string"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| hardwarePools[] | **[HardwarePool](#yandex.cloud.baremetal.v2.HardwarePool)**

List of HardwarePool resources. ||
|| nextPageToken | **string**

Token for getting the next page of the list. If the number of results is greater than
[ListHardwarePoolsRequest.pageSize](#yandex.cloud.baremetal.v2.ListHardwarePoolsRequest), use `next_page_token` as the value
for the [ListHardwarePoolsRequest.pageToken](#yandex.cloud.baremetal.v2.ListHardwarePoolsRequest) parameter in the next list request.

Each subsequent page will have its own `next_page_token` to continue paging through the results. ||
|#

## HardwarePool {#yandex.cloud.baremetal.v2.HardwarePool}

A HardwarePool resource.

#|
||Field | Description ||
|| hardwarePoolId | **string**

ID of the hardware pool. ||
|| zoneId | **string**

ID of the zone where the hardware pool is located.

To get the zone ID use a [ZoneService.List] request. ||
|#