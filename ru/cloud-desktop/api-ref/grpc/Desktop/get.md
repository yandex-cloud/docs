---
editable: false
sourcePath: en/_api-ref-grpc/clouddesktop/v1/api-ref/grpc/Desktop/get.md
---

# Cloud Desktop API, gRPC: DesktopService.Get

Returns the specified desktop resource.

To get the list of available desktops, make a [List](/docs/cloud-desktop/api-ref/grpc/Desktop/list#List) request.

## gRPC request

**rpc Get ([GetDesktopRequest](#yandex.cloud.clouddesktop.v1.api.GetDesktopRequest)) returns ([Desktop](#yandex.cloud.clouddesktop.v1.api.Desktop))**

## GetDesktopRequest {#yandex.cloud.clouddesktop.v1.api.GetDesktopRequest}

```json
{
  "desktop_id": "string"
}
```

#|
||Field | Description ||
|| desktop_id | **string**

Required field. ID of the desktop resource to return.

To get the desktop ID use a [DesktopService.List](/docs/cloud-desktop/api-ref/grpc/Desktop/list#List) request. ||
|#

## Desktop {#yandex.cloud.clouddesktop.v1.api.Desktop}

```json
{
  "id": "string",
  "folder_id": "string",
  "desktop_group_id": "string",
  "created_at": "google.protobuf.Timestamp",
  "status": "Status",
  "name": "string",
  "resources": {
    "memory": "int64",
    "cores": "int64",
    "core_fraction": "int64"
  },
  "network_interfaces": [
    {
      "network_id": "string",
      "subnet_id": "string"
    }
  ],
  "users": [
    {
      "subject_id": "string",
      "subject_type": "string"
    }
  ],
  "labels": "map<string, string>"
}
```

A desktop resource.

#|
||Field | Description ||
|| id | **string**

Desktop ID. ||
|| folder_id | **string**

ID of the folder that the desktop belongs to. ||
|| desktop_group_id | **string**

ID of the desktop group that the desktop belongs to. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. ||
|| status | enum **Status**

Status of the desktop.

- `STATUS_UNSPECIFIED`
- `CREATING`: Desktop is being created.
- `ACTIVE`: Desktop is ready to be used.
- `DELETING`: Desktop is being deleted.
- `RESTARTING`: Desktop is restarting.
- `UPDATING`: Desktop is updating.
- `STARTING`: Desktop is starting.
- `STOPPING`: Desktop is stopping.
- `STOPPED`: Desktop is stopped.
- `ERROR`: Desktop did not manage start or restart.
- `CREATION_FAILED`: Desktop did not manage to get created or updated. ||
|| name | **string**

Name of the desktop. ||
|| resources | **[Resources](#yandex.cloud.clouddesktop.v1.api.Resources)**

Resources of the desktop. ||
|| network_interfaces[] | **[NetworkInterface](#yandex.cloud.clouddesktop.v1.api.NetworkInterface)** ||
|| users[] | **[User](#yandex.cloud.clouddesktop.v1.api.User)** ||
|| labels | **object** (map<**string**, **string**>)

Labels of the desktop. ||
|#

## Resources {#yandex.cloud.clouddesktop.v1.api.Resources}

#|
||Field | Description ||
|| memory | **int64** ||
|| cores | **int64** ||
|| core_fraction | **int64** ||
|#

## NetworkInterface {#yandex.cloud.clouddesktop.v1.api.NetworkInterface}

#|
||Field | Description ||
|| network_id | **string**

Required field.  ||
|| subnet_id | **string**

Required field.  ||
|#

## User {#yandex.cloud.clouddesktop.v1.api.User}

#|
||Field | Description ||
|| subject_id | **string**

Required field. Identity of the access binding. ||
|| subject_type | **string**

Required field. Type of the access binding, e.g. userAccount, serviceAccount, system. ||
|#