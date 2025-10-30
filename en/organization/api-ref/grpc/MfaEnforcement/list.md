---
editable: false
sourcePath: en/_api-ref-grpc/organizationmanager/v1/api-ref/grpc/MfaEnforcement/list.md
---

# Identity Hub API, gRPC: MfaEnforcementService.List

## gRPC request

**rpc List ([ListMfaEnforcementsRequest](#yandex.cloud.organizationmanager.v1.ListMfaEnforcementsRequest)) returns ([ListMfaEnforcementsResponse](#yandex.cloud.organizationmanager.v1.ListMfaEnforcementsResponse))**

## ListMfaEnforcementsRequest {#yandex.cloud.organizationmanager.v1.ListMfaEnforcementsRequest}

```json
{
  "organization_id": "string",
  "page_size": "int64",
  "page_token": "string"
}
```

#|
||Field | Description ||
|| organization_id | **string**

Required field.  ||
|| page_size | **int64** ||
|| page_token | **string** ||
|#

## ListMfaEnforcementsResponse {#yandex.cloud.organizationmanager.v1.ListMfaEnforcementsResponse}

```json
{
  "mfa_enforcements": [
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
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| mfa_enforcements[] | **[MfaEnforcement](#yandex.cloud.organizationmanager.v1.MfaEnforcement)** ||
|| next_page_token | **string** ||
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

- `MFA_ENFORCEMENT_STATUS_UNSPECIFIED`
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