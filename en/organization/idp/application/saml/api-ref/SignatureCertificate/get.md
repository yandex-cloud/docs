---
editable: false
apiPlayground:
  - url: https://organization-manager.{{ api-host }}/organization-manager/v1/idp/application/saml/signature-certificates/{signatureCertificateId}
    method: get
    path:
      type: object
      properties:
        signatureCertificateId:
          description: |-
            **string**
            Required field. ID of the signature certificate to return.
            The maximum string length in characters is 50.
          type: string
      required:
        - signatureCertificateId
      additionalProperties: false
    query: null
    body: null
    definitions: null
---

# SAML Application API, REST: SignatureCertificate.Get

Returns the specified signature certificate.

To get the list of available certificates, make a [List](/docs/organization/idp/application/saml/mapi-ref/SignatureCertificate/list#List) request.

## HTTP request

```
GET https://organization-manager.{{ api-host }}/organization-manager/v1/idp/application/saml/signature-certificates/{signatureCertificateId}
```

## Path parameters

Request to get a signature certificate by ID.

#|
||Field | Description ||
|| signatureCertificateId | **string**

Required field. ID of the signature certificate to return.

The maximum string length in characters is 50. ||
|#

## Response {#yandex.cloud.organizationmanager.v1.idp.application.saml.SignatureCertificate}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "applicationId": "string",
  "status": "string",
  "name": "string",
  "description": "string",
  "createdAt": "string",
  "data": "string",
  "fingerprint": "string",
  "notAfter": "string",
  "notBefore": "string"
}
```

A signature certificate for SAML applications.

#|
||Field | Description ||
|| id | **string**

Unique identifier of the signature certificate. ||
|| applicationId | **string**

ID of the SAML application that the signature certificate belongs to. ||
|| status | **enum** (Status)

Current status of the signature certificate.

- `ACTIVE`: The certificate is active and can be used for signing.
- `INACTIVE`: The certificate is inactive and cannot be used for signing. ||
|| name | **string**

Name of the signature certificate. ||
|| description | **string**

Description of the signature certificate. ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| data | **string**

Certificate data in PEM format. ||
|| fingerprint | **string**

SHA256-fingerprint of the signature certificate. ||
|| notAfter | **string** (date-time)

Time after which the signature certificate is not valid.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| notBefore | **string** (date-time)

Time before which the signature certificate is not valid.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|#