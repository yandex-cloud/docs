---
editable: false
sourcePath: en/_api-ref-grpc/mdb/greenplum/v1/api-ref/grpc/Cluster/listBackups.md
---

# Managed Service for Greenplum® API, gRPC: ClusterService.ListBackups {#ListBackups}

Retrieves a list of available backups for the specified Greenplum® cluster.

## gRPC request

**rpc ListBackups ([ListClusterBackupsRequest](#yandex.cloud.mdb.greenplum.v1.ListClusterBackupsRequest)) returns ([ListClusterBackupsResponse](#yandex.cloud.mdb.greenplum.v1.ListClusterBackupsResponse))**

## ListClusterBackupsRequest {#yandex.cloud.mdb.greenplum.v1.ListClusterBackupsRequest}

```json
{
  "clusterId": "string",
  "pageSize": "int64",
  "pageToken": "string"
}
```

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the Greenplum® cluster.

To get the Greenplum® cluster ID use a [ClusterService.List](/docs/managed-greenplum/api-ref/grpc/Cluster/list#List) request. ||
|| pageSize | **int64**

The maximum number of results per page to return.

If the number of available results is larger than `pageSize`, the service returns a [ListClusterBackupsResponse.nextPageToken](#yandex.cloud.mdb.greenplum.v1.ListClusterBackupsResponse) that can be used to get the next page of results in subsequent list requests. ||
|| pageToken | **string**

Page token. To get the next page of results, set `pageToken` to the [ListClusterBackupsResponse.nextPageToken](#yandex.cloud.mdb.greenplum.v1.ListClusterBackupsResponse) returned by the previous list request. ||
|#

## ListClusterBackupsResponse {#yandex.cloud.mdb.greenplum.v1.ListClusterBackupsResponse}

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

List of Greenplum® backups. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests.

If the number of results is larger than [ListClusterBackupsRequest.pageSize](#yandex.cloud.mdb.greenplum.v1.ListClusterBackupsRequest), use the `nextPageToken` as the value for the [ListClusterBackupsRequest.pageToken](#yandex.cloud.mdb.greenplum.v1.ListClusterBackupsRequest) query parameter in the next list request.

Each subsequent list request has its own `nextPageToken` to continue paging through the results. ||
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