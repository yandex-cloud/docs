---
editable: false
sourcePath: en/_api-ref/kms/v1/asymmetricencryption/api-ref/AsymmetricEncryptionKey/get.md
---

# Key Management Service API, REST: AsymmetricEncryptionKey.Get

Returns the specified asymmetric KMS key.

To get the list of available asymmetric KMS keys, make a [SymmetricKeyService.List] request.

## HTTP request

```
GET https://{{ api-host-kms }}/kms/v1/asymmetricEncryptionKeys/{keyId}
```

## Path parameters

#|
||Field | Description ||
|| keyId | **string**

Required field. ID of the asymmetric KMS key to return.
To get the ID of an asymmetric KMS key use a [AsymmetricEncryptionKeyService.List](/docs/kms/api-ref/AsymmetricEncryptionKey/list#List) request. ||
|#

## Response {#yandex.cloud.kms.v1.asymmetricencryption.AsymmetricEncryptionKey}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "folderId": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "status": "string",
  "encryptionAlgorithm": "string",
  "deletionProtection": "boolean"
}
```

An asymmetric KMS key that may contain several versions of the cryptographic material.

#|
||Field | Description ||
|| id | **string**

ID of the key. ||
|| folderId | **string**

ID of the folder that the key belongs to. ||
|| createdAt | **string** (date-time)

Time when the key was created.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| name | **string**

Name of the key. ||
|| description | **string**

Description of the key. ||
|| labels | **object** (map<**string**, **string**>)

Custom labels for the key as `key:value` pairs. Maximum 64 per key. ||
|| status | **enum** (Status)

Current status of the key.

- `STATUS_UNSPECIFIED`
- `CREATING`: The key is being created.
- `ACTIVE`: The key is active and can be used for encryption and decryption or signature and verification.
Can be set to INACTIVE using the [AsymmetricKeyService.Update] method.
- `INACTIVE`: The key is inactive and unusable.
Can be set to ACTIVE using the [AsymmetricKeyService.Update] method. ||
|| encryptionAlgorithm | **enum** (AsymmetricEncryptionAlgorithm)

Asymmetric Encryption Algorithm ID.

- `ASYMMETRIC_ENCRYPTION_ALGORITHM_UNSPECIFIED`
- `RSA_2048_ENC_OAEP_SHA_256`: RSA-2048 encryption with OAEP padding and SHA-256
- `RSA_3072_ENC_OAEP_SHA_256`: RSA-3072 encryption with OAEP padding and SHA-256
- `RSA_4096_ENC_OAEP_SHA_256`: RSA-4096 encryption with OAEP padding and SHA-256 ||
|| deletionProtection | **boolean**

Flag that inhibits deletion of the key ||
|#