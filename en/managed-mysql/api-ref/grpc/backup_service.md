---
editable: false
sourcePath: en/_api-ref-grpc/managed-mysql/api-ref/grpc/backup_service.md
---

# Managed Service for MySQL API, gRPC: BackupService

A set of methods for managing MySQL backups. 

See [the documentation](/docs/managed-mysql/operations/cluster-backups) for details.

| Call | Description |
| --- | --- |
| [Get](#Get) | Retrieves information about the specified backup. |
| [List](#List) | Retrieves the list of backups in a folder. |
| [Delete](#Delete) | Deletes the specified MySQL cluster backup. |

## Calls BackupService {#calls}

## Get {#Get}

Retrieves information about the specified backup.

**rpc Get ([GetBackupRequest](#GetBackupRequest)) returns ([Backup](#Backup))**

### GetBackupRequest {#GetBackupRequest}

Field | Description
--- | ---
backup_id | **string**<br>Required. ID of the backup to return information about. <br>To get this ID, make a [BackupService.List](#List) request (lists all backups in a folder) or a [ClusterService.ListBackups](./cluster_service#ListBackups) request (lists all backups for an existing cluster). 


### Backup {#Backup}

Field | Description
--- | ---
id | **string**<br>Required. ID of the backup. 
folder_id | **string**<br>ID of the folder that the backup belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp (the time when the backup operation was completed). 
source_cluster_id | **string**<br>ID of the cluster that the backup was created for. 
started_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Start timestamp (the time when the backup operation was started). 
size | **int64**<br>Size of backup, in bytes 
type | enum **BackupCreationType**<br>How this backup was created (manual/automatic/etc...) <ul><li>`AUTOMATED`: Backup created by automated daily schedule</li><li>`MANUAL`: Backup created by user request</li></ul>
status | enum **BackupStatus**<br>Status of backup <ul><li>`DONE`: Backup is done</li><li>`CREATING`: Backup is creating</li></ul>


## List {#List}

Retrieves the list of backups in a folder. <br>To list backups for an existing cluster, make a [ClusterService.ListBackups](./cluster_service#ListBackups) request.

**rpc List ([ListBackupsRequest](#ListBackupsRequest)) returns ([ListBackupsResponse](#ListBackupsResponse))**

### ListBackupsRequest {#ListBackupsRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to list backups in. <br>To get this ID, make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List) request. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. <br>If the number of available results is larger than `page_size`, the API returns a [ListBackupsResponse.next_page_token](#ListBackupsResponse) that can be used to get the next page of results in the subsequent [BackupService.List](#List) requests. The maximum value is 1000.
page_token | **string**<br>Page token that can be used to iterate through multiple pages of results. <br>To get the next page of results, set `page_token` to the [ListBackupsResponse.next_page_token](#ListBackupsResponse) returned by the previous [BackupService.List](#List) request. The maximum string length in characters is 100.


### ListBackupsResponse {#ListBackupsResponse}

Field | Description
--- | ---
backups[] | **[Backup](#Backup1)**<br>List of backups. 
next_page_token | **string**<br>The token that can be used to get the next page of results. <br>If the number of results is larger than [ListBackupsRequest.page_size](#ListBackupsRequest), use the `next_page_token` as the value for the [ListBackupsRequest.page_token](#ListBackupsRequest) in the subsequent [BackupService.List](#List) request to iterate through multiple pages of results. <br>Each of the subsequent [BackupService.List](#List) requests should use the `next_page_token` value returned by the previous request to continue paging through the results. The maximum string length in characters is 100.


### Backup {#Backup1}

Field | Description
--- | ---
id | **string**<br>Required. ID of the backup. 
folder_id | **string**<br>ID of the folder that the backup belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp (the time when the backup operation was completed). 
source_cluster_id | **string**<br>ID of the cluster that the backup was created for. 
started_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Start timestamp (the time when the backup operation was started). 
size | **int64**<br>Size of backup, in bytes 
type | enum **BackupCreationType**<br>How this backup was created (manual/automatic/etc...) <ul><li>`AUTOMATED`: Backup created by automated daily schedule</li><li>`MANUAL`: Backup created by user request</li></ul>
status | enum **BackupStatus**<br>Status of backup <ul><li>`DONE`: Backup is done</li><li>`CREATING`: Backup is creating</li></ul>


## Delete {#Delete}

Deletes the specified MySQL cluster backup.

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
backup_id | **string**<br>Required. ID of the MySQL backup that is currently being deleted. 
cluster_id | **string**<br>ID of the MySQL backup that is being deleted. 


