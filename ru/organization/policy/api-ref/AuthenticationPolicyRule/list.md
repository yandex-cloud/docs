---
editable: false
apiPlayground:
  - url: https://organization-manager.{{ api-host }}/organization-manager/v1/policy/authenticationPolicyRules
    method: get
    path: null
    query:
      type: object
      properties:
        organizationId:
          description: |-
            **string**
            Required field. ID of the organization to list authentication policy rules for.
            The maximum string length in characters is 50.
          type: string
        pageSize:
          description: |-
            **string** (int64)
            Maximum number of authentication policy rules to return.
            Acceptable values are 0 to 1000, inclusive.
          type: string
          format: int64
        pageToken:
          description: |-
            **string**
            Page token returned in [ListRulesResponse.nextPageToken](#yandex.cloud.organizationmanager.v1.policy.ListRulesResponse) by a previous request.
            The maximum string length in characters is 2000.
          type: string
        filter:
          description: |-
            **string**
            Filter expression applied to the returned rules.
            Only [AuthenticationPolicyRule.name](#yandex.cloud.organizationmanager.v1.policy.AuthenticationPolicyRule) and [AuthenticationPolicyRule.id](#yandex.cloud.organizationmanager.v1.policy.AuthenticationPolicyRule) support filtering.
            The maximum string length in characters is 1000.
          type: string
      required:
        - organizationId
      additionalProperties: false
    body: null
    definitions: null
---

# Organization Policy API, REST: AuthenticationPolicyRule.List

Lists authentication policy rules in the specified organization.

## HTTP request

```
GET https://organization-manager.{{ api-host }}/organization-manager/v1/policy/authenticationPolicyRules
```

## Query parameters {#yandex.cloud.organizationmanager.v1.policy.ListRulesRequest}

#|
||Field | Description ||
|| organizationId | **string**

Required field. ID of the organization to list authentication policy rules for.

The maximum string length in characters is 50. ||
|| pageSize | **string** (int64)

Maximum number of authentication policy rules to return.

Acceptable values are 0 to 1000, inclusive. ||
|| pageToken | **string**

Page token returned in [ListRulesResponse.nextPageToken](#yandex.cloud.organizationmanager.v1.policy.ListRulesResponse) by a previous request.

The maximum string length in characters is 2000. ||
|| filter | **string**

Filter expression applied to the returned rules.
Only [AuthenticationPolicyRule.name](#yandex.cloud.organizationmanager.v1.policy.AuthenticationPolicyRule) and [AuthenticationPolicyRule.id](#yandex.cloud.organizationmanager.v1.policy.AuthenticationPolicyRule) support filtering.

The maximum string length in characters is 1000. ||
|#

## Response {#yandex.cloud.organizationmanager.v1.policy.ListRulesResponse}

**HTTP Code: 200 - OK**

```json
{
  "authPolicyRules": [
    {
      "id": "string",
      "name": "string",
      "description": "string",
      "organizationId": "string",
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
      "createdAt": "string",
      "updatedAt": "string",
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
      "status": "string",
      "labels": "object"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| authPolicyRules[] | **[AuthenticationPolicyRule](#yandex.cloud.organizationmanager.v1.policy.AuthenticationPolicyRule)**

Authentication policy rules matching the request. ||
|| nextPageToken | **string**

Token to retrieve the next page of results.
Pass this value in `ListRulesRequest.page_token`. ||
|#

## AuthenticationPolicyRule {#yandex.cloud.organizationmanager.v1.policy.AuthenticationPolicyRule}

#|
||Field | Description ||
|| id | **string**

ID of the authentication policy rule. ||
|| name | **string**

Name of the authentication policy rule.
The name is unique within the organization and contains 1-63 characters. ||
|| description | **string**

Description of an authentication policy rule. 0-256 characters long. ||
|| organizationId | **string**

ID of the organization that the authentication policy rule belongs to. ||
|| effect | **enum** (Effect)

Effect to apply when the rule matches.

- `ALLOW_WITH_OBLIGATIONS`: Allow authentication provided the obligations in `AuthenticationPolicyRule.obligations` are satisfied.
- `DENY`: Deny authentication. ||
|| obligations[] | **[Obligation](#yandex.cloud.organizationmanager.v1.policy.Obligation)**

Obligations to satisfy when the effect is ALLOW_WITH_OBLIGATIONS. ||
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
|| subjectsInclude[] | **string**

List of IDs of subjects affected by the authentication policy rule.
Empty list matches all subjects and is functionally equal to ["allUsers"]. ||
|| subjectsExclude[] | **string**

List of IDs of subjects not affected by the authentication policy rule.
Empty list matches no subjects. ||
|| networksInclude[] | **string**

Source IP ranges in CIDR notation that the authentication policy rule applies to.
Empty list matches any source and is functionally equal to ["0.0.0.0/0", "::0/0"]. ||
|| networksExclude[] | **string**

Source IP ranges in CIDR notation excluded from the authentication policy rule.
Empty list matches no sources. ||
|| applicationsExclude[] | **string**

List of IDs of applications not affected by the authentication policy rule.
Empty list matches no applications. ||
|| applicationsInclude[] | **string**

List of IDs of applications affected by the authentication policy rule.
Empty list matches all applications. ||
|| status | **enum** (Status)

Status of the authentication policy rule.

- `CREATING`: Authentication policy rule is being created.
- `ACTIVE`: Authentication policy rule is active.
- `INACTIVE`: Authentication policy rule is inactive and is not considered during authentication.
- `UPDATING`: Authentication policy rule is being updated.
- `DELETING`: Authentication policy rule is being deleted and might not be considered during authentication. ||
|| labels | **object** (map<**string**, **string**>)

Labels of the authentication policy rule. ||
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