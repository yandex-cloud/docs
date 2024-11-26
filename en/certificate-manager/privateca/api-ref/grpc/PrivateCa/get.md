---
editable: false
sourcePath: en/_api-ref-grpc/certificatemanager/v1/privateca/api-ref/grpc/PrivateCa/get.md
---

# Certificate Manager Private CA API, gRPC: PrivateCaService.Get

Retrieves detailed information about a specific Certificate Authority (CA).

## gRPC request

**rpc Get ([GetCertificateAuthorityRequest](#yandex.cloud.priv.certificatemanager.v1.privateca.GetCertificateAuthorityRequest)) returns ([CertificateAuthority](#yandex.cloud.priv.certificatemanager.v1.privateca.CertificateAuthority))**

## GetCertificateAuthorityRequest {#yandex.cloud.priv.certificatemanager.v1.privateca.GetCertificateAuthorityRequest}

```json
{
  "certificate_authority_id": "string"
}
```

Request to get detailed information about an existing Certificate Authority.

#|
||Field | Description ||
|| certificate_authority_id | **string**

Required field. The ID of the Certificate Authority to retrieve.
This must be a valid Certificate Authority ID in your account. ||
|#

## CertificateAuthority {#yandex.cloud.priv.certificatemanager.v1.privateca.CertificateAuthority}

```json
{
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
```

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