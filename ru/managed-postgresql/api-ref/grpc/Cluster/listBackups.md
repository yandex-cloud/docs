---
editable: false
sourcePath: en/_api-ref-grpc/mdb/postgresql/v1/api-ref/grpc/Cluster/listBackups.md
---

# Managed Service for PostgreSQL API, gRPC: ClusterService.ListBackups {#ListBackups}

Retrieves the list of available backups for the specified PostgreSQL cluster.

## gRPC request

**rpc ListBackups ([ListClusterBackupsRequest](#yandex.cloud.mdb.postgresql.v1.ListClusterBackupsRequest)) returns ([ListClusterBackupsResponse](#yandex.cloud.mdb.postgresql.v1.ListClusterBackupsResponse))**

## ListClusterBackupsRequest {#yandex.cloud.mdb.postgresql.v1.ListClusterBackupsRequest}

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

Required field. ID of the PostgreSQL cluster.
To get the PostgreSQL cluster ID use a [ClusterService.List](/docs/managed-postgresql/api-ref/grpc/Cluster/list#List) request. ||
|| pageSize | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`, the service returns a [ListClusterBackupsResponse.nextPageToken](#yandex.cloud.mdb.postgresql.v1.ListClusterBackupsResponse)
that can be used to get the next page of results in subsequent list requests. ||
|| pageToken | **string**

Page token.  To get the next page of results, set `pageToken` to the [ListClusterBackupsResponse.nextPageToken](#yandex.cloud.mdb.postgresql.v1.ListClusterBackupsResponse)
returned by the previous list request. ||
|#

## ListClusterBackupsResponse {#yandex.cloud.mdb.postgresql.v1.ListClusterBackupsResponse}

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
      "journalSize": "int64",
      "status": "BackupStatus"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| backups[] | **[Backup](#yandex.cloud.mdb.postgresql.v1.Backup)**

List of PostgreSQL Backup resources. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListClusterBackupsRequest.pageSize](#yandex.cloud.mdb.postgresql.v1.ListClusterBackupsRequest), use the `nextPageToken` as the value
for the [ListClusterBackupsRequest.pageToken](#yandex.cloud.mdb.postgresql.v1.ListClusterBackupsRequest) query parameter in the next list request.
Each subsequent list request will have its own `nextPageToken` to continue paging through the results. ||
|#

## Backup {#yandex.cloud.mdb.postgresql.v1.Backup}

A PostgreSQL Backup resource. For more information, see
the [Developer's Guide](/docs/managed-postgresql/concepts/backup).

#|
||Field | Description ||
|| id | **string**

Required. ID of the backup. ||
|| folderId | **string**

ID of the folder that the backup belongs to. ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format
(i.e. when the backup operation was completed). ||
|| sourceClusterId | **string**

ID of the PostgreSQL cluster that the backup was created for. ||
|| startedAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time when the backup operation was started. ||
|| size | **int64**

Size of backup, in bytes ||
|| type | enum **BackupCreationType**

How this backup was created (manual/automatic/etc...)

- `BACKUP_CREATION_TYPE_UNSPECIFIED`
- `AUTOMATED`: Backup created by automated daily schedule
- `MANUAL`: Backup created by user request ||
|| method | enum **BackupMethod**

Method of backup creation

- `BACKUP_METHOD_UNSPECIFIED`
- `BASE`: Base backup
- `INCREMENTAL`: Delta (incremental) PostgreSQL backup ||
|| journalSize | **int64**

Size of the journal associated with backup, in bytes ||
|| status | enum **BackupStatus**

Status of backup

- `BACKUP_STATUS_UNSPECIFIED`
- `DONE`: Backup is done
- `CREATING`: Backup is creating ||
|#