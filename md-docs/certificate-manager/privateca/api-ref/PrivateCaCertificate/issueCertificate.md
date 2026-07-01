# Certificate Manager Private CA API, REST: PrivateCaCertificate.IssueCertificate

Issues a new certificate for a given Certificate Authority (CA).

## HTTP request

```
POST https://private-ca.certificate-manager.api.cloud.yandex.net/privateca/v1/privateCertificates:issue
```

## Body parameters {#yandex.cloud.certificatemanager.v1.privateca.IssueCertificateRequest}

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

Required field. The ID of the Certificate Authority (CA) that will issue this certificate.

The maximum string length in characters is 50. ||
|| name | **string**

The name of the certificate.

Value must match the regular expression ``` |[a-z]([-a-z0-9]{0,61}[a-z0-9])? ```. ||
|| description | **string**

A description of the certificate.

The maximum string length in characters is 1024. ||
|| subject | **[Subject](#yandex.cloud.certificatemanager.v1.privateca.Subject)**

Details about the certificate subject (e.g., CN, O, etc.). ||
|| signingAlgorithm | **enum** (Algorithm)

The algorithm the CA will use to sign and issue the certificate.

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
|| subjectAlternativeNames[] | **[SubjectAlternativeName](#yandex.cloud.certificatemanager.v1.privateca.SubjectAlternativeName)**

Subject Alternative Names (SANs) for the certificate, such as DNS entries or IP addresses. ||
|| templateId | **string**

Optional certificate template ID. Issue certificate with template's fields if non-empty.

The maximum string length in characters is 50. ||
|| deletionProtection | **boolean**

Flag to protect the certificate from being accidentally deleted. ||
|| desiredTtlDays | **string** (int64)

Desired time-to-live (TTL) of the certificate in days.

The maximum value is 20000. ||
|#

## Subject {#yandex.cloud.certificatemanager.v1.privateca.Subject}

Subject field of certificate https://datatracker.ietf.org/doc/html/rfc5280#section-4.1.2.6

#|
||Field | Description ||
|| baseRdn | **[BaseRDN](#yandex.cloud.certificatemanager.v1.privateca.BaseRDN)**

Required field. Most used field of subject ||
|| additionalRdn | **[AdditionalRDN](#yandex.cloud.certificatemanager.v1.privateca.AdditionalRDN)**

Additional fields of subject ||
|#

## BaseRDN {#yandex.cloud.certificatemanager.v1.privateca.BaseRDN}

https://datatracker.ietf.org/doc/html/rfc5280#section-4.1.2.4

#|
||Field | Description ||
|| country | **string**

Two letter county code

The maximum string length in characters is 2. ||
|| organization | **string**

Organization name in arbitrary form

The maximum string length in characters is 1000. ||
|| organizationalUnit | **string**

Organizational unit name in arbitrary form

The maximum string length in characters is 1000. ||
|| distinguishedNameQualifier | **string**

Distinguished name qualifier

The maximum string length in characters is 10000. ||
|| stateOrProvince | **string**

State or province name in arbitrary form

The maximum string length in characters is 1000. ||
|| commonName | **string**

Common name. For tls certificates it is domain usually.

The maximum string length in characters is 10000. ||
|| emailAddress | **string**

Email address of certificate owner

The maximum string length in characters is 1000. ||
|#

## AdditionalRDN {#yandex.cloud.certificatemanager.v1.privateca.AdditionalRDN}

https://datatracker.ietf.org/doc/html/rfc5280#section-4.1.2.4

#|
||Field | Description ||
|| serialNumber | **string**

Serial number of certificate subject in arbitrary form. Don't confuse with certificate serial number.

The maximum string length in characters is 100. ||
|| locality | **string**

Locality of certificate subject in arbitrary form.

The maximum string length in characters is 1000. ||
|| title | **string**

Title of certificate subject in arbitrary form.

The maximum string length in characters is 1000. ||
|| surname | **string**

Surname of certificate subject in arbitrary form.

The maximum string length in characters is 1000. ||
|| givenName | **string**

Given name of certificate subject in arbitrary form.

The maximum string length in characters is 1000. ||
|| initials | **string**

Initials of certificate subject in arbitrary form.

The maximum string length in characters is 1000. ||
|| generationQualifier | **string**

Generation qualifier of certificate subject in arbitrary form.

The maximum string length in characters is 1000. ||
|#

## SubjectAlternativeName {#yandex.cloud.certificatemanager.v1.privateca.SubjectAlternativeName}

Extend subject of certificate https://datatracker.ietf.org/doc/html/rfc5280#section-4.2.1.6

#|
||Field | Description ||
|| otherName | **[OtherName](#yandex.cloud.certificatemanager.v1.privateca.OtherName)**

Local defined identifier in arbitrary form

Includes only one of the fields `otherName`, `rfc_822Name`, `dnsName`, `x_400Name`, `directoryName`, `ediPartyName`, `uniformResourceIdentifier`, `ipAddress`, `registeredId`.

https://datatracker.ietf.org/doc/html/rfc5280#section-4.2.1.6 ||
|| rfc_822Name | **string**

Encoded email address

The maximum string length in characters is 1000.

Includes only one of the fields `otherName`, `rfc_822Name`, `dnsName`, `x_400Name`, `directoryName`, `ediPartyName`, `uniformResourceIdentifier`, `ipAddress`, `registeredId`.

https://datatracker.ietf.org/doc/html/rfc5280#section-4.2.1.6 ||
|| dnsName | **string**

Widely used in tls certificates for domains

The maximum string length in characters is 1000.

Includes only one of the fields `otherName`, `rfc_822Name`, `dnsName`, `x_400Name`, `directoryName`, `ediPartyName`, `uniformResourceIdentifier`, `ipAddress`, `registeredId`.

https://datatracker.ietf.org/doc/html/rfc5280#section-4.2.1.6 ||
|| x_400Name | **string**

x400 name https://en.wikipedia.org/wiki/X.400

The maximum string length in characters is 1000.

Includes only one of the fields `otherName`, `rfc_822Name`, `dnsName`, `x_400Name`, `directoryName`, `ediPartyName`, `uniformResourceIdentifier`, `ipAddress`, `registeredId`.

https://datatracker.ietf.org/doc/html/rfc5280#section-4.2.1.6 ||
|| directoryName | **string**

Represents sequence of rdn for uniquely identifying entities

The maximum string length in characters is 1000.

Includes only one of the fields `otherName`, `rfc_822Name`, `dnsName`, `x_400Name`, `directoryName`, `ediPartyName`, `uniformResourceIdentifier`, `ipAddress`, `registeredId`.

https://datatracker.ietf.org/doc/html/rfc5280#section-4.2.1.6 ||
|| ediPartyName | **[EdiPartyName](#yandex.cloud.certificatemanager.v1.privateca.EdiPartyName)**

Electronic Data Interchange entity

Includes only one of the fields `otherName`, `rfc_822Name`, `dnsName`, `x_400Name`, `directoryName`, `ediPartyName`, `uniformResourceIdentifier`, `ipAddress`, `registeredId`.

https://datatracker.ietf.org/doc/html/rfc5280#section-4.2.1.6 ||
|| uniformResourceIdentifier | **string**

URI

The maximum string length in characters is 1000.

Includes only one of the fields `otherName`, `rfc_822Name`, `dnsName`, `x_400Name`, `directoryName`, `ediPartyName`, `uniformResourceIdentifier`, `ipAddress`, `registeredId`.

https://datatracker.ietf.org/doc/html/rfc5280#section-4.2.1.6 ||
|| ipAddress | **string**

ip address of certificate subject. May be used in tls certificates

The maximum string length in characters is 45.

Includes only one of the fields `otherName`, `rfc_822Name`, `dnsName`, `x_400Name`, `directoryName`, `ediPartyName`, `uniformResourceIdentifier`, `ipAddress`, `registeredId`.

https://datatracker.ietf.org/doc/html/rfc5280#section-4.2.1.6 ||
|| registeredId | **string**

Object Identifier (OID)

The maximum string length in characters is 1000.

Includes only one of the fields `otherName`, `rfc_822Name`, `dnsName`, `x_400Name`, `directoryName`, `ediPartyName`, `uniformResourceIdentifier`, `ipAddress`, `registeredId`.

https://datatracker.ietf.org/doc/html/rfc5280#section-4.2.1.6 ||
|#

## OtherName {#yandex.cloud.certificatemanager.v1.privateca.OtherName}

#|
||Field | Description ||
|| typeOid | **string**

Object identifier for name type

The maximum string length in characters is 1000. ||
|| name | **string**

DER encoded value of type with type_oid

The maximum string length in characters is 1000. ||
|#

## EdiPartyName {#yandex.cloud.certificatemanager.v1.privateca.EdiPartyName}

#|
||Field | Description ||
|| nameAssigner | **string**

Specifies the entity or authority that assigned the partyName

The maximum string length in characters is 1000. ||
|| partyName | **string**

The actual identifier of the EDI party

The maximum string length in characters is 1000. ||
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
  "metadata": "object",
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": "object"
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](../../../../api-design-guide/concepts/operation.md).

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
|| metadata | **object**

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
|| response | **object**

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