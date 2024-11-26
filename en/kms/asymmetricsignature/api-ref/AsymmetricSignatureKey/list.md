---
editable: false
sourcePath: en/_api-ref/kms/v1/asymmetricsignature/api-ref/AsymmetricSignatureKey/list.md
---

# Key Management Service API, REST: AsymmetricSignatureKey.List

Returns the list of asymmetric KMS keys in the specified folder.

## HTTP request

```
GET https://{{ api-host-kms }}/kms/v1/asymmetricSignatureKeys
```

## Query parameters {#yandex.cloud.kms.v1.asymmetricsignature.ListAsymmetricSignatureKeysRequest}

#|
||Field | Description ||
|| folderId | **string**

Required field. ID of the folder to list asymmetric KMS keys in. ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`, the service returns a [ListAsymmetricSignatureKeysResponse.nextPageToken](#yandex.cloud.kms.v1.asymmetricsignature.ListAsymmetricSignatureKeysResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100. ||
|| pageToken | **string**

Page token. To get the next page of results, set `pageToken` to the
[ListAsymmetricSignatureKeysResponse.nextPageToken](#yandex.cloud.kms.v1.asymmetricsignature.ListAsymmetricSignatureKeysResponse) returned by a previous list request. ||
|#

## Response {#yandex.cloud.kms.v1.asymmetricsignature.ListAsymmetricSignatureKeysResponse}

**HTTP Code: 200 - OK**

```json
{
  "keys": [
    {
      "id": "string",
      "folderId": "string",
      "createdAt": "string",
      "name": "string",
      "description": "string",
      "labels": "string",
      "status": "string",
      "signatureAlgorithm": "string",
      "deletionProtection": "boolean"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| keys[] | **[AsymmetricSignatureKey](#yandex.cloud.kms.v1.asymmetricsignature.AsymmetricSignatureKey)**

List of asymmetric KMS keys in the specified folder. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests. If the number
of results is greater than the specified [ListAsymmetricSignatureKeysRequest.pageSize](#yandex.cloud.kms.v1.asymmetricsignature.ListAsymmetricSignatureKeysRequest), use
the `nextPageToken` as the value for the [ListAsymmetricSignatureKeysRequest.pageToken](#yandex.cloud.kms.v1.asymmetricsignature.ListAsymmetricSignatureKeysRequest) query parameter
in the next list request. Each subsequent list request will have its own
`nextPageToken` to continue paging through the results. ||
|#

## AsymmetricSignatureKey {#yandex.cloud.kms.v1.asymmetricsignature.AsymmetricSignatureKey}

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
|| labels | **string**

Custom labels for the key as `key:value` pairs. Maximum 64 per key. ||
|| status | **enum** (Status)

Current status of the key.

- `STATUS_UNSPECIFIED`
- `CREATING`: The key is being created.
- `ACTIVE`: The key is active and can be used for encryption and decryption or signature and verification.
Can be set to INACTIVE using the [AsymmetricKeyService.Update] method.
- `INACTIVE`: The key is inactive and unusable.
Can be set to ACTIVE using the [AsymmetricKeyService.Update] method. ||
|| signatureAlgorithm | **enum** (AsymmetricSignatureAlgorithm)

Signature Algorithm ID.

- `ASYMMETRIC_SIGNATURE_ALGORITHM_UNSPECIFIED`
- `RSA_2048_SIGN_PSS_SHA_256`: RSA-2048 signature with PSS padding and SHA-256
- `RSA_2048_SIGN_PSS_SHA_384`: RSA-2048 signature with PSS padding and SHA-384
- `RSA_2048_SIGN_PSS_SHA_512`: RSA-2048 signature with PSS padding and SHA-512
- `RSA_3072_SIGN_PSS_SHA_256`: RSA-3072 signature with PSS padding and SHA-256
- `RSA_3072_SIGN_PSS_SHA_384`: RSA-3072 signature with PSS padding and SHA-384
- `RSA_3072_SIGN_PSS_SHA_512`: RSA-3072 signature with PSS padding and SHA-512
- `RSA_4096_SIGN_PSS_SHA_256`: RSA-4096 signature with PSS padding and SHA-256
- `RSA_4096_SIGN_PSS_SHA_384`: RSA-4096 signature with PSS padding and SHA-384
- `RSA_4096_SIGN_PSS_SHA_512`: RSA-4096 signature with PSS padding and SHA-512
- `ECDSA_NIST_P256_SHA_256`: ECDSA signature with NIST P-256 curve and SHA-256
- `ECDSA_NIST_P384_SHA_384`: ECDSA signature with NIST P-384 curve and SHA-384
- `ECDSA_NIST_P521_SHA_512`: ECDSA signature with NIST P-521 curve and SHA-512
- `ECDSA_SECP256_K1_SHA_256`: ECDSA signature with SECP256_K1 curve and SHA-256 ||
|| deletionProtection | **boolean**

Flag that inhibits deletion of the key ||
|#