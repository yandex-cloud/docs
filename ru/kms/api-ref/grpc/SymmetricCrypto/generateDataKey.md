---
editable: false
sourcePath: en/_api-ref-grpc/kms/v1/api-ref/grpc/SymmetricCrypto/generateDataKey.md
---

# Key Management Service API, gRPC: SymmetricCryptoService.GenerateDataKey

Generates a new symmetric data encryption key (not a KMS key) and returns
the generated key as plaintext and as ciphertext encrypted with the specified symmetric KMS key.

## gRPC request

**rpc GenerateDataKey ([GenerateDataKeyRequest](#yandex.cloud.kms.v1.GenerateDataKeyRequest)) returns ([GenerateDataKeyResponse](#yandex.cloud.kms.v1.GenerateDataKeyResponse))**

## GenerateDataKeyRequest {#yandex.cloud.kms.v1.GenerateDataKeyRequest}

```json
{
  "key_id": "string",
  "version_id": "string",
  "aad_context": "bytes",
  "data_key_spec": "SymmetricAlgorithm",
  "skip_plaintext": "bool"
}
```

#|
||Field | Description ||
|| key_id | **string**

Required field. ID of the symmetric KMS key that the generated data key should be encrypted with. ||
|| version_id | **string**

ID of the key version to encrypt the generated data key with.
Defaults to the primary version if not specified. ||
|| aad_context | **bytes**

Additional authenticated data (AAD context), optional.
If specified, this data will be required for decryption with the [SymmetricDecryptRequest](/docs/kms/api-ref/grpc/SymmetricCrypto/decrypt#yandex.cloud.kms.v1.SymmetricDecryptRequest).
Should be encoded with base64. ||
|| data_key_spec | enum **SymmetricAlgorithm**

Encryption algorithm and key length for the generated data key.

- `SYMMETRIC_ALGORITHM_UNSPECIFIED`
- `AES_128`: AES algorithm with 128-bit keys.
- `AES_192`: AES algorithm with 192-bit keys.
- `AES_256`: AES algorithm with 256-bit keys.
- `AES_256_HSM`: AES algorithm with 256-bit keys hosted by HSM ||
|| skip_plaintext | **bool**

If `true`, the method won't return the data key as plaintext.
Default value is `false`. ||
|#

## GenerateDataKeyResponse {#yandex.cloud.kms.v1.GenerateDataKeyResponse}

```json
{
  "key_id": "string",
  "version_id": "string",
  "data_key_plaintext": "bytes",
  "data_key_ciphertext": "bytes"
}
```

#|
||Field | Description ||
|| key_id | **string**

ID of the symmetric KMS key that was used to encrypt the generated data key. ||
|| version_id | **string**

ID of the key version that was used for encryption. ||
|| data_key_plaintext | **bytes**

Generated data key as plaintext.
The field is empty, if the [GenerateDataKeyRequest.skip_plaintext](#yandex.cloud.kms.v1.GenerateDataKeyRequest) parameter
was set to `true`. ||
|| data_key_ciphertext | **bytes**

The encrypted data key. ||
|#