---
editable: false
sourcePath: en/_api-ref/kms/v1/asymmetricsignature/api-ref/AsymmetricSignatureKey/list.md
---

# Key Management Service API, REST: AsymmetricSignatureKey.list
Returns the list of asymmetric KMS keys in the specified folder.
 

 
## HTTP request {#https-request}
```
GET https://{{ api-host-kms }}/kms/v1/asymmetricSignatureKeys
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | <p>Required. ID of the folder to list asymmetric KMS keys in.</p> <p>The maximum string length in characters is 50.</p> 
pageSize | <p>The maximum number of results per page to return. If the number of available results is larger than <a href="/docs/kms/api-ref/AsymmetricSignatureKey/list#query_params">pageSize</a>, the service returns a <a href="/docs/kms/api-ref/AsymmetricSignatureKey/list#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests. Default value: 100.</p> <p>The maximum value is 1000.</p> 
pageToken | <p>Page token. To get the next page of results, set <a href="/docs/kms/api-ref/AsymmetricSignatureKey/list#query_params">pageToken</a> to the <a href="/docs/kms/api-ref/AsymmetricSignatureKey/list#responses">nextPageToken</a> returned by a previous list request.</p> <p>The maximum string length in characters is 100.</p> 
 
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
      "signatureAlgorithm": "string",
      "deletionProtection": true
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
keys[] | **object**<br><p>List of asymmetric KMS keys in the specified folder.</p> 
keys[].<br>id | **string**<br><p>ID of the key.</p> 
keys[].<br>folderId | **string**<br><p>ID of the folder that the key belongs to.</p> 
keys[].<br>createdAt | **string** (date-time)<br><p>Time when the key was created.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
keys[].<br>name | **string**<br><p>Name of the key.</p> 
keys[].<br>description | **string**<br><p>Description of the key.</p> 
keys[].<br>labels | **object**<br><p>Custom labels for the key as ``key:value`` pairs. Maximum 64 per key.</p> 
keys[].<br>status | **string**<br><p>Current status of the key.</p> <ul> <li>CREATING: The key is being created.</li> <li>ACTIVE: The key is active and can be used for encryption and decryption or signature and verification. Can be set to INACTIVE using the [AsymmetricKeyService.Update] method.</li> <li>INACTIVE: The key is inactive and unusable. Can be set to ACTIVE using the [AsymmetricKeyService.Update] method.</li> </ul> 
keys[].<br>signatureAlgorithm | **string**<br><p>Signature Algorithm ID.</p> <p>Supported asymmetric signature algorithms.</p> <ul> <li>RSA_2048_SIGN_PSS_SHA_256: RSA-2048 signature with PSS padding and SHA-256</li> <li>RSA_2048_SIGN_PSS_SHA_384: RSA-2048 signature with PSS padding and SHA-384</li> <li>RSA_2048_SIGN_PSS_SHA_512: RSA-2048 signature with PSS padding and SHA-512</li> <li>RSA_3072_SIGN_PSS_SHA_256: RSA-3072 signature with PSS padding and SHA-256</li> <li>RSA_3072_SIGN_PSS_SHA_384: RSA-3072 signature with PSS padding and SHA-384</li> <li>RSA_3072_SIGN_PSS_SHA_512: RSA-3072 signature with PSS padding and SHA-512</li> <li>RSA_4096_SIGN_PSS_SHA_256: RSA-4096 signature with PSS padding and SHA-256</li> <li>RSA_4096_SIGN_PSS_SHA_384: RSA-4096 signature with PSS padding and SHA-384</li> <li>RSA_4096_SIGN_PSS_SHA_512: RSA-4096 signature with PSS padding and SHA-512</li> <li>ECDSA_NIST_P256_SHA_256: ECDSA signature with NIST P-256 curve and SHA-256</li> <li>ECDSA_NIST_P384_SHA_384: ECDSA signature with NIST P-384 curve and SHA-384</li> <li>ECDSA_NIST_P521_SHA_512: ECDSA signature with NIST P-521 curve and SHA-512</li> <li>ECDSA_SECP256_K1_SHA_256: ECDSA signature with SECP256_K1 curve and SHA-256</li> </ul> 
keys[].<br>deletionProtection | **boolean** (boolean)<br><p>Flag that inhibits deletion of the key</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is greater than the specified <a href="/docs/kms/api-ref/AsymmetricSignatureKey/list#query_params">pageSize</a>, use the <a href="/docs/kms/api-ref/AsymmetricSignatureKey/list#responses">nextPageToken</a> as the value for the <a href="/docs/kms/api-ref/AsymmetricSignatureKey/list#query_params">pageToken</a> query parameter in the next list request. Each subsequent list request will have its own <a href="/docs/kms/api-ref/AsymmetricSignatureKey/list#responses">nextPageToken</a> to continue paging through the results.</p> 