---
editable: false
sourcePath: en/_api-ref/certificatemanager/v1/privateca/api-ref/PrivateCaCertificateContent/getChain.md
---

# Certificate Manager Private CA API, REST: PrivateCaCertificateContent.GetChain

Returns the certificate chain for the specified certificate.

## HTTP request

```
GET https://private-ca.certificate-manager.{{ api-host }}/privateca/v1/privateCertificates/{certificateId}:getChain
```

## Path parameters

Request message for GetChain.

#|
||Field | Description ||
|| certificateId | **string**

Required field. ID of the certificate to get the chain for. ||
|#

## Response {#yandex.cloud.priv.certificatemanager.v1.privateca.GetCertificateChainResponse}

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