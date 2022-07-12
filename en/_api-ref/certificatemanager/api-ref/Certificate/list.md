---
editable: false
---

# Method list
Returns the list of certificates in the specified folder.
 

 
## HTTP request {#https-request}
```
GET https://certificate-manager.{{ api-host }}/certificate-manager/v1/certificates
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | <p>Required. ID of the folder to list certificate in.</p> <p>The maximum string length in characters is 50.</p> 
pageSize | <p>The maximum number of results per page to return. If the number of available results is larger than ``page_size``, the service returns a <a href="/docs/certificate-manager/api-ref/Certificate/list#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests. Default value: 100.</p> <p>The maximum value is 1000.</p> 
pageToken | <p>Page token. To get the next page of results, set ``page_token`` to the <a href="/docs/certificate-manager/api-ref/Certificate/list#responses">nextPageToken</a> returned by a previous list request.</p> <p>The maximum string length in characters is 100.</p> 
view | <p>The output type of the certificate.</p> <ul> <li>BASIC: Output basic information about the certificate.</li> <li>FULL: Output full information about the certificate including domain challenges.</li> </ul> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "certificates": [
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

          // `certificates[].challenges[]` includes only one of the fields `dnsChallenge`, `httpChallenge`
          "dnsChallenge": {
            "name": "string",
            "type": "string",
            "value": "string"
          },
          "httpChallenge": {
            "url": "string",
            "content": "string"
          },
          // end of the list of possible fields`certificates[].challenges[]`

        }
      ],
      "deletionProtection": true
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
certificates[] | **object**<br><p>List of certificates in the specified folder.</p> 
certificates[].<br>id | **string**<br><p>ID of the certificate. Generated at creation time.</p> 
certificates[].<br>folderId | **string**<br><p>ID of the folder that the certificate belongs to.</p> 
certificates[].<br>createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
certificates[].<br>name | **string**<br><p>Name of the certificate. The name is unique within the folder.</p> 
certificates[].<br>description | **string**<br><p>Description of the certificate.</p> 
certificates[].<br>labels | **object**<br><p>Certificate labels as ``key:value`` pairs.</p> 
certificates[].<br>type | **string**<br><p>Type of the certificate.</p> <p>Supported certificate types.</p> <ul> <li>IMPORTED: The certificate is imported by user.</li> <li>MANAGED: The certificate is created by service.</li> </ul> 
certificates[].<br>domains[] | **string**<br><p>Fully qualified domain names of the certificate.</p> 
certificates[].<br>status | **string**<br><p>Status of the certificate.</p> <ul> <li>VALIDATING: The certificate domains validation are required. Used only for managed certificates.</li> <li>INVALID: The certificate issuance is failed. Used only for managed certificates.</li> <li>ISSUED: The certificate is issued.</li> <li>REVOKED: The certificate is revoked.</li> <li>RENEWING: The certificate renewal is started. Used only for managed certificates.</li> <li>RENEWAL_FAILED: The certificate renewal is failed. Used only for managed certificates.</li> </ul> 
certificates[].<br>issuer | **string**<br><p><a href="https://tools.ietf.org/html/rfc1779">Distinguished Name</a> of the certificate authority that issued the certificate.</p> 
certificates[].<br>subject | **string**<br><p><a href="https://tools.ietf.org/html/rfc1779">Distinguished Name</a> of the entity that is associated with the public key contained in the certificate.</p> 
certificates[].<br>serial | **string**<br><p>Serial number of the certificate.</p> 
certificates[].<br>updatedAt | **string** (date-time)<br><p>Time when the certificate is updated.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
certificates[].<br>issuedAt | **string** (date-time)<br><p>Time when the certificate is issued.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
certificates[].<br>notAfter | **string** (date-time)<br><p>Time after which the certificate is not valid.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
certificates[].<br>notBefore | **string** (date-time)<br><p>Time before which the certificate is not valid.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
certificates[].<br>challenges[] | **object**<br><p>Domains validation challenges of the certificate. Used only for managed certificates.</p> 
certificates[].<br>challenges[].<br>domain | **string**<br><p>Domain of the challenge.</p> 
certificates[].<br>challenges[].<br>type | **string**<br>Type of the challenge.<br><p>Supported domain validation types.</p> <ul> <li>DNS: Domain validation type that using DNS-records.</li> <li>HTTP: Domain validation type that using HTTP-files.</li> </ul> 
certificates[].<br>challenges[].<br>createdAt | **string** (date-time)<br><p>Time when the challenge is created.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
certificates[].<br>challenges[].<br>updatedAt | **string** (date-time)<br><p>Time when the challenge is updated.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
certificates[].<br>challenges[].<br>status | **string**<br>Status of the challenge.<br><ul> <li>PENDING: The challenge is waiting to be completed.</li> <li>PROCESSING: The challenge is awaiting approval from Let's Encrypt.</li> <li>VALID: The challenge is complete.</li> <li>INVALID: The rights check for a specific domain failed or the one-week period allocated for the check expired.</li> </ul> 
certificates[].<br>challenges[].<br>message | **string**<br><p>Description of the challenge.</p> 
certificates[].<br>challenges[].<br>error | **string**<br><p>Error of the challenge.</p> 
certificates[].<br>challenges[].<br>dnsChallenge | **object**<br>DNS-record. <br>`certificates[].challenges[]` includes only one of the fields `dnsChallenge`, `httpChallenge`<br><br>
certificates[].<br>challenges[].<br>dnsChallenge.<br>name | **string**<br><p>Name of the DNS record.</p> 
certificates[].<br>challenges[].<br>dnsChallenge.<br>type | **string**<br><p>Type of the DNS-record.</p> 
certificates[].<br>challenges[].<br>dnsChallenge.<br>value | **string**<br><p>Value of the DNS-record.</p> 
certificates[].<br>challenges[].<br>httpChallenge | **object**<br>HTTP-file. <br>`certificates[].challenges[]` includes only one of the fields `dnsChallenge`, `httpChallenge`<br><br>
certificates[].<br>challenges[].<br>httpChallenge.<br>url | **string**<br><p>Location of the HTTP file.</p> 
certificates[].<br>challenges[].<br>httpChallenge.<br>content | **string**<br><p>Content of the HTTP file.</p> 
certificates[].<br>deletionProtection | **boolean** (boolean)<br><p>Flag that protects deletion of the certificate</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is greater than the specified <a href="/docs/certificate-manager/api-ref/Certificate/list#query_params">pageSize</a>, use the ``next_page_token`` as the value for the <a href="/docs/certificate-manager/api-ref/Certificate/list#query_params">pageToken</a> query parameter in the next list request. Each subsequent list request will have its own <a href="/docs/certificate-manager/api-ref/Certificate/list#responses">nextPageToken</a> to continue paging through the results.</p> 