---
editable: false
---

# DatabaseService

A set of methods for managing PostgreSQL Database resources.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specified PostgreSQL Database resource. |
| [List](#List) | Retrieves the list of PostgreSQL Database resources in the specified cluster. |
| [Create](#Create) | Creates a new PostgreSQL database in the specified cluster. |
| [Update](#Update) | Updates the specified PostgreSQL database. |
| [Delete](#Delete) | Deletes the specified PostgreSQL database. |

## Calls DatabaseService {#calls}

## Get {#Get}

Returns the specified PostgreSQL Database resource. <br>To get the list of available PostgreSQL Database resources, make a [List](#List) request.

**rpc Get ([GetDatabaseRequest](#GetDatabaseRequest)) returns ([Database](#Database))**

### GetDatabaseRequest {#GetDatabaseRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the PostgreSQL cluster that the database belongs to. To get the cluster ID use a [ClusterService.List](./cluster_service#List) request. The maximum string length in characters is 50.
database_name | **string**<br>Required. Name of the PostgreSQL Database resource to return. To get the name of the database use a [DatabaseService.List](#List) request. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.


### Database {#Database}

Field | Description
--- | ---
name | **string**<br>Name of the database. 
cluster_id | **string**<br>ID of the PostgreSQL cluster that the database belongs to. 
owner | **string**<br>Name of the user assigned as the owner of the database. 
lc_collate | **string**<br>POSIX locale for string sorting order. Can only be set at creation time. 
lc_ctype | **string**<br>POSIX locale for character classification. Can only be set at creation time. 
extensions[] | **[Extension](#Extension)**<br>PostgreSQL extensions enabled for the database. 
template_db | **string**<br>Name of the database template. 


### Extension {#Extension}

Field | Description
--- | ---
name | **string**<br>Name of the extension, e.g. `pg_trgm` or `pg_btree`. Extensions supported by Managed Service for PostgreSQL are [listed in the Developer's Guide](/docs/managed-postgresql/operations/cluster-extensions). 
version | **string**<br>Version of the extension. 


## List {#List}

Retrieves the list of PostgreSQL Database resources in the specified cluster.

**rpc List ([ListDatabasesRequest](#ListDatabasesRequest)) returns ([ListDatabasesResponse](#ListDatabasesResponse))**

### ListDatabasesRequest {#ListDatabasesRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the PostgreSQL cluster to list databases in. To get the cluster ID use a [ClusterService.List](./cluster_service#List) request. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListDatabasesResponse.next_page_token](#ListDatabasesResponse) that can be used to get the next page of results in subsequent list requests. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, Set `page_token` to the [ListDatabasesResponse.next_page_token](#ListDatabasesResponse) returned by the previous list request. The maximum string length in characters is 100.


### ListDatabasesResponse {#ListDatabasesResponse}

Field | Description
--- | ---
databases[] | **[Database](#Database1)**<br>List of PostgreSQL Database resources. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListDatabasesRequest.page_size](#ListDatabasesRequest), use the `next_page_token` as the value for the [ListDatabasesRequest.page_token](#ListDatabasesRequest) parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### Database {#Database1}

Field | Description
--- | ---
name | **string**<br>Name of the database. 
cluster_id | **string**<br>ID of the PostgreSQL cluster that the database belongs to. 
owner | **string**<br>Name of the user assigned as the owner of the database. 
lc_collate | **string**<br>POSIX locale for string sorting order. Can only be set at creation time. 
lc_ctype | **string**<br>POSIX locale for character classification. Can only be set at creation time. 
extensions[] | **[Extension](#Extension1)**<br>PostgreSQL extensions enabled for the database. 
template_db | **string**<br>Name of the database template. 


### Extension {#Extension1}

Field | Description
--- | ---
name | **string**<br>Name of the extension, e.g. `pg_trgm` or `pg_btree`. Extensions supported by Managed Service for PostgreSQL are [listed in the Developer's Guide](/docs/managed-postgresql/operations/cluster-extensions). 
version | **string**<br>Version of the extension. 


## Create {#Create}

Creates a new PostgreSQL database in the specified cluster.

**rpc Create ([CreateDatabaseRequest](#CreateDatabaseRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateDatabaseMetadata](#CreateDatabaseMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Database](#Database2)<br>

### CreateDatabaseRequest {#CreateDatabaseRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the PostgreSQL cluster to create a database in. To get the cluster ID use a [ClusterService.List](./cluster_service#List) request. The maximum string length in characters is 50.
database_spec | **[DatabaseSpec](#DatabaseSpec)**<br>Required. Configuration of the database to create. 


### DatabaseSpec {#DatabaseSpec}

Field | Description
--- | ---
name | **string**<br>Required. Name of the PostgreSQL database. 1-63 characters long. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
owner | **string**<br>Required. Name of the user to be assigned as the owner of the database. To get the list of available PostgreSQL users, make a [UserService.List](./user_service#List) request. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_]* `.
lc_collate | **string**<br>POSIX locale for string sorting order. Can only be set at creation time. Value must match the regular expression ` \|[a-zA-Z_]+.UTF-8\|C `.
lc_ctype | **string**<br>POSIX locale for character classification. Can only be set at creation time. Value must match the regular expression ` \|[a-zA-Z_]+.UTF-8\|C `.
extensions[] | **[Extension](#Extension2)**<br>PostgreSQL extensions to be enabled for the database. 
template_db | **string**<br>Name of the PostgreSQL database template. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.


### Extension {#Extension2}

Field | Description
--- | ---
name | **string**<br>Name of the extension, e.g. `pg_trgm` or `pg_btree`. Extensions supported by Managed Service for PostgreSQL are [listed in the Developer's Guide](/docs/managed-postgresql/operations/cluster-extensions). 
version | **string**<br>Version of the extension. 


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
cluster_id | **string**<br>ID of the PostgreSQL cluster where a database is being created. 
database_name | **string**<br>Name of the PostgreSQL database that is being created. 


### Database {#Database2}

Field | Description
--- | ---
name | **string**<br>Name of the database. 
cluster_id | **string**<br>ID of the PostgreSQL cluster that the database belongs to. 
owner | **string**<br>Name of the user assigned as the owner of the database. 
lc_collate | **string**<br>POSIX locale for string sorting order. Can only be set at creation time. 
lc_ctype | **string**<br>POSIX locale for character classification. Can only be set at creation time. 
extensions[] | **[Extension](#Extension3)**<br>PostgreSQL extensions enabled for the database. 
template_db | **string**<br>Name of the database template. 


### Extension {#Extension3}

Field | Description
--- | ---
name | **string**<br>Name of the extension, e.g. `pg_trgm` or `pg_btree`. Extensions supported by Managed Service for PostgreSQL are [listed in the Developer's Guide](/docs/managed-postgresql/operations/cluster-extensions). 
version | **string**<br>Version of the extension. 


## Update {#Update}

Updates the specified PostgreSQL database.

**rpc Update ([UpdateDatabaseRequest](#UpdateDatabaseRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateDatabaseMetadata](#UpdateDatabaseMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Database](#Database3)<br>

### UpdateDatabaseRequest {#UpdateDatabaseRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the PostgreSQL cluster to update a database in. To get the cluster ID use a [ClusterService.List](./cluster_service#List) request. The maximum string length in characters is 50.
database_name | **string**<br>Required. Name of the database to update. To get the name of the database use a [DatabaseService.List](#List) request. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Field mask that specifies which fields of the Database resource should be updated. 
extensions[] | **[Extension](#Extension4)**<br>PostgreSQL extensions that should be enabled for the database. <br>If the field is sent, the list of enabled extensions is rewritten entirely. Therefore, to disable an active extension you should simply send the list omitting this extension. 


### Extension {#Extension4}

Field | Description
--- | ---
name | **string**<br>Name of the extension, e.g. `pg_trgm` or `pg_btree`. Extensions supported by Managed Service for PostgreSQL are [listed in the Developer's Guide](/docs/managed-postgresql/operations/cluster-extensions). 
version | **string**<br>Version of the extension. 


### Operation {#Operation1}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateDatabaseMetadata](#UpdateDatabaseMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Database](#Database3)>**<br>if operation finished successfully. 


### UpdateDatabaseMetadata {#UpdateDatabaseMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>ID of the PostgreSQL cluster where a database is being updated. 
database_name | **string**<br>Name of the PostgreSQL database that is being updated. 


### Database {#Database3}

Field | Description
--- | ---
name | **string**<br>Name of the database. 
cluster_id | **string**<br>ID of the PostgreSQL cluster that the database belongs to. 
owner | **string**<br>Name of the user assigned as the owner of the database. 
lc_collate | **string**<br>POSIX locale for string sorting order. Can only be set at creation time. 
lc_ctype | **string**<br>POSIX locale for character classification. Can only be set at creation time. 
extensions[] | **[Extension](#Extension5)**<br>PostgreSQL extensions enabled for the database. 
template_db | **string**<br>Name of the database template. 


### Extension {#Extension5}

Field | Description
--- | ---
name | **string**<br>Name of the extension, e.g. `pg_trgm` or `pg_btree`. Extensions supported by Managed Service for PostgreSQL are [listed in the Developer's Guide](/docs/managed-postgresql/operations/cluster-extensions). 
version | **string**<br>Version of the extension. 


## Delete {#Delete}

Deletes the specified PostgreSQL database.

**rpc Delete ([DeleteDatabaseRequest](#DeleteDatabaseRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteDatabaseMetadata](#DeleteDatabaseMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteDatabaseRequest {#DeleteDatabaseRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the PostgreSQL cluster to delete a database in. To get the cluster ID, use a [ClusterService.List](./cluster_service#List) request. The maximum string length in characters is 50.
database_name | **string**<br>Required. Name of the database to delete. To get the name of the database, use a [DatabaseService.List](#List) request. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.


### Operation {#Operation2}

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
cluster_id | **string**<br>ID of the PostgreSQL cluster where a database is being deleted. 
database_name | **string**<br>Name of the PostgreSQL database that is being deleted. 


