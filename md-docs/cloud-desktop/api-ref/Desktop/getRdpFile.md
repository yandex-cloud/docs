# Cloud Desktop API, REST: Desktop.GetRdpFile

Returns a RDP file for the specified desktop.

## HTTP request

```
GET https://clouddesktops.api.cloud.yandex.net/cloud-desktop/v1/desktops/{desktopId}:getRdpFile
```

## Path parameters

#|
||Field | Description ||
|| desktopId | **string**

Required field. ID of the desktop resource to return.
To get the desktop ID use a [DesktopService.List](list.md#List) request.

The maximum string length in characters is 50. ||
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

Required field. Identity of the access binding.

The maximum string length in characters is 100. ||
|| subjectType | **string**

Required field. Type of the access binding, e.g. userAccount, serviceAccount, system.

The maximum string length in characters is 100. ||
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