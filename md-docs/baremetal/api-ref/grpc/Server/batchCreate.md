[Документация Yandex Cloud](../../../../index.md) > [Yandex BareMetal](../../../index.md) > Концепции > Настройка и управление > Справочник API > [gRPC (англ.)](../index.md) > [Server](index.md) > BatchCreate

# BareMetal API, gRPC: ServerService.BatchCreate

Creates multiple servers in the specified folder.

## gRPC request

**rpc BatchCreate ([BatchCreateServersRequest](#yandex.cloud.baremetal.v1alpha.BatchCreateServersRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## BatchCreateServersRequest {#yandex.cloud.baremetal.v1alpha.BatchCreateServersRequest}

```json
{
  "folder_id": "string",
  "name": "string",
  "description": "string",
  "hardware_pool_id": "string",
  "configuration_id": "string",
  "rental_period_id": "string",
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
      "configuration_network_interface_id": "google.protobuf.StringValue"
    }
  ],
  "os_settings_spec": {
    // Includes only one of the fields `ssh_public_key`, `user_ssh_id`
    "ssh_public_key": "string",
    "user_ssh_id": "string",
    // end of the list of possible fields
    // Includes only one of the fields `password_plain_text`, `password_lockbox_secret`
    "password_plain_text": "string",
    "password_lockbox_secret": {
      "secret_id": "string",
      "version_id": "string",
      "key": "string"
    },
    // end of the list of possible fields
    "image_id": "string",
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
  "labels": "map<string, string>",
  "count": "int64"
}
```

#|
||Field | Description ||
|| folder_id | **string**

ID of the folder to list images in.
To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](../../../../resource-manager/api-ref/grpc/Folder/list.md#List) request.

The maximum string length in characters is 50. Value must match the regular expression ` [a-z][a-z0-9.-]* `. ||
|| name | **string**

Name of the server.
The name must be unique within the folder.

The string length in characters must be 2-56. Value must match the regular expression ` [a-z]([-a-z0-9]*[a-z0-9])? `. ||
|| description | **string**

Description of the server.

The maximum string length in characters is 1024. ||
|| hardware_pool_id | **string**

Required field. ID of the hardware pool that the server belongs to.
To get the hardware pool ID, use a [HardwarePoolService.List](../HardwarePool/list.md#List) request.

The maximum string length in characters is 20. ||
|| configuration_id | **string**

ID of the configuration to use for the server.
To get the configuration ID, use a [ConfigurationService.List](../Configuration/list.md#List) request.

Value must match the regular expression ``` ([a-z][a-z0-9]{19})| ```. ||
|| rental_period_id | **string**

A period of time for which the server is rented.
To get the rental period ID, use a [RentalPeriodService.List](../RentalPeriod/list.md#List) request.

The maximum string length in characters is 20. ||
|| network_interfaces[] | **[NetworkInterfaceSpec](#yandex.cloud.baremetal.v1alpha.NetworkInterfaceSpec)**

Network configuration for the server. Specifies how the network interface is configured
to interact with other servers on the internal network and on the internet.
Currently up to 2 network interfaces are supported: required private network interface and
optional public network interface.

The maximum number of elements is 2. ||
|| os_settings_spec | **[OsSettingsSpec](#yandex.cloud.baremetal.v1alpha.OsSettingsSpec)**

Operating system specific settings for provisioning the server. Optional, if omitted, the
server will be created without an operating system. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs.

The maximum string length in characters for each value is 63. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `. Each value must match the regular expression ` [-_0-9a-z]* `. No more than 64 per resource. ||
|| count | **int64**

Number of servers to create.

Acceptable values are 1 to 100, inclusive. ||
|#

## NetworkInterfaceSpec {#yandex.cloud.baremetal.v1alpha.NetworkInterfaceSpec}


Required for backward compatibility with old clients. --)

#|
||Field | Description ||
|| private_subnet | **[PrivateSubnetNetworkInterface](#yandex.cloud.baremetal.v1alpha.PrivateSubnetNetworkInterface)**

@deprecated Private subnet.

Includes only one of the fields `private_subnet`, `public_subnet`.

@deprecated. Use `interface` instead.
Subnet specific interface params. ||
|| public_subnet | **[PublicSubnetNetworkInterface](#yandex.cloud.baremetal.v1alpha.PublicSubnetNetworkInterface)**

@deprecated Public subnet.

Includes only one of the fields `private_subnet`, `public_subnet`.

@deprecated. Use `interface` instead.
Subnet specific interface params. ||
|| private_interface | **[PrivateNetworkInterface](#yandex.cloud.baremetal.v1alpha.PrivateNetworkInterface)**

Private interface.

Includes only one of the fields `private_interface`, `public_interface`. ||
|| public_interface | **[PublicNetworkInterface](#yandex.cloud.baremetal.v1alpha.PublicNetworkInterface)**

Public interface.

Includes only one of the fields `private_interface`, `public_interface`. ||
|| id | **string**

ID of the network interface. Should not be specified when creating a server.

The maximum string length in characters is 20. Value must match the regular expression ` ([a-z][a-z0-9]*)? `. ||
|| configuration_network_interface_id | **[google.protobuf.StringValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/string-value)**

ID of the configuration network interface that determines the network interface configuration.
The configuration network interface defines available modes (public/private) and other properties
for the network interface. This field is optional. If not specified, the configuration will be
chosen automatically on the server side based on availability. It is recommended to specify this
field for deterministic behavior. To get the configuration interface ID, use a
[ConfigurationService.ListConfigurationNetworkInterface](../Configuration/listConfigurationNetworkInterface.md#ListConfigurationNetworkInterface) request or examine the `network_interfaces`
field in [ConfigurationService.GetConfiguration] response. ||
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

## OsSettingsSpec {#yandex.cloud.baremetal.v1alpha.OsSettingsSpec}

#|
||Field | Description ||
|| ssh_public_key | **string**

Public SSH key for the server.

The maximum string length in characters is 20000.

Includes only one of the fields `ssh_public_key`, `user_ssh_id`.

Root user SSH key. ||
|| user_ssh_id | **string**

ID of the user SSH key to use for the server.
To get the user SSH key ID, use a [yandex.cloud.organizationmanager.v1.UserSshKeyService.List](../../../../organization/api-ref/grpc/UserSshKey/list.md#List) request.

The maximum string length in characters is 50.

Includes only one of the fields `ssh_public_key`, `user_ssh_id`.

Root user SSH key. ||
|| password_plain_text | **string**

Raw password.

The minimum string length in characters is 6.

Includes only one of the fields `password_plain_text`, `password_lockbox_secret`.

Password for the server. ||
|| password_lockbox_secret | **[LockboxSecret](#yandex.cloud.baremetal.v1alpha.LockboxSecret)**

Reference to the Lockbox secret used to obtain the password.

Includes only one of the fields `password_plain_text`, `password_lockbox_secret`.

Password for the server. ||
|| image_id | **string**

ID of the image that the server was created from.

The maximum string length in characters is 20. Value must match the regular expression ` [a-z][a-z0-9]* `. ||
|| storages[] | **[Storage](#yandex.cloud.baremetal.v1alpha.Storage)**

List of storages to be created on the server. If not specified, the default value based on the
selected configuration will be used as the field value. ||
|#

## LockboxSecret {#yandex.cloud.baremetal.v1alpha.LockboxSecret}

#|
||Field | Description ||
|| secret_id | **string**

Required field. The unique identifier for the lockbox secret that contains the user password. ||
|| version_id | **string**

The unique identifier for the lockbox version.
If omitted, the current version of the secret will be used. ||
|| key | **string**

Required field. The key used to access a specific secret entry. ||
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

## operation.Operation {#yandex.cloud.operation.Operation}

```json
{
  "id": "string",
  "description": "string",
  "created_at": "google.protobuf.Timestamp",
  "created_by": "string",
  "modified_at": "google.protobuf.Timestamp",
  "done": "bool",
  "metadata": "google.protobuf.Any",
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": "google.protobuf.Any"
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](../../../../api-design-guide/concepts/operation.md).

#|
||Field | Description ||
|| id | **string**

ID of the operation. ||
|| description | **string**

Description of the operation. 0-256 characters long. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| created_by | **string**

ID of the user or service account who initiated the operation. ||
|| modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**

The normal response of the operation in case of success.
If the original method returns no data on success, such as Delete,
the response is [google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty).
If the original method is the standard Create/Update,
the response should be the target resource of the operation.
Any method that returns a long-running operation should document the response type, if any.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|#