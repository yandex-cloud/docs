---
editable: false
sourcePath: en/_api-ref-grpc/iam/v1/api-ref/grpc/ApiKey/get.md
---

# Identity and Access Management API, gRPC: ApiKeyService.Get

Returns the specified API key.

To get the list of available API keys, make a [List](/docs/iam/api-ref/grpc/ApiKey/list#List) request.

## gRPC request

**rpc Get ([GetApiKeyRequest](#yandex.cloud.iam.v1.GetApiKeyRequest)) returns ([ApiKey](#yandex.cloud.iam.v1.ApiKey))**

## GetApiKeyRequest {#yandex.cloud.iam.v1.GetApiKeyRequest}

```json
{
  "api_key_id": "string"
}
```

#|
||Field | Description ||
|| api_key_id | **string**

Required field. ID of the API key to return.
To get the API key ID, use a [ApiKeyService.List](/docs/iam/api-ref/grpc/ApiKey/list#List) request. ||
|#

## ApiKey {#yandex.cloud.iam.v1.ApiKey}

```json
{
  "id": "string",
  "service_account_id": "string",
  "created_at": "google.protobuf.Timestamp",
  "description": "string",
  "last_used_at": "google.protobuf.Timestamp",
  "scope": "string",
  "scopes": [
    "string"
  ],
  "expires_at": "google.protobuf.Timestamp"
}
```

An ApiKey resource. For more information, see [Api-Key](/docs/iam/concepts/authorization/api-key).

#|
||Field | Description ||
|| id | **string**

ID of the API Key. ||
|| service_account_id | **string**

ID of the service account that the API key belongs to. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| description | **string**

Description of the API key. 0-256 characters long. ||
|| last_used_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp for the last authentication using this API key. ||
|| scope | **string**

Scope of the API key. 0-256 characters long. ||
|| scopes[] | **string**

Scopes of the API key. 0-256 characters long. ||
|| expires_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

API key expiration timestamp. ||
|#