---
editable: false
sourcePath: en/_api-ref-grpc/mdb/mongodb/v1/api-ref/grpc/Cluster/listBackups.md
---

# Managed Service for MongoDB API, gRPC: ClusterService.ListBackups

Retrieves the list of available backups for the specified MongoDB cluster.

## gRPC request

**rpc ListBackups ([ListClusterBackupsRequest](#yandex.cloud.mdb.mongodb.v1.ListClusterBackupsRequest)) returns ([ListClusterBackupsResponse](#yandex.cloud.mdb.mongodb.v1.ListClusterBackupsResponse))**

## ListClusterBackupsRequest {#yandex.cloud.mdb.mongodb.v1.ListClusterBackupsRequest}

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

Required field. ID of the MongoDB cluster.
To get the MongoDB cluster ID, use a [ClusterService.List](/docs/managed-mongodb/api-ref/grpc/Cluster/list#List) request. ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `page_size`, the service returns a [ListClusterBackupsResponse.next_page_token](#yandex.cloud.mdb.mongodb.v1.ListClusterBackupsResponse)
that can be used to get the next page of results in subsequent list requests.
Acceptable values are 0 to 1000, inclusive. Default value: 100. ||
|| page_token | **string**

Page token.  To get the next page of results, set `page_token` to the
[ListClusterBackupsResponse.next_page_token](#yandex.cloud.mdb.mongodb.v1.ListClusterBackupsResponse) returned by the previous list request. ||
|#

## ListClusterBackupsResponse {#yandex.cloud.mdb.mongodb.v1.ListClusterBackupsResponse}

```json
{
  "backups": [
    {
      "id": "string",
      "folder_id": "string",
      "created_at": "google.protobuf.Timestamp",
      "source_cluster_id": "string",
      "started_at": "google.protobuf.Timestamp",
      "source_shard_names": [
        "string"
      ],
      "size": "int64",
      "type": "BackupType",
      "journal_size": "int64"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| backups[] | **[Backup](#yandex.cloud.mdb.mongodb.v1.Backup)**

List of MongoDB Backup resources. ||
|| next_page_token | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListClusterBackupsRequest.page_size](#yandex.cloud.mdb.mongodb.v1.ListClusterBackupsRequest), use the `next_page_token` as the value
for the [ListClusterBackupsRequest.page_token](#yandex.cloud.mdb.mongodb.v1.ListClusterBackupsRequest) query parameter in the next list request.
Each subsequent list request will have its own `next_page_token` to continue paging through the results. ||
|#

## Backup {#yandex.cloud.mdb.mongodb.v1.Backup}

A MongoDB Backup resource. For more information, see the
[Developer's Guide](/docs/managed-mongodb/concepts).

#|
||Field | Description ||
|| id | **string**

ID of the backup. Required. ||
|| folder_id | **string**

ID of the folder that the backup belongs to. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format
(i.e. when the backup operation was completed). ||
|| source_cluster_id | **string**

ID of the MongoDB cluster that the backup was created for. ||
|| started_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time when the backup operation was started. ||
|| source_shard_names[] | **string**

Shard names used as a source for backup. ||
|| size | **int64**

Size of backup in bytes ||
|| type | enum **BackupType**

How this backup was created (manual/automatic/etc...)

- `BACKUP_TYPE_UNSPECIFIED`
- `AUTOMATED`: Backup created by automated daily schedule
- `MANUAL`: Backup created by user request ||
|| journal_size | **int64**

Size of the journal associated with backup, in bytes ||
|#