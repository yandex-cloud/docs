---
editable: false
sourcePath: en/_api-ref-grpc/backup/v1/backup/api-ref/grpc/Backup/list.md
---

# Cloud Backup API, gRPC: BackupService.List {#List}

List backups using filters.

## gRPC request

**rpc List ([ListBackupsRequest](#yandex.cloud.backup.v1.ListBackupsRequest)) returns ([ListBackupsResponse](#yandex.cloud.backup.v1.ListBackupsResponse))**

## ListBackupsRequest {#yandex.cloud.backup.v1.ListBackupsRequest}

```json
{
  // Includes only one of the fields `computeInstanceId`, `archive`, `folderId`, `instancePolicy`, `resourceId`, `policyId`
  "computeInstanceId": "string",
  "archive": {
    "archiveId": "string",
    "folderId": "string"
  },
  "folderId": "string",
  "instancePolicy": {
    "computeInstanceId": "string",
    "policyId": "string"
  },
  "resourceId": "string",
  "policyId": "string",
  // end of the list of possible fields
  "orderBy": "string",
  "filter": "string",
  "type": "ResourceType"
}
```

#|
||Field | Description ||
|| computeInstanceId | **string**

List backups that belongs to specific Compute Cloud instance.

Includes only one of the fields `computeInstanceId`, `archive`, `folderId`, `instancePolicy`, `resourceId`, `policyId`. ||
|| archive | **[ArchiveParameters](#yandex.cloud.backup.v1.ListBackupsRequest.ArchiveParameters)**

List backups that belongs to specific archive of specific folder.

Includes only one of the fields `computeInstanceId`, `archive`, `folderId`, `instancePolicy`, `resourceId`, `policyId`. ||
|| folderId | **string**

List backups that belongs to specific folder.

Includes only one of the fields `computeInstanceId`, `archive`, `folderId`, `instancePolicy`, `resourceId`, `policyId`. ||
|| instancePolicy | **[InstancePolicy](#yandex.cloud.backup.v1.ListBackupsRequest.InstancePolicy)**

List backups that belongs to specific instance and policy at the same time.

Includes only one of the fields `computeInstanceId`, `archive`, `folderId`, `instancePolicy`, `resourceId`, `policyId`. ||
|| resourceId | **string**

List backups by specific resource ID.

Includes only one of the fields `computeInstanceId`, `archive`, `folderId`, `instancePolicy`, `resourceId`, `policyId`. ||
|| policyId | **string**

List backups by specific policy ID.

Includes only one of the fields `computeInstanceId`, `archive`, `folderId`, `instancePolicy`, `resourceId`, `policyId`. ||
|| orderBy | **string**

By which column the listing should be ordered and in which direction,
format is "createdAt desc". "createdAt desc" if omitted. ||
|| filter | **string**

Filter list by various parameters.
Supported parameters are:
* created_at

Supported logic operators:
* AND ||
|| type | enum **ResourceType**

Type of resource. Could be compute VM or baremetal server.

- `RESOURCE_TYPE_UNSPECIFIED`
- `COMPUTE`: Resource is Compute Cloud VM
- `BMS`: Resource is baremetal server ||
|#

## ArchiveParameters {#yandex.cloud.backup.v1.ListBackupsRequest.ArchiveParameters}

#|
||Field | Description ||
|| archiveId | **string**

Required field. Archive ID. ||
|| folderId | **string**

Required field. Folder ID. ||
|#

## InstancePolicy {#yandex.cloud.backup.v1.ListBackupsRequest.InstancePolicy}

#|
||Field | Description ||
|| computeInstanceId | **string**

Compute Cloud instance ID. ||
|| policyId | **string**

Policy ID. ||
|#

## ListBackupsResponse {#yandex.cloud.backup.v1.ListBackupsResponse}

```json
{
  "backups": [
    {
      "id": "string",
      "vaultId": "string",
      "archiveId": "string",
      "createdAt": "google.protobuf.Timestamp",
      "lastSeenAt": "google.protobuf.Timestamp",
      "size": "int64",
      "deduplicatedSize": "int64",
      "backedUpDataSize": "int64",
      "originalDataSize": "int64",
      "attributes": {
        "streamName": "string",
        "uri": "string"
      },
      "computeInstanceId": "string",
      "disks": [
        {
          "deviceModel": "string",
          "name": "string",
          "size": "int64",
          "volumes": [
            {
              "freeSpace": "int64",
              "isBootable": "bool",
              "isSystem": "bool",
              "name": "string",
              "size": "int64",
              "mountStrid": "string"
            }
          ]
        }
      ],
      "type": "Type",
      "deleted": "bool",
      "policyId": "string",
      "resourceId": "string"
    }
  ]
}
```

#|
||Field | Description ||
|| backups[] | **[Backup](#yandex.cloud.backup.v1.Backup)** ||
|#

## Backup {#yandex.cloud.backup.v1.Backup}

#|
||Field | Description ||
|| id | **string**

ID of the backup. ||
|| vaultId | **string**

ID of the backup vault. ||
|| archiveId | **string**

ID of the backup archive. ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|| lastSeenAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|| size | **int64**

Backup size. ||
|| deduplicatedSize | **int64**

Deduplicated backup size. ||
|| backedUpDataSize | **int64**

Backed up data size. ||
|| originalDataSize | **int64**

Original data size. ||
|| attributes | **[BackupAttributes](#yandex.cloud.backup.v1.Backup.BackupAttributes)** ||
|| computeInstanceId | **string**

Compute Cloud instance ID. ||
|| disks[] | **[Disk](#yandex.cloud.backup.v1.Disk)** ||
|| type | enum **Type**

- `TYPE_UNSPECIFIED`
- `FULL`
- `INCREMENTAL` ||
|| deleted | **bool**

If this field is true, it means that the backup was deleted. ||
|| policyId | **string**

[Policy](/docs/backup/concepts/policy) ID. ||
|| resourceId | **string**

Resource ID. It identifies Compute Cloud instance in backup service. ||
|#

## BackupAttributes {#yandex.cloud.backup.v1.Backup.BackupAttributes}

Backup attributes.

#|
||Field | Description ||
|| streamName | **string**

Backup stream name. ||
|| uri | **string**

URI of the backup archive. ||
|#

## Disk {#yandex.cloud.backup.v1.Disk}

#|
||Field | Description ||
|| deviceModel | **string**

Device model. ||
|| name | **string**

Disk name. ||
|| size | **int64**

Disk size. ||
|| volumes[] | **[Volume](#yandex.cloud.backup.v1.Volume)** ||
|#

## Volume {#yandex.cloud.backup.v1.Volume}

#|
||Field | Description ||
|| freeSpace | **int64**

Free space in the volume. ||
|| isBootable | **bool**

If this field is true, it means that the volume is bootable. ||
|| isSystem | **bool**

If this field is true, it means that the volume is a system volume. ||
|| name | **string**

Volume name. ||
|| size | **int64**

Volume size. ||
|| mountStrid | **string**

Mount string ID. ||
|#