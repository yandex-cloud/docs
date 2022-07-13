---
editable: false
sourcePath: en/_api-ref-grpc/managed-redis/api-ref/grpc/backup_service.md
---

# BackupService

A set of methods for managing Redis backups.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specified Redis backup. |
| [List](#List) | Retrieves the list of Redis backups available for the specified folder. |

## Calls BackupService {#calls}

## Get {#Get}

Returns the specified Redis backup. <br>To get the list of available Redis backups, make a [List](#List) request.

**rpc Get ([GetBackupRequest](#GetBackupRequest)) returns ([Backup](#Backup))**

### GetBackupRequest {#GetBackupRequest}

Field | Description
--- | ---
backup_id | **string**<br>Required. ID of the Redis backup to return. To get the backup ID, use a [ClusterService.ListBackups](./cluster_service#ListBackups) request. 


### Backup {#Backup}

Field | Description
--- | ---
id | **string**<br>ID of the backup. 
folder_id | **string**<br>ID of the folder that the backup belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format (i.e. when the backup operation was completed). 
source_cluster_id | **string**<br>ID of the Redis cluster that the backup was created for. 
started_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Start timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format (i.e. when the backup operation was started). 
source_shard_names[] | **string**<br>Shard names used as a source for backup. 


## List {#List}

Retrieves the list of Redis backups available for the specified folder.

**rpc List ([ListBackupsRequest](#ListBackupsRequest)) returns ([ListBackupsResponse](#ListBackupsResponse))**

### ListBackupsRequest {#ListBackupsRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to list backups in. To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List) request. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListBackupsResponse.next_page_token](#ListBackupsResponse) that can be used to get the next page of results in subsequent list requests. Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListBackupsResponse.next_page_token](#ListBackupsResponse) returned by the previous list request. The maximum string length in characters is 100.


### ListBackupsResponse {#ListBackupsResponse}

Field | Description
--- | ---
backups[] | **[Backup](#Backup1)**<br>Requested list of backups. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListBackupsRequest.page_size](#ListBackupsRequest), use the `next_page_token` as the value for the [ListBackupsRequest.page_token](#ListBackupsRequest) parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### Backup {#Backup1}

Field | Description
--- | ---
id | **string**<br>ID of the backup. 
folder_id | **string**<br>ID of the folder that the backup belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format (i.e. when the backup operation was completed). 
source_cluster_id | **string**<br>ID of the Redis cluster that the backup was created for. 
started_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Start timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format (i.e. when the backup operation was started). 
source_shard_names[] | **string**<br>Shard names used as a source for backup. 


