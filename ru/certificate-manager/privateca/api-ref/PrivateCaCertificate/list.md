---
editable: false
sourcePath: en/_api-ref/certificatemanager/v1/privateca/api-ref/PrivateCaCertificate/list.md
---

# Certificate Manager Private CA API, REST: PrivateCaCertificate.List

Lists the certificates issued by a given Certificate Authority (CA).

## HTTP request

```
GET https://private-ca.certificate-manager.{{ api-host }}/privateca/v1/privateCertificates
```

## Query parameters {#yandex.cloud.certificatemanager.v1.privateca.ListCertificatesRequest}

Request to list certificates issued by a specific Certificate Authority.

#|
||Field | Description ||
|| certificateAuthorityId | **string**

Required field. The ID of the Certificate Authority issuing the certificates. ||
|| pageSize | **string** (int64)

Maximum number of certificates to return per page, optional. Default is 100. ||
|| pageToken | **string**

Page token, allows request for the next page of results from a previous list call. ||
|#

## Response {#yandex.cloud.certificatemanager.v1.privateca.ListCertificatesResponse}

**HTTP Code: 200 - OK**

```json
{
  "certificates": [
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
  ],
  "nextPageToken": "string"
}
```

Response to the `ListCertificates` request, containing the certificates and pagination information.

#|
||Field | Description ||
|| certificates[] | **[PrivateCertificate](#yandex.cloud.certificatemanager.v1.privateca.PrivateCertificate)**

The list of certificates issued by the Certificate Authority. ||
|| nextPageToken | **string**

Token to use to fetch the next page of results, if there are more results. ||
|#

## PrivateCertificate {#yandex.cloud.certificatemanager.v1.privateca.PrivateCertificate}

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