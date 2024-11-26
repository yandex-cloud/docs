---
editable: false
sourcePath: en/_api-ref-grpc/certificatemanager/v1/privateca/api-ref/grpc/PrivateCaCertificate/list.md
---

# Certificate Manager Private CA API, gRPC: PrivateCaCertificateService.List

Lists the certificates issued by a given Certificate Authority (CA).

## gRPC request

**rpc List ([ListCertificatesRequest](#yandex.cloud.priv.certificatemanager.v1.privateca.ListCertificatesRequest)) returns ([ListCertificatesResponse](#yandex.cloud.priv.certificatemanager.v1.privateca.ListCertificatesResponse))**

## ListCertificatesRequest {#yandex.cloud.priv.certificatemanager.v1.privateca.ListCertificatesRequest}

```json
{
  "certificate_authority_id": "string",
  "page_size": "int64",
  "page_token": "string"
}
```

Request to list certificates issued by a specific Certificate Authority.

#|
||Field | Description ||
|| certificate_authority_id | **string**

Required field. The ID of the Certificate Authority issuing the certificates. ||
|| page_size | **int64**

Maximum number of certificates to return per page, optional. Default is 100. ||
|| page_token | **string**

Page token, allows request for the next page of results from a previous list call. ||
|#

## ListCertificatesResponse {#yandex.cloud.priv.certificatemanager.v1.privateca.ListCertificatesResponse}

```json
{
  "certificates": [
    {
      "id": "string",
      "certificate_authority_id": "string",
      "name": "string",
      "description": "string",
      "issued_at": "google.protobuf.Timestamp",
      "not_after": "google.protobuf.Timestamp",
      "not_before": "google.protobuf.Timestamp",
      "deletion_protection": "bool",
      "created_at": "google.protobuf.Timestamp",
      "updated_at": "google.protobuf.Timestamp"
    }
  ],
  "next_page_token": "string"
}
```

Response to the `ListCertificates` request, containing the certificates and pagination information.

#|
||Field | Description ||
|| certificates[] | **[PrivateCertificate](#yandex.cloud.priv.certificatemanager.v1.privateca.PrivateCertificate)**

The list of certificates issued by the Certificate Authority. ||
|| next_page_token | **string**

Token to use to fetch the next page of results, if there are more results. ||
|#

## PrivateCertificate {#yandex.cloud.priv.certificatemanager.v1.privateca.PrivateCertificate}

A private certificate issued by a private certificate authority.

#|
||Field | Description ||
|| id | **string**

ID of the private certificate. ||
|| certificate_authority_id | **string**

ID of the certificate authority that issued the private certificate. ||
|| name | **string**

Name of the private certificate. ||
|| description | **string**

Description of the private certificate. ||
|| issued_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time when the private certificate was issued. ||
|| not_after | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time after which the private certificate is not valid. ||
|| not_before | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time before which the private certificate is not valid. ||
|| deletion_protection | **bool**

Flag that protects deletion of the private certificate. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time when the private certificate was created. ||
|| updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time when the private certificate was updated. ||
|#