# BareMetal API, REST: Server.Create

Creates a server in the specified folder.

## HTTP request

```
POST https://baremetal.api.cloud.yandex.net/baremetal/v1alpha/servers
```

## Body parameters {#yandex.cloud.baremetal.v1alpha.CreateServerRequest}

```json
{
  "folderId": "string",
  "name": "string",
  "description": "string",
  "hardwarePoolId": "string",
  "configurationId": "string",
  "rentalPeriodId": "string",
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
      "configurationNetworkInterfaceId": "string"
    }
  ],
  "osSettingsSpec": {
    // Includes only one of the fields `sshPublicKey`, `userSshId`
    "sshPublicKey": "string",
    "userSshId": "string",
    // end of the list of possible fields
    // Includes only one of the fields `passwordPlainText`, `passwordLockboxSecret`
    "passwordPlainText": "string",
    "passwordLockboxSecret": {
      "secretId": "string",
      "versionId": "string",
      "key": "string"
    },
    // end of the list of possible fields
    "imageId": "string",
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
  "labels": "object"
}
```

#|
||Field | Description ||
|| folderId | **string**

ID of the folder to create server in.
To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](../../../resource-manager/api-ref/Folder/list.md#List) request.

The maximum string length in characters is 50. Value must match the regular expression ` [a-z][a-z0-9.-]* `. ||
|| name | **string**

Name of the server.
The name must be unique within the folder.

The string length in characters must be 2-56. Value must match the regular expression ` [a-z]([-a-z0-9]*[a-z0-9])? `. ||
|| description | **string**

Description of the server.

The maximum string length in characters is 1024. ||
|| hardwarePoolId | **string**

Required field. ID of the hardware pool that the server belongs to.
To get the hardware pool ID, use a [HardwarePoolService.List](../HardwarePool/list.md#List) request.

The maximum string length in characters is 20. ||
|| configurationId | **string**

ID of the configuration to use for the server.
To get the configuration ID, use a [ConfigurationService.List](../Configuration/list.md#List) request.

Value must match the regular expression ``` ([a-z][a-z0-9]{19})| ```. ||
|| rentalPeriodId | **string**

A period of time for which the server is rented.
To get the rental period ID, use a [RentalPeriodService.List](../RentalPeriod/list.md#List) request.

The maximum string length in characters is 20. ||
|| networkInterfaces[] | **[NetworkInterfaceSpec](#yandex.cloud.baremetal.v1alpha.NetworkInterfaceSpec)**

Network configuration for the server. Specifies how the network interface is configured
to interact with other servers on the internal network and on the internet.
Currently up to 2 network interfaces are supported: required private network interface and
optional public network interface.

The maximum number of elements is 2. ||
|| osSettingsSpec | **[OsSettingsSpec](#yandex.cloud.baremetal.v1alpha.OsSettingsSpec)**

Operating system specific settings for provisioning the server. Optional, if omitted, the
server will be created without an operating system. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs.

The maximum string length in characters for each value is 63. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `. Each value must match the regular expression ` [-_0-9a-z]* `. No more than 64 per resource. ||
|#

## NetworkInterfaceSpec {#yandex.cloud.baremetal.v1alpha.NetworkInterfaceSpec}


Required for backward compatibility with old clients. --)

#|
||Field | Description ||
|| privateSubnet | **[PrivateSubnetNetworkInterface](#yandex.cloud.baremetal.v1alpha.PrivateSubnetNetworkInterface)**

@deprecated Private subnet.

Includes only one of the fields `privateSubnet`, `publicSubnet`.

@deprecated. Use `interface` instead.
Subnet specific interface params. ||
|| publicSubnet | **[PublicSubnetNetworkInterface](#yandex.cloud.baremetal.v1alpha.PublicSubnetNetworkInterface)**

@deprecated Public subnet.

Includes only one of the fields `privateSubnet`, `publicSubnet`.

@deprecated. Use `interface` instead.
Subnet specific interface params. ||
|| privateInterface | **[PrivateNetworkInterface](#yandex.cloud.baremetal.v1alpha.PrivateNetworkInterface)**

Private interface.

Includes only one of the fields `privateInterface`, `publicInterface`. ||
|| publicInterface | **[PublicNetworkInterface](#yandex.cloud.baremetal.v1alpha.PublicNetworkInterface)**

Public interface.

Includes only one of the fields `privateInterface`, `publicInterface`. ||
|| id | **string**

ID of the network interface. Should not be specified when creating a server.

The maximum string length in characters is 20. Value must match the regular expression ` ([a-z][a-z0-9]*)? `. ||
|| configurationNetworkInterfaceId | **string**

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

## OsSettingsSpec {#yandex.cloud.baremetal.v1alpha.OsSettingsSpec}

#|
||Field | Description ||
|| sshPublicKey | **string**

Public SSH key for the server.

The maximum string length in characters is 20000.

Includes only one of the fields `sshPublicKey`, `userSshId`.

Root user SSH key. ||
|| userSshId | **string**

ID of the user SSH key to use for the server.
To get the user SSH key ID, use a [yandex.cloud.organizationmanager.v1.UserSshKeyService.List](../../../organization/api-ref/UserSshKey/list.md#List) request.

The maximum string length in characters is 50.

Includes only one of the fields `sshPublicKey`, `userSshId`.

Root user SSH key. ||
|| passwordPlainText | **string**

Raw password.

The minimum string length in characters is 6.

Includes only one of the fields `passwordPlainText`, `passwordLockboxSecret`.

Password for the server. ||
|| passwordLockboxSecret | **[LockboxSecret](#yandex.cloud.baremetal.v1alpha.LockboxSecret)**

Reference to the Lockbox secret used to obtain the password.

Includes only one of the fields `passwordPlainText`, `passwordLockboxSecret`.

Password for the server. ||
|| imageId | **string**

ID of the image that the server was created from.

The maximum string length in characters is 20. Value must match the regular expression ` [a-z][a-z0-9]* `. ||
|| storages[] | **[Storage](#yandex.cloud.baremetal.v1alpha.Storage)**

List of storages to be created on the server. If not specified, the default value based on the
selected configuration will be used as the field value. ||
|#

## LockboxSecret {#yandex.cloud.baremetal.v1alpha.LockboxSecret}

#|
||Field | Description ||
|| secretId | **string**

Required field. The unique identifier for the lockbox secret that contains the user password. ||
|| versionId | **string**

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

## Response {#yandex.cloud.operation.Operation}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": "boolean",
  "metadata": "object",
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": "object"
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](../../../api-design-guide/concepts/operation.md).

#|
||Field | Description ||
|| id | **string**

ID of the operation. ||
|| description | **string**

Description of the operation. 0-256 characters long. ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **string** (date-time)

The time when the Operation resource was last modified.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| done | **boolean**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **object**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[Status](#google.rpc.Status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **object**

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

## Status {#google.rpc.Status}

The error result of the operation in case of failure or cancellation.

#|
||Field | Description ||
|| code | **integer** (int32)

Error code. An enum value of [google.rpc.Code](https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto). ||
|| message | **string**

An error message. ||
|| details[] | **object**

A list of messages that carry the error details. ||
|#