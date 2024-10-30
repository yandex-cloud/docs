---
editable: false
sourcePath: en/_api-ref/billing/v1/api-ref/Service/get.md
---

# Billing API, REST: Service.Get {#Get}

Returns the specified service.

## HTTP request

```
GET https://billing.{{ api-host }}/billing/v1/services/{id}
```

## Path parameters

#|
||Field | Description ||
|| id | **string**

Required field. ID of the service to return.
To get the service ID, use [ServiceService.List](/docs/billing/api-ref/Service/list#List) request. ||
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