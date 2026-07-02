[Документация Yandex Cloud](../../../../../index.md) > [Yandex Identity Hub](../../../../index.md) > Справочник API > gRPC (англ.) > [Identity Provider API](../index.md) > [User](index.md) > CommitPassword

# Identity Provider API, gRPC: UserService.CommitPassword

Commits the result of a password writeback operation.

## gRPC request

**rpc CommitPassword ([CommitPasswordRequest](#yandex.cloud.organizationmanager.v1.idp.CommitPasswordRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## CommitPasswordRequest {#yandex.cloud.organizationmanager.v1.idp.CommitPasswordRequest}

```json
{
  "external_user_id": "string",
  "password": "string",
  "modifying_operation_id": "string",
  "need_change": "bool",
  "error_details": {
    "error_code": "PasswordWritebackErrorCode",
    "error_message": "string"
  },
  "expires_at": "google.protobuf.Timestamp",
  "generated": "bool",
  "userpool_id": "string"
}
```

Request to commit the result of a password writeback operation.

#|
||Field | Description ||
|| external_user_id | **string**

Required field. External identifier of the user whose password was written back.

The maximum string length in characters is 50. ||
|| password | **string**

Required field. The password that was written back.

The maximum string length in characters is 128. ||
|| modifying_operation_id | **string**

Required field. ID of the operation that triggered this writeback.

The maximum string length in characters is 50. ||
|| need_change | **bool**

Whether the user must change their password on next login. ||
|| error_details | **[PasswordWritebackErrorDetails](#yandex.cloud.organizationmanager.v1.idp.PasswordWritebackErrorDetails)**

Error details if the writeback failed. ||
|| expires_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp when the password expires. ||
|| generated | **bool**

Whether the password was system-generated. ||
|| userpool_id | **string**

Required field. ID of the userpool the user belongs to.

The maximum string length in characters is 50. ||
|#

## PasswordWritebackErrorDetails {#yandex.cloud.organizationmanager.v1.idp.PasswordWritebackErrorDetails}

Error details from LDAP password writeback.

#|
||Field | Description ||
|| error_code | enum **PasswordWritebackErrorCode**

Type of error, used for UI rendering.

- `PERMISSION_DENIED`: The IdentityHub sync agent does not have permission to set the password.
- `PASSWORD_POLICY_VIOLATION`: The password does not meet the directory's password policy.
- `UNKNOWN_ERROR`: An unknown error occurred.
- `DEADLINE_EXCEEDED`: The writeback operation timed out. ||
|| error_message | **string**

Exact error message from LDAP, for debugging purposes. ||
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
  "metadata": "google.protobuf.Any",
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": "google.protobuf.Any"
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](../../../../../api-design-guide/concepts/operation.md).

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
|| metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**

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
|| response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**

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