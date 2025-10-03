---
editable: false
apiPlayground:
  - url: https://organization-manager.{{ api-host }}/organization-manager/v1/idp/application/oauth/applications/{applicationId}
    method: get
    path:
      type: object
      properties:
        applicationId:
          description: |-
            **string**
            Required field. ID of the OAuth application to return.
            To get the OAuth application ID, make a [ApplicationService.List](/docs/organization/idp/application/oauth/mapi-ref/Application/list#List) request.
          type: string
      required:
        - applicationId
      additionalProperties: false
    query: null
    body: null
    definitions: null
sourcePath: en/_api-ref/organizationmanager/v1/idp/application/oauth/api-ref/Application/get.md
---

# OAUTH Application API, REST: Application.Get

Returns the specified OAuth application resource.

To get the list of available OAuth applications, make a [List](/docs/organization/idp/application/oauth/mapi-ref/Application/list#List) request.

## HTTP request

```
GET https://organization-manager.{{ api-host }}/organization-manager/v1/idp/application/oauth/applications/{applicationId}
```

## Path parameters

Request to get a OAuth application.

#|
||Field | Description ||
|| applicationId | **string**

Required field. ID of the OAuth application to return.
To get the OAuth application ID, make a [ApplicationService.List](/docs/organization/idp/application/oauth/mapi-ref/Application/list#List) request. ||
|#

## Response {#yandex.cloud.organizationmanager.v1.idp.application.oauth.Application}

**HTTP Code: 200 - OK**

```json
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
```

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

- `STATUS_UNSPECIFIED`: The status is not specified.
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

- `GROUP_DISTRIBUTION_TYPE_UNSPECIFIED`: The distribution type is unspecified
- `NONE`: No groups are visible for the application users
- `ASSIGNED_GROUPS`: Only assigned groups are visible for the application users
- `ALL_GROUPS`: All groups are visible for the application users ||
|#

## ClientGrant {#yandex.cloud.organizationmanager.v1.idp.application.oauth.ClientGrant}

Represents connection to the OAuth client with specified scopes

#|
||Field | Description ||
|| clientId | **string**

Required field. OAuth client id ||
|| authorizedScopes[] | **string**

List of authorized client scopes by the application ||
|#