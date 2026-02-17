---
editable: false
---

# OAUTH Application API, gRPC: ApplicationService.Update

Updates the specified OAuth application.

## gRPC request

**rpc Update ([UpdateApplicationRequest](#yandex.cloud.organizationmanager.v1.idp.application.oauth.UpdateApplicationRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## UpdateApplicationRequest {#yandex.cloud.organizationmanager.v1.idp.application.oauth.UpdateApplicationRequest}

```json
{
  "application_id": "string",
  "update_mask": "google.protobuf.FieldMask",
  "name": "string",
  "description": "string",
  "group_claims_settings": {
    "group_distribution_type": "GroupDistributionType"
  },
  "client_grant": {
    "client_id": "string",
    "authorized_scopes": [
      "string"
    ]
  },
  "labels": "map<string, string>"
}
```

Request to update a OAuth application.

#|
||Field | Description ||
|| application_id | **string**

Required field. ID of the OAuth application to update.
To get the OAuth application ID, make a [ApplicationService.List](/docs/organization/idp/application/oauth/mapi-ref/grpc/Application/list#List) request.

The maximum string length in characters is 50. ||
|| update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**

Field mask that specifies which fields of the OAuth application are going to be updated. ||
|| name | **string**

Name of the OAuth application.
The name must be unique within the organization.

Value must match the regular expression ``` |[a-z]([-a-z0-9]{0,61}[a-z0-9])? ```. ||
|| description | **string**

Description of the OAuth application.

The maximum string length in characters is 256. ||
|| group_claims_settings | **[GroupClaimsSettings](#yandex.cloud.organizationmanager.v1.idp.application.oauth.GroupClaimsSettings)**

Settings of the group claims ||
|| client_grant | **[ClientGrant](#yandex.cloud.organizationmanager.v1.idp.application.oauth.ClientGrant)**

Connection to the OAuth client with specified scopes ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as key:value pairs.

No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `. ||
|#

## GroupClaimsSettings {#yandex.cloud.organizationmanager.v1.idp.application.oauth.GroupClaimsSettings}

Settings of the group claims

#|
||Field | Description ||
|| group_distribution_type | enum **GroupDistributionType**

Represents current distribution type of the groups. I.e. which groups are visible for the application users.

- `NONE`: No groups are visible for the application users
- `ASSIGNED_GROUPS`: Only assigned groups are visible for the application users
- `ALL_GROUPS`: All groups are visible for the application users ||
|#

## ClientGrant {#yandex.cloud.organizationmanager.v1.idp.application.oauth.ClientGrant}

Represents connection to the OAuth client with specified scopes

#|
||Field | Description ||
|| client_id | **string**

Required field. OAuth client id

The maximum string length in characters is 50. ||
|| authorized_scopes[] | **string**

List of authorized client scopes by the application

The number of elements must be in the range 1-1000. The maximum string length in characters for each value is 255. ||
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
    "application_id": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "string",
    "name": "string",
    "organization_id": "string",
    "description": "string",
    "group_claims_settings": {
      "group_distribution_type": "GroupDistributionType"
    },
    "client_grant": {
      "client_id": "string",
      "authorized_scopes": [
        "string"
      ]
    },
    "status": "Status",
    "labels": "map<string, string>",
    "created_at": "google.protobuf.Timestamp",
    "updated_at": "google.protobuf.Timestamp"
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
|| metadata | **[UpdateApplicationMetadata](#yandex.cloud.organizationmanager.v1.idp.application.oauth.UpdateApplicationMetadata)**

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
|| response | **[Application](#yandex.cloud.organizationmanager.v1.idp.application.oauth.Application)**

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

## UpdateApplicationMetadata {#yandex.cloud.organizationmanager.v1.idp.application.oauth.UpdateApplicationMetadata}

Metadata for the [ApplicationService.Update](#Update) operation.

#|
||Field | Description ||
|| application_id | **string**

ID of the OAuth application that is being updated. ||
|#

## Application {#yandex.cloud.organizationmanager.v1.idp.application.oauth.Application}

An OAuth application resource.

#|
||Field | Description ||
|| id | **string**

ID of the application. ||
|| name | **string**

Name of the application.
The name is unique within the organization. 3-63 characters long. ||
|| organization_id | **string**

ID of the organization that the application belongs to. ||
|| description | **string**

Description of the application. 0-256 characters long. ||
|| group_claims_settings | **[GroupClaimsSettings](#yandex.cloud.organizationmanager.v1.idp.application.oauth.GroupClaimsSettings2)**

Settings of the group claims ||
|| client_grant | **[ClientGrant](#yandex.cloud.organizationmanager.v1.idp.application.oauth.ClientGrant2)**

Represents current connection to the OAuth client with specified scopes ||
|| status | enum **Status**

Current status of the application.

- `CREATING`: The apllication is in the process of being created.
- `ACTIVE`: The apllication is active and operational.
- `SUSPENDED`: The apllication is suspended. I.e. authentication via this application is disabled.
- `DELETING`: The apllication is in the process of being deleted. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `` key:value `` pairs. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Modification timestamp. ||
|#

## GroupClaimsSettings {#yandex.cloud.organizationmanager.v1.idp.application.oauth.GroupClaimsSettings2}

Settings of the group claims

#|
||Field | Description ||
|| group_distribution_type | enum **GroupDistributionType**

Represents current distribution type of the groups. I.e. which groups are visible for the application users.

- `NONE`: No groups are visible for the application users
- `ASSIGNED_GROUPS`: Only assigned groups are visible for the application users
- `ALL_GROUPS`: All groups are visible for the application users ||
|#

## ClientGrant {#yandex.cloud.organizationmanager.v1.idp.application.oauth.ClientGrant2}

Represents connection to the OAuth client with specified scopes

#|
||Field | Description ||
|| client_id | **string**

Required field. OAuth client id

The maximum string length in characters is 50. ||
|| authorized_scopes[] | **string**

List of authorized client scopes by the application

The number of elements must be in the range 1-1000. The maximum string length in characters for each value is 255. ||
|#