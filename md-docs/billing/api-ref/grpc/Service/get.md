[Документация Yandex Cloud](../../../../index.md) > [Yandex Cloud Billing](../../../index.md) > Справочник API > gRPC (англ.) > [Billing](../index.md) > [Service](index.md) > Get

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
To get the service ID, use [ServiceService.List](list.md#List) request.

The maximum string length in characters is 50. ||
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