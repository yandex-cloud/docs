---
editable: false
apiPlayground:
  - url: https://baremetal.{{ api-host }}/baremetal/v1alpha/hardwarePools
    method: get
    path: null
    query:
      type: object
      properties:
        pageSize:
          description: |-
            **string** (int64)
            The maximum number of results per page to return. If the number of available
            results is greater than `page_size`,
            the service returns a [ListHardwarePoolsResponse.nextPageToken](/docs/baremetal/api-ref/HardwarePool/list#yandex.cloud.baremetal.v1alpha.ListHardwarePoolsResponse)
            that can be used to get the next page of results in subsequent list requests.
            Default value is 20.
          type: string
          format: int64
        pageToken:
          description: |-
            **string**
            Page token. To get the next page of results, set `page_token` to the
            [ListHardwarePoolsResponse.nextPageToken](/docs/baremetal/api-ref/HardwarePool/list#yandex.cloud.baremetal.v1alpha.ListHardwarePoolsResponse) returned by a previous list request.
          type: string
      additionalProperties: false
    body: null
    definitions: null
sourcePath: en/_api-ref/baremetal/v1alpha/api-ref/HardwarePool/list.md
---

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
Default value is 20. ||
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

To get the zone ID use a [ZoneService.List](/docs/baremetal/api-ref/Zone/list#List) request. ||
|#