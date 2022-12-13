---
editable: false
sourcePath: en/_api-ref-grpc/managed-mysql/api-ref/grpc/database_service.md
---

# Managed Service for MySQL API, gRPC: DatabaseService

A set of methods for managing MySQL databases in a cluster. 

See [the documentation](/docs/managed-mysql/operations/databases) for details.

| Call | Description |
| --- | --- |
| [Get](#Get) | Retrieves information about the specified database. |
| [List](#List) | Retrieves the list of databases in a cluster. |
| [Create](#Create) | Creates a new database in a cluster. |
| [Delete](#Delete) | Deletes a database from a cluster. |

## Calls DatabaseService {#calls}

## Get {#Get}

Retrieves information about the specified database.

**rpc Get ([GetDatabaseRequest](#GetDatabaseRequest)) returns ([Database](#Database))**

### GetDatabaseRequest {#GetDatabaseRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the cluster that the database belongs to. <br>To get this ID, make a [ClusterService.List](./cluster_service#List) request. The maximum string length in characters is 50.
database_name | **string**<br>Required. Name of the database to return information about. <br>To get this name, make a [DatabaseService.List](#List) request. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.


### Database {#Database}

Field | Description
--- | ---
name | **string**<br>Name of the database. 
cluster_id | **string**<br>ID of the cluster that the database belongs to. 


## List {#List}

Retrieves the list of databases in a cluster.

**rpc List ([ListDatabasesRequest](#ListDatabasesRequest)) returns ([ListDatabasesResponse](#ListDatabasesResponse))**

### ListDatabasesRequest {#ListDatabasesRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the cluster to list databases in. <br>To get this ID, make a [ClusterService.List](./cluster_service#List) request. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. <br>If the number of available results is larger than `page_size`, the API returns a [ListDatabasesResponse.next_page_token](#ListDatabasesResponse) that can be used to get the next page of results in the subsequent [DatabaseService.List](#List) requests. Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br>Page token that can be used to iterate through multiple pages of results. <br>To get the next page of results, set `page_token` to the [ListDatabasesResponse.next_page_token](#ListDatabasesResponse) returned by the previous [DatabaseService.List](#List) request. The maximum string length in characters is 100.


### ListDatabasesResponse {#ListDatabasesResponse}

Field | Description
--- | ---
databases[] | **[Database](#Database1)**<br>List of databases. 
next_page_token | **string**<br>The token that can be used to get the next page of results. <br>If the number of results is larger than [ListDatabasesRequest.page_size](#ListDatabasesRequest), use the `next_page_token` as the value for the [ListDatabasesRequest.page_token](#ListDatabasesRequest) in the subsequent [DatabaseService.List](#List) request to iterate through multiple pages of results. <br>Each of the subsequent [DatabaseService.List](#List) requests should use the `next_page_token` value returned by the previous request to continue paging through the results. 


### Database {#Database1}

Field | Description
--- | ---
name | **string**<br>Name of the database. 
cluster_id | **string**<br>ID of the cluster that the database belongs to. 


## Create {#Create}

Creates a new database in a cluster.

**rpc Create ([CreateDatabaseRequest](#CreateDatabaseRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateDatabaseMetadata](#CreateDatabaseMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Database](#Database2)<br>

### CreateDatabaseRequest {#CreateDatabaseRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the cluster to create the database in. <br>To get this ID, make a [ClusterService.List](./cluster_service#List) request. The maximum string length in characters is 50.
database_spec | **[DatabaseSpec](#DatabaseSpec)**<br>Required. Configuration of the database. 


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
cluster_id | **string**<br>ID of the cluster the database is being created in. 
database_name | **string**<br>Name of the database that is being created. 


### Database {#Database2}

Field | Description
--- | ---
name | **string**<br>Name of the database. 
cluster_id | **string**<br>ID of the cluster that the database belongs to. 


## Delete {#Delete}

Deletes a database from a cluster.

**rpc Delete ([DeleteDatabaseRequest](#DeleteDatabaseRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteDatabaseMetadata](#DeleteDatabaseMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteDatabaseRequest {#DeleteDatabaseRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the cluster to delete the database from. <br>To get this ID, make a [ClusterService.List](./cluster_service#List) request. The maximum string length in characters is 50.
database_name | **string**<br>Required. Name of the database to delete. <br>To get this name, make a [DatabaseService.List](#List) request. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.


### Operation {#Operation1}

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
cluster_id | **string**<br>ID of the cluster the database is being deleted from. 
database_name | **string**<br>Name of the database that is being deleted. 


