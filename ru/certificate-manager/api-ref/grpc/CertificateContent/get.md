---
editable: false
---

# Certificate Manager API, gRPC: CertificateContentService.Get

Returns chain and private key of the specified certificate.

## gRPC request

**rpc Get ([GetCertificateContentRequest](#yandex.cloud.certificatemanager.v1.GetCertificateContentRequest)) returns ([GetCertificateContentResponse](#yandex.cloud.certificatemanager.v1.GetCertificateContentResponse))**

## GetCertificateContentRequest {#yandex.cloud.certificatemanager.v1.GetCertificateContentRequest}

```json
{
  "certificate_id": "string",
  "version_id": "string",
  "private_key_format": "PrivateKeyFormat"
}
```

#|
||Field | Description ||
|| certificate_id | **string**

ID of the certificate to download content. ||
|| version_id | **string**

Optional ID of the version. ||
|| private_key_format | enum **PrivateKeyFormat**

Desired format of private key

- `PKCS1`
- `PKCS8` ||
|#

## GetCertificateContentResponse {#yandex.cloud.certificatemanager.v1.GetCertificateContentResponse}

```json
{
  "certificate_id": "string",
  "certificate_chain": [
    "string"
  ],
  "private_key": "string"
}
```

#|
||Field | Description ||
|| certificate_id | **string**

ID of the certificate. ||
|| certificate_chain[] | **string**

PEM-encoded certificate chain content of the certificate. ||
|| private_key | **string**

PEM-encoded private key content of the certificate. ||
|#