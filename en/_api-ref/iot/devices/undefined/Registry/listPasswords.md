---
editable: false
---

# Method listPasswords

 

 
## HTTP request {#https-request}
```
GET undefined/iot-devices/v1/registries/{registryId}/passwords
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
registryId | Required. The maximum string length in characters is 50.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "passwords": [
    {
      "registryId": "string",
      "id": "string",
      "createdAt": "string"
    }
  ]
}
```

 
Field | Description
--- | ---
passwords[] | **object**<br>
passwords[].<br>registryId | **string**<br>
passwords[].<br>id | **string**<br>
passwords[].<br>createdAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 