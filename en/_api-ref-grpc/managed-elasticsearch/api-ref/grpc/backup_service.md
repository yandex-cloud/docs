---
editable: false
---

# Managed Service for Elasticsearch API, gRPC: BackupService



| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specified backup of Elasticsearch cluster. |
| [List](#List) | Returns the list of available backups for the specified Elasticsearch cluster. |

## Calls BackupService {#calls}

## Get {#Get}

Returns the specified backup of Elasticsearch cluster.

**rpc Get ([GetBackupRequest](#GetBackupRequest)) returns ([Backup](#Backup))**

### GetBackupRequest {#GetBackupRequest}

Field | Description
--- | ---
backup_id | **string**<br>Required. Required. ID of the backup to return. 


### Backup {#Backup}

Field | Description
--- | ---
id | **string**<br>Required. ID of the backup. 
folder_id | **string**<br>ID of the folder that the backup belongs to. 
source_cluster_id | **string**<br>ID of the associated Elasticsearch cluster. 
started_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the backup operation was started. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the backup was created (i.e. when the backup operation completed). 
indices[] | **string**<br>Indices names. (max 100) The maximum number of elements is 100.
elasticsearch_version | **string**<br>Elasticsearch version used to create the snapshot 
size_bytes | **int64**<br>Total size of all indices in backup. in bytes 
indices_total | **int64**<br>Total count of indices in backup 


## List {#List}

Returns the list of available backups for the specified Elasticsearch cluster.

**rpc List ([ListBackupsRequest](#ListBackupsRequest)) returns ([ListBackupsResponse](#ListBackupsResponse))**

### ListBackupsRequest {#ListBackupsRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. Required. ID of the folder to list backups in. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page that should be returned. If the number of available results is larger than `page_size`, the service returns a `next_page_token` that can be used to get the next page of results in subsequent ListBackups requests. Acceptable values are 0 to 1000, inclusive. Default value: 100. Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br>Page token. Set `page_token` to the `next_page_token` returned by a previous ListBackups request to get the next page of results. The maximum string length in characters is 100.


### ListBackupsResponse {#ListBackupsResponse}

Field | Description
--- | ---
backups[] | **[Backup](#Backup1)**<br>Requested list of backups. 
next_page_token | **string**<br>This token allows you to get the next page of results for ListBackups requests, if the number of results is larger than `page_size` specified in the request. To get the next page, specify the value of `next_page_token` as a value for the `page_token` parameter in the next ListBackups request. Subsequent ListBackups requests will have their own `next_page_token` to continue paging through the results. 


### Backup {#Backup1}

Field | Description
--- | ---
id | **string**<br>Required. ID of the backup. 
folder_id | **string**<br>ID of the folder that the backup belongs to. 
source_cluster_id | **string**<br>ID of the associated Elasticsearch cluster. 
started_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the backup operation was started. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the backup was created (i.e. when the backup operation completed). 
indices[] | **string**<br>Indices names. (max 100) The maximum number of elements is 100.
elasticsearch_version | **string**<br>Elasticsearch version used to create the snapshot 
size_bytes | **int64**<br>Total size of all indices in backup. in bytes 
indices_total | **int64**<br>Total count of indices in backup 


