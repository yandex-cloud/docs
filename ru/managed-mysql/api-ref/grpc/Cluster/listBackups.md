---
editable: false
sourcePath: en/_api-ref-grpc/mdb/mysql/v1/api-ref/grpc/Cluster/listBackups.md
---

# Managed Service for MySQL API, gRPC: ClusterService.ListBackups

Retrieves a list of backups for a cluster.

To list all backups in a folder, make a [BackupService.List](/docs/managed-mysql/api-ref/grpc/Backup/list#List) request.

## gRPC request

**rpc ListBackups ([ListClusterBackupsRequest](#yandex.cloud.mdb.mysql.v1.ListClusterBackupsRequest)) returns ([ListClusterBackupsResponse](#yandex.cloud.mdb.mysql.v1.ListClusterBackupsResponse))**

## ListClusterBackupsRequest {#yandex.cloud.mdb.mysql.v1.ListClusterBackupsRequest}

```json
{
  "cluster_id": "string",
  "page_size": "int64",
  "page_token": "string"
}
```

#|
||Field | Description ||
|| cluster_id | **string**

Required field. ID of the cluster to list backups for.

To get this ID, make a [ClusterService.List](/docs/managed-mysql/api-ref/grpc/Cluster/list#List) request. ||
|| page_size | **int64**

The maximum number of results per page to return.

If the number of available results is larger than `page_size`, the API returns a [ListClusterBackupsResponse.next_page_token](#yandex.cloud.mdb.mysql.v1.ListClusterBackupsResponse) that can be used to get the next page of results in the subsequent [ClusterService.ListBackups](#ListBackups) requests. ||
|| page_token | **string**

Page token that can be used to iterate through multiple pages of results.

To get the next page of results, set `page_token` to the [ListClusterBackupsResponse.next_page_token](#yandex.cloud.mdb.mysql.v1.ListClusterBackupsResponse) returned by the previous [ClusterService.ListBackups](#ListBackups) request. ||
|#

## ListClusterBackupsResponse {#yandex.cloud.mdb.mysql.v1.ListClusterBackupsResponse}

```json
{
  "backups": [
    {
      "id": "string",
      "folder_id": "string",
      "created_at": "google.protobuf.Timestamp",
      "source_cluster_id": "string",
      "started_at": "google.protobuf.Timestamp",
      "size": "int64",
      "type": "BackupCreationType",
      "status": "BackupStatus"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| backups[] | **[Backup](#yandex.cloud.mdb.mysql.v1.Backup)**

List of the cluster backups. ||
|| next_page_token | **string**

The token that can be used to get the next page of results.

If the number of results is larger than [ListClusterBackupsRequest.page_size](#yandex.cloud.mdb.mysql.v1.ListClusterBackupsRequest), use the `next_page_token` as the value for the [ListClusterBackupsRequest.page_token](#yandex.cloud.mdb.mysql.v1.ListClusterBackupsRequest) in the subsequent [ClusterService.ListBackups](#ListBackups) request to iterate through multiple pages of results.

Each of the subsequent [ClusterService.ListBackups](#ListBackups) requests should use the `next_page_token` value returned by the previous request to continue paging through the results. ||
|#

## Backup {#yandex.cloud.mdb.mysql.v1.Backup}

An object that represents MySQL backup.

See [the documentation](/docs/managed-mysql/concepts/backup) for details.

#|
||Field | Description ||
|| id | **string**

Required field. ID of the backup. ||
|| folder_id | **string**

ID of the folder that the backup belongs to. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp (the time when the backup operation was completed). ||
|| source_cluster_id | **string**

ID of the cluster that the backup was created for. ||
|| started_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Start timestamp (the time when the backup operation was started). ||
|| size | **int64**

Size of backup, in bytes ||
|| type | enum **BackupCreationType**

How this backup was created (manual/automatic/etc...)

- `BACKUP_CREATION_TYPE_UNSPECIFIED`
- `AUTOMATED`: Backup created by automated daily schedule
- `MANUAL`: Backup created by user request ||
|| status | enum **BackupStatus**

Status of backup

- `BACKUP_STATUS_UNSPECIFIED`
- `DONE`: Backup is done
- `CREATING`: Backup is creating ||
|#