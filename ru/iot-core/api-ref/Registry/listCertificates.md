---
editable: false
sourcePath: en/_api-ref/iot/devices/api-ref/Registry/listCertificates.md
---


# Method listCertificates
Retrieves the list of registry certificates for the specified registry.
 

 
## HTTP request {#https-request}
```
GET https://iot-devices.api.cloud.yandex.net/iot-devices/v1/registries/{registryId}/certificates
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
registryId | Required. ID of the registry to list certificates for.  The maximum string length in characters is 50.
 
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
certificates[] | **object**<br><p>A registry certificate. For more information, see <a href="/docs/iot-core/operations/certificates/registry-certificates">Managing registry certificates</a>.</p> 
certificates[].<br>registryId | **string**<br><p>ID of the registry that the certificate belongs to.</p> 
certificates[].<br>fingerprint | **string**<br><p>SHA256 hash of the certificates.</p> 
certificates[].<br>certificateData | **string**<br><p>Public part of the certificate.</p> 
certificates[].<br>createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 