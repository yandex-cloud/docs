[Документация Yandex Cloud](../../../../../index.md) > [Yandex Identity Hub](../../../../index.md) > Справочник API > gRPC (англ.) > [Organization Policy API](../index.md) > [AuthenticationPolicyRule](index.md) > List

# Organization Policy API, gRPC: AuthenticationPolicyRuleService.List

Lists authentication policy rules in the specified organization.

## gRPC request

**rpc List ([ListRulesRequest](#yandex.cloud.organizationmanager.v1.policy.ListRulesRequest)) returns ([ListRulesResponse](#yandex.cloud.organizationmanager.v1.policy.ListRulesResponse))**

## ListRulesRequest {#yandex.cloud.organizationmanager.v1.policy.ListRulesRequest}

```json
{
  "organization_id": "string",
  "page_size": "int64",
  "page_token": "string",
  "filter": "string"
}
```

#|
||Field | Description ||
|| organization_id | **string**

Required field. ID of the organization to list authentication policy rules for.

The maximum string length in characters is 50. ||
|| page_size | **int64**

Maximum number of authentication policy rules to return.

Acceptable values are 0 to 1000, inclusive. ||
|| page_token | **string**

Page token returned in [ListRulesResponse.next_page_token](#yandex.cloud.organizationmanager.v1.policy.ListRulesResponse) by a previous request.

The maximum string length in characters is 2000. ||
|| filter | **string**

Filter expression applied to the returned rules.
Only [AuthenticationPolicyRule.name](#yandex.cloud.organizationmanager.v1.policy.AuthenticationPolicyRule) and [AuthenticationPolicyRule.id](#yandex.cloud.organizationmanager.v1.policy.AuthenticationPolicyRule) support filtering.

The maximum string length in characters is 1000. ||
|#

## ListRulesResponse {#yandex.cloud.organizationmanager.v1.policy.ListRulesResponse}

```json
{
  "auth_policy_rules": [
    {
      "id": "string",
      "name": "string",
      "description": "string",
      "organization_id": "string",
      "effect": "Effect",
      "obligations": [
        {
          // Includes only one of the fields `step_up_required`, `skip_mfa`, `reauthentication_required`
          "step_up_required": {
            "acr_id": "string",
            "ttl": "google.protobuf.Duration"
          },
          "skip_mfa": {
            "require_once": "bool"
          },
          "reauthentication_required": {
            "ttl": "google.protobuf.Duration"
          }
          // end of the list of possible fields
        }
      ],
      "created_at": "google.protobuf.Timestamp",
      "updated_at": "google.protobuf.Timestamp",
      "subjects_include": [
        "string"
      ],
      "subjects_exclude": [
        "string"
      ],
      "networks_include": [
        "string"
      ],
      "networks_exclude": [
        "string"
      ],
      "applications_exclude": [
        "string"
      ],
      "applications_include": [
        "string"
      ],
      "status": "Status",
      "labels": "map<string, string>"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| auth_policy_rules[] | **[AuthenticationPolicyRule](#yandex.cloud.organizationmanager.v1.policy.AuthenticationPolicyRule)**

Authentication policy rules matching the request. ||
|| next_page_token | **string**

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
|| organization_id | **string**

ID of the organization that the authentication policy rule belongs to. ||
|| effect | enum **Effect**

Effect to apply when the rule matches.

- `ALLOW_WITH_OBLIGATIONS`: Allow authentication provided the obligations in `AuthenticationPolicyRule.obligations` are satisfied.
- `DENY`: Deny authentication. ||
|| obligations[] | **[Obligation](#yandex.cloud.organizationmanager.v1.policy.Obligation)**

Obligations to satisfy when the effect is ALLOW_WITH_OBLIGATIONS. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Modification timestamp. ||
|| subjects_include[] | **string**

List of IDs of subjects affected by the authentication policy rule.
Empty list matches all subjects and is functionally equal to ["allUsers"]. ||
|| subjects_exclude[] | **string**

List of IDs of subjects not affected by the authentication policy rule.
Empty list matches no subjects. ||
|| networks_include[] | **string**

Source IP ranges in CIDR notation that the authentication policy rule applies to.
Empty list matches any source and is functionally equal to ["0.0.0.0/0", "::0/0"]. ||
|| networks_exclude[] | **string**

Source IP ranges in CIDR notation excluded from the authentication policy rule.
Empty list matches no sources. ||
|| applications_exclude[] | **string**

List of IDs of applications not affected by the authentication policy rule.
Empty list matches no applications. ||
|| applications_include[] | **string**

List of IDs of applications affected by the authentication policy rule.
Empty list matches all applications. ||
|| status | enum **Status**

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
|| step_up_required | **[StepUpRequired](#yandex.cloud.organizationmanager.v1.policy.StepUpRequired)**

Require step-up authentication.

Includes only one of the fields `step_up_required`, `skip_mfa`, `reauthentication_required`. ||
|| skip_mfa | **[SkipMfa](#yandex.cloud.organizationmanager.v1.policy.SkipMfa)**

Allow skipping the organization's current MFA requirements.

Includes only one of the fields `step_up_required`, `skip_mfa`, `reauthentication_required`. ||
|| reauthentication_required | **[ReauthenticationRequired](#yandex.cloud.organizationmanager.v1.policy.ReauthenticationRequired)**

Require full authentication again.

Includes only one of the fields `step_up_required`, `skip_mfa`, `reauthentication_required`. ||
|#

## StepUpRequired {#yandex.cloud.organizationmanager.v1.policy.StepUpRequired}

#|
||Field | Description ||
|| acr_id | **string**

Required field. ACR ID required to satisfy this obligation.

The maximum string length in characters is 50. ||
|| ttl | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Required field. Maximum age of a factor verification that can satisfy this obligation. ||
|#

## SkipMfa {#yandex.cloud.organizationmanager.v1.policy.SkipMfa}

#|
||Field | Description ||
|| require_once | **bool**

If true, the organization's current MFA requirements must have been satisfied at least once
during the current session. ||
|#

## ReauthenticationRequired {#yandex.cloud.organizationmanager.v1.policy.ReauthenticationRequired}

#|
||Field | Description ||
|| ttl | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Required field. Maximum age of an authentication that can satisfy this obligation. ||
|#