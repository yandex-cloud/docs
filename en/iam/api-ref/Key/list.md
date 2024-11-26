---
editable: false
sourcePath: en/_api-ref/iam/v1/api-ref/Key/list.md
---

# Identity and Access Management API, REST: Key.List

Retrieves the list of Key resources for the specified service account.

## HTTP request

```
GET https://iam.{{ api-host }}/iam/v1/keys
```

## Query parameters {#yandex.cloud.iam.v1.ListKeysRequest}

#|
||Field | Description ||
|| format | **enum** (KeyFormat)

Output format of the key.

- `PEM_FILE`: Privacy-Enhanced Mail (PEM) format. Default value. ||
|| serviceAccountId | **string**

ID of the service account to list key pairs for.
To get the service account ID, use a [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/api-ref/ServiceAccount/list#List) request.
If not specified, it defaults to the subject that made the request. ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`,
the service returns a [ListKeysResponse.nextPageToken](#yandex.cloud.iam.v1.ListKeysResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100. ||
|| pageToken | **string**

Page token. To get the next page of results, set `pageToken` to the
[ListKeysResponse.nextPageToken](#yandex.cloud.iam.v1.ListKeysResponse) returned by a previous list request. ||
|#

## Response {#yandex.cloud.iam.v1.ListKeysResponse}

**HTTP Code: 200 - OK**

```json
{
  "keys": [
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
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| keys[] | **[Key](#yandex.cloud.iam.v1.Key)**

List of Key resources. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListKeysRequest.pageSize](#yandex.cloud.iam.v1.ListKeysRequest), use
the `nextPageToken` as the value
for the [ListKeysRequest.pageToken](#yandex.cloud.iam.v1.ListKeysRequest) query parameter
in the next list request. Each subsequent list request will have its own
`nextPageToken` to continue paging through the results. ||
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