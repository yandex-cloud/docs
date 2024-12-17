---
editable: false
sourcePath: en/_api-ref-grpc/certificatemanager/v1/privateca/api-ref/grpc/PrivateCaCertificate/issueCertificateByCsr.md
---

# Certificate Manager Private CA API, gRPC: PrivateCaCertificateService.IssueCertificateByCsr

Issues a new certificate using a CSR (Certificate Signing Request).

## gRPC request

**rpc IssueCertificateByCsr ([IssueCertificateByCsrRequest](#yandex.cloud.certificatemanager.v1.privateca.IssueCertificateByCsrRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## IssueCertificateByCsrRequest {#yandex.cloud.certificatemanager.v1.privateca.IssueCertificateByCsrRequest}

```json
{
  "certificate_authority_id": "string",
  "name": "string",
  "description": "string",
  "csr": "string",
  "private_key": "string",
  "template_id": "string",
  "deletion_protection": "bool",
  "desired_ttl_days": "int64"
}
```

Request to issue a new certificate using a CSR (Certificate Signing Request).

#|
||Field | Description ||
|| certificate_authority_id | **string**

Required field. The ID of the Certificate Authority (CA) that will issue this certificate. ||
|| name | **string**

The name of the certificate. ||
|| description | **string**

A description of the certificate. ||
|| csr | **string**

Required field. PEM-encoded CSR content. ||
|| private_key | **string**

PEM-encoded private key associated with the CSR. CA will generate own key for certificate if absent ||
|| template_id | **string**

Optional certificate template ID. Issue certificate with template's fields if non-empty. ||
|| deletion_protection | **bool**

Flag to protect the certificate from being accidentally deleted. ||
|| desired_ttl_days | **int64**

Desired time-to-live (TTL) of the certificate in days. ||
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
    "certificate_id": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "string",
    "certificate_authority_id": "string",
    "name": "string",
    "description": "string",
    "issued_at": "google.protobuf.Timestamp",
    "not_after": "google.protobuf.Timestamp",
    "not_before": "google.protobuf.Timestamp",
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
|| metadata | **[IssueCertificateByCsrMetadata](#yandex.cloud.certificatemanager.v1.privateca.IssueCertificateByCsrMetadata)**

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
|| response | **[PrivateCertificate](#yandex.cloud.certificatemanager.v1.privateca.PrivateCertificate)**

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

## IssueCertificateByCsrMetadata {#yandex.cloud.certificatemanager.v1.privateca.IssueCertificateByCsrMetadata}

Metadata for the `IssueCertificateByCsr` operation.

#|
||Field | Description ||
|| certificate_id | **string**

The ID of the certificate that was issued using the CSR. ||
|#

## PrivateCertificate {#yandex.cloud.certificatemanager.v1.privateca.PrivateCertificate}

A private certificate issued by a private certificate authority.

#|
||Field | Description ||
|| id | **string**

ID of the private certificate. ||
|| certificate_authority_id | **string**

ID of the certificate authority that issued the private certificate. ||
|| name | **string**

Name of the private certificate. ||
|| description | **string**

Description of the private certificate. ||
|| issued_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time when the private certificate was issued. ||
|| not_after | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time after which the private certificate is not valid. ||
|| not_before | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time before which the private certificate is not valid. ||
|| deletion_protection | **bool**

Flag that protects deletion of the private certificate. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time when the private certificate was created. ||
|| updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time when the private certificate was updated. ||
|#