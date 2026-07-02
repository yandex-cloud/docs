[Документация Yandex Cloud](../../../../../index.md) > [Yandex Identity Hub](../../../../index.md) > Справочник API > gRPC (англ.) > [Identity Provider API](../index.md) > [User](index.md) > Update

# Identity Provider API, gRPC: UserService.Update

Updates the specified user.

## gRPC request

**rpc Update ([UpdateUserRequest](#yandex.cloud.organizationmanager.v1.idp.UpdateUserRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## UpdateUserRequest {#yandex.cloud.organizationmanager.v1.idp.UpdateUserRequest}

```json
{
  "user_id": "string",
  "update_mask": "google.protobuf.FieldMask",
  "username": "string",
  "full_name": "string",
  "given_name": "string",
  "family_name": "string",
  "email": "string",
  "phone_number": "string",
  "company_name": "string",
  "department": "string",
  "job_title": "string",
  "employee_id": "string",
  "expires_at": "google.protobuf.Timestamp"
}
```

Request to update an existing user.

#|
||Field | Description ||
|| user_id | **string**

Required field. ID of the user to update.

The maximum string length in characters is 50. ||
|| update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**

Field mask that specifies which fields of the user are going to be updated. ||
|| username | **string**

New username for the user.

The maximum string length in characters is 254. Value must match the regular expression ``` |[a-z0-9A-Z\._-]{1,64}@.{1,256} ```. ||
|| full_name | **string**

New full name for the user.

The maximum string length in characters is 256. ||
|| given_name | **string**

New first name for the user.

The maximum string length in characters is 256. ||
|| family_name | **string**

New last name for the user.

The maximum string length in characters is 256. ||
|| email | **string**

New email address for the user.

The maximum string length in characters is 254. Value must match the regular expression ``` |(.{3,254}) ```. ||
|| phone_number | **string**

New phone number for the user.

The maximum string length in characters is 50. ||
|| company_name | **string**

New company name for the user.

The maximum string length in characters is 256. ||
|| department | **string**

New department for the user.

The maximum string length in characters is 256. ||
|| job_title | **string**

New job title for the user.

The maximum string length in characters is 256. ||
|| employee_id | **string**

New employee ID for the user.

The maximum string length in characters is 256. ||
|| expires_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp when the user account expires. ||
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