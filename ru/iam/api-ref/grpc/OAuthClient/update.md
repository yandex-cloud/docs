---
editable: false
sourcePath: en/_api-ref-grpc/iam/v1/api-ref/grpc/OAuthClient/update.md
---

# Identity and Access Management API, gRPC: OAuthClientService.Update

Updates the specified oauth client.

## gRPC request

**rpc Update ([UpdateOAuthClientRequest](#yandex.cloud.iam.v1.UpdateOAuthClientRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## UpdateOAuthClientRequest {#yandex.cloud.iam.v1.UpdateOAuthClientRequest}

```json
{
  "oauth_client_id": "string",
  "update_mask": "google.protobuf.FieldMask",
  "name": "string",
  "redirect_uris": [
    "string"
  ],
  "scopes": [
    "string"
  ]
}
```

#|
||Field | Description ||
|| oauth_client_id | **string**

Required field. ID of the OAuthClient resource to update.
To get the oauth client ID, use a [OAuthClientService.List](/docs/iam/api-ref/grpc/OAuthClient/list#List) request. ||
|| update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**

Field mask that specifies which fields of the OAuthClient resource are going to be updated. ||
|| name | **string**

Required field. Name of the oauth client.
The name must be unique within folder. ||
|| redirect_uris[] | **string**

List of redirect uries allowed for the oauth client. ||
|| scopes[] | **string**

List of oauth scopes requested by the oauth client. ||
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
    "oauth_client_id": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "string",
    "name": "string",
    "redirect_uris": [
      "string"
    ],
    "scopes": [
      "string"
    ],
    "folder_id": "string",
    "status": "Status"
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
|| metadata | **[UpdateOAuthClientMetadata](#yandex.cloud.iam.v1.UpdateOAuthClientMetadata)**

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
|| response | **[OAuthClient](#yandex.cloud.iam.v1.OAuthClient)**

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

## UpdateOAuthClientMetadata {#yandex.cloud.iam.v1.UpdateOAuthClientMetadata}

#|
||Field | Description ||
|| oauth_client_id | **string**

ID of the oauth client that is being updated ||
|#

## OAuthClient {#yandex.cloud.iam.v1.OAuthClient}

An OauthClient resource.

#|
||Field | Description ||
|| id | **string**

ID of the oauth client. ||
|| name | **string**

Name for the oauth client. ||
|| redirect_uris[] | **string**

List of redirect uries allowed for the oauth client. ||
|| scopes[] | **string**

List of oauth scopes requested by the oauth client. ||
|| folder_id | **string**

ID of the folder oauth client belongs to. ||
|| status | enum **Status**

Current status of the oauth client.

- `STATUS_UNSPECIFIED`
- `CREATING`: OAuth client is being created.
- `ACTIVE`: OAuth client is active.
- `DELETING`: OAuth client is being deleted. ||
|#