---
editable: false
---

# Key Management Service API, REST: SymmetricKey.listVersions
Returns the list of versions of the specified symmetric KMS key.
 

 
## HTTP request {#https-request}
```
GET https://kms.{{ api-host }}/kms/v1/keys/{keyId}/versions
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
keyId | <p>Required. ID of the symmetric KMS key to list versions for.</p> <p>The maximum string length in characters is 50.</p> 
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | <p>The maximum number of results per page to return. If the number of available results is larger than <a href="/docs/kms/api-ref/SymmetricKey/listVersions#query_params">pageSize</a>, the service returns a <a href="/docs/kms/api-ref/SymmetricKey/listVersions#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests. Default value: 100.</p> <p>The maximum value is 1000.</p> 
pageToken | <p>Page token. To get the next page of results, set <a href="/docs/kms/api-ref/SymmetricKey/listVersions#query_params">pageToken</a> to the <a href="/docs/kms/api-ref/SymmetricKey/listVersions#responses">nextPageToken</a> returned by a previous list request.</p> <p>The maximum string length in characters is 100.</p> 
 
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
      "destroyAt": "string",
      "hostedByHsm": true
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
keyVersions[] | **object**<br><p>List of versions for the specified symmetric KMS key.</p> 
keyVersions[].<br>id | **string**<br><p>ID of the key version.</p> 
keyVersions[].<br>keyId | **string**<br><p>ID of the symmetric KMS key that the version belongs to.</p> 
keyVersions[].<br>status | **string**<br><p>Status of the key version.</p> <p>Possible version status.</p> <ul> <li>ACTIVE: The version is active and can be used for encryption and decryption.</li> <li>SCHEDULED_FOR_DESTRUCTION: The version is scheduled for destruction, the time when it will be destroyed is specified in the ``destroyAt`` field.</li> <li>DESTROYED: The version is destroyed and cannot be recovered.</li> </ul> 
keyVersions[].<br>algorithm | **string**<br><p>Encryption algorithm that should be used when using the key version to encrypt plaintext.</p> <p>Supported symmetric encryption algorithms.</p> <ul> <li>AES_128: AES algorithm with 128-bit keys.</li> <li>AES_192: AES algorithm with 192-bit keys.</li> <li>AES_256: AES algorithm with 256-bit keys.</li> <li>AES_256_HSM: AES algorithm with 256-bit keys hosted by HSM</li> </ul> 
keyVersions[].<br>createdAt | **string** (date-time)<br><p>Time when the key version was created.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
keyVersions[].<br>primary | **boolean** (boolean)<br><p>Indication of a primary version, that is to be used by default for all cryptographic operations that don't have a key version explicitly specified.</p> 
keyVersions[].<br>destroyAt | **string** (date-time)<br><p>Time when the key version is going to be destroyed. Empty unless the status is ``SCHEDULED_FOR_DESTRUCTION``.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
keyVersions[].<br>hostedByHsm | **boolean** (boolean)<br><p>Indication of the version that is hosted by HSM.</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is greater than the specified <a href="/docs/kms/api-ref/SymmetricKey/listVersions#query_params">pageSize</a>, use the <a href="/docs/kms/api-ref/SymmetricKey/listVersions#responses">nextPageToken</a> as the value for the <a href="/docs/kms/api-ref/SymmetricKey/listVersions#query_params">pageToken</a> query parameter in the next list request. Each subsequent list request will have its own <a href="/docs/kms/api-ref/SymmetricKey/listVersions#responses">nextPageToken</a> to continue paging through the results.</p> 