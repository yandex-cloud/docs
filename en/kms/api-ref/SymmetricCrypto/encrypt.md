---
editable: false
apiPlayground:
  - url: https://{{ api-host-kms-symcrypto }}/kms/v1/keys/{keyId}:encrypt
    method: post
    path:
      type: object
      properties:
        keyId:
          description: |-
            **string**
            Required field. ID of the symmetric KMS key to use for encryption.
            The maximum string length in characters is 50.
          type: string
      required:
        - keyId
      additionalProperties: false
    query: null
    body:
      type: object
      properties:
        versionId:
          description: |-
            **string**
            ID of the key version to encrypt plaintext with.
            Defaults to the primary version if not specified.
            The maximum string length in characters is 50.
          type: string
        aadContext:
          description: |-
            **string** (bytes)
            Additional authenticated data (AAD context), optional.
            If specified, this data will be required for decryption with the [SymmetricDecryptRequest](/docs/kms/api-ref/SymmetricCrypto/decrypt#yandex.cloud.kms.v1.SymmetricDecryptRequest).
            Should be encoded with base64.
            The maximum string length in characters is 8192.
          type: string
          format: bytes
        plaintext:
          description: |-
            **string** (bytes)
            Required field. Plaintext to be encrypted.
            Should be encoded with base64.
            The maximum string length in characters is 32768.
          type: string
          format: bytes
      required:
        - plaintext
      additionalProperties: false
    definitions: null
sourcePath: en/_api-ref/kms/v1/api-ref/SymmetricCrypto/encrypt.md
---

# Key Management Service API, REST: SymmetricCrypto.Encrypt

Encrypts given plaintext with the specified key.

## HTTP request

```
POST https://{{ api-host-kms-symcrypto }}/kms/v1/keys/{keyId}:encrypt
```

## Path parameters

#|
||Field | Description ||
|| keyId | **string**

Required field. ID of the symmetric KMS key to use for encryption.

The maximum string length in characters is 50. ||
|#

## Body parameters {#yandex.cloud.kms.v1.SymmetricEncryptRequest}

```json
{
  "versionId": "string",
  "aadContext": "string",
  "plaintext": "string"
}
```

#|
||Field | Description ||
|| versionId | **string**

ID of the key version to encrypt plaintext with.
Defaults to the primary version if not specified.

The maximum string length in characters is 50. ||
|| aadContext | **string** (bytes)

Additional authenticated data (AAD context), optional.
If specified, this data will be required for decryption with the [SymmetricDecryptRequest](/docs/kms/api-ref/SymmetricCrypto/decrypt#yandex.cloud.kms.v1.SymmetricDecryptRequest).
Should be encoded with base64.

The maximum string length in characters is 8192. ||
|| plaintext | **string** (bytes)

Required field. Plaintext to be encrypted.
Should be encoded with base64.

The maximum string length in characters is 32768. ||
|#

## Response {#yandex.cloud.kms.v1.SymmetricEncryptResponse}

**HTTP Code: 200 - OK**

```json
{
  "keyId": "string",
  "versionId": "string",
  "ciphertext": "string"
}
```

#|
||Field | Description ||
|| keyId | **string**

Required field. ID of the symmetric KMS key that was used for encryption.

The maximum string length in characters is 50. ||
|| versionId | **string**

ID of the key version that was used for encryption.

The maximum string length in characters is 50. ||
|| ciphertext | **string** (bytes)

Resulting ciphertext. ||
|#