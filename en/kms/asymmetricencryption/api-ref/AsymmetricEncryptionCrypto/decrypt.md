---
editable: false
apiPlayground:
  - url: https://{{ api-host-kms }}/kms/v1/asymmetricEncryptionKeys/{keyId}:decrypt
    method: post
    path:
      type: object
      properties:
        keyId:
          description: |-
            **string**
            Required field. ID of the asymmetric KMS key to use for decryption.
            The maximum string length in characters is 50.
          type: string
      required:
        - keyId
      additionalProperties: false
    query: null
    body:
      type: object
      properties:
        ciphertext:
          description: |-
            **string** (bytes)
            Required field. Ciphertext to be decrypted.
            Should be encoded with base64.
            The maximum string length in characters is 32768.
          type: string
          format: bytes
      required:
        - ciphertext
      additionalProperties: false
    definitions: null
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

Required field. ID of the asymmetric KMS key to use for decryption.

The maximum string length in characters is 50. ||
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
Should be encoded with base64.

The maximum string length in characters is 32768. ||
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