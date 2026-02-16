---
editable: false
sourcePath: en/_api-ref-grpc/organizationmanager/v1/idp/application/saml/api-ref/grpc/SignatureCertificate/get.md
---

# SAML Application API, gRPC: SignatureCertificateService.Get

Returns the specified signature certificate.

To get the list of available certificates, make a [List](/docs/organization/idp/application/saml/mapi-ref/grpc/SignatureCertificate/list#List) request.

## gRPC request

**rpc Get ([GetSignatureCertificateRequest](#yandex.cloud.organizationmanager.v1.idp.application.saml.GetSignatureCertificateRequest)) returns ([SignatureCertificate](#yandex.cloud.organizationmanager.v1.idp.application.saml.SignatureCertificate))**

## GetSignatureCertificateRequest {#yandex.cloud.organizationmanager.v1.idp.application.saml.GetSignatureCertificateRequest}

```json
{
  "signature_certificate_id": "string"
}
```

Request to get a signature certificate by ID.

#|
||Field | Description ||
|| signature_certificate_id | **string**

Required field. ID of the signature certificate to return.

The maximum string length in characters is 50. ||
|#

## SignatureCertificate {#yandex.cloud.organizationmanager.v1.idp.application.saml.SignatureCertificate}

```json
{
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
```

A signature certificate for SAML applications.

#|
||Field | Description ||
|| id | **string**

Unique identifier of the signature certificate. ||
|| application_id | **string**

ID of the SAML application that the signature certificate belongs to. ||
|| status | enum **Status**

Current status of the signature certificate.

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