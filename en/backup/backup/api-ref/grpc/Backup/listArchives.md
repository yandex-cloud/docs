---
editable: false
sourcePath: en/_api-ref-grpc/backup/v1/backup/api-ref/grpc/Backup/listArchives.md
---

# Cloud Backup API, gRPC: BackupService.ListArchives

List archives that holds backups for specified folder or
specified [Compute Cloud instance](/docs/backup/concepts/vm-connection#os).

## gRPC request

**rpc ListArchives ([ListArchivesRequest](#yandex.cloud.backup.v1.ListArchivesRequest)) returns ([ListArchivesResponse](#yandex.cloud.backup.v1.ListArchivesResponse))**

## ListArchivesRequest {#yandex.cloud.backup.v1.ListArchivesRequest}

```json
{
  // Includes only one of the fields `folder_id`, `compute_instance_id`
  "folder_id": "string",
  "compute_instance_id": "string"
  // end of the list of possible fields
}
```

#|
||Field | Description ||
|| folder_id | **string**

List of archives in specified folder.

Includes only one of the fields `folder_id`, `compute_instance_id`. ||
|| compute_instance_id | **string**

List of archives of the specified Compute Cloud instance.

Includes only one of the fields `folder_id`, `compute_instance_id`. ||
|#

## ListArchivesResponse {#yandex.cloud.backup.v1.ListArchivesResponse}

```json
{
  "archives": [
    {
      "id": "string",
      "name": "string",
      "vault_id": "string",
      "attributes": {
        "aaib": "string",
        "uri": "string"
      },
      "size": "int64",
      "compressed_data_size": "int64",
      "data_size": "int64",
      "original_data_size": "int64",
      "logical_size": "int64",
      "format": "Format",
      "created_at": "google.protobuf.Timestamp",
      "updated_at": "google.protobuf.Timestamp",
      "last_backup_created_at": "google.protobuf.Timestamp",
      "last_seen_at": "google.protobuf.Timestamp",
      "protected_by_password": "bool",
      "encryption_algorithm": "EncryptionAlgorithm",
      "actions": [
        "Action"
      ],
      "backup_plan_id": "string",
      "backup_plan_name": "string",
      "description": "string",
      "display_name": "string",
      "compute_instance_id": "string",
      "consistent": "bool",
      "deleted": "bool",
      "resource_id": "string"
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
|| vault_id | **string**

ID of the backup vault. ||
|| attributes | **[ArchiveAttributes](#yandex.cloud.backup.v1.Archive.ArchiveAttributes)**

Archive attributes. ||
|| size | **int64**

Archive size. ||
|| compressed_data_size | **int64**

Compressed data size. ||
|| data_size | **int64**

Data size. ||
|| original_data_size | **int64**

Original data size. ||
|| logical_size | **int64**

Logical size. ||
|| format | enum **Format**

- `FORMAT_UNSPECIFIED`
- `VERSION_11`: A legacy backup format used in older versions. It's not recommended to use.
- `VERSION_12`: A new format recommended in most cases for fast backup and recovery.
- `AUTO`: Automatic version selection. Will be used version 12 unless the protection
plan (policy) appends backups to the ones created by earlier product
versions. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|| updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|| last_backup_created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|| last_seen_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|| protected_by_password | **bool**

If this field is true, it means that any of encryption algorithm
has been chosen. ||
|| encryption_algorithm | enum **EncryptionAlgorithm**

- `ENCRYPTION_ALGORITHM_UNSPECIFIED`
- `NONE`
- `AES128`
- `AES192`
- `AES256` ||
|| actions[] | enum **Action**

- `ACTION_UNSPECIFIED`
- `REFRESH`
- `DELETE_BY_AGENT` ||
|| backup_plan_id | **string**

Backup plan ID. ||
|| backup_plan_name | **string**

Backup plan name. ||
|| description | **string**

Backup plan description. ||
|| display_name | **string**

Display name, e.g. `INSTANCE_NAME - POLICY_NAME`. ||
|| compute_instance_id | **string**

Compute Cloud instance ID. ||
|| consistent | **bool**

If this field is true, it means that the archive is consistent. ||
|| deleted | **bool**

If this field is true, it means that the archive was deleted. ||
|| resource_id | **string**

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