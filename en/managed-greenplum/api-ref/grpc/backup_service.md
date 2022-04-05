---
editable: false
sourcePath: en/_api-ref-grpc/managed-greenplum/api-ref/grpc/backup_service.md
---

# BackupService



| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specified backup of Greenplum® cluster. |
| [List](#List) | Returns the list of available backups for the specified Greenplum® cluster. |

## Calls BackupService {#calls}

## Get {#Get}

Returns the specified backup of Greenplum® cluster.

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
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format (i.e. when the backup operation was completed). 
source_cluster_id | **string**<br>ID of the PostgreSQL cluster that the backup was created for. 
started_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the backup operation was started. 
size | **int64**<br>Size of backup in bytes 


## List {#List}

Returns the list of available backups for the specified Greenplum® cluster.

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
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format (i.e. when the backup operation was completed). 
source_cluster_id | **string**<br>ID of the PostgreSQL cluster that the backup was created for. 
started_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the backup operation was started. 
size | **int64**<br>Size of backup in bytes 


