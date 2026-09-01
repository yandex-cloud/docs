---
editable: false
apiPlayground:
  - url: https://baremetal.{{ api-host }}/baremetal/v2/clouds/{server.cloud_id}/folders/{server.folder_id}/servers/{server.server_id}
    method: patch
    path: null
    query: null
    body:
      type: object
      properties:
        server:
          description: |-
            **[Server](#yandex.cloud.baremetal.v2.Server)**
            The server object to be updated
          $ref: '#/definitions/Server'
        updateMask:
          description: |-
            **string** (field-mask)
            A comma-separated names off ALL fields to be updated.
            Only the specified fields will be changed. The others will be left untouched.
            If the field is specified in `` updateMask `` and no value for that field was sent in the request,
            the field's value will be reset to the default. The default value for most fields is null or 0.
            If `` updateMask `` is not sent in the request, all fields' values will be updated.
            Fields specified in the request will be updated to provided values.
            The rest of the fields will be reset to the default.
          type: string
          format: field-mask
      additionalProperties: false
    definitions:
      LockboxSecret:
        type: object
        properties:
          secretId:
            description: |-
              **string**
              Required field. The unique identifier for the lockbox secret that contains the user password.
            type: string
          versionId:
            description: |-
              **string**
              The unique identifier for the lockbox version.
              If omitted, the current version of the secret will be used.
            type: string
          key:
            description: |-
              **string**
              Required field. The key used to access a specific secret entry.
            type: string
        required:
          - secretId
          - key
      StoragePartition:
        type: object
        properties:
          type:
            description: |-
              **enum** (StoragePartitionType)
              Partition type.
              - `EXT4`: ext4 file system partition type.
              - `SWAP`: Swap partition type.
              - `EXT3`: ext3 file system partition type.
              - `XFS`: XFS file system partition type.
            type: string
            enum:
              - STORAGE_PARTITION_TYPE_UNSPECIFIED
              - EXT4
              - SWAP
              - EXT3
              - XFS
          sizeBytes:
            description: |-
              **string** (int64)
              Size of the storage partition.
            type: string
            format: int64
          mountPoint:
            description: |-
              **string**
              Storage mount point.
            type: string
      Disk:
        type: object
        properties:
          id:
            description: |-
              **string**
              ID of the disk.
            type: string
          type:
            description: |-
              **enum** (DiskDriveType)
              Type of the disk drive.
              - `HDD`: Hard disk drive.
              - `SSD`: Solid state drive.
              - `NVME`: NVMe Solid state drive.
            type: string
            enum:
              - DISK_DRIVE_TYPE_UNSPECIFIED
              - HDD
              - SSD
              - NVME
          sizeBytes:
            description: |-
              **string** (int64)
              Size of the disk.
            type: string
            format: int64
      Raid:
        type: object
        properties:
          type:
            description: |-
              **enum** (RaidType)
              RAID type.
              - `RAID0`: RAID0 configuration.
              - `RAID1`: RAID1 configuration.
              - `RAID10`: RAID10 configuration.
            type: string
            enum:
              - RAID_TYPE_UNSPECIFIED
              - RAID0
              - RAID1
              - RAID10
          disks:
            description: |-
              **[Disk](#yandex.cloud.baremetal.v2.Disk)**
              Array of disks in the RAID configuration.
            type: array
            items:
              $ref: '#/definitions/Disk'
      Storage:
        type: object
        properties:
          partitions:
            description: |-
              **[StoragePartition](#yandex.cloud.baremetal.v2.StoragePartition)**
              Array of partitions created on the storage.
            type: array
            items:
              $ref: '#/definitions/StoragePartition'
          disk:
            description: |-
              **[Disk](#yandex.cloud.baremetal.v2.Disk)**
              Disk storage.
              Includes only one of the fields `disk`, `raid`.
              Storage type.
            $ref: '#/definitions/Disk'
          raid:
            description: |-
              **[Raid](#yandex.cloud.baremetal.v2.Raid)**
              RAID storage.
              Includes only one of the fields `disk`, `raid`.
              Storage type.
            $ref: '#/definitions/Raid'
        oneOf:
          - required:
              - disk
          - required:
              - raid
      OsSettings:
        type: object
        properties:
          imageId:
            description: |-
              **string**
              ID of the image that the server was created from.
            type: string
          sshPublicKey:
            description: |-
              **string**
              Public SSH key of the server.
            type: string
          sshPublicKeyText:
            description: |-
              **string**
              Public SSH key for the server.
              Input only field.
              The maximum string length in characters is 20000.
              Includes only one of the fields `sshPublicKeyText`, `userSshId`.
              Root user SSH key.
              Input only field. One of elements is required.
            type: string
          userSshId:
            description: |-
              **string**
              ID of the user SSH key to use for the server.
              Input only field. To get the user SSH key ID, use a [yandex.cloud.organizationmanager.v1.UserSshKeyService.List](/docs/organization/api-ref/UserSshKey/list#List) request.
              The maximum string length in characters is 50.
              Includes only one of the fields `sshPublicKeyText`, `userSshId`.
              Root user SSH key.
              Input only field. One of elements is required.
            type: string
          passwordPlainText:
            description: |-
              **string**
              Raw password.
              Input only field.
              The minimum string length in characters is 6.
              Includes only one of the fields `passwordPlainText`, `passwordLockboxSecret`.
              Password for the server.
              Input only field. One of elements is required.
            type: string
          passwordLockboxSecret:
            description: |-
              **[LockboxSecret](#yandex.cloud.baremetal.v2.LockboxSecret)**
              Reference to the Lockbox secret used to obtain the password.
              Input only field.
              Includes only one of the fields `passwordPlainText`, `passwordLockboxSecret`.
              Password for the server.
              Input only field. One of elements is required.
            $ref: '#/definitions/LockboxSecret'
          storages:
            description: |-
              **[Storage](#yandex.cloud.baremetal.v2.Storage)**
              List of storages.
              If not specified, the default value based on the selected configuration will be used as the field value.
            type: array
            items:
              $ref: '#/definitions/Storage'
        allOf:
          - oneOf:
              - required:
                  - sshPublicKeyText
              - required:
                  - userSshId
          - oneOf:
              - required:
                  - passwordPlainText
              - required:
                  - passwordLockboxSecret
      VLANSubinterface:
        type: object
        properties:
          taggedSubnetId:
            description: |-
              **string**
              ID of the private subnet which is used as tagged subnet for interface.
            type: string
          ipAddress:
            description: |-
              **string**
              IPv4 address that is assigned to the VLAN subinterface.
            type: string
          macLimit:
            description: |-
              **string** (int64)
              Limit of MAC addresses in the tagged subnet.
            type: string
            format: int64
      PrivateNetworkInterface:
        type: object
        properties:
          nativeSubnetId:
            description: |-
              **string**
              ID of the private subnet which is used as native subnet for interface.
            type: string
          ipAddress:
            description: |-
              **string**
              IPv4 address that is assigned to the server for this network interface.
            type: string
          macLimit:
            description: |-
              **string** (int64)
              Limit of MAC addresses in the native subnet.
            type: string
            format: int64
          vlanSubinterfaces:
            description: |-
              **[VLANSubinterface](#yandex.cloud.baremetal.v2.VLANSubinterface)**
              Array of VLAN subinterfaces. Additional tagged subnets for the interface.
            type: array
            items:
              $ref: '#/definitions/VLANSubinterface'
      NativeSubnet:
        type: object
        properties:
          subnetId:
            description: |-
              **string**
              ID of the existing public subnet.
            type: string
      NewNativeSubnet:
        type: object
        properties:
          addressingType:
            description: |-
              **enum** (AddressingType)
              Addressing type (DHCP | Static).
              - `DHCP`: DHCP addressing.
              - `STATIC`: Static addressing.
            type: string
            enum:
              - ADDRESSING_TYPE_UNSPECIFIED
              - DHCP
              - STATIC
      PublicNetworkInterface:
        type: object
        properties:
          ipAddress:
            description: |-
              **string**
              IPv4 address that is assigned to the server for this network interface.
            type: string
          nativeSubnetId:
            description: |-
              **string**
              ID of the public subnet which is used as native subnet for interface.
            type: string
          macLimit:
            description: |-
              **string** (int64)
              Limit of MAC addresses in the native subnet.
            type: string
            format: int64
          internetTrafficPlan:
            description: |-
              **enum** (InternetTrafficPlan)
              Internet traffic plan. Defines how much data can be transfered with server interface.
              - `PLAN_10TB`: 10 terabyte of data per day.
              - `PLAN_100TB`: 100 terabyte of data per day.
            type: string
            enum:
              - INTERNET_TRAFFIC_PLAN_UNSPECIFIED
              - PLAN_10TB
              - PLAN_100TB
          nativeSubnet:
            description: |-
              **[NativeSubnet](#yandex.cloud.baremetal.v2.PublicNetworkInterface.NativeSubnet)**
              Use existing native subnet.
              Includes only one of the fields `nativeSubnet`, `newNativeSubnet`.
              Native subnet configuration.
              Input only field. One of elements is required.
            $ref: '#/definitions/NativeSubnet'
          newNativeSubnet:
            description: |-
              **[NewNativeSubnet](#yandex.cloud.baremetal.v2.PublicNetworkInterface.NewNativeSubnet)**
              Create new native subnet.
              Includes only one of the fields `nativeSubnet`, `newNativeSubnet`.
              Native subnet configuration.
              Input only field. One of elements is required.
            $ref: '#/definitions/NewNativeSubnet'
        oneOf:
          - required:
              - nativeSubnet
          - required:
              - newNativeSubnet
      NetworkInterface:
        type: object
        properties:
          networkInterfaceId:
            description: |-
              **string**
              ID of the network interface.
              Should not be specified when creating a server.
            type: string
          macAddress:
            description: |-
              **string**
              MAC address that is assigned to the network interface.
            type: string
          privateInterface:
            description: |-
              **[PrivateNetworkInterface](#yandex.cloud.baremetal.v2.PrivateNetworkInterface)**
              Private interface.
              Includes only one of the fields `privateInterface`, `publicInterface`.
              Type of the network interface.
              One of elements is required.
            $ref: '#/definitions/PrivateNetworkInterface'
          publicInterface:
            description: |-
              **[PublicNetworkInterface](#yandex.cloud.baremetal.v2.PublicNetworkInterface)**
              Public interface.
              Includes only one of the fields `privateInterface`, `publicInterface`.
              Type of the network interface.
              One of elements is required.
            $ref: '#/definitions/PublicNetworkInterface'
          configurationNetworkInterfaceId:
            description: |-
              **string**
              ID of the configuration network interface that determines the network interface configuration.
              The configuration network interface defines available modes (public/private) and other properties
              for the network interface. This field is optional. If not specified, the configuration will be
              chosen automatically on the server side based on availability. It is recommended to specify this
              field for deterministic behavior. To get the configuration interface ID, use a
              [ConfigurationService.ListConfigurationNetworkInterface] request or examine the `network_interfaces`
              field in [ConfigurationService.GetConfiguration] response.
            type: string
        oneOf:
          - required:
              - privateInterface
          - required:
              - publicInterface
      UserCPU:
        type: object
        properties:
          id:
            description: |-
              **string**
              ID of the CPU from configurator.
            type: string
          name:
            description: |-
              **string**
              Name of the CPU.
            type: string
          vendor:
            description: |-
              **string**
              Vendor of the CPU.
            type: string
          physicalCores:
            description: |-
              **string** (int64)
              Number of physical cores per CPU (socket).
            type: string
            format: int64
          frequencyMhz:
            description: |-
              **string** (int64)
              Frequency of the CPU in megahertz (MHz).
            type: string
            format: int64
          count:
            description: |-
              **string** (int64)
              Number of cpu.
            type: string
            format: int64
          threads:
            description: |-
              **string** (int64)
              Number of threads (logical cores) per CPU (socket).
            type: string
            format: int64
      DiskDriveConfiguration:
        type: object
        properties:
          type:
            description: |-
              **enum** (DiskDriveType)
              Type of the disk drive.
              - `HDD`: Hard disk drive.
              - `SSD`: Solid state drive.
              - `NVME`: NVMe Solid state drive.
            type: string
            enum:
              - DISK_DRIVE_TYPE_UNSPECIFIED
              - HDD
              - SSD
              - NVME
          count:
            description: |-
              **string** (int64)
              Number of disk drives.
            type: string
            format: int64
          sizeBytes:
            description: |-
              **string** (int64)
              Size of a single disk drive.
            type: string
            format: int64
      UserRAM:
        type: object
        properties:
          id:
            description: |-
              **string**
              ID of the RAM from configurator.
            type: string
          sizeBytes:
            description: |-
              **string** (int64)
              Ram size.
            type: string
            format: int64
      UserConfiguration:
        type: object
        properties:
          configurationId:
            description: |-
              **string**
              ID of the configuration.
            type: string
          name:
            description: |-
              **string**
              Name of the configuration.
            type: string
          cpu:
            description: |-
              **[UserCPU](#yandex.cloud.baremetal.v2.UserCPU)**
              CPU configuration.
            $ref: '#/definitions/UserCPU'
          diskDrives:
            description: |-
              **[DiskDriveConfiguration](#yandex.cloud.baremetal.v2.DiskDriveConfiguration)**
              Array of disk drive configurations.
            type: array
            items:
              $ref: '#/definitions/DiskDriveConfiguration'
          ram:
            description: |-
              **[UserRAM](#yandex.cloud.baremetal.v2.UserRAM)**
              Random-access memory (RAM).
            $ref: '#/definitions/UserRAM'
      Server:
        type: object
        properties:
          serverId:
            description: |-
              **string**
              ID of the server.
            type: string
          cloudId:
            description: |-
              **string**
              ID of the cloud that the server belongs to.
            type: string
          folderId:
            description: |-
              **string**
              ID of the folder that the server belongs to.
            type: string
          name:
            description: |-
              **string**
              Name of the server.
              The display name is unique within the folder.
            type: string
          description:
            description: |-
              **string**
              Description of the server.
            type: string
          hardwarePoolId:
            description: |-
              **string**
              ID of the hardware pool that the server belongs to.
              The maximum string length in characters is 20.
            type: string
          state:
            description: |-
              **enum** (State)
              State of the server.
              - `CREATING`: Image is being created.
              - `READY`: Image is ready to use.
              - `ERROR`: Image encountered an error.
              - `DELETING`: Image is being deleted.
              - `UPDATING`: Image is being updated.
            type: string
            enum:
              - STATE_UNSPECIFIED
              - CREATING
              - READY
              - ERROR
              - DELETING
              - UPDATING
          osSettings:
            description: |-
              **[OsSettings](#yandex.cloud.baremetal.v2.OsSettings)**
              Operating system specific settings of the server. Optional, will be empty if the server is
              provisioned without an operating system.
            $ref: '#/definitions/OsSettings'
          rentalPeriodStartTime:
            description: |-
              **string** (date-time)
              Timestamp indicating the start date and time of the server's rental period. Optional, may be
              unset initially and should be set when the rental actually starts.
              String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
              `0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.
              To work with values in this field, use the APIs described in the
              [Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
              In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).
            type: string
            format: date-time
          rentalPeriodId:
            description: |-
              **string**
              A period of time for which a Bare Metal Server is rented.
            type: string
          nextRentalPeriodId:
            description: |-
              **string**
              A period of time for which a Bare Metal Server will be changed on after ending of current rental period.
              The maximum string length in characters is 20.
            type: string
          rentalPeriodEndTime:
            description: |-
              **string** (date-time)
              Timestamp indicating the end date and time of the server's rental period. Optional, may be
              unset initially and should be set when the rental actually starts.
              String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
              `0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.
              To work with values in this field, use the APIs described in the
              [Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
              In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).
            type: string
            format: date-time
          networkInterfaces:
            description: |-
              **[NetworkInterface](#yandex.cloud.baremetal.v2.NetworkInterface)**
              Array of network interfaces that are attached to the instance.
              The number of elements must be in the range 1-2.
            type: array
            items:
              $ref: '#/definitions/NetworkInterface'
          prolongationState:
            description: |-
              **enum** (ProlongationState)
              Prolongation state of the server's rent.
              - `AUTO_RENEW`: The rent will automatically be renewed at the end of the current period.
              - `NON_RENEWAL`: The rent will not be renewed at the end of the current period.
            type: string
            enum:
              - PROLONGATION_STATE_UNSPECIFIED
              - AUTO_RENEW
              - NON_RENEWAL
          disks:
            description: |-
              **[Disk](#yandex.cloud.baremetal.v2.Disk)**
              Array of disks that are attached to the server.
            type: array
            items:
              $ref: '#/definitions/Disk'
          customConfiguration:
            description: |-
              **[UserConfiguration](#yandex.cloud.baremetal.v2.UserConfiguration)**
              Custom configuration.
              Includes only one of the fields `customConfiguration`, `stockConfigurationId`.
              Configuration of the server.
              One of elements is required for server creation
            $ref: '#/definitions/UserConfiguration'
          stockConfigurationId:
            description: |-
              **string**
              ID of the stock configuration.
              Includes only one of the fields `customConfiguration`, `stockConfigurationId`.
              Configuration of the server.
              One of elements is required for server creation
            type: string
          createTime:
            description: |-
              **string** (date-time)
              Creation timestamp.
              String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
              `0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.
              To work with values in this field, use the APIs described in the
              [Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
              In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).
            type: string
            format: date-time
          updateTime:
            description: |-
              **string** (date-time)
              Update timestamp.
              String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
              `0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.
              To work with values in this field, use the APIs described in the
              [Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
              In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).
            type: string
            format: date-time
          annotations:
            description: |-
              **object** (map<**string**, **string**>)
              Resource labels as `key:value` pairs.
              The maximum string length in characters for each value is 63. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `. Each value must match the regular expression ` [-_0-9a-z]* `. No more than 64 per resource.
            type: object
            additionalProperties:
              type: string
              pattern: '[-_0-9a-z]*'
              maxLength: 63
            propertyNames:
              type: string
              pattern: '[a-z][-_0-9a-z]*'
              maxLength: 63
              minLength: 1
            maxProperties: 64
        oneOf:
          - required:
              - customConfiguration
          - required:
              - stockConfigurationId
---

# BareMetal API, REST: Server.UpdateServer

Updates the specified server.


## HTTP request

```
PATCH https://baremetal.{{ api-host }}/baremetal/v2/clouds/{server.cloud_id}/folders/{server.folder_id}/servers/{server.server_id}
```

## Body parameters {#yandex.cloud.baremetal.v2.UpdateServerRequest}

```json
{
  "server": {
    "serverId": "string",
    "cloudId": "string",
    "folderId": "string",
    "name": "string",
    "description": "string",
    "hardwarePoolId": "string",
    "state": "string",
    "osSettings": {
      "imageId": "string",
      "sshPublicKey": "string",
      // Includes only one of the fields `sshPublicKeyText`, `userSshId`
      "sshPublicKeyText": "string",
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
      "storages": [
        {
          "partitions": [
            {
              "type": "string",
              "sizeBytes": "string",
              "mountPoint": "string"
            }
          ],
          // Includes only one of the fields `disk`, `raid`
          "disk": {
            "id": "string",
            "type": "string",
            "sizeBytes": "string"
          },
          "raid": {
            "type": "string",
            "disks": [
              {
                "id": "string",
                "type": "string",
                "sizeBytes": "string"
              }
            ]
          }
          // end of the list of possible fields
        }
      ]
    },
    "rentalPeriodStartTime": "string",
    "rentalPeriodId": "string",
    "nextRentalPeriodId": "string",
    "rentalPeriodEndTime": "string",
    "networkInterfaces": [
      {
        "networkInterfaceId": "string",
        "macAddress": "string",
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
          "ipAddress": "string",
          "nativeSubnetId": "string",
          "macLimit": "string",
          "internetTrafficPlan": "string",
          // Includes only one of the fields `nativeSubnet`, `newNativeSubnet`
          "nativeSubnet": {
            "subnetId": "string"
          },
          "newNativeSubnet": {
            "addressingType": "string"
          }
          // end of the list of possible fields
        },
        // end of the list of possible fields
        "configurationNetworkInterfaceId": "string"
      }
    ],
    "prolongationState": "string",
    "disks": [
      {
        "id": "string",
        "type": "string",
        "sizeBytes": "string"
      }
    ],
    // Includes only one of the fields `customConfiguration`, `stockConfigurationId`
    "customConfiguration": {
      "configurationId": "string",
      "name": "string",
      "cpu": {
        "id": "string",
        "name": "string",
        "vendor": "string",
        "physicalCores": "string",
        "frequencyMhz": "string",
        "count": "string",
        "threads": "string"
      },
      "diskDrives": [
        {
          "type": "string",
          "count": "string",
          "sizeBytes": "string"
        }
      ],
      "ram": {
        "id": "string",
        "sizeBytes": "string"
      }
    },
    "stockConfigurationId": "string",
    // end of the list of possible fields
    "createTime": "string",
    "updateTime": "string",
    "annotations": "object"
  },
  "updateMask": "string"
}
```

#|
||Field | Description ||
|| server | **[Server](#yandex.cloud.baremetal.v2.Server)**

The server object to be updated ||
|| updateMask | **string** (field-mask)

A comma-separated names off ALL fields to be updated.
Only the specified fields will be changed. The others will be left untouched.
If the field is specified in `` updateMask `` and no value for that field was sent in the request,
the field's value will be reset to the default. The default value for most fields is null or 0.

If `` updateMask `` is not sent in the request, all fields' values will be updated.
Fields specified in the request will be updated to provided values.
The rest of the fields will be reset to the default. ||
|#

## Server {#yandex.cloud.baremetal.v2.Server}

A Server resource.

#|
||Field | Description ||
|| serverId | **string**

ID of the server. ||
|| cloudId | **string**

ID of the cloud that the server belongs to. ||
|| folderId | **string**

ID of the folder that the server belongs to. ||
|| name | **string**

Name of the server.
The display name is unique within the folder. ||
|| description | **string**

Description of the server. ||
|| hardwarePoolId | **string**

ID of the hardware pool that the server belongs to.

The maximum string length in characters is 20. ||
|| state | **enum** (State)

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
- `RUNNING`: Server is running normally
- `ASSEMBLING`: Server is being assembled.
- `MAINTENANCE`: Server is under maintenance. ||
|| osSettings | **[OsSettings](#yandex.cloud.baremetal.v2.OsSettings)**

Operating system specific settings of the server. Optional, will be empty if the server is
provisioned without an operating system. ||
|| rentalPeriodStartTime | **string** (date-time)

Timestamp indicating the start date and time of the server's rental period. Optional, may be
unset initially and should be set when the rental actually starts.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| rentalPeriodId | **string**

A period of time for which a Bare Metal Server is rented. ||
|| nextRentalPeriodId | **string**

A period of time for which a Bare Metal Server will be changed on after ending of current rental period.

The maximum string length in characters is 20. ||
|| rentalPeriodEndTime | **string** (date-time)

Timestamp indicating the end date and time of the server's rental period. Optional, may be
unset initially and should be set when the rental actually starts.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| networkInterfaces[] | **[NetworkInterface](#yandex.cloud.baremetal.v2.NetworkInterface)**

Array of network interfaces that are attached to the instance.

The number of elements must be in the range 1-2. ||
|| prolongationState | **enum** (ProlongationState)

Prolongation state of the server's rent.

- `AUTO_RENEW`: The rent will automatically be renewed at the end of the current period.
- `NON_RENEWAL`: The rent will not be renewed at the end of the current period. ||
|| disks[] | **[Disk](#yandex.cloud.baremetal.v2.Disk)**

Array of disks that are attached to the server. ||
|| customConfiguration | **[UserConfiguration](#yandex.cloud.baremetal.v2.UserConfiguration)**

Custom configuration.

Includes only one of the fields `customConfiguration`, `stockConfigurationId`.

Configuration of the server.

One of elements is required for server creation ||
|| stockConfigurationId | **string**

ID of the stock configuration.

Includes only one of the fields `customConfiguration`, `stockConfigurationId`.

Configuration of the server.

One of elements is required for server creation ||
|| createTime | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| updateTime | **string** (date-time)

Update timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| annotations | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs.

The maximum string length in characters for each value is 63. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `. Each value must match the regular expression ` [-_0-9a-z]* `. No more than 64 per resource. ||
|#

## OsSettings {#yandex.cloud.baremetal.v2.OsSettings}

#|
||Field | Description ||
|| imageId | **string**

ID of the image that the server was created from. ||
|| sshPublicKey | **string**

Public SSH key of the server. ||
|| sshPublicKeyText | **string**

Public SSH key for the server.

Input only field.

The maximum string length in characters is 20000.

Includes only one of the fields `sshPublicKeyText`, `userSshId`.

Root user SSH key.

Input only field. One of elements is required. ||
|| userSshId | **string**

ID of the user SSH key to use for the server.

Input only field. To get the user SSH key ID, use a [yandex.cloud.organizationmanager.v1.UserSshKeyService.List](/docs/organization/api-ref/UserSshKey/list#List) request.

The maximum string length in characters is 50.

Includes only one of the fields `sshPublicKeyText`, `userSshId`.

Root user SSH key.

Input only field. One of elements is required. ||
|| passwordPlainText | **string**

Raw password.

Input only field.

The minimum string length in characters is 6.

Includes only one of the fields `passwordPlainText`, `passwordLockboxSecret`.

Password for the server.

Input only field. One of elements is required. ||
|| passwordLockboxSecret | **[LockboxSecret](#yandex.cloud.baremetal.v2.LockboxSecret)**

Reference to the Lockbox secret used to obtain the password.

Input only field.

Includes only one of the fields `passwordPlainText`, `passwordLockboxSecret`.

Password for the server.

Input only field. One of elements is required. ||
|| storages[] | **[Storage](#yandex.cloud.baremetal.v2.Storage)**

List of storages.

If not specified, the default value based on the selected configuration will be used as the field value. ||
|#

## LockboxSecret {#yandex.cloud.baremetal.v2.LockboxSecret}

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
|| type | **enum** (StoragePartitionType)

Partition type.

- `EXT4`: ext4 file system partition type.
- `SWAP`: Swap partition type.
- `EXT3`: ext3 file system partition type.
- `XFS`: XFS file system partition type. ||
|| sizeBytes | **string** (int64)

Size of the storage partition. ||
|| mountPoint | **string**

Storage mount point. ||
|#

## Disk {#yandex.cloud.baremetal.v2.Disk}

Disk.

#|
||Field | Description ||
|| id | **string**

ID of the disk. ||
|| type | **enum** (DiskDriveType)

Type of the disk drive.

- `HDD`: Hard disk drive.
- `SSD`: Solid state drive.
- `NVME`: NVMe Solid state drive. ||
|| sizeBytes | **string** (int64)

Size of the disk. ||
|#

## Raid {#yandex.cloud.baremetal.v2.Raid}

RAID storage.

#|
||Field | Description ||
|| type | **enum** (RaidType)

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
|| networkInterfaceId | **string**

ID of the network interface.

Should not be specified when creating a server. ||
|| macAddress | **string**

MAC address that is assigned to the network interface. ||
|| privateInterface | **[PrivateNetworkInterface](#yandex.cloud.baremetal.v2.PrivateNetworkInterface)**

Private interface.

Includes only one of the fields `privateInterface`, `publicInterface`.

Type of the network interface.

One of elements is required. ||
|| publicInterface | **[PublicNetworkInterface](#yandex.cloud.baremetal.v2.PublicNetworkInterface)**

Public interface.

Includes only one of the fields `privateInterface`, `publicInterface`.

Type of the network interface.

One of elements is required. ||
|| configurationNetworkInterfaceId | **string**

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
|| nativeSubnetId | **string**

ID of the private subnet which is used as native subnet for interface. ||
|| ipAddress | **string**

IPv4 address that is assigned to the server for this network interface. ||
|| macLimit | **string** (int64)

Limit of MAC addresses in the native subnet. ||
|| vlanSubinterfaces[] | **[VLANSubinterface](#yandex.cloud.baremetal.v2.VLANSubinterface)**

Array of VLAN subinterfaces. Additional tagged subnets for the interface. ||
|#

## VLANSubinterface {#yandex.cloud.baremetal.v2.VLANSubinterface}

#|
||Field | Description ||
|| taggedSubnetId | **string**

ID of the private subnet which is used as tagged subnet for interface. ||
|| ipAddress | **string**

IPv4 address that is assigned to the VLAN subinterface. ||
|| macLimit | **string** (int64)

Limit of MAC addresses in the tagged subnet. ||
|#

## PublicNetworkInterface {#yandex.cloud.baremetal.v2.PublicNetworkInterface}

#|
||Field | Description ||
|| ipAddress | **string**

IPv4 address that is assigned to the server for this network interface. ||
|| nativeSubnetId | **string**

ID of the public subnet which is used as native subnet for interface. ||
|| macLimit | **string** (int64)

Limit of MAC addresses in the native subnet. ||
|| internetTrafficPlan | **enum** (InternetTrafficPlan)

Internet traffic plan. Defines how much data can be transfered with server interface.

- `PLAN_10TB`: 10 terabyte of data per day.
- `PLAN_100TB`: 100 terabyte of data per day. ||
|| nativeSubnet | **[NativeSubnet](#yandex.cloud.baremetal.v2.PublicNetworkInterface.NativeSubnet)**

Use existing native subnet.

Includes only one of the fields `nativeSubnet`, `newNativeSubnet`.

Native subnet configuration.

Input only field. One of elements is required. ||
|| newNativeSubnet | **[NewNativeSubnet](#yandex.cloud.baremetal.v2.PublicNetworkInterface.NewNativeSubnet)**

Create new native subnet.

Includes only one of the fields `nativeSubnet`, `newNativeSubnet`.

Native subnet configuration.

Input only field. One of elements is required. ||
|#

## NativeSubnet {#yandex.cloud.baremetal.v2.PublicNetworkInterface.NativeSubnet}

Configuration for using existing native subnet.

#|
||Field | Description ||
|| subnetId | **string**

ID of the existing public subnet. ||
|#

## NewNativeSubnet {#yandex.cloud.baremetal.v2.PublicNetworkInterface.NewNativeSubnet}

Configuration for creating new native subnet.

#|
||Field | Description ||
|| addressingType | **enum** (AddressingType)

Addressing type (DHCP \| Static).

- `DHCP`: DHCP addressing.
- `STATIC`: Static addressing. ||
|#

## UserConfiguration {#yandex.cloud.baremetal.v2.UserConfiguration}

#|
||Field | Description ||
|| configurationId | **string**

ID of the configuration. ||
|| name | **string**

Name of the configuration. ||
|| cpu | **[UserCPU](#yandex.cloud.baremetal.v2.UserCPU)**

CPU configuration. ||
|| diskDrives[] | **[DiskDriveConfiguration](#yandex.cloud.baremetal.v2.DiskDriveConfiguration)**

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
|| physicalCores | **string** (int64)

Number of physical cores per CPU (socket). ||
|| frequencyMhz | **string** (int64)

Frequency of the CPU in megahertz (MHz). ||
|| count | **string** (int64)

Number of cpu. ||
|| threads | **string** (int64)

Number of threads (logical cores) per CPU (socket). ||
|#

## DiskDriveConfiguration {#yandex.cloud.baremetal.v2.DiskDriveConfiguration}

#|
||Field | Description ||
|| type | **enum** (DiskDriveType)

Type of the disk drive.

- `HDD`: Hard disk drive.
- `SSD`: Solid state drive.
- `NVME`: NVMe Solid state drive. ||
|| count | **string** (int64)

Number of disk drives. ||
|| sizeBytes | **string** (int64)

Size of a single disk drive. ||
|#

## UserRAM {#yandex.cloud.baremetal.v2.UserRAM}

#|
||Field | Description ||
|| id | **string**

ID of the RAM from configurator. ||
|| sizeBytes | **string** (int64)

Ram size. ||
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

An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).

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