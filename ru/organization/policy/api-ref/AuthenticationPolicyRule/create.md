---
editable: false
apiPlayground:
  - url: https://organization-manager.{{ api-host }}/organization-manager/v1/policy/authenticationPolicyRules
    method: post
    path: null
    query: null
    body:
      type: object
      properties:
        organizationId:
          description: |-
            **string**
            Required field. ID of organization to create the authentication policy rule for.
            The maximum string length in characters is 50.
          type: string
        name:
          description: |-
            **string**
            Required field. Name of the authentication policy rule to create.
            The name must be unique within the organization and contain 1-63 characters.
            Value must match the regular expression ` [a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
          pattern: '[a-z]([-a-z0-9]{0,61}[a-z0-9])?'
          type: string
        description:
          description: |-
            **string**
            Description of the authentication policy rule to create. 0-256 characters long.
            The maximum string length in characters is 256.
          type: string
        effect:
          description: |-
            **enum** (Effect)
            Effect to apply when the rule matches.
            - `ALLOW_WITH_OBLIGATIONS`: Allow authentication provided the obligations in [AuthenticationPolicyRule.obligations](/docs/organization/policy/api-ref/AuthenticationPolicyRule/get#yandex.cloud.organizationmanager.v1.policy.AuthenticationPolicyRule) are satisfied.
            - `DENY`: Deny authentication.
          type: string
          enum:
            - EFFECT_UNSPECIFIED
            - ALLOW_WITH_OBLIGATIONS
            - DENY
        obligations:
          description: |-
            **[Obligation](#yandex.cloud.organizationmanager.v1.policy.Obligation)**
            Obligations to satisfy when the effect is ALLOW_WITH_OBLIGATIONS.
            The maximum number of elements is 5.
          type: array
          items:
            $ref: '#/definitions/Obligation'
        subjectsInclude:
          description: |-
            **string**
            List of IDs of subjects to be affected by the authentication policy rule to create.
            Empty list will match all subjects and is functionally equal to ["allUsers"].
            The maximum string length in characters for each value is 64. The maximum number of elements is 64.
          type: array
          items:
            type: string
        subjectsExclude:
          description: |-
            **string**
            List of IDs of subjects not to be affected by the authentication policy rule to create.
            Empty list will match no subjects.
            The maximum string length in characters for each value is 64. The maximum number of elements is 64.
          type: array
          items:
            type: string
        networksInclude:
          description: |-
            **string**
            Source IP ranges in CIDR notation that the authentication policy rule applies to.
            Empty list will match any source and is functionally equal to ["0.0.0.0/0", "::0/0"].
            The maximum string length in characters for each value is 64. The maximum number of elements is 64.
          type: array
          items:
            type: string
        networksExclude:
          description: |-
            **string**
            Source IP ranges in CIDR notation excluded from the authentication policy rule.
            Empty list will match no sources.
            The maximum string length in characters for each value is 64. The maximum number of elements is 64.
          type: array
          items:
            type: string
        applicationsExclude:
          description: |-
            **string**
            List of IDs of applications not to be affected by the authentication policy rule to create.
            Empty list will match no applications.
            The maximum string length in characters for each value is 64. The maximum number of elements is 64.
          type: array
          items:
            type: string
        applicationsInclude:
          description: |-
            **string**
            List of IDs of applications to be affected by the authentication policy rule to create.
            Empty list will match all applications.
            The maximum string length in characters for each value is 64. The maximum number of elements is 64.
          type: array
          items:
            type: string
        labels:
          description: |-
            **object** (map<**string**, **string**>)
            Labels of the authentication policy rule.
            The maximum string length in characters for each value is 63. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `. Each value must match the regular expression ` [-_0-9a-z]* `. No more than 64 per resource.
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
        - organizationId
        - name
      additionalProperties: false
    definitions:
      StepUpRequired:
        type: object
        properties:
          acrId:
            description: |-
              **string**
              Required field. ACR ID required to satisfy this obligation.
              The maximum string length in characters is 50.
            type: string
          ttl:
            description: |-
              **string** (duration)
              Required field. Maximum age of a factor verification that can satisfy this obligation.
            type: string
            format: duration
        required:
          - acrId
          - ttl
      SkipMfa:
        type: object
        properties:
          requireOnce:
            description: |-
              **boolean**
              If true, the organization's current MFA requirements must have been satisfied at least once
              during the current session.
            type: boolean
      ReauthenticationRequired:
        type: object
        properties:
          ttl:
            description: |-
              **string** (duration)
              Required field. Maximum age of an authentication that can satisfy this obligation.
            type: string
            format: duration
        required:
          - ttl
      Obligation:
        type: object
        properties:
          stepUpRequired:
            description: |-
              **[StepUpRequired](#yandex.cloud.organizationmanager.v1.policy.StepUpRequired)**
              Require step-up authentication.
              Includes only one of the fields `stepUpRequired`, `skipMfa`, `reauthenticationRequired`.
            $ref: '#/definitions/StepUpRequired'
          skipMfa:
            description: |-
              **[SkipMfa](#yandex.cloud.organizationmanager.v1.policy.SkipMfa)**
              Allow skipping the organization's current MFA requirements.
              Includes only one of the fields `stepUpRequired`, `skipMfa`, `reauthenticationRequired`.
            $ref: '#/definitions/SkipMfa'
          reauthenticationRequired:
            description: |-
              **[ReauthenticationRequired](#yandex.cloud.organizationmanager.v1.policy.ReauthenticationRequired)**
              Require full authentication again.
              Includes only one of the fields `stepUpRequired`, `skipMfa`, `reauthenticationRequired`.
            $ref: '#/definitions/ReauthenticationRequired'
        oneOf:
          - required:
              - stepUpRequired
          - required:
              - skipMfa
          - required:
              - reauthenticationRequired
---

# Organization Policy API, REST: AuthenticationPolicyRule.Create

Creates an authentication policy rule in the specified organization.

## HTTP request

```
POST https://organization-manager.{{ api-host }}/organization-manager/v1/policy/authenticationPolicyRules
```

## Body parameters {#yandex.cloud.organizationmanager.v1.policy.CreateRuleRequest}

```json
{
  "organizationId": "string",
  "name": "string",
  "description": "string",
  "effect": "string",
  "obligations": [
    {
      // Includes only one of the fields `stepUpRequired`, `skipMfa`, `reauthenticationRequired`
      "stepUpRequired": {
        "acrId": "string",
        "ttl": "string"
      },
      "skipMfa": {
        "requireOnce": "boolean"
      },
      "reauthenticationRequired": {
        "ttl": "string"
      }
      // end of the list of possible fields
    }
  ],
  "subjectsInclude": [
    "string"
  ],
  "subjectsExclude": [
    "string"
  ],
  "networksInclude": [
    "string"
  ],
  "networksExclude": [
    "string"
  ],
  "applicationsExclude": [
    "string"
  ],
  "applicationsInclude": [
    "string"
  ],
  "labels": "object"
}
```

#|
||Field | Description ||
|| organizationId | **string**

Required field. ID of organization to create the authentication policy rule for.

The maximum string length in characters is 50. ||
|| name | **string**

Required field. Name of the authentication policy rule to create.
The name must be unique within the organization and contain 1-63 characters.

Value must match the regular expression ` [a-z]([-a-z0-9]{0,61}[a-z0-9])? `. ||
|| description | **string**

Description of the authentication policy rule to create. 0-256 characters long.

The maximum string length in characters is 256. ||
|| effect | **enum** (Effect)

Effect to apply when the rule matches.

- `ALLOW_WITH_OBLIGATIONS`: Allow authentication provided the obligations in [AuthenticationPolicyRule.obligations](/docs/organization/policy/api-ref/AuthenticationPolicyRule/get#yandex.cloud.organizationmanager.v1.policy.AuthenticationPolicyRule) are satisfied.
- `DENY`: Deny authentication. ||
|| obligations[] | **[Obligation](#yandex.cloud.organizationmanager.v1.policy.Obligation)**

Obligations to satisfy when the effect is ALLOW_WITH_OBLIGATIONS.

The maximum number of elements is 5. ||
|| subjectsInclude[] | **string**

List of IDs of subjects to be affected by the authentication policy rule to create.
Empty list will match all subjects and is functionally equal to ["allUsers"].

The maximum string length in characters for each value is 64. The maximum number of elements is 64. ||
|| subjectsExclude[] | **string**

List of IDs of subjects not to be affected by the authentication policy rule to create.
Empty list will match no subjects.

The maximum string length in characters for each value is 64. The maximum number of elements is 64. ||
|| networksInclude[] | **string**

Source IP ranges in CIDR notation that the authentication policy rule applies to.
Empty list will match any source and is functionally equal to ["0.0.0.0/0", "::0/0"].

The maximum string length in characters for each value is 64. The maximum number of elements is 64. ||
|| networksExclude[] | **string**

Source IP ranges in CIDR notation excluded from the authentication policy rule.
Empty list will match no sources.

The maximum string length in characters for each value is 64. The maximum number of elements is 64. ||
|| applicationsExclude[] | **string**

List of IDs of applications not to be affected by the authentication policy rule to create.
Empty list will match no applications.

The maximum string length in characters for each value is 64. The maximum number of elements is 64. ||
|| applicationsInclude[] | **string**

List of IDs of applications to be affected by the authentication policy rule to create.
Empty list will match all applications.

The maximum string length in characters for each value is 64. The maximum number of elements is 64. ||
|| labels | **object** (map<**string**, **string**>)

Labels of the authentication policy rule.

The maximum string length in characters for each value is 63. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `. Each value must match the regular expression ` [-_0-9a-z]* `. No more than 64 per resource. ||
|#

## Obligation {#yandex.cloud.organizationmanager.v1.policy.Obligation}

#|
||Field | Description ||
|| stepUpRequired | **[StepUpRequired](#yandex.cloud.organizationmanager.v1.policy.StepUpRequired)**

Require step-up authentication.

Includes only one of the fields `stepUpRequired`, `skipMfa`, `reauthenticationRequired`. ||
|| skipMfa | **[SkipMfa](#yandex.cloud.organizationmanager.v1.policy.SkipMfa)**

Allow skipping the organization's current MFA requirements.

Includes only one of the fields `stepUpRequired`, `skipMfa`, `reauthenticationRequired`. ||
|| reauthenticationRequired | **[ReauthenticationRequired](#yandex.cloud.organizationmanager.v1.policy.ReauthenticationRequired)**

Require full authentication again.

Includes only one of the fields `stepUpRequired`, `skipMfa`, `reauthenticationRequired`. ||
|#

## StepUpRequired {#yandex.cloud.organizationmanager.v1.policy.StepUpRequired}

#|
||Field | Description ||
|| acrId | **string**

Required field. ACR ID required to satisfy this obligation.

The maximum string length in characters is 50. ||
|| ttl | **string** (duration)

Required field. Maximum age of a factor verification that can satisfy this obligation. ||
|#

## SkipMfa {#yandex.cloud.organizationmanager.v1.policy.SkipMfa}

#|
||Field | Description ||
|| requireOnce | **boolean**

If true, the organization's current MFA requirements must have been satisfied at least once
during the current session. ||
|#

## ReauthenticationRequired {#yandex.cloud.organizationmanager.v1.policy.ReauthenticationRequired}

#|
||Field | Description ||
|| ttl | **string** (duration)

Required field. Maximum age of an authentication that can satisfy this obligation. ||
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