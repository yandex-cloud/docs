---
editable: false
---

# OAUTH Application API, gRPC: ApplicationService.List

Retrieves the list of OAuth applications in the specified organization.

## gRPC request

**rpc List ([ListApplicationsRequest](#yandex.cloud.organizationmanager.v1.idp.application.oauth.ListApplicationsRequest)) returns ([ListApplicationsResponse](#yandex.cloud.organizationmanager.v1.idp.application.oauth.ListApplicationsResponse))**

## ListApplicationsRequest {#yandex.cloud.organizationmanager.v1.idp.application.oauth.ListApplicationsRequest}

```json
{
  "organization_id": "string",
  "page_size": "int64",
  "page_token": "string",
  "filter": "string"
}
```

Request to list OAuth applications.

#|
||Field | Description ||
|| organization_id | **string**

Required field. ID of the organization to list OAuth applications in.

The maximum string length in characters is 50. ||
|| page_size | **int64**

The maximum number of results per page to return.
If the number of available results is larger than `page_size`,
the service returns a [ListApplicationsResponse.next_page_token](#yandex.cloud.organizationmanager.v1.idp.application.oauth.ListApplicationsResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100.

Acceptable values are 0 to 1000, inclusive. ||
|| page_token | **string**

Page token. To get the next page of results, set `page_token`
to the [ListApplicationsResponse.next_page_token](#yandex.cloud.organizationmanager.v1.idp.application.oauth.ListApplicationsResponse)
returned by a previous list request.

The maximum string length in characters is 2000. ||
|| filter | **string**

A filter expression that filters resources listed in the response.

The maximum string length in characters is 1000. ||
|#

## ListApplicationsResponse {#yandex.cloud.organizationmanager.v1.idp.application.oauth.ListApplicationsResponse}

```json
{
  "applications": [
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
  ],
  "next_page_token": "string"
}
```

Response message for [ApplicationService.List](#List).

#|
||Field | Description ||
|| applications[] | **[Application](#yandex.cloud.organizationmanager.v1.idp.application.oauth.Application)**

List of OAuth applications. ||
|| next_page_token | **string**

This token allows you to get the next page of results for list requests.
If the number of results is larger than [ListApplicationsRequest.page_size](#yandex.cloud.organizationmanager.v1.idp.application.oauth.ListApplicationsRequest),
use the `next_page_token` as the value for the [ListApplicationsRequest.page_token](#yandex.cloud.organizationmanager.v1.idp.application.oauth.ListApplicationsRequest)
query parameter in the next list request. ||
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
|| group_claims_settings | **[GroupClaimsSettings](#yandex.cloud.organizationmanager.v1.idp.application.oauth.GroupClaimsSettings)**

Settings of the group claims ||
|| client_grant | **[ClientGrant](#yandex.cloud.organizationmanager.v1.idp.application.oauth.ClientGrant)**

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