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
            The maximum string length in characters is 50.
            Includes only one of the fields `certificateId`, `folderAndName`.
          type: string
        folderAndName:
          description: |-
            **[FolderAndName](#yandex.cloud.certificatemanager.v1.FolderAndName)**
            Includes only one of the fields `certificateId`, `folderAndName`.
          $ref: '#/definitions/FolderAndName'
        versionId:
          description: |-
            **string**
            The maximum string length in characters is 50.
          type: string
        privateKeyFormat:
          description: |-
            **enum** (PrivateKeyFormat)
            - `PKCS1`
            - `PKCS8`
          type: string
          enum:
            - PRIVATE_KEY_FORMAT_UNSPECIFIED
            - PKCS1
            - PKCS8
      additionalProperties: false
      oneOf:
        - required:
            - certificateId
        - required:
            - folderAndName
    body: null
    definitions:
      FolderAndName:
        type: object
        properties:
          folderId:
            description: |-
              **string**
              Required field.
              The maximum string length in characters is 50.
            type: string
          certificateName:
            description: |-
              **string**
              Required field.
              The maximum string length in characters is 100.
            type: string
        required:
          - folderId
          - certificateName
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