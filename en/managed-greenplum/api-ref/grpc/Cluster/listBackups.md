---
editable: false
sourcePath: en/_api-ref-grpc/mdb/greenplum/v1/api-ref/grpc/Cluster/listBackups.md
---

# Managed Service for Greenplum® API, gRPC: ClusterService.ListBackups

Retrieves a list of available backups for the specified Greenplum® cluster.

## gRPC request

**rpc ListBackups ([ListClusterBackupsRequest](#yandex.cloud.mdb.greenplum.v1.ListClusterBackupsRequest)) returns ([ListClusterBackupsResponse](#yandex.cloud.mdb.greenplum.v1.ListClusterBackupsResponse))**

## ListClusterBackupsRequest {#yandex.cloud.mdb.greenplum.v1.ListClusterBackupsRequest}

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

Required field. ID of the Greenplum® cluster.

To get the Greenplum® cluster ID use a [ClusterService.List](/docs/managed-greenplum/api-ref/grpc/Cluster/list#List) request. ||
|| page_size | **int64**

The maximum number of results per page to return.

If the number of available results is larger than `page_size`, the service returns a [ListClusterBackupsResponse.next_page_token](#yandex.cloud.mdb.greenplum.v1.ListClusterBackupsResponse) that can be used to get the next page of results in subsequent list requests. ||
|| page_token | **string**

Page token. To get the next page of results, set `page_token` to the [ListClusterBackupsResponse.next_page_token](#yandex.cloud.mdb.greenplum.v1.ListClusterBackupsResponse) returned by the previous list request. ||
|#

## ListClusterBackupsResponse {#yandex.cloud.mdb.greenplum.v1.ListClusterBackupsResponse}

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

List of Greenplum® backups. ||
|| next_page_token | **string**

This token allows you to get the next page of results for list requests.

If the number of results is larger than [ListClusterBackupsRequest.page_size](#yandex.cloud.mdb.greenplum.v1.ListClusterBackupsRequest), use the `next_page_token` as the value for the [ListClusterBackupsRequest.page_token](#yandex.cloud.mdb.greenplum.v1.ListClusterBackupsRequest) query parameter in the next list request.

Each subsequent list request has its own `next_page_token` to continue paging through the results. ||
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