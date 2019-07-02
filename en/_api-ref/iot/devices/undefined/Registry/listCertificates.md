---
editable: false
---

# Method listCertificates

 

 
## HTTP request {#https-request}
```
GET undefined/iot-devices/v1/registries/{registryId}/certificates
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
registryId | Required. The maximum string length in characters is 50.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "certificates": [
    {
      "registryId": "string",
      "fingerprint": "string",
      "certificateData": "string",
      "createdAt": "string"
    }
  ]
}
```

 
Field | Description
--- | ---
certificates[] | **object**<br>
certificates[].<br>registryId | **string**<br>
certificates[].<br>fingerprint | **string**<br>
certificates[].<br>certificateData | **string**<br>
certificates[].<br>createdAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 