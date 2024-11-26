---
editable: false
sourcePath: en/_api-ref-grpc/certificatemanager/v1/privateca/api-ref/grpc/PrivateCa/generateCertificateAuthority.md
---

# Certificate Manager Private CA API, gRPC: PrivateCaService.GenerateCertificateAuthority

Generates a new Certificate Authority (CA).
This endpoint creates a new CA with given properties and cryptographic settings.

## gRPC request

**rpc GenerateCertificateAuthority ([GenerateCertificateAuthorityRequest](#yandex.cloud.priv.certificatemanager.v1.privateca.GenerateCertificateAuthorityRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## GenerateCertificateAuthorityRequest {#yandex.cloud.priv.certificatemanager.v1.privateca.GenerateCertificateAuthorityRequest}

```json
{
  "folder_id": "string",
  "parent_certificate_authority_id": "string",
  "name": "string",
  "description": "string",
  "subject_spec": {
    "base_rdn": {
      "country": "string",
      "organization": "string",
      "organizational_unit": "string",
      "distinguished_name_qualifier": "string",
      "state_or_province": "string",
      "common_name": "string",
      "email_address": "string"
    },
    "additional_rdn": {
      "serial_number": "string",
      "locality": "string",
      "title": "string",
      "surname": "string",
      "given_name": "string",
      "initials": "string",
      "generation_qualifier": "string"
    }
  },
  "algorithm": "Algorithm",
  "path_len": "int64",
  "key_usage": [
    "KeyUsageExtension"
  ],
  "extended_key_usage": [
    "ExtendedKeyUsageExtension"
  ],
  "ttl_days": "int64",
  "end_entities_ttl_limit_days": "int64",
  "template_id": "string",
  "enable_crl": "bool",
  "enable_ocsp": "bool",
  "deletion_protection": "bool"
}
```

Request to generate a new Certificate Authority (CA).

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
|| subject_spec | **[Subject](#yandex.cloud.priv.certificatemanager.v1.privateca.Subject)**

Required field. The subject (e.g., common name, organization, etc.) for the CA. ||
|| algorithm | enum **Algorithm**

Required field. The algorithm for the asymmetric key generation (e.g., RSA, ECC).

- `ALGORITHM_UNSPECIFIED`
- `RSA_2048_PSS_SHA_256`
- `RSA_2048_PSS_SHA_384`
- `RSA_2048_PSS_SHA_512`
- `RSA_3072_PSS_SHA_256`
- `RSA_3072_PSS_SHA_384`
- `RSA_3072_PSS_SHA_512`
- `RSA_4096_PSS_SHA_256`
- `RSA_4096_PSS_SHA_384`
- `RSA_4096_PSS_SHA_512`
- `ECDSA_NIST_P256_SHA_256`
- `ECDSA_NIST_P384_SHA_384`
- `ECDSA_NIST_P521_SHA_512`
- `ECDSA_SECP256_K1_SHA_256`
- `RSA_2048_PKCS1_5_SHA_256`: RSA PKCS 1.5
- `RSA_2048_PKCS1_5_SHA_384`
- `RSA_2048_PKCS1_5_SHA_512`
- `RSA_3072_PKCS1_5_SHA_256`
- `RSA_3072_PKCS1_5_SHA_384`
- `RSA_3072_PKCS1_5_SHA_512`
- `RSA_4096_PKCS1_5_SHA_256`
- `RSA_4096_PKCS1_5_SHA_384`
- `RSA_4096_PKCS1_5_SHA_512` ||
|| path_len | **int64**

The maximum length of the certificate chain. ||
|| key_usage[] | enum **KeyUsageExtension**

Key usage (e.g., keyEncipherment, digitalSignature).

- `KEY_USAGE_EXTENSION_UNSPECIFIED`
- `DIGITAL_SIGNATURE`
- `CONTENT_COMMITMENT`
- `KEY_ENCIPHERMENT`
- `DATA_ENCIPHERMENT`
- `KEY_AGREEMENT`
- `KEY_CERT_SIGN`
- `CRL_SIGN`
- `ENCIPHER_ONLY`
- `DECIPHER_ONLY` ||
|| extended_key_usage[] | enum **ExtendedKeyUsageExtension**

Extended key usage (e.g., serverAuth, clientAuth).

- `EXTENDED_KEY_USAGE_EXTENSION_UNSPECIFIED`
- `SERVER_AUTH`
- `CLIENT_AUTH`
- `CODE_SIGNING`
- `EMAIL_PROTECTION`
- `TIME_STAMPING`
- `OCSP_SIGNING`
- `IPSEC_IKE`
- `MS_CODE_IND`
- `MS_CODE_COM`
- `MS_CTL_SIGN`
- `MS_EFS` ||
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

Protect the CA from accidental deletion. Deny deletion of ca if set ||
|#

## Subject {#yandex.cloud.priv.certificatemanager.v1.privateca.Subject}

Subject field of certificate https://datatracker.ietf.org/doc/html/rfc5280#section-4.1.2.6

#|
||Field | Description ||
|| base_rdn | **[BaseRDN](#yandex.cloud.priv.certificatemanager.v1.privateca.BaseRDN)**

Required field. Most used field of subject ||
|| additional_rdn | **[AdditionalRDN](#yandex.cloud.priv.certificatemanager.v1.privateca.AdditionalRDN)**

Additional fields of subject ||
|#

## BaseRDN {#yandex.cloud.priv.certificatemanager.v1.privateca.BaseRDN}

https://datatracker.ietf.org/doc/html/rfc5280#section-4.1.2.4

#|
||Field | Description ||
|| country | **string**

Two letter county code ||
|| organization | **string**

Organization name in arbitrary form ||
|| organizational_unit | **string**

Organizational unit name in arbitrary form ||
|| distinguished_name_qualifier | **string**

Distinguished name qualifier ||
|| state_or_province | **string**

State or province name in arbitrary form ||
|| common_name | **string**

Common name. For tls certificates it is domain usually. ||
|| email_address | **string**

Email address of certificate owner ||
|#

## AdditionalRDN {#yandex.cloud.priv.certificatemanager.v1.privateca.AdditionalRDN}

https://datatracker.ietf.org/doc/html/rfc5280#section-4.1.2.4

#|
||Field | Description ||
|| serial_number | **string**

Serial number of certificate subject in arbitrary form. Don't confuse with certificate serial number. ||
|| locality | **string**

Locality of certificate subject in arbitrary form. ||
|| title | **string**

Title of certificate subject in arbitrary form. ||
|| surname | **string**

Surname of certificate subject in arbitrary form. ||
|| given_name | **string**

Given name of certificate subject in arbitrary form. ||
|| initials | **string**

Initials of certificate subject in arbitrary form. ||
|| generation_qualifier | **string**

Generation qualifier of certificate subject in arbitrary form. ||
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
|| metadata | **[GenerateCertificateAuthorityMetadata](#yandex.cloud.priv.certificatemanager.v1.privateca.GenerateCertificateAuthorityMetadata)**

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
|| response | **[CertificateAuthority](#yandex.cloud.priv.certificatemanager.v1.privateca.CertificateAuthority)**

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

## GenerateCertificateAuthorityMetadata {#yandex.cloud.priv.certificatemanager.v1.privateca.GenerateCertificateAuthorityMetadata}

Metadata for the GenerateCertificateAuthority operation.

#|
||Field | Description ||
|| certificate_authority_id | **string**

ID of the Certificate Authority being created. ||
|#

## CertificateAuthority {#yandex.cloud.priv.certificatemanager.v1.privateca.CertificateAuthority}

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