[Документация Yandex Cloud](../../../index.md) > [Yandex Certificate Manager](../../index.md) > Справочник API > [REST (англ.)](../index.md) > [CertificateContent](index.md) > GetEx

# Certificate Manager API, REST: CertificateContent.GetEx

## HTTP request

```
GET https://data.certificate-manager.api.cloud.yandex.net/certificate-manager/v1/certificates:getEx
```

## Query parameters {#yandex.cloud.certificatemanager.v1.GetExCertificateContentRequest}

#|
||Field | Description ||
|| certificateId | **string**

The maximum string length in characters is 50.

Includes only one of the fields `certificateId`, `folderAndName`. ||
|| folderAndName | **[FolderAndName](#yandex.cloud.certificatemanager.v1.FolderAndName)**

Includes only one of the fields `certificateId`, `folderAndName`. ||
|| versionId | **string**

The maximum string length in characters is 50. ||
|| privateKeyFormat | **enum** (PrivateKeyFormat)

- `PKCS1`
- `PKCS8` ||
|#

## FolderAndName {#yandex.cloud.certificatemanager.v1.FolderAndName}

#|
||Field | Description ||
|| folderId | **string**

Required field.

The maximum string length in characters is 50. ||
|| certificateName | **string**

Required field.

The maximum string length in characters is 100. ||
|#

## Response {#yandex.cloud.certificatemanager.v1.GetExCertificateContentResponse}

**HTTP Code: 200 - OK**

```json
{
  "certificateId": "string",
  "versionId": "string",
  "certificateChain": [
    "string"
  ],
  "privateKey": "string"
}
```

#|
||Field | Description ||
|| certificateId | **string** ||
|| versionId | **string** ||
|| certificateChain[] | **string** ||
|| privateKey | **string** ||
|#