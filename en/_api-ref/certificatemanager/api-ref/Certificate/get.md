---
editable: false
---

# Method get
Returns the specified certificate.
 
To get the list of available certificates, make a [list](/docs/certificate-manager/api-ref/Certificate/list) request.
 
## HTTP request {#https-request}
```
GET https://certificate-manager.api.cloud.yandex.net/certificate-manager/v1/certificates/{certificateId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
certificateId | Required. ID of the certificate to return. To get the ID of a certificate use a [list](/docs/certificate-manager/api-ref/Certificate/list) request.  The maximum string length in characters is 50.
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
view | 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "folderId": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "type": "string",
  "domains": [
    "string"
  ],
  "status": "string",
  "issuer": "string",
  "subject": "string",
  "serial": "string",
  "updatedAt": "string",
  "issuedAt": "string",
  "notAfter": "string",
  "notBefore": "string",
  "challenges": [
    {
      "domain": "string",
      "type": "string",
      "createdAt": "string",
      "updatedAt": "string",
      "status": "string",
      "message": "string",
      "error": "string",

      // `challenges[]` includes only one of the fields `dnsChallenge`, `httpChallenge`
      "dnsChallenge": {
        "name": "string",
        "type": "string",
        "value": "string"
      },
      "httpChallenge": {
        "url": "string",
        "content": "string"
      },
      // end of the list of possible fields`challenges[]`

    }
  ]
}
```
A certificate.
 
Field | Description
--- | ---
id | **string**<br><p>ID of the certificate.</p> 
folderId | **string**<br><p>ID of the folder that the certificate belongs to.</p> 
createdAt | **string** (date-time)<br><p>Time when the certificate was created.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
name | **string**<br><p>Name of the certificate.</p> 
description | **string**<br><p>Description of the certificate.</p> 
labels | **object**<br><p>Certificate labels as <code>key:value</code> pairs. Maximum 64 per certificate.</p> 
type | **string**<br><p>Type of the certificate.</p> <p>Supported certificate types.</p> <ul> <li>IMPORTED: The certificate was imported by user</li> <li>MANAGED: The certificate was created by service</li> </ul> 
domains[] | **string**<br><p>Fully qualified domain names of the certificate.</p> 
status | **string**<br><p>Status of the certificate.</p> <ul> <li>VALIDATING: The certificate domains validation are required. Used only for MANAGED certificates.</li> <li>INVALID: The certificate issuance was failed. Used only for MANAGED certificates.</li> <li>ISSUED: The certificate was issued.</li> <li>REVOKED: The certificate was revoked.</li> <li>RENEWING: The certificate renewal was started. Used only for MANAGED certificates.</li> <li>RENEWAL_FAILED: The certificate renewal was failed. Used only for MANAGED certificates.</li> </ul> 
issuer | **string**<br><p>Name of the certificate authority that issued the certificate.</p> 
subject | **string**<br><p>Name of the entity that is associated with the public key contained in the certificate.</p> 
serial | **string**<br><p>Serial number of the certificate</p> 
updatedAt | **string** (date-time)<br><p>Time when the certificate was updated</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
issuedAt | **string** (date-time)<br><p>Time when the certificate was issued</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
notAfter | **string** (date-time)<br><p>Time after which the certificate is not valid.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
notBefore | **string** (date-time)<br><p>Time before which the certificate is not valid.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
challenges[] | **object**<br><p>Domain validation challenge.</p> 
challenges[].<br>domain | **string**<br><p>Domain of the challenge.</p> 
challenges[].<br>type | **string**<br>Type of the challenge.<br><p>Supported domain validation types.</p> <ul> <li>DNS: Domain validation type that using DNS-records.</li> <li>HTTP: Domain validation type that using HTTP-files.</li> </ul> 
challenges[].<br>createdAt | **string** (date-time)<br><p>Time when the challenge was created.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
challenges[].<br>updatedAt | **string** (date-time)<br><p>Time when the challenge was updated.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
challenges[].<br>status | **string**<br>Status of the challenge.<br>
challenges[].<br>message | **string**<br><p>Description of the challenge.</p> 
challenges[].<br>error | **string**<br><p>Error of the challenge.</p> 
challenges[].<br>dnsChallenge | **object**<br>DNS record. <br>`challenges[]` includes only one of the fields `dnsChallenge`, `httpChallenge`<br><br>
challenges[].<br>dnsChallenge.<br>name | **string**<br><p>Name of the DNS record.</p> 
challenges[].<br>dnsChallenge.<br>type | **string**<br><p>Type of the DNS record.</p> 
challenges[].<br>dnsChallenge.<br>value | **string**<br><p>Value of the DNS record.</p> 
challenges[].<br>httpChallenge | **object**<br>HTTP file. <br>`challenges[]` includes only one of the fields `dnsChallenge`, `httpChallenge`<br><br>
challenges[].<br>httpChallenge.<br>url | **string**<br><p>Location of the HTTP file.</p> 
challenges[].<br>httpChallenge.<br>content | **string**<br><p>Content of the HTTP file.</p> 