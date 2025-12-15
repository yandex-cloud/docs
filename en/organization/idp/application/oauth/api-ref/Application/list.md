---
editable: false
apiPlayground:
  - url: https://organization-manager.{{ api-host }}/organization-manager/v1/idp/application/oauth/applications
    method: get
    path: null
    query:
      type: object
      properties:
        organizationId:
          description: |-
            **string**
            Required field. ID of the organization to list OAuth applications in.
            The maximum string length in characters is 50.
          type: string
        pageSize:
          description: |-
            **string** (int64)
            The maximum number of results per page to return.
            If the number of available results is larger than `pageSize`,
            the service returns a [ListApplicationsResponse.nextPageToken](#yandex.cloud.organizationmanager.v1.idp.application.oauth.ListApplicationsResponse)
            that can be used to get the next page of results in subsequent list requests.
            Default value: 100.
            Acceptable values are 0 to 1000, inclusive.
          default: '100'
          type: string
          format: int64
        pageToken:
          description: |-
            **string**
            Page token. To get the next page of results, set `pageToken`
            to the [ListApplicationsResponse.nextPageToken](#yandex.cloud.organizationmanager.v1.idp.application.oauth.ListApplicationsResponse)
            returned by a previous list request.
            The maximum string length in characters is 2000.
          type: string
        filter:
          description: |-
            **string**
            A filter expression that filters resources listed in the response.
            The maximum string length in characters is 1000.
          type: string
      required:
        - organizationId
      additionalProperties: false
    body: null
    definitions: null
sourcePath: en/_api-ref/organizationmanager/v1/idp/application/oauth/api-ref/Application/list.md
---

# OAUTH Application API, REST: Application.List

Retrieves the list of OAuth applications in the specified organization.

## HTTP request

```
GET https://organization-manager.{{ api-host }}/organization-manager/v1/idp/application/oauth/applications
```

## Query parameters {#yandex.cloud.organizationmanager.v1.idp.application.oauth.ListApplicationsRequest}

Request to list OAuth applications.

#|
||Field | Description ||
|| organizationId | **string**

Required field. ID of the organization to list OAuth applications in.

The maximum string length in characters is 50. ||
|| pageSize | **string** (int64)

The maximum number of results per page to return.
If the number of available results is larger than `pageSize`,
the service returns a [ListApplicationsResponse.nextPageToken](#yandex.cloud.organizationmanager.v1.idp.application.oauth.ListApplicationsResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100.

Acceptable values are 0 to 1000, inclusive. ||
|| pageToken | **string**

Page token. To get the next page of results, set `pageToken`
to the [ListApplicationsResponse.nextPageToken](#yandex.cloud.organizationmanager.v1.idp.application.oauth.ListApplicationsResponse)
returned by a previous list request.

The maximum string length in characters is 2000. ||
|| filter | **string**

A filter expression that filters resources listed in the response.

The maximum string length in characters is 1000. ||
|#

## Response {#yandex.cloud.organizationmanager.v1.idp.application.oauth.ListApplicationsResponse}

**HTTP Code: 200 - OK**

```json
{
  "applications": [
    {
      "id": "string",
      "name": "string",
      "organizationId": "string",
      "description": "string",
      "groupClaimsSettings": {
        "groupDistributionType": "string"
      },
      "clientGrant": {
        "clientId": "string",
        "authorizedScopes": [
          "string"
        ]
      },
      "status": "string",
      "labels": "object",
      "createdAt": "string",
      "updatedAt": "string"
    }
  ],
  "nextPageToken": "string"
}
```

Response message for [ApplicationService.List](#List).

#|
||Field | Description ||
|| applications[] | **[Application](#yandex.cloud.organizationmanager.v1.idp.application.oauth.Application)**

List of OAuth applications. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests.
If the number of results is larger than [ListApplicationsRequest.pageSize](#yandex.cloud.organizationmanager.v1.idp.application.oauth.ListApplicationsRequest),
use the `nextPageToken` as the value for the [ListApplicationsRequest.pageToken](#yandex.cloud.organizationmanager.v1.idp.application.oauth.ListApplicationsRequest)
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
|| organizationId | **string**

ID of the organization that the application belongs to. ||
|| description | **string**

Description of the application. 0-256 characters long. ||
|| groupClaimsSettings | **[GroupClaimsSettings](#yandex.cloud.organizationmanager.v1.idp.application.oauth.GroupClaimsSettings)**

Settings of the group claims ||
|| clientGrant | **[ClientGrant](#yandex.cloud.organizationmanager.v1.idp.application.oauth.ClientGrant)**

Represents current connection to the OAuth client with specified scopes ||
|| status | **enum** (Status)

Current status of the application.

- `CREATING`: The apllication is in the process of being created.
- `ACTIVE`: The apllication is active and operational.
- `SUSPENDED`: The apllication is suspended. I.e. authentication via this application is disabled.
- `DELETING`: The apllication is in the process of being deleted. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `` key:value `` pairs. ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| updatedAt | **string** (date-time)

Modification timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|#

## GroupClaimsSettings {#yandex.cloud.organizationmanager.v1.idp.application.oauth.GroupClaimsSettings}

Settings of the group claims

#|
||Field | Description ||
|| groupDistributionType | **enum** (GroupDistributionType)

Represents current distribution type of the groups. I.e. which groups are visible for the application users.

- `NONE`: No groups are visible for the application users
- `ASSIGNED_GROUPS`: Only assigned groups are visible for the application users
- `ALL_GROUPS`: All groups are visible for the application users ||
|#

## ClientGrant {#yandex.cloud.organizationmanager.v1.idp.application.oauth.ClientGrant}

Represents connection to the OAuth client with specified scopes

#|
||Field | Description ||
|| clientId | **string**

Required field. OAuth client id

The maximum string length in characters is 50. ||
|| authorizedScopes[] | **string**

List of authorized client scopes by the application

The number of elements must be in the range 1-1000. The maximum string length in characters for each value is 255. ||
|#