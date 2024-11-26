---
editable: false
sourcePath: en/_api-ref-grpc/kms/v1/api-ref/grpc/SymmetricCrypto/reEncrypt.md
---

# Key Management Service API, gRPC: SymmetricCryptoService.ReEncrypt

Re-encrypts a ciphertext with the specified KMS key.

## gRPC request

**rpc ReEncrypt ([SymmetricReEncryptRequest](#yandex.cloud.kms.v1.SymmetricReEncryptRequest)) returns ([SymmetricReEncryptResponse](#yandex.cloud.kms.v1.SymmetricReEncryptResponse))**

## SymmetricReEncryptRequest {#yandex.cloud.kms.v1.SymmetricReEncryptRequest}

```json
{
  "key_id": "string",
  "version_id": "string",
  "aad_context": "bytes",
  "source_key_id": "string",
  "source_aad_context": "bytes",
  "ciphertext": "bytes"
}
```

#|
||Field | Description ||
|| key_id | **string**

Required field. ID of the new key to be used for encryption. ||
|| version_id | **string**

ID of the version of the new key to be used for encryption.
Defaults to the primary version if not specified. ||
|| aad_context | **bytes**

Additional authenticated data to be required for decryption.
Should be encoded with base64. ||
|| source_key_id | **string**

Required field. ID of the key that the ciphertext is currently encrypted with. May be the same as for the new key. ||
|| source_aad_context | **bytes**

Additional authenticated data provided with the initial encryption request.
Should be encoded with base64. ||
|| ciphertext | **bytes**

Required field. Ciphertext to re-encrypt.
Should be encoded with base64. ||
|#

## SymmetricReEncryptResponse {#yandex.cloud.kms.v1.SymmetricReEncryptResponse}

```json
{
  "key_id": "string",
  "version_id": "string",
  "source_key_id": "string",
  "source_version_id": "string",
  "ciphertext": "bytes"
}
```

#|
||Field | Description ||
|| key_id | **string**

ID of the key that the ciphertext is encrypted with now. ||
|| version_id | **string**

ID of key version that was used for encryption. ||
|| source_key_id | **string**

ID of the key that the ciphertext was encrypted with previously. ||
|| source_version_id | **string**

ID of the key version that was used to decrypt the re-encrypted ciphertext. ||
|| ciphertext | **bytes**

Resulting re-encrypted ciphertext. ||
|#