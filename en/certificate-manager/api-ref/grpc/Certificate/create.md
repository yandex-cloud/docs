---
editable: false
sourcePath: en/_api-ref-grpc/certificatemanager/v1/api-ref/grpc/Certificate/create.md
---

# Certificate Manager API, gRPC: CertificateService.Create

Creates a certificate in the specified folder.

## gRPC request

**rpc Create ([CreateCertificateRequest](#yandex.cloud.certificatemanager.v1.CreateCertificateRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## CreateCertificateRequest {#yandex.cloud.certificatemanager.v1.CreateCertificateRequest}

```json
{
  "folder_id": "string",
  "name": "string",
  "description": "string",
  "labels": "map<string, string>",
  "certificate": "string",
  "chain": "string",
  "private_key": "string",
  "deletion_protection": "bool"
}
```

#|
||Field | Description ||
|| folder_id | **string**

Required field. ID of the folder to create a certificate in. ||
|| name | **string**

Name of the certificate.
The name must be unique within the folder. ||
|| description | **string**

Description of the certificate. ||
|| labels | **object** (map<**string**, **string**>)

Labels for the certificate as `key:value` pairs. ||
|| certificate | **string**

PEM-encoded certificate content of the certificate. ||
|| chain | **string**

PEM-encoded certificate chain content of the certificate. ||
|| private_key | **string**

Required field. PEM-encoded private key content of the certificate. ||
|| deletion_protection | **bool**

Flag that protects deletion of the certificate ||
|#

## operation.Operation {#yandex.cloud.operation.Operation}

```json
{
  "id": "string",
  "description": "string",
  "created_at": "google.protobuf.Timestamp",
  "created_by": "string",
  "modified_at": "google.protobuf.Timestamp",
  "done": "bool",
  "metadata": {
    "certificate_id": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "string",
    "folder_id": "string",
    "created_at": "google.protobuf.Timestamp",
    "name": "string",
    "description": "string",
    "labels": "map<string, string>",
    "type": "CertificateType",
    "domains": [
      "string"
    ],
    "status": "Status",
    "issuer": "string",
    "subject": "string",
    "serial": "string",
    "updated_at": "google.protobuf.Timestamp",
    "issued_at": "google.protobuf.Timestamp",
    "not_after": "google.protobuf.Timestamp",
    "not_before": "google.protobuf.Timestamp",
    "challenges": [
      {
        "domain": "string",
        "type": "ChallengeType",
        "created_at": "google.protobuf.Timestamp",
        "updated_at": "google.protobuf.Timestamp",
        "status": "Status",
        "message": "string",
        "error": "string",
        // Includes only one of the fields `dns_challenge`, `http_challenge`
        "dns_challenge": {
          "name": "string",
          "type": "string",
          "value": "string"
        },
        "http_challenge": {
          "url": "string",
          "content": "string"
        }
        // end of the list of possible fields
      }
    ],
    "deletion_protection": "bool",
    "incomplete_chain": "bool"
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
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| created_by | **string**

ID of the user or service account who initiated the operation. ||
|| modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[CreateCertificateMetadata](#yandex.cloud.certificatemanager.v1.CreateCertificateMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **[Certificate](#yandex.cloud.certificatemanager.v1.Certificate)**

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

## CreateCertificateMetadata {#yandex.cloud.certificatemanager.v1.CreateCertificateMetadata}

#|
||Field | Description ||
|| certificate_id | **string**

ID of the certificate being created. ||
|#

## Certificate {#yandex.cloud.certificatemanager.v1.Certificate}

A certificate. For details about the concept, see [documentation](/docs/certificate-manager/concepts/).

#|
||Field | Description ||
|| id | **string**

ID of the certificate. Generated at creation time. ||
|| folder_id | **string**

ID of the folder that the certificate belongs to. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| name | **string**

Name of the certificate.
The name is unique within the folder. ||
|| description | **string**

Description of the certificate. ||
|| labels | **object** (map<**string**, **string**>)

Certificate labels as `key:value` pairs. ||
|| type | enum **CertificateType**

Type of the certificate.

- `CERTIFICATE_TYPE_UNSPECIFIED`
- `IMPORTED`: The certificate is imported by user.
- `MANAGED`: The certificate is created by service. ||
|| domains[] | **string**

Fully qualified domain names of the certificate. ||
|| status | enum **Status**

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
|| updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time when the certificate is updated. ||
|| issued_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time when the certificate is issued. ||
|| not_after | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time after which the certificate is not valid. ||
|| not_before | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time before which the certificate is not valid. ||
|| challenges[] | **[Challenge](#yandex.cloud.certificatemanager.v1.Challenge)**

Domains validation challenges of the certificate. Used only for managed certificates. ||
|| deletion_protection | **bool**

Flag that protects deletion of the certificate ||
|| incomplete_chain | **bool**

Mark imported certificates without uploaded chain or with chain which not lead to root certificate ||
|#

## Challenge {#yandex.cloud.certificatemanager.v1.Challenge}

Domain validation challenge.

#|
||Field | Description ||
|| domain | **string**

Domain of the challenge. ||
|| type | enum **ChallengeType**

Type of the challenge.

- `CHALLENGE_TYPE_UNSPECIFIED`
- `DNS`: Domain validation type that using DNS-records.
- `HTTP`: Domain validation type that using HTTP-files. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time when the challenge is created. ||
|| updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time when the challenge is updated. ||
|| status | enum **Status**

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
|| dns_challenge | **[DnsRecord](#yandex.cloud.certificatemanager.v1.Challenge.DnsRecord)**

DNS-record.

Includes only one of the fields `dns_challenge`, `http_challenge`.

Data of the challenge. ||
|| http_challenge | **[HttpFile](#yandex.cloud.certificatemanager.v1.Challenge.HttpFile)**

HTTP-file.

Includes only one of the fields `dns_challenge`, `http_challenge`.

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