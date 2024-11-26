---
editable: false
sourcePath: en/_api-ref/certificatemanager/v1/privateca/api-ref/PrivateCa/generateCsrForCertificateAuthority.md
---

# Certificate Manager Private CA API, REST: PrivateCa.GenerateCsrForCertificateAuthority

Generates a Certificate Signing Request (CSR) for a new CA.
This allows generating the CSR which can be used to receive the final certificate.

## HTTP request

```
POST https://private-ca.certificate-manager.{{ api-host }}/privateca/v1/certificateAuthorities/generateCsr
```

## Body parameters {#yandex.cloud.priv.certificatemanager.v1.privateca.GenerateCsrForCertificateAuthorityRequest}

```json
{
  "folderId": "string",
  "name": "string",
  "description": "string",
  "issuer": {
    "baseRdn": {
      "country": "string",
      "organization": "string",
      "organizationalUnit": "string",
      "distinguishedNameQualifier": "string",
      "stateOrProvince": "string",
      "commonName": "string",
      "emailAddress": "string"
    },
    "additionalRdn": {
      "serialNumber": "string",
      "locality": "string",
      "title": "string",
      "surname": "string",
      "givenName": "string",
      "initials": "string",
      "generationQualifier": "string"
    }
  },
  "subjectSpec": {
    "baseRdn": {
      "country": "string",
      "organization": "string",
      "organizationalUnit": "string",
      "distinguishedNameQualifier": "string",
      "stateOrProvince": "string",
      "commonName": "string",
      "emailAddress": "string"
    },
    "additionalRdn": {
      "serialNumber": "string",
      "locality": "string",
      "title": "string",
      "surname": "string",
      "givenName": "string",
      "initials": "string",
      "generationQualifier": "string"
    }
  },
  "algorithm": "string",
  "pathLen": "string",
  "keyUsage": [
    "string"
  ],
  "extendedKeyUsage": [
    "string"
  ],
  "ttlDays": "string",
  "endEntitiesTtlLimitDays": "string",
  "templateId": "string",
  "enableCrl": "boolean",
  "enableOcsp": "boolean",
  "deletionProtection": "boolean"
}
```

Request to generate a CSR for an existing Certificate Authority (CA).
Request for generating a Certificate Signing Request (CSR) for a new Certificate Authority (CA).

#|
||Field | Description ||
|| folderId | **string**

Required field. Folder ID where the CA is being created. ||
|| name | **string**

Required field. Unique name for the Certificate Authority. ||
|| description | **string**

Optional description of the Certificate Authority for users to add additional context. ||
|| issuer | **[Issuer](#yandex.cloud.priv.certificatemanager.v1.privateca.Issuer)**

Required field. Specifies the Certificate Authority issuer.
Required to define the issuer attributes for the CSR. ||
|| subjectSpec | **[Subject](#yandex.cloud.priv.certificatemanager.v1.privateca.Subject)**

Required field. Subject specifies the distinguished name (DN) fields for the CA (e.g., CN, O, etc.).
This is a required field that defines the identity information of the certificate. ||
|| algorithm | **enum** (Algorithm)

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
|| pathLen | **string** (int64)

Path length constraint, defining the depth to which the CA can sign child certificates. ||
|| keyUsage[] | **enum** (KeyUsageExtension)

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
|| extendedKeyUsage[] | **enum** (ExtendedKeyUsageExtension)

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
|| ttlDays | **string** (int64)

Time-to-Live (TTL) in days for the Certificate Authority.
Defines the validity period of the CA certificate. ||
|| endEntitiesTtlLimitDays | **string** (int64)

TTL limit in days for end-entity certificates (e.g., server certs) issued by this CA.
This limit ensures the lifetime of signed end-entity certificates doesn't exceed this value. ||
|| templateId | **string**

Optional template ID for applying predefined configurations for generating the keys. ||
|| enableCrl | **boolean**

Enables support for Certificate Revocation Lists (CRL).
If enabled, the CA will support revocation and produce CRLs. ||
|| enableOcsp | **boolean**

Enables support for the Online Certificate Status Protocol (OCSP).
If enabled, OCSP responses will be generated for certificates signed by this CA. ||
|| deletionProtection | **boolean**

Protection flag that prevents accidental deletion of the Certificate Authority.
If set to true, the CA cannot be deleted unless this flag is removed. ||
|#

## Issuer {#yandex.cloud.priv.certificatemanager.v1.privateca.Issuer}

Issuer field of certificate. Contains same inner field with subject. https://datatracker.ietf.org/doc/html/rfc5280#section-4.1.2.4

#|
||Field | Description ||
|| baseRdn | **[BaseRDN](#yandex.cloud.priv.certificatemanager.v1.privateca.BaseRDN)**

Required field.  ||
|| additionalRdn | **[AdditionalRDN](#yandex.cloud.priv.certificatemanager.v1.privateca.AdditionalRDN)** ||
|#

## BaseRDN {#yandex.cloud.priv.certificatemanager.v1.privateca.BaseRDN}

https://datatracker.ietf.org/doc/html/rfc5280#section-4.1.2.4

#|
||Field | Description ||
|| country | **string**

Two letter county code ||
|| organization | **string**

Organization name in arbitrary form ||
|| organizationalUnit | **string**

Organizational unit name in arbitrary form ||
|| distinguishedNameQualifier | **string**

Distinguished name qualifier ||
|| stateOrProvince | **string**

State or province name in arbitrary form ||
|| commonName | **string**

Common name. For tls certificates it is domain usually. ||
|| emailAddress | **string**

Email address of certificate owner ||
|#

## AdditionalRDN {#yandex.cloud.priv.certificatemanager.v1.privateca.AdditionalRDN}

https://datatracker.ietf.org/doc/html/rfc5280#section-4.1.2.4

#|
||Field | Description ||
|| serialNumber | **string**

Serial number of certificate subject in arbitrary form. Don't confuse with certificate serial number. ||
|| locality | **string**

Locality of certificate subject in arbitrary form. ||
|| title | **string**

Title of certificate subject in arbitrary form. ||
|| surname | **string**

Surname of certificate subject in arbitrary form. ||
|| givenName | **string**

Given name of certificate subject in arbitrary form. ||
|| initials | **string**

Initials of certificate subject in arbitrary form. ||
|| generationQualifier | **string**

Generation qualifier of certificate subject in arbitrary form. ||
|#

## Subject {#yandex.cloud.priv.certificatemanager.v1.privateca.Subject}

Subject field of certificate https://datatracker.ietf.org/doc/html/rfc5280#section-4.1.2.6

#|
||Field | Description ||
|| baseRdn | **[BaseRDN](#yandex.cloud.priv.certificatemanager.v1.privateca.BaseRDN)**

Required field. Most used field of subject ||
|| additionalRdn | **[AdditionalRDN](#yandex.cloud.priv.certificatemanager.v1.privateca.AdditionalRDN)**

Additional fields of subject ||
|#

## Response {#yandex.cloud.operation.Operation}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": "boolean",
  "metadata": {
    "certificateAuthorityId": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": {
    "certificateAuthorityId": "string",
    "pemContent": "string"
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
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **string** (date-time)

The time when the Operation resource was last modified.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| done | **boolean**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[GenerateCsrForCertificateAuthorityMetadata](#yandex.cloud.priv.certificatemanager.v1.privateca.GenerateCsrForCertificateAuthorityMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[Status](#google.rpc.Status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **[CsrForSignCertificateAuthority](#yandex.cloud.priv.certificatemanager.v1.privateca.CsrForSignCertificateAuthority)**

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

## GenerateCsrForCertificateAuthorityMetadata {#yandex.cloud.priv.certificatemanager.v1.privateca.GenerateCsrForCertificateAuthorityMetadata}

Metadata returned from the GenerateCsrForCertificateAuthority operation.

#|
||Field | Description ||
|| certificateAuthorityId | **string**

The ID of the Certificate Authority for which the CSR was generated. ||
|#

## Status {#google.rpc.Status}

The error result of the operation in case of failure or cancellation.

#|
||Field | Description ||
|| code | **integer** (int32)

Error code. An enum value of [google.rpc.Code](https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto). ||
|| message | **string**

An error message. ||
|| details[] | **object**

A list of messages that carry the error details. ||
|#

## CsrForSignCertificateAuthority {#yandex.cloud.priv.certificatemanager.v1.privateca.CsrForSignCertificateAuthority}

Certificate Signing Request (CSR) for signing a certificate authority.

#|
||Field | Description ||
|| certificateAuthorityId | **string**

ID of the certificate authority for which the CSR was generated. ||
|| pemContent | **string**

PEM-encoded CSR content. ||
|#