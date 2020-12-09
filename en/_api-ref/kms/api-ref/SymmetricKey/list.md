---
editable: false
---

# Method list
Returns the list of symmetric KMS keys in the specified folder.
 

 
## HTTP request {#https-request}
```
GET https://kms.api.cloud.yandex.net/kms/v1/keys
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | Required. ID of the folder to list symmetric KMS keys in.  The maximum string length in characters is 50.
pageSize | The maximum number of results per page to return. If the number of available results is larger than [pageSize](/docs/kms/api-ref/SymmetricKey/list#query_params), the service returns a [nextPageToken](/docs/kms/api-ref/SymmetricKey/list#responses) that can be used to get the next page of results in subsequent list requests. Default value: 100.  The maximum value is 1000.
pageToken | Page token. To get the next page of results, set [pageToken](/docs/kms/api-ref/SymmetricKey/list#query_params) to the [nextPageToken](/docs/kms/api-ref/SymmetricKey/list#responses) returned by a previous list request.  The maximum string length in characters is 100.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "keys": [
    {
      "id": "string",
      "folderId": "string",
      "createdAt": "string",
      "name": "string",
      "description": "string",
      "labels": "object",
      "status": "string",
      "primaryVersion": {
        "id": "string",
        "keyId": "string",
        "status": "string",
        "algorithm": "string",
        "createdAt": "string",
        "primary": true,
        "destroyAt": "string"
      },
      "defaultAlgorithm": "string",
      "rotatedAt": "string",
      "rotationPeriod": "string",
      "deletionProtection": true
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
keys[] | **object**<br><p>A symmetric KMS key that may contain several versions of the cryptographic material.</p> 
keys[].<br>id | **string**<br><p>ID of the key.</p> 
keys[].<br>folderId | **string**<br><p>ID of the folder that the key belongs to.</p> 
keys[].<br>createdAt | **string** (date-time)<br><p>Time when the key was created.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
keys[].<br>name | **string**<br><p>Name of the key.</p> 
keys[].<br>description | **string**<br><p>Description of the key.</p> 
keys[].<br>labels | **object**<br><p>Custom labels for the key as `key:value` pairs. Maximum 64 per key.</p> 
keys[].<br>status | **string**<br><p>Current status of the key.</p> <ul> <li>CREATING: The key is being created.</li> <li>ACTIVE: The key is active and can be used for encryption and decryption. Can be set to INACTIVE using the <a href="/docs/kms/api-ref/SymmetricKey/update">update</a> method.</li> <li>INACTIVE: The key is inactive and unusable. Can be set to ACTIVE using the <a href="/docs/kms/api-ref/SymmetricKey/update">update</a> method.</li> </ul> 
keys[].<br>primaryVersion | **object**<br><p>Primary version of the key, used as the default for all encrypt/decrypt operations, when no version ID is specified.</p> <p>Symmetric KMS key version: metadata about actual cryptographic data.</p> 
keys[].<br>primaryVersion.<br>id | **string**<br><p>ID of the key version.</p> 
keys[].<br>primaryVersion.<br>keyId | **string**<br><p>ID of the symmetric KMS key that the version belongs to.</p> 
keys[].<br>primaryVersion.<br>status | **string**<br><p>Status of the key version.</p> <p>Possible version status.</p> <ul> <li>ACTIVE: The version is active and can be used for encryption and decryption.</li> <li>SCHEDULED_FOR_DESTRUCTION: The version is scheduled for destruction, the time when it will be destroyed is specified in the `destroyAt` field.</li> <li>DESTROYED: The version is destroyed and cannot be recovered.</li> </ul> 
keys[].<br>primaryVersion.<br>algorithm | **string**<br><p>Encryption algorithm that should be used when using the key version to encrypt plaintext.</p> <p>Supported symmetric encryption algorithms.</p> <ul> <li>AES_128: AES algorithm with 128-bit keys.</li> <li>AES_192: AES algorithm with 192-bit keys.</li> <li>AES_256: AES algorithm with 256-bit keys.</li> </ul> 
keys[].<br>primaryVersion.<br>createdAt | **string** (date-time)<br><p>Time when the key version was created.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
keys[].<br>primaryVersion.<br>primary | **boolean** (boolean)<br><p>Indication of a primary version, that is to be used by default for all cryptographic operations that don't have a key version explicitly specified.</p> 
keys[].<br>primaryVersion.<br>destroyAt | **string** (date-time)<br><p>Time when the key version is going to be destroyed. Empty unless the status is `SCHEDULED_FOR_DESTRUCTION`.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
keys[].<br>defaultAlgorithm | **string**<br><p>Default encryption algorithm to be used with new versions of the key.</p> <p>Supported symmetric encryption algorithms.</p> <ul> <li>AES_128: AES algorithm with 128-bit keys.</li> <li>AES_192: AES algorithm with 192-bit keys.</li> <li>AES_256: AES algorithm with 256-bit keys.</li> </ul> 
keys[].<br>rotatedAt | **string** (date-time)<br><p>Time of the last key rotation (time when the last version was created). Empty if the key does not have versions yet.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
keys[].<br>rotationPeriod | **string**<br><p>Time period between automatic key rotations.</p> 
keys[].<br>deletionProtection | **boolean** (boolean)<br><p>Flag that inhibits deletion of the key</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is greater than the specified <a href="/docs/kms/api-ref/SymmetricKey/list#query_params">pageSize</a>, use the <a href="/docs/kms/api-ref/SymmetricKey/list#responses">nextPageToken</a> as the value for the <a href="/docs/kms/api-ref/SymmetricKey/list#query_params">pageToken</a> query parameter in the next list request. Each subsequent list request will have its own <a href="/docs/kms/api-ref/SymmetricKey/list#responses">nextPageToken</a> to continue paging through the results.</p> 