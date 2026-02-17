---
editable: false
---

# BareMetal API, gRPC: RentalPeriodService.List

Retrieves the list of RentalPeriod resources.

## gRPC request

**rpc List ([ListRentalPeriodsRequest](#yandex.cloud.baremetal.v1alpha.ListRentalPeriodsRequest)) returns ([ListRentalPeriodsResponse](#yandex.cloud.baremetal.v1alpha.ListRentalPeriodsResponse))**

## ListRentalPeriodsRequest {#yandex.cloud.baremetal.v1alpha.ListRentalPeriodsRequest}

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

ID of the Configuration resource to return a Rental Period for.

To get the configuration ID, use a [ConfigurationService.List](/docs/baremetal/api-ref/grpc/Configuration/list#List) request. ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is greater than `page_size`,
the service returns a [ListRentalPeriodsResponse.next_page_token](#yandex.cloud.baremetal.v1alpha.ListRentalPeriodsResponse)
that can be used to get the next page of results in subsequent list requests.
Default value is 20. ||
|| page_token | **string**

Page token. To get the next page of results, set `page_token` to the
[ListRentalPeriodsResponse.next_page_token](#yandex.cloud.baremetal.v1alpha.ListRentalPeriodsResponse) returned by a previous list request. ||
|#

## ListRentalPeriodsResponse {#yandex.cloud.baremetal.v1alpha.ListRentalPeriodsResponse}

```json
{
  "rental_periods": [
    {
      "id": "string"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| rental_periods[] | **[RentalPeriod](#yandex.cloud.baremetal.v1alpha.RentalPeriod)**

List of RentalPeriod resources. ||
|| next_page_token | **string**

Token for getting the next page of the list. If the number of results is greater than
[ListRentalPeriodsRequest.page_size](#yandex.cloud.baremetal.v1alpha.ListRentalPeriodsRequest), use `next_page_token` as the value
for the [ListRentalPeriodsResponse.page_token] parameter in the next list request.

Each subsequent page will have its own `next_page_token` to continue paging through the results. ||
|#

## RentalPeriod {#yandex.cloud.baremetal.v1alpha.RentalPeriod}

A period of time for which a Bare Metal Server can be rented. e.g., 1 month, 3 months, 6 months,
a year.

#|
||Field | Description ||
|| id | **string**

Rental period identifier. ||
|#