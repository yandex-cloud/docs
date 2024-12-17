---
editable: false
sourcePath: en/_api-ref-grpc/certificatemanager/v1/privateca/api-ref/grpc/PrivateCaCertificateContent/getChain.md
---

# Certificate Manager Private CA API, gRPC: PrivateCaCertificateContentService.GetChain

Returns the certificate chain for the specified certificate.

## gRPC request

**rpc GetChain ([GetCertificateChainRequest](#yandex.cloud.certificatemanager.v1.privateca.GetCertificateChainRequest)) returns ([GetCertificateChainResponse](#yandex.cloud.certificatemanager.v1.privateca.GetCertificateChainResponse))**

## GetCertificateChainRequest {#yandex.cloud.certificatemanager.v1.privateca.GetCertificateChainRequest}

```json
{
  "certificate_id": "string"
}
```

Request message for GetChain.

#|
||Field | Description ||
|| certificate_id | **string**

Required field. ID of the certificate to get the chain for. ||
|#

## GetCertificateChainResponse {#yandex.cloud.certificatemanager.v1.privateca.GetCertificateChainResponse}

```json
{
  "certificate_id": "string",
  "certificate_chain": [
    "string"
  ]
}
```

Response message containing the certificate chain.

#|
||Field | Description ||
|| certificate_id | **string**

ID of the certificate. ||
|| certificate_chain[] | **string**

The certificate chain in PEM format. ||
|#