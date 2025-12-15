---
editable: false
sourcePath: en/_api-ref-grpc/organizationmanager/v1/api-ref/grpc/MfaEnforcement/get.md
---

# Identity Hub API, gRPC: MfaEnforcementService.Get

returns the specified MFA enforcement

## gRPC request

**rpc Get ([GetMfaEnforcementRequest](#yandex.cloud.organizationmanager.v1.GetMfaEnforcementRequest)) returns ([MfaEnforcement](#yandex.cloud.organizationmanager.v1.MfaEnforcement))**

## GetMfaEnforcementRequest {#yandex.cloud.organizationmanager.v1.GetMfaEnforcementRequest}

```json
{
  "mfa_enforcement_id": "string"
}
```

#|
||Field | Description ||
|| mfa_enforcement_id | **string**

Required field. id of the MFA enforcement

The maximum string length in characters is 50. ||
|#

## MfaEnforcement {#yandex.cloud.organizationmanager.v1.MfaEnforcement}

```json
{
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
```

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