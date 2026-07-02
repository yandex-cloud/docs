[Документация Yandex Cloud](../../../index.md) > [Yandex Key Management Service](../../index.md) > Справочник API > [REST (англ.)](../index.md) > [SymmetricCrypto](index.md) > Decrypt

# Key Management Service API, REST: SymmetricCrypto.Decrypt

Decrypts the given ciphertext with the specified key.

## HTTP request

```
POST https://kms.yandex/kms/v1/keys/{keyId}:decrypt
```

## Path parameters

#|
||Field | Description ||
|| keyId | **string**

Required field. ID of the symmetric KMS key to use for decryption.

The maximum string length in characters is 50. ||
|#

## Body parameters {#yandex.cloud.kms.v1.SymmetricDecryptRequest}

```json
{
  "aadContext": "string",
  "ciphertext": "string"
}
```

#|
||Field | Description ||
|| aadContext | **string** (bytes)

Additional authenticated data, must be the same as was provided
in the corresponding [SymmetricEncryptRequest](encrypt.md#yandex.cloud.kms.v1.SymmetricEncryptRequest).
Should be encoded with base64.

The maximum string length in characters is 8192. ||
|| ciphertext | **string** (bytes)

Required field. Ciphertext to be decrypted.
Should be encoded with base64. ||
|#

## Response {#yandex.cloud.kms.v1.SymmetricDecryptResponse}

**HTTP Code: 200 - OK**

```json
{
  "keyId": "string",
  "versionId": "string",
  "plaintext": "string"
}
```

#|
||Field | Description ||
|| keyId | **string**

ID of the symmetric KMS key that was used for decryption. ||
|| versionId | **string**

ID of the key version that was used for decryption. ||
|| plaintext | **string** (bytes)

Decrypted plaintext. ||
|#