---
editable: false
sourcePath: en/_api-ref-grpc/certificatemanager/v1/privateca/api-ref/grpc/PrivateCa/generateCertificateAuthorityByCsr.md
---

# Certificate Manager Private CA API, gRPC: PrivateCaService.GenerateCertificateAuthorityByCsr

Generates a Certificate Authority (CA) by using a Certificate Signing Request (CSR).
This allows using an externally provided CSR to finalize CA creation.

## gRPC request

**rpc GenerateCertificateAuthorityByCsr ([GenerateCertificateAuthorityByCsrRequest](#yandex.cloud.certificatemanager.v1.privateca.GenerateCertificateAuthorityByCsrRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## GenerateCertificateAuthorityByCsrRequest {#yandex.cloud.certificatemanager.v1.privateca.GenerateCertificateAuthorityByCsrRequest}

```json
{
  "folder_id": "string",
  "parent_certificate_authority_id": "string",
  "name": "string",
  "description": "string",
  "csr": "string",
  "private_key": "string",
  "ttl_days": "int64",
  "end_entities_ttl_limit_days": "int64",
  "template_id": "string",
  "enable_crl": "bool",
  "enable_ocsp": "bool",
  "deletion_protection": "bool"
}
```

Request to generate a Certificate Authority (CA) from a Certificate Signing Request (CSR).

#|
||Field | Description ||
|| folder_id | **string**

Required field. Folder ID where the CA is being created. ||
|| parent_certificate_authority_id | **string**

Optional. If set intermediate CA would be generated and signed on parent CA ||
|| name | **string**

Required field. The name of the Certificate Authority. ||
|| description | **string**

An optional description of the Certificate Authority. ||
|| csr | **string**

Required field. The PEM-encoded Certificate Signing Request (CSR) content. ||
|| private_key | **string**

Optional. The PEM-encoded private key linked to the certificate. If absent CA would be issued with server side generated key pair ||
|| ttl_days | **int64**

The Time-To-Live (TTL) in days for the CA. ||
|| end_entities_ttl_limit_days | **int64**

TTL limit in days for end-entities signed by the CA. ||
|| template_id | **string**

Optional template ID to fill certificate fields with template data. Explicitly defined parameters is preferred ||
|| enable_crl | **bool**

Enable Certificate Revocation List (CRL) support. ||
|| enable_ocsp | **bool**

Enable Online Certificate Status Protocol (OCSP) support. ||
|| deletion_protection | **bool**

Protect the CA from accidental deletion. ||
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
    "certificate_authority_id": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "string",
    "folder_id": "string",
    "name": "string",
    "description": "string",
    "parent_certificate_authority_id": "string",
    "status": "Status",
    "issued_at": "google.protobuf.Timestamp",
    "not_after": "google.protobuf.Timestamp",
    "not_before": "google.protobuf.Timestamp",
    "crl_endpoint": "string",
    "end_entities_ttl_limit_days": "int64",
    "deletion_protection": "bool",
    "created_at": "google.protobuf.Timestamp",
    "updated_at": "google.protobuf.Timestamp"
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
|| metadata | **[GenerateCertificateAuthorityByCsrMetadata](#yandex.cloud.certificatemanager.v1.privateca.GenerateCertificateAuthorityByCsrMetadata)**

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
|| response | **[CertificateAuthority](#yandex.cloud.certificatemanager.v1.privateca.CertificateAuthority)**

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

## GenerateCertificateAuthorityByCsrMetadata {#yandex.cloud.certificatemanager.v1.privateca.GenerateCertificateAuthorityByCsrMetadata}

Metadata for the GenerateCertificateAuthorityByCsr operation.

#|
||Field | Description ||
|| certificate_authority_id | **string**

The ID of the Certificate Authority being generated. ||
|#

## CertificateAuthority {#yandex.cloud.certificatemanager.v1.privateca.CertificateAuthority}

A certificate authority (CA) used to sign certificates.

#|
||Field | Description ||
|| id | **string**

ID of the certificate authority. ||
|| folder_id | **string**

ID of the folder that the certificate authority belongs to. ||
|| name | **string**

Name of the certificate authority. ||
|| description | **string**

Description of the certificate authority. ||
|| parent_certificate_authority_id | **string**

ID of the parent certificate authority that signed this certificate authority if any. ||
|| status | enum **Status**

Status of the certificate authority.

- `STATUS_UNSPECIFIED`
- `UNSIGNED`: The certificate authority is unsigned and pending signing.
- `ACTIVE`: The certificate authority is active and can issue certificates. ||
|| issued_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time when the certificate authority was issued. ||
|| not_after | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time after which the certificate authority is not valid. ||
|| not_before | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time before which the certificate authority is not valid. ||
|| crl_endpoint | **string**

Endpoint of the certificate revocation list (CRL) for the certificate authority. ||
|| end_entities_ttl_limit_days | **int64**

Maximum allowed TTL (in days) for end-entity certificates issued by this CA. ||
|| deletion_protection | **bool**

Flag that protects deletion of the certificate authority. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time when the certificate authority was created. ||
|| updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time when the certificate authority was last updated. ||
|#