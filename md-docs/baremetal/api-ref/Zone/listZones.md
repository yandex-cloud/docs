[Документация Yandex Cloud](../../../index.md) > [Yandex BareMetal](../../index.md) > Концепции > Настройка и управление > Справочник API > API v2 > [REST (англ.)](../index.md) > [Zone](index.md) > ListZones

# BareMetal API, REST: Zone.ListZones


Retrieves the list of Zone resources.

## HTTP request

```
GET https://baremetal.api.cloud.yandex.net/baremetal/v2/zones
```

## Query parameters {#yandex.cloud.baremetal.v2.ListZonesRequest}

#|
||Field | Description ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is greater than `page_size`,
the service returns a [ListZonesResponse.nextPageToken](#yandex.cloud.baremetal.v2.ListZonesResponse)
that can be used to get the next page of results in subsequent list requests.
Default value is 20.

The maximum value is 1000. ||
|| pageToken | **string**

Page token. To get the next page of results, set `page_token` to the
[ListZonesResponse.nextPageToken](#yandex.cloud.baremetal.v2.ListZonesResponse) returned by a previous list request. ||
|#

## Response {#yandex.cloud.baremetal.v2.ListZonesResponse}

**HTTP Code: 200 - OK**

```json
{
  "zones": [
    {
      "zoneId": "string"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| zones[] | **[Zone](#yandex.cloud.baremetal.v2.Zone)**

List of Zone resources. ||
|| nextPageToken | **string**

Token for getting the next page of the list. If the number of results is greater than
[ListZonesRequest.pageSize](#yandex.cloud.baremetal.v2.ListZonesRequest), use `next_page_token` as the value
for the [ListZonesRequest.pageToken](#yandex.cloud.baremetal.v2.ListZonesRequest) parameter in the next list request.

Each subsequent page will have its own `next_page_token` to continue paging through the results. ||
|#

## Zone {#yandex.cloud.baremetal.v2.Zone}

Availability zone.

#|
||Field | Description ||
|| zoneId | **string**

ID of the Zone. ||
|#