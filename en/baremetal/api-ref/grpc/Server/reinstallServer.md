---
editable: false
---

# BareMetal API, gRPC: ServerService.ReinstallServer

Reinstalls the specified server.

https://google.aip.dev/130 --)

Required for backward compatibility with old clients. --)

## gRPC request

**rpc ReinstallServer ([ReinstallServerRequest](#yandex.cloud.baremetal.v2.ReinstallServerRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## ReinstallServerRequest {#yandex.cloud.baremetal.v2.ReinstallServerRequest}

```json
{
  "cloud_id": "string",
  "folder_id": "string",
  "server_id": "string",
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
  }
}
```

#|
||Field | Description ||
|| cloud_id | **string**

ID of the parent cloud.

To get the cloud ID, use a [yandex.cloud.resourcemanager.v1.CloudService.List](/docs/resource-manager/api-ref/grpc/Cloud/list#List) request. ||
|| folder_id | **string**

ID of the parent folder.

To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/Folder/list#List) request. ||
|| server_id | **string**

ID of the server to reinstall.

To get the server ID, use a [ServerService.List] request.

Value must match the regular expression ` [a-z][a-z0-9]* `. ||
|| os_settings | **[OsSettings](#yandex.cloud.baremetal.v2.OsSettings)**

Operating system specific settings for provisioning the server. ||
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

Input only field. To get the user SSH key ID, use a [yandex.cloud.organizationmanager.v1.UserSshKeyService.List](/docs/organization/api-ref/grpc/UserSshKey/list#List) request.

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

An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).

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