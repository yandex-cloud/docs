---
editable: false
apiPlayground:
  - url: https://{{ api-host-certmanager }}/certificate-manager/v1/certificates
    method: get
    path: null
    query:
      type: object
      properties:
        folderId:
          description: |-
            **string**
            Required field. ID of the folder to list certificate in.
          type: string
        pageSize:
          description: |-
            **string** (int64)
            The maximum number of results per page to return. If the number of available
            results is larger than `page_size`, the service returns a [ListCertificatesResponse.nextPageToken](/docs/certificate-manager/api-ref/Certificate/list#yandex.cloud.certificatemanager.v1.ListCertificatesResponse)
            that can be used to get the next page of results in subsequent list requests.
            Default value: 100.
          type: string
          format: int64
        pageToken:
          description: |-
            **string**
            Page token. To get the next page of results, set `page_token` to the
            [ListCertificatesResponse.nextPageToken](/docs/certificate-manager/api-ref/Certificate/list#yandex.cloud.certificatemanager.v1.ListCertificatesResponse) returned by a previous list request.
          type: string
        view:
          description: |-
            **enum** (CertificateView)
            The output type of the certificate.
            - `BASIC`: Output basic information about the certificate.
            - `FULL`: Output full information about the certificate including domain challenges.
          type: string
          enum:
            - BASIC
            - FULL
      required:
        - folderId
      additionalProperties: false
    body: null
    definitions: null
sourcePath: en/_api-ref/certificatemanager/v1/api-ref/Certificate/list.md
---

# Certificate Manager API, REST: Certificate.List

Returns the list of certificates in the specified folder.

## HTTP request

```
GET https://{{ api-host-certmanager }}/certificate-manager/v1/certificates
```

## Query parameters {#yandex.cloud.certificatemanager.v1.ListCertificatesRequest}

#|
||Field | Description ||
|| folderId | **string**

Required field. ID of the folder to list certificate in. ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is larger than `page_size`, the service returns a [ListCertificatesResponse.nextPageToken](#yandex.cloud.certificatemanager.v1.ListCertificatesResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100. ||
|| pageToken | **string**

Page token. To get the next page of results, set `page_token` to the
[ListCertificatesResponse.nextPageToken](#yandex.cloud.certificatemanager.v1.ListCertificatesResponse) returned by a previous list request. ||
|| view | **enum** (CertificateView)

The output type of the certificate.

- `BASIC`: Output basic information about the certificate.
- `FULL`: Output full information about the certificate including domain challenges. ||
|#

## Response {#yandex.cloud.certificatemanager.v1.ListCertificatesResponse}

**HTTP Code: 200 - OK**

```json
{
  "certificates": [
    {
      "id": "string",
      "folderId": "string",
      "createdAt": "string",
      "name": "string",
      "description": "string",
      "labels": "object",
      "type": "string",
      "domains": [
        "string"
      ],
      "status": "string",
      "issuer": "string",
      "subject": "string",
      "serial": "string",
      "updatedAt": "string",
      "issuedAt": "string",
      "notAfter": "string",
      "notBefore": "string",
      "challenges": [
        {
          "domain": "string",
          "type": "string",
          "createdAt": "string",
          "updatedAt": "string",
          "status": "string",
          "message": "string",
          "error": "string",
          // Includes only one of the fields `dnsChallenge`, `httpChallenge`
          "dnsChallenge": {
            "name": "string",
            "type": "string",
            "value": "string"
          },
          "httpChallenge": {
            "url": "string",
            "content": "string"
          }
          // end of the list of possible fields
        }
      ],
      "deletionProtection": "boolean",
      "incompleteChain": "boolean"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| certificates[] | **[Certificate](#yandex.cloud.certificatemanager.v1.Certificate)**

List of certificates in the specified folder. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests. If the number
of results is greater than the specified [ListCertificatesRequest.pageSize](#yandex.cloud.certificatemanager.v1.ListCertificatesRequest), use
the `next_page_token` as the value for the [ListCertificatesRequest.pageToken](#yandex.cloud.certificatemanager.v1.ListCertificatesRequest) query parameter
in the next list request. Each subsequent list request will have its own
`nextPageToken` to continue paging through the results. ||
|#

## Certificate {#yandex.cloud.certificatemanager.v1.Certificate}

A certificate. For details about the concept, see [documentation](/docs/certificate-manager/concepts/).

#|
||Field | Description ||
|| id | **string**

ID of the certificate. Generated at creation time. ||
|| folderId | **string**

ID of the folder that the certificate belongs to. ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| name | **string**

Name of the certificate.
The name is unique within the folder. ||
|| description | **string**

Description of the certificate. ||
|| labels | **object** (map<**string**, **string**>)

Certificate labels as `key:value` pairs. ||
|| type | **enum** (CertificateType)

Type of the certificate.

- `CERTIFICATE_TYPE_UNSPECIFIED`
- `IMPORTED`: The certificate is imported by user.
- `MANAGED`: The certificate is created by service. ||
|| domains[] | **string**

Fully qualified domain names of the certificate. ||
|| status | **enum** (Status)

Status of the certificate.

- `STATUS_UNSPECIFIED`
- `VALIDATING`: The certificate domains validation are required. Used only for managed certificates.
- `INVALID`: The certificate issuance is failed. Used only for managed certificates.
- `ISSUED`: The certificate is issued.
- `REVOKED`: The certificate is revoked.
- `RENEWING`: The certificate renewal is started. Used only for managed certificates.
- `RENEWAL_FAILED`: The certificate renewal is failed. Used only for managed certificates. ||
|| issuer | **string**

[Distinguished Name](https://tools.ietf.org/html/rfc1779) of the certificate authority that issued the certificate. ||
|| subject | **string**

[Distinguished Name](https://tools.ietf.org/html/rfc1779) of the entity that is associated with the public key contained in the certificate. ||
|| serial | **string**

Serial number of the certificate. ||
|| updatedAt | **string** (date-time)

Time when the certificate is updated.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| issuedAt | **string** (date-time)

Time when the certificate is issued.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| notAfter | **string** (date-time)

Time after which the certificate is not valid.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| notBefore | **string** (date-time)

Time before which the certificate is not valid.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| challenges[] | **[Challenge](#yandex.cloud.certificatemanager.v1.Challenge)**

Domains validation challenges of the certificate. Used only for managed certificates. ||
|| deletionProtection | **boolean**

Flag that protects deletion of the certificate ||
|| incompleteChain | **boolean**

Mark imported certificates without uploaded chain or with chain which not lead to root certificate ||
|#

## Challenge {#yandex.cloud.certificatemanager.v1.Challenge}

Domain validation challenge.

#|
||Field | Description ||
|| domain | **string**

Domain of the challenge. ||
|| type | **enum** (ChallengeType)

Type of the challenge.

- `CHALLENGE_TYPE_UNSPECIFIED`
- `DNS`: Domain validation type that using DNS-records.
- `HTTP`: Domain validation type that using HTTP-files. ||
|| createdAt | **string** (date-time)

Time when the challenge is created.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| updatedAt | **string** (date-time)

Time when the challenge is updated.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| status | **enum** (Status)

Status of the challenge.

- `STATUS_UNSPECIFIED`
- `PENDING`: The challenge is waiting to be completed.
- `PROCESSING`: The challenge is awaiting approval from Let's Encrypt.
- `VALID`: The challenge is complete.
- `INVALID`: The rights check for a specific domain failed or the one-week period allocated for the check expired. ||
|| message | **string**

Description of the challenge. ||
|| error | **string**

Error of the challenge. ||
|| dnsChallenge | **[DnsRecord](#yandex.cloud.certificatemanager.v1.Challenge.DnsRecord)**

DNS-record.

Includes only one of the fields `dnsChallenge`, `httpChallenge`.

Data of the challenge. ||
|| httpChallenge | **[HttpFile](#yandex.cloud.certificatemanager.v1.Challenge.HttpFile)**

HTTP-file.

Includes only one of the fields `dnsChallenge`, `httpChallenge`.

Data of the challenge. ||
|#

## DnsRecord {#yandex.cloud.certificatemanager.v1.Challenge.DnsRecord}

#|
||Field | Description ||
|| name | **string**

Name of the DNS record. ||
|| type | **string**

Type of the DNS-record. ||
|| value | **string**

Value of the DNS-record. ||
|#

## HttpFile {#yandex.cloud.certificatemanager.v1.Challenge.HttpFile}

#|
||Field | Description ||
|| url | **string**

Location of the HTTP file. ||
|| content | **string**

Content of the HTTP file. ||
|#