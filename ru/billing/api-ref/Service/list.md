---
editable: false
apiPlayground:
  - url: https://billing.{{ api-host }}/billing/v1/services
    method: get
    path: null
    query:
      type: object
      properties:
        filter:
          description: |-
            **string**
            A filter expression that filters resources listed in the response.
            The expression must specify:
            1. The field name. Currently you can use filtering only on the [yandex.cloud.billing.v1.Service.id](/docs/billing/api-ref/Service/get#yandex.cloud.billing.v1.Service) field.
            2. An `=` operator.
            3. The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`.
          type: string
        pageSize:
          description: |-
            **string** (int64)
            The maximum number of results per page to return. If the number of available
            results is larger than `pageSize`,
            the service returns a [ListServicesResponse.nextPageToken](/docs/billing/api-ref/Service/list#yandex.cloud.billing.v1.ListServicesResponse)
            that can be used to get the next page of results in subsequent list requests.
          type: string
          format: int64
        pageToken:
          description: |-
            **string**
            Page token. To get the next page of results,
            set `pageToken` to the [ListServicesResponse.nextPageToken](/docs/billing/api-ref/Service/list#yandex.cloud.billing.v1.ListServicesResponse)
            returned by a previous list request.
          type: string
      additionalProperties: false
    body: null
    definitions: null
sourcePath: en/_api-ref/billing/v1/api-ref/Service/list.md
---

# Billing API, REST: Service.List

Retrieves the list of services.

## HTTP request

```
GET https://billing.{{ api-host }}/billing/v1/services
```

## Query parameters {#yandex.cloud.billing.v1.ListServicesRequest}

#|
||Field | Description ||
|| filter | **string**

A filter expression that filters resources listed in the response.
The expression must specify:
1. The field name. Currently you can use filtering only on the [yandex.cloud.billing.v1.Service.id](#yandex.cloud.billing.v1.Service) field.
2. An `=` operator.
3. The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`. ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`,
the service returns a [ListServicesResponse.nextPageToken](#yandex.cloud.billing.v1.ListServicesResponse)
that can be used to get the next page of results in subsequent list requests. ||
|| pageToken | **string**

Page token. To get the next page of results,
set `pageToken` to the [ListServicesResponse.nextPageToken](#yandex.cloud.billing.v1.ListServicesResponse)
returned by a previous list request. ||
|#

## Response {#yandex.cloud.billing.v1.ListServicesResponse}

**HTTP Code: 200 - OK**

```json
{
  "services": [
    {
      "id": "string",
      "name": "string",
      "description": "string"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| services[] | **[Service](#yandex.cloud.billing.v1.Service)**

List of services. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListServicesRequest.pageSize](#yandex.cloud.billing.v1.ListServicesRequest), use
`nextPageToken` as the value
for the [ListServicesRequest.pageToken](#yandex.cloud.billing.v1.ListServicesRequest) query parameter
in the next list request. Each subsequent list request will have its own
`nextPageToken` to continue paging through the results. ||
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