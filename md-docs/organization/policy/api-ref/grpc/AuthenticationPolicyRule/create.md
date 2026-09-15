[Документация Yandex Cloud](../../../../../index.md) > [Yandex Identity Hub](../../../../index.md) > Справочник API > gRPC (англ.) > [Organization Policy API](../index.md) > [AuthenticationPolicyRule](index.md) > Create

# Organization Policy API, gRPC: AuthenticationPolicyRuleService.Create

Creates an authentication policy rule in the specified organization.

## gRPC request

**rpc Create ([CreateRuleRequest](#yandex.cloud.organizationmanager.v1.policy.CreateRuleRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## CreateRuleRequest {#yandex.cloud.organizationmanager.v1.policy.CreateRuleRequest}

```json
{
  "organization_id": "string",
  "name": "string",
  "description": "string",
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
  "labels": "map<string, string>"
}
```

#|
||Field | Description ||
|| organization_id | **string**

Required field. ID of organization to create the authentication policy rule for.

The maximum string length in characters is 50. ||
|| name | **string**

Required field. Name of the authentication policy rule to create.
The name must be unique within the organization and contain 1-63 characters.

Value must match the regular expression ` [a-z]([-a-z0-9]{0,61}[a-z0-9])? `. ||
|| description | **string**

Description of the authentication policy rule to create. 0-256 characters long.

The maximum string length in characters is 256. ||
|| effect | enum **Effect**

Effect to apply when the rule matches.

- `ALLOW_WITH_OBLIGATIONS`: Allow authentication provided the obligations in [AuthenticationPolicyRule.obligations](get.md#yandex.cloud.organizationmanager.v1.policy.AuthenticationPolicyRule) are satisfied.
- `DENY`: Deny authentication. ||
|| obligations[] | **[Obligation](#yandex.cloud.organizationmanager.v1.policy.Obligation)**

Obligations to satisfy when the effect is ALLOW_WITH_OBLIGATIONS.

The maximum number of elements is 5. ||
|| subjects_include[] | **string**

List of IDs of subjects to be affected by the authentication policy rule to create.
Empty list will match all subjects and is functionally equal to ["allUsers"].

The maximum string length in characters for each value is 64. The maximum number of elements is 64. ||
|| subjects_exclude[] | **string**

List of IDs of subjects not to be affected by the authentication policy rule to create.
Empty list will match no subjects.

The maximum string length in characters for each value is 64. The maximum number of elements is 64. ||
|| networks_include[] | **string**

Source IP ranges in CIDR notation that the authentication policy rule applies to.
Empty list will match any source and is functionally equal to ["0.0.0.0/0", "::0/0"].

The maximum string length in characters for each value is 64. The maximum number of elements is 64. ||
|| networks_exclude[] | **string**

Source IP ranges in CIDR notation excluded from the authentication policy rule.
Empty list will match no sources.

The maximum string length in characters for each value is 64. The maximum number of elements is 64. ||
|| applications_exclude[] | **string**

List of IDs of applications not to be affected by the authentication policy rule to create.
Empty list will match no applications.

The maximum string length in characters for each value is 64. The maximum number of elements is 64. ||
|| applications_include[] | **string**

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

## operation.Operation {#yandex.cloud.operation.Operation}

```json
{
  "id": "string",
  "description": "string",
  "created_at": "google.protobuf.Timestamp",
  "created_by": "string",
  "modified_at": "google.protobuf.Timestamp",
  "done": "bool",
  "metadata": "google.protobuf.Any",
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": "google.protobuf.Any"
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](../../../../../api-design-guide/concepts/operation.md).

#|
||Field | Description ||
|| id | **string**

ID of the operation. ||
|| description | **string**

Description of the operation. 0-256 characters long. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| created_by | **string**

ID of the user or service account who initiated the operation. ||
|| modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**

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