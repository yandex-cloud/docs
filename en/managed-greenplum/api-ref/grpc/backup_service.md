---
editable: false
sourcePath: en/_api-ref-grpc/managed-greenplum/api-ref/grpc/backup_service.md
---

# Managed Service for Greenplum® API, gRPC: BackupService

A set of methods for managing backups.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specified backup of Greenplum® cluster. |
| [List](#List) | Returns the list of available backups for the specified Greenplum® cluster. |
| [Delete](#Delete) |  |

## Calls BackupService {#calls}

## Get {#Get}

Returns the specified backup of Greenplum® cluster.

**rpc Get ([GetBackupRequest](#GetBackupRequest)) returns ([Backup](#Backup))**

### GetBackupRequest {#GetBackupRequest}

Field | Description
--- | ---
backup_id | **string**<br>Required. ID of the backup to return. 


### Backup {#Backup}

Field | Description
--- | ---
id | **string**<br>Required. ID of the backup. 
folder_id | **string**<br>ID of the folder that the backup belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the backup operation was completed. 
source_cluster_id | **string**<br>ID of the Greenplum® cluster that the backup was created for. 
started_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the backup operation was started. 
size | **int64**<br>Size of the backup in bytes. 
type | enum **BackupCreationType**<br>How this backup was created (manual/automatic/etc...) <ul><li>`AUTOMATED`: Backup created by automated daily schedule</li><li>`MANUAL`: Backup created by user request</li></ul>
method | enum **BackupMethod**<br>Method of backup creation <ul><li>`BASE`: Base backup</li><li>`INCREMENTAL`: Delta (incremental) Greenplum backup</li></ul>
journal_size | **int64**<br>Size of the journal associated with backup, in bytes 


## List {#List}

Returns the list of available backups for the specified Greenplum® cluster.

**rpc List ([ListBackupsRequest](#ListBackupsRequest)) returns ([ListBackupsResponse](#ListBackupsResponse))**

### ListBackupsRequest {#ListBackupsRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to list backups in. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. <br>If the number of available results is larger than `page_size`, the service returns a [ListBackupsResponse.next_page_token](#ListBackupsResponse) that can be used to get the next page of results in subsequent list requests. <br>Default value is 100. Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br>The page token. To get the next page of results, set `page_token` to the [ListBackupsResponse.next_page_token](#ListBackupsResponse) returned by the previous list request. The maximum string length in characters is 100.


### ListBackupsResponse {#ListBackupsResponse}

Field | Description
--- | ---
backups[] | **[Backup](#Backup1)**<br>Requested list of backups. 
next_page_token | **string**<br>This token allows you to get the next page of results for a list request. <br>If the number of results is larger than [ListBackupsRequest.page_size](#ListBackupsRequest) specified in the request, use the `next_page_token` as the value for the [ListBackupsRequest.page_token](#ListBackupsRequest) parameter in the next list request. <br>Each subsequent ListBackups request has its own `next_page_token` to continue paging through the results. 


### Backup {#Backup1}

Field | Description
--- | ---
id | **string**<br>Required. ID of the backup. 
folder_id | **string**<br>ID of the folder that the backup belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the backup operation was completed. 
source_cluster_id | **string**<br>ID of the Greenplum® cluster that the backup was created for. 
started_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the backup operation was started. 
size | **int64**<br>Size of the backup in bytes. 
type | enum **BackupCreationType**<br>How this backup was created (manual/automatic/etc...) <ul><li>`AUTOMATED`: Backup created by automated daily schedule</li><li>`MANUAL`: Backup created by user request</li></ul>
method | enum **BackupMethod**<br>Method of backup creation <ul><li>`BASE`: Base backup</li><li>`INCREMENTAL`: Delta (incremental) Greenplum backup</li></ul>
journal_size | **int64**<br>Size of the journal associated with backup, in bytes 


## Delete {#Delete}



**rpc Delete ([DeleteBackupRequest](#DeleteBackupRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteBackupMetadata](#DeleteBackupMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteBackupRequest {#DeleteBackupRequest}

Field | Description
--- | ---
backup_id | **string**<br>Required. Required. ID of the backup to delete. 


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteBackupMetadata](#DeleteBackupMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### DeleteBackupMetadata {#DeleteBackupMetadata}

Field | Description
--- | ---
backup_id | **string**<br>Required. ID of the Greenplum backup that is currently being deleted. 
cluster_id | **string**<br>ID of the Greenplum backup that is being deleted. The maximum string length in characters is 50.


