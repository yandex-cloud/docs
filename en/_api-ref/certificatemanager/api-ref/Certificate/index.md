---
editable: false
---

# Certificate
A set of methods for managing certificates.
## JSON Representation {#representation}
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
 
Field | Description
--- | ---
id | **string**<br><p>ID of the certificate. Generated at creation time.</p> 
folderId | **string**<br><p>ID of the folder that the certificate belongs to.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
name | **string**<br><p>Name of the certificate. The name is unique within the folder.</p> 
description | **string**<br><p>Description of the certificate.</p> 
labels | **object**<br><p>Certificate labels as `key:value` pairs.</p> 
type | **string**<br><p>Type of the certificate.</p> <p>Supported certificate types.</p> <ul> <li>IMPORTED: The certificate is imported by user.</li> <li>MANAGED: The certificate is created by service.</li> </ul> 
domains[] | **string**<br><p>Fully qualified domain names of the certificate.</p> 
status | **string**<br><p>Status of the certificate.</p> <ul> <li>VALIDATING: The certificate domains validation are required. Used only for managed certificates.</li> <li>INVALID: The certificate issuance is failed. Used only for managed certificates.</li> <li>ISSUED: The certificate is issued.</li> <li>REVOKED: The certificate is revoked.</li> <li>RENEWING: The certificate renewal is started. Used only for managed certificates.</li> <li>RENEWAL_FAILED: The certificate renewal is failed. Used only for managed certificates.</li> </ul> 
issuer | **string**<br><p><a href="https://tools.ietf.org/html/rfc1779">Distinguished Name</a> of the certificate authority that issued the certificate.</p> 
subject | **string**<br><p><a href="https://tools.ietf.org/html/rfc1779">Distinguished Name</a> of the entity that is associated with the public key contained in the certificate.</p> 
serial | **string**<br><p>Serial number of the certificate.</p> 
updatedAt | **string** (date-time)<br><p>Time when the certificate is updated.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
issuedAt | **string** (date-time)<br><p>Time when the certificate is issued.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
notAfter | **string** (date-time)<br><p>Time after which the certificate is not valid.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
notBefore | **string** (date-time)<br><p>Time before which the certificate is not valid.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
challenges[] | **object**<br><p>Domain validation challenge.</p> 
challenges[].<br>domain | **string**<br><p>Domain of the challenge.</p> 
challenges[].<br>type | **string**<br>Type of the challenge.<br><p>Supported domain validation types.</p> <ul> <li>DNS: Domain validation type that using DNS-records.</li> <li>HTTP: Domain validation type that using HTTP-files.</li> </ul> 
challenges[].<br>createdAt | **string** (date-time)<br><p>Time when the challenge is created.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
challenges[].<br>updatedAt | **string** (date-time)<br><p>Time when the challenge is updated.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
challenges[].<br>status | **string**<br>Status of the challenge.<br><ul> <li>PENDING: The challenge is waiting to be completed.</li> <li>PROCESSING: The challenge is awaiting approval from Let's Encrypt.</li> <li>VALID: The challenge is complete.</li> <li>INVALID: The rights check for a specific domain failed or the one-week period allocated for the check expired.</li> </ul> 
challenges[].<br>message | **string**<br><p>Description of the challenge.</p> 
challenges[].<br>error | **string**<br><p>Error of the challenge.</p> 
challenges[].<br>dnsChallenge | **object** <br>`challenges[]` includes only one of the fields `dnsChallenge`, `httpChallenge`<br><br>
challenges[].<br>dnsChallenge.<br>name | **string**<br><p>Name of the DNS record.</p> 
challenges[].<br>dnsChallenge.<br>type | **string**<br><p>Type of the DNS-record.</p> 
challenges[].<br>dnsChallenge.<br>value | **string**<br><p>Value of the DNS-record.</p> 
challenges[].<br>httpChallenge | **object** <br>`challenges[]` includes only one of the fields `dnsChallenge`, `httpChallenge`<br><br>
challenges[].<br>httpChallenge.<br>url | **string**<br><p>Location of the HTTP file.</p> 
challenges[].<br>httpChallenge.<br>content | **string**<br><p>Content of the HTTP file.</p> 

## Methods {#methods}
Method | Description
--- | ---
[create](create.md) | Creates a certificate in the specified folder.
[delete](delete.md) | Deletes the specified certificate.
[get](get.md) | Returns the specified certificate.
[list](list.md) | Returns the list of certificates in the specified folder.
[listAccessBindings](listAccessBindings.md) | Lists existing access bindings for the specified certificate.
[listOperations](listOperations.md) | Lists operations for the specified certificate.
[requestNew](requestNew.md) | Request a certificate in the specified folder.
[setAccessBindings](setAccessBindings.md) | Sets access bindings for the certificate.
[update](update.md) | Updates the specified certificate.
[updateAccessBindings](updateAccessBindings.md) | Updates access bindings for the specified certificate.