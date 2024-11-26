---
editable: false
sourcePath: en/_api-ref-grpc/iam/v1/api-ref/grpc/RefreshToken/list.md
---

# Identity and Access Management API, gRPC: RefreshTokenService.List

List subjects Refresh Tokens.

## gRPC request

**rpc List ([ListRefreshTokensRequest](#yandex.cloud.iam.v1.ListRefreshTokensRequest)) returns ([ListRefreshTokensResponse](#yandex.cloud.iam.v1.ListRefreshTokensResponse))**

## ListRefreshTokensRequest {#yandex.cloud.iam.v1.ListRefreshTokensRequest}

```json
{
  "subject_id": "string",
  "page_size": "int64",
  "page_token": "string",
  "filter": "string"
}
```

#|
||Field | Description ||
|| subject_id | **string** ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `page_size`,
the service returns a [ListRefreshTokensResponse.next_page_token](#yandex.cloud.iam.v1.ListRefreshTokensResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100. ||
|| page_token | **string**

Page token. To get the next page of results, set `page_token`
to the [ListRefreshTokensResponse.next_page_token](#yandex.cloud.iam.v1.ListRefreshTokensResponse)
returned by a previous list request. ||
|| filter | **string**

A filter expression that filters refresh tokens listed in the response.

The expression must specify:
1. The field name. Currently you can use filtering only on [RefreshToken.client_instance_info](#yandex.cloud.iam.v1.RefreshToken), [RefreshToken.client_id](#yandex.cloud.iam.v1.RefreshToken) or [RefreshToken.protection_level](#yandex.cloud.iam.v1.RefreshToken) fields.
2. The operator. An `=` operator can be used for all fields. An 'IN' operator can be used for [RefreshToken.protection_level](#yandex.cloud.iam.v1.RefreshToken).
3. The value. The value must be in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-zA-Z][_-a-zA-Z0-9]{1,61}[a-z0-9]`.
Example of a filter: `client_instance_info="clientInstanceInfo" AND protection_level IN ("INSECURE_KEY_DPOP", "SECURE_KEY_DPOP")`. ||
|#

## ListRefreshTokensResponse {#yandex.cloud.iam.v1.ListRefreshTokensResponse}

```json
{
  "refresh_tokens": [
    {
      "id": "string",
      "client_instance_info": "string",
      "client_id": "string",
      "subject_id": "string",
      "created_at": "google.protobuf.Timestamp",
      "expires_at": "google.protobuf.Timestamp",
      "last_used_at": "google.protobuf.Timestamp",
      "protection_level": "ProtectionLevel"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| refresh_tokens[] | **[RefreshToken](#yandex.cloud.iam.v1.RefreshToken)**

List of Refresh Tokens ||
|| next_page_token | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListRefreshTokensForSubjectRequest.page_size], use
the `next_page_token` as the value
for the [ListRefreshTokensForSubjectRequest.page_token] query parameter
in the next list request. Each subsequent list request will have its own
`next_page_token` to continue paging through the results. ||
|#

## RefreshToken {#yandex.cloud.iam.v1.RefreshToken}

#|
||Field | Description ||
|| id | **string**

Refresh Token id. ||
|| client_instance_info | **string**

Information about the app for which the Refresh Token was issued. ||
|| client_id | **string**

The OAuth client identifier for which the Refresh Token was issued. ||
|| subject_id | **string**

The subject identifier for whom the Refresh Token was issued. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Refresh token creation time. ||
|| expires_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Refresh token expiration time. ||
|| last_used_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp for the last authentication using this Refresh Token. ||
|| protection_level | enum **ProtectionLevel**

Protection level of the refresh token.

It shows whether DPOP was used to protect the Refresh Token and and the level of security of the storage used for the DPOP key.

- `PROTECTION_LEVEL_UNSPECIFIED`
- `NO_PROTECTION`: Refresh token without DPOP
- `INSECURE_KEY_DPOP`: Refresh token with dpop. The dpop key is not a YubiKey PIV key with required pin/touch policy and attestation.
- `SECURE_KEY_DPOP`: Refresh token with dpop. The dpop key is a YubiKey PIV key with required pin/touch policy and attestation. ||
|#