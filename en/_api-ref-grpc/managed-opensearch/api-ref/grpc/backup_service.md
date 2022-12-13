---
editable: false
---

# Managed Service for OpenSearch API, gRPC: BackupService

A set of methods for managing backups.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specified backup of an OpenSearch cluster. |
| [List](#List) | Returns the list of available backups for the specified OpenSearch cluster. |

## Calls BackupService {#calls}

## Get {#Get}

Returns the specified backup of an OpenSearch cluster.

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
source_cluster_id | **string**<br>ID of the OpenSearch cluster that the backup was created for. 
started_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the backup operation was started. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the backup operation was completed. 
indices[] | **string**<br>Names of indices in the backup. The maximum number of elements is 100.
opensearch_version | **string**<br>OpenSearch version used to create the backup. 
size_bytes | **int64**<br>Size of the backup in bytes. 
indices_total | **int64**<br>The number of indices in the backup. 


## List {#List}

Returns the list of available backups for the specified OpenSearch cluster.

**rpc List ([ListBackupsRequest](#ListBackupsRequest)) returns ([ListBackupsResponse](#ListBackupsResponse))**

### ListBackupsRequest {#ListBackupsRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to list backups in. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page that should be returned. <br>If the number of available results is larger than `page_size`, the service returns a [ListBackupsResponse.next_page_token](#ListBackupsResponse) that can be used to get the next page of results in subsequent list requests. <br>Default value is 100. Acceptable values are 0 to 1000, inclusive.
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
source_cluster_id | **string**<br>ID of the OpenSearch cluster that the backup was created for. 
started_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the backup operation was started. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the backup operation was completed. 
indices[] | **string**<br>Names of indices in the backup. The maximum number of elements is 100.
opensearch_version | **string**<br>OpenSearch version used to create the backup. 
size_bytes | **int64**<br>Size of the backup in bytes. 
indices_total | **int64**<br>The number of indices in the backup. 


