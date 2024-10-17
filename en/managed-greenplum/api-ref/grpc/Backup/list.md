---
editable: false
sourcePath: en/_api-ref-grpc/mdb/greenplum/v1/api-ref/grpc/Backup/list.md
---

# Managed Service for Greenplum® API, gRPC: BackupService.List {#List}

Returns the list of available backups for the specified Greenplum® cluster.

## gRPC request

**rpc List ([ListBackupsRequest](#yandex.cloud.mdb.greenplum.v1.ListBackupsRequest)) returns ([ListBackupsResponse](#yandex.cloud.mdb.greenplum.v1.ListBackupsResponse))**

## ListBackupsRequest {#yandex.cloud.mdb.greenplum.v1.ListBackupsRequest}

```json
{
  "folderId": "string",
  "pageSize": "int64",
  "pageToken": "string"
}
```

#|
||Field | Description ||
|| folderId | **string**

Required field. ID of the folder to list backups in. ||
|| pageSize | **int64**

The maximum number of results per page to return.

If the number of available results is larger than `pageSize`, the service returns a [ListBackupsResponse.nextPageToken](#yandex.cloud.mdb.greenplum.v1.ListBackupsResponse) that can be used to get the next page of results in subsequent list requests.

Default value is 100. ||
|| pageToken | **string**

The page token. To get the next page of results, set `pageToken` to the [ListBackupsResponse.nextPageToken](#yandex.cloud.mdb.greenplum.v1.ListBackupsResponse) returned by the previous list request. ||
|#

## ListBackupsResponse {#yandex.cloud.mdb.greenplum.v1.ListBackupsResponse}

```json
{
  "backups": [
    {
      "id": "string",
      "folderId": "string",
      "createdAt": "google.protobuf.Timestamp",
      "sourceClusterId": "string",
      "startedAt": "google.protobuf.Timestamp",
      "size": "int64",
      "type": "BackupCreationType",
      "method": "BackupMethod",
      "journalSize": "int64"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| backups[] | **[Backup](#yandex.cloud.mdb.greenplum.v1.Backup)**

Requested list of backups. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for a list request.

If the number of results is larger than [ListBackupsRequest.pageSize](#yandex.cloud.mdb.greenplum.v1.ListBackupsRequest) specified in the request, use the `nextPageToken` as the value for the [ListBackupsRequest.pageToken](#yandex.cloud.mdb.greenplum.v1.ListBackupsRequest) parameter in the next list request.

Each subsequent ListBackups request has its own `nextPageToken` to continue paging through the results. ||
|#

## Backup {#yandex.cloud.mdb.greenplum.v1.Backup}

#|
||Field | Description ||
|| id | **string**

Required. ID of the backup. ||
|| folderId | **string**

ID of the folder that the backup belongs to. ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time when the backup operation was completed. ||
|| sourceClusterId | **string**

ID of the Greenplum® cluster that the backup was created for. ||
|| startedAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

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
|| journalSize | **int64**

Size of the journal associated with backup, in bytes ||
|#