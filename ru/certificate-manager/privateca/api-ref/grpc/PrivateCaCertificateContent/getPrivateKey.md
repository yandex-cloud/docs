---
editable: false
sourcePath: en/_api-ref-grpc/certificatemanager/v1/privateca/api-ref/grpc/PrivateCaCertificateContent/getPrivateKey.md
---

# Certificate Manager Private CA API, gRPC: PrivateCaCertificateContentService.GetPrivateKey

Returns the private key for the specified certificate.

## gRPC request

**rpc GetPrivateKey ([GetCertificatePrivateKeyRequest](#yandex.cloud.priv.certificatemanager.v1.privateca.GetCertificatePrivateKeyRequest)) returns ([GetCertificatePrivateKeyResponse](#yandex.cloud.priv.certificatemanager.v1.privateca.GetCertificatePrivateKeyResponse))**

## GetCertificatePrivateKeyRequest {#yandex.cloud.priv.certificatemanager.v1.privateca.GetCertificatePrivateKeyRequest}

```json
{
  "certificate_id": "string"
}
```

Request message for GetPrivateKey.

#|
||Field | Description ||
|| certificate_id | **string**

Required field. ID of the certificate to get the private key for. ||
|#

## GetCertificatePrivateKeyResponse {#yandex.cloud.priv.certificatemanager.v1.privateca.GetCertificatePrivateKeyResponse}

```json
{
  "certificate_id": "string",
  "private_key": "string"
}
```

Response message containing the private key.

#|
||Field | Description ||
|| certificate_id | **string**

ID of the certificate. ||
|| private_key | **string**

The private key in PEM format. ||
|#