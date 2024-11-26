---
editable: false
sourcePath: en/_api-ref/kms/v1/asymmetricencryption/api-ref/AsymmetricEncryptionCrypto/decrypt.md
---

# Key Management Service API, REST: AsymmetricEncryptionCrypto.Decrypt

Decrypts the given ciphertext with the specified key.

## HTTP request

```
POST https://{{ api-host-kms }}/kms/v1/asymmetricEncryptionKeys/{keyId}:decrypt
```

## Path parameters

#|
||Field | Description ||
|| keyId | **string**

Required field. ID of the asymmetric KMS key to use for decryption. ||
|#

## Body parameters {#yandex.cloud.kms.v1.asymmetricencryption.AsymmetricDecryptRequest}

```json
{
  "ciphertext": "string"
}
```

#|
||Field | Description ||
|| ciphertext | **string** (bytes)

Required field. Ciphertext to be decrypted.
Should be encoded with base64. ||
|#

## Response {#yandex.cloud.kms.v1.asymmetricencryption.AsymmetricDecryptResponse}

**HTTP Code: 200 - OK**

```json
{
  "keyId": "string",
  "plaintext": "string"
}
```

#|
||Field | Description ||
|| keyId | **string**

ID of the asymmetric KMS key that was used for decryption. ||
|| plaintext | **string** (bytes)

Decrypted plaintext. ||
|#