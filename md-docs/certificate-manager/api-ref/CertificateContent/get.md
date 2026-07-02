[Документация Yandex Cloud](../../../index.md) > [Yandex Certificate Manager](../../index.md) > Справочник API > [REST (англ.)](../index.md) > [CertificateContent](index.md) > Get

# Certificate Manager API, REST: CertificateContent.Get

Returns chain and private key of the specified certificate.

## HTTP request

```
GET https://data.certificate-manager.api.cloud.yandex.net/certificate-manager/v1/certificates/{certificateId}:getContent
```

## Path parameters

#|
||Field | Description ||
|| certificateId | **string**

Required field. ID of the certificate to download content.

The maximum string length in characters is 50. ||
|#

## Query parameters {#yandex.cloud.certificatemanager.v1.GetCertificateContentRequest}

#|
||Field | Description ||
|| versionId | **string**

Optional ID of the version.

The maximum string length in characters is 50. ||
|| privateKeyFormat | **enum** (PrivateKeyFormat)

Desired format of private key

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