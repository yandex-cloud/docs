---
editable: false
sourcePath: en/_api-ref/clouddesktop/v1/api-ref/DesktopGroup/get.md
---

# Cloud Desktop API, REST: DesktopGroup.Get

Returns the specified desktop group resource.

To get the list of available desktop groups, make a [List](/docs/cloud-desktop/api-ref/DesktopGroup/list#List) request.

## HTTP request

```
GET https://cloud-desktop.{{ api-host }}/cloud-desktop/v1/desktopGroups/{desktopGroupId}
```

## Path parameters

#|
||Field | Description ||
|| desktopGroupId | **string**

Required field. ID of the desktop group resource to return.

To get the desktop group ID use a [DesktopGroupService.List](/docs/cloud-desktop/api-ref/DesktopGroup/list#List) request. ||
|#

## Response {#yandex.cloud.clouddesktop.v1.api.DesktopGroup}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "folderId": "string",
  "createdAt": "string",
  "status": "string",
  "name": "string",
  "description": "string",
  "resourcesSpec": {
    "memory": "string",
    "cores": "string",
    "coreFraction": "string"
  },
  "networkInterfaceSpec": {
    "networkId": "string",
    "subnetIds": [
      "string"
    ]
  },
  "labels": "object"
}
```

A desktop group resource.

#|
||Field | Description ||
|| id | **string**

Desktop group ID. ||
|| folderId | **string**

ID of the folder that the desktop group belongs to. ||
|| createdAt | **string** (date-time)

Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| status | **enum** (Status)

Status of the desktop group.

- `STATUS_UNSPECIFIED`
- `CREATING`: Desktop group is being created.
- `ACTIVE`: Desktop group is ready to use.
- `DELETING`: Desktop group is being deleted. ||
|| name | **string**

Name of the desktop group. ||
|| description | **string**

Description of the desktop group. ||
|| resourcesSpec | **[ResourcesSpec](#yandex.cloud.clouddesktop.v1.api.ResourcesSpec)**

Resource specification of the desktop group. ||
|| networkInterfaceSpec | **[NetworkInterfaceSpec](#yandex.cloud.clouddesktop.v1.api.NetworkInterfaceSpec)**

Network interface specification of the desktop group. ||
|| labels | **object** (map<**string**, **string**>)

Labels of the desktop group. ||
|#

## ResourcesSpec {#yandex.cloud.clouddesktop.v1.api.ResourcesSpec}

#|
||Field | Description ||
|| memory | **string** (int64)

RAM volume, in bytes. ||
|| cores | **string** (int64)

Number of CPU cores. ||
|| coreFraction | **string** (int64)

Baseline level of CPU performance with the ability to burst performance above that baseline level.
This field sets baseline performance for each core. ||
|#

## NetworkInterfaceSpec {#yandex.cloud.clouddesktop.v1.api.NetworkInterfaceSpec}

#|
||Field | Description ||
|| networkId | **string**

Required field. ID of the network interface specification. ||
|| subnetIds[] | **string**

List of subnet IDs. ||
|#