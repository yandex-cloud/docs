---
editable: false
sourcePath: en/_api-ref/iam/api-ref/Key/list.md
---


# Method list
Retrieves the list of Key resources for the specified service account.
 

 
## HTTP request {#https-request}
```
GET https://iam.api.cloud.yandex.net/iam/v1/keys
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
format | Output format of the key.<ul> <li>PEM_FILE: Privacy-Enhanced Mail (PEM) format. Default value.</li> </ul> 
serviceAccountId | ID of the service account to list key pairs for. To get the service account ID, use a [list](/docs/iam/api-ref/ServiceAccount/list) request. If not specified, it defaults to the subject that made the request.  The maximum string length in characters is 50.
pageSize | The maximum number of results per page to return. If the number of available results is larger than [pageSize](/docs/iam/api-ref/Key/list#query_params), the service returns a [nextPageToken](/docs/iam/api-ref/Key/list#responses) that can be used to get the next page of results in subsequent list requests. Default value: 100.  The maximum value is 1000.
pageToken | Page token. To get the next page of results, set [pageToken](/docs/iam/api-ref/Key/list#query_params) to the [nextPageToken](/docs/iam/api-ref/Key/list#responses) returned by a previous list request.  The maximum string length in characters is 100.
 
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
keys[] | **object**<br><p>A Key resource. For more information, see <a href="/docs/iam/concepts/authorization/key">Authorized keys</a>.</p> 
keys[].<br>id | **string**<br><p>ID of the Key resource.</p> 
keys[].<br>createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
keys[].<br>description | **string**<br><p>Description of the Key resource. 0-256 characters long.</p> 
keys[].<br>keyAlgorithm | **string**<br>An algorithm used to generate a key pair of the Key resource.<br><ul> <li>RSA_2048: RSA with a 2048-bit key size. Default value.</li> <li>RSA_4096: RSA with a 4096-bit key size.</li> </ul> 
keys[].<br>publicKey | **string**<br><p>A public key of the Key resource.</p> 
keys[].<br>userAccountId | **string** <br>`keys[]` includes only one of the fields `userAccountId`, `serviceAccountId`<br><br><p>ID of the user account that the Key resource belongs to.</p> 
keys[].<br>serviceAccountId | **string** <br>`keys[]` includes only one of the fields `userAccountId`, `serviceAccountId`<br><br><p>ID of the service account that the Key resource belongs to.</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/iam/api-ref/Key/list#query_params">pageSize</a>, use the <a href="/docs/iam/api-ref/Key/list#responses">nextPageToken</a> as the value for the <a href="/docs/iam/api-ref/Key/list#query_params">pageToken</a> query parameter in the next list request. Each subsequent list request will have its own <a href="/docs/iam/api-ref/Key/list#responses">nextPageToken</a> to continue paging through the results.</p> 