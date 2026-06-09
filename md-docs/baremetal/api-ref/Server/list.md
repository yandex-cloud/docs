# BareMetal API, REST: Server.List

Retrieves the list of Server resources in the specified folder.

## HTTP request

```
GET https://baremetal.{{ api-host }}/baremetal/v1alpha/servers
```

## Query parameters {#yandex.cloud.baremetal.v1alpha.ListServerRequest}

#|
||Field | Description ||
|| folderId | **string**

ID of the folder to list servers in.
To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](../../../resource-manager/api-ref/Folder/list.md#List) request.

The maximum string length in characters is 50. Value must match the regular expression ` [a-z][a-z0-9.-]* `. ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is greater than `page_size`,
the service returns a [ListServerResponse.nextPageToken](#yandex.cloud.baremetal.v1alpha.ListServerResponse)
that can be used to get the next page of results in subsequent list requests.
Default value is 20.

The maximum value is 1000. ||
|| pageToken | **string**

Page token. To get the next page of results, set `page_token` to the
[ListServerResponse.nextPageToken](#yandex.cloud.baremetal.v1alpha.ListServerResponse) returned by a previous list request. ||
|| orderBy | **string**

By which column the listing should be ordered and in which direction,
format is "createdAt desc". "id asc" if omitted.
Supported fields: ["id", "name", "createdAt"].
Both snake_case and camelCase are supported for fields. ||
|| filter | **string**

A filter expression that filters resources listed in the response.
The expression consists of one or more conditions united by `AND` operator: `<condition1> [AND <condition2> [<...> AND <conditionN>]]`.
Each condition has the form `<field> <operator> <value>`, where:
1. `<field>` is the field name. Currently you can use filtering only on the limited number of fields.
2. `<operator>` is a logical operator, one of `=` (equal), `:` (substring).
3. `<value>` represents a value.
String values should be written in double (`"`) or single (`'`) quotes. C-style escape sequences are supported (`\"` turns to `"`, `\'` to `'`, `\\` to backslash).
Example: "key1='value' AND key2='value'"
Supported operators: ["AND"].
Supported fields: ["id", "name", "zoneId", "hardwarePoolId"].
Both snake_case and camelCase are supported for fields. ||
|#

## Response {#yandex.cloud.baremetal.v1alpha.ListServerResponse}

**HTTP Code: 200 - OK**

```json
{
  "servers": [
    {
      "id": "string",
      "cloudId": "string",
      "folderId": "string",
      "name": "string",
      "description": "string",
      "zoneId": "string",
      "hardwarePoolId": "string",
      "status": "string",
      "osSettings": {
        "imageId": "string",
        "sshPublicKey": "string",
        "storages": [
          {
            // Includes only one of the fields `disk`, `raid`
            "disk": {
              "id": "string",
              "type": "string",
              "sizeGib": "string"
            },
            "raid": {
              "type": "string",
              "disks": [
                {
                  "id": "string",
                  "type": "string",
                  "sizeGib": "string"
                }
              ]
            },
            // end of the list of possible fields
            "partitions": [
              {
                "type": "string",
                "sizeGib": "string",
                "mountPoint": "string"
              }
            ]
          }
        ]
      },
      "networkInterfaces": [
        {
          // Includes only one of the fields `privateSubnet`, `publicSubnet`
          "privateSubnet": {
            "privateSubnetId": "string"
          },
          "publicSubnet": {
            "publicSubnetId": "string"
          },
          // end of the list of possible fields
          // Includes only one of the fields `privateInterface`, `publicInterface`
          "privateInterface": {
            "nativeSubnetId": "string",
            "ipAddress": "string",
            "macLimit": "string",
            "vlanSubinterfaces": [
              {
                "taggedSubnetId": "string",
                "ipAddress": "string",
                "macLimit": "string"
              }
            ]
          },
          "publicInterface": {
            // Includes only one of the fields `nativeSubnet`, `newNativeSubnet`
            "nativeSubnet": {
              "subnetId": "string"
            },
            "newNativeSubnet": {
              "addressingType": "string"
            },
            // end of the list of possible fields
            "ipAddress": "string",
            "nativeSubnetId": "string",
            "macLimit": "string"
          },
          // end of the list of possible fields
          "id": "string",
          "macAddress": "string",
          "ipAddress": "string"
        }
      ],
      "configurationId": "string",
      "disks": [
        {
          "id": "string",
          "type": "string",
          "sizeGib": "string"
        }
      ],
      "createdAt": "string",
      "labels": "object"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| servers[] | **[Server](#yandex.cloud.baremetal.v1alpha.Server)**

List of Server resources. ||
|| nextPageToken | **string**

Token for getting the next page of the list. If the number of results is greater than
[ListServerRequest.pageSize](#yandex.cloud.baremetal.v1alpha.ListServerRequest), use `next_page_token` as the value
for the [ListServerRequest.pageToken](#yandex.cloud.baremetal.v1alpha.ListServerRequest) parameter in the next list request.
Each subsequent page will have its own `next_page_token` to continue paging through the results. ||
|#

## Server {#yandex.cloud.baremetal.v1alpha.Server}

A Server resource.

#|
||Field | Description ||
|| id | **string**

ID of the server. ||
|| cloudId | **string**

ID of the cloud that the server belongs to. ||
|| folderId | **string**

ID of the folder that the server belongs to. ||
|| name | **string**

Name of the server.
The name is unique within the folder. ||
|| description | **string**

Description of the server. ||
|| zoneId | **string**

ID of the availability zone where the server is resides. ||
|| hardwarePoolId | **string**

ID of the hardware pool that the server belongs to. ||
|| status | **enum** (Status)

Status of the server.

- `PROVISIONING`: Server is waiting for to be allocated from the hardware pool.
- `STOPPING`: Server is being stopped.
- `STOPPED`: Server has been stopped.
- `STARTING`: Server is being started.
- `RESTARTING`: Server is being restarted.
- `ERROR`: Server encountered a problem and cannot operate.
- `DELETING`: Server is being deleted.
- `REINSTALLING`: Server operating system is being reinstalled.
- `UPDATING`: Server is being updated.
- `QUARANTINED`: Server has been quarantined
- `RUNNING`: Server is running normaly ||
|| osSettings | **[OsSettings](#yandex.cloud.baremetal.v1alpha.OsSettings)**

Operating system specific settings of the server. Optional, will be empty if the server is
provisioned without an operating system. ||
|| networkInterfaces[] | **[NetworkInterface](#yandex.cloud.baremetal.v1alpha.NetworkInterface)**

Array of network interfaces that are attached to the instance. ||
|| configurationId | **string**

ID of the configuration that was used to create the server. ||
|| disks[] | **[Disk](#yandex.cloud.baremetal.v1alpha.Disk)**

Array of disks that are attached to the server. ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs. ||
|#

## OsSettings {#yandex.cloud.baremetal.v1alpha.OsSettings}

#|
||Field | Description ||
|| imageId | **string**

ID of the image that the server was created from. ||
|| sshPublicKey | **string**

Public SSH key of the server. ||
|| storages[] | **[Storage](#yandex.cloud.baremetal.v1alpha.Storage)**

List of storages. ||
|#

## Storage {#yandex.cloud.baremetal.v1alpha.Storage}

Storage, a OS-level storage entity used for creating partitions. For example, this could
represent a plain disk or a software RAID of disks.

#|
||Field | Description ||
|| disk | **[Disk](#yandex.cloud.baremetal.v1alpha.Disk)**

Disk storage.

Includes only one of the fields `disk`, `raid`.

Storage type. ||
|| raid | **[Raid](#yandex.cloud.baremetal.v1alpha.Raid)**

RAID storage.

Includes only one of the fields `disk`, `raid`.

Storage type. ||
|| partitions[] | **[StoragePartition](#yandex.cloud.baremetal.v1alpha.StoragePartition)**

Array of partitions created on the storage. ||
|#

## Disk {#yandex.cloud.baremetal.v1alpha.Disk}

Disk.

#|
||Field | Description ||
|| id | **string**

ID of the disk. ||
|| type | **enum** (DiskDriveType)

Type of the disk drive.

- `HDD`: Hard disk drive (magnetic storage).
- `SSD`: Solid state drive with SATA/SAS interface.
- `NVME`: Solid state drive with NVMe interface. ||
|| sizeGib | **string** (int64)

Size of the disk in gibibytes (2^30 bytes). ||
|#

## Raid {#yandex.cloud.baremetal.v1alpha.Raid}

RAID storage.

#|
||Field | Description ||
|| type | **enum** (RaidType)

RAID type.

- `RAID0`: RAID0 configuration.
- `RAID1`: RAID1 configuration.
- `RAID10`: RAID10 configuration. ||
|| disks[] | **[Disk](#yandex.cloud.baremetal.v1alpha.Disk)**

Array of disks in the RAID configuration. ||
|#

## StoragePartition {#yandex.cloud.baremetal.v1alpha.StoragePartition}

#|
||Field | Description ||
|| type | **enum** (StoragePartitionType)

Partition type.

- `EXT4`: ext4 file system partition type.
- `SWAP`: Swap partition type.
- `EXT3`: ext3 file system partition type.
- `XFS`: XFS file system partition type. ||
|| sizeGib | **string** (int64)

Size of the storage partition in gibibytes (2^30 bytes). ||
|| mountPoint | **string**

Storage mount point. ||
|#

## NetworkInterface {#yandex.cloud.baremetal.v1alpha.NetworkInterface}

#|
||Field | Description ||
|| privateSubnet | **[PrivateSubnetNetworkInterface](#yandex.cloud.baremetal.v1alpha.PrivateSubnetNetworkInterface)**

@deprecated Private subnet.

Includes only one of the fields `privateSubnet`, `publicSubnet`.

@deprecated. Use `interface` instead.
Subnet that the network interface belongs to. ||
|| publicSubnet | **[PublicSubnetNetworkInterface](#yandex.cloud.baremetal.v1alpha.PublicSubnetNetworkInterface)**

@deprecated Public subnet.

Includes only one of the fields `privateSubnet`, `publicSubnet`.

@deprecated. Use `interface` instead.
Subnet that the network interface belongs to. ||
|| privateInterface | **[PrivateNetworkInterface](#yandex.cloud.baremetal.v1alpha.PrivateNetworkInterface)**

Private interface.

Includes only one of the fields `privateInterface`, `publicInterface`. ||
|| publicInterface | **[PublicNetworkInterface](#yandex.cloud.baremetal.v1alpha.PublicNetworkInterface)**

Public interface.

Includes only one of the fields `privateInterface`, `publicInterface`. ||
|| id | **string**

ID of the network interface. ||
|| macAddress | **string**

MAC address that is assigned to the network interface.
Read only field. ||
|| ipAddress | **string**

@deprecated. Use `interface.ipaddress` instead.
IPv4 address that is assigned to the server for this network interface.
Read only field. ||
|#

## PrivateSubnetNetworkInterface {#yandex.cloud.baremetal.v1alpha.PrivateSubnetNetworkInterface}

#|
||Field | Description ||
|| privateSubnetId | **string**

ID of the private subnet. ||
|#

## PublicSubnetNetworkInterface {#yandex.cloud.baremetal.v1alpha.PublicSubnetNetworkInterface}

#|
||Field | Description ||
|| publicSubnetId | **string**

ID of the public subnet.
A new ephemeral public subnet will be created if not specified. ||
|#

## PrivateNetworkInterface {#yandex.cloud.baremetal.v1alpha.PrivateNetworkInterface}

#|
||Field | Description ||
|| nativeSubnetId | **string**

ID of the private subnet which is used as native subnet for interface. ||
|| ipAddress | **string**

IPv4 address that is assigned to the server for this network interface.
Read only field. ||
|| macLimit | **string** (int64)

Limit of MAC addresses in the native subnet.
Read only field. ||
|| vlanSubinterfaces[] | **[VLANSubinterface](#yandex.cloud.baremetal.v1alpha.VLANSubinterface)**

Array of VLAN subinterfaces. Additional tagged subnets for the interface. ||
|#

## VLANSubinterface {#yandex.cloud.baremetal.v1alpha.VLANSubinterface}

#|
||Field | Description ||
|| taggedSubnetId | **string**

ID of the private subnet which is used as tagged subnet for interface. ||
|| ipAddress | **string**

IPv4 address that is assigned to the VLAN subinterface.
Read only field. ||
|| macLimit | **string** (int64)

Limit of MAC addresses in the tagged subnet.
Read only field. ||
|#

## PublicNetworkInterface {#yandex.cloud.baremetal.v1alpha.PublicNetworkInterface}

#|
||Field | Description ||
|| nativeSubnet | **[NativeSubnet](#yandex.cloud.baremetal.v1alpha.PublicNetworkInterface.NativeSubnet)**

Use existing native subnet.
Input only field.

Includes only one of the fields `nativeSubnet`, `newNativeSubnet`.

Native subnet configuration.
Input only field. ||
|| newNativeSubnet | **[NewNativeSubnet](#yandex.cloud.baremetal.v1alpha.PublicNetworkInterface.NewNativeSubnet)**

Create new native subnet.
Input only field.

Includes only one of the fields `nativeSubnet`, `newNativeSubnet`.

Native subnet configuration.
Input only field. ||
|| ipAddress | **string**

IPv4 address that is assigned to the server for this network interface.
Read only field. ||
|| nativeSubnetId | **string**

ID of the public subnet which is used as native subnet for interface.
Read only field. ||
|| macLimit | **string** (int64)

Limit of MAC addresses in the native subnet.
Read only field. ||
|#

## NativeSubnet {#yandex.cloud.baremetal.v1alpha.PublicNetworkInterface.NativeSubnet}

Configuration for using existing native subnet.

#|
||Field | Description ||
|| subnetId | **string**

ID of the existing public subnet. ||
|#

## NewNativeSubnet {#yandex.cloud.baremetal.v1alpha.PublicNetworkInterface.NewNativeSubnet}

Configuration for creating new native subnet.

#|
||Field | Description ||
|| addressingType | **enum** (AddressingType)

Addressing type (DHCP \| Static).

- `DHCP`: DHCP addressing.
- `STATIC`: Static addressing. ||
|#