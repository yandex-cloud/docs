---
editable: false
sourcePath: en/_api-ref-grpc/certificatemanager/v1/privateca/api-ref/grpc/PrivateCaCertificate/get.md
---

# Certificate Manager Private CA API, gRPC: PrivateCaCertificateService.Get

Retrieves information about a specific certificate.

## gRPC request

**rpc Get ([GetCertificateRequest](#yandex.cloud.certificatemanager.v1.privateca.GetCertificateRequest)) returns ([PrivateCertificate](#yandex.cloud.certificatemanager.v1.privateca.PrivateCertificate))**

## GetCertificateRequest {#yandex.cloud.certificatemanager.v1.privateca.GetCertificateRequest}

```json
{
  "certificate_id": "string"
}
```

Request to retrieve details of a specific certificate.

#|
||Field | Description ||
|| certificate_id | **string**

Required field. The ID of the certificate to retrieve. ||
|#

## PrivateCertificate {#yandex.cloud.certificatemanager.v1.privateca.PrivateCertificate}

```json
{
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
```

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