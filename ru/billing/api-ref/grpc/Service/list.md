---
editable: false
sourcePath: en/_api-ref-grpc/billing/v1/api-ref/grpc/Service/list.md
---

# Billing API, gRPC: ServiceService.List

Retrieves the list of services.

## gRPC request

**rpc List ([ListServicesRequest](#yandex.cloud.billing.v1.ListServicesRequest)) returns ([ListServicesResponse](#yandex.cloud.billing.v1.ListServicesResponse))**

## ListServicesRequest {#yandex.cloud.billing.v1.ListServicesRequest}

```json
{
  "filter": "string",
  "page_size": "int64",
  "page_token": "string"
}
```

#|
||Field | Description ||
|| filter | **string**

A filter expression that filters resources listed in the response.
The expression must specify:
1. The field name. Currently you can use filtering only on the [yandex.cloud.billing.v1.Service.id](#yandex.cloud.billing.v1.Service) field.
2. An `=` operator.
3. The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`. ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `page_size`,
the service returns a [ListServicesResponse.next_page_token](#yandex.cloud.billing.v1.ListServicesResponse)
that can be used to get the next page of results in subsequent list requests. ||
|| page_token | **string**

Page token. To get the next page of results,
set `page_token` to the [ListServicesResponse.next_page_token](#yandex.cloud.billing.v1.ListServicesResponse)
returned by a previous list request. ||
|#

## ListServicesResponse {#yandex.cloud.billing.v1.ListServicesResponse}

```json
{
  "services": [
    {
      "id": "string",
      "name": "string",
      "description": "string"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| services[] | **[Service](#yandex.cloud.billing.v1.Service)**

List of services. ||
|| next_page_token | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListServicesRequest.page_size](#yandex.cloud.billing.v1.ListServicesRequest), use
`next_page_token` as the value
for the [ListServicesRequest.page_token](#yandex.cloud.billing.v1.ListServicesRequest) query parameter
in the next list request. Each subsequent list request will have its own
`next_page_token` to continue paging through the results. ||
|#

## Service {#yandex.cloud.billing.v1.Service}

A Service resource.

#|
||Field | Description ||
|| id | **string**

ID of the service. ||
|| name | **string**

Name of the service, e.g. `Compute Cloud`, `VPC`. ||
|| description | **string**

Description of the service. ||
|#