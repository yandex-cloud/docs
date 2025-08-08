---
editable: false
sourcePath: en/_api-ref-grpc/organizationmanager/v1/api-ref/grpc/UserSshKey/create.md
---

# Identity Hub API, gRPC: UserSshKeyService.Create

## gRPC request

**rpc Create ([CreateUserSshKeyRequest](#yandex.cloud.organizationmanager.v1.CreateUserSshKeyRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## CreateUserSshKeyRequest {#yandex.cloud.organizationmanager.v1.CreateUserSshKeyRequest}

```json
{
  "organization_id": "string",
  "subject_id": "string",
  "name": "string",
  "data": "string",
  "expires_at": "google.protobuf.Timestamp"
}
```

#|
||Field | Description ||
|| organization_id | **string**

Required field.  ||
|| subject_id | **string**

Required field.  ||
|| name | **string** ||
|| data | **string**

Required field.  ||
|| expires_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
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
    "user_ssh_key_id": "string",
    "organization_id": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "string",
    "subject_id": "string",
    "data": "string",
    "name": "string",
    "fingerprint": "string",
    "organization_id": "string",
    "created_at": "google.protobuf.Timestamp",
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
|| metadata | **[CreateUserSshKeyMetadata](#yandex.cloud.organizationmanager.v1.CreateUserSshKeyMetadata)**

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
|| response | **[UserSshKey](#yandex.cloud.organizationmanager.v1.UserSshKey)**

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

## CreateUserSshKeyMetadata {#yandex.cloud.organizationmanager.v1.CreateUserSshKeyMetadata}

#|
||Field | Description ||
|| user_ssh_key_id | **string** ||
|| organization_id | **string** ||
|#

## UserSshKey {#yandex.cloud.organizationmanager.v1.UserSshKey}

#|
||Field | Description ||
|| id | **string** ||
|| subject_id | **string** ||
|| data | **string** ||
|| name | **string** ||
|| fingerprint | **string** ||
|| organization_id | **string** ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|| expires_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Used for temporary keys, if empty the key doesn't expire ||
|#