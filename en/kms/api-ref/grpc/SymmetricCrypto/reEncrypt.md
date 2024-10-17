---
editable: false
sourcePath: en/_api-ref-grpc/kms/v1/api-ref/grpc/SymmetricCrypto/reEncrypt.md
---

# Key Management Service API, gRPC: SymmetricCryptoService.ReEncrypt {#ReEncrypt}

Re-encrypts a ciphertext with the specified KMS key.

## gRPC request

**rpc ReEncrypt ([SymmetricReEncryptRequest](#yandex.cloud.kms.v1.SymmetricReEncryptRequest)) returns ([SymmetricReEncryptResponse](#yandex.cloud.kms.v1.SymmetricReEncryptResponse))**

## SymmetricReEncryptRequest {#yandex.cloud.kms.v1.SymmetricReEncryptRequest}

```json
{
  "keyId": "string",
  "versionId": "string",
  "aadContext": "bytes",
  "sourceKeyId": "string",
  "sourceAadContext": "bytes",
  "ciphertext": "bytes"
}
```

#|
||Field | Description ||
|| keyId | **string**

Required field. ID of the new key to be used for encryption. ||
|| versionId | **string**

ID of the version of the new key to be used for encryption.
Defaults to the primary version if not specified. ||
|| aadContext | **bytes**

Additional authenticated data to be required for decryption.
Should be encoded with base64. ||
|| sourceKeyId | **string**

Required field. ID of the key that the ciphertext is currently encrypted with. May be the same as for the new key. ||
|| sourceAadContext | **bytes**

Additional authenticated data provided with the initial encryption request.
Should be encoded with base64. ||
|| ciphertext | **bytes**

Required field. Ciphertext to re-encrypt.
Should be encoded with base64. ||
|#

## SymmetricReEncryptResponse {#yandex.cloud.kms.v1.SymmetricReEncryptResponse}

```json
{
  "keyId": "string",
  "versionId": "string",
  "sourceKeyId": "string",
  "sourceVersionId": "string",
  "ciphertext": "bytes"
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
|| ciphertext | **bytes**

Resulting re-encrypted ciphertext. ||
|#