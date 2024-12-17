---
editable: false
sourcePath: en/_api-ref-grpc/certificatemanager/v1/privateca/api-ref/grpc/PrivateCaCertificate/issueCertificate.md
---

# Certificate Manager Private CA API, gRPC: PrivateCaCertificateService.IssueCertificate

Issues a new certificate for a given Certificate Authority (CA).

## gRPC request

**rpc IssueCertificate ([IssueCertificateRequest](#yandex.cloud.certificatemanager.v1.privateca.IssueCertificateRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## IssueCertificateRequest {#yandex.cloud.certificatemanager.v1.privateca.IssueCertificateRequest}

```json
{
  "certificate_authority_id": "string",
  "name": "string",
  "description": "string",
  "subject": {
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
  "signing_algorithm": "Algorithm",
  "key_usage": [
    "KeyUsageExtension"
  ],
  "extended_key_usage": [
    "ExtendedKeyUsageExtension"
  ],
  "subject_alternative_names": [
    {
      // Includes only one of the fields `other_name`, `rfc_822_name`, `dns_name`, `x_400_name`, `directory_name`, `edi_party_name`, `uniform_resource_identifier`, `ip_address`, `registered_id`
      "other_name": {
        "type_oid": "string",
        "name": "string"
      },
      "rfc_822_name": "string",
      "dns_name": "string",
      "x_400_name": "string",
      "directory_name": "string",
      "edi_party_name": {
        "name_assigner": "string",
        "party_name": "string"
      },
      "uniform_resource_identifier": "string",
      "ip_address": "string",
      "registered_id": "string"
      // end of the list of possible fields
    }
  ],
  "template_id": "string",
  "deletion_protection": "bool",
  "desired_ttl_days": "int64"
}
```

Request to issue a new certificate for a given Certificate Authority.

#|
||Field | Description ||
|| certificate_authority_id | **string**

Required field. The ID of the Certificate Authority (CA) that will issue this certificate. ||
|| name | **string**

The name of the certificate. ||
|| description | **string**

A description of the certificate. ||
|| subject | **[Subject](#yandex.cloud.certificatemanager.v1.privateca.Subject)**

Details about the certificate subject (e.g., CN, O, etc.). ||
|| signing_algorithm | enum **Algorithm**

The algorithm the CA will use to sign and issue the certificate.

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
|| key_usage[] | enum **KeyUsageExtension**

List of purposes of the certificate, such as digitalSignature or keyEncipherment.

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

List of extended purposes of the certificate, such as serverAuth or clientAuth.

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
|| subject_alternative_names[] | **[SubjectAlternativeName](#yandex.cloud.certificatemanager.v1.privateca.SubjectAlternativeName)**

Subject Alternative Names (SANs) for the certificate, such as DNS entries or IP addresses. ||
|| template_id | **string**

Optional certificate template ID. Issue certificate with template's fields if non-empty. ||
|| deletion_protection | **bool**

Flag to protect the certificate from being accidentally deleted. ||
|| desired_ttl_days | **int64**

Desired time-to-live (TTL) of the certificate in days. ||
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

## SubjectAlternativeName {#yandex.cloud.certificatemanager.v1.privateca.SubjectAlternativeName}

Extend subject of certificate https://datatracker.ietf.org/doc/html/rfc5280#section-4.2.1.6

#|
||Field | Description ||
|| other_name | **[OtherName](#yandex.cloud.certificatemanager.v1.privateca.OtherName)**

Local defined identifier in arbitrary form

Includes only one of the fields `other_name`, `rfc_822_name`, `dns_name`, `x_400_name`, `directory_name`, `edi_party_name`, `uniform_resource_identifier`, `ip_address`, `registered_id`.

https://datatracker.ietf.org/doc/html/rfc5280#section-4.2.1.6 ||
|| rfc_822_name | **string**

Encoded email address

Includes only one of the fields `other_name`, `rfc_822_name`, `dns_name`, `x_400_name`, `directory_name`, `edi_party_name`, `uniform_resource_identifier`, `ip_address`, `registered_id`.

https://datatracker.ietf.org/doc/html/rfc5280#section-4.2.1.6 ||
|| dns_name | **string**

Widely used in tls certificates for domains

Includes only one of the fields `other_name`, `rfc_822_name`, `dns_name`, `x_400_name`, `directory_name`, `edi_party_name`, `uniform_resource_identifier`, `ip_address`, `registered_id`.

https://datatracker.ietf.org/doc/html/rfc5280#section-4.2.1.6 ||
|| x_400_name | **string**

x400 name https://en.wikipedia.org/wiki/X.400

Includes only one of the fields `other_name`, `rfc_822_name`, `dns_name`, `x_400_name`, `directory_name`, `edi_party_name`, `uniform_resource_identifier`, `ip_address`, `registered_id`.

https://datatracker.ietf.org/doc/html/rfc5280#section-4.2.1.6 ||
|| directory_name | **string**

Represents sequence of rdn for uniquely identifying entities

Includes only one of the fields `other_name`, `rfc_822_name`, `dns_name`, `x_400_name`, `directory_name`, `edi_party_name`, `uniform_resource_identifier`, `ip_address`, `registered_id`.

https://datatracker.ietf.org/doc/html/rfc5280#section-4.2.1.6 ||
|| edi_party_name | **[EdiPartyName](#yandex.cloud.certificatemanager.v1.privateca.EdiPartyName)**

Electronic Data Interchange entity

Includes only one of the fields `other_name`, `rfc_822_name`, `dns_name`, `x_400_name`, `directory_name`, `edi_party_name`, `uniform_resource_identifier`, `ip_address`, `registered_id`.

https://datatracker.ietf.org/doc/html/rfc5280#section-4.2.1.6 ||
|| uniform_resource_identifier | **string**

URI

Includes only one of the fields `other_name`, `rfc_822_name`, `dns_name`, `x_400_name`, `directory_name`, `edi_party_name`, `uniform_resource_identifier`, `ip_address`, `registered_id`.

https://datatracker.ietf.org/doc/html/rfc5280#section-4.2.1.6 ||
|| ip_address | **string**

ip address of certificate subject. May be used in tls certificates

Includes only one of the fields `other_name`, `rfc_822_name`, `dns_name`, `x_400_name`, `directory_name`, `edi_party_name`, `uniform_resource_identifier`, `ip_address`, `registered_id`.

https://datatracker.ietf.org/doc/html/rfc5280#section-4.2.1.6 ||
|| registered_id | **string**

Object Identifier (OID)

Includes only one of the fields `other_name`, `rfc_822_name`, `dns_name`, `x_400_name`, `directory_name`, `edi_party_name`, `uniform_resource_identifier`, `ip_address`, `registered_id`.

https://datatracker.ietf.org/doc/html/rfc5280#section-4.2.1.6 ||
|#

## OtherName {#yandex.cloud.certificatemanager.v1.privateca.OtherName}

#|
||Field | Description ||
|| type_oid | **string**

Object identifier for name type ||
|| name | **string**

DER encoded value of type with type_oid ||
|#

## EdiPartyName {#yandex.cloud.certificatemanager.v1.privateca.EdiPartyName}

#|
||Field | Description ||
|| name_assigner | **string**

Specifies the entity or authority that assigned the partyName ||
|| party_name | **string**

The actual identifier of the EDI party ||
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
|| metadata | **[IssueCertificateMetadata](#yandex.cloud.certificatemanager.v1.privateca.IssueCertificateMetadata)**

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

## IssueCertificateMetadata {#yandex.cloud.certificatemanager.v1.privateca.IssueCertificateMetadata}

Metadata for the `IssueCertificate` operation, tracking the ID of the new certificate.

#|
||Field | Description ||
|| certificate_id | **string**

The ID of the certificate that was issued. ||
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