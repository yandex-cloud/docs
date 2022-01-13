---
editable: false
---

# Method getHTTPSConfig
Fetch Bucket's HTTPS configuration.
 

 
## HTTP request {#https-request}
```
GET https://storage.api.cloud.yandex.net/storage/v1/buckets/{name}:getHttpsConfig
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
name | Required.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "name": "string",
  "sourceType": "string",
  "issuer": "string",
  "subject": "string",
  "dnsNames": [
    "string"
  ],
  "notBefore": "string",
  "notAfter": "string",
  "certificateId": "string"
}
```

 
Field | Description
--- | ---
name | **string**<br>
sourceType | **string**<br>
issuer | **string**<br>
subject | **string**<br>
dnsNames[] | **string**<br>
notBefore | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
notAfter | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
certificateId | **string**<br>