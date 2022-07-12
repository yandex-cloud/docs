---
editable: false
---

# Method get
Returns the specified service.
 

 
## HTTP request {#https-request}
```
GET https://billing.{{ api-host }}/billing/v1/services/{id}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
id | <p>Required. ID of the service to return. To get the service ID, use <a href="/docs/billing/api-ref/Service/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
 
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