---
editable: false
apiPlayground:
  - url: https://organization-manager.{{ api-host }}/organization-manager/v1/idp/application/oauth/applications
    method: post
    path: null
    query: null
    body:
      type: object
      properties:
        name:
          description: |-
            **string**
            Required field. Name of the OAuth application.
            The name must be unique within the organization.
            The maximum string length in characters is 100. Value must match the regular expression ` [a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
          pattern: '[a-z]([-a-z0-9]{0,61}[a-z0-9])?'
          type: string
        organizationId:
          description: |-
            **string**
            Required field. ID of the organization to create a OAuth application in.
            The maximum string length in characters is 50.
          type: string
        description:
          description: |-
            **string**
            Description of the OAuth application.
            The maximum string length in characters is 256.
          type: string
        groupClaimsSettings:
          description: |-
            **[GroupClaimsSettings](#yandex.cloud.organizationmanager.v1.idp.application.oauth.GroupClaimsSettings)**
            Settings of the group claims
          $ref: '#/definitions/GroupClaimsSettings'
        clientGrant:
          description: |-
            **[ClientGrant](#yandex.cloud.organizationmanager.v1.idp.application.oauth.ClientGrant)**
            Connection to the OAuth client with specified scopes
          $ref: '#/definitions/ClientGrant'
        labels:
          description: |-
            **object** (map<**string**, **string**>)
            Resource labels as key:value pairs.
            No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
          type: object
          additionalProperties:
            type: string
            pattern: '[-_0-9a-z]*'
            maxLength: 63
          propertyNames:
            type: string
            pattern: '[a-z][-_0-9a-z]*'
            maxLength: 63
            minLength: 1
          maxProperties: 64
      required:
        - name
        - organizationId
      additionalProperties: false
    definitions:
      GroupClaimsSettings:
        type: object
        properties:
          groupDistributionType:
            description: |-
              **enum** (GroupDistributionType)
              Represents current distribution type of the groups. I.e. which groups are visible for the application users.
              - `NONE`: No groups are visible for the application users
              - `ASSIGNED_GROUPS`: Only assigned groups are visible for the application users
              - `ALL_GROUPS`: All groups are visible for the application users
            type: string
            enum:
              - GROUP_DISTRIBUTION_TYPE_UNSPECIFIED
              - NONE
              - ASSIGNED_GROUPS
              - ALL_GROUPS
      ClientGrant:
        type: object
        properties:
          clientId:
            description: |-
              **string**
              Required field. OAuth client id
              The maximum string length in characters is 50.
            type: string
          authorizedScopes:
            description: |-
              **string**
              List of authorized client scopes by the application
              The number of elements must be in the range 1-1000. The maximum string length in characters for each value is 255.
            type: array
            items:
              type: string
        required:
          - clientId
sourcePath: en/_api-ref/organizationmanager/v1/idp/application/oauth/api-ref/Application/create.md
---

# OAUTH Application API, REST: Application.Create

Creates an OAuth application in the specified organization.

## HTTP request

```
POST https://organization-manager.{{ api-host }}/organization-manager/v1/idp/application/oauth/applications
```

## Body parameters {#yandex.cloud.organizationmanager.v1.idp.application.oauth.CreateApplicationRequest}

```json
{
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
  "labels": "object"
}
```

Request to create a OAuth application.

#|
||Field | Description ||
|| name | **string**

Required field. Name of the OAuth application.
The name must be unique within the organization.

The maximum string length in characters is 100. Value must match the regular expression ` [a-z]([-a-z0-9]{0,61}[a-z0-9])? `. ||
|| organizationId | **string**

Required field. ID of the organization to create a OAuth application in.

The maximum string length in characters is 50. ||
|| description | **string**

Description of the OAuth application.

The maximum string length in characters is 256. ||
|| groupClaimsSettings | **[GroupClaimsSettings](#yandex.cloud.organizationmanager.v1.idp.application.oauth.GroupClaimsSettings)**

Settings of the group claims ||
|| clientGrant | **[ClientGrant](#yandex.cloud.organizationmanager.v1.idp.application.oauth.ClientGrant)**

Connection to the OAuth client with specified scopes ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as key:value pairs.

No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `. ||
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

## Response {#yandex.cloud.operation.Operation}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": "boolean",
  "metadata": {
    "applicationId": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": {
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
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **string** (date-time)

The time when the Operation resource was last modified.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| done | **boolean**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[CreateApplicationMetadata](#yandex.cloud.organizationmanager.v1.idp.application.oauth.CreateApplicationMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[Status](#google.rpc.Status)**

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

## CreateApplicationMetadata {#yandex.cloud.organizationmanager.v1.idp.application.oauth.CreateApplicationMetadata}

Metadata for the [ApplicationService.Create](#Create) operation.

#|
||Field | Description ||
|| applicationId | **string**

ID of the OAuth application that is being created. ||
|#

## Status {#google.rpc.Status}

The error result of the operation in case of failure or cancellation.

#|
||Field | Description ||
|| code | **integer** (int32)

Error code. An enum value of [google.rpc.Code](https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto). ||
|| message | **string**

An error message. ||
|| details[] | **object**

A list of messages that carry the error details. ||
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
|| groupClaimsSettings | **[GroupClaimsSettings](#yandex.cloud.organizationmanager.v1.idp.application.oauth.GroupClaimsSettings2)**

Settings of the group claims ||
|| clientGrant | **[ClientGrant](#yandex.cloud.organizationmanager.v1.idp.application.oauth.ClientGrant2)**

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

## GroupClaimsSettings {#yandex.cloud.organizationmanager.v1.idp.application.oauth.GroupClaimsSettings2}

Settings of the group claims

#|
||Field | Description ||
|| groupDistributionType | **enum** (GroupDistributionType)

Represents current distribution type of the groups. I.e. which groups are visible for the application users.

- `NONE`: No groups are visible for the application users
- `ASSIGNED_GROUPS`: Only assigned groups are visible for the application users
- `ALL_GROUPS`: All groups are visible for the application users ||
|#

## ClientGrant {#yandex.cloud.organizationmanager.v1.idp.application.oauth.ClientGrant2}

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