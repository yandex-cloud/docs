---
editable: false
sourcePath: en/_api-ref/kms/v1/api-ref/SymmetricCrypto/encrypt.md
---

# Key Management Service API, REST: SymmetricCrypto.Encrypt {#Encrypt}

Encrypts given plaintext with the specified key.

## HTTP request

```
POST https://{{ api-host-kms-symcrypto }}/kms/v1/keys/{keyId}:encrypt
```

## Path parameters

#|
||Field | Description ||
|| keyId | **string**

Required field. ID of the symmetric KMS key to use for encryption. ||
|#

## Body parameters {#yandex.cloud.kms.v1.SymmetricEncryptRequest}

```json
{
  "versionId": "string",
  "aadContext": "string",
  "plaintext": "string"
}
```

#|
||Field | Description ||
|| versionId | **string**

ID of the key version to encrypt plaintext with.
Defaults to the primary version if not specified. ||
|| aadContext | **string** (bytes)

Additional authenticated data (AAD context), optional.
If specified, this data will be required for decryption with the [SymmetricDecryptRequest](/docs/kms/api-ref/SymmetricCrypto/decrypt#yandex.cloud.kms.v1.SymmetricDecryptRequest).
Should be encoded with base64. ||
|| plaintext | **string** (bytes)

Required field. Plaintext to be encrypted.
Should be encoded with base64. ||
|#

## Response {#yandex.cloud.kms.v1.SymmetricEncryptResponse}

**HTTP Code: 200 - OK**

```json
{
  "keyId": "string",
  "versionId": "string",
  "ciphertext": "string"
}
```

#|
||Field | Description ||
|| keyId | **string**

Required field. ID of the symmetric KMS key that was used for encryption. ||
|| versionId | **string**

ID of the key version that was used for encryption. ||
|| ciphertext | **string** (bytes)

Resulting ciphertext. ||
|#