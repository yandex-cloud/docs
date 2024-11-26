---
editable: false
sourcePath: en/_api-ref/certificatemanager/v1/api-ref/CertificateContent/get.md
---

# Certificate Manager API, REST: CertificateContent.Get

Returns chain and private key of the specified certificate.

## HTTP request

```
GET https://{{ api-host-certmanager-certcontent }}/certificate-manager/v1/certificates/{certificateId}:getContent
```

## Path parameters

#|
||Field | Description ||
|| certificateId | **string**

Required field. ID of the certificate to download content. ||
|#

## Query parameters {#yandex.cloud.certificatemanager.v1.GetCertificateContentRequest}

#|
||Field | Description ||
|| versionId | **string**

Optional ID of the version. ||
|| privateKeyFormat | **enum** (PrivateKeyFormat)

Desired format of private key

- `PRIVATE_KEY_FORMAT_UNSPECIFIED`
- `PKCS1`
- `PKCS8` ||
|#

## Response {#yandex.cloud.certificatemanager.v1.GetCertificateContentResponse}

**HTTP Code: 200 - OK**

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