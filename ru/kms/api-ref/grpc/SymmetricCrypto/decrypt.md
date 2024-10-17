---
editable: false
sourcePath: en/_api-ref-grpc/kms/v1/api-ref/grpc/SymmetricCrypto/decrypt.md
---

# Key Management Service API, gRPC: SymmetricCryptoService.Decrypt {#Decrypt}

Decrypts the given ciphertext with the specified key.

## gRPC request

**rpc Decrypt ([SymmetricDecryptRequest](#yandex.cloud.kms.v1.SymmetricDecryptRequest)) returns ([SymmetricDecryptResponse](#yandex.cloud.kms.v1.SymmetricDecryptResponse))**

## SymmetricDecryptRequest {#yandex.cloud.kms.v1.SymmetricDecryptRequest}

```json
{
  "keyId": "string",
  "aadContext": "bytes",
  "ciphertext": "bytes"
}
```

#|
||Field | Description ||
|| keyId | **string**

Required field. ID of the symmetric KMS key to use for decryption. ||
|| aadContext | **bytes**

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
  "keyId": "string",
  "versionId": "string",
  "plaintext": "bytes"
}
```

#|
||Field | Description ||
|| keyId | **string**

ID of the symmetric KMS key that was used for decryption. ||
|| versionId | **string**

ID of the key version that was used for decryption. ||
|| plaintext | **bytes**

Decrypted plaintext. ||
|#