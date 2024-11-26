---
editable: false
sourcePath: en/_api-ref-grpc/certificatemanager/v1/privateca/api-ref/grpc/PrivateCaContent/getChain.md
---

# Certificate Manager Private CA API, gRPC: PrivateCaContentService.GetChain

Returns the certificate chain for the specified certificate authority.

## gRPC request

**rpc GetChain ([GetCertificateAuthorityChainRequest](#yandex.cloud.priv.certificatemanager.v1.privateca.GetCertificateAuthorityChainRequest)) returns ([GetCertificateAuthorityChainResponse](#yandex.cloud.priv.certificatemanager.v1.privateca.GetCertificateAuthorityChainResponse))**

## GetCertificateAuthorityChainRequest {#yandex.cloud.priv.certificatemanager.v1.privateca.GetCertificateAuthorityChainRequest}

```json
{
  "certificate_authority_id": "string"
}
```

Request message for getting the certificate chain of a certificate authority.

#|
||Field | Description ||
|| certificate_authority_id | **string**

Required field. ID of the certificate authority to get the chain for. ||
|#

## GetCertificateAuthorityChainResponse {#yandex.cloud.priv.certificatemanager.v1.privateca.GetCertificateAuthorityChainResponse}

```json
{
  "certificate_authority_id": "string",
  "certificate_chain": [
    "string"
  ]
}
```

Response message containing the certificate chain.

#|
||Field | Description ||
|| certificate_authority_id | **string**

ID of the certificate authority. ||
|| certificate_chain[] | **string**

The certificate chain in PEM format. ||
|#