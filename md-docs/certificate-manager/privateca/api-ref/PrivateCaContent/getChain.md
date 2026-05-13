# Certificate Manager Private CA API, REST: PrivateCaContent.GetChain

Returns the certificate chain for the specified certificate authority.

## HTTP request

```
GET https://private-ca.certificate-manager.api.cloud.yandex.net/privateca/v1/certificateAuthorities/{certificateAuthorityId}:getChain
```

## Path parameters

Request message for getting the certificate chain of a certificate authority.

#|
||Field | Description ||
|| certificateAuthorityId | **string**

Required field. ID of the certificate authority to get the chain for.

The maximum string length in characters is 50. ||
|#

## Response {#yandex.cloud.certificatemanager.v1.privateca.GetCertificateAuthorityChainResponse}

**HTTP Code: 200 - OK**

```json
{
  "certificateAuthorityId": "string",
  "certificateChain": [
    "string"
  ]
}
```

Response message containing the certificate chain.

#|
||Field | Description ||
|| certificateAuthorityId | **string**

ID of the certificate authority. ||
|| certificateChain[] | **string**

The certificate chain in PEM format. ||
|#