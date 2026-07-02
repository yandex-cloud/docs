[Документация Yandex Cloud](../../../../index.md) > [Yandex Certificate Manager](../../../index.md) > Справочник API > REST (англ.) > [Certificate Manager Private CA API](../index.md) > [PrivateCaCertificateContent](index.md) > GetPrivateKey

# Certificate Manager Private CA API, REST: PrivateCaCertificateContent.GetPrivateKey

Returns the private key for the specified certificate.

## HTTP request

```
GET https://private-ca.certificate-manager.api.cloud.yandex.net/privateca/v1/privateCertificates/{certificateId}:getPrivateKey
```

## Path parameters

Request message for GetPrivateKey.

#|
||Field | Description ||
|| certificateId | **string**

Required field. ID of the certificate to get the private key for.

The maximum string length in characters is 50. ||
|#

## Response {#yandex.cloud.certificatemanager.v1.privateca.GetCertificatePrivateKeyResponse}

**HTTP Code: 200 - OK**

```json
{
  "certificateId": "string",
  "privateKey": "string"
}
```

Response message containing the private key.

#|
||Field | Description ||
|| certificateId | **string**

ID of the certificate. ||
|| privateKey | **string**

The private key in PEM format. ||
|#