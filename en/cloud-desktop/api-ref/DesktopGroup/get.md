---
editable: false
apiPlayground:
  - url: https://cloud-desktop.{{ api-host }}/cloud-desktop/v1/desktopGroups/{desktopGroupId}
    method: get
    path:
      type: object
      properties:
        desktopGroupId:
          description: |-
            **string**
            Required field. ID of the desktop group resource to return.
            To get the desktop group ID use a [DesktopGroupService.List](/docs/cloud-desktop/api-ref/DesktopGroup/list#List) request.
            The maximum string length in characters is 50.
          type: string
      required:
        - desktopGroupId
      additionalProperties: false
    query: null
    body: null
    definitions: null
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

To get the desktop group ID use a [DesktopGroupService.List](/docs/cloud-desktop/api-ref/DesktopGroup/list#List) request.

The maximum string length in characters is 50. ||
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
  "labels": "object",
  "bootDiskSpec": {
    "type": "string",
    "size": "string"
  },
  "dataDiskSpec": {
    "type": "string",
    "size": "string"
  },
  "groupConfig": {
    "minReadyDesktops": "string",
    "maxDesktopsAmount": "string",
    "desktopType": "string",
    "members": [
      {
        "id": "string",
        "type": "string"
      }
    ]
  },
  // Includes only one of the fields `autoUpdatePolicy`, `manualUpdatePolicy`
  "autoUpdatePolicy": "object",
  "manualUpdatePolicy": "object"
  // end of the list of possible fields
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

- `CREATING`: Desktop group is being created.
- `ACTIVE`: Desktop group is ready to use.
- `DELETING`: Desktop group is being deleted.
- `UPDATING`: Desktop group is updating. ||
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
|| bootDiskSpec | **[DiskSpec](#yandex.cloud.clouddesktop.v1.api.DiskSpec)**

Boot disk specification of the desktop group. ||
|| dataDiskSpec | **[DiskSpec](#yandex.cloud.clouddesktop.v1.api.DiskSpec)**

Data disk specification of the desktop group. ||
|| groupConfig | **[DesktopGroupConfiguration](#yandex.cloud.clouddesktop.v1.api.DesktopGroupConfiguration)**

Desktop group configuration. ||
|| autoUpdatePolicy | **object**

Includes only one of the fields `autoUpdatePolicy`, `manualUpdatePolicy`.

Desktop group update policy. ||
|| manualUpdatePolicy | **object**

Includes only one of the fields `autoUpdatePolicy`, `manualUpdatePolicy`.

Desktop group update policy. ||
|#

## ResourcesSpec {#yandex.cloud.clouddesktop.v1.api.ResourcesSpec}

#|
||Field | Description ||
|| memory | **string** (int64)

RAM volume, in bytes.

The minimum value is 1. ||
|| cores | **string** (int64)

Number of CPU cores.

The minimum value is 1. ||
|| coreFraction | **string** (int64)

Baseline level of CPU performance with the ability to burst performance above that baseline level.
This field sets baseline performance for each core.

Acceptable values are 0 to 100, inclusive. ||
|#

## NetworkInterfaceSpec {#yandex.cloud.clouddesktop.v1.api.NetworkInterfaceSpec}

#|
||Field | Description ||
|| networkId | **string**

Required field. ID of the network interface specification.

The maximum string length in characters is 50. ||
|| subnetIds[] | **string**

List of subnet IDs.

The number of elements must be greater than 0. The maximum string length in characters for each value is 50. ||
|#

## DiskSpec {#yandex.cloud.clouddesktop.v1.api.DiskSpec}

Disk specificaton.

#|
||Field | Description ||
|| type | **enum** (Type)

Required field. Type of disk.

- `HDD`: HDD disk type.
- `SSD`: SSD disk type. ||
|| size | **string** (int64)

Size of disk.

Value must be greater than 0. ||
|#

## DesktopGroupConfiguration {#yandex.cloud.clouddesktop.v1.api.DesktopGroupConfiguration}

#|
||Field | Description ||
|| minReadyDesktops | **string** (int64)

Minimum number of ready desktops.

Acceptable values are 1 to 512, inclusive. ||
|| maxDesktopsAmount | **string** (int64)

Maximum number of desktops.

Acceptable values are 0 to 512, inclusive. ||
|| desktopType | **enum** (DesktopType)

Type of the desktop.

- `PERSISTENT`
- `NON_PERSISTENT` ||
|| members[] | **[Subject](#yandex.cloud.access.Subject)**

List of members of the desktop group.

The number of elements must be in the range 0-10. ||
|#

## Subject {#yandex.cloud.access.Subject}

#|
||Field | Description ||
|| id | **string**

Required field. ID of the subject.

It can contain one of the following values:
* `allAuthenticatedUsers`: A special public group that represents anyone
who is authenticated. It can be used only if the `type` is `system`.
* `allUsers`: A special public group that represents anyone. No authentication is required.
For example, you don't need to specify the IAM token in an API query.
It can be used only if the `type` is `system`.
* `group:organization:<id>:users`: A special system group that represents all members of organization
with given &lt;id&gt;. It can be used only if the `type` is `system`.
* `group:federation:<id>:users`: A special system group that represents all users of federation
with given &lt;id&gt;. It can be used only if the `type` is `system`.
* `<cloud generated id>`: An identifier that represents a user account.
It can be used only if the `type` is `userAccount`, `federatedUser` or `serviceAccount`.

The maximum string length in characters is 100. ||
|| type | **string**

Required field. Type of the subject.

It can contain one of the following values:
* `userAccount`: An account on Yandex or Yandex Connect, added to Yandex Cloud.
* `serviceAccount`: A service account. This type represents the [yandex.cloud.iam.v1.ServiceAccount](/docs/iam/api-ref/ServiceAccount/get#yandex.cloud.iam.v1.ServiceAccount) resource.
* `federatedUser`: A federated account. This type represents a user from an identity federation, like Active Directory.
* `system`: System group. This type represents several accounts with a common system identifier.

For more information, see [Subject to which the role is assigned](/docs/iam/concepts/access-control/#subject).

The maximum string length in characters is 100. ||
|#