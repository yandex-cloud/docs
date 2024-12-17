---
editable: false
sourcePath: en/_api-ref-grpc/iam/v1/api-ref/grpc/ApiKey/update.md
---

# Identity and Access Management API, gRPC: ApiKeyService.Update

Updates the specified API key.

## gRPC request

**rpc Update ([UpdateApiKeyRequest](#yandex.cloud.iam.v1.UpdateApiKeyRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## UpdateApiKeyRequest {#yandex.cloud.iam.v1.UpdateApiKeyRequest}

```json
{
  "api_key_id": "string",
  "update_mask": "google.protobuf.FieldMask",
  "description": "string",
  "scopes": [
    "string"
  ],
  "expires_at": "google.protobuf.Timestamp"
}
```

#|
||Field | Description ||
|| api_key_id | **string**

Required field. ID of the ApiKey resource to update.
To get the API key ID, use a [ApiKeyService.List](/docs/iam/api-ref/grpc/ApiKey/list#List) request. ||
|| update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**

Field mask that specifies which fields of the ApiKey resource are going to be updated. ||
|| description | **string**

Description of the API key. ||
|| scopes[] | **string**

Scopes of the API key. ||
|| expires_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

API key expiration timestamp, if not specified, then the API key doesn't expire ||
|#

## operation.Operation {#yandex.cloud.operation.Operation}

```json
{
  "id": "string",
  "description": "string",
  "created_at": "google.protobuf.Timestamp",
  "created_by": "string",
  "modified_at": "google.protobuf.Timestamp",
  "done": "bool",
  "metadata": {
    "api_key_id": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
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
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| created_by | **string**

ID of the user or service account who initiated the operation. ||
|| modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[UpdateApiKeyMetadata](#yandex.cloud.iam.v1.UpdateApiKeyMetadata)**

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
|| response | **[ApiKey](#yandex.cloud.iam.v1.ApiKey)**

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

## UpdateApiKeyMetadata {#yandex.cloud.iam.v1.UpdateApiKeyMetadata}

#|
||Field | Description ||
|| api_key_id | **string**

ID of the ApiKey resource that is being updated. ||
|#

## ApiKey {#yandex.cloud.iam.v1.ApiKey}

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