---
editable: false

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---


# Method listVersions
Returns the list of versions of the specified symmetric KMS key.
 

 
## HTTP request {#https-request}
```
GET https://kms.api.cloud.yandex.net/kms/v1/keys/{keyId}/versions
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
keyId | Required. ID of the symmetric KMS key to list versions for.  The maximum string length in characters is 50.
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | The maximum number of results per page to return. If the number of available results is larger than [pageSize](/docs/kms/api-ref/SymmetricKey/listVersions#query_params), the service returns a [nextPageToken](/docs/kms/api-ref/SymmetricKey/listVersions#responses) that can be used to get the next page of results in subsequent list requests. Default value: 100.  The maximum value is 1000.
pageToken | Page token. To get the next page of results, set [pageToken](/docs/kms/api-ref/SymmetricKey/listVersions#query_params) to the [nextPageToken](/docs/kms/api-ref/SymmetricKey/listVersions#responses) returned by a previous list request.  The maximum string length in characters is 100.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "keyVersions": [
    {
      "id": "string",
      "keyId": "string",
      "status": "string",
      "algorithm": "string",
      "createdAt": "string",
      "primary": true,
      "destroyAt": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
keyVersions[] | **object**<br><p>Symmetric KMS key version: metadata about actual cryptographic data.</p> 
keyVersions[].<br>id | **string**<br><p>ID of the key version.</p> 
keyVersions[].<br>keyId | **string**<br><p>ID of the symmetric KMS key that the version belongs to.</p> 
keyVersions[].<br>status | **string**<br><p>Status of the key version.</p> <p>Possible version status.</p> <ul> <li>ACTIVE: The version is active and can be used for encryption and decryption.</li> <li>SCHEDULED_FOR_DESTRUCTION: The version is scheduled for destruction, the time when it will be destroyed is specified in the ``destroyAt`` field.</li> <li>DESTROYED: The version is destroyed and cannot be recovered.</li> </ul> 
keyVersions[].<br>algorithm | **string**<br><p>Encryption algorithm that should be used when using the key version to encrypt plaintext.</p> <p>Supported symmetric encryption algorithms.</p> <ul> <li>AES_128: AES algorithm with 128-bit keys.</li> <li>AES_192: AES algorithm with 192-bit keys.</li> <li>AES_256: AES algorithm with 256-bit keys.</li> </ul> 
keyVersions[].<br>createdAt | **string** (date-time)<br><p>Time when the key version was created.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
keyVersions[].<br>primary | **boolean** (boolean)<br><p>Indication of a primary version, that is to be used by default for all cryptographic operations that don't have a key version explicitly specified.</p> 
keyVersions[].<br>destroyAt | **string** (date-time)<br><p>Time when the key version is going to be destroyed. Empty unless the status is ``SCHEDULED_FOR_DESTRUCTION``.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is greater than the specified <a href="/docs/kms/api-ref/SymmetricKey/listVersions#query_params">pageSize</a>, use the <a href="/docs/kms/api-ref/SymmetricKey/listVersions#responses">nextPageToken</a> as the value for the <a href="/docs/kms/api-ref/SymmetricKey/listVersions#query_params">pageToken</a> query parameter in the next list request. Each subsequent list request will have its own <a href="/docs/kms/api-ref/SymmetricKey/listVersions#responses">nextPageToken</a> to continue paging through the results.</p> 