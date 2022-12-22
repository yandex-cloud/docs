---
editable: false
---

# Managed Service for SQL Server API, gRPC: DatabaseService

A set of methods for managing SQL Server databases.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specified SQL Server database. |
| [List](#List) | Retrieves the list of SQL Server databases in the specified cluster. |
| [Create](#Create) | Creates a new SQL Server database in the specified cluster. |
| [Restore](#Restore) | Creates a new SQL Server database in the specified cluster from a backup. |
| [ImportBackup](#ImportBackup) | Imports a new SQL Server database from an external backup. |
| [ExportBackup](#ExportBackup) | Exports the last database backup to an external backup. |
| [Delete](#Delete) | Deletes the specified SQL Server database. |

## Calls DatabaseService {#calls}

## Get {#Get}

Returns the specified SQL Server database. <br>To get the list of available SQL Server databases, make a [List](#List) request.

**rpc Get ([GetDatabaseRequest](#GetDatabaseRequest)) returns ([Database](#Database))**

### GetDatabaseRequest {#GetDatabaseRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the SQL Server cluster the database belongs to. <br>To get the cluster ID, use a [ClusterService.List](./cluster_service#List) request. The maximum string length in characters is 50.
database_name | **string**<br>Required. Name of the SQL Server database to return. <br>To get the name of the database use a [DatabaseService.List](#List) request. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.


### Database {#Database}

Field | Description
--- | ---
name | **string**<br>Name of the database. 
cluster_id | **string**<br>ID of the SQL Server cluster that the database belongs to. 


## List {#List}

Retrieves the list of SQL Server databases in the specified cluster.

**rpc List ([ListDatabasesRequest](#ListDatabasesRequest)) returns ([ListDatabasesResponse](#ListDatabasesResponse))**

### ListDatabasesRequest {#ListDatabasesRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the SQL Server cluster to list databases in. <br>To get the cluster ID, use a [ClusterService.List](./cluster_service#List) request. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. <br>If the number of available results is larger than `page_size`, the service returns a [ListDatabasesResponse.next_page_token](#ListDatabasesResponse) that can be used to get the next page of results in subsequent list requests. Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListDatabasesResponse.next_page_token](#ListDatabasesResponse) returned by the previous list request. The maximum string length in characters is 100.


### ListDatabasesResponse {#ListDatabasesResponse}

Field | Description
--- | ---
databases[] | **[Database](#Database1)**<br>List of SQL Server databases. 
next_page_token | **string**<br>Token that allows you to get the next page of results for list requests. <br>If the number of results is larger than [ListDatabasesRequest.page_size](#ListDatabasesRequest), use the `next_page_token` as the value for the [ListDatabasesRequest.page_token](#ListDatabasesRequest) parameter in the next list request. <br>Each subsequent list request has its own `next_page_token` to continue paging through the results. 


### Database {#Database1}

Field | Description
--- | ---
name | **string**<br>Name of the database. 
cluster_id | **string**<br>ID of the SQL Server cluster that the database belongs to. 


## Create {#Create}

Creates a new SQL Server database in the specified cluster.

**rpc Create ([CreateDatabaseRequest](#CreateDatabaseRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateDatabaseMetadata](#CreateDatabaseMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Database](#Database2)<br>

### CreateDatabaseRequest {#CreateDatabaseRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the SQL Server cluster to create a database in. <br>To get the cluster ID, use a [ClusterService.List](./cluster_service#List) request. The maximum string length in characters is 50.
database_spec | **[DatabaseSpec](#DatabaseSpec)**<br>Required. Configuration of the database to create. 


### DatabaseSpec {#DatabaseSpec}

Field | Description
--- | ---
name | **string**<br>Required. Name of the database. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateDatabaseMetadata](#CreateDatabaseMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Database](#Database2)>**<br>if operation finished successfully. 


### CreateDatabaseMetadata {#CreateDatabaseMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>ID of the SQL Server cluster where the database is being created. 
database_name | **string**<br>Name of the SQL Server database being created. 


### Database {#Database2}

Field | Description
--- | ---
name | **string**<br>Name of the database. 
cluster_id | **string**<br>ID of the SQL Server cluster that the database belongs to. 


## Restore {#Restore}

Creates a new SQL Server database in the specified cluster from a backup.

**rpc Restore ([RestoreDatabaseRequest](#RestoreDatabaseRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[RestoreDatabaseMetadata](#RestoreDatabaseMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Database](#Database3)<br>

### RestoreDatabaseRequest {#RestoreDatabaseRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the SQL Server cluster to restore a database in. <br>To get the cluster ID, use a [ClusterService.List](./cluster_service#List) request. The maximum string length in characters is 50.
database_name | **string**<br>Required. Name of the SQL Server database that is being restored. 
from_database | **string**<br>Required. Name of the database which backup is used to restore the database. 
backup_id | **string**<br>Required. ID of a backup to be used. 
time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Required. Timestamp which is used for Point-in-Time recovery. 


### Operation {#Operation1}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[RestoreDatabaseMetadata](#RestoreDatabaseMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Database](#Database3)>**<br>if operation finished successfully. 


### RestoreDatabaseMetadata {#RestoreDatabaseMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the SQL Server cluster where a database is being created. 
database_name | **string**<br>Required. Name of an SQL Server database that is being created. 
from_database | **string**<br>Required. Name of the database which backup is used to restore the database. 
backup_id | **string**<br>Required. ID of a backup to be used. 


### Database {#Database3}

Field | Description
--- | ---
name | **string**<br>Name of the database. 
cluster_id | **string**<br>ID of the SQL Server cluster that the database belongs to. 


## ImportBackup {#ImportBackup}

Imports a new SQL Server database from an external backup.

**rpc ImportBackup ([ImportDatabaseBackupRequest](#ImportDatabaseBackupRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[ImportDatabaseBackupMetadata](#ImportDatabaseBackupMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Database](#Database4)<br>

### ImportDatabaseBackupRequest {#ImportDatabaseBackupRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the SQL Server cluster to import a database in. <br>To get the cluster ID, use a [ClusterService.List](./cluster_service#List) request. The maximum string length in characters is 50.
database_name | **string**<br>Required. Name of the SQL Server database that is being imported. 
s3_bucket | **string**<br>Required. Name of object storage bucket to import backups from. 
s3_path | **string**<br>Path in object storage bucket to import backups from. 
files[] | **string**<br>Required. List of .bak files in bucket containing database backup. 


### Operation {#Operation2}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[ImportDatabaseBackupMetadata](#ImportDatabaseBackupMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Database](#Database4)>**<br>if operation finished successfully. 


### ImportDatabaseBackupMetadata {#ImportDatabaseBackupMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the SQL Server cluster where a database is being imported. 
database_name | **string**<br>Required. Name of the SQL Server database that is being imported. 
s3_bucket | **string**<br>Required. Name of object storage bucket to import backups from. 
s3_path | **string**<br>Path in object storage bucket to import backups from. 


### Database {#Database4}

Field | Description
--- | ---
name | **string**<br>Name of the database. 
cluster_id | **string**<br>ID of the SQL Server cluster that the database belongs to. 


## ExportBackup {#ExportBackup}

Exports the last database backup to an external backup.

**rpc ExportBackup ([ExportDatabaseBackupRequest](#ExportDatabaseBackupRequest)) returns ([operation.Operation](#Operation3))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[ExportDatabaseBackupMetadata](#ExportDatabaseBackupMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Database](#Database5)<br>

### ExportDatabaseBackupRequest {#ExportDatabaseBackupRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the SQL Server cluster to export a database from. <br>To get the cluster ID, use a [ClusterService.List](./cluster_service#List) request. The maximum string length in characters is 50.
database_name | **string**<br>Required. Name of the SQL Server database that is being exported. 
s3_bucket | **string**<br>Required. Name of object storage bucket to export backups to. 
s3_path | **string**<br>Path in object storage bucket to export backups to. 
prefix | **string**<br>Prefix for .bak files to export. 


### Operation {#Operation3}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[ExportDatabaseBackupMetadata](#ExportDatabaseBackupMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Database](#Database5)>**<br>if operation finished successfully. 


### ExportDatabaseBackupMetadata {#ExportDatabaseBackupMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the SQL Server cluster where a database is being exported. 
database_name | **string**<br>Required. Name of the SQL Server database that is being exported. 
s3_bucket | **string**<br>Required. Name of object storage bucket to export backups to. 
s3_path | **string**<br>Path in object storage bucket to export backups to. 


### Database {#Database5}

Field | Description
--- | ---
name | **string**<br>Name of the database. 
cluster_id | **string**<br>ID of the SQL Server cluster that the database belongs to. 


## Delete {#Delete}

Deletes the specified SQL Server database.

**rpc Delete ([DeleteDatabaseRequest](#DeleteDatabaseRequest)) returns ([operation.Operation](#Operation4))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteDatabaseMetadata](#DeleteDatabaseMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteDatabaseRequest {#DeleteDatabaseRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the SQL Server cluster to delete a database in. <br>To get the cluster ID, use a [ClusterService.List](./cluster_service#List) request. The maximum string length in characters is 50.
database_name | **string**<br>Required. Name of the database to delete. <br>To get the name of the database, use a [DatabaseService.List](#List) request. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.


### Operation {#Operation4}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteDatabaseMetadata](#DeleteDatabaseMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### DeleteDatabaseMetadata {#DeleteDatabaseMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>ID of the SQL Server cluster where the database is being deleted. 
database_name | **string**<br>Name of the SQL Server database being deleted. 


