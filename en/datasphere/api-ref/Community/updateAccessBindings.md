---
editable: false
apiPlayground:
  - url: https://datasphere.{{ api-host }}/datasphere/v2/communities/{resourceId}:updateAccessBindings
    method: patch
    path:
      type: object
      properties:
        resourceId:
          description: |-
            **string**
            Required field. ID of the resource for which access bindings are being updated.
          type: string
      required:
        - resourceId
      additionalProperties: false
    query: null
    body:
      type: object
      properties:
        accessBindingDeltas:
          description: |-
            **[AccessBindingDelta](#yandex.cloud.access.AccessBindingDelta)**
            Updates to access bindings.
          type: array
          items:
            $ref: '#/definitions/AccessBindingDelta'
      additionalProperties: false
    definitions:
      Subject:
        type: object
        properties:
          id:
            description: |-
              **string**
              Required field. ID of the subject.
              It can contain one of the following values:
              * `allAuthenticatedUsers`: A special public group that represents anyone
              who is authenticated. It can be used only if the [type](#yandex.cloud.access.Subject) is `system`.
              * `allUsers`: A special public group that represents anyone. No authentication is required.
              For example, you don't need to specify the IAM token in an API query.
              It can be used only if the [type](#yandex.cloud.access.Subject) is `system`.
              * `group:organization:<id>:users`: A special system group that represents all members of organization
              with given &lt;id&gt;. It can be used only if the [type](#yandex.cloud.access.Subject) is `system`.
              * `group:federation:<id>:users`: A special system group that represents all users of federation
              with given &lt;id&gt;. It can be used only if the [type](#yandex.cloud.access.Subject) is `system`.
              * `<cloud generated id>`: An identifier that represents a user account.
              It can be used only if the [type](#yandex.cloud.access.Subject) is `userAccount`, `federatedUser` or `serviceAccount`.
            type: string
          type:
            description: |-
              **string**
              Required field. Type of the subject.
              It can contain one of the following values:
              * `userAccount`: An account on Yandex or Yandex Connect, added to Yandex Cloud.
              * `serviceAccount`: A service account. This type represents the [yandex.cloud.iam.v1.ServiceAccount](/docs/iam/api-ref/ServiceAccount/get#yandex.cloud.iam.v1.ServiceAccount) resource.
              * `federatedUser`: A federated account. This type represents a user from an identity federation, like Active Directory.
              * `system`: System group. This type represents several accounts with a common system identifier.
              For more information, see [Subject to which the role is assigned](/docs/iam/concepts/access-control/#subject).
            type: string
        required:
          - id
          - type
      AccessBinding:
        type: object
        properties:
          roleId:
            description: |-
              **string**
              Required field. ID of the [yandex.cloud.iam.v1.Role](/docs/iam/api-ref/Role/get#yandex.cloud.iam.v1.Role) that is assigned to the [subject](#yandex.cloud.access.AccessBinding).
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
      AccessBindingDelta:
        type: object
        properties:
          action:
            description: |-
              **enum** (AccessBindingAction)
              Required field. The action that is being performed on an access binding.
              - `ACCESS_BINDING_ACTION_UNSPECIFIED`
              - `ADD`: Addition of an access binding.
              - `REMOVE`: Removal of an access binding.
            type: string
            enum:
              - ACCESS_BINDING_ACTION_UNSPECIFIED
              - ADD
              - REMOVE
          accessBinding:
            description: |-
              **[AccessBinding](#yandex.cloud.access.AccessBinding)**
              Required field. Access binding. For more information, see [Access Bindings](/docs/iam/concepts/access-control/#access-bindings).
            $ref: '#/definitions/AccessBinding'
        required:
          - action
          - accessBinding
sourcePath: en/_api-ref/datasphere/v2/api-ref/Community/updateAccessBindings.md
---

# DataSphere API v2, REST: Community.UpdateAccessBindings

Updates access bindings for specified community.

## HTTP request

```
PATCH https://datasphere.{{ api-host }}/datasphere/v2/communities/{resourceId}:updateAccessBindings
```

## Path parameters

#|
||Field | Description ||
|| resourceId | **string**

Required field. ID of the resource for which access bindings are being updated. ||
|#

## Body parameters {#yandex.cloud.access.UpdateAccessBindingsRequest}

```json
{
  "accessBindingDeltas": [
    {
      "action": "string",
      "accessBinding": {
        "roleId": "string",
        "subject": {
          "id": "string",
          "type": "string"
        }
      }
    }
  ]
}
```

#|
||Field | Description ||
|| accessBindingDeltas[] | **[AccessBindingDelta](#yandex.cloud.access.AccessBindingDelta)**

Updates to access bindings. ||
|#

## AccessBindingDelta {#yandex.cloud.access.AccessBindingDelta}

#|
||Field | Description ||
|| action | **enum** (AccessBindingAction)

Required field. The action that is being performed on an access binding.

- `ACCESS_BINDING_ACTION_UNSPECIFIED`
- `ADD`: Addition of an access binding.
- `REMOVE`: Removal of an access binding. ||
|| accessBinding | **[AccessBinding](#yandex.cloud.access.AccessBinding)**

Required field. Access binding. For more information, see [Access Bindings](/docs/iam/concepts/access-control/#access-bindings). ||
|#

## AccessBinding {#yandex.cloud.access.AccessBinding}

#|
||Field | Description ||
|| roleId | **string**

Required field. ID of the [yandex.cloud.iam.v1.Role](/docs/iam/api-ref/Role/get#yandex.cloud.iam.v1.Role) that is assigned to the `subject`. ||
|| subject | **[Subject](#yandex.cloud.access.Subject)**

Required field. Identity for which access binding is being created.
It can represent an account with a unique ID or several accounts with a system identifier. ||
|#

## Subject {#yandex.cloud.access.Subject}

#|
||Field | Description ||
|| id | **string**

Required field. ID of the subject.

It can contain one of the following values:
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
It can be used only if the `type` is `userAccount`, `federatedUser` or `serviceAccount`. ||
|| type | **string**

Required field. Type of the subject.

It can contain one of the following values:
* `userAccount`: An account on Yandex or Yandex Connect, added to Yandex Cloud.
* `serviceAccount`: A service account. This type represents the [yandex.cloud.iam.v1.ServiceAccount](/docs/iam/api-ref/ServiceAccount/get#yandex.cloud.iam.v1.ServiceAccount) resource.
* `federatedUser`: A federated account. This type represents a user from an identity federation, like Active Directory.
* `system`: System group. This type represents several accounts with a common system identifier.

For more information, see [Subject to which the role is assigned](/docs/iam/concepts/access-control/#subject). ||
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
    "communityId": "string"
  },
  // Includes only one of the fields `error`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
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
|| metadata | **[UpdateCommunityAccessBindingsMetadata](#yandex.cloud.datasphere.v2.UpdateCommunityAccessBindingsMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[Status](#google.rpc.Status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|#

## UpdateCommunityAccessBindingsMetadata {#yandex.cloud.datasphere.v2.UpdateCommunityAccessBindingsMetadata}

#|
||Field | Description ||
|| communityId | **string**

ID of the community which access bindings are updated. ||
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