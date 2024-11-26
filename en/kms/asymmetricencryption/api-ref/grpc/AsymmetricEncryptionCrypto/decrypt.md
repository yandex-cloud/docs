---
editable: false
sourcePath: en/_api-ref-grpc/kms/v1/asymmetricencryption/api-ref/grpc/AsymmetricEncryptionCrypto/decrypt.md
---

# Key Management Service API, gRPC: AsymmetricEncryptionCryptoService.Decrypt

Decrypts the given ciphertext with the specified key.

## gRPC request

**rpc Decrypt ([AsymmetricDecryptRequest](#yandex.cloud.kms.v1.asymmetricencryption.AsymmetricDecryptRequest)) returns ([AsymmetricDecryptResponse](#yandex.cloud.kms.v1.asymmetricencryption.AsymmetricDecryptResponse))**

## AsymmetricDecryptRequest {#yandex.cloud.kms.v1.asymmetricencryption.AsymmetricDecryptRequest}

```json
{
  "key_id": "string",
  "ciphertext": "bytes"
}
```

#|
||Field | Description ||
|| key_id | **string**

Required field. ID of the asymmetric KMS key to use for decryption. ||
|| ciphertext | **bytes**

Required field. Ciphertext to be decrypted.
Should be encoded with base64. ||
|#

## AsymmetricDecryptResponse {#yandex.cloud.kms.v1.asymmetricencryption.AsymmetricDecryptResponse}

```json
{
  "key_id": "string",
  "plaintext": "bytes"
}
```

#|
||Field | Description ||
|| key_id | **string**

ID of the asymmetric KMS key that was used for decryption. ||
|| plaintext | **bytes**

Decrypted plaintext. ||
|#