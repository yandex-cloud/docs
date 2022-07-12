---
editable: false
---

# Method get
Returns chain and private key of the specified certificate.
 

 
## HTTP request {#https-request}
```
GET https://{{ api-host-certmanager-certcontent }}/certificate-manager/v1/certificates/{certificateId}:getContent
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
certificateId | <p>ID of the certificate to download content.</p> 
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
versionId | <p>Optional ID of the version.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "certificateId": "string",
  "certificateChain": [
    "string"
  ],
  "privateKey": "string"
}
```

 
Field | Description
--- | ---
certificateId | **string**<br><p>ID of the certificate.</p> 
certificateChain[] | **string**<br><p>PEM-encoded certificate chain content of the certificate.</p> 
privateKey | **string**<br><p>PEM-encoded private key content of the certificate.</p> 