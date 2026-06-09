# Cloud Desktop API, REST: Desktop.Get

Returns the specified desktop resource.
To get the list of available desktops, make a [List](list.md#List) request.

## HTTP request

```
GET https://clouddesktops.{{ api-host }}/cloud-desktop/v1/desktops/{desktopId}
```

## Path parameters

#|
||Field | Description ||
|| desktopId | **string**

Required field. ID of the desktop resource to return.
To get the desktop ID use a [DesktopService.List](list.md#List) request.

The maximum string length in characters is 50. ||
|#

## Response {#yandex.cloud.clouddesktop.v1.api.Desktop}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "folderId": "string",
  "desktopGroupId": "string",
  "createdAt": "string",
  "status": "string",
  "name": "string",
  "labels": "object",
  "description": "string",
  "resources": {
    "memory": "string",
    "cores": "string",
    "coreFraction": "string"
  },
  "networkInterfaces": [
    {
      "networkId": "string",
      "subnetId": "string"
    }
  ],
  "users": [
    {
      "subjectId": "string",
      "subjectType": "string"
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
|| createdAt | **string** (date-time)

Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| status | **enum** (Status)

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
|| networkInterfaces[] | **[NetworkInterface](#yandex.cloud.clouddesktop.v1.api.NetworkInterface)**

Network interfaces of the desktop. ||
|| users[] | **[User](#yandex.cloud.clouddesktop.v1.api.User)**

Users of the desktop. ||
|#

## Resources {#yandex.cloud.clouddesktop.v1.api.Resources}

#|
||Field | Description ||
|| memory | **string** (int64)

The amount of memory available to the desktop, specified in bytes.

The minimum value is 1. ||
|| cores | **string** (int64)

The number of cores available to the desktop.

The minimum value is 1. ||
|| coreFraction | **string** (int64)

Baseline level of CPU performance with the ability to burst performance above that baseline level.
This field sets baseline performance for each core.
For example, if you need only 5% of the CPU performance, you can set core_fraction=5.

Acceptable values are 0 to 100, inclusive. ||
|#

## NetworkInterface {#yandex.cloud.clouddesktop.v1.api.NetworkInterface}

#|
||Field | Description ||
|| networkId | **string**

Required field. ID of the network.

The maximum string length in characters is 50. ||
|| subnetId | **string**

Required field. ID of the subnet.

The maximum string length in characters is 50. ||
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