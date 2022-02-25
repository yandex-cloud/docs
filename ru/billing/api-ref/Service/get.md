---
editable: false
sourcePath: en/_api-ref/billing/api-ref/Service/get.md
---


# Method get
Returns the specified service.
 

 
## HTTP request {#https-request}
```
GET https://billing.api.cloud.yandex.net/billing/v1/services/{id}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
id | Required. ID of the service to return. To get the service ID, use [list](/docs/billing/api-ref/Service/list) request.  The maximum string length in characters is 50.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "name": "string",
  "description": "string"
}
```
A Service resource.
 
Field | Description
--- | ---
id | **string**<br><p>ID of the service.</p> 
name | **string**<br><p>Name of the service, e.g. ``Compute Cloud``, ``VPC``.</p> 
description | **string**<br><p>Description of the service.</p> 