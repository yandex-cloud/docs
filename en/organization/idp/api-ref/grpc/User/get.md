---
editable: false
sourcePath: en/_api-ref-grpc/organizationmanager/v1/idp/api-ref/grpc/User/get.md
---

# Identity Provider API, gRPC: UserService.Get

Returns the specified user.

To get the list of available users, make a [List](/docs/organization/idp/api-ref/grpc/User/list#List) request.

## gRPC request

**rpc Get ([GetUserRequest](#yandex.cloud.organizationmanager.v1.idp.GetUserRequest)) returns ([User](#yandex.cloud.organizationmanager.v1.idp.User))**

## GetUserRequest {#yandex.cloud.organizationmanager.v1.idp.GetUserRequest}

```json
{
  "user_id": "string"
}
```

Request to get a user by ID.

#|
||Field | Description ||
|| user_id | **string**

Required field. ID of the user to return. ||
|#

## User {#yandex.cloud.organizationmanager.v1.idp.User}

```json
{
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
```

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