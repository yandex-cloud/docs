[Документация Yandex Cloud](../../../index.md) > [Yandex Key Management Service](../../index.md) > Справочник API > [REST (англ.)](../index.md) > [SymmetricCrypto](index.md) > GenerateDataKey

# Key Management Service API, REST: SymmetricCrypto.GenerateDataKey

Generates a new symmetric data encryption key (not a KMS key) and returns
the generated key as plaintext and as ciphertext encrypted with the specified symmetric KMS key.

## HTTP request

```
POST https://kms.yandex/kms/v1/keys/{keyId}:generateDataKey
```

## Path parameters

#|
||Field | Description ||
|| keyId | **string**

Required field. ID of the symmetric KMS key that the generated data key should be encrypted with.

The maximum string length in characters is 50. ||
|#

## Body parameters {#yandex.cloud.kms.v1.GenerateDataKeyRequest}

```json
{
  "versionId": "string",
  "aadContext": "string",
  "dataKeySpec": "string",
  "skipPlaintext": "boolean"
}
```

#|
||Field | Description ||
|| versionId | **string**

ID of the key version to encrypt the generated data key with.
Defaults to the primary version if not specified.

The maximum string length in characters is 50. ||
|| aadContext | **string** (bytes)

Additional authenticated data (AAD context), optional.
If specified, this data will be required for decryption with the [SymmetricDecryptRequest](decrypt.md#yandex.cloud.kms.v1.SymmetricDecryptRequest).
Should be encoded with base64.

The maximum string length in characters is 8192. ||
|| dataKeySpec | **enum** (SymmetricAlgorithm)

Encryption algorithm and key length for the generated data key.

- `AES_128`: AES algorithm with 128-bit keys.
- `AES_192`: AES algorithm with 192-bit keys.
- `AES_256`: AES algorithm with 256-bit keys.
- `AES_256_HSM`: AES algorithm with 256-bit keys hosted by HSM
- `GOST_R_3412_2015_K`: GOST R 34.12-2015 Kuznyechik algorithm ||
|| skipPlaintext | **boolean**

If `true`, the method won't return the data key as plaintext.
Default value is `false`. ||
|#

## Response {#yandex.cloud.kms.v1.GenerateDataKeyResponse}

**HTTP Code: 200 - OK**

```json
{
  "keyId": "string",
  "versionId": "string",
  "dataKeyPlaintext": "string",
  "dataKeyCiphertext": "string"
}
```

#|
||Field | Description ||
|| keyId | **string**

ID of the symmetric KMS key that was used to encrypt the generated data key. ||
|| versionId | **string**

ID of the key version that was used for encryption. ||
|| dataKeyPlaintext | **string** (bytes)

Generated data key as plaintext.
The field is empty, if the [GenerateDataKeyRequest.skipPlaintext](#yandex.cloud.kms.v1.GenerateDataKeyRequest) parameter
was set to `true`. ||
|| dataKeyCiphertext | **string** (bytes)

The encrypted data key. ||
|#