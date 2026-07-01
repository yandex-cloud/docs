---
editable: false
---

# BareMetal API, gRPC: ServerService.List

Retrieves the list of Server resources in the specified folder.

## gRPC request

**rpc List ([ListServerRequest](#yandex.cloud.baremetal.v1alpha.ListServerRequest)) returns ([ListServerResponse](#yandex.cloud.baremetal.v1alpha.ListServerResponse))**

## ListServerRequest {#yandex.cloud.baremetal.v1alpha.ListServerRequest}

```json
{
  "folder_id": "string",
  "page_size": "int64",
  "page_token": "string",
  "order_by": "string",
  "filter": "string"
}
```

#|
||Field | Description ||
|| folder_id | **string**

ID of the folder to list servers in.
To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/Folder/list#List) request.

The maximum string length in characters is 50. Value must match the regular expression ` [a-z][a-z0-9.-]* `. ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is greater than `page_size`,
the service returns a [ListServerResponse.next_page_token](#yandex.cloud.baremetal.v1alpha.ListServerResponse)
that can be used to get the next page of results in subsequent list requests.
Default value is 20.

The maximum value is 1000. ||
|| page_token | **string**

Page token. To get the next page of results, set `page_token` to the
[ListServerResponse.next_page_token](#yandex.cloud.baremetal.v1alpha.ListServerResponse) returned by a previous list request. ||
|| order_by | **string**

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

## ListServerResponse {#yandex.cloud.baremetal.v1alpha.ListServerResponse}

```json
{
  "servers": [
    {
      // Includes only one of the fields `custom_configuration`, `stock_configuration_id`
      "custom_configuration": {
        "id": "string",
        "name": "string",
        "memory_gib": "int64",
        "cpu": {
          "name": "string",
          "vendor": "string",
          "cores": "int64",
          "physical_cores": "int64",
          "frequency_mhz": "int64",
          "threads": "int64"
        },
        "disk_drives": [
          {
            "type": "DiskDriveType",
            "disk_count": "int64",
            "disk_size_gib": "int64"
          }
        ],
        "network_capacity_gbps": "int64",
        "cpu_num": "int64",
        "network_interfaces": [
          {
            "id": "string",
            "name": "string",
            "configuration_id": "string",
            "link_speed_gbps": "int64",
            "available_modes": [
              "InterfaceMode"
            ],
            "mc_lag_options": {
              "interface_count": "int64"
            }
          }
        ],
        "mounting_availability": "MountingAvailability"
      },
      "stock_configuration_id": "string",
      // end of the list of possible fields
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
          "ip_address": "string",
          "configuration_network_interface_id": "string"
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
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| servers[] | **[Server](#yandex.cloud.baremetal.v1alpha.Server)**

List of Server resources. ||
|| next_page_token | **string**

Token for getting the next page of the list. If the number of results is greater than
[ListServerRequest.page_size](#yandex.cloud.baremetal.v1alpha.ListServerRequest), use `next_page_token` as the value
for the [ListServerRequest.page_token](#yandex.cloud.baremetal.v1alpha.ListServerRequest) parameter in the next list request.
Each subsequent page will have its own `next_page_token` to continue paging through the results. ||
|#

## Server {#yandex.cloud.baremetal.v1alpha.Server}

A Server resource.

#|
||Field | Description ||
|| custom_configuration | **[Configuration](#yandex.cloud.baremetal.v1alpha.Configuration)**

Custom configuration.

Includes only one of the fields `custom_configuration`, `stock_configuration_id`.

Configuration of the server. ||
|| stock_configuration_id | **string**

ID of the stock configuration.

Includes only one of the fields `custom_configuration`, `stock_configuration_id`.

Configuration of the server. ||
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

## Configuration {#yandex.cloud.baremetal.v1alpha.Configuration}

#|
||Field | Description ||
|| id | **string**

ID of the configuration. ||
|| name | **string**

Name of the configuration. ||
|| memory_gib | **int64**

Random-access memory (RAM) size in gibibytes (2^30 bytes). ||
|| cpu | **[CPU](#yandex.cloud.baremetal.v1alpha.CPU)**

CPU configuration. ||
|| disk_drives[] | **[DiskDriveConfiguration](#yandex.cloud.baremetal.v1alpha.DiskDriveConfiguration)**

Array of disk drive configurations. ||
|| network_capacity_gbps | **int64**

Network capacity or bandwidth in gigabits per second. ||
|| cpu_num | **int64**

Number of cpu. ||
|| network_interfaces[] | **[ConfigurationNetworkInterface](#yandex.cloud.baremetal.v1alpha.ConfigurationNetworkInterface)**

Network interfaces of the configuration. ||
|| mounting_availability | enum **MountingAvailability**

Indicates whether the mounting option is available or not for this configuration.

- `AVAILABLE`: Mounting is available.
- `UNAVAILABLE`: Mounting is unavailable. ||
|#

## CPU {#yandex.cloud.baremetal.v1alpha.CPU}

CPU configuration.

#|
||Field | Description ||
|| name | **string**

Name of the CPU. ||
|| vendor | **string**

Vendor of the CPU. ||
|| cores | **int64**

@deprecated. Number of cores. ||
|| physical_cores | **int64**

Number of physical cores per CPU (socket). ||
|| frequency_mhz | **int64**

Frequency of the CPU in megahertz (MHz).

Value must be greater than 0. ||
|| threads | **int64**

Number of threads (logical cores) per CPU (socket). ||
|#

## DiskDriveConfiguration {#yandex.cloud.baremetal.v1alpha.DiskDriveConfiguration}

#|
||Field | Description ||
|| type | enum **DiskDriveType**

Type of the disk drive.

- `HDD`: Hard disk drive (magnetic storage).
- `SSD`: Solid state drive with SATA/SAS interface.
- `NVME`: Solid state drive with NVMe interface. ||
|| disk_count | **int64**

Number of disk drives. ||
|| disk_size_gib | **int64**

Size of a single disk drive in gibibytes (2^30 bytes). ||
|#

## ConfigurationNetworkInterface {#yandex.cloud.baremetal.v1alpha.ConfigurationNetworkInterface}

#|
||Field | Description ||
|| id | **string**

Id of the network interface
Not used while creating interfaces ||
|| name | **string**

Name of the network interface ||
|| configuration_id | **string**

Id of the configuration ||
|| link_speed_gbps | **int64**

Link speed in gigabits per second ||
|| available_modes[] | enum **InterfaceMode**

Available modes for the network interface

- `PRIVATE`: Private network interface mode.
- `PUBLIC`: Public network interface mode. ||
|| mc_lag_options | **[MCLagAggregationOptions](#yandex.cloud.baremetal.v1alpha.ConfigurationNetworkInterface.MCLagAggregationOptions)**

MC-LAG configuration options for aggregated interfaces ||
|#

## MCLagAggregationOptions {#yandex.cloud.baremetal.v1alpha.ConfigurationNetworkInterface.MCLagAggregationOptions}

MC-LAG aggregation options for the network interface.

#|
||Field | Description ||
|| interface_count | **int64**

Number of interfaces in the MC-LAG aggregation. ||
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
|| configuration_network_interface_id | **string**

ID of the configuration network interface that determines the network interface configuration.
The configuration network interface defines available modes (public/private) and other properties
for the network interface.

The maximum string length in characters is 20. Value must match the regular expression ` ([a-z][a-z0-9]*)? `. ||
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