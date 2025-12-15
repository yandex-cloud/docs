---
editable: false
apiPlayground:
  - url: https://organization-manager.{{ api-host }}/organization-manager/v1/idp/application/saml/signature-certificates
    method: get
    path: null
    query:
      type: object
      properties:
        applicationId:
          description: |-
            **string**
            Required field. ID of the SAML application to list certificates for.
            The maximum string length in characters is 50.
          type: string
        pageSize:
          description: |-
            **string** (int64)
            The maximum number of results per page to return.
            Acceptable values are 0 to 1000, inclusive.
          type: string
          format: int64
        pageToken:
          description: |-
            **string**
            Page token for pagination.
            The maximum string length in characters is 2000.
          type: string
        filter:
          description: |-
            **string**
            A filter expression that filters resources listed in the response.
            The maximum string length in characters is 1000.
          type: string
      required:
        - applicationId
      additionalProperties: false
    body: null
    definitions: null
sourcePath: en/_api-ref/organizationmanager/v1/idp/application/saml/api-ref/SignatureCertificate/list.md
---

# SAML Application API, REST: SignatureCertificate.List

Retrieves the list of signature certificates for the specified SAML application.

## HTTP request

```
GET https://organization-manager.{{ api-host }}/organization-manager/v1/idp/application/saml/signature-certificates
```

## Query parameters {#yandex.cloud.organizationmanager.v1.idp.application.saml.ListSignatureCertificatesRequest}

Request to list signature certificates for a SAML application.

#|
||Field | Description ||
|| applicationId | **string**

Required field. ID of the SAML application to list certificates for.

The maximum string length in characters is 50. ||
|| pageSize | **string** (int64)

The maximum number of results per page to return.

Acceptable values are 0 to 1000, inclusive. ||
|| pageToken | **string**

Page token for pagination.

The maximum string length in characters is 2000. ||
|| filter | **string**

A filter expression that filters resources listed in the response.

The maximum string length in characters is 1000. ||
|#

## Response {#yandex.cloud.organizationmanager.v1.idp.application.saml.ListSignatureCertificatesResponse}

**HTTP Code: 200 - OK**

```json
{
  "signatureCertificates": [
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
  ],
  "nextPageToken": "string"
}
```

Response message for [SignatureCertificateService.List](#List).

#|
||Field | Description ||
|| signatureCertificates[] | **[SignatureCertificate](#yandex.cloud.organizationmanager.v1.idp.application.saml.SignatureCertificate)**

List of signature certificates. ||
|| nextPageToken | **string**

Token for getting the next page of the list. ||
|#

## SignatureCertificate {#yandex.cloud.organizationmanager.v1.idp.application.saml.SignatureCertificate}

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