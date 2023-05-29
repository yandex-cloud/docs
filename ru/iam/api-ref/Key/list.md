---
editable: false
sourcePath: en/_api-ref/iam/v1/api-ref/Key/list.md
---

# Identity and Access Management API, REST: Key.list
Retrieves the list of Key resources for the specified service account.
 

 
## HTTP request {#https-request}
```
GET https://iam.{{ api-host }}/iam/v1/keys
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
format | <p>Output format of the key.</p> <ul> <li>PEM_FILE: Privacy-Enhanced Mail (PEM) format. Default value.</li> </ul> 
serviceAccountId | <p>ID of the service account to list key pairs for. To get the service account ID, use a <a href="/docs/iam/api-ref/ServiceAccount/list">list</a> request. If not specified, it defaults to the subject that made the request.</p> <p>The maximum string length in characters is 50.</p> 
pageSize | <p>The maximum number of results per page to return. If the number of available results is larger than <a href="/docs/iam/api-ref/Key/list#query_params">pageSize</a>, the service returns a <a href="/docs/iam/api-ref/Key/list#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests. Default value: 100.</p> <p>The maximum value is 1000.</p> 
pageToken | <p>Page token. To get the next page of results, set <a href="/docs/iam/api-ref/Key/list#query_params">pageToken</a> to the <a href="/docs/iam/api-ref/Key/list#responses">nextPageToken</a> returned by a previous list request.</p> <p>The maximum string length in characters is 2000.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "keys": [
    {
      "id": "string",
      "createdAt": "string",
      "description": "string",
      "keyAlgorithm": "string",
      "publicKey": "string",

      // `keys[]` includes only one of the fields `userAccountId`, `serviceAccountId`
      "userAccountId": "string",
      "serviceAccountId": "string",
      // end of the list of possible fields`keys[]`

    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
keys[] | **object**<br><p>List of Key resources.</p> 
keys[].<br>id | **string**<br><p>ID of the Key resource.</p> 
keys[].<br>createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
keys[].<br>description | **string**<br><p>Description of the Key resource. 0-256 characters long.</p> 
keys[].<br>keyAlgorithm | **string**<br>An algorithm used to generate a key pair of the Key resource.<br><ul> <li>RSA_2048: RSA with a 2048-bit key size. Default value.</li> <li>RSA_4096: RSA with a 4096-bit key size.</li> </ul> 
keys[].<br>publicKey | **string**<br><p>A public key of the Key resource.</p> 
keys[].<br>userAccountId | **string** <br>`keys[]` includes only one of the fields `userAccountId`, `serviceAccountId`<br><br><p>ID of the user account that the Key resource belongs to.</p> 
keys[].<br>serviceAccountId | **string** <br>`keys[]` includes only one of the fields `userAccountId`, `serviceAccountId`<br><br><p>ID of the service account that the Key resource belongs to.</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/iam/api-ref/Key/list#query_params">pageSize</a>, use the <a href="/docs/iam/api-ref/Key/list#responses">nextPageToken</a> as the value for the <a href="/docs/iam/api-ref/Key/list#query_params">pageToken</a> query parameter in the next list request. Each subsequent list request will have its own <a href="/docs/iam/api-ref/Key/list#responses">nextPageToken</a> to continue paging through the results.</p> 