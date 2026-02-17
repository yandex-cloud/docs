---
editable: false
---

# Identity Hub API, gRPC: MfaEnforcementService.Create

creates an MFA enforcement in the specified organization

## gRPC request

**rpc Create ([CreateMfaEnforcementRequest](#yandex.cloud.organizationmanager.v1.CreateMfaEnforcementRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## CreateMfaEnforcementRequest {#yandex.cloud.organizationmanager.v1.CreateMfaEnforcementRequest}

```json
{
  "organization_id": "string",
  "acr_id": "string",
  "ttl": "google.protobuf.Duration",
  "status": "Status",
  "apply_at": "google.protobuf.Timestamp",
  "enroll_window": "google.protobuf.Duration",
  "name": "string",
  "description": "string"
}
```

#|
||Field | Description ||
|| organization_id | **string**

Required field. organization id of the MFA enforcement

The maximum string length in characters is 50. ||
|| acr_id | **string**

Required field. acr id for the MFA enforcement. one of 'any-mfa' or 'phr',
specification https://yandex.cloud/en/docs/organization/concepts/mfa?utm_referrer=https%3A%2F%2Fa.yandex-team.ru%2F#mfa-factors

The maximum string length in characters is 50. ||
|| ttl | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Required field. the period during which the entered MFA factor will be considered valid and the
corresponding acr will be regarded as satisfied ||
|| status | enum **Status**

Required field. the MFA enforcement status

- `STATUS_ACTIVE`: active
- `STATUS_INACTIVE`: inactive ||
|| apply_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

the MFA enforcement application start time ||
|| enroll_window | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Required field. the MFA enforcement enroll window ||
|| name | **string**

Required field. the MFA enforcement name

Value must match the regular expression ` [a-z]([-a-z0-9]{0,61}[a-z0-9])? `. ||
|| description | **string**

the MFA enforcement description

The maximum string length in characters is 256. ||
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
  "metadata": {
    "organization_id": "string",
    "mfa_enforcement_id": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "string",
    "organization_id": "string",
    "acr_id": "string",
    "ttl": "google.protobuf.Duration",
    "status": "MfaEnforcementStatus",
    "apply_at": "google.protobuf.Timestamp",
    "enroll_window": "google.protobuf.Duration",
    "name": "string",
    "description": "string",
    "created_at": "google.protobuf.Timestamp"
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
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| created_by | **string**

ID of the user or service account who initiated the operation. ||
|| modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[CreateMfaEnforcementMetadata](#yandex.cloud.organizationmanager.v1.CreateMfaEnforcementMetadata)**

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
|| response | **[MfaEnforcement](#yandex.cloud.organizationmanager.v1.MfaEnforcement)**

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

## CreateMfaEnforcementMetadata {#yandex.cloud.organizationmanager.v1.CreateMfaEnforcementMetadata}

#|
||Field | Description ||
|| organization_id | **string**

organization id of the MFA enforcement ||
|| mfa_enforcement_id | **string**

id of the MFA enforcement ||
|#

## MfaEnforcement {#yandex.cloud.organizationmanager.v1.MfaEnforcement}

MFA enforcement resource

#|
||Field | Description ||
|| id | **string**

id of the MFA enforcement ||
|| organization_id | **string**

organization id of the MFA enforcement ||
|| acr_id | **string**

acr id of the MFA enforcement ||
|| ttl | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

the period during which the entered MFA factor is considered valid and the
corresponding acr is regarded as satisfied ||
|| status | enum **MfaEnforcementStatus**

MFA enforcement status

- `MFA_ENFORCEMENT_STATUS_ACTIVE`
- `MFA_ENFORCEMENT_STATUS_INACTIVE`
- `MFA_ENFORCEMENT_STATUS_DELETING` ||
|| apply_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

the MFA enforcement application start time. ||
|| enroll_window | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

the time window during which the user is allowed to create an MFA profile.
this window is measured relative to the MFA enforcement application start time
and the user's most recent successful authentication that falls under the rule
(or the user's creation time, if there has been no authentication). ||
|| name | **string**

name of the MFA enforcement ||
|| description | **string**

description of the MFA enforcement ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

creation timestamp ||
|#