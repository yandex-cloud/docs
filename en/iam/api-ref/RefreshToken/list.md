---
editable: false
sourcePath: en/_api-ref/iam/v1/api-ref/RefreshToken/list.md
---

# Identity and Access Management API, REST: RefreshToken.List

List subjects Refresh Tokens.

## HTTP request

```
GET https://iam.{{ api-host }}/iam/v1/refreshTokens
```

## Query parameters {#yandex.cloud.iam.v1.ListRefreshTokensRequest}

#|
||Field | Description ||
|| subjectId | **string** ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`,
the service returns a [ListRefreshTokensResponse.nextPageToken](#yandex.cloud.iam.v1.ListRefreshTokensResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100. ||
|| pageToken | **string**

Page token. To get the next page of results, set `pageToken`
to the [ListRefreshTokensResponse.nextPageToken](#yandex.cloud.iam.v1.ListRefreshTokensResponse)
returned by a previous list request. ||
|| filter | **string**

A filter expression that filters refresh tokens listed in the response.

The expression must specify:
1. The field name. Currently you can use filtering only on [RefreshToken.clientInstanceInfo](#yandex.cloud.iam.v1.RefreshToken), [RefreshToken.clientId](#yandex.cloud.iam.v1.RefreshToken) or [RefreshToken.protectionLevel](#yandex.cloud.iam.v1.RefreshToken) fields.
2. The operator. An `=` operator can be used for all fields. An 'IN' operator can be used for [RefreshToken.protectionLevel](#yandex.cloud.iam.v1.RefreshToken).
3. The value. The value must be in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-zA-Z][_-a-zA-Z0-9]{1,61}[a-z0-9]`.
Example of a filter: `client_instance_info="clientInstanceInfo" AND protection_level IN ("INSECURE_KEY_DPOP", "SECURE_KEY_DPOP")`. ||
|#

## Response {#yandex.cloud.iam.v1.ListRefreshTokensResponse}

**HTTP Code: 200 - OK**

```json
{
  "refreshTokens": [
    {
      "id": "string",
      "clientInstanceInfo": "string",
      "clientId": "string",
      "subjectId": "string",
      "createdAt": "string",
      "expiresAt": "string",
      "lastUsedAt": "string",
      "protectionLevel": "string"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| refreshTokens[] | **[RefreshToken](#yandex.cloud.iam.v1.RefreshToken)**

List of Refresh Tokens ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListRefreshTokensForSubjectRequest.page_size], use
the `nextPageToken` as the value
for the [ListRefreshTokensForSubjectRequest.page_token] query parameter
in the next list request. Each subsequent list request will have its own
`nextPageToken` to continue paging through the results. ||
|#

## RefreshToken {#yandex.cloud.iam.v1.RefreshToken}

#|
||Field | Description ||
|| id | **string**

Refresh Token id. ||
|| clientInstanceInfo | **string**

Information about the app for which the Refresh Token was issued. ||
|| clientId | **string**

The OAuth client identifier for which the Refresh Token was issued. ||
|| subjectId | **string**

The subject identifier for whom the Refresh Token was issued. ||
|| createdAt | **string** (date-time)

Refresh token creation time.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| expiresAt | **string** (date-time)

Refresh token expiration time.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| lastUsedAt | **string** (date-time)

Timestamp for the last authentication using this Refresh Token.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| protectionLevel | **enum** (ProtectionLevel)

Protection level of the refresh token.

It shows whether DPOP was used to protect the Refresh Token and and the level of security of the storage used for the DPOP key.

- `PROTECTION_LEVEL_UNSPECIFIED`
- `NO_PROTECTION`: Refresh token without DPOP
- `INSECURE_KEY_DPOP`: Refresh token with dpop. The dpop key is not a YubiKey PIV key with required pin/touch policy and attestation.
- `SECURE_KEY_DPOP`: Refresh token with dpop. The dpop key is a YubiKey PIV key with required pin/touch policy and attestation. ||
|#