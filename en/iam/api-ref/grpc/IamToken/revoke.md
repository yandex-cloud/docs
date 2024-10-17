---
editable: false
sourcePath: en/_api-ref-grpc/iam/v1/api-ref/grpc/IamToken/revoke.md
---

# Identity and Access Management API, gRPC: IamTokenService.Revoke {#Revoke}

Revoke the IAM token.

## gRPC request

**rpc Revoke ([RevokeIamTokenRequest](#yandex.cloud.iam.v1.RevokeIamTokenRequest)) returns ([RevokeIamTokenResponse](#yandex.cloud.iam.v1.RevokeIamTokenResponse))**

## RevokeIamTokenRequest {#yandex.cloud.iam.v1.RevokeIamTokenRequest}

```json
{
  "iamToken": "string"
}
```

#|
||Field | Description ||
|| iamToken | **string**

Required field.  ||
|#

## RevokeIamTokenResponse {#yandex.cloud.iam.v1.RevokeIamTokenResponse}

```json
{
  "subjectId": "string"
}
```

#|
||Field | Description ||
|| subjectId | **string** ||
|#