---
editable: false
sourcePath: en/_api-ref-grpc/clouddesktop/v1/api-ref/grpc/Desktop/getRdpFile.md
---

# Cloud Desktop API, gRPC: DesktopService.GetRdpFile

Returns a RDP file for the specified desktop.

## gRPC request

**rpc GetRdpFile ([GetRdpFileRequest](#yandex.cloud.clouddesktop.v1.api.GetRdpFileRequest)) returns ([RdpFileResponse](#yandex.cloud.clouddesktop.v1.api.RdpFileResponse))**

## GetRdpFileRequest {#yandex.cloud.clouddesktop.v1.api.GetRdpFileRequest}

```json
{
  "desktop_id": "string",
  "user": {
    "subject_id": "string",
    "subject_type": "string"
  }
}
```

#|
||Field | Description ||
|| desktop_id | **string**

Required field. ID of the desktop resource to return.

To get the desktop ID use a [DesktopService.List](/docs/cloud-desktop/api-ref/grpc/Desktop/list#List) request. ||
|| user | **[User](#yandex.cloud.clouddesktop.v1.api.User)**

User of the desktop. ||
|#

## User {#yandex.cloud.clouddesktop.v1.api.User}

#|
||Field | Description ||
|| subject_id | **string**

Required field. Identity of the access binding. ||
|| subject_type | **string**

Required field. Type of the access binding, e.g. userAccount, serviceAccount, system. ||
|#

## RdpFileResponse {#yandex.cloud.clouddesktop.v1.api.RdpFileResponse}

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