---
editable: false
sourcePath: en/_api-ref-grpc/organizationmanager/v1/idp/api-ref/grpc/User/setPasswordHash.md
---

# Identity Provider API, gRPC: UserService.SetPasswordHash

Sets a password hash for the specified user.

## gRPC request

**rpc SetPasswordHash ([SetPasswordHashRequest](#yandex.cloud.organizationmanager.v1.idp.SetPasswordHashRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## SetPasswordHashRequest {#yandex.cloud.organizationmanager.v1.idp.SetPasswordHashRequest}

```json
{
  "user_id": "string",
  "hash": {
    "password_hash": "string",
    "password_hash_type": "PasswordHashType"
  }
}
```

Request to set a password hash for a user.

#|
||Field | Description ||
|| user_id | **string**

Required field. ID of the user to set the password hash for. ||
|| hash | **[PasswordHash](#yandex.cloud.organizationmanager.v1.idp.PasswordHash)**

Password hash to set. ||
|#

## PasswordHash {#yandex.cloud.organizationmanager.v1.idp.PasswordHash}

Password hash information.

#|
||Field | Description ||
|| password_hash | **string**

Required field. The password hash string. ||
|| password_hash_type | enum **PasswordHashType**

Required field. Type of the password hash.

- `PASSWORD_HASH_TYPE_UNSPECIFIED`: The password hash type is not specified.
- `AD_MD4`: Microsoft Active Directory MD4 hash. ||
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
    "user_id": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": "google.protobuf.Empty"
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
|| metadata | **[SetPasswordHashMetadata](#yandex.cloud.organizationmanager.v1.idp.SetPasswordHashMetadata)**

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
|| response | **[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)**

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

## SetPasswordHashMetadata {#yandex.cloud.organizationmanager.v1.idp.SetPasswordHashMetadata}

Metadata for the [UserService.SetPasswordHash](#SetPasswordHash) operation.

#|
||Field | Description ||
|| user_id | **string**

ID of the user whose password hash is being set. ||
|#