---
editable: false
---

# Key Management Service API, REST: AsymmetricSignatureKey methods
Set of methods for managing asymmetric signature keys.
## JSON Representation {#representation}
```json 
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
```
 
Field | Description
--- | ---
id | **string**<br><p>ID of the key.</p> 
folderId | **string**<br><p>ID of the folder that the key belongs to.</p> 
createdAt | **string** (date-time)<br><p>Time when the key was created.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
name | **string**<br><p>Name of the key.</p> 
description | **string**<br><p>Description of the key.</p> 
labels | **object**<br><p>Custom labels for the key as ``key:value`` pairs. Maximum 64 per key.</p> 
status | **string**<br><p>Current status of the key.</p> <ul> <li>CREATING: The key is being created.</li> <li>ACTIVE: The key is active and can be used for encryption and decryption or signature and verification. Can be set to INACTIVE using the [AsymmetricKeyService.Update] method.</li> <li>INACTIVE: The key is inactive and unusable. Can be set to ACTIVE using the [AsymmetricKeyService.Update] method.</li> </ul> 
signatureAlgorithm | **string**<br><p>Signature Algorithm ID.</p> <p>Supported asymmetric signature algorithms.</p> <ul> <li>RSA_2048_SIGN_PSS_SHA_256: RSA-2048 signature with PSS padding and SHA-256</li> <li>RSA_2048_SIGN_PSS_SHA_384: RSA-2048 signature with PSS padding and SHA-384</li> <li>RSA_2048_SIGN_PSS_SHA_512: RSA-2048 signature with PSS padding and SHA-512</li> <li>RSA_3072_SIGN_PSS_SHA_256: RSA-3072 signature with PSS padding and SHA-256</li> <li>RSA_3072_SIGN_PSS_SHA_384: RSA-3072 signature with PSS padding and SHA-384</li> <li>RSA_3072_SIGN_PSS_SHA_512: RSA-3072 signature with PSS padding and SHA-512</li> <li>RSA_4096_SIGN_PSS_SHA_256: RSA-4096 signature with PSS padding and SHA-256</li> <li>RSA_4096_SIGN_PSS_SHA_384: RSA-4096 signature with PSS padding and SHA-384</li> <li>RSA_4096_SIGN_PSS_SHA_512: RSA-4096 signature with PSS padding and SHA-512</li> <li>ECDSA_NIST_P256_SHA_256: ECDSA signature with NIST P-256 curve and SHA-256</li> <li>ECDSA_NIST_P384_SHA_384: ECDSA signature with NIST P-384 curve and SHA-384</li> <li>ECDSA_NIST_P521_SHA_512: ECDSA signature with NIST P-521 curve and SHA-512</li> <li>ECDSA_NIST_SECP256_K1_SHA_256: ECDSA signature with SECP256_K1 curve and SHA-256</li> </ul> 
deletionProtection | **boolean** (boolean)<br><p>Flag that inhibits deletion of the key</p> 

## Methods {#methods}
Method | Description
--- | ---
[create](create.md) | control plane Creates an asymmetric KMS key in the specified folder.
[delete](delete.md) | Deletes the specified asymmetric KMS key. This action also automatically schedules the destruction of all of the key's versions in 72 hours.
[get](get.md) | Returns the specified asymmetric KMS key.
[list](list.md) | Returns the list of asymmetric KMS keys in the specified folder.
[listAccessBindings](listAccessBindings.md) | Lists existing access bindings for the specified key.
[listOperations](listOperations.md) | Lists operations for the specified asymmetric KMS key.
[setAccessBindings](setAccessBindings.md) | Sets access bindings for the key.
[update](update.md) | Updates the specified asymmetric KMS key.
[updateAccessBindings](updateAccessBindings.md) | Updates access bindings for the specified key.