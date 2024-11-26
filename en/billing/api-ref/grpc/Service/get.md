---
editable: false
sourcePath: en/_api-ref-grpc/billing/v1/api-ref/grpc/Service/get.md
---

# Billing API, gRPC: ServiceService.Get

Returns the specified service.

## gRPC request

**rpc Get ([GetServiceRequest](#yandex.cloud.billing.v1.GetServiceRequest)) returns ([Service](#yandex.cloud.billing.v1.Service))**

## GetServiceRequest {#yandex.cloud.billing.v1.GetServiceRequest}

```json
{
  "id": "string"
}
```

#|
||Field | Description ||
|| id | **string**

Required field. ID of the service to return.
To get the service ID, use [ServiceService.List](/docs/billing/api-ref/grpc/Service/list#List) request. ||
|#

## Service {#yandex.cloud.billing.v1.Service}

```json
{
  "id": "string",
  "name": "string",
  "description": "string"
}
```

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