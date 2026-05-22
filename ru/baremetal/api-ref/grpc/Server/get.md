---
editable: false
---

# BareMetal API, gRPC: ServerService.Get

Returns the specific Server resource.
To get the list of available Server resources, make a [List](/docs/baremetal/api-ref/grpc/Server/list#List) request.

## gRPC request

**rpc Get ([GetServerRequest](#yandex.cloud.baremetal.v1alpha.GetServerRequest)) returns ([Server](#yandex.cloud.baremetal.v1alpha.Server))**

## GetServerRequest {#yandex.cloud.baremetal.v1alpha.GetServerRequest}

```json
{
  "server_id": "string"
}
```

#|
||Field | Description ||
|| server_id | **string**

ID of the Server resource to return.
To get the server ID, use a [ServerService.List](/docs/baremetal/api-ref/grpc/Server/list#List) request.

Value must match the regular expression ` [a-z][a-z0-9]* `. ||
|#

## Server {#yandex.cloud.baremetal.v1alpha.Server}

```json
{
  "id": "string",
  "cloud_id": "string",
  "folder_id": "string",
  "name": "string",
  "description": "string",
  "zone_id": "string",
  "hardware_pool_id": "string",
  "status": "Status",
  "os_settings": {
    "image_id": "string",
    "ssh_public_key": "string",
    "storages": [
      {
        // Includes only one of the fields `disk`, `raid`
        "disk": {
          "id": "string",
          "type": "DiskDriveType",
          "size_gib": "int64"
        },
        "raid": {
          "type": "RaidType",
          "disks": [
            {
              "id": "string",
              "type": "DiskDriveType",
              "size_gib": "int64"
            }
          ]
        },
        // end of the list of possible fields
        "partitions": [
          {
            "type": "StoragePartitionType",
            "size_gib": "int64",
            "mount_point": "string"
          }
        ]
      }
    ]
  },
  "network_interfaces": [
    {
      // Includes only one of the fields `private_subnet`, `public_subnet`
      "private_subnet": {
        "private_subnet_id": "string"
      },
      "public_subnet": {
        "public_subnet_id": "string"
      },
      // end of the list of possible fields
      // Includes only one of the fields `private_interface`, `public_interface`
      "private_interface": {
        "native_subnet_id": "string",
        "ip_address": "string",
        "mac_limit": "int64",
        "vlan_subinterfaces": [
          {
            "tagged_subnet_id": "string",
            "ip_address": "string",
            "mac_limit": "int64"
          }
        ]
      },
      "public_interface": {
        // Includes only one of the fields `native_subnet`, `new_native_subnet`
        "native_subnet": {
          "subnet_id": "string"
        },
        "new_native_subnet": {
          "addressing_type": "AddressingType"
        },
        // end of the list of possible fields
        "ip_address": "string",
        "native_subnet_id": "string",
        "mac_limit": "int64"
      },
      // end of the list of possible fields
      "id": "string",
      "mac_address": "string",
      "ip_address": "string"
    }
  ],
  "configuration_id": "string",
  "disks": [
    {
      "id": "string",
      "type": "DiskDriveType",
      "size_gib": "int64"
    }
  ],
  "created_at": "google.protobuf.Timestamp",
  "labels": "map<string, string>"
}
```

A Server resource.

#|
||Field | Description ||
|| id | **string**

ID of the server. ||
|| cloud_id | **string**

ID of the cloud that the server belongs to. ||
|| folder_id | **string**

ID of the folder that the server belongs to. ||
|| name | **string**

Name of the server.
The name is unique within the folder. ||
|| description | **string**

Description of the server. ||
|| zone_id | **string**

ID of the availability zone where the server is resides. ||
|| hardware_pool_id | **string**

ID of the hardware pool that the server belongs to. ||
|| status | enum **Status**

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
|| os_settings | **[OsSettings](#yandex.cloud.baremetal.v1alpha.OsSettings)**

Operating system specific settings of the server. Optional, will be empty if the server is
provisioned without an operating system. ||
|| network_interfaces[] | **[NetworkInterface](#yandex.cloud.baremetal.v1alpha.NetworkInterface)**

Array of network interfaces that are attached to the instance. ||
|| configuration_id | **string**

ID of the configuration that was used to create the server. ||
|| disks[] | **[Disk](#yandex.cloud.baremetal.v1alpha.Disk)**

Array of disks that are attached to the server. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs. ||
|#

## OsSettings {#yandex.cloud.baremetal.v1alpha.OsSettings}

#|
||Field | Description ||
|| image_id | **string**

ID of the image that the server was created from. ||
|| ssh_public_key | **string**

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
|| type | enum **DiskDriveType**

Type of the disk drive.

- `HDD`: Hard disk drive (magnetic storage).
- `SSD`: Solid state drive with SATA/SAS interface.
- `NVME`: Solid state drive with NVMe interface. ||
|| size_gib | **int64**

Size of the disk in gibibytes (2^30 bytes). ||
|#

## Raid {#yandex.cloud.baremetal.v1alpha.Raid}

RAID storage.

#|
||Field | Description ||
|| type | enum **RaidType**

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
|| type | enum **StoragePartitionType**

Partition type.

- `EXT4`: ext4 file system partition type.
- `SWAP`: Swap partition type.
- `EXT3`: ext3 file system partition type.
- `XFS`: XFS file system partition type. ||
|| size_gib | **int64**

Size of the storage partition in gibibytes (2^30 bytes). ||
|| mount_point | **string**

Storage mount point. ||
|#

## NetworkInterface {#yandex.cloud.baremetal.v1alpha.NetworkInterface}

#|
||Field | Description ||
|| private_subnet | **[PrivateSubnetNetworkInterface](#yandex.cloud.baremetal.v1alpha.PrivateSubnetNetworkInterface)**

@deprecated Private subnet.

Includes only one of the fields `private_subnet`, `public_subnet`.

@deprecated. Use `interface` instead.
Subnet that the network interface belongs to. ||
|| public_subnet | **[PublicSubnetNetworkInterface](#yandex.cloud.baremetal.v1alpha.PublicSubnetNetworkInterface)**

@deprecated Public subnet.

Includes only one of the fields `private_subnet`, `public_subnet`.

@deprecated. Use `interface` instead.
Subnet that the network interface belongs to. ||
|| private_interface | **[PrivateNetworkInterface](#yandex.cloud.baremetal.v1alpha.PrivateNetworkInterface)**

Private interface.

Includes only one of the fields `private_interface`, `public_interface`. ||
|| public_interface | **[PublicNetworkInterface](#yandex.cloud.baremetal.v1alpha.PublicNetworkInterface)**

Public interface.

Includes only one of the fields `private_interface`, `public_interface`. ||
|| id | **string**

ID of the network interface. ||
|| mac_address | **string**

MAC address that is assigned to the network interface.
Read only field. ||
|| ip_address | **string**

@deprecated. Use `interface.ipaddress` instead.
IPv4 address that is assigned to the server for this network interface.
Read only field. ||
|#

## PrivateSubnetNetworkInterface {#yandex.cloud.baremetal.v1alpha.PrivateSubnetNetworkInterface}

#|
||Field | Description ||
|| private_subnet_id | **string**

ID of the private subnet. ||
|#

## PublicSubnetNetworkInterface {#yandex.cloud.baremetal.v1alpha.PublicSubnetNetworkInterface}

#|
||Field | Description ||
|| public_subnet_id | **string**

ID of the public subnet.
A new ephemeral public subnet will be created if not specified. ||
|#

## PrivateNetworkInterface {#yandex.cloud.baremetal.v1alpha.PrivateNetworkInterface}

#|
||Field | Description ||
|| native_subnet_id | **string**

ID of the private subnet which is used as native subnet for interface. ||
|| ip_address | **string**

IPv4 address that is assigned to the server for this network interface.
Read only field. ||
|| mac_limit | **int64**

Limit of MAC addresses in the native subnet.
Read only field. ||
|| vlan_subinterfaces[] | **[VLANSubinterface](#yandex.cloud.baremetal.v1alpha.VLANSubinterface)**

Array of VLAN subinterfaces. Additional tagged subnets for the interface. ||
|#

## VLANSubinterface {#yandex.cloud.baremetal.v1alpha.VLANSubinterface}

#|
||Field | Description ||
|| tagged_subnet_id | **string**

ID of the private subnet which is used as tagged subnet for interface. ||
|| ip_address | **string**

IPv4 address that is assigned to the VLAN subinterface.
Read only field. ||
|| mac_limit | **int64**

Limit of MAC addresses in the tagged subnet.
Read only field. ||
|#

## PublicNetworkInterface {#yandex.cloud.baremetal.v1alpha.PublicNetworkInterface}

#|
||Field | Description ||
|| native_subnet | **[NativeSubnet](#yandex.cloud.baremetal.v1alpha.PublicNetworkInterface.NativeSubnet)**

Use existing native subnet.
Input only field.

Includes only one of the fields `native_subnet`, `new_native_subnet`.

Native subnet configuration.
Input only field. ||
|| new_native_subnet | **[NewNativeSubnet](#yandex.cloud.baremetal.v1alpha.PublicNetworkInterface.NewNativeSubnet)**

Create new native subnet.
Input only field.

Includes only one of the fields `native_subnet`, `new_native_subnet`.

Native subnet configuration.
Input only field. ||
|| ip_address | **string**

IPv4 address that is assigned to the server for this network interface.
Read only field. ||
|| native_subnet_id | **string**

ID of the public subnet which is used as native subnet for interface.
Read only field. ||
|| mac_limit | **int64**

Limit of MAC addresses in the native subnet.
Read only field. ||
|#

## NativeSubnet {#yandex.cloud.baremetal.v1alpha.PublicNetworkInterface.NativeSubnet}

Configuration for using existing native subnet.

#|
||Field | Description ||
|| subnet_id | **string**

ID of the existing public subnet. ||
|#

## NewNativeSubnet {#yandex.cloud.baremetal.v1alpha.PublicNetworkInterface.NewNativeSubnet}

Configuration for creating new native subnet.

#|
||Field | Description ||
|| addressing_type | enum **AddressingType**

Addressing type (DHCP \| Static).

- `DHCP`: DHCP addressing.
- `STATIC`: Static addressing. ||
|#