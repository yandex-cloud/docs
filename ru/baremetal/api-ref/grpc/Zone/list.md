---
editable: false
sourcePath: en/_api-ref-grpc/baremetal/v1alpha/api-ref/grpc/Zone/list.md
---

# BareMetal API, gRPC: ZoneService.List

Retrieves the list of Zone resources.

## gRPC request

**rpc List ([ListZonesRequest](#yandex.cloud.baremetal.v1alpha.ListZonesRequest)) returns ([ListZonesResponse](#yandex.cloud.baremetal.v1alpha.ListZonesResponse))**

## ListZonesRequest {#yandex.cloud.baremetal.v1alpha.ListZonesRequest}

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
the service returns a [ListZonesResponse.next_page_token](#yandex.cloud.baremetal.v1alpha.ListZonesResponse)
that can be used to get the next page of results in subsequent list requests.
Default value is 20. ||
|| page_token | **string**

Page token. To get the next page of results, set `page_token` to the
[ListZonesResponse.next_page_token](#yandex.cloud.baremetal.v1alpha.ListZonesResponse) returned by a previous list request. ||
|#

## ListZonesResponse {#yandex.cloud.baremetal.v1alpha.ListZonesResponse}

```json
{
  "zones": [
    {
      "id": "string"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| zones[] | **[Zone](#yandex.cloud.baremetal.v1alpha.Zone)**

List of Zone resources. ||
|| next_page_token | **string**

Token for getting the next page of the list. If the number of results is greater than
[ListZonesRequest.page_size](#yandex.cloud.baremetal.v1alpha.ListZonesRequest), use `next_page_token` as the value
for the [ListZonesRequest.page_token](#yandex.cloud.baremetal.v1alpha.ListZonesRequest) parameter in the next list request.

Each subsequent page will have its own `next_page_token` to continue paging through the results. ||
|#

## Zone {#yandex.cloud.baremetal.v1alpha.Zone}

Availability zone.

#|
||Field | Description ||
|| id | **string**

ID of the zone. ||
|#