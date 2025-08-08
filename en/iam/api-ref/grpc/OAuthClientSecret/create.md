---
editable: false
sourcePath: en/_api-ref-grpc/iam/v1/api-ref/grpc/OAuthClientSecret/create.md
---

# Identity and Access Management API, gRPC: OAuthClientSecretService.Create

Creates an OAuthClientSecret resource for the specified OAuthClient.

## gRPC request

**rpc Create ([CreateOAuthClientSecretRequest](#yandex.cloud.iam.v1.CreateOAuthClientSecretRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## CreateOAuthClientSecretRequest {#yandex.cloud.iam.v1.CreateOAuthClientSecretRequest}

```json
{
  "oauth_client_id": "string",
  "description": "string"
}
```

#|
||Field | Description ||
|| oauth_client_id | **string**

Required field. ID of the OAuthClient resource to create OAuthClientSecret resource for.
To get the oauth client ID, use a [yandex.cloud.iam.v1.OAuthClientService.List](/docs/iam/api-ref/grpc/OAuthClient/list#List) request. ||
|| description | **string**

Description of the OAuthClientResource. ||
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
    "oauth_client_secret_id": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "oauth_client_secret": {
      "id": "string",
      "oauth_client_id": "string",
      "description": "string",
      "masked_secret": "string",
      "created_at": "google.protobuf.Timestamp"
    },
    "secret_value": "string"
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
|| metadata | **[CreateOAuthClientSecretMetadata](#yandex.cloud.iam.v1.CreateOAuthClientSecretMetadata)**

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
|| response | **[CreateOAuthClientSecretResponse](#yandex.cloud.iam.v1.CreateOAuthClientSecretResponse)**

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

## CreateOAuthClientSecretMetadata {#yandex.cloud.iam.v1.CreateOAuthClientSecretMetadata}

#|
||Field | Description ||
|| oauth_client_secret_id | **string**

ID of the OAuthClientSecretResource that is being created. ||
|#

## CreateOAuthClientSecretResponse {#yandex.cloud.iam.v1.CreateOAuthClientSecretResponse}

#|
||Field | Description ||
|| oauth_client_secret | **[OAuthClientSecret](#yandex.cloud.iam.v1.OAuthClientSecret)**

OAuthClientSecret resource. ||
|| secret_value | **string**

The secret value of OAuthClientSecret resource.
This value can be used for lient secret based authentication.
This value must be stored securely. ||
|#

## OAuthClientSecret {#yandex.cloud.iam.v1.OAuthClientSecret}

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