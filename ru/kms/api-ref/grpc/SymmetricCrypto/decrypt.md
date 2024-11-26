---
editable: false
sourcePath: en/_api-ref-grpc/kms/v1/api-ref/grpc/SymmetricCrypto/decrypt.md
---

# Key Management Service API, gRPC: SymmetricCryptoService.Decrypt

Decrypts the given ciphertext with the specified key.

## gRPC request

**rpc Decrypt ([SymmetricDecryptRequest](#yandex.cloud.kms.v1.SymmetricDecryptRequest)) returns ([SymmetricDecryptResponse](#yandex.cloud.kms.v1.SymmetricDecryptResponse))**

## SymmetricDecryptRequest {#yandex.cloud.kms.v1.SymmetricDecryptRequest}

```json
{
  "key_id": "string",
  "aad_context": "bytes",
  "ciphertext": "bytes"
}
```

#|
||Field | Description ||
|| key_id | **string**

Required field. ID of the symmetric KMS key to use for decryption. ||
|| aad_context | **bytes**

Additional authenticated data, must be the same as was provided
in the corresponding [SymmetricEncryptRequest](/docs/kms/api-ref/grpc/SymmetricCrypto/encrypt#yandex.cloud.kms.v1.SymmetricEncryptRequest).
Should be encoded with base64. ||
|| ciphertext | **bytes**

Required field. Ciphertext to be decrypted.
Should be encoded with base64. ||
|#

## SymmetricDecryptResponse {#yandex.cloud.kms.v1.SymmetricDecryptResponse}

```json
{
  "key_id": "string",
  "version_id": "string",
  "plaintext": "bytes"
}
```

#|
||Field | Description ||
|| key_id | **string**

ID of the symmetric KMS key that was used for decryption. ||
|| version_id | **string**

ID of the key version that was used for decryption. ||
|| plaintext | **bytes**

Decrypted plaintext. ||
|#