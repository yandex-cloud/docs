[Документация Yandex Cloud](../../../../index.md) > [Yandex Certificate Manager](../../../index.md) > Справочник API > [gRPC (англ.)](../index.md) > [Certificate](index.md) > Get

# Certificate Manager API, gRPC: CertificateService.Get

Returns the specified certificate.
To get the list of available certificates, make a [List](list.md#List) request.

## gRPC request

**rpc Get ([GetCertificateRequest](#yandex.cloud.certificatemanager.v1.GetCertificateRequest)) returns ([Certificate](#yandex.cloud.certificatemanager.v1.Certificate))**

## GetCertificateRequest {#yandex.cloud.certificatemanager.v1.GetCertificateRequest}

```json
{
  "certificate_id": "string",
  "view": "CertificateView"
}
```

#|
||Field | Description ||
|| certificate_id | **string**

Required field. ID of the certificate to return.
To get the ID of a certificate use a [CertificateService.List](list.md#List) request.

The maximum string length in characters is 50. ||
|| view | enum **CertificateView**

The output type of the certificate.

- `BASIC`: Output basic information about the certificate.
- `FULL`: Output full information about the certificate including domain challenges. ||
|#

## Certificate {#yandex.cloud.certificatemanager.v1.Certificate}

```json
{
  "id": "string",
  "name": "string",
  "labels": "map<string, string>",
  "folder_id": "string",
  "created_at": "google.protobuf.Timestamp",
  "updated_at": "google.protobuf.Timestamp",
  "type": "CertificateType",
  "domains": [
    "string"
  ],
  "issuer": "string",
  "issued_at": "google.protobuf.Timestamp",
  "not_after": "google.protobuf.Timestamp",
  "not_before": "google.protobuf.Timestamp",
  "serial": "string",
  "status": "Status",
  "challenges": [
    {
      // Includes only one of the fields `dns_challenge`, `http_challenge`
      "dns_challenge": {
        "name": "string",
        "type": "string",
        "value": "string"
      },
      "http_challenge": {
        "url": "string",
        "content": "string"
      },
      // end of the list of possible fields
      "created_at": "google.protobuf.Timestamp",
      "updated_at": "google.protobuf.Timestamp",
      "domain": "string",
      "type": "ChallengeType",
      "status": "Status",
      "message": "string",
      "error": "string"
    }
  ],
  "subject": "string",
  "description": "string",
  "deletion_protection": "bool",
  "incomplete_chain": "bool"
}
```

A certificate. For details about the concept, see [documentation](../../../concepts/index.md).

#|
||Field | Description ||
|| id | **string**

ID of the certificate. Generated at creation time. ||
|| name | **string**

Name of the certificate.
The name is unique within the folder. ||
|| labels | **object** (map<**string**, **string**>)

Certificate labels as `key:value` pairs. ||
|| folder_id | **string**

ID of the folder that the certificate belongs to. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time when the certificate is updated. ||
|| type | enum **CertificateType**

Type of the certificate.

- `IMPORTED`: The certificate is imported by user.
- `MANAGED`: The certificate is created by service. ||
|| domains[] | **string**

Fully qualified domain names of the certificate. ||
|| issuer | **string**

[Distinguished Name](https://tools.ietf.org/html/rfc1779) of the certificate authority that issued the certificate. ||
|| issued_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time when the certificate is issued. ||
|| not_after | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time after which the certificate is not valid. ||
|| not_before | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time before which the certificate is not valid. ||
|| serial | **string**

Serial number of the certificate. ||
|| status | enum **Status**

Status of the certificate.

- `VALIDATING`: The certificate domains validation are required. Used only for managed certificates.
- `INVALID`: The certificate issuance is failed. Used only for managed certificates.
- `ISSUED`: The certificate is issued.
- `REVOKED`: The certificate is revoked.
- `RENEWING`: The certificate renewal is started. Used only for managed certificates.
- `RENEWAL_FAILED`: The certificate renewal is failed. Used only for managed certificates. ||
|| challenges[] | **[Challenge](#yandex.cloud.certificatemanager.v1.Challenge)**

Domains validation challenges of the certificate. Used only for managed certificates. ||
|| subject | **string**

[Distinguished Name](https://tools.ietf.org/html/rfc1779) of the entity that is associated with the public key contained in the certificate. ||
|| description | **string**

Description of the certificate. ||
|| deletion_protection | **bool**

Flag that protects deletion of the certificate ||
|| incomplete_chain | **bool**

Mark imported certificates without uploaded chain or with chain which not lead to root certificate ||
|#

## Challenge {#yandex.cloud.certificatemanager.v1.Challenge}

Domain validation challenge.

#|
||Field | Description ||
|| dns_challenge | **[DnsRecord](#yandex.cloud.certificatemanager.v1.Challenge.DnsRecord)**

DNS-record.

Includes only one of the fields `dns_challenge`, `http_challenge`.

Data of the challenge. ||
|| http_challenge | **[HttpFile](#yandex.cloud.certificatemanager.v1.Challenge.HttpFile)**

HTTP-file.

Includes only one of the fields `dns_challenge`, `http_challenge`.

Data of the challenge. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time when the challenge is created. ||
|| updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time when the challenge is updated. ||
|| domain | **string**

Domain of the challenge. ||
|| type | enum **ChallengeType**

Type of the challenge.

- `DNS`: Domain validation type that using DNS-records.
- `HTTP`: Domain validation type that using HTTP-files. ||
|| status | enum **Status**

Status of the challenge.

- `PENDING`: The challenge is waiting to be completed.
- `PROCESSING`: The challenge is awaiting approval from Let's Encrypt.
- `VALID`: The challenge is complete.
- `INVALID`: The rights check for a specific domain failed or the one-week period allocated for the check expired. ||
|| message | **string**

Description of the challenge. ||
|| error | **string**

Error of the challenge. ||
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