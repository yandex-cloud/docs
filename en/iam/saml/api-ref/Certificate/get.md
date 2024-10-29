---
editable: false
sourcePath: en/_api-ref/iam/v1/saml/api-ref/Certificate/get.md
---

# Identity and Access Management SAML API, REST: Certificate.Get {#Get}

Returns the specified certificate.

To get the list of available certificates, make a [List](/docs/iam/api-ref/Certificate/list#List) request.

## HTTP request

```
GET https://iam.{{ api-host }}/iam/v1/saml/certificates/{certificateId}
```

## Path parameters

#|
||Field | Description ||
|| certificateId | **string**

Required field. ID of the certificate to return.
To get the certificate ID, make a [CertificateService.List](/docs/iam/api-ref/Certificate/list#List) request. ||
|#

## Response {#yandex.cloud.iam.v1.saml.Certificate}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "federationId": "string",
  "name": "string",
  "description": "string",
  "createdAt": "string",
  "data": "string"
}
```

A certificate.

#|
||Field | Description ||
|| id | **string**

Required field. ID of the certificate. ||
|| federationId | **string**

Required field. ID of the federation that the certificate belongs to. ||
|| name | **string**

Name of the certificate. ||
|| description | **string**

Description of the certificate. ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| data | **string**

Required field. Certificate data in PEM format. ||
|#