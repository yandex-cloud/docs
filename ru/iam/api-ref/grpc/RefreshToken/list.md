---
editable: false
sourcePath: en/_api-ref-grpc/iam/v1/api-ref/grpc/RefreshToken/list.md
---

# Identity and Access Management API, gRPC: RefreshTokenService.List {#List}

List subjects Refresh Tokens.

## gRPC request

**rpc List ([ListRefreshTokensRequest](#yandex.cloud.iam.v1.ListRefreshTokensRequest)) returns ([ListRefreshTokensResponse](#yandex.cloud.iam.v1.ListRefreshTokensResponse))**

## ListRefreshTokensRequest {#yandex.cloud.iam.v1.ListRefreshTokensRequest}

```json
{
  "subjectId": "string",
  "pageSize": "int64",
  "pageToken": "string",
  "filter": "string"
}
```

#|
||Field | Description ||
|| subjectId | **string** ||
|| pageSize | **int64**

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

## ListRefreshTokensResponse {#yandex.cloud.iam.v1.ListRefreshTokensResponse}

```json
{
  "refreshTokens": [
    {
      "id": "string",
      "clientInstanceInfo": "string",
      "clientId": "string",
      "subjectId": "string",
      "createdAt": "google.protobuf.Timestamp",
      "expiresAt": "google.protobuf.Timestamp",
      "lastUsedAt": "google.protobuf.Timestamp",
      "protectionLevel": "ProtectionLevel"
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
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Refresh token creation time. ||
|| expiresAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Refresh token expiration time. ||
|| lastUsedAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp for the last authentication using this Refresh Token. ||
|| protectionLevel | enum **ProtectionLevel**

Protection level of the refresh token.

It shows whether DPOP was used to protect the Refresh Token and and the level of security of the storage used for the DPOP key.

- `PROTECTION_LEVEL_UNSPECIFIED`
- `NO_PROTECTION`: Refresh token without DPOP
- `INSECURE_KEY_DPOP`: Refresh token with dpop. The dpop key is not a YubiKey PIV key with required pin/touch policy and attestation.
- `SECURE_KEY_DPOP`: Refresh token with dpop. The dpop key is a YubiKey PIV key with required pin/touch policy and attestation. ||
|#