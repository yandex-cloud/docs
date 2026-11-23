[Документация Yandex Cloud](../../../../index.md) > [Yandex Managed Service for GitLab](../../../index.md) > Справочник API > [gRPC (англ.)](../index.md) > [Instance](index.md) > ListBackups

# Managed Service for Gitlab API, gRPC: InstanceService.ListBackups

Retrieves the list of backups for the specified GitLab instance.

## gRPC request

**rpc ListBackups ([ListInstanceBackupsRequest](#yandex.cloud.gitlab.v1.ListInstanceBackupsRequest)) returns ([ListInstanceBackupsResponse](#yandex.cloud.gitlab.v1.ListInstanceBackupsResponse))**

## ListInstanceBackupsRequest {#yandex.cloud.gitlab.v1.ListInstanceBackupsRequest}

```json
{
  "instance_id": "string",
  "page_size": "int64",
  "page_token": "string"
}
```

Request message for InstanceService.ListBackups.

#|
||Field | Description ||
|| instance_id | **string**

Required field. ID of the GitLab instance to list backups for.

The maximum string length in characters is 50. ||
|| page_size | **int64**

Maximum number of results per page. If unspecified, the service uses its default page size.

Acceptable values are 0 to 1000, inclusive. ||
|| page_token | **string**

Page token returned by a previous ListBackups request for the same instance.

The maximum string length in characters is 100. ||
|#

## ListInstanceBackupsResponse {#yandex.cloud.gitlab.v1.ListInstanceBackupsResponse}

```json
{
  "backups": [
    {
      "id": "string",
      "folder_id": "string",
      "instance_id": "string",
      "created_at": "google.protobuf.Timestamp",
      "size": "int64",
      "started_at": "google.protobuf.Timestamp",
      "status": "Status",
      "creation_type": "CreationType",
      "gitlab_version": "string"
    }
  ],
  "next_page_token": "string"
}
```

Response message for InstanceService.ListBackups.

#|
||Field | Description ||
|| backups[] | **[Backup](#yandex.cloud.gitlab.v1.Backup)**

Backups of the specified GitLab instance. ||
|| next_page_token | **string**

Token to retrieve the next page. Empty when there are no more results. ||
|#

## Backup {#yandex.cloud.gitlab.v1.Backup}

A backup of a GitLab instance.

#|
||Field | Description ||
|| id | **string**

ID of the backup. ||
|| folder_id | **string**

ID of the folder that owns the backup. ||
|| instance_id | **string**

ID of the GitLab instance that owns the backup. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time when backup creation completed. ||
|| size | **int64**

Size of the backup in bytes. ||
|| started_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time when backup creation started. ||
|| status | enum **Status**

Current status of the backup.

- `COMPLETED`: Backup creation completed successfully.
- `FAILED`: Backup creation failed.
- `CREATING`: Backup creation is in progress. ||
|| creation_type | enum **CreationType**

How the backup was created.

- `AUTOMATED`: Backup created on a schedule.
- `MANUAL`: Backup created or uploaded manually. ||
|| gitlab_version | **string**

GitLab version of the source instance when the backup was created. ||
|#