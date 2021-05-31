---
editable: false
---

# ProjectService

A set of methods for managing Project resources.

| Call | Description |
| --- | --- |
| [Create](#Create) | Creates a project in the specified folder. |
| [Update](#Update) | Updates the specified project. |
| [Delete](#Delete) | Deletes the specified project. |
| [Open](#Open) | Opens the specified project. |
| [Get](#Get) | Returns the specified project. |
| [List](#List) | Lists projects for the specified folder. |

## Calls ProjectService {#calls}

## Create {#Create}

Creates a project in the specified folder.

**rpc Create ([CreateProjectRequest](#CreateProjectRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateProjectMetadata](#CreateProjectMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Project](#Project)<br>

### CreateProjectRequest {#CreateProjectRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to create a project in. To get the folder ID use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List) request. The maximum string length in characters is 50.
name | **string**<br>Name of the project. The maximum string length in characters is 63. Value must match the regular expression ` [a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
description | **string**<br>Description of the project. The maximum string length in characters is 256.
settings | **[Project.Settings](#Project)**<br>Settings of the project. 


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateProjectMetadata](#CreateProjectMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Project](#Project)>**<br>if operation finished successfully. 


### CreateProjectMetadata {#CreateProjectMetadata}

Field | Description
--- | ---
project_id | **string**<br>ID of the project that is being created. 


### Project {#Project}

Field | Description
--- | ---
id | **string**<br>ID of the project. 
folder_id | **string**<br>ID of the folder that the project belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
name | **string**<br>Name of the project. 1-63 characters long. 
description | **string**<br>Description of the project. 0-256 characters long. 
settings | **[Settings](#Settings)**<br>Settings of the project. 


### Settings {#Settings}

Field | Description
--- | ---
service_account_id | **string**<br>ID of the service account, on whose behalf all operations with clusters will be performed. 
subnet_id | **string**<br>ID of the subnet where the DataProc cluster resides. Currently only subnets created in the availability zone ru-central1-a are supported. 
data_proc_cluster_id | **string**<br>ID of the DataProc cluster. 
commit_mode | enum **CommitMode**<br>Commit mode that is assigned to the project. <ul><li>`STANDARD`: Commit happens after the execution of a cell or group of cells or after completion with an error.</li><li>`AUTO`: Commit happens periodically. Also, automatic saving of state occurs when switching to another type of computing resource.</li><ul/>


## Update {#Update}

Updates the specified project.

**rpc Update ([UpdateProjectRequest](#UpdateProjectRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateProjectMetadata](#UpdateProjectMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Project](#Project1)<br>

### UpdateProjectRequest {#UpdateProjectRequest}

Field | Description
--- | ---
project_id | **string**<br>Required. ID of the Project resource to update. To get the project ID use a [ProjectService.List](#List) request. The maximum string length in characters is 200.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Field mask that specifies which fields of the Project resource are going to be updated. 
name | **string**<br>Name of the project. The maximum string length in characters is 63. Value must match the regular expression ` [a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
description | **string**<br>Description of the project. The maximum string length in characters is 256.
settings | **[Project.Settings](#Project1)**<br>Settings of the project. 


### Operation {#Operation1}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateProjectMetadata](#UpdateProjectMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Project](#Project1)>**<br>if operation finished successfully. 


### UpdateProjectMetadata {#UpdateProjectMetadata}

Field | Description
--- | ---
project_id | **string**<br>ID of the project that is being updated. 


### Project {#Project1}

Field | Description
--- | ---
id | **string**<br>ID of the project. 
folder_id | **string**<br>ID of the folder that the project belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
name | **string**<br>Name of the project. 1-63 characters long. 
description | **string**<br>Description of the project. 0-256 characters long. 
settings | **[Settings](#Settings1)**<br>Settings of the project. 


### Settings {#Settings1}

Field | Description
--- | ---
service_account_id | **string**<br>ID of the service account, on whose behalf all operations with clusters will be performed. 
subnet_id | **string**<br>ID of the subnet where the DataProc cluster resides. Currently only subnets created in the availability zone ru-central1-a are supported. 
data_proc_cluster_id | **string**<br>ID of the DataProc cluster. 
commit_mode | enum **CommitMode**<br>Commit mode that is assigned to the project. <ul><li>`STANDARD`: Commit happens after the execution of a cell or group of cells or after completion with an error.</li><li>`AUTO`: Commit happens periodically. Also, automatic saving of state occurs when switching to another type of computing resource.</li><ul/>


## Delete {#Delete}

Deletes the specified project.

**rpc Delete ([DeleteProjectRequest](#DeleteProjectRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteProjectMetadata](#DeleteProjectMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteProjectRequest {#DeleteProjectRequest}

Field | Description
--- | ---
project_id | **string**<br>Required. ID of the Project resource to delete. To get the project ID use a [ProjectService.List](#List) request. The maximum string length in characters is 200.


### Operation {#Operation2}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteProjectMetadata](#DeleteProjectMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### DeleteProjectMetadata {#DeleteProjectMetadata}

Field | Description
--- | ---
project_id | **string**<br>ID of the project that is being deleted. 


## Open {#Open}

Opens the specified project.

**rpc Open ([OpenProjectRequest](#OpenProjectRequest)) returns ([operation.Operation](#Operation3))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[OpenProjectMetadata](#OpenProjectMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[OpenProjectResponse](#OpenProjectResponse)<br>

### OpenProjectRequest {#OpenProjectRequest}

Field | Description
--- | ---
project_id | **string**<br>Required. ID of the Project resource to open. To get the project ID use a [ProjectService.List](#List) request. The maximum string length in characters is 200.


### Operation {#Operation3}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[OpenProjectMetadata](#OpenProjectMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[OpenProjectResponse](#OpenProjectResponse)>**<br>if operation finished successfully. 


### OpenProjectMetadata {#OpenProjectMetadata}

Field | Description
--- | ---
project_id | **string**<br>ID of the project that is being opened. 


### OpenProjectResponse {#OpenProjectResponse}

Field | Description
--- | ---
project_url | **string**<br>URL of the project that is being opened. Make GET request to `project_url` with sessionToken query parameter equals to `session_token` or POST request to `project_url` with sessionToken body parameter equals to `session_token` to fetch Datasphere web interface 
session_token | **string**<br>Session token of the project that is being opened. 


## Get {#Get}

Returns the specified project.

**rpc Get ([GetProjectRequest](#GetProjectRequest)) returns ([Project](#Project2))**

### GetProjectRequest {#GetProjectRequest}

Field | Description
--- | ---
project_id | **string**<br>Required. ID of the Project resource to return. To get the project ID use a [ProjectService.List](#List) request. The maximum string length in characters is 200.


### Project {#Project2}

Field | Description
--- | ---
id | **string**<br>ID of the project. 
folder_id | **string**<br>ID of the folder that the project belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
name | **string**<br>Name of the project. 1-63 characters long. 
description | **string**<br>Description of the project. 0-256 characters long. 
settings | **[Settings](#Settings2)**<br>Settings of the project. 


### Settings {#Settings2}

Field | Description
--- | ---
service_account_id | **string**<br>ID of the service account, on whose behalf all operations with clusters will be performed. 
subnet_id | **string**<br>ID of the subnet where the DataProc cluster resides. Currently only subnets created in the availability zone ru-central1-a are supported. 
data_proc_cluster_id | **string**<br>ID of the DataProc cluster. 
commit_mode | enum **CommitMode**<br>Commit mode that is assigned to the project. <ul><li>`STANDARD`: Commit happens after the execution of a cell or group of cells or after completion with an error.</li><li>`AUTO`: Commit happens periodically. Also, automatic saving of state occurs when switching to another type of computing resource.</li><ul/>


## List {#List}

Lists projects for the specified folder.

**rpc List ([ListProjectsRequest](#ListProjectsRequest)) returns ([ListProjectsResponse](#ListProjectsResponse))**

### ListProjectsRequest {#ListProjectsRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to list projects in. To get the folder ID use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List) request. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListProjectsResponse.next_page_token](#ListProjectsResponse) that can be used to get the next page of results in subsequent list requests. Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListProjectsResponse.next_page_token](#ListProjectsResponse) returned by a previous list request. The maximum string length in characters is 100.


### ListProjectsResponse {#ListProjectsResponse}

Field | Description
--- | ---
projects[] | **[Project](#Project3)**<br>List of Project resources. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListProjectsRequest.page_size](#ListProjectsRequest), use the `next_page_token` as the value for the [ListProjectsRequest.page_token](#ListProjectsRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### Project {#Project3}

Field | Description
--- | ---
id | **string**<br>ID of the project. 
folder_id | **string**<br>ID of the folder that the project belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
name | **string**<br>Name of the project. 1-63 characters long. 
description | **string**<br>Description of the project. 0-256 characters long. 
settings | **[Settings](#Settings3)**<br>Settings of the project. 


### Settings {#Settings3}

Field | Description
--- | ---
service_account_id | **string**<br>ID of the service account, on whose behalf all operations with clusters will be performed. 
subnet_id | **string**<br>ID of the subnet where the DataProc cluster resides. Currently only subnets created in the availability zone ru-central1-a are supported. 
data_proc_cluster_id | **string**<br>ID of the DataProc cluster. 
commit_mode | enum **CommitMode**<br>Commit mode that is assigned to the project. <ul><li>`STANDARD`: Commit happens after the execution of a cell or group of cells or after completion with an error.</li><li>`AUTO`: Commit happens periodically. Also, automatic saving of state occurs when switching to another type of computing resource.</li><ul/>


