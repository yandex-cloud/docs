---
editable: false
sourcePath: en/_api-ref/certificatemanager/v1/privateca/api-ref/PrivateCaCertificate/get.md
---

# Certificate Manager Private CA API, REST: PrivateCaCertificate.Get

Retrieves information about a specific certificate.

## HTTP request

```
GET https://private-ca.certificate-manager.{{ api-host }}/privateca/v1/privateCertificates/{certificateId}
```

## Path parameters

Request to retrieve details of a specific certificate.

#|
||Field | Description ||
|| certificateId | **string**

Required field. The ID of the certificate to retrieve. ||
|#

## Response {#yandex.cloud.priv.certificatemanager.v1.privateca.PrivateCertificate}

**HTTP Code: 200 - OK**

```json
{
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
```

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