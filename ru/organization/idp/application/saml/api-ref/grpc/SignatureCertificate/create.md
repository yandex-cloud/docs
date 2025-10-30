---
editable: false
sourcePath: en/_api-ref-grpc/organizationmanager/v1/idp/application/saml/api-ref/grpc/SignatureCertificate/create.md
---

# SAML Application API, gRPC: SignatureCertificateService.Create

Creates a new signature certificate for the specified SAML application.

## gRPC request

**rpc Create ([CreateSignatureCertificateRequest](#yandex.cloud.organizationmanager.v1.idp.application.saml.CreateSignatureCertificateRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## CreateSignatureCertificateRequest {#yandex.cloud.organizationmanager.v1.idp.application.saml.CreateSignatureCertificateRequest}

```json
{
  "application_id": "string",
  "name": "string",
  "description": "string"
}
```

Request to create a new signature certificate.

#|
||Field | Description ||
|| application_id | **string**

Required field. ID of the SAML application to create the certificate for. ||
|| name | **string**

Name of the signature certificate.
The name is unique within the application. 3-63 characters long. ||
|| description | **string**

Description of the signature certificate. 0-256 characters long. ||
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
    "signature_certificate_id": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "string",
    "application_id": "string",
    "status": "Status",
    "name": "string",
    "description": "string",
    "created_at": "google.protobuf.Timestamp",
    "data": "string",
    "fingerprint": "string",
    "not_after": "google.protobuf.Timestamp",
    "not_before": "google.protobuf.Timestamp"
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
|| metadata | **[CreateSignatureCertificateMetadata](#yandex.cloud.organizationmanager.v1.idp.application.saml.CreateSignatureCertificateMetadata)**

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
|| response | **[SignatureCertificate](#yandex.cloud.organizationmanager.v1.idp.application.saml.SignatureCertificate)**

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

## CreateSignatureCertificateMetadata {#yandex.cloud.organizationmanager.v1.idp.application.saml.CreateSignatureCertificateMetadata}

Metadata for the [SignatureCertificateService.Create](#Create) operation.

#|
||Field | Description ||
|| signature_certificate_id | **string**

ID of the signature certificate that is being created. ||
|#

## SignatureCertificate {#yandex.cloud.organizationmanager.v1.idp.application.saml.SignatureCertificate}

A signature certificate for SAML applications.

#|
||Field | Description ||
|| id | **string**

Unique identifier of the signature certificate. ||
|| application_id | **string**

ID of the SAML application that the signature certificate belongs to. ||
|| status | enum **Status**

Current status of the signature certificate.

- `STATUS_UNSPECIFIED`: The status is not specified.
- `ACTIVE`: The certificate is active and can be used for signing.
- `INACTIVE`: The certificate is inactive and cannot be used for signing. ||
|| name | **string**

Name of the signature certificate. ||
|| description | **string**

Description of the signature certificate. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| data | **string**

Certificate data in PEM format. ||
|| fingerprint | **string**

SHA256-fingerprint of the signature certificate. ||
|| not_after | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time after which the signature certificate is not valid. ||
|| not_before | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time before which the signature certificate is not valid. ||
|#