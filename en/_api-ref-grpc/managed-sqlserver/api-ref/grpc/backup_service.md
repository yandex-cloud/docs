---
editable: false
---

# Managed Service for SQL Server API, gRPC: BackupService

A set of methods for managing SQL Server backups.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specified SQL Server backup. |
| [List](#List) | Retrieves the list of SQL Server backups available for the specified folder. |

## Calls BackupService {#calls}

## Get {#Get}

Returns the specified SQL Server backup. <br>To get the list of available SQL Server backups, make a [List](#List) request.

**rpc Get ([GetBackupRequest](#GetBackupRequest)) returns ([Backup](#Backup))**

### GetBackupRequest {#GetBackupRequest}

Field | Description
--- | ---
backup_id | **string**<br>Required. ID of the backup to return information about. <br>To get the backup ID, use a [ClusterService.ListBackups](./cluster_service#ListBackups) request. 


### Backup {#Backup}

Field | Description
--- | ---
id | **string**<br>ID of the backup. 
folder_id | **string**<br>ID of the folder that the backup belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the backup operation was completed. 
source_cluster_id | **string**<br>ID of the SQL Server cluster that the backup was created for. 
started_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the backup operation was started. 
databases[] | **string**<br>List of databases included in the backup. 


## List {#List}

Retrieves the list of SQL Server backups available for the specified folder.

**rpc List ([ListBackupsRequest](#ListBackupsRequest)) returns ([ListBackupsResponse](#ListBackupsResponse))**

### ListBackupsRequest {#ListBackupsRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to list backups in. <br>To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List) request. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. <br>If the number of available results is larger than `page_size`, the service returns a [ListBackupsResponse.next_page_token](#ListBackupsResponse) that can be used to get the next page of results in subsequent list requests. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListBackupsResponse.next_page_token](#ListBackupsResponse) returned by the previous list request. The maximum string length in characters is 100.


### ListBackupsResponse {#ListBackupsResponse}

Field | Description
--- | ---
backups[] | **[Backup](#Backup1)**<br>List of SQL Server backups. 
next_page_token | **string**<br>This token allows you to get the next page of results for ListBackups requests. <br>If the number of results is larger than [ListBackupsRequest.page_size](#ListBackupsRequest), use the `next_page_token` as the value for the [ListBackupsRequest.page_token](#ListBackupsRequest) parameter in the next ListBackups request. <br>Each subsequent ListBackups request has its own `next_page_token` to continue paging through the results. The maximum string length in characters is 100.


### Backup {#Backup1}

Field | Description
--- | ---
id | **string**<br>ID of the backup. 
folder_id | **string**<br>ID of the folder that the backup belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the backup operation was completed. 
source_cluster_id | **string**<br>ID of the SQL Server cluster that the backup was created for. 
started_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the backup operation was started. 
databases[] | **string**<br>List of databases included in the backup. 


