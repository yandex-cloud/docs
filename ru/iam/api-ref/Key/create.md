---
editable: false
sourcePath: en/_api-ref/iam/v1/api-ref/Key/create.md
---

# Identity and Access Management API, REST: Key.Create {#Create}

Creates a key pair for the specified service account.

## HTTP request

```
POST https://iam.{{ api-host }}/iam/v1/keys
```

## Body parameters {#yandex.cloud.iam.v1.CreateKeyRequest}

```json
{
  "serviceAccountId": "string",
  "description": "string",
  "format": "string",
  "keyAlgorithm": "string"
}
```

#|
||Field | Description ||
|| serviceAccountId | **string**

ID of the service account to create a key pair for.
To get the service account ID, use a [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/api-ref/ServiceAccount/list#List) request.
If not specified, it defaults to the subject that made the request. ||
|| description | **string**

Description of the key pair. ||
|| format | **enum** (KeyFormat)

Output format of the key.

- `PEM_FILE`: Privacy-Enhanced Mail (PEM) format. Default value. ||
|| keyAlgorithm | **enum** (Algorithm)

An algorithm used to generate a key pair of the Key resource.

- `ALGORITHM_UNSPECIFIED`
- `RSA_2048`: RSA with a 2048-bit key size. Default value.
- `RSA_4096`: RSA with a 4096-bit key size. ||
|#

## Response {#yandex.cloud.iam.v1.CreateKeyResponse}

**HTTP Code: 200 - OK**

```json
{
  "key": {
    "id": "string",
    // Includes only one of the fields `userAccountId`, `serviceAccountId`
    "userAccountId": "string",
    "serviceAccountId": "string",
    // end of the list of possible fields
    "createdAt": "string",
    "description": "string",
    "keyAlgorithm": "string",
    "publicKey": "string",
    "lastUsedAt": "string"
  },
  "privateKey": "string"
}
```

#|
||Field | Description ||
|| key | **[Key](#yandex.cloud.iam.v1.Key)**

Key resource. ||
|| privateKey | **string**

A private key of the Key resource.
This key must be stored securely. ||
|#

## Key {#yandex.cloud.iam.v1.Key}

A Key resource. For more information, see [Authorized keys](/docs/iam/concepts/authorization/key).

#|
||Field | Description ||
|| id | **string**

ID of the Key resource. ||
|| userAccountId | **string**

ID of the user account that the Key resource belongs to.

Includes only one of the fields `userAccountId`, `serviceAccountId`. ||
|| serviceAccountId | **string**

ID of the service account that the Key resource belongs to.

Includes only one of the fields `userAccountId`, `serviceAccountId`. ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| description | **string**

Description of the Key resource. 0-256 characters long. ||
|| keyAlgorithm | **enum** (Algorithm)

An algorithm used to generate a key pair of the Key resource.

- `ALGORITHM_UNSPECIFIED`
- `RSA_2048`: RSA with a 2048-bit key size. Default value.
- `RSA_4096`: RSA with a 4096-bit key size. ||
|| publicKey | **string**

A public key of the Key resource. ||
|| lastUsedAt | **string** (date-time)

Timestamp for the last use of this key.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|#