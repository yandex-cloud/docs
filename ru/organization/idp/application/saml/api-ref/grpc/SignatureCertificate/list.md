---
editable: false
---

# SAML Application API, gRPC: SignatureCertificateService.List

Retrieves the list of signature certificates for the specified SAML application.

## gRPC request

**rpc List ([ListSignatureCertificatesRequest](#yandex.cloud.organizationmanager.v1.idp.application.saml.ListSignatureCertificatesRequest)) returns ([ListSignatureCertificatesResponse](#yandex.cloud.organizationmanager.v1.idp.application.saml.ListSignatureCertificatesResponse))**

## ListSignatureCertificatesRequest {#yandex.cloud.organizationmanager.v1.idp.application.saml.ListSignatureCertificatesRequest}

```json
{
  "application_id": "string",
  "page_size": "int64",
  "page_token": "string",
  "filter": "string"
}
```

Request to list signature certificates for a SAML application.

#|
||Field | Description ||
|| application_id | **string**

Required field. ID of the SAML application to list certificates for.

The maximum string length in characters is 50. ||
|| page_size | **int64**

The maximum number of results per page to return.

Acceptable values are 0 to 1000, inclusive. ||
|| page_token | **string**

Page token for pagination.

The maximum string length in characters is 2000. ||
|| filter | **string**

A filter expression that filters resources listed in the response.

The maximum string length in characters is 1000. ||
|#

## ListSignatureCertificatesResponse {#yandex.cloud.organizationmanager.v1.idp.application.saml.ListSignatureCertificatesResponse}

```json
{
  "signature_certificates": [
    {
      "id": "string",
      "application_id": "string",
      "status": "Status",
      "name": "string",
      "description": "string",
      "created_at": "google.protobuf.Timestamp",
      "data": "string",
      "fingerprint": "string",
      "not_after": "google.protobuf.Timestamp",
      "not_before": "google.protobuf.Timestamp"
    }
  ],
  "next_page_token": "string"
}
```

Response message for [SignatureCertificateService.List](#List).

#|
||Field | Description ||
|| signature_certificates[] | **[SignatureCertificate](#yandex.cloud.organizationmanager.v1.idp.application.saml.SignatureCertificate)**

List of signature certificates. ||
|| next_page_token | **string**

Token for getting the next page of the list. ||
|#

## SignatureCertificate {#yandex.cloud.organizationmanager.v1.idp.application.saml.SignatureCertificate}

A signature certificate for SAML applications.

#|
||Field | Description ||
|| id | **string**

Unique identifier of the signature certificate. ||
|| application_id | **string**

ID of the SAML application that the signature certificate belongs to. ||
|| status | enum **Status**

Current status of the signature certificate.

- `ACTIVE`: The certificate is active and can be used for signing.
- `INACTIVE`: The certificate is inactive and cannot be used for signing. ||
|| name | **string**

Name of the signature certificate. ||
|| description | **string**

Description of the signature certificate. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| data | **string**

Certificate data in PEM format. ||
|| fingerprint | **string**

SHA256-fingerprint of the signature certificate. ||
|| not_after | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time after which the signature certificate is not valid. ||
|| not_before | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time before which the signature certificate is not valid. ||
|#