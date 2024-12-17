---
editable: false
sourcePath: en/_api-ref-grpc/certificatemanager/v1/privateca/api-ref/grpc/PrivateCaCertificate/revokeCertificate.md
---

# Certificate Manager Private CA API, gRPC: PrivateCaCertificateService.RevokeCertificate

Revokes a previously issued certificate. Revoked certificates are added to the CA's CRL or OCSP if enabled.

## gRPC request

**rpc RevokeCertificate ([RevokeCertificateRequest](#yandex.cloud.certificatemanager.v1.privateca.RevokeCertificateRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## RevokeCertificateRequest {#yandex.cloud.certificatemanager.v1.privateca.RevokeCertificateRequest}

```json
{
  "certificate_id": "string",
  "crl_reason": "CrlReason"
}
```

Request to revoke an issued certificate, making it invalid.

#|
||Field | Description ||
|| certificate_id | **string**

Required field. The ID of the certificate to revoke. ||
|| crl_reason | enum **CrlReason**

Required field. The reason for revoking the certificate (must be one of the reasons defined above).

- `CRL_REASON_UNSPECIFIED`
- `KEY_COMPROMISE`: Key used in the certificate has been compromised.
- `CA_COMPROMISE`: The Certificate Authority (CA) has been compromised.
- `AFFILIATION_CHANGED`: Change in affiliation, such as an organization restructure.
- `SUPERSEDED`: Certificate superseded by a newer one.
- `CESSATION_OF_OPERATION`: Operations relying on this certificate have ceased.
- `CERTIFICATE_HOLD`: Temporarily hold the certificate. Can be restored later.
- `REMOVE_FROM_CRL`: The certificate was removed from the Certificate Revocation List (CRL).
- `PRIVILEGE_WITHDRAWN`: Privileges associated with the certificate were withdrawn.
- `AA_COMPROMISE`: Certificate Authority or administrative compromise. ||
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
    "certificate_authority_id": "string",
    "certificate_id": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": "google.protobuf.Empty"
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
|| metadata | **[RevokeCertificateMetadata](#yandex.cloud.certificatemanager.v1.privateca.RevokeCertificateMetadata)**

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
|| response | **[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)**

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

## RevokeCertificateMetadata {#yandex.cloud.certificatemanager.v1.privateca.RevokeCertificateMetadata}

Metadata for the `RevokeCertificate` operation.

#|
||Field | Description ||
|| certificate_authority_id | **string**

Required field. The ID of the Certificate Authority that issued the revoked certificate. ||
|| certificate_id | **string**

Required field. The ID of the certificate that was revoked. ||
|#