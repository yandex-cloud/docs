---
editable: false
sourcePath: en/_api-ref-grpc/organizationmanager/v1/idp/api-ref/grpc/User/list.md
---

# Identity Provider API, gRPC: UserService.List

Retrieves the list of users in the specified userpool.

## gRPC request

**rpc List ([ListUsersRequest](#yandex.cloud.organizationmanager.v1.idp.ListUsersRequest)) returns ([ListUsersResponse](#yandex.cloud.organizationmanager.v1.idp.ListUsersResponse))**

## ListUsersRequest {#yandex.cloud.organizationmanager.v1.idp.ListUsersRequest}

```json
{
  "userpool_id": "string",
  "page_size": "int64",
  "page_token": "string",
  "filter": "string"
}
```

Request to list users in a userpool.

#|
||Field | Description ||
|| userpool_id | **string**

Required field. ID of the userpool to list users in. ||
|| page_size | **int64**

The maximum number of results per page to return. ||
|| page_token | **string**

Page token for pagination. ||
|| filter | **string**

A filter expression that filters resources listed in the response. ||
|#

## ListUsersResponse {#yandex.cloud.organizationmanager.v1.idp.ListUsersResponse}

```json
{
  "users": [
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
  ],
  "next_page_token": "string"
}
```

Response message for [UserService.List](#List).

#|
||Field | Description ||
|| users[] | **[User](#yandex.cloud.organizationmanager.v1.idp.User)**

List of users. ||
|| next_page_token | **string**

Token for getting the next page of the list. ||
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