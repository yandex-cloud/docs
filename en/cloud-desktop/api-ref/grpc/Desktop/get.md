---
editable: false
sourcePath: en/_api-ref-grpc/clouddesktop/v1/api-ref/grpc/Desktop/get.md
---

# Cloud Desktop API, gRPC: DesktopService.Get {#Get}

Returns the specified desktop resource.

To get the list of available desktops, make a [List](/docs/cloud-desktop/api-ref/grpc/Desktop/list#List) request.

## gRPC request

**rpc Get ([GetDesktopRequest](#yandex.cloud.clouddesktop.v1.api.GetDesktopRequest)) returns ([Desktop](#yandex.cloud.clouddesktop.v1.api.Desktop))**

## GetDesktopRequest {#yandex.cloud.clouddesktop.v1.api.GetDesktopRequest}

```json
{
  "desktopId": "string"
}
```

#|
||Field | Description ||
|| desktopId | **string**

Required field. ID of the desktop resource to return.

To get the desktop ID use a [DesktopService.List](/docs/cloud-desktop/api-ref/grpc/Desktop/list#List) request. ||
|#

## Desktop {#yandex.cloud.clouddesktop.v1.api.Desktop}

```json
{
  "id": "string",
  "folderId": "string",
  "desktopGroupId": "string",
  "createdAt": "google.protobuf.Timestamp",
  "status": "Status",
  "name": "string",
  "resources": {
    "memory": "int64",
    "cores": "int64",
    "coreFraction": "int64"
  },
  "networkInterfaces": [
    {
      "networkId": "string",
      "subnetId": "string"
    }
  ],
  "users": [
    {
      "subjectId": "string"
    }
  ]
}
```

A desktop resource.

#|
||Field | Description ||
|| id | **string**

Desktop ID. ||
|| folderId | **string**

ID of the folder that the desktop belongs to. ||
|| desktopGroupId | **string**

ID of the desktop group that the desktop belongs to. ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. ||
|| status | enum **Status**

Status of the desktop.

- `STATUS_UNSPECIFIED`
- `CREATING`: Desktop is being created.
- `ACTIVE`: Desktop is ready to use.
- `DELETING`: Desktop is being deleted. ||
|| name | **string**

Name of the desktop. ||
|| resources | **[Resources](#yandex.cloud.clouddesktop.v1.api.Resources)**

Resources of the desktop. ||
|| networkInterfaces[] | **[NetworkInterface](#yandex.cloud.clouddesktop.v1.api.NetworkInterface)** ||
|| users[] | **[User](#yandex.cloud.clouddesktop.v1.api.User)** ||
|#

## Resources {#yandex.cloud.clouddesktop.v1.api.Resources}

#|
||Field | Description ||
|| memory | **int64** ||
|| cores | **int64** ||
|| coreFraction | **int64** ||
|#

## NetworkInterface {#yandex.cloud.clouddesktop.v1.api.NetworkInterface}

#|
||Field | Description ||
|| networkId | **string**

Required field.  ||
|| subnetId | **string**

Required field.  ||
|#

## User {#yandex.cloud.clouddesktop.v1.api.User}

#|
||Field | Description ||
|| subjectId | **string**

Required field. Identity of the access binding. ||
|#