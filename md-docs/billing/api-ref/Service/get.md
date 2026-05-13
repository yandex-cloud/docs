# Billing API, REST: Service.Get

Returns the specified service.

## HTTP request

```
GET https://billing.api.cloud.yandex.net/billing/v1/services/{id}
```

## Path parameters

#|
||Field | Description ||
|| id | **string**

Required field. ID of the service to return.
To get the service ID, use [ServiceService.List](list.md#List) request.

The maximum string length in characters is 50. ||
|#

## Response {#yandex.cloud.billing.v1.Service}

**HTTP Code: 200 - OK**

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