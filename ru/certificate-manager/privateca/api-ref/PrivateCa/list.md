---
editable: false
apiPlayground:
  - url: https://private-ca.certificate-manager.{{ api-host }}/privateca/v1/certificateAuthorities
    method: get
    path: null
    query:
      type: object
      properties:
        folderId:
          description: |-
            **string**
            Required field. The folder in which CA would be listed.
          type: string
        pageSize:
          description: |-
            **string** (int64)
            The maximum number of results to return per page. Couldn't exceed 100, default value is 100
          type: string
          format: int64
        pageToken:
          description: |-
            **string**
            Token to retrieve the next page of results.
            This is returned from a previous call to ListCertificateAuthorities.
          type: string
      required:
        - folderId
      additionalProperties: false
    body: null
    definitions: null
sourcePath: en/_api-ref/certificatemanager/v1/privateca/api-ref/PrivateCa/list.md
---

# Certificate Manager Private CA API, REST: PrivateCa.List

Lists the available Certificate Authorities (CAs).

## HTTP request

```
GET https://private-ca.certificate-manager.{{ api-host }}/privateca/v1/certificateAuthorities
```

## Query parameters {#yandex.cloud.certificatemanager.v1.privateca.ListCertificateAuthoritiesRequest}

List Certificate Authorities in specified folder.
This supports pagination.

#|
||Field | Description ||
|| folderId | **string**

Required field. The folder in which CA would be listed. ||
|| pageSize | **string** (int64)

The maximum number of results to return per page. Couldn't exceed 100, default value is 100 ||
|| pageToken | **string**

Token to retrieve the next page of results.
This is returned from a previous call to ListCertificateAuthorities. ||
|#

## Response {#yandex.cloud.certificatemanager.v1.privateca.ListCertificateAuthoritiesResponse}

**HTTP Code: 200 - OK**

```json
{
  "certificateAuthorities": [
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
  ],
  "nextPageToken": "string"
}
```

Response containing the Certificate Authorities list from the ListCertificateAuthorities request.

#|
||Field | Description ||
|| certificateAuthorities[] | **[CertificateAuthority](#yandex.cloud.certificatemanager.v1.privateca.CertificateAuthority)**

List of matching Certificate Authorities. ||
|| nextPageToken | **string**

Token to retrieve the next page of results, if they were paginated. ||
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