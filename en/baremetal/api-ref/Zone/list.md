---
editable: false
apiPlayground:
  - url: https://baremetal.{{ api-host }}/baremetal/v1alpha/zones
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
            the service returns a [ListZonesResponse.nextPageToken](/docs/baremetal/api-ref/Zone/list#yandex.cloud.baremetal.v1alpha.ListZonesResponse)
            that can be used to get the next page of results in subsequent list requests.
            Default value is 20.
          type: string
          format: int64
        pageToken:
          description: |-
            **string**
            Page token. To get the next page of results, set `page_token` to the
            [ListZonesResponse.nextPageToken](/docs/baremetal/api-ref/Zone/list#yandex.cloud.baremetal.v1alpha.ListZonesResponse) returned by a previous list request.
          type: string
      additionalProperties: false
    body: null
    definitions: null
sourcePath: en/_api-ref/baremetal/v1alpha/api-ref/Zone/list.md
---

# BareMetal API, REST: Zone.List

Retrieves the list of Zone resources.

## HTTP request

```
GET https://baremetal.{{ api-host }}/baremetal/v1alpha/zones
```

## Query parameters {#yandex.cloud.baremetal.v1alpha.ListZonesRequest}

#|
||Field | Description ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is greater than `page_size`,
the service returns a [ListZonesResponse.nextPageToken](#yandex.cloud.baremetal.v1alpha.ListZonesResponse)
that can be used to get the next page of results in subsequent list requests.
Default value is 20. ||
|| pageToken | **string**

Page token. To get the next page of results, set `page_token` to the
[ListZonesResponse.nextPageToken](#yandex.cloud.baremetal.v1alpha.ListZonesResponse) returned by a previous list request. ||
|#

## Response {#yandex.cloud.baremetal.v1alpha.ListZonesResponse}

**HTTP Code: 200 - OK**

```json
{
  "zones": [
    {
      "id": "string"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| zones[] | **[Zone](#yandex.cloud.baremetal.v1alpha.Zone)**

List of Zone resources. ||
|| nextPageToken | **string**

Token for getting the next page of the list. If the number of results is greater than
[ListZonesRequest.pageSize](#yandex.cloud.baremetal.v1alpha.ListZonesRequest), use `next_page_token` as the value
for the [ListZonesRequest.pageToken](#yandex.cloud.baremetal.v1alpha.ListZonesRequest) parameter in the next list request.

Each subsequent page will have its own `next_page_token` to continue paging through the results. ||
|#

## Zone {#yandex.cloud.baremetal.v1alpha.Zone}

Availability zone.

#|
||Field | Description ||
|| id | **string**

ID of the zone. ||
|#