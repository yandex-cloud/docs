---
editable: false
sourcePath: en/_api-ref-grpc/iam/v1/api-ref/grpc/IamToken/create.md
---

# Identity and Access Management API, gRPC: IamTokenService.Create

Create an IAM token for the specified identity.

## gRPC request

**rpc Create ([CreateIamTokenRequest](#yandex.cloud.iam.v1.CreateIamTokenRequest)) returns ([CreateIamTokenResponse](#yandex.cloud.iam.v1.CreateIamTokenResponse))**

## CreateIamTokenRequest {#yandex.cloud.iam.v1.CreateIamTokenRequest}

```json
{
  // Includes only one of the fields `yandex_passport_oauth_token`, `jwt`
  "yandex_passport_oauth_token": "string",
  "jwt": "string"
  // end of the list of possible fields
}
```

#|
||Field | Description ||
|| yandex_passport_oauth_token | **string**

OAuth token for a Yandex account.
For more information, see [OAuth token](/docs/iam/concepts/authorization/oauth-token).

Includes only one of the fields `yandex_passport_oauth_token`, `jwt`. ||
|| jwt | **string**

JSON Web Token (JWT) for a service account.
For more information, see [Get IAM token for a service account](/docs/iam/operations/iam-token/create-for-sa).

Includes only one of the fields `yandex_passport_oauth_token`, `jwt`. ||
|#

## CreateIamTokenResponse {#yandex.cloud.iam.v1.CreateIamTokenResponse}

```json
{
  "iam_token": "string",
  "expires_at": "google.protobuf.Timestamp"
}
```

#|
||Field | Description ||
|| iam_token | **string**

IAM token for the specified identity.

You should pass the token in the `Authorization` header for any further API requests.
For example, `Authorization: Bearer `iam_token``. ||
|| expires_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

IAM token expiration time. ||
|#