[Документация Yandex Cloud](../../../../index.md) > [Yandex Cloud Desktop](../../../index.md) > Справочник API > [gRPC (англ.)](../index.md) > [Desktop](index.md) > Get

# Cloud Desktop API, gRPC: DesktopService.Get

Returns the specified desktop resource.
To get the list of available desktops, make a [List](list.md#List) request.

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
To get the desktop ID use a [DesktopService.List](list.md#List) request.

The maximum string length in characters is 50. ||
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
  "labels": "map<string, string>",
  "description": "string",
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
  ]
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

- `CREATING`: Desktop is being created.
- `ACTIVE`: Desktop is ready to be used.
- `DELETING`: Desktop is being deleted.
- `RESTARTING`: Desktop is restarting.
- `UPDATING`: Desktop is updating.
- `STARTING`: Desktop is starting.
- `STOPPING`: Desktop is stopping.
- `STOPPED`: Desktop is stopped.
- `ERROR`: Desktop did not manage start or restart.
- `CREATION_FAILED`: Desktop did not manage to get created or updated.
- `HEALTH_CHECK`: Desktop in the process of health check. ||
|| name | **string**

Name of the desktop. ||
|| labels | **object** (map<**string**, **string**>)

Labels of the desktop. ||
|| description | **string**

Description of the desktop. ||
|| resources | **[Resources](#yandex.cloud.clouddesktop.v1.api.Resources)**

Resources of the desktop. ||
|| network_interfaces[] | **[NetworkInterface](#yandex.cloud.clouddesktop.v1.api.NetworkInterface)**

Network interfaces of the desktop. ||
|| users[] | **[User](#yandex.cloud.clouddesktop.v1.api.User)**

Users of the desktop. ||
|#

## Resources {#yandex.cloud.clouddesktop.v1.api.Resources}

#|
||Field | Description ||
|| memory | **int64**

The amount of memory available to the desktop, specified in bytes.

The minimum value is 1. ||
|| cores | **int64**

The number of cores available to the desktop.

The minimum value is 1. ||
|| core_fraction | **int64**

Baseline level of CPU performance with the ability to burst performance above that baseline level.
This field sets baseline performance for each core.
For example, if you need only 5% of the CPU performance, you can set core_fraction=5.

Acceptable values are 0 to 100, inclusive. ||
|#

## NetworkInterface {#yandex.cloud.clouddesktop.v1.api.NetworkInterface}

#|
||Field | Description ||
|| network_id | **string**

Required field. ID of the network.

The maximum string length in characters is 50. ||
|| subnet_id | **string**

Required field. ID of the subnet.

The maximum string length in characters is 50. ||
|#

## User {#yandex.cloud.clouddesktop.v1.api.User}

#|
||Field | Description ||
|| subject_id | **string**

Required field. Identity of the access binding.

The maximum string length in characters is 100. ||
|| subject_type | **string**

Required field. Type of the access binding, e.g. userAccount, serviceAccount, system.

The maximum string length in characters is 100. ||
|#