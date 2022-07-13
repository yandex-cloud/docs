---
editable: false
sourcePath: en/_api-ref/storage/api-ref/Bucket/getHTTPSConfig.md
---

# Method getHTTPSConfig
Returns the HTTPS configuration for the specified bucket.
 

 
## HTTP request {#https-request}
```
GET https://storage.{{ api-host }}/storage/v1/buckets/{name}:getHttpsConfig
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
name | <p>Required. Name of the bucket to return the HTTPS configuration for.</p> 
 
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
A resource for HTTPS configuration of a bucket.
 
Field | Description
--- | ---
name | **string**<br><p>Name of the bucket.</p> 
sourceType | **string**<br><p>Type of TLS certificate source.</p> <p>A resource for type of TLS certificate source.</p> <ul> <li>SOURCE_TYPE_SELF_MANAGED: Your certificate, uploaded directly.</li> <li>SOURCE_TYPE_MANAGED_BY_CERTIFICATE_MANAGER: Certificate managed by Certificate Manager.</li> </ul> 
issuer | **string**<br><p>Issuer of the TLS certificate.</p> 
subject | **string**<br><p>Subject of the TLS certificate.</p> 
dnsNames[] | **string**<br><p>List of DNS names of the TLS certificate (Subject Alternative Name field).</p> 
notBefore | **string** (date-time)<br><p>Start of the TLS certificate validity period (Not Before field).</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
notAfter | **string** (date-time)<br><p>End of the TLS certificate validity period (Not After field)</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
certificateId | **string**<br><p>ID of the TLS certificate in Certificate Manager.</p> <p>To get information about the certificate from Certificate Manager, make a <a href="/docs/certificate-manager/api-ref/Certificate/get">get</a> request.</p> 