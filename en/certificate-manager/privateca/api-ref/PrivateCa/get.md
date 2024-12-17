---
editable: false
sourcePath: en/_api-ref/certificatemanager/v1/privateca/api-ref/PrivateCa/get.md
---

# Certificate Manager Private CA API, REST: PrivateCa.Get

Retrieves detailed information about a specific Certificate Authority (CA).

## HTTP request

```
GET https://private-ca.certificate-manager.{{ api-host }}/privateca/v1/certificateAuthorities/{certificateAuthorityId}
```

## Path parameters

Request to get detailed information about an existing Certificate Authority.

#|
||Field | Description ||
|| certificateAuthorityId | **string**

Required field. The ID of the Certificate Authority to retrieve.
This must be a valid Certificate Authority ID in your account. ||
|#

## Response {#yandex.cloud.certificatemanager.v1.privateca.CertificateAuthority}

**HTTP Code: 200 - OK**

```json
{
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
```

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