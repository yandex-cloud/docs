---
editable: false
sourcePath: en/_api-ref-grpc/iam/v1/api-ref/grpc/OAuthClientSecret/get.md
---

# Identity and Access Management API, gRPC: OAuthClientSecretService.Get

Returns the sepcified OAuthClientSecret resource.

To get the list of available OAuthClientSecret resources, make a [List](/docs/iam/api-ref/grpc/OAuthClientSecret/list#List) request.

## gRPC request

**rpc Get ([GetOAuthClientSecretRequest](#yandex.cloud.iam.v1.GetOAuthClientSecretRequest)) returns ([OAuthClientSecret](#yandex.cloud.iam.v1.OAuthClientSecret))**

## GetOAuthClientSecretRequest {#yandex.cloud.iam.v1.GetOAuthClientSecretRequest}

```json
{
  "oauth_client_secret_id": "string"
}
```

#|
||Field | Description ||
|| oauth_client_secret_id | **string**

Required field. ID of the OAuthClientSecret resource to return.
To get the OAuthClientSecret ID, use a [OAuthClientSecretService.List](/docs/iam/api-ref/grpc/OAuthClientSecret/list#List) request. ||
|#

## OAuthClientSecret {#yandex.cloud.iam.v1.OAuthClientSecret}

```json
{
  "id": "string",
  "oauth_client_id": "string",
  "description": "string",
  "masked_secret": "string",
  "created_at": "google.protobuf.Timestamp"
}
```

An OauthClientSecretResource

#|
||Field | Description ||
|| id | **string**

ID of the oauth client secret. ||
|| oauth_client_id | **string**

ID of the oauth client that the secret belongs to. ||
|| description | **string**

Description of the oauth client secret. ||
|| masked_secret | **string**

Masked value of the oauth client secret: `yccs__[a-f0-9]{10}\*{4}` ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|#