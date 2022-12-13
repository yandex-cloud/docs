---
editable: false
---

# DataSphere API v1, gRPC: ProjectService

A set of methods for managing Project resources.

| Call | Description |
| --- | --- |
| [Create](#Create) | Creates a project in the specified folder. |
| [Update](#Update) | Updates the specified project. |
| [Delete](#Delete) | Deletes the specified project. |
| [Open](#Open) | Opens the specified project. |
| [Get](#Get) | Returns the specified project. |
| [List](#List) | Lists projects for the specified folder. |
| [GetUnitBalance](#GetUnitBalance) | Returns the unit balance of the specified project. |
| [SetUnitBalance](#SetUnitBalance) | Sets the unit balance of the specified project. |
| [Execute](#Execute) | Executes code in the specified cell or notebook. |
| [GetCellOutputs](#GetCellOutputs) | Returns outputs of the specified cell. |
| [GetStateVariables](#GetStateVariables) | Returns state variables of the specified notebook. |
| [GetNotebookMetadata](#GetNotebookMetadata) | Returns metadata of the specified notebook. |

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
limits | **[Project.Limits](#Project)**<br>Limits of the project. 


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
limits | **[Limits](#Limits)**<br>Limits of the project. 


### Settings {#Settings}

Field | Description
--- | ---
service_account_id | **string**<br>ID of the service account, on whose behalf all operations with clusters will be performed. 
subnet_id | **string**<br>ID of the subnet where the DataProc cluster resides. Currently only subnets created in the availability zone ru-central1-a are supported. 
data_proc_cluster_id | **string**<br>ID of the DataProc cluster. 
commit_mode | enum **CommitMode**<br>Commit mode that is assigned to the project. <ul><li>`STANDARD`: Commit happens after the execution of a cell or group of cells or after completion with an error.</li><li>`AUTO`: Commit happens periodically. Also, automatic saving of state occurs when switching to another type of computing resource.</li></ul>
security_group_ids[] | **string**<br>Network interfaces security groups. 


### Limits {#Limits}

Field | Description
--- | ---
max_units_per_hour | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of units that can be spent per hour. 
max_units_per_execution | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of units that can be spent on the one execution. 


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
limits | **[Project.Limits](#Project1)**<br>Limits of the project. 


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
limits | **[Limits](#Limits1)**<br>Limits of the project. 


### Settings {#Settings1}

Field | Description
--- | ---
service_account_id | **string**<br>ID of the service account, on whose behalf all operations with clusters will be performed. 
subnet_id | **string**<br>ID of the subnet where the DataProc cluster resides. Currently only subnets created in the availability zone ru-central1-a are supported. 
data_proc_cluster_id | **string**<br>ID of the DataProc cluster. 
commit_mode | enum **CommitMode**<br>Commit mode that is assigned to the project. <ul><li>`STANDARD`: Commit happens after the execution of a cell or group of cells or after completion with an error.</li><li>`AUTO`: Commit happens periodically. Also, automatic saving of state occurs when switching to another type of computing resource.</li></ul>
security_group_ids[] | **string**<br>Network interfaces security groups. 


### Limits {#Limits1}

Field | Description
--- | ---
max_units_per_hour | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of units that can be spent per hour. 
max_units_per_execution | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of units that can be spent on the one execution. 


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
project_url | **string**<br>URL of the project that is being opened. Make GET request to `project_url` with sessionToken query parameter equals to `session_token` or POST request to `project_url` with sessionToken body parameter equals to `session_token` to fetch Datasphere web interface. 
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
limits | **[Limits](#Limits2)**<br>Limits of the project. 


### Settings {#Settings2}

Field | Description
--- | ---
service_account_id | **string**<br>ID of the service account, on whose behalf all operations with clusters will be performed. 
subnet_id | **string**<br>ID of the subnet where the DataProc cluster resides. Currently only subnets created in the availability zone ru-central1-a are supported. 
data_proc_cluster_id | **string**<br>ID of the DataProc cluster. 
commit_mode | enum **CommitMode**<br>Commit mode that is assigned to the project. <ul><li>`STANDARD`: Commit happens after the execution of a cell or group of cells or after completion with an error.</li><li>`AUTO`: Commit happens periodically. Also, automatic saving of state occurs when switching to another type of computing resource.</li></ul>
security_group_ids[] | **string**<br>Network interfaces security groups. 


### Limits {#Limits2}

Field | Description
--- | ---
max_units_per_hour | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of units that can be spent per hour. 
max_units_per_execution | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of units that can be spent on the one execution. 


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
limits | **[Limits](#Limits3)**<br>Limits of the project. 


### Settings {#Settings3}

Field | Description
--- | ---
service_account_id | **string**<br>ID of the service account, on whose behalf all operations with clusters will be performed. 
subnet_id | **string**<br>ID of the subnet where the DataProc cluster resides. Currently only subnets created in the availability zone ru-central1-a are supported. 
data_proc_cluster_id | **string**<br>ID of the DataProc cluster. 
commit_mode | enum **CommitMode**<br>Commit mode that is assigned to the project. <ul><li>`STANDARD`: Commit happens after the execution of a cell or group of cells or after completion with an error.</li><li>`AUTO`: Commit happens periodically. Also, automatic saving of state occurs when switching to another type of computing resource.</li></ul>
security_group_ids[] | **string**<br>Network interfaces security groups. 


### Limits {#Limits3}

Field | Description
--- | ---
max_units_per_hour | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of units that can be spent per hour. 
max_units_per_execution | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of units that can be spent on the one execution. 


## GetUnitBalance {#GetUnitBalance}

Returns the unit balance of the specified project.

**rpc GetUnitBalance ([GetUnitBalanceRequest](#GetUnitBalanceRequest)) returns ([GetUnitBalanceResponse](#GetUnitBalanceResponse))**

### GetUnitBalanceRequest {#GetUnitBalanceRequest}

Field | Description
--- | ---
project_id | **string**<br>Required. ID of the project to return the unit balance for. The maximum string length in characters is 200.


### GetUnitBalanceResponse {#GetUnitBalanceResponse}

Field | Description
--- | ---
unit_balance | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of units available to the project. 


## SetUnitBalance {#SetUnitBalance}

Sets the unit balance of the specified project.

**rpc SetUnitBalance ([SetUnitBalanceRequest](#SetUnitBalanceRequest)) returns ([google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty))**

### SetUnitBalanceRequest {#SetUnitBalanceRequest}

Field | Description
--- | ---
project_id | **string**<br>Required. ID of the project to set the unit balance for. The maximum string length in characters is 200.
unit_balance | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of units available to the project. 


## Execute {#Execute}

Executes code in the specified cell or notebook.

**rpc Execute ([ProjectExecutionRequest](#ProjectExecutionRequest)) returns ([operation.Operation](#Operation4))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[ProjectExecutionMetadata](#ProjectExecutionMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[ProjectExecutionResponse](#ProjectExecutionResponse)<br>

### ProjectExecutionRequest {#ProjectExecutionRequest}

Field | Description
--- | ---
project_id | **string**<br>Required. ID of the project to execute notebook/cell in. The maximum string length in characters is 200.
target | **oneof:** `notebook_id` or `cell_id`<br>
&nbsp;&nbsp;notebook_id | **string**<br>ID of the notebook to execute. The maximum string length in characters is 200.
&nbsp;&nbsp;cell_id | **string**<br>ID of the cell to execute. The maximum string length in characters is 200.
input_variables | **google.protobuf.Struct**<br>Values of input variables. 
output_variable_names[] | **string**<br>Names of output variables. 


### Operation {#Operation4}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[ProjectExecutionMetadata](#ProjectExecutionMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[ProjectExecutionResponse](#ProjectExecutionResponse)>**<br>if operation finished successfully. 


### ProjectExecutionMetadata {#ProjectExecutionMetadata}

Field | Description
--- | ---
project_id | **string**<br>ID of the project in which notebook is being executed. 
target | **oneof:** `notebook_id` or `cell_id`<br>
&nbsp;&nbsp;notebook_id | **string**<br>ID of the notebook that is being executed The maximum string length in characters is 200.
&nbsp;&nbsp;cell_id | **string**<br>ID of the cell that is being executed The maximum string length in characters is 200.


### ProjectExecutionResponse {#ProjectExecutionResponse}

Field | Description
--- | ---
checkpoint_id | **string**<br>ID of the checkpoint resulting from the execution. 
output_variables | **google.protobuf.Struct**<br>Values of output variables resulting from the execution. 


## GetCellOutputs {#GetCellOutputs}

Returns outputs of the specified cell.

**rpc GetCellOutputs ([CellOutputsRequest](#CellOutputsRequest)) returns ([CellOutputsResponse](#CellOutputsResponse))**

### CellOutputsRequest {#CellOutputsRequest}

Field | Description
--- | ---
project_id | **string**<br>Required. ID of the project to return cell outputs for. The maximum string length in characters is 200.
cell_id | **string**<br>Required. ID of the cell to return outputs for. The maximum string length in characters is 200.
checkpoint_id | **string**<br>ID of the checkpoint to return cell outputs for. 
start_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Timestamp from which to return outputs. 


### CellOutputsResponse {#CellOutputsResponse}

Field | Description
--- | ---
outputs[] | **string**<br>List of outputs. 


## GetStateVariables {#GetStateVariables}

Returns state variables of the specified notebook.

**rpc GetStateVariables ([GetStateVariablesRequest](#GetStateVariablesRequest)) returns ([GetStateVariablesResponse](#GetStateVariablesResponse))**

### GetStateVariablesRequest {#GetStateVariablesRequest}

Field | Description
--- | ---
project_id | **string**<br>Required. ID of the project, for which to return state variables. The maximum string length in characters is 200.
notebook_id | **string**<br>Required. ID of the notebook, for which to return state variables. The maximum string length in characters is 200.
variable_names[] | **string**<br>Names of variables to return. 
checkpoint_id | **string**<br>ID of the checkpoint, for which to return state variables. 


### GetStateVariablesResponse {#GetStateVariablesResponse}

Field | Description
--- | ---
variables | **google.protobuf.Struct**<br>Values of the specified variables. 


## GetNotebookMetadata {#GetNotebookMetadata}

Returns metadata of the specified notebook.

**rpc GetNotebookMetadata ([GetNotebookMetadataRequest](#GetNotebookMetadataRequest)) returns ([GetNotebookMetadataResponse](#GetNotebookMetadataResponse))**

### GetNotebookMetadataRequest {#GetNotebookMetadataRequest}

Field | Description
--- | ---
project_id | **string**<br>Required. ID of the project, for which to return notebook metadata. The maximum string length in characters is 200.
notebook_path | **string**<br>Required. Path of the notebook to get metadata. 


### GetNotebookMetadataResponse {#GetNotebookMetadataResponse}

Field | Description
--- | ---
notebook_id | **string**<br>ID of the specified notebook. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time the notebook was created. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time the notebook was modified last time. 
content_length | **int64**<br>Content length of the specified notebook. 
cell_ids[] | **string**<br>Cell ids of the specified notebook. 


