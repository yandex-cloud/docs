[Документация Yandex Cloud](../../../../index.md) > [Yandex BareMetal](../../../index.md) > Концепции > Настройка и управление > Справочник API > API v2 > [gRPC (англ.)](../index.md) > [RentalPeriod](index.md) > ListRentalPeriods

# BareMetal API, gRPC: RentalPeriodService.ListRentalPeriods

Retrieves the list of RentalPeriod resources.

https://google.aip.dev/130 --)

## gRPC request

**rpc ListRentalPeriods ([ListRentalPeriodsRequest](#yandex.cloud.baremetal.v2.ListRentalPeriodsRequest)) returns ([ListRentalPeriodsResponse](#yandex.cloud.baremetal.v2.ListRentalPeriodsResponse))**

## ListRentalPeriodsRequest {#yandex.cloud.baremetal.v2.ListRentalPeriodsRequest}

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
the service returns a [ListRentalPeriodsResponse.next_page_token](#yandex.cloud.baremetal.v2.ListRentalPeriodsResponse)
that can be used to get the next page of results in subsequent list requests.
Default value is 20.

The maximum value is 1000. ||
|| page_token | **string**

Page token. To get the next page of results, set `page_token` to the
[ListRentalPeriodsResponse.next_page_token](#yandex.cloud.baremetal.v2.ListRentalPeriodsResponse) returned by a previous list request. ||
|#

## ListRentalPeriodsResponse {#yandex.cloud.baremetal.v2.ListRentalPeriodsResponse}

```json
{
  "rental_periods": [
    {
      "rental_period_id": "string"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| rental_periods[] | **[RentalPeriod](#yandex.cloud.baremetal.v2.RentalPeriod)**

List of RentalPeriod resources. ||
|| next_page_token | **string**

Token for getting the next page of the list. If the number of results is greater than
[ListZonesRequest.page_size](../Zone/listZones.md#yandex.cloud.baremetal.v2.ListZonesRequest), use `next_page_token` as the value
for the [ListRentalPeriodsResponse.page_token] parameter in the next list request.

Each subsequent page will have its own `next_page_token` to continue paging through the results. ||
|#

## RentalPeriod {#yandex.cloud.baremetal.v2.RentalPeriod}

A period of time for which a Bare Metal Server can be rented. e.g., 1 month, 3 months, 6 months,
a year.

#|
||Field | Description ||
|| rental_period_id | **string**

Rental period identifier. ||
|#