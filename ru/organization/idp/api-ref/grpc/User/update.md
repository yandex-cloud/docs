---
editable: false
sourcePath: en/_api-ref-grpc/organizationmanager/v1/idp/api-ref/grpc/User/update.md
---

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
  "phone_number": "string"
}
```

Request to update an existing user.

#|
||Field | Description ||
|| user_id | **string**

Required field. ID of the user to update. ||
|| update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**

Field mask that specifies which fields of the user are going to be updated. ||
|| username | **string**

New username for the user. ||
|| full_name | **string**

New full name for the user. ||
|| given_name | **string**

New first name for the user. ||
|| family_name | **string**

New last name for the user. ||
|| email | **string**

New email address for the user. ||
|| phone_number | **string**

New phone number for the user. ||
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
  "response": {
    "id": "string",
    "userpool_id": "string",
    "status": "Status",
    "username": "string",
    "full_name": "string",
    "given_name": "string",
    "family_name": "string",
    "email": "string",
    "phone_number": "string",
    "created_at": "google.protobuf.Timestamp",
    "updated_at": "google.protobuf.Timestamp",
    "external_id": "string"
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
|| metadata | **[UpdateUserMetadata](#yandex.cloud.organizationmanager.v1.idp.UpdateUserMetadata)**

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
|| response | **[User](#yandex.cloud.organizationmanager.v1.idp.User)**

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

## UpdateUserMetadata {#yandex.cloud.organizationmanager.v1.idp.UpdateUserMetadata}

Metadata for the [UserService.Update](#Update) operation.

#|
||Field | Description ||
|| user_id | **string**

ID of the user that is being updated. ||
|#

## User {#yandex.cloud.organizationmanager.v1.idp.User}

A user in the Identity Provider system.

Users are created within a userpool and can authenticate to access cloud resources.
Each user has a unique identifier, credentials, and profile information.

#|
||Field | Description ||
|| id | **string**

Unique identifier of the user.
This ID is generated automatically when the user is created. ||
|| userpool_id | **string**

ID of the userpool this user belongs to.
To get the userpool ID, make a [UserpoolService.List](/docs/organization/idp/api-ref/grpc/Userpool/list#List) request. ||
|| status | enum **Status**

Current status of the user.
Determines whether the user can authenticate and access the system.

- `STATUS_UNSPECIFIED`: The status is not specified.
- `ACTIVE`: The user is active and can authenticate.
Active users have full access to the system according to their permissions.
- `SUSPENDED`: The user is suspended and cannot authenticate.
Suspended users retain their data but cannot access the system.
- `DELETING`: The user is in the process of being deleted.
This is a transitional state before the user is completely removed from the system. ||
|| username | **string**

Username used for authentication.
Usually in the format of an email address. ||
|| full_name | **string**

User's full name (display name).
This is typically shown in the UI and used for identification purposes. ||
|| given_name | **string**

User's first name.
Part of the user's profile information. ||
|| family_name | **string**

User's last name.
Part of the user's profile information. ||
|| email | **string**

User's email address. ||
|| phone_number | **string**

User's phone number. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp when the user was created. ||
|| updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp when the user was last updated. ||
|| external_id | **string**

External identifier for federation with external identity systems.
This ID can be used to link this user with an account in an external system. ||
|#