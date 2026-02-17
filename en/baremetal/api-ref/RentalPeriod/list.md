---
editable: false
apiPlayground:
  - url: https://baremetal.{{ api-host }}/baremetal/v1alpha/rentalPeriods
    method: get
    path: null
    query:
      type: object
      properties:
        configurationId:
          description: |-
            **string**
            ID of the Configuration resource to return a Rental Period for.
            To get the configuration ID, use a [ConfigurationService.List](/docs/baremetal/api-ref/Configuration/list#List) request.
          pattern: '[a-z][a-z0-9]*'
          type: string
        pageSize:
          description: |-
            **string** (int64)
            The maximum number of results per page to return. If the number of available
            results is greater than `page_size`,
            the service returns a [ListRentalPeriodsResponse.nextPageToken](#yandex.cloud.baremetal.v1alpha.ListRentalPeriodsResponse)
            that can be used to get the next page of results in subsequent list requests.
            Default value is 20.
          type: string
          format: int64
        pageToken:
          description: |-
            **string**
            Page token. To get the next page of results, set `page_token` to the
            [ListRentalPeriodsResponse.nextPageToken](#yandex.cloud.baremetal.v1alpha.ListRentalPeriodsResponse) returned by a previous list request.
          type: string
      additionalProperties: false
    body: null
    definitions: null
---

# BareMetal API, REST: RentalPeriod.List

Retrieves the list of RentalPeriod resources.

## HTTP request

```
GET https://baremetal.{{ api-host }}/baremetal/v1alpha/rentalPeriods
```

## Query parameters {#yandex.cloud.baremetal.v1alpha.ListRentalPeriodsRequest}

#|
||Field | Description ||
|| configurationId | **string**

ID of the Configuration resource to return a Rental Period for.

To get the configuration ID, use a [ConfigurationService.List](/docs/baremetal/api-ref/Configuration/list#List) request. ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is greater than `page_size`,
the service returns a [ListRentalPeriodsResponse.nextPageToken](#yandex.cloud.baremetal.v1alpha.ListRentalPeriodsResponse)
that can be used to get the next page of results in subsequent list requests.
Default value is 20. ||
|| pageToken | **string**

Page token. To get the next page of results, set `page_token` to the
[ListRentalPeriodsResponse.nextPageToken](#yandex.cloud.baremetal.v1alpha.ListRentalPeriodsResponse) returned by a previous list request. ||
|#

## Response {#yandex.cloud.baremetal.v1alpha.ListRentalPeriodsResponse}

**HTTP Code: 200 - OK**

```json
{
  "rentalPeriods": [
    {
      "id": "string"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| rentalPeriods[] | **[RentalPeriod](#yandex.cloud.baremetal.v1alpha.RentalPeriod)**

List of RentalPeriod resources. ||
|| nextPageToken | **string**

Token for getting the next page of the list. If the number of results is greater than
[ListRentalPeriodsRequest.pageSize](#yandex.cloud.baremetal.v1alpha.ListRentalPeriodsRequest), use `next_page_token` as the value
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