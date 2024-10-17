---
editable: false
sourcePath: en/_api-ref-grpc/backup/v1/backup/api-ref/grpc/Backup/listArchives.md
---

# Cloud Backup API, gRPC: BackupService.ListArchives {#ListArchives}

List archives that holds backups for specified folder or
specified [Compute Cloud instance](/docs/backup/concepts/vm-connection#os).

## gRPC request

**rpc ListArchives ([ListArchivesRequest](#yandex.cloud.backup.v1.ListArchivesRequest)) returns ([ListArchivesResponse](#yandex.cloud.backup.v1.ListArchivesResponse))**

## ListArchivesRequest {#yandex.cloud.backup.v1.ListArchivesRequest}

```json
{
  // Includes only one of the fields `folderId`, `computeInstanceId`
  "folderId": "string",
  "computeInstanceId": "string"
  // end of the list of possible fields
}
```

#|
||Field | Description ||
|| folderId | **string**

List of archives in specified folder.

Includes only one of the fields `folderId`, `computeInstanceId`. ||
|| computeInstanceId | **string**

List of archives of the specified Compute Cloud instance.

Includes only one of the fields `folderId`, `computeInstanceId`. ||
|#

## ListArchivesResponse {#yandex.cloud.backup.v1.ListArchivesResponse}

```json
{
  "archives": [
    {
      "id": "string",
      "name": "string",
      "vaultId": "string",
      "attributes": {
        "aaib": "string",
        "uri": "string"
      },
      "size": "int64",
      "compressedDataSize": "int64",
      "dataSize": "int64",
      "originalDataSize": "int64",
      "logicalSize": "int64",
      "format": "Format",
      "createdAt": "google.protobuf.Timestamp",
      "updatedAt": "google.protobuf.Timestamp",
      "lastBackupCreatedAt": "google.protobuf.Timestamp",
      "lastSeenAt": "google.protobuf.Timestamp",
      "protectedByPassword": "bool",
      "encryptionAlgorithm": "EncryptionAlgorithm",
      "actions": [
        "Action"
      ],
      "backupPlanId": "string",
      "backupPlanName": "string",
      "description": "string",
      "displayName": "string",
      "computeInstanceId": "string",
      "consistent": "bool",
      "deleted": "bool",
      "resourceId": "string"
    }
  ]
}
```

#|
||Field | Description ||
|| archives[] | **[Archive](#yandex.cloud.backup.v1.Archive)** ||
|#

## Archive {#yandex.cloud.backup.v1.Archive}

Archive is a container that holds backups of Compute Cloud instance.

#|
||Field | Description ||
|| id | **string**

ID of the backup. ||
|| name | **string**

Name of the backup. ||
|| vaultId | **string**

ID of the backup vault. ||
|| attributes | **[ArchiveAttributes](#yandex.cloud.backup.v1.Archive.ArchiveAttributes)**

Archive attributes. ||
|| size | **int64**

Archive size. ||
|| compressedDataSize | **int64**

Compressed data size. ||
|| dataSize | **int64**

Data size. ||
|| originalDataSize | **int64**

Original data size. ||
|| logicalSize | **int64**

Logical size. ||
|| format | enum **Format**

- `FORMAT_UNSPECIFIED`
- `VERSION_11`: A legacy backup format used in older versions. It's not recommended to use.
- `VERSION_12`: A new format recommended in most cases for fast backup and recovery.
- `AUTO`: Automatic version selection. Will be used version 12 unless the protection
plan (policy) appends backups to the ones created by earlier product
versions. ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|| updatedAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|| lastBackupCreatedAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|| lastSeenAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|| protectedByPassword | **bool**

If this field is true, it means that any of encryption algorithm
has been chosen. ||
|| encryptionAlgorithm | enum **EncryptionAlgorithm**

- `ENCRYPTION_ALGORITHM_UNSPECIFIED`
- `NONE`
- `AES128`
- `AES192`
- `AES256` ||
|| actions[] | enum **Action**

- `ACTION_UNSPECIFIED`
- `REFRESH`
- `DELETE_BY_AGENT` ||
|| backupPlanId | **string**

Backup plan ID. ||
|| backupPlanName | **string**

Backup plan name. ||
|| description | **string**

Backup plan description. ||
|| displayName | **string**

Display name, e.g. `INSTANCE_NAME - POLICY_NAME`. ||
|| computeInstanceId | **string**

Compute Cloud instance ID. ||
|| consistent | **bool**

If this field is true, it means that the archive is consistent. ||
|| deleted | **bool**

If this field is true, it means that the archive was deleted. ||
|| resourceId | **string**

Resource ID. ||
|#

## ArchiveAttributes {#yandex.cloud.backup.v1.Archive.ArchiveAttributes}

Archive attributes.

#|
||Field | Description ||
|| aaib | **string**

Archive attribute. Default value: `0`. ||
|| uri | **string**

URI of the backup archive. ||
|#