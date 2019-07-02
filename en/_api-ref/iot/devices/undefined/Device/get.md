---
editable: false
---

# Method get

 

 
## HTTP request {#https-request}
```
GET undefined/iot-devices/v1/devices/{deviceId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
deviceId | Required. The maximum string length in characters is 50.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "registryId": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string"
}
```

 
Field | Description
--- | ---
id | **string**<br>
registryId | **string**<br>
createdAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
name | **string**<br>
description | **string**<br>