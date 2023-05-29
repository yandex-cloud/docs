---
editable: false
sourcePath: en/_api-ref/certificatemanager/v1/api-ref/Certificate/get.md
---

# Certificate Manager API, REST: Certificate.get
Returns the specified certificate.
 
To get the list of available certificates, make a [list](/docs/certificate-manager/api-ref/Certificate/list) request.
 
## HTTP request {#https-request}
```
GET https://certificate-manager.{{ api-host }}/certificate-manager/v1/certificates/{certificateId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
certificateId | <p>Required. ID of the certificate to return.</p> <p>To get the ID of a certificate use a <a href="/docs/certificate-manager/api-ref/Certificate/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
view | <p>The output type of the certificate.</p> <ul> <li>BASIC: Output basic information about the certificate.</li> <li>FULL: Output full information about the certificate including domain challenges.</li> </ul> 
 
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
  ],
  "deletionProtection": true,
  "incompleteChain": true
}
```
A certificate. For details about the concept, see [documentation](/docs/certificate-manager/concepts/).
 
Field | Description
--- | ---
id | **string**<br><p>ID of the certificate. Generated at creation time.</p> 
folderId | **string**<br><p>ID of the folder that the certificate belongs to.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
name | **string**<br><p>Name of the certificate. The name is unique within the folder.</p> 
description | **string**<br><p>Description of the certificate.</p> 
labels | **object**<br><p>Certificate labels as ``key:value`` pairs.</p> 
type | **string**<br><p>Type of the certificate.</p> <p>Supported certificate types.</p> <ul> <li>IMPORTED: The certificate is imported by user.</li> <li>MANAGED: The certificate is created by service.</li> </ul> 
domains[] | **string**<br><p>Fully qualified domain names of the certificate.</p> 
status | **string**<br><p>Status of the certificate.</p> <ul> <li>VALIDATING: The certificate domains validation are required. Used only for managed certificates.</li> <li>INVALID: The certificate issuance is failed. Used only for managed certificates.</li> <li>ISSUED: The certificate is issued.</li> <li>REVOKED: The certificate is revoked.</li> <li>RENEWING: The certificate renewal is started. Used only for managed certificates.</li> <li>RENEWAL_FAILED: The certificate renewal is failed. Used only for managed certificates.</li> </ul> 
issuer | **string**<br><p><a href="https://tools.ietf.org/html/rfc1779">Distinguished Name</a> of the certificate authority that issued the certificate.</p> 
subject | **string**<br><p><a href="https://tools.ietf.org/html/rfc1779">Distinguished Name</a> of the entity that is associated with the public key contained in the certificate.</p> 
serial | **string**<br><p>Serial number of the certificate.</p> 
updatedAt | **string** (date-time)<br><p>Time when the certificate is updated.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
issuedAt | **string** (date-time)<br><p>Time when the certificate is issued.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
notAfter | **string** (date-time)<br><p>Time after which the certificate is not valid.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
notBefore | **string** (date-time)<br><p>Time before which the certificate is not valid.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
challenges[] | **object**<br><p>Domains validation challenges of the certificate. Used only for managed certificates.</p> 
challenges[].<br>domain | **string**<br><p>Domain of the challenge.</p> 
challenges[].<br>type | **string**<br>Type of the challenge.<br><ul> <li>DNS: Domain validation type that using DNS-records.</li> <li>HTTP: Domain validation type that using HTTP-files.</li> </ul> 
challenges[].<br>createdAt | **string** (date-time)<br><p>Time when the challenge is created.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
challenges[].<br>updatedAt | **string** (date-time)<br><p>Time when the challenge is updated.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
challenges[].<br>status | **string**<br>Status of the challenge.<br><ul> <li>PENDING: The challenge is waiting to be completed.</li> <li>PROCESSING: The challenge is awaiting approval from Let's Encrypt.</li> <li>VALID: The challenge is complete.</li> <li>INVALID: The rights check for a specific domain failed or the one-week period allocated for the check expired.</li> </ul> 
challenges[].<br>message | **string**<br><p>Description of the challenge.</p> 
challenges[].<br>error | **string**<br><p>Error of the challenge.</p> 
challenges[].<br>dnsChallenge | **object**<br>DNS-record. <br>`challenges[]` includes only one of the fields `dnsChallenge`, `httpChallenge`<br>
challenges[].<br>dnsChallenge.<br>name | **string**<br><p>Name of the DNS record.</p> 
challenges[].<br>dnsChallenge.<br>type | **string**<br><p>Type of the DNS-record.</p> 
challenges[].<br>dnsChallenge.<br>value | **string**<br><p>Value of the DNS-record.</p> 
challenges[].<br>httpChallenge | **object**<br>HTTP-file. <br>`challenges[]` includes only one of the fields `dnsChallenge`, `httpChallenge`<br>
challenges[].<br>httpChallenge.<br>url | **string**<br><p>Location of the HTTP file.</p> 
challenges[].<br>httpChallenge.<br>content | **string**<br><p>Content of the HTTP file.</p> 
deletionProtection | **boolean** (boolean)<br><p>Flag that protects deletion of the certificate</p> 
incompleteChain | **boolean** (boolean)<br><p>Mark imported certificates without uploaded chain or with chain which not lead to root certificate</p> 