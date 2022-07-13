---
editable: false
sourcePath: en/_api-ref/iam/api-ref/Certificate/get.md
---

# Method get
Returns the specified certificate.
 
To get the list of available certificates, make a [list](/docs/iam/api-ref/Certificate/list) request.
 
## HTTP request {#https-request}
```
GET https://iam.{{ api-host }}/iam/v1/saml/certificates/{certificateId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
certificateId | <p>ID of the certificate to return. To get the certificate ID, make a <a href="/docs/iam/api-ref/Certificate/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "federationId": "string",
  "name": "string",
  "description": "string",
  "createdAt": "string",
  "data": "string"
}
```
A certificate.
 
Field | Description
--- | ---
id | **string**<br><p>Required. ID of the certificate.</p> <p>The maximum string length in characters is 50.</p> 
federationId | **string**<br><p>Required. ID of the federation that the certificate belongs to.</p> <p>The maximum string length in characters is 50.</p> 
name | **string**<br><p>Name of the certificate.</p> <p>Value must match the regular expression ``\|[a-z][-a-z0-9]{1,61}[a-z0-9]``.</p> 
description | **string**<br><p>Description of the certificate.</p> <p>The maximum string length in characters is 256.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
data | **string**<br><p>Required. Certificate data in PEM format.</p> <p>The maximum string length in characters is 32000.</p> 