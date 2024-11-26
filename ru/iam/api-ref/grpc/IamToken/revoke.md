---
editable: false
sourcePath: en/_api-ref-grpc/iam/v1/api-ref/grpc/IamToken/revoke.md
---

# Identity and Access Management API, gRPC: IamTokenService.Revoke

Revoke the IAM token.

## gRPC request

**rpc Revoke ([RevokeIamTokenRequest](#yandex.cloud.iam.v1.RevokeIamTokenRequest)) returns ([RevokeIamTokenResponse](#yandex.cloud.iam.v1.RevokeIamTokenResponse))**

## RevokeIamTokenRequest {#yandex.cloud.iam.v1.RevokeIamTokenRequest}

```json
{
  "iam_token": "string"
}
```

#|
||Field | Description ||
|| iam_token | **string**

Required field.  ||
|#

## RevokeIamTokenResponse {#yandex.cloud.iam.v1.RevokeIamTokenResponse}

```json
{
  "subject_id": "string"
}
```

#|
||Field | Description ||
|| subject_id | **string** ||
|#