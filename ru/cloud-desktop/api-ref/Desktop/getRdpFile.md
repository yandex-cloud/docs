---
editable: false
apiPlayground:
  - url: https://cloud-desktop.{{ api-host }}/cloud-desktop/v1/desktops/{desktopId}:getRdpFile
    method: get
    path:
      type: object
      properties:
        desktopId:
          description: |-
            **string**
            Required field. ID of the desktop resource to return.
            To get the desktop ID use a [DesktopService.List](/docs/cloud-desktop/api-ref/Desktop/list#List) request.
          type: string
      required:
        - desktopId
      additionalProperties: false
    query:
      type: object
      properties:
        user:
          description: |-
            **[User](/docs/cloud-desktop/api-ref/DesktopGroup/listDesktops#yandex.cloud.clouddesktop.v1.api.User)**
            User of the desktop.
          $ref: '#/definitions/User'
      additionalProperties: false
    body: null
    definitions:
      User:
        type: object
        properties:
          subjectId:
            description: |-
              **string**
              Required field. Identity of the access binding.
            type: string
          subjectType:
            description: |-
              **string**
              Required field. Type of the access binding, e.g. userAccount, serviceAccount, system.
            type: string
        required:
          - subjectId
          - subjectType
sourcePath: en/_api-ref/clouddesktop/v1/api-ref/Desktop/getRdpFile.md
---

# Cloud Desktop API, REST: Desktop.GetRdpFile

Returns a RDP file for the specified desktop.

## HTTP request

```
GET https://cloud-desktop.{{ api-host }}/cloud-desktop/v1/desktops/{desktopId}:getRdpFile
```

## Path parameters

#|
||Field | Description ||
|| desktopId | **string**

Required field. ID of the desktop resource to return.

To get the desktop ID use a [DesktopService.List](/docs/cloud-desktop/api-ref/Desktop/list#List) request. ||
|#

## Query parameters {#yandex.cloud.clouddesktop.v1.api.GetRdpFileRequest}

#|
||Field | Description ||
|| user | **[User](#yandex.cloud.clouddesktop.v1.api.User)**

User of the desktop. ||
|#

## User {#yandex.cloud.clouddesktop.v1.api.User}

#|
||Field | Description ||
|| subjectId | **string**

Required field. Identity of the access binding. ||
|| subjectType | **string**

Required field. Type of the access binding, e.g. userAccount, serviceAccount, system. ||
|#

## Response {#yandex.cloud.clouddesktop.v1.api.RdpFileResponse}

**HTTP Code: 200 - OK**

```json
{
  "headers": "object",
  "content": "string"
}
```

#|
||Field | Description ||
|| headers | **object** (map<**string**, **string**>)

HTTP headers mapping. ||
|| content | **string**

RDP file content. ||
|#