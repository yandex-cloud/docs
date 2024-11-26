---
editable: false
sourcePath: en/_api-ref-grpc/iam/v1/api-ref/grpc/IamToken/createForServiceAccount.md
---

# Identity and Access Management API, gRPC: IamTokenService.CreateForServiceAccount

Create an IAM token for service account.

## gRPC request

**rpc CreateForServiceAccount ([CreateIamTokenForServiceAccountRequest](#yandex.cloud.iam.v1.CreateIamTokenForServiceAccountRequest)) returns ([CreateIamTokenResponse](#yandex.cloud.iam.v1.CreateIamTokenResponse))**

## CreateIamTokenForServiceAccountRequest {#yandex.cloud.iam.v1.CreateIamTokenForServiceAccountRequest}

```json
{
  "service_account_id": "string"
}
```

#|
||Field | Description ||
|| service_account_id | **string**

Required field.  ||
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