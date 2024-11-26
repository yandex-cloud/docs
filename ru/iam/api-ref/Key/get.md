---
editable: false
sourcePath: en/_api-ref/iam/v1/api-ref/Key/get.md
---

# Identity and Access Management API, REST: Key.Get

Returns the specified Key resource.

To get the list of available Key resources, make a [List](/docs/iam/api-ref/Key/list#List) request.

## HTTP request

```
GET https://iam.{{ api-host }}/iam/v1/keys/{keyId}
```

## Path parameters

#|
||Field | Description ||
|| keyId | **string**

Required field. ID of the Key resource to return.
To get the ID use a [KeyService.List](/docs/iam/api-ref/Key/list#List) request. ||
|#

## Query parameters {#yandex.cloud.iam.v1.GetKeyRequest}

#|
||Field | Description ||
|| format | **enum** (KeyFormat)

Output format of the key.

- `PEM_FILE`: Privacy-Enhanced Mail (PEM) format. Default value. ||
|#

## Response {#yandex.cloud.iam.v1.Key}

**HTTP Code: 200 - OK**

```json
{
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
}
```

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