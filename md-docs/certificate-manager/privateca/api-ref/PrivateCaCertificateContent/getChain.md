[Документация Yandex Cloud](../../../../index.md) > [Yandex Certificate Manager](../../../index.md) > Справочник API > REST (англ.) > [Certificate Manager Private CA API](../index.md) > [PrivateCaCertificateContent](index.md) > GetChain

# Certificate Manager Private CA API, REST: PrivateCaCertificateContent.GetChain

Returns the certificate chain for the specified certificate.

## HTTP request

```
GET https://private-ca.certificate-manager.api.cloud.yandex.net/privateca/v1/privateCertificates/{certificateId}:getChain
```

## Path parameters

Request message for GetChain.

#|
||Field | Description ||
|| certificateId | **string**

Required field. ID of the certificate to get the chain for.

The maximum string length in characters is 50. ||
|#

## Response {#yandex.cloud.certificatemanager.v1.privateca.GetCertificateChainResponse}

**HTTP Code: 200 - OK**

```json
{
  "certificateId": "string",
  "certificateChain": [
    "string"
  ]
}
```

Response message containing the certificate chain.

#|
||Field | Description ||
|| certificateId | **string**

ID of the certificate. ||
|| certificateChain[] | **string**

The certificate chain in PEM format. ||
|#