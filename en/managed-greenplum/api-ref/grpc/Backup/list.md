---
editable: false
sourcePath: en/_api-ref-grpc/mdb/greenplum/v1/api-ref/grpc/Backup/list.md
---

# Managed Service for Greenplum® API, gRPC: BackupService.List

Returns the list of available backups for the specified Greenplum® cluster.

## gRPC request

**rpc List ([ListBackupsRequest](#yandex.cloud.mdb.greenplum.v1.ListBackupsRequest)) returns ([ListBackupsResponse](#yandex.cloud.mdb.greenplum.v1.ListBackupsResponse))**

## ListBackupsRequest {#yandex.cloud.mdb.greenplum.v1.ListBackupsRequest}

```json
{
  "folder_id": "string",
  "page_size": "int64",
  "page_token": "string"
}
```

#|
||Field | Description ||
|| folder_id | **string**

Required field. ID of the folder to list backups in. ||
|| page_size | **int64**

The maximum number of results per page to return.

If the number of available results is larger than `page_size`, the service returns a [ListBackupsResponse.next_page_token](#yandex.cloud.mdb.greenplum.v1.ListBackupsResponse) that can be used to get the next page of results in subsequent list requests.

Default value is 100. ||
|| page_token | **string**

The page token. To get the next page of results, set `page_token` to the [ListBackupsResponse.next_page_token](#yandex.cloud.mdb.greenplum.v1.ListBackupsResponse) returned by the previous list request. ||
|#

## ListBackupsResponse {#yandex.cloud.mdb.greenplum.v1.ListBackupsResponse}

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
      "method": "BackupMethod",
      "journal_size": "int64"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| backups[] | **[Backup](#yandex.cloud.mdb.greenplum.v1.Backup)**

Requested list of backups. ||
|| next_page_token | **string**

This token allows you to get the next page of results for a list request.

If the number of results is larger than [ListBackupsRequest.page_size](#yandex.cloud.mdb.greenplum.v1.ListBackupsRequest) specified in the request, use the `next_page_token` as the value for the [ListBackupsRequest.page_token](#yandex.cloud.mdb.greenplum.v1.ListBackupsRequest) parameter in the next list request.

Each subsequent ListBackups request has its own `next_page_token` to continue paging through the results. ||
|#

## Backup {#yandex.cloud.mdb.greenplum.v1.Backup}

#|
||Field | Description ||
|| id | **string**

Required. ID of the backup. ||
|| folder_id | **string**

ID of the folder that the backup belongs to. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time when the backup operation was completed. ||
|| source_cluster_id | **string**

ID of the Greenplum® cluster that the backup was created for. ||
|| started_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time when the backup operation was started. ||
|| size | **int64**

Size of the backup in bytes. ||
|| type | enum **BackupCreationType**

How this backup was created (manual/automatic/etc...)

- `BACKUP_CREATION_TYPE_UNSPECIFIED`
- `AUTOMATED`: Backup created by automated daily schedule
- `MANUAL`: Backup created by user request ||
|| method | enum **BackupMethod**

Method of backup creation

- `BACKUP_METHOD_UNSPECIFIED`
- `BASE`: Base backup
- `INCREMENTAL`: Delta (incremental) Greenplum backup ||
|| journal_size | **int64**

Size of the journal associated with backup, in bytes ||
|#