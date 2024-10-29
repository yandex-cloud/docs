---
editable: false
sourcePath: en/_api-ref-grpc/iam/v1/api-ref/grpc/ApiKey/create.md
---

# Identity and Access Management API, gRPC: ApiKeyService.Create {#Create}

Creates an API key for the specified service account.

## gRPC request

**rpc Create ([CreateApiKeyRequest](#yandex.cloud.iam.v1.CreateApiKeyRequest)) returns ([CreateApiKeyResponse](#yandex.cloud.iam.v1.CreateApiKeyResponse))**

## CreateApiKeyRequest {#yandex.cloud.iam.v1.CreateApiKeyRequest}

```json
{
  "serviceAccountId": "string",
  "description": "string",
  "scope": "string",
  "expiresAt": "google.protobuf.Timestamp"
}
```

#|
||Field | Description ||
|| serviceAccountId | **string**

ID of the service account to create an API key for.
To get the service account ID, use a [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/api-ref/grpc/ServiceAccount/list#List) request.
If not specified, it defaults to the subject that made the request. ||
|| description | **string**

Description of the API key. ||
|| scope | **string**

Scope of the API key. ||
|| expiresAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

API key expiration timestamp, if not specified, then the API key doesn't expire ||
|#

## CreateApiKeyResponse {#yandex.cloud.iam.v1.CreateApiKeyResponse}

```json
{
  "apiKey": {
    "id": "string",
    "serviceAccountId": "string",
    "createdAt": "google.protobuf.Timestamp",
    "description": "string",
    "lastUsedAt": "google.protobuf.Timestamp",
    "scope": "string",
    "expiresAt": "google.protobuf.Timestamp"
  },
  "secret": "string"
}
```

#|
||Field | Description ||
|| apiKey | **[ApiKey](#yandex.cloud.iam.v1.ApiKey)**

ApiKey resource. ||
|| secret | **string**

Secret part of the API key. This secret key you may use in the requests for authentication. ||
|#

## ApiKey {#yandex.cloud.iam.v1.ApiKey}

An ApiKey resource. For more information, see [Api-Key](/docs/iam/concepts/authorization/api-key).

#|
||Field | Description ||
|| id | **string**

ID of the API Key. ||
|| serviceAccountId | **string**

ID of the service account that the API key belongs to. ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| description | **string**

Description of the API key. 0-256 characters long. ||
|| lastUsedAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp for the last authentication using this API key. ||
|| scope | **string**

Scope of the API key. 0-256 characters long. ||
|| expiresAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

API key expiration timestamp. ||
|#