[Документация Yandex Cloud](../../../index.md) > [Yandex BareMetal](../../index.md) > Концепции > Настройка и управление > Справочник API > API v2 > [REST (англ.)](../index.md) > [RentalPeriod](index.md) > ListRentalPeriods

# BareMetal API, REST: RentalPeriod.ListRentalPeriods

Retrieves the list of RentalPeriod resources.

https://google.aip.dev/130 --)

## HTTP request

```
GET https://baremetal.api.cloud.yandex.net/baremetal/v2/rentalPeriods
```

## Query parameters {#yandex.cloud.baremetal.v2.ListRentalPeriodsRequest}

#|
||Field | Description ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is greater than `page_size`,
the service returns a [ListRentalPeriodsResponse.nextPageToken](#yandex.cloud.baremetal.v2.ListRentalPeriodsResponse)
that can be used to get the next page of results in subsequent list requests.
Default value is 20.

The maximum value is 1000. ||
|| pageToken | **string**

Page token. To get the next page of results, set `page_token` to the
[ListRentalPeriodsResponse.nextPageToken](#yandex.cloud.baremetal.v2.ListRentalPeriodsResponse) returned by a previous list request. ||
|#

## Response {#yandex.cloud.baremetal.v2.ListRentalPeriodsResponse}

**HTTP Code: 200 - OK**

```json
{
  "rentalPeriods": [
    {
      "rentalPeriodId": "string"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| rentalPeriods[] | **[RentalPeriod](#yandex.cloud.baremetal.v2.RentalPeriod)**

List of RentalPeriod resources. ||
|| nextPageToken | **string**

Token for getting the next page of the list. If the number of results is greater than
[ListZonesRequest.pageSize](../Zone/listZones.md#yandex.cloud.baremetal.v2.ListZonesRequest), use `next_page_token` as the value
for the [ListRentalPeriodsResponse.page_token] parameter in the next list request.

Each subsequent page will have its own `next_page_token` to continue paging through the results. ||
|#

## RentalPeriod {#yandex.cloud.baremetal.v2.RentalPeriod}

A period of time for which a Bare Metal Server can be rented. e.g., 1 month, 3 months, 6 months,
a year.

#|
||Field | Description ||
|| rentalPeriodId | **string**

Rental period identifier. ||
|#