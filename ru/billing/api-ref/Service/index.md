---
editable: false
sourcePath: en/_api-ref/billing/v1/api-ref/Service/index.md
---

# Billing API, REST: Service methods
A set of methods for managing Service resources.
## JSON Representation {#representation}
```json 
{
  "id": "string",
  "name": "string",
  "description": "string"
}
```
 
Field | Description
--- | ---
id | **string**<br><p>ID of the service.</p> 
name | **string**<br><p>Name of the service, e.g. ``Compute Cloud``, ``VPC``.</p> 
description | **string**<br><p>Description of the service.</p> 

## Methods {#methods}
Method | Description
--- | ---
[get](get.md) | Returns the specified service.
[list](list.md) | Retrieves the list of services.