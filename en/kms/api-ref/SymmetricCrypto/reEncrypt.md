---
editable: false
sourcePath: en/_api-ref/kms/v1/api-ref/SymmetricCrypto/reEncrypt.md
---

# Key Management Service API, REST: SymmetricCrypto.ReEncrypt {#ReEncrypt}

Re-encrypts a ciphertext with the specified KMS key.

## HTTP request

```
POST https://{{ api-host-kms-symcrypto }}/kms/v1/keys/{keyId}:reEncrypt
```

## Path parameters

#|
||Field | Description ||
|| keyId | **string**

Required field. ID of the new key to be used for encryption. ||
|#

## Body parameters {#yandex.cloud.kms.v1.SymmetricReEncryptRequest}

```json
{
  "versionId": "string",
  "aadContext": "string",
  "sourceKeyId": "string",
  "sourceAadContext": "string",
  "ciphertext": "string"
}
```

#|
||Field | Description ||
|| versionId | **string**

ID of the version of the new key to be used for encryption.
Defaults to the primary version if not specified. ||
|| aadContext | **string** (bytes)

Additional authenticated data to be required for decryption.
Should be encoded with base64. ||
|| sourceKeyId | **string**

Required field. ID of the key that the ciphertext is currently encrypted with. May be the same as for the new key. ||
|| sourceAadContext | **string** (bytes)

Additional authenticated data provided with the initial encryption request.
Should be encoded with base64. ||
|| ciphertext | **string** (bytes)

Required field. Ciphertext to re-encrypt.
Should be encoded with base64. ||
|#

## Response {#yandex.cloud.kms.v1.SymmetricReEncryptResponse}

**HTTP Code: 200 - OK**

```json
{
  "keyId": "string",
  "versionId": "string",
  "sourceKeyId": "string",
  "sourceVersionId": "string",
  "ciphertext": "string"
}
```

#|
||Field | Description ||
|| keyId | **string**

ID of the key that the ciphertext is encrypted with now. ||
|| versionId | **string**

ID of key version that was used for encryption. ||
|| sourceKeyId | **string**

ID of the key that the ciphertext was encrypted with previously. ||
|| sourceVersionId | **string**

ID of the key version that was used to decrypt the re-encrypted ciphertext. ||
|| ciphertext | **string** (bytes)

Resulting re-encrypted ciphertext. ||
|#