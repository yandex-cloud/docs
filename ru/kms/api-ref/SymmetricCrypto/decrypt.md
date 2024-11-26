---
editable: false
sourcePath: en/_api-ref/kms/v1/api-ref/SymmetricCrypto/decrypt.md
---

# Key Management Service API, REST: SymmetricCrypto.Decrypt

Decrypts the given ciphertext with the specified key.

## HTTP request

```
POST https://{{ api-host-kms-symcrypto }}/kms/v1/keys/{keyId}:decrypt
```

## Path parameters

#|
||Field | Description ||
|| keyId | **string**

Required field. ID of the symmetric KMS key to use for decryption. ||
|#

## Body parameters {#yandex.cloud.kms.v1.SymmetricDecryptRequest}

```json
{
  "aadContext": "string",
  "ciphertext": "string"
}
```

#|
||Field | Description ||
|| aadContext | **string** (bytes)

Additional authenticated data, must be the same as was provided
in the corresponding [SymmetricEncryptRequest](/docs/kms/api-ref/SymmetricCrypto/encrypt#yandex.cloud.kms.v1.SymmetricEncryptRequest).
Should be encoded with base64. ||
|| ciphertext | **string** (bytes)

Required field. Ciphertext to be decrypted.
Should be encoded with base64. ||
|#

## Response {#yandex.cloud.kms.v1.SymmetricDecryptResponse}

**HTTP Code: 200 - OK**

```json
{
  "keyId": "string",
  "versionId": "string",
  "plaintext": "string"
}
```

#|
||Field | Description ||
|| keyId | **string**

ID of the symmetric KMS key that was used for decryption. ||
|| versionId | **string**

ID of the key version that was used for decryption. ||
|| plaintext | **string** (bytes)

Decrypted plaintext. ||
|#