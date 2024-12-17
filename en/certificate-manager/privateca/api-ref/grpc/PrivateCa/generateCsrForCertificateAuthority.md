---
editable: false
sourcePath: en/_api-ref-grpc/certificatemanager/v1/privateca/api-ref/grpc/PrivateCa/generateCsrForCertificateAuthority.md
---

# Certificate Manager Private CA API, gRPC: PrivateCaService.GenerateCsrForCertificateAuthority

Generates a Certificate Signing Request (CSR) for a new CA.
This allows generating the CSR which can be used to receive the final certificate.

## gRPC request

**rpc GenerateCsrForCertificateAuthority ([GenerateCsrForCertificateAuthorityRequest](#yandex.cloud.certificatemanager.v1.privateca.GenerateCsrForCertificateAuthorityRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## GenerateCsrForCertificateAuthorityRequest {#yandex.cloud.certificatemanager.v1.privateca.GenerateCsrForCertificateAuthorityRequest}

```json
{
  "folder_id": "string",
  "name": "string",
  "description": "string",
  "issuer": {
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

Request to generate a CSR for an existing Certificate Authority (CA).
Request for generating a Certificate Signing Request (CSR) for a new Certificate Authority (CA).

#|
||Field | Description ||
|| folder_id | **string**

Required field. Folder ID where the CA is being created. ||
|| name | **string**

Required field. Unique name for the Certificate Authority. ||
|| description | **string**

Optional description of the Certificate Authority for users to add additional context. ||
|| issuer | **[Issuer](#yandex.cloud.certificatemanager.v1.privateca.Issuer)**

Required field. Specifies the Certificate Authority issuer.
Required to define the issuer attributes for the CSR. ||
|| subject_spec | **[Subject](#yandex.cloud.certificatemanager.v1.privateca.Subject)**

Required field. Subject specifies the distinguished name (DN) fields for the CA (e.g., CN, O, etc.).
This is a required field that defines the identity information of the certificate. ||
|| algorithm | enum **Algorithm**

Required field. The cryptographic algorithm to generate the CSR with (e.g., RSA, ECC).

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

Path length constraint, defining the depth to which the CA can sign child certificates. ||
|| key_usage[] | enum **KeyUsageExtension**

Specifies the key usage extensions, such as digitalSignature, keyEncipherment, etc.

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

Specifies the extended key usage extensions, such as serverAuth or clientAuth.

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

Time-to-Live (TTL) in days for the Certificate Authority.
Defines the validity period of the CA certificate. ||
|| end_entities_ttl_limit_days | **int64**

TTL limit in days for end-entity certificates (e.g., server certs) issued by this CA.
This limit ensures the lifetime of signed end-entity certificates doesn't exceed this value. ||
|| template_id | **string**

Optional template ID for applying predefined configurations for generating the keys. ||
|| enable_crl | **bool**

Enables support for Certificate Revocation Lists (CRL).
If enabled, the CA will support revocation and produce CRLs. ||
|| enable_ocsp | **bool**

Enables support for the Online Certificate Status Protocol (OCSP).
If enabled, OCSP responses will be generated for certificates signed by this CA. ||
|| deletion_protection | **bool**

Protection flag that prevents accidental deletion of the Certificate Authority.
If set to true, the CA cannot be deleted unless this flag is removed. ||
|#

## Issuer {#yandex.cloud.certificatemanager.v1.privateca.Issuer}

Issuer field of certificate. Contains same inner field with subject. https://datatracker.ietf.org/doc/html/rfc5280#section-4.1.2.4

#|
||Field | Description ||
|| base_rdn | **[BaseRDN](#yandex.cloud.certificatemanager.v1.privateca.BaseRDN)**

Required field.  ||
|| additional_rdn | **[AdditionalRDN](#yandex.cloud.certificatemanager.v1.privateca.AdditionalRDN)** ||
|#

## BaseRDN {#yandex.cloud.certificatemanager.v1.privateca.BaseRDN}

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

## AdditionalRDN {#yandex.cloud.certificatemanager.v1.privateca.AdditionalRDN}

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

## Subject {#yandex.cloud.certificatemanager.v1.privateca.Subject}

Subject field of certificate https://datatracker.ietf.org/doc/html/rfc5280#section-4.1.2.6

#|
||Field | Description ||
|| base_rdn | **[BaseRDN](#yandex.cloud.certificatemanager.v1.privateca.BaseRDN)**

Required field. Most used field of subject ||
|| additional_rdn | **[AdditionalRDN](#yandex.cloud.certificatemanager.v1.privateca.AdditionalRDN)**

Additional fields of subject ||
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
    "certificate_authority_id": "string",
    "pem_content": "string"
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
|| metadata | **[GenerateCsrForCertificateAuthorityMetadata](#yandex.cloud.certificatemanager.v1.privateca.GenerateCsrForCertificateAuthorityMetadata)**

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
|| response | **[CsrForSignCertificateAuthority](#yandex.cloud.certificatemanager.v1.privateca.CsrForSignCertificateAuthority)**

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

## GenerateCsrForCertificateAuthorityMetadata {#yandex.cloud.certificatemanager.v1.privateca.GenerateCsrForCertificateAuthorityMetadata}

Metadata returned from the GenerateCsrForCertificateAuthority operation.

#|
||Field | Description ||
|| certificate_authority_id | **string**

The ID of the Certificate Authority for which the CSR was generated. ||
|#

## CsrForSignCertificateAuthority {#yandex.cloud.certificatemanager.v1.privateca.CsrForSignCertificateAuthority}

Certificate Signing Request (CSR) for signing a certificate authority.

#|
||Field | Description ||
|| certificate_authority_id | **string**

ID of the certificate authority for which the CSR was generated. ||
|| pem_content | **string**

PEM-encoded CSR content. ||
|#