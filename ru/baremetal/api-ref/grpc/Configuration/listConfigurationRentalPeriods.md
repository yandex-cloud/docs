---
editable: false
---

# BareMetal API, gRPC: ConfigurationService.ListConfigurationRentalPeriods

Retrieves the list of RentalPeriods for the specified Configuration resource.

https://google.aip.dev/130 --)

## gRPC request

**rpc ListConfigurationRentalPeriods ([ListConfigurationRentalPeriodsRequest](#yandex.cloud.baremetal.v2.ListConfigurationRentalPeriodsRequest)) returns ([ListConfigurationRentalPeriodsResponse](#yandex.cloud.baremetal.v2.ListConfigurationRentalPeriodsResponse))**

## ListConfigurationRentalPeriodsRequest {#yandex.cloud.baremetal.v2.ListConfigurationRentalPeriodsRequest}

```json
{
  "configuration_id": "string",
  "page_size": "int64",
  "page_token": "string"
}
```

#|
||Field | Description ||
|| configuration_id | **string**

ID of the Configuration resource to return.
To get the configuration ID, use a [ConfigurationService.List] request.

Value must match the regular expression ` [a-z][a-z0-9]* `. ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is greater than `page_size`,
the service returns a [ListConfigurationRentalPeriodsResponse.next_page_token](#yandex.cloud.baremetal.v2.ListConfigurationRentalPeriodsResponse)
that can be used to get the next page of results in subsequent list requests.
Default value is 20.

The maximum value is 1000. ||
|| page_token | **string**

Page token. To get the next page of results, set `page_token` to the
[ListConfigurationRentalPeriodsResponse.next_page_token](#yandex.cloud.baremetal.v2.ListConfigurationRentalPeriodsResponse) returned by a previous list request. ||
|#

## ListConfigurationRentalPeriodsResponse {#yandex.cloud.baremetal.v2.ListConfigurationRentalPeriodsResponse}

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
[ListZonesRequest.page_size](/docs/baremetal/api-ref/grpc/Zone/listZones#yandex.cloud.baremetal.v2.ListZonesRequest), use `next_page_token` as the value
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