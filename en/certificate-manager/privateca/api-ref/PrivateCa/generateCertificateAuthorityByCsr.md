---
editable: false
sourcePath: en/_api-ref/certificatemanager/v1/privateca/api-ref/PrivateCa/generateCertificateAuthorityByCsr.md
---

# Certificate Manager Private CA API, REST: PrivateCa.GenerateCertificateAuthorityByCsr

Generates a Certificate Authority (CA) by using a Certificate Signing Request (CSR).
This allows using an externally provided CSR to finalize CA creation.

## HTTP request

```
POST https://private-ca.certificate-manager.{{ api-host }}/privateca/v1/certificateAuthorities:generateByCsr
```

## Body parameters {#yandex.cloud.certificatemanager.v1.privateca.GenerateCertificateAuthorityByCsrRequest}

```json
{
  "folderId": "string",
  "parentCertificateAuthorityId": "string",
  "name": "string",
  "description": "string",
  "csr": "string",
  "privateKey": "string",
  "ttlDays": "string",
  "endEntitiesTtlLimitDays": "string",
  "templateId": "string",
  "enableCrl": "boolean",
  "enableOcsp": "boolean",
  "deletionProtection": "boolean"
}
```

Request to generate a Certificate Authority (CA) from a Certificate Signing Request (CSR).

#|
||Field | Description ||
|| folderId | **string**

Required field. Folder ID where the CA is being created. ||
|| parentCertificateAuthorityId | **string**

Optional. If set intermediate CA would be generated and signed on parent CA ||
|| name | **string**

Required field. The name of the Certificate Authority. ||
|| description | **string**

An optional description of the Certificate Authority. ||
|| csr | **string**

Required field. The PEM-encoded Certificate Signing Request (CSR) content. ||
|| privateKey | **string**

Optional. The PEM-encoded private key linked to the certificate. If absent CA would be issued with server side generated key pair ||
|| ttlDays | **string** (int64)

The Time-To-Live (TTL) in days for the CA. ||
|| endEntitiesTtlLimitDays | **string** (int64)

TTL limit in days for end-entities signed by the CA. ||
|| templateId | **string**

Optional template ID to fill certificate fields with template data. Explicitly defined parameters is preferred ||
|| enableCrl | **boolean**

Enable Certificate Revocation List (CRL) support. ||
|| enableOcsp | **boolean**

Enable Online Certificate Status Protocol (OCSP) support. ||
|| deletionProtection | **boolean**

Protect the CA from accidental deletion. ||
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
|| metadata | **[GenerateCertificateAuthorityByCsrMetadata](#yandex.cloud.certificatemanager.v1.privateca.GenerateCertificateAuthorityByCsrMetadata)**

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

## GenerateCertificateAuthorityByCsrMetadata {#yandex.cloud.certificatemanager.v1.privateca.GenerateCertificateAuthorityByCsrMetadata}

Metadata for the GenerateCertificateAuthorityByCsr operation.

#|
||Field | Description ||
|| certificateAuthorityId | **string**

The ID of the Certificate Authority being generated. ||
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

- `STATUS_UNSPECIFIED`
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