---
editable: false
---

# BackupService

A set of methods for managing MySQL backups. 

See [the documentation](/docs/managed-mysql/operations/cluster-backups) for details.

| Call | Description |
| --- | --- |
| [Get](#Get) | Retrieves information about the specified backup. |
| [List](#List) | Retrieves the list of backups in a folder. |

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


