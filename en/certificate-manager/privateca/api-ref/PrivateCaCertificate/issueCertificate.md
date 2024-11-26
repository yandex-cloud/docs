---
editable: false
sourcePath: en/_api-ref/certificatemanager/v1/privateca/api-ref/PrivateCaCertificate/issueCertificate.md
---

# Certificate Manager Private CA API, REST: PrivateCaCertificate.IssueCertificate

Issues a new certificate for a given Certificate Authority (CA).

## HTTP request

```
POST https://private-ca.certificate-manager.{{ api-host }}/privateca/v1/privateCertificates:issue
```

## Body parameters {#yandex.cloud.priv.certificatemanager.v1.privateca.IssueCertificateRequest}

```json
{
  "certificateAuthorityId": "string",
  "name": "string",
  "description": "string",
  "subject": {
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
  "signingAlgorithm": "string",
  "keyUsage": [
    "string"
  ],
  "extendedKeyUsage": [
    "string"
  ],
  "subjectAlternativeNames": [
    {
      // Includes only one of the fields `otherName`, `rfc_822Name`, `dnsName`, `x_400Name`, `directoryName`, `ediPartyName`, `uniformResourceIdentifier`, `ipAddress`, `registeredId`
      "otherName": {
        "typeOid": "string",
        "name": "string"
      },
      "rfc_822Name": "string",
      "dnsName": "string",
      "x_400Name": "string",
      "directoryName": "string",
      "ediPartyName": {
        "nameAssigner": "string",
        "partyName": "string"
      },
      "uniformResourceIdentifier": "string",
      "ipAddress": "string",
      "registeredId": "string"
      // end of the list of possible fields
    }
  ],
  "templateId": "string",
  "deletionProtection": "boolean",
  "desiredTtlDays": "string"
}
```

Request to issue a new certificate for a given Certificate Authority.

#|
||Field | Description ||
|| certificateAuthorityId | **string**

Required field. The ID of the Certificate Authority (CA) that will issue this certificate. ||
|| name | **string**

The name of the certificate. ||
|| description | **string**

A description of the certificate. ||
|| subject | **[Subject](#yandex.cloud.priv.certificatemanager.v1.privateca.Subject)**

Details about the certificate subject (e.g., CN, O, etc.). ||
|| signingAlgorithm | **enum** (Algorithm)

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
|| keyUsage[] | **enum** (KeyUsageExtension)

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
|| extendedKeyUsage[] | **enum** (ExtendedKeyUsageExtension)

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
|| subjectAlternativeNames[] | **[SubjectAlternativeName](#yandex.cloud.priv.certificatemanager.v1.privateca.SubjectAlternativeName)**

Subject Alternative Names (SANs) for the certificate, such as DNS entries or IP addresses. ||
|| templateId | **string**

Optional certificate template ID. Issue certificate with template's fields if non-empty. ||
|| deletionProtection | **boolean**

Flag to protect the certificate from being accidentally deleted. ||
|| desiredTtlDays | **string** (int64)

Desired time-to-live (TTL) of the certificate in days. ||
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

## SubjectAlternativeName {#yandex.cloud.priv.certificatemanager.v1.privateca.SubjectAlternativeName}

Extend subject of certificate https://datatracker.ietf.org/doc/html/rfc5280#section-4.2.1.6

#|
||Field | Description ||
|| otherName | **[OtherName](#yandex.cloud.priv.certificatemanager.v1.privateca.OtherName)**

Local defined identifier in arbitrary form

Includes only one of the fields `otherName`, `rfc_822Name`, `dnsName`, `x_400Name`, `directoryName`, `ediPartyName`, `uniformResourceIdentifier`, `ipAddress`, `registeredId`.

https://datatracker.ietf.org/doc/html/rfc5280#section-4.2.1.6 ||
|| rfc_822Name | **string**

Encoded email address

Includes only one of the fields `otherName`, `rfc_822Name`, `dnsName`, `x_400Name`, `directoryName`, `ediPartyName`, `uniformResourceIdentifier`, `ipAddress`, `registeredId`.

https://datatracker.ietf.org/doc/html/rfc5280#section-4.2.1.6 ||
|| dnsName | **string**

Widely used in tls certificates for domains

Includes only one of the fields `otherName`, `rfc_822Name`, `dnsName`, `x_400Name`, `directoryName`, `ediPartyName`, `uniformResourceIdentifier`, `ipAddress`, `registeredId`.

https://datatracker.ietf.org/doc/html/rfc5280#section-4.2.1.6 ||
|| x_400Name | **string**

x400 name https://en.wikipedia.org/wiki/X.400

Includes only one of the fields `otherName`, `rfc_822Name`, `dnsName`, `x_400Name`, `directoryName`, `ediPartyName`, `uniformResourceIdentifier`, `ipAddress`, `registeredId`.

https://datatracker.ietf.org/doc/html/rfc5280#section-4.2.1.6 ||
|| directoryName | **string**

Represents sequence of rdn for uniquely identifying entities

Includes only one of the fields `otherName`, `rfc_822Name`, `dnsName`, `x_400Name`, `directoryName`, `ediPartyName`, `uniformResourceIdentifier`, `ipAddress`, `registeredId`.

https://datatracker.ietf.org/doc/html/rfc5280#section-4.2.1.6 ||
|| ediPartyName | **[EdiPartyName](#yandex.cloud.priv.certificatemanager.v1.privateca.EdiPartyName)**

Electronic Data Interchange entity

Includes only one of the fields `otherName`, `rfc_822Name`, `dnsName`, `x_400Name`, `directoryName`, `ediPartyName`, `uniformResourceIdentifier`, `ipAddress`, `registeredId`.

https://datatracker.ietf.org/doc/html/rfc5280#section-4.2.1.6 ||
|| uniformResourceIdentifier | **string**

URI

Includes only one of the fields `otherName`, `rfc_822Name`, `dnsName`, `x_400Name`, `directoryName`, `ediPartyName`, `uniformResourceIdentifier`, `ipAddress`, `registeredId`.

https://datatracker.ietf.org/doc/html/rfc5280#section-4.2.1.6 ||
|| ipAddress | **string**

ip address of certificate subject. May be used in tls certificates

Includes only one of the fields `otherName`, `rfc_822Name`, `dnsName`, `x_400Name`, `directoryName`, `ediPartyName`, `uniformResourceIdentifier`, `ipAddress`, `registeredId`.

https://datatracker.ietf.org/doc/html/rfc5280#section-4.2.1.6 ||
|| registeredId | **string**

Object Identifier (OID)

Includes only one of the fields `otherName`, `rfc_822Name`, `dnsName`, `x_400Name`, `directoryName`, `ediPartyName`, `uniformResourceIdentifier`, `ipAddress`, `registeredId`.

https://datatracker.ietf.org/doc/html/rfc5280#section-4.2.1.6 ||
|#

## OtherName {#yandex.cloud.priv.certificatemanager.v1.privateca.OtherName}

#|
||Field | Description ||
|| typeOid | **string**

Object identifier for name type ||
|| name | **string**

DER encoded value of type with type_oid ||
|#

## EdiPartyName {#yandex.cloud.priv.certificatemanager.v1.privateca.EdiPartyName}

#|
||Field | Description ||
|| nameAssigner | **string**

Specifies the entity or authority that assigned the partyName ||
|| partyName | **string**

The actual identifier of the EDI party ||
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
    "certificateId": "string"
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
    "id": "string",
    "certificateAuthorityId": "string",
    "name": "string",
    "description": "string",
    "issuedAt": "string",
    "notAfter": "string",
    "notBefore": "string",
    "deletionProtection": "boolean",
    "createdAt": "string",
    "updatedAt": "string"
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
|| metadata | **[IssueCertificateMetadata](#yandex.cloud.priv.certificatemanager.v1.privateca.IssueCertificateMetadata)**

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
|| response | **[PrivateCertificate](#yandex.cloud.priv.certificatemanager.v1.privateca.PrivateCertificate)**

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

## IssueCertificateMetadata {#yandex.cloud.priv.certificatemanager.v1.privateca.IssueCertificateMetadata}

Metadata for the `IssueCertificate` operation, tracking the ID of the new certificate.

#|
||Field | Description ||
|| certificateId | **string**

The ID of the certificate that was issued. ||
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

## PrivateCertificate {#yandex.cloud.priv.certificatemanager.v1.privateca.PrivateCertificate}

A private certificate issued by a private certificate authority.

#|
||Field | Description ||
|| id | **string**

ID of the private certificate. ||
|| certificateAuthorityId | **string**

ID of the certificate authority that issued the private certificate. ||
|| name | **string**

Name of the private certificate. ||
|| description | **string**

Description of the private certificate. ||
|| issuedAt | **string** (date-time)

Time when the private certificate was issued.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| notAfter | **string** (date-time)

Time after which the private certificate is not valid.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| notBefore | **string** (date-time)

Time before which the private certificate is not valid.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| deletionProtection | **boolean**

Flag that protects deletion of the private certificate. ||
|| createdAt | **string** (date-time)

Time when the private certificate was created.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| updatedAt | **string** (date-time)

Time when the private certificate was updated.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|#