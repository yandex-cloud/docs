---
editable: false
apiPlayground:
  - url: https://iam.{{ api-host }}/iam/v1/refreshTokens:revoke
    method: post
    path: null
    query: null
    body:
      type: object
      properties:
        refreshTokenId:
          description: |-
            **string**
            Identifier of the Refresh Token to be revoked.
            Includes only one of the fields `refreshTokenId`, `refreshToken`, `revokeFilter`.
          type: string
        refreshToken:
          description: |-
            **string**
            The Refresh Token to be revoked.
            Includes only one of the fields `refreshTokenId`, `refreshToken`, `revokeFilter`.
          type: string
        revokeFilter:
          description: |-
            **[RevokeFilter](/docs/iam/api-ref/RefreshToken/revoke#yandex.cloud.iam.v1.RevokeFilter)**
            The filter for revoking Refresh Token
            Includes only one of the fields `refreshTokenId`, `refreshToken`, `revokeFilter`.
          $ref: '#/definitions/RevokeFilter'
      additionalProperties: false
    definitions:
      RevokeFilter:
        type: object
        properties:
          clientId:
            description: |-
              **string**
              The OAuth client identifier for which the Refresh Token was issued.
            type: string
          subjectId:
            description: |-
              **string**
              The subject identifier for whom the Refresh Token was issued.
              If not specified, it defaults to the subject that made the request.
            type: string
          clientInstanceInfo:
            description: |-
              **string**
              Information about the app for which the Refresh Token was issued.
            type: string
sourcePath: en/_api-ref/iam/v1/api-ref/RefreshToken/revoke.md
---

# Identity and Access Management API, REST: RefreshToken.Revoke

Revoke Refresh Tokens. Several Refresh Tokens can be revoked by one request.

## HTTP request

```
POST https://iam.{{ api-host }}/iam/v1/refreshTokens:revoke
```

## Body parameters {#yandex.cloud.iam.v1.RevokeRefreshTokenRequest}

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

## Response {#yandex.cloud.operation.Operation}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": "boolean",
  "metadata": {
    "subjectId": "string",
    "refreshTokenIds": [
      "string"
    ]
  },
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
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
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **string** (date-time)

The time when the Operation resource was last modified.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| done | **boolean**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[RevokeRefreshTokenMetadata](#yandex.cloud.iam.v1.RevokeRefreshTokenMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[Status](#google.rpc.Status)**

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

## Status {#google.rpc.Status}

The error result of the operation in case of failure or cancellation.

#|
||Field | Description ||
|| code | **integer** (int32)

Error code. An enum value of [google.rpc.Code](https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto). ||
|| message | **string**

An error message. ||
|| details[] | **object**

A list of messages that carry the error details. ||
|#

## RevokeRefreshTokenResponse {#yandex.cloud.iam.v1.RevokeRefreshTokenResponse}

#|
||Field | Description ||
|| refreshTokenIds[] | **string**

Id of revoked Refresh Tokens. ||
|#