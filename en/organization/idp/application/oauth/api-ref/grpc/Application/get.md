---
editable: false
sourcePath: en/_api-ref-grpc/organizationmanager/v1/idp/application/oauth/api-ref/grpc/Application/get.md
---

# OAUTH Application API, gRPC: ApplicationService.Get

Returns the specified OAuth application resource.

To get the list of available OAuth applications, make a [List](/docs/organization/idp/application/oauth/mapi-ref/grpc/Application/list#List) request.

## gRPC request

**rpc Get ([GetApplicationRequest](#yandex.cloud.organizationmanager.v1.idp.application.oauth.GetApplicationRequest)) returns ([Application](#yandex.cloud.organizationmanager.v1.idp.application.oauth.Application))**

## GetApplicationRequest {#yandex.cloud.organizationmanager.v1.idp.application.oauth.GetApplicationRequest}

```json
{
  "application_id": "string"
}
```

Request to get a OAuth application.

#|
||Field | Description ||
|| application_id | **string**

Required field. ID of the OAuth application to return.
To get the OAuth application ID, make a [ApplicationService.List](/docs/organization/idp/application/oauth/mapi-ref/grpc/Application/list#List) request. ||
|#

## Application {#yandex.cloud.organizationmanager.v1.idp.application.oauth.Application}

```json
{
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
```

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
|| group_claims_settings | **[GroupClaimsSettings](#yandex.cloud.organizationmanager.v1.idp.application.oauth.GroupClaimsSettings)**

Settings of the group claims ||
|| client_grant | **[ClientGrant](#yandex.cloud.organizationmanager.v1.idp.application.oauth.ClientGrant)**

Represents current connection to the OAuth client with specified scopes ||
|| status | enum **Status**

Current status of the application.

- `STATUS_UNSPECIFIED`: The status is not specified.
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

## GroupClaimsSettings {#yandex.cloud.organizationmanager.v1.idp.application.oauth.GroupClaimsSettings}

Settings of the group claims

#|
||Field | Description ||
|| group_distribution_type | enum **GroupDistributionType**

Represents current distribution type of the groups. I.e. which groups are visible for the application users.

- `GROUP_DISTRIBUTION_TYPE_UNSPECIFIED`: The distribution type is unspecified
- `NONE`: No groups are visible for the application users
- `ASSIGNED_GROUPS`: Only assigned groups are visible for the application users
- `ALL_GROUPS`: All groups are visible for the application users ||
|#

## ClientGrant {#yandex.cloud.organizationmanager.v1.idp.application.oauth.ClientGrant}

Represents connection to the OAuth client with specified scopes

#|
||Field | Description ||
|| client_id | **string**

Required field. OAuth client id ||
|| authorized_scopes[] | **string**

List of authorized client scopes by the application ||
|#