---
editable: false
sourcePath: en/_api-ref/certificatemanager/v1/privateca/api-ref/PrivateCaContent/getPrivateKey.md
---

# Certificate Manager Private CA API, REST: PrivateCaContent.GetPrivateKey

Returns the private key and passphrase for the specified certificate authority.

## HTTP request

```
GET https://private-ca.certificate-manager.{{ api-host }}/privateca/v1/certificateAuthorities/{certificateAuthorityId}:getPrivateKey
```

## Path parameters

Request message for getting the private key of a certificate authority.

#|
||Field | Description ||
|| certificateAuthorityId | **string**

Required field. ID of the certificate authority to get the private key for. ||
|#

## Response {#yandex.cloud.certificatemanager.v1.privateca.GetCertificateAuthorityPrivateKeyResponse}

**HTTP Code: 200 - OK**

```json
{
  "certificateAuthorityId": "string",
  "privateKey": "string",
  "passphrase": "string"
}
```

Response message containing the private key and passphrase.

#|
||Field | Description ||
|| certificateAuthorityId | **string**

ID of the certificate authority. ||
|| privateKey | **string**

The private key in PEM format. ||
|| passphrase | **string**

The passphrase for the private key, if any. ||
|#