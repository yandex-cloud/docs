---
editable: false
apiPlayground:
  - url: https://cloud-desktop.{{ api-host }}/cloud-desktop/v1/desktopGroups
    method: get
    path: null
    query:
      type: object
      properties:
        folderId:
          description: |-
            **string**
            Required field. ID of the folder to list desktop groups in.
            To get the folder ID use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/Folder/list#List) request.
          type: string
        pageSize:
          description: |-
            **string** (int64)
            The maximum number of results per page to return. If the number of available
            results is larger than `pageSize`,
            the service returns a [ListDesktopGroupsResponse.nextPageToken](/docs/cloud-desktop/api-ref/DesktopGroup/list#yandex.cloud.clouddesktop.v1.api.ListDesktopGroupsResponse)
            that can be used to get the next page of results in subsequent list requests.
            Default value: 100.
          type: string
          format: int64
        pageToken:
          description: |-
            **string**
            Page token. To get the next page of results, set `pageToken` to the
            [ListDesktopGroupsResponse.nextPageToken](/docs/cloud-desktop/api-ref/DesktopGroup/list#yandex.cloud.clouddesktop.v1.api.ListDesktopGroupsResponse) returned by a previous list request.
          type: string
        filter:
          description: |-
            **string**
            A filter expression that filters resources listed in the response.
            The expression must specify:
            1. The field name. Currently you can use filtering only on [DesktopGroup.name](/docs/cloud-desktop/api-ref/DesktopGroup/get#yandex.cloud.clouddesktop.v1.api.DesktopGroup) field.
            2. An operator. Can be either `=` or `!=` for single values, `IN` or `NOT IN` for lists of values.
            3. Value or a list of values to compare against the values of the field.
          type: string
        orderBy:
          description: |-
            **string**
            Sorting the list by [DesktopGroup.name](/docs/cloud-desktop/api-ref/DesktopGroup/get#yandex.cloud.clouddesktop.v1.api.DesktopGroup), [DesktopGroup.createdAt](/docs/cloud-desktop/api-ref/DesktopGroup/get#yandex.cloud.clouddesktop.v1.api.DesktopGroup) and [DesktopGroup.status](/docs/cloud-desktop/api-ref/DesktopGroup/get#yandex.cloud.clouddesktop.v1.api.DesktopGroup) fields.
            The default sorting order is ascending.
          type: string
      required:
        - folderId
      additionalProperties: false
    body: null
    definitions: null
sourcePath: en/_api-ref/clouddesktop/v1/api-ref/DesktopGroup/list.md
---

# Cloud Desktop API, REST: DesktopGroup.List

Retrieves the list of desktop group resources.

## HTTP request

```
GET https://cloud-desktop.{{ api-host }}/cloud-desktop/v1/desktopGroups
```

## Query parameters {#yandex.cloud.clouddesktop.v1.api.ListDesktopGroupsRequest}

#|
||Field | Description ||
|| folderId | **string**

Required field. ID of the folder to list desktop groups in.

To get the folder ID use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/Folder/list#List) request. ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`,
the service returns a [ListDesktopGroupsResponse.nextPageToken](#yandex.cloud.clouddesktop.v1.api.ListDesktopGroupsResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100. ||
|| pageToken | **string**

Page token. To get the next page of results, set `pageToken` to the
[ListDesktopGroupsResponse.nextPageToken](#yandex.cloud.clouddesktop.v1.api.ListDesktopGroupsResponse) returned by a previous list request. ||
|| filter | **string**

A filter expression that filters resources listed in the response.
The expression must specify:
1. The field name. Currently you can use filtering only on [DesktopGroup.name](#yandex.cloud.clouddesktop.v1.api.DesktopGroup) field.
2. An operator. Can be either `=` or `!=` for single values, `IN` or `NOT IN` for lists of values.
3. Value or a list of values to compare against the values of the field. ||
|| orderBy | **string**

Sorting the list by [DesktopGroup.name](#yandex.cloud.clouddesktop.v1.api.DesktopGroup), [DesktopGroup.createdAt](#yandex.cloud.clouddesktop.v1.api.DesktopGroup) and [DesktopGroup.status](#yandex.cloud.clouddesktop.v1.api.DesktopGroup) fields.
The default sorting order is ascending. ||
|#

## Response {#yandex.cloud.clouddesktop.v1.api.ListDesktopGroupsResponse}

**HTTP Code: 200 - OK**

```json
{
  "desktopGroups": [
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
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| desktopGroups[] | **[DesktopGroup](#yandex.cloud.clouddesktop.v1.api.DesktopGroup)**

List of desktop groups. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListDesktopGroupsRequest.pageSize](#yandex.cloud.clouddesktop.v1.api.ListDesktopGroupsRequest), use
the `nextPageToken` as the value
for the [ListDesktopGroupsRequest.pageToken](#yandex.cloud.clouddesktop.v1.api.ListDesktopGroupsRequest) query parameter
in the next list request. Each subsequent list request will have its own
`nextPageToken` to continue paging through the results. ||
|#

## DesktopGroup {#yandex.cloud.clouddesktop.v1.api.DesktopGroup}

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

## DiskSpec {#yandex.cloud.clouddesktop.v1.api.DiskSpec}

Disk specificaton.

#|
||Field | Description ||
|| type | **enum** (Type)

Required field. Type of disk.

- `TYPE_UNSPECIFIED`: Disk type is not specified.
- `HDD`: HDD disk type.
- `SSD`: SSD disk type. ||
|| size | **string** (int64)

Size of disk. ||
|#

## DesktopGroupConfiguration {#yandex.cloud.clouddesktop.v1.api.DesktopGroupConfiguration}

#|
||Field | Description ||
|| minReadyDesktops | **string** (int64)

Minimum number of ready desktops. ||
|| maxDesktopsAmount | **string** (int64)

Maximum number of desktops. ||
|| desktopType | **enum** (DesktopType)

Type of the desktop.

- `DESKTOP_TYPE_UNSPECIFIED`
- `PERSISTENT`
- `NON_PERSISTENT` ||
|| members[] | **[Subject](#yandex.cloud.access.Subject)**

List of members of the desktop group. ||
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
with given <id>. It can be used only if the `type` is `system`.
* `group:federation:<id>:users`: A special system group that represents all users of federation
with given <id>. It can be used only if the `type` is `system`.
* `<cloud generated id>`: An identifier that represents a user account.
It can be used only if the `type` is `userAccount`, `federatedUser` or `serviceAccount`. ||
|| type | **string**

Required field. Type of the subject.

It can contain one of the following values:
* `userAccount`: An account on Yandex or Yandex Connect, added to Yandex Cloud.
* `serviceAccount`: A service account. This type represents the [yandex.cloud.iam.v1.ServiceAccount](/docs/iam/api-ref/ServiceAccount/get#yandex.cloud.iam.v1.ServiceAccount) resource.
* `federatedUser`: A federated account. This type represents a user from an identity federation, like Active Directory.
* `system`: System group. This type represents several accounts with a common system identifier.

For more information, see [Subject to which the role is assigned](/docs/iam/concepts/access-control/#subject). ||
|#