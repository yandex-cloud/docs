---
editable: false
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
  "headers": "string",
  "content": "string"
}
```

#|
||Field | Description ||
|| headers | **string**

HTTP headers mapping. ||
|| content | **string**

RDP file content. ||
|#