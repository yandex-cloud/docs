---
editable: false
---

# Key Management Service API, gRPC: SymmetricCryptoService.Encrypt

Encrypts given plaintext with the specified key.

## gRPC request

**rpc Encrypt ([SymmetricEncryptRequest](#yandex.cloud.kms.v1.SymmetricEncryptRequest)) returns ([SymmetricEncryptResponse](#yandex.cloud.kms.v1.SymmetricEncryptResponse))**

## SymmetricEncryptRequest {#yandex.cloud.kms.v1.SymmetricEncryptRequest}

```json
{
  "key_id": "string",
  "version_id": "string",
  "aad_context": "bytes",
  "plaintext": "bytes"
}
```

#|
||Field | Description ||
|| key_id | **string**

Required field. ID of the symmetric KMS key to use for encryption.

The maximum string length in characters is 50. ||
|| version_id | **string**

ID of the key version to encrypt plaintext with.
Defaults to the primary version if not specified.

The maximum string length in characters is 50. ||
|| aad_context | **bytes**

Additional authenticated data (AAD context), optional.
If specified, this data will be required for decryption with the [SymmetricDecryptRequest](/docs/kms/api-ref/grpc/SymmetricCrypto/decrypt#yandex.cloud.kms.v1.SymmetricDecryptRequest).
Should be encoded with base64.

The maximum string length in characters is 8192. ||
|| plaintext | **bytes**

Required field. Plaintext to be encrypted.
Should be encoded with base64.

The maximum string length in characters is 32768. ||
|#

## SymmetricEncryptResponse {#yandex.cloud.kms.v1.SymmetricEncryptResponse}

```json
{
  "key_id": "string",
  "version_id": "string",
  "ciphertext": "bytes"
}
```

#|
||Field | Description ||
|| key_id | **string**

Required field. ID of the symmetric KMS key that was used for encryption.

The maximum string length in characters is 50. ||
|| version_id | **string**

ID of the key version that was used for encryption.

The maximum string length in characters is 50. ||
|| ciphertext | **bytes**

Resulting ciphertext. ||
|#