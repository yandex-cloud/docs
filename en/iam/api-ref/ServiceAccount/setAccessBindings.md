---
editable: false
apiPlayground:
  - url: https://iam.{{ api-host }}/iam/v1/serviceAccounts/{resourceId}:setAccessBindings
    method: post
    path:
      type: object
      properties:
        resourceId:
          description: |-
            **string**
            Required field. ID of the resource for which access bindings are being set.
            To get the resource ID, use a corresponding List request.
            The maximum string length in characters is 64.
          type: string
      required:
        - resourceId
      additionalProperties: false
    query: null
    body:
      type: object
      properties:
        accessBindings:
          description: |-
            **[AccessBinding](#yandex.cloud.access.AccessBinding)**
            Access bindings to be set. For more information, see [Access Bindings](/docs/iam/concepts/access-control/#access-bindings).
            The maximum number of elements is 1000.
          type: array
          items:
            $ref: '#/definitions/AccessBinding'
      additionalProperties: false
    definitions:
      Group:
        type: object
        properties:
          id:
            description: |-
              **string**
              ID of the group.
            type: string
          name:
            description: |-
              **string**
              Name of the group.
            type: string
          type:
            description: |-
              **enum** (GroupType)
              Type of the group.
              - `PUBLIC_ACCESS`: Public group.
              - `EXPLICIT`: Regular group.
              - `META`: System group.
            type: string
            enum:
              - GROUP_TYPE_UNSPECIFIED
              - PUBLIC_ACCESS
              - EXPLICIT
              - META
      YandexPassportUserAccount:
        type: object
        properties:
          login:
            description: |-
              **string**
              Login of the Yandex user account.
            type: string
          defaultEmail:
            description: |-
              **string**
              Default email of the Yandex user account.
            type: string
      Attribute:
        type: object
        properties:
          value:
            description: '**string**'
            type: array
            items:
              type: string
      SamlUserAccount:
        type: object
        properties:
          federationId:
            description: |-
              **string**
              Required field. ID of the federation that the federation belongs to.
              The maximum string length in characters is 50.
            type: string
          nameId:
            description: |-
              **string**
              Required field. Name Id of the SAML federated user.
              The name is unique within the federation. 1-256 characters long.
              The string length in characters must be 1-256.
            type: string
          attributes:
            description: |-
              **object** (map<**string**, **[Attribute](/docs/iam/api-ref/UserAccount/get#yandex.cloud.iam.v1.SamlUserAccount.Attribute)**>)
              Additional attributes of the SAML federated user.
            type: object
            additionalProperties:
              $ref: '#/definitions/Attribute'
        required:
          - federationId
          - nameId
      UserAccount:
        type: object
        properties:
          id:
            description: |-
              **string**
              ID of the user account.
            type: string
          yandexPassportUserAccount:
            description: |-
              **[YandexPassportUserAccount](/docs/iam/api-ref/UserAccount/get#yandex.cloud.iam.v1.YandexPassportUserAccount)**
              A YandexPassportUserAccount resource.
              Includes only one of the fields `yandexPassportUserAccount`, `samlUserAccount`.
            $ref: '#/definitions/YandexPassportUserAccount'
          samlUserAccount:
            description: |-
              **[SamlUserAccount](/docs/iam/api-ref/UserAccount/get#yandex.cloud.iam.v1.SamlUserAccount)**
              A SAML federated user.
              Includes only one of the fields `yandexPassportUserAccount`, `samlUserAccount`.
            $ref: '#/definitions/SamlUserAccount'
          lastAuthenticatedAt:
            description: |-
              **string** (date-time)
              String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
              `0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.
              To work with values in this field, use the APIs described in the
              [Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
              In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).
            type: string
            format: date-time
        oneOf:
          - required:
              - yandexPassportUserAccount
          - required:
              - samlUserAccount
      ServiceAccount:
        type: object
        properties:
          id:
            description: |-
              **string**
              ID of the service account.
            type: string
          folderId:
            description: |-
              **string**
              ID of the folder that the service account belongs to.
            type: string
          createdAt:
            description: |-
              **string** (date-time)
              Creation timestamp.
              String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
              `0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.
              To work with values in this field, use the APIs described in the
              [Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
              In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).
            type: string
            format: date-time
          name:
            description: |-
              **string**
              Name of the service account.
              The name is unique within the cloud. 3-63 characters long.
            type: string
          description:
            description: |-
              **string**
              Description of the service account. 0-256 characters long.
            type: string
          labels:
            description: |-
              **object** (map<**string**, **string**>)
              Resource labels as `` key:value `` pairs. Maximum of 64 per resource.
            type: object
            additionalProperties:
              type: string
          lastAuthenticatedAt:
            description: |-
              **string** (date-time)
              Timestamp for the last authentication of this service account.
              String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
              `0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.
              To work with values in this field, use the APIs described in the
              [Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
              In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).
            type: string
            format: date-time
          status:
            description: |-
              **enum** (Status)
              Current status of the service account.
              Determines whether the service account can authenticate and access the system.
              - `CREATING`: OAuth client is being created.
              - `ACTIVE`: OAuth client is active.
              - `DELETING`: OAuth client is being deleted.
            type: string
            enum:
              - STATUS_UNSPECIFIED
              - CREATING
              - ACTIVE
              - DELETING
          expiresAt:
            description: |-
              **string** (date-time)
              Timestamp when the service account expires.
              String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
              `0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.
              To work with values in this field, use the APIs described in the
              [Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
              In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).
            type: string
            format: date-time
      Invitee:
        type: object
        properties:
          email:
            description: |-
              **string**
              E-mail address of the invitee.
            type: string
          preferredUsername:
            description: |-
              **string**
              Preferred username of the invitee.
            type: string
      Subject:
        type: object
        properties:
          sub:
            description: |-
              **string**
              Required field. Subject - Identifier for the End-User at the Issuer.
              The maximum string length in characters is 100.
            type: string
          type:
            description: |-
              **enum** (SubjectType)
              Required field. Subject type.
              - `USER_ACCOUNT`: User account subject.
              - `SERVICE_ACCOUNT`: Service account subject.
              - `GROUP`: Group subject.
              - `INVITEE`: Invitee subject.
            type: string
            enum:
              - SUBJECT_TYPE_UNSPECIFIED
              - USER_ACCOUNT
              - SERVICE_ACCOUNT
              - GROUP
              - INVITEE
          createdAt:
            description: |-
              **string** (date-time)
              Creation time
              String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
              `0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.
              To work with values in this field, use the APIs described in the
              [Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
              In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).
            type: string
            format: date-time
          status:
            description: |-
              **enum** (SubjectStatus)
              Status
              - `ACTIVE`: Subject is active.
              - `SUSPENDED`: Subject is suspended.
            type: string
            enum:
              - SUBJECT_STATUS_UNSPECIFIED
              - ACTIVE
              - SUSPENDED
          name:
            description: |-
              **string**
              End-User's full name in displayable form including all name parts, possibly including titles and suffixes, ordered according to the End-User's locale and preferences.
            type: string
          lastAuthenticatedAt:
            description: |-
              **string** (date-time)
              Last time the access token was created. Filled only for federated users (not for global users).
              String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
              `0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.
              To work with values in this field, use the APIs described in the
              [Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
              In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).
            type: string
            format: date-time
          groups:
            description: |-
              **`Group`**
              Groups to which the subject belongs
            type: array
            items:
              $ref: '#/definitions/Group'
          userAccount:
            description: |-
              **`UserAccount`**
              Details of a user account subject. Set when the subject is a user account.
              Includes only one of the fields `userAccount`, `serviceAccount`, `group`, `invitee`.
              Subject type-specific details.
            $ref: '#/definitions/UserAccount'
          serviceAccount:
            description: |-
              **`ServiceAccount`**
              Details of a service account subject. Set when the subject is a service account.
              Includes only one of the fields `userAccount`, `serviceAccount`, `group`, `invitee`.
              Subject type-specific details.
            $ref: '#/definitions/ServiceAccount'
          group:
            description: |-
              **`Group`**
              Details of a group subject. Set when the subject is a group.
              Includes only one of the fields `userAccount`, `serviceAccount`, `group`, `invitee`.
              Subject type-specific details.
            $ref: '#/definitions/Group'
          invitee:
            description: |-
              **`Invitee`**
              Details of an invitee subject. Set when the subject is an invitee.
              Includes only one of the fields `userAccount`, `serviceAccount`, `group`, `invitee`.
              Subject type-specific details.
            $ref: '#/definitions/Invitee'
          externalId:
            description: |-
              **string**
              Subject id in external container
            type: string
        required:
          - sub
          - type
        oneOf:
          - required:
              - userAccount
          - required:
              - serviceAccount
          - required:
              - group
          - required:
              - invitee
      AccessBinding:
        type: object
        properties:
          roleId:
            description: |-
              **string**
              Required field. ID of the [yandex.cloud.iam.v1.Role](/docs/iam/api-ref/Role/get#yandex.cloud.iam.v1.Role) that is assigned to the [subject](#yandex.cloud.access.AccessBinding).
              The maximum string length in characters is 64.
            type: string
          subject:
            description: |-
              **[Subject](#yandex.cloud.access.Subject)**
              Required field. Identity for which access binding is being created.
              It can represent an account with a unique ID or several accounts with a system identifier.
            $ref: '#/definitions/Subject'
        required:
          - roleId
          - subject
---

# Identity and Access Management API, REST: ServiceAccount.SetAccessBindings

Sets access bindings for the service account.

## HTTP request

```
POST https://iam.{{ api-host }}/iam/v1/serviceAccounts/{resourceId}:setAccessBindings
```

## Path parameters

#|
||Field | Description ||
|| resourceId | **string**

Required field. ID of the resource for which access bindings are being set.
To get the resource ID, use a corresponding List request.

The maximum string length in characters is 64. ||
|#

## Body parameters {#yandex.cloud.access.SetAccessBindingsRequest}

```json
{
  "accessBindings": [
    {
      "roleId": "string",
      "subject": {
        "id": "string",
        "type": "string"
      }
    }
  ]
}
```

#|
||Field | Description ||
|| accessBindings[] | **[AccessBinding](#yandex.cloud.access.AccessBinding)**

Access bindings to be set. For more information, see [Access Bindings](/docs/iam/concepts/access-control/#access-bindings).

The maximum number of elements is 1000. ||
|#

## AccessBinding {#yandex.cloud.access.AccessBinding}

#|
||Field | Description ||
|| roleId | **string**

Required field. ID of the [yandex.cloud.iam.v1.Role](/docs/iam/api-ref/Role/get#yandex.cloud.iam.v1.Role) that is assigned to the `subject`.

The maximum string length in characters is 64. ||
|| subject | **[Subject](#yandex.cloud.access.Subject)**

Required field. Identity for which access binding is being created.
It can represent an account with a unique ID or several accounts with a system identifier. ||
|#

## Subject {#yandex.cloud.access.Subject}

#|
||Field | Description ||
|| id | **string**

Required field. ID of the subject.
It can contain one of the following values:oauth
* `allAuthenticatedUsers`: A special public group that represents anyone
who is authenticated. It can be used only if the `type` is `system`.
* `allUsers`: A special public group that represents anyone. No authentication is required.
For example, you don't need to specify the IAM token in an API query.
It can be used only if the `type` is `system`.
* `group:organization:<id>:users`: A special system group that represents all members of organization
with given &lt;id&gt;. It can be used only if the `type` is `system`.
* `group:federation:<id>:users`: A special system group that represents all users of federation
with given &lt;id&gt;. It can be used only if the `type` is `system`.
* `<cloud generated id>`: An identifier that represents a user account.
It can be used only if the `type` is `userAccount`, `federatedUser` or `serviceAccount`.

The maximum string length in characters is 100. ||
|| type | **string**

Required field. Type of the subject.
It can contain one of the following values:
* `userAccount`: An account on Yandex or Yandex Connect, added to Yandex Cloud.
* `serviceAccount`: A service account. This type represents the [yandex.cloud.iam.v1.ServiceAccount](/docs/iam/api-ref/ServiceAccount/get#yandex.cloud.iam.v1.ServiceAccount) resource.
* `federatedUser`: A federated account. This type represents a user from an identity federation, like Active Directory.
* `system`: System group. This type represents several accounts with a common system identifier.
For more information, see [Subject to which the role is assigned](/docs/iam/concepts/access-control/#subject).

The maximum string length in characters is 100. ||
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
  "metadata": "object",
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": "object"
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
|| metadata | **object**

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
|| response | **object**

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