---
editable: false
apiPlayground:
  - url: https://{{ api-host-certmanager-certcontent }}/certificate-manager/v1/certificates:getEx
    method: get
    path: null
    query:
      type: object
      properties:
        certificateId:
          description: |-
            **string**
            Includes only one of the fields `certificateId`, `folderAndName`.
          type: string
        folderAndName:
          description: |-
            **[FolderAndName](/docs/certificate-manager/api-ref/CertificateContent/getEx#yandex.cloud.certificatemanager.v1.FolderAndName)**
            Includes only one of the fields `certificateId`, `folderAndName`.
          $ref: '#/definitions/FolderAndName'
        versionId:
          description: '**string**'
          type: string
        privateKeyFormat:
          description: |-
            **enum** (PrivateKeyFormat)
            - `PRIVATE_KEY_FORMAT_UNSPECIFIED`
            - `PKCS1`
            - `PKCS8`
          type: string
          enum:
            - PRIVATE_KEY_FORMAT_UNSPECIFIED
            - PKCS1
            - PKCS8
      additionalProperties: false
    body: null
    definitions:
      FolderAndName:
        type: object
        properties:
          folderId:
            description: |-
              **string**
              Required field. 
            type: string
          certificateName:
            description: |-
              **string**
              Required field. 
            type: string
        required:
          - folderId
          - certificateName
sourcePath: en/_api-ref/certificatemanager/v1/api-ref/CertificateContent/getEx.md
---

# Certificate Manager API, REST: CertificateContent.GetEx

## HTTP request

```
GET https://{{ api-host-certmanager-certcontent }}/certificate-manager/v1/certificates:getEx
```

## Query parameters {#yandex.cloud.certificatemanager.v1.GetExCertificateContentRequest}

#|
||Field | Description ||
|| certificateId | **string**

Includes only one of the fields `certificateId`, `folderAndName`. ||
|| folderAndName | **[FolderAndName](#yandex.cloud.certificatemanager.v1.FolderAndName)**

Includes only one of the fields `certificateId`, `folderAndName`. ||
|| versionId | **string** ||
|| privateKeyFormat | **enum** (PrivateKeyFormat)

- `PRIVATE_KEY_FORMAT_UNSPECIFIED`
- `PKCS1`
- `PKCS8` ||
|#

## FolderAndName {#yandex.cloud.certificatemanager.v1.FolderAndName}

#|
||Field | Description ||
|| folderId | **string**

Required field.  ||
|| certificateName | **string**

Required field.  ||
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