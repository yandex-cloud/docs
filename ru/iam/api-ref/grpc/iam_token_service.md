---
editable: false
sourcePath: en/_api-ref-grpc/iam/api-ref/grpc/iam_token_service.md
---

# Identity and Access Management API, gRPC: IamTokenService

A set of methods for managing IAM tokens.

| Call | Description |
| --- | --- |
| [Create](#Create) | Creates an IAM token for the specified identity. |
| [CreateForServiceAccount](#CreateForServiceAccount) | Create iam token for service account. |

## Calls IamTokenService {#calls}

## Create {#Create}

Creates an IAM token for the specified identity.

**rpc Create ([CreateIamTokenRequest](#CreateIamTokenRequest)) returns ([CreateIamTokenResponse](#CreateIamTokenResponse))**

### CreateIamTokenRequest {#CreateIamTokenRequest}

Field | Description
--- | ---
identity | **oneof:** `yandex_passport_oauth_token` or `jwt`<br>
&nbsp;&nbsp;yandex_passport_oauth_token | **string**<br>OAuth token for a Yandex account. For more information, see [OAuth token](/docs/iam/concepts/authorization/oauth-token). 
&nbsp;&nbsp;jwt | **string**<br>JSON Web Token (JWT) for a service account. For more information, see [Get IAM token for a service account](/docs/iam/operations/iam-token/create-for-sa). 


### CreateIamTokenResponse {#CreateIamTokenResponse}

Field | Description
--- | ---
iam_token | **string**<br>IAM token for the specified identity. <br>You should pass the token in the `Authorization` header for any further API requests. For example, `Authorization: Bearer `iam_token``. 
expires_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>IAM token expiration time. 


## CreateForServiceAccount {#CreateForServiceAccount}

Create iam token for service account.

**rpc CreateForServiceAccount ([CreateIamTokenForServiceAccountRequest](#CreateIamTokenForServiceAccountRequest)) returns ([CreateIamTokenResponse](#CreateIamTokenResponse))**

### CreateIamTokenForServiceAccountRequest {#CreateIamTokenForServiceAccountRequest}

Field | Description
--- | ---
service_account_id | **string**<br>Required.  The maximum string length in characters is 50.


### CreateIamTokenResponse {#CreateIamTokenResponse1}

Field | Description
--- | ---
iam_token | **string**<br>IAM token for the specified identity. <br>You should pass the token in the `Authorization` header for any further API requests. For example, `Authorization: Bearer `iam_token``. 
expires_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>IAM token expiration time. 


