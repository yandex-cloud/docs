---
editable: false
sourcePath: en/_api-ref/kms/v1/asymmetricencryption/api-ref/AsymmetricEncryptionCrypto/getPublicKey.md
---

# Key Management Service API, REST: AsymmetricEncryptionCrypto.GetPublicKey {#GetPublicKey}

Gets value of public key.

## HTTP request

```
GET https://{{ api-host-kms }}/kms/v1/asymmetricEncryptionKeys/{keyId}/publicKey
```

## Path parameters

#|
||Field | Description ||
|| keyId | **string**

Required field. ID of the asymmetric KMS key to be used for public key retrieval. ||
|#

## Response {#yandex.cloud.kms.v1.asymmetricencryption.AsymmetricGetPublicKeyResponse}

**HTTP Code: 200 - OK**

```json
{
  "keyId": "string",
  "publicKey": "string"
}
```

#|
||Field | Description ||
|| keyId | **string**

ID of the asymmetric KMS key to get public key of. ||
|| publicKey | **string**

Public key value.
The value is a PEM-encoded X.509 public key, also known as SubjectPublicKeyInfo (SPKI),
as defined in RFC 5280. ||
|#