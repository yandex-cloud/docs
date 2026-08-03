[Документация Yandex Cloud](../../../../index.md) > [Yandex BareMetal](../../../index.md) > Концепции > Настройка и управление > Справочник API > API v2 > [gRPC (англ.)](../index.md) > [Server](index.md) > BatchCreateServers

# BareMetal API, gRPC: ServerService.BatchCreateServers

Creates multiple servers in the specified folder.

https://google.aip.dev/130 --)

## gRPC request

**rpc BatchCreateServers ([BatchCreateServersRequest](#yandex.cloud.baremetal.v2.BatchCreateServersRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## BatchCreateServersRequest {#yandex.cloud.baremetal.v2.BatchCreateServersRequest}

```json
{
  "cloud_id": "string",
  "folder_id": "string",
  "requests": [
    {
      "cloud_id": "string",
      "folder_id": "string",
      "server": {
        "server_id": "string",
        "cloud_id": "string",
        "folder_id": "string",
        "name": "string",
        "description": "string",
        "hardware_pool_id": "string",
        "state": "State",
        "os_settings": {
          "image_id": "string",
          "ssh_public_key": "string",
          // Includes only one of the fields `ssh_public_key_text`, `user_ssh_id`
          "ssh_public_key_text": "string",
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
          "storages": [
            {
              "partitions": [
                {
                  "type": "StoragePartitionType",
                  "size_bytes": "int64",
                  "mount_point": "string"
                }
              ],
              // Includes only one of the fields `disk`, `raid`
              "disk": {
                "id": "string",
                "type": "DiskDriveType",
                "size_bytes": "int64"
              },
              "raid": {
                "type": "RaidType",
                "disks": [
                  {
                    "id": "string",
                    "type": "DiskDriveType",
                    "size_bytes": "int64"
                  }
                ]
              }
              // end of the list of possible fields
            }
          ]
        },
        "rental_period_start_time": "google.protobuf.Timestamp",
        "rental_period_id": "string",
        "next_rental_period_id": "string",
        "rental_period_end_time": "google.protobuf.Timestamp",
        "network_interfaces": [
          {
            "network_interface_id": "string",
            "mac_address": "string",
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
              "ip_address": "string",
              "native_subnet_id": "string",
              "mac_limit": "int64",
              "internet_traffic_plan": "InternetTrafficPlan",
              // Includes only one of the fields `native_subnet`, `new_native_subnet`
              "native_subnet": {
                "subnet_id": "string"
              },
              "new_native_subnet": {
                "addressing_type": "AddressingType"
              }
              // end of the list of possible fields
            },
            // end of the list of possible fields
            "configuration_network_interface_id": "string"
          }
        ],
        "prolongation_state": "ProlongationState",
        "disks": [
          {
            "id": "string",
            "type": "DiskDriveType",
            "size_bytes": "int64"
          }
        ],
        // Includes only one of the fields `custom_configuration`, `stock_configuration_id`
        "custom_configuration": {
          "configuration_id": "string",
          "name": "string",
          "cpu": {
            "id": "string",
            "name": "string",
            "vendor": "string",
            "physical_cores": "int64",
            "frequency_mhz": "int64",
            "count": "int64",
            "threads": "int64"
          },
          "disk_drives": [
            {
              "type": "DiskDriveType",
              "count": "int64",
              "size_bytes": "int64"
            }
          ],
          "ram": {
            "id": "string",
            "size_bytes": "int64"
          }
        },
        "stock_configuration_id": "string",
        // end of the list of possible fields
        "create_time": "google.protobuf.Timestamp",
        "update_time": "google.protobuf.Timestamp",
        "annotations": "map<string, string>"
      }
    }
  ]
}
```

#|
||Field | Description ||
|| cloud_id | **string**

ID of the parent cloud.

To get the cloud ID, use a [yandex.cloud.resourcemanager.v1.CloudService.List](../../../../resource-manager/api-ref/grpc/Cloud/list.md#List) request. ||
|| folder_id | **string**

ID of the parent folder shared by all servers being created.

To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](../../../../resource-manager/api-ref/grpc/Folder/list.md#List) request.
If this is set, the folder_id field in the `BatchCreateServersRequest.requests` messages
must either be empty or match this field. ||
|| requests[] | **[CreateServerRequest](#yandex.cloud.baremetal.v2.CreateServerRequest)**

List of create server requests.

The number of elements must be in the range 1-100. ||
|#

## CreateServerRequest {#yandex.cloud.baremetal.v2.CreateServerRequest}

#|
||Field | Description ||
|| cloud_id | **string**

ID of the parent cloud.

To get the cloud ID, use a [yandex.cloud.resourcemanager.v1.CloudService.List](../../../../resource-manager/api-ref/grpc/Cloud/list.md#List) request. ||
|| folder_id | **string**

ID of the parent folder.

To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](../../../../resource-manager/api-ref/grpc/Folder/list.md#List) request. ||
|| server | **[Server](#yandex.cloud.baremetal.v2.Server)**

The server to create. ||
|#

## Server {#yandex.cloud.baremetal.v2.Server}

A Server resource.

#|
||Field | Description ||
|| server_id | **string**

ID of the server. ||
|| cloud_id | **string**

ID of the cloud that the server belongs to. ||
|| folder_id | **string**

ID of the folder that the server belongs to. ||
|| name | **string**

Name of the server.
The display name is unique within the folder. ||
|| description | **string**

Description of the server. ||
|| hardware_pool_id | **string**

ID of the hardware pool that the server belongs to.

The maximum string length in characters is 20. ||
|| state | enum **State**

State of the server.

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
- `RUNNING`: Server is running normally ||
|| os_settings | **[OsSettings](#yandex.cloud.baremetal.v2.OsSettings)**

Operating system specific settings of the server. Optional, will be empty if the server is
provisioned without an operating system. ||
|| rental_period_start_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp indicating the start date and time of the server's rental period. Optional, may be
unset initially and should be set when the rental actually starts. ||
|| rental_period_id | **string**

A period of time for which a Bare Metal Server is rented. ||
|| next_rental_period_id | **string**

A period of time for which a Bare Metal Server will be changed on after ending of current rental period.

The maximum string length in characters is 20. ||
|| rental_period_end_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp indicating the end date and time of the server's rental period. Optional, may be
unset initially and should be set when the rental actually starts. ||
|| network_interfaces[] | **[NetworkInterface](#yandex.cloud.baremetal.v2.NetworkInterface)**

Array of network interfaces that are attached to the instance.

The number of elements must be in the range 1-2. ||
|| prolongation_state | enum **ProlongationState**

Prolongation state of the server's rent.

- `AUTO_RENEW`: The rent will automatically be renewed at the end of the current period.
- `NON_RENEWAL`: The rent will not be renewed at the end of the current period. ||
|| disks[] | **[Disk](#yandex.cloud.baremetal.v2.Disk)**

Array of disks that are attached to the server. ||
|| custom_configuration | **[UserConfiguration](#yandex.cloud.baremetal.v2.UserConfiguration)**

Custom configuration.

Includes only one of the fields `custom_configuration`, `stock_configuration_id`.

Configuration of the server.

One of elements is required for server creation ||
|| stock_configuration_id | **string**

ID of the stock configuration.

Includes only one of the fields `custom_configuration`, `stock_configuration_id`.

Configuration of the server.

One of elements is required for server creation ||
|| create_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| update_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Update timestamp. ||
|| annotations | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs.

The maximum string length in characters for each value is 63. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `. Each value must match the regular expression ` [-_0-9a-z]* `. No more than 64 per resource. ||
|#

## OsSettings {#yandex.cloud.baremetal.v2.OsSettings}

#|
||Field | Description ||
|| image_id | **string**

ID of the image that the server was created from. ||
|| ssh_public_key | **string**

Public SSH key of the server. ||
|| ssh_public_key_text | **string**

Public SSH key for the server.

Input only field.

The maximum string length in characters is 20000.

Includes only one of the fields `ssh_public_key_text`, `user_ssh_id`.

Root user SSH key.

Input only field. One of elements is required. ||
|| user_ssh_id | **string**

ID of the user SSH key to use for the server.

Input only field. To get the user SSH key ID, use a [yandex.cloud.organizationmanager.v1.UserSshKeyService.List](../../../../organization/api-ref/grpc/UserSshKey/list.md#List) request.

The maximum string length in characters is 50.

Includes only one of the fields `ssh_public_key_text`, `user_ssh_id`.

Root user SSH key.

Input only field. One of elements is required. ||
|| password_plain_text | **string**

Raw password.

Input only field.

The minimum string length in characters is 6.

Includes only one of the fields `password_plain_text`, `password_lockbox_secret`.

Password for the server.

Input only field. One of elements is required. ||
|| password_lockbox_secret | **[LockboxSecret](#yandex.cloud.baremetal.v2.LockboxSecret)**

Reference to the Lockbox secret used to obtain the password.

Input only field.

Includes only one of the fields `password_plain_text`, `password_lockbox_secret`.

Password for the server.

Input only field. One of elements is required. ||
|| storages[] | **[Storage](#yandex.cloud.baremetal.v2.Storage)**

List of storages.

If not specified, the default value based on the selected configuration will be used as the field value. ||
|#

## LockboxSecret {#yandex.cloud.baremetal.v2.LockboxSecret}

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

## Storage {#yandex.cloud.baremetal.v2.Storage}

Storage, a OS-level storage entity used for creating partitions. For example, this could
represent a plain disk or a software RAID of disks.

#|
||Field | Description ||
|| partitions[] | **[StoragePartition](#yandex.cloud.baremetal.v2.StoragePartition)**

Array of partitions created on the storage. ||
|| disk | **[Disk](#yandex.cloud.baremetal.v2.Disk)**

Disk storage.

Includes only one of the fields `disk`, `raid`.

Storage type. ||
|| raid | **[Raid](#yandex.cloud.baremetal.v2.Raid)**

RAID storage.

Includes only one of the fields `disk`, `raid`.

Storage type. ||
|#

## StoragePartition {#yandex.cloud.baremetal.v2.StoragePartition}

#|
||Field | Description ||
|| type | enum **StoragePartitionType**

Partition type.

- `EXT4`: ext4 file system partition type.
- `SWAP`: Swap partition type.
- `EXT3`: ext3 file system partition type.
- `XFS`: XFS file system partition type. ||
|| size_bytes | **int64**

Size of the storage partition. ||
|| mount_point | **string**

Storage mount point. ||
|#

## Disk {#yandex.cloud.baremetal.v2.Disk}

Disk.

#|
||Field | Description ||
|| id | **string**

ID of the disk. ||
|| type | enum **DiskDriveType**

Type of the disk drive.

- `HDD`: Hard disk drive.
- `SSD`: Solid state drive.
- `NVME`: NVMe Solid state drive. ||
|| size_bytes | **int64**

Size of the disk. ||
|#

## Raid {#yandex.cloud.baremetal.v2.Raid}

RAID storage.

#|
||Field | Description ||
|| type | enum **RaidType**

RAID type.

- `RAID0`: RAID0 configuration.
- `RAID1`: RAID1 configuration.
- `RAID10`: RAID10 configuration. ||
|| disks[] | **[Disk](#yandex.cloud.baremetal.v2.Disk)**

Array of disks in the RAID configuration. ||
|#

## NetworkInterface {#yandex.cloud.baremetal.v2.NetworkInterface}

#|
||Field | Description ||
|| network_interface_id | **string**

ID of the network interface.

Should not be specified when creating a server. ||
|| mac_address | **string**

MAC address that is assigned to the network interface. ||
|| private_interface | **[PrivateNetworkInterface](#yandex.cloud.baremetal.v2.PrivateNetworkInterface)**

Private interface.

Includes only one of the fields `private_interface`, `public_interface`.

Type of the network interface.

One of elements is required. ||
|| public_interface | **[PublicNetworkInterface](#yandex.cloud.baremetal.v2.PublicNetworkInterface)**

Public interface.

Includes only one of the fields `private_interface`, `public_interface`.

Type of the network interface.

One of elements is required. ||
|| configuration_network_interface_id | **string**

ID of the configuration network interface that determines the network interface configuration.
The configuration network interface defines available modes (public/private) and other properties
for the network interface. This field is optional. If not specified, the configuration will be
chosen automatically on the server side based on availability. It is recommended to specify this
field for deterministic behavior. To get the configuration interface ID, use a
[ConfigurationService.ListConfigurationNetworkInterface] request or examine the `network_interfaces`
field in [ConfigurationService.GetConfiguration] response. ||
|#

## PrivateNetworkInterface {#yandex.cloud.baremetal.v2.PrivateNetworkInterface}

#|
||Field | Description ||
|| native_subnet_id | **string**

ID of the private subnet which is used as native subnet for interface. ||
|| ip_address | **string**

IPv4 address that is assigned to the server for this network interface. ||
|| mac_limit | **int64**

Limit of MAC addresses in the native subnet. ||
|| vlan_subinterfaces[] | **[VLANSubinterface](#yandex.cloud.baremetal.v2.VLANSubinterface)**

Array of VLAN subinterfaces. Additional tagged subnets for the interface. ||
|#

## VLANSubinterface {#yandex.cloud.baremetal.v2.VLANSubinterface}

#|
||Field | Description ||
|| tagged_subnet_id | **string**

ID of the private subnet which is used as tagged subnet for interface. ||
|| ip_address | **string**

IPv4 address that is assigned to the VLAN subinterface. ||
|| mac_limit | **int64**

Limit of MAC addresses in the tagged subnet. ||
|#

## PublicNetworkInterface {#yandex.cloud.baremetal.v2.PublicNetworkInterface}

#|
||Field | Description ||
|| ip_address | **string**

IPv4 address that is assigned to the server for this network interface. ||
|| native_subnet_id | **string**

ID of the public subnet which is used as native subnet for interface. ||
|| mac_limit | **int64**

Limit of MAC addresses in the native subnet. ||
|| internet_traffic_plan | enum **InternetTrafficPlan**

Internet traffic plan. Defines how much data can be transfered with server interface.

- `PLAN_10TB`: 10 terabyte of data per day.
- `PLAN_100TB`: 100 terabyte of data per day. ||
|| native_subnet | **[NativeSubnet](#yandex.cloud.baremetal.v2.PublicNetworkInterface.NativeSubnet)**

Use existing native subnet.

Includes only one of the fields `native_subnet`, `new_native_subnet`.

Native subnet configuration.

Input only field. One of elements is required. ||
|| new_native_subnet | **[NewNativeSubnet](#yandex.cloud.baremetal.v2.PublicNetworkInterface.NewNativeSubnet)**

Create new native subnet.

Includes only one of the fields `native_subnet`, `new_native_subnet`.

Native subnet configuration.

Input only field. One of elements is required. ||
|#

## NativeSubnet {#yandex.cloud.baremetal.v2.PublicNetworkInterface.NativeSubnet}

Configuration for using existing native subnet.

#|
||Field | Description ||
|| subnet_id | **string**

ID of the existing public subnet. ||
|#

## NewNativeSubnet {#yandex.cloud.baremetal.v2.PublicNetworkInterface.NewNativeSubnet}

Configuration for creating new native subnet.

#|
||Field | Description ||
|| addressing_type | enum **AddressingType**

Addressing type (DHCP \| Static).

- `DHCP`: DHCP addressing.
- `STATIC`: Static addressing. ||
|#

## UserConfiguration {#yandex.cloud.baremetal.v2.UserConfiguration}

#|
||Field | Description ||
|| configuration_id | **string**

ID of the configuration. ||
|| name | **string**

Name of the configuration. ||
|| cpu | **[UserCPU](#yandex.cloud.baremetal.v2.UserCPU)**

CPU configuration. ||
|| disk_drives[] | **[DiskDriveConfiguration](#yandex.cloud.baremetal.v2.DiskDriveConfiguration)**

Array of disk drive configurations. ||
|| ram | **[UserRAM](#yandex.cloud.baremetal.v2.UserRAM)**

Random-access memory (RAM). ||
|#

## UserCPU {#yandex.cloud.baremetal.v2.UserCPU}

CPU configuration.

#|
||Field | Description ||
|| id | **string**

ID of the CPU from configurator. ||
|| name | **string**

Name of the CPU. ||
|| vendor | **string**

Vendor of the CPU. ||
|| physical_cores | **int64**

Number of physical cores per CPU (socket). ||
|| frequency_mhz | **int64**

Frequency of the CPU in megahertz (MHz). ||
|| count | **int64**

Number of cpu. ||
|| threads | **int64**

Number of threads (logical cores) per CPU (socket). ||
|#

## DiskDriveConfiguration {#yandex.cloud.baremetal.v2.DiskDriveConfiguration}

#|
||Field | Description ||
|| type | enum **DiskDriveType**

Type of the disk drive.

- `HDD`: Hard disk drive.
- `SSD`: Solid state drive.
- `NVME`: NVMe Solid state drive. ||
|| count | **int64**

Number of disk drives. ||
|| size_bytes | **int64**

Size of a single disk drive. ||
|#

## UserRAM {#yandex.cloud.baremetal.v2.UserRAM}

#|
||Field | Description ||
|| id | **string**

ID of the RAM from configurator. ||
|| size_bytes | **int64**

Ram size. ||
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