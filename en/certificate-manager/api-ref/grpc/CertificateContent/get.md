---
editable: false
sourcePath: en/_api-ref-grpc/certificatemanager/v1/api-ref/grpc/CertificateContent/get.md
---

# Certificate Manager API, gRPC: CertificateContentService.Get {#Get}

Returns chain and private key of the specified certificate.

## gRPC request

**rpc Get ([GetCertificateContentRequest](#yandex.cloud.certificatemanager.v1.GetCertificateContentRequest)) returns ([GetCertificateContentResponse](#yandex.cloud.certificatemanager.v1.GetCertificateContentResponse))**

## GetCertificateContentRequest {#yandex.cloud.certificatemanager.v1.GetCertificateContentRequest}

```json
{
  "certificateId": "string",
  "versionId": "string",
  "privateKeyFormat": "PrivateKeyFormat"
}
```

#|
||Field | Description ||
|| certificateId | **string**

ID of the certificate to download content. ||
|| versionId | **string**

Optional ID of the version. ||
|| privateKeyFormat | enum **PrivateKeyFormat**

Desired format of private key

- `PRIVATE_KEY_FORMAT_UNSPECIFIED`
- `PKCS1`
- `PKCS8` ||
|#

## GetCertificateContentResponse {#yandex.cloud.certificatemanager.v1.GetCertificateContentResponse}

```json
{
  "certificateId": "string",
  "certificateChain": [
    "string"
  ],
  "privateKey": "string"
}
```

#|
||Field | Description ||
|| certificateId | **string**

ID of the certificate. ||
|| certificateChain[] | **string**

PEM-encoded certificate chain content of the certificate. ||
|| privateKey | **string**

PEM-encoded private key content of the certificate. ||
|#