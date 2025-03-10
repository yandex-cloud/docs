---
editable: false
sourcePath: en/_api-ref-grpc/quotamanager/v1/api-ref/grpc/QuotaLimit/listServices.md
---

# Quota Manager API, gRPC: QuotaLimitService.ListServices

Retrieves the list of services available for quota management.

## gRPC request

**rpc ListServices ([ListServicesRequest](#yandex.cloud.quotamanager.v1.ListServicesRequest)) returns ([ListServicesResponse](#yandex.cloud.quotamanager.v1.ListServicesResponse))**

## ListServicesRequest {#yandex.cloud.quotamanager.v1.ListServicesRequest}

```json
{
  "resource_type": "string",
  "page_size": "int64",
  "page_token": "string"
}
```

#|
||Field | Description ||
|| resource_type | **string**

Required field. The type of resources for which services are being requested. ||
|| page_size | **int64**

The maximum number of services to return per response. ||
|| page_token | **string**

Token to retrieve the next page of results. Omitted on the first request. ||
|#

## ListServicesResponse {#yandex.cloud.quotamanager.v1.ListServicesResponse}

```json
{
  "services": [
    {
      "id": "string",
      "name": "string"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| services[] | **[Service](#yandex.cloud.quotamanager.v1.Service)**

List of services available for quota management. ||
|| next_page_token | **string**

Token to retrieve the next page of results. ||
|#

## Service {#yandex.cloud.quotamanager.v1.Service}

#|
||Field | Description ||
|| id | **string**

The unique id of the service. ||
|| name | **string**

The name of the service. ||
|#