---
editable: false
apiPlayground:
  - url: https://private-ca.certificate-manager.{{ api-host }}/privateca/v1/certificateAuthorities:generate
    method: post
    path: null
    query: null
    body:
      type: object
      properties:
        folderId:
          description: |-
            **string**
            Required field. Folder ID where the CA is being created.
            The maximum string length in characters is 50.
          type: string
        parentCertificateAuthorityId:
          description: |-
            **string**
            Optional. If set intermediate CA would be generated and signed on parent CA
            The maximum string length in characters is 50.
          type: string
        name:
          description: |-
            **string**
            Required field. The name of the Certificate Authority.
            Value must match the regular expression ` |[a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
          pattern: '|[a-z]([-a-z0-9]{0,61}[a-z0-9])?'
          type: string
        description:
          description: |-
            **string**
            An optional description of the Certificate Authority.
            The maximum string length in characters is 1024.
          type: string
        subjectSpec:
          description: |-
            **[Subject](#yandex.cloud.certificatemanager.v1.privateca.Subject)**
            Required field. The subject (e.g., common name, organization, etc.) for the CA.
          $ref: '#/definitions/Subject'
        algorithm:
          description: |-
            **enum** (Algorithm)
            Required field. The algorithm for the asymmetric key generation (e.g., RSA, ECC).
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
            - `RSA_4096_PKCS1_5_SHA_512`
          type: string
          enum:
            - ALGORITHM_UNSPECIFIED
            - RSA_2048_PSS_SHA_256
            - RSA_2048_PSS_SHA_384
            - RSA_2048_PSS_SHA_512
            - RSA_3072_PSS_SHA_256
            - RSA_3072_PSS_SHA_384
            - RSA_3072_PSS_SHA_512
            - RSA_4096_PSS_SHA_256
            - RSA_4096_PSS_SHA_384
            - RSA_4096_PSS_SHA_512
            - ECDSA_NIST_P256_SHA_256
            - ECDSA_NIST_P384_SHA_384
            - ECDSA_NIST_P521_SHA_512
            - ECDSA_SECP256_K1_SHA_256
            - RSA_2048_PKCS1_5_SHA_256
            - RSA_2048_PKCS1_5_SHA_384
            - RSA_2048_PKCS1_5_SHA_512
            - RSA_3072_PKCS1_5_SHA_256
            - RSA_3072_PKCS1_5_SHA_384
            - RSA_3072_PKCS1_5_SHA_512
            - RSA_4096_PKCS1_5_SHA_256
            - RSA_4096_PKCS1_5_SHA_384
            - RSA_4096_PKCS1_5_SHA_512
        pathLen:
          description: |-
            **string** (int64)
            The maximum length of the certificate chain.
          type: string
          format: int64
        keyUsage:
          description: |-
            **enum** (KeyUsageExtension)
            Key usage (e.g., keyEncipherment, digitalSignature).
            The maximum number of elements is 9.
            - `DIGITAL_SIGNATURE`
            - `CONTENT_COMMITMENT`
            - `KEY_ENCIPHERMENT`
            - `DATA_ENCIPHERMENT`
            - `KEY_AGREEMENT`
            - `KEY_CERT_SIGN`
            - `CRL_SIGN`
            - `ENCIPHER_ONLY`
            - `DECIPHER_ONLY`
          type: array
          items:
            type: string
            enum:
              - KEY_USAGE_EXTENSION_UNSPECIFIED
              - DIGITAL_SIGNATURE
              - CONTENT_COMMITMENT
              - KEY_ENCIPHERMENT
              - DATA_ENCIPHERMENT
              - KEY_AGREEMENT
              - KEY_CERT_SIGN
              - CRL_SIGN
              - ENCIPHER_ONLY
              - DECIPHER_ONLY
        extendedKeyUsage:
          description: |-
            **enum** (ExtendedKeyUsageExtension)
            Extended key usage (e.g., serverAuth, clientAuth).
            The maximum number of elements is 11.
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
            - `MS_EFS`
          type: array
          items:
            type: string
            enum:
              - EXTENDED_KEY_USAGE_EXTENSION_UNSPECIFIED
              - SERVER_AUTH
              - CLIENT_AUTH
              - CODE_SIGNING
              - EMAIL_PROTECTION
              - TIME_STAMPING
              - OCSP_SIGNING
              - IPSEC_IKE
              - MS_CODE_IND
              - MS_CODE_COM
              - MS_CTL_SIGN
              - MS_EFS
        ttlDays:
          description: |-
            **string** (int64)
            The Time-To-Live (TTL) in days for the CA.
            Acceptable values are 1 to 20000, inclusive.
          type: string
          format: int64
        endEntitiesTtlLimitDays:
          description: |-
            **string** (int64)
            TTL limit in days for end-entities signed by the CA.
            The maximum value is 20000.
          type: string
          format: int64
        templateId:
          description: |-
            **string**
            Optional template ID to fill certificate fields with template data. Explicitly defined parameters is preferred
            The maximum string length in characters is 50.
          type: string
        enableCrl:
          description: |-
            **boolean**
            Enable Certificate Revocation List (CRL) support.
          type: boolean
        enableOcsp:
          description: |-
            **boolean**
            Enable Online Certificate Status Protocol (OCSP) support.
          type: boolean
        deletionProtection:
          description: |-
            **boolean**
            Protect the CA from accidental deletion. Deny deletion of ca if set
          type: boolean
      required:
        - folderId
        - name
        - subjectSpec
        - algorithm
      additionalProperties: false
    definitions:
      BaseRDN:
        type: object
        properties:
          country:
            description: |-
              **string**
              Two letter county code
              The maximum string length in characters is 2.
            type: string
          organization:
            description: |-
              **string**
              Organization name in arbitrary form
              The maximum string length in characters is 1000.
            type: string
          organizationalUnit:
            description: |-
              **string**
              Organizational unit name in arbitrary form
              The maximum string length in characters is 1000.
            type: string
          distinguishedNameQualifier:
            description: |-
              **string**
              Distinguished name qualifier
              The maximum string length in characters is 10000.
            type: string
          stateOrProvince:
            description: |-
              **string**
              State or province name in arbitrary form
              The maximum string length in characters is 1000.
            type: string
          commonName:
            description: |-
              **string**
              Common name. For tls certificates it is domain usually.
              The maximum string length in characters is 10000.
            type: string
          emailAddress:
            description: |-
              **string**
              Email address of certificate owner
              The maximum string length in characters is 1000.
            type: string
      AdditionalRDN:
        type: object
        properties:
          serialNumber:
            description: |-
              **string**
              Serial number of certificate subject in arbitrary form. Don't confuse with certificate serial number.
              The maximum string length in characters is 100.
            type: string
          locality:
            description: |-
              **string**
              Locality of certificate subject in arbitrary form.
              The maximum string length in characters is 1000.
            type: string
          title:
            description: |-
              **string**
              Title of certificate subject in arbitrary form.
              The maximum string length in characters is 1000.
            type: string
          surname:
            description: |-
              **string**
              Surname of certificate subject in arbitrary form.
              The maximum string length in characters is 1000.
            type: string
          givenName:
            description: |-
              **string**
              Given name of certificate subject in arbitrary form.
              The maximum string length in characters is 1000.
            type: string
          initials:
            description: |-
              **string**
              Initials of certificate subject in arbitrary form.
              The maximum string length in characters is 1000.
            type: string
          generationQualifier:
            description: |-
              **string**
              Generation qualifier of certificate subject in arbitrary form.
              The maximum string length in characters is 1000.
            type: string
      Subject:
        type: object
        properties:
          baseRdn:
            description: |-
              **[BaseRDN](#yandex.cloud.certificatemanager.v1.privateca.BaseRDN)**
              Required field. Most used field of subject
            $ref: '#/definitions/BaseRDN'
          additionalRdn:
            description: |-
              **[AdditionalRDN](#yandex.cloud.certificatemanager.v1.privateca.AdditionalRDN)**
              Additional fields of subject
            $ref: '#/definitions/AdditionalRDN'
        required:
          - baseRdn
---

# Certificate Manager Private CA API, REST: PrivateCa.GenerateCertificateAuthority

Generates a new Certificate Authority (CA).
This endpoint creates a new CA with given properties and cryptographic settings.

## HTTP request

```
POST https://private-ca.certificate-manager.{{ api-host }}/privateca/v1/certificateAuthorities:generate
```

## Body parameters {#yandex.cloud.certificatemanager.v1.privateca.GenerateCertificateAuthorityRequest}

```json
{
  "folderId": "string",
  "parentCertificateAuthorityId": "string",
  "name": "string",
  "description": "string",
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

Request to generate a new Certificate Authority (CA).

#|
||Field | Description ||
|| folderId | **string**

Required field. Folder ID where the CA is being created.

The maximum string length in characters is 50. ||
|| parentCertificateAuthorityId | **string**

Optional. If set intermediate CA would be generated and signed on parent CA

The maximum string length in characters is 50. ||
|| name | **string**

Required field. The name of the Certificate Authority.

Value must match the regular expression ``` |[a-z]([-a-z0-9]{0,61}[a-z0-9])? ```. ||
|| description | **string**

An optional description of the Certificate Authority.

The maximum string length in characters is 1024. ||
|| subjectSpec | **[Subject](#yandex.cloud.certificatemanager.v1.privateca.Subject)**

Required field. The subject (e.g., common name, organization, etc.) for the CA. ||
|| algorithm | **enum** (Algorithm)

Required field. The algorithm for the asymmetric key generation (e.g., RSA, ECC).

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

The maximum length of the certificate chain. ||
|| keyUsage[] | **enum** (KeyUsageExtension)

Key usage (e.g., keyEncipherment, digitalSignature).

The maximum number of elements is 9.

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

Extended key usage (e.g., serverAuth, clientAuth).

The maximum number of elements is 11.

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

The Time-To-Live (TTL) in days for the CA.

Acceptable values are 1 to 20000, inclusive. ||
|| endEntitiesTtlLimitDays | **string** (int64)

TTL limit in days for end-entities signed by the CA.

The maximum value is 20000. ||
|| templateId | **string**

Optional template ID to fill certificate fields with template data. Explicitly defined parameters is preferred

The maximum string length in characters is 50. ||
|| enableCrl | **boolean**

Enable Certificate Revocation List (CRL) support. ||
|| enableOcsp | **boolean**

Enable Online Certificate Status Protocol (OCSP) support. ||
|| deletionProtection | **boolean**

Protect the CA from accidental deletion. Deny deletion of ca if set ||
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
    "id": "string",
    "folderId": "string",
    "name": "string",
    "description": "string",
    "parentCertificateAuthorityId": "string",
    "status": "string",
    "issuedAt": "string",
    "notAfter": "string",
    "notBefore": "string",
    "crlEndpoint": "string",
    "endEntitiesTtlLimitDays": "string",
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
|| metadata | **[GenerateCertificateAuthorityMetadata](#yandex.cloud.certificatemanager.v1.privateca.GenerateCertificateAuthorityMetadata)**

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
|| response | **[CertificateAuthority](#yandex.cloud.certificatemanager.v1.privateca.CertificateAuthority)**

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

## GenerateCertificateAuthorityMetadata {#yandex.cloud.certificatemanager.v1.privateca.GenerateCertificateAuthorityMetadata}

Metadata for the GenerateCertificateAuthority operation.

#|
||Field | Description ||
|| certificateAuthorityId | **string**

ID of the Certificate Authority being created. ||
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

## CertificateAuthority {#yandex.cloud.certificatemanager.v1.privateca.CertificateAuthority}

A certificate authority (CA) used to sign certificates.

#|
||Field | Description ||
|| id | **string**

ID of the certificate authority. ||
|| folderId | **string**

ID of the folder that the certificate authority belongs to. ||
|| name | **string**

Name of the certificate authority. ||
|| description | **string**

Description of the certificate authority. ||
|| parentCertificateAuthorityId | **string**

ID of the parent certificate authority that signed this certificate authority if any. ||
|| status | **enum** (Status)

Status of the certificate authority.

- `UNSIGNED`: The certificate authority is unsigned and pending signing.
- `ACTIVE`: The certificate authority is active and can issue certificates. ||
|| issuedAt | **string** (date-time)

Time when the certificate authority was issued.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| notAfter | **string** (date-time)

Time after which the certificate authority is not valid.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| notBefore | **string** (date-time)

Time before which the certificate authority is not valid.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| crlEndpoint | **string**

Endpoint of the certificate revocation list (CRL) for the certificate authority. ||
|| endEntitiesTtlLimitDays | **string** (int64)

Maximum allowed TTL (in days) for end-entity certificates issued by this CA. ||
|| deletionProtection | **boolean**

Flag that protects deletion of the certificate authority. ||
|| createdAt | **string** (date-time)

Time when the certificate authority was created.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| updatedAt | **string** (date-time)

Time when the certificate authority was last updated.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|#