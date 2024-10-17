---
editable: false
sourcePath: en/_api-ref-grpc/iam/v1/api-ref/grpc/RefreshToken/revoke.md
---

# Identity and Access Management API, gRPC: RefreshTokenService.Revoke {#Revoke}

Revoke Refresh Tokens. Several Refresh Tokens can be revoked by one request.

## gRPC request

**rpc Revoke ([RevokeRefreshTokenRequest](#yandex.cloud.iam.v1.RevokeRefreshTokenRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## RevokeRefreshTokenRequest {#yandex.cloud.iam.v1.RevokeRefreshTokenRequest}

```json
{
  // Includes only one of the fields `refreshTokenId`, `refreshToken`, `revokeFilter`
  "refreshTokenId": "string",
  "refreshToken": "string",
  "revokeFilter": {
    "clientId": "string",
    "subjectId": "string",
    "clientInstanceInfo": "string"
  }
  // end of the list of possible fields
}
```

Revoke Refresh Token request.
If none of the parameters refresh_token_id, refresh_token, or revoke_filter are provided, all Refresh Tokens for the current subject will be revoked.

#|
||Field | Description ||
|| refreshTokenId | **string**

Identifier of the Refresh Token to be revoked.

Includes only one of the fields `refreshTokenId`, `refreshToken`, `revokeFilter`. ||
|| refreshToken | **string**

The Refresh Token to be revoked.

Includes only one of the fields `refreshTokenId`, `refreshToken`, `revokeFilter`. ||
|| revokeFilter | **[RevokeFilter](#yandex.cloud.iam.v1.RevokeFilter)**

The filter for revoking Refresh Token

Includes only one of the fields `refreshTokenId`, `refreshToken`, `revokeFilter`. ||
|#

## RevokeFilter {#yandex.cloud.iam.v1.RevokeFilter}

The Filter object allows filtering Refresh Tokens that will be revoked.
It contains three optional fields.
When multiple fields are provided, they are combined using a logical AND operation.

#|
||Field | Description ||
|| clientId | **string**

The OAuth client identifier for which the Refresh Token was issued. ||
|| subjectId | **string**

The subject identifier for whom the Refresh Token was issued.
If not specified, it defaults to the subject that made the request. ||
|| clientInstanceInfo | **string**

Information about the app for which the Refresh Token was issued. ||
|#

## operation.Operation {#yandex.cloud.operation.Operation}

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "google.protobuf.Timestamp",
  "createdBy": "string",
  "modifiedAt": "google.protobuf.Timestamp",
  "done": "bool",
  "metadata": {
    "subjectId": "string",
    "refreshTokenIds": [
      "string"
    ]
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "refreshTokenIds": [
      "string"
    ]
  }
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).

#|
||Field | Description ||
|| id | **string**

ID of the operation. ||
|| description | **string**

Description of the operation. 0-256 characters long. ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[RevokeRefreshTokenMetadata](#yandex.cloud.iam.v1.RevokeRefreshTokenMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **[RevokeRefreshTokenResponse](#yandex.cloud.iam.v1.RevokeRefreshTokenResponse)**

The normal response of the operation in case of success.
If the original method returns no data on success, such as Delete,
the response is [google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty).
If the original method is the standard Create/Update,
the response should be the target resource of the operation.
Any method that returns a long-running operation should document the response type, if any.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|#

## RevokeRefreshTokenMetadata {#yandex.cloud.iam.v1.RevokeRefreshTokenMetadata}

#|
||Field | Description ||
|| subjectId | **string** ||
|| refreshTokenIds[] | **string**

Id of revoked Refresh Tokens. ||
|#

## RevokeRefreshTokenResponse {#yandex.cloud.iam.v1.RevokeRefreshTokenResponse}

#|
||Field | Description ||
|| refreshTokenIds[] | **string**

Id of revoked Refresh Tokens. ||
|#