[Документация Yandex Cloud](../../../../index.md) > [Yandex BareMetal](../../../index.md) > Концепции > Настройка и управление > Справочник API > API v2 > [gRPC (англ.)](../index.md) > [Zone](index.md) > ListZones

# BareMetal API, gRPC: ZoneService.ListZones


Retrieves the list of Zone resources.

## gRPC request

**rpc ListZones ([ListZonesRequest](#yandex.cloud.baremetal.v2.ListZonesRequest)) returns ([ListZonesResponse](#yandex.cloud.baremetal.v2.ListZonesResponse))**

## ListZonesRequest {#yandex.cloud.baremetal.v2.ListZonesRequest}

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
the service returns a [ListZonesResponse.next_page_token](#yandex.cloud.baremetal.v2.ListZonesResponse)
that can be used to get the next page of results in subsequent list requests.
Default value is 20.

The maximum value is 1000. ||
|| page_token | **string**

Page token. To get the next page of results, set `page_token` to the
[ListZonesResponse.next_page_token](#yandex.cloud.baremetal.v2.ListZonesResponse) returned by a previous list request. ||
|#

## ListZonesResponse {#yandex.cloud.baremetal.v2.ListZonesResponse}

```json
{
  "zones": [
    {
      "zone_id": "string"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| zones[] | **[Zone](#yandex.cloud.baremetal.v2.Zone)**

List of Zone resources. ||
|| next_page_token | **string**

Token for getting the next page of the list. If the number of results is greater than
[ListZonesRequest.page_size](#yandex.cloud.baremetal.v2.ListZonesRequest), use `next_page_token` as the value
for the [ListZonesRequest.page_token](#yandex.cloud.baremetal.v2.ListZonesRequest) parameter in the next list request.

Each subsequent page will have its own `next_page_token` to continue paging through the results. ||
|#

## Zone {#yandex.cloud.baremetal.v2.Zone}

Availability zone.

#|
||Field | Description ||
|| zone_id | **string**

ID of the Zone. ||
|#