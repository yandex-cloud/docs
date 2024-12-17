---
editable: false
sourcePath: en/_api-ref-grpc/certificatemanager/v1/privateca/api-ref/grpc/PrivateCaContent/getPrivateKey.md
---

# Certificate Manager Private CA API, gRPC: PrivateCaContentService.GetPrivateKey

Returns the private key and passphrase for the specified certificate authority.

## gRPC request

**rpc GetPrivateKey ([GetCertificateAuthorityPrivateKeyRequest](#yandex.cloud.certificatemanager.v1.privateca.GetCertificateAuthorityPrivateKeyRequest)) returns ([GetCertificateAuthorityPrivateKeyResponse](#yandex.cloud.certificatemanager.v1.privateca.GetCertificateAuthorityPrivateKeyResponse))**

## GetCertificateAuthorityPrivateKeyRequest {#yandex.cloud.certificatemanager.v1.privateca.GetCertificateAuthorityPrivateKeyRequest}

```json
{
  "certificate_authority_id": "string"
}
```

Request message for getting the private key of a certificate authority.

#|
||Field | Description ||
|| certificate_authority_id | **string**

Required field. ID of the certificate authority to get the private key for. ||
|#

## GetCertificateAuthorityPrivateKeyResponse {#yandex.cloud.certificatemanager.v1.privateca.GetCertificateAuthorityPrivateKeyResponse}

```json
{
  "certificate_authority_id": "string",
  "private_key": "string",
  "passphrase": "string"
}
```

Response message containing the private key and passphrase.

#|
||Field | Description ||
|| certificate_authority_id | **string**

ID of the certificate authority. ||
|| private_key | **string**

The private key in PEM format. ||
|| passphrase | **string**

The passphrase for the private key, if any. ||
|#