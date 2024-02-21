---
editable: false
sourcePath: en/_api-ref-grpc/datasphere/v2/api-ref/grpc/project_service.md
---

# DataSphere API v2, gRPC: ProjectService

A set of methods for managing Project resources.

| Call | Description |
| --- | --- |
| [Create](#Create) | Creates a project in the specified folder. |
| [Update](#Update) | Updates the specified project. |
| [Delete](#Delete) | Deletes the specified project. |
| [Open](#Open) | Opens the specified project. |
| [Get](#Get) | Returns the specified project. |
| [List](#List) | Lists projects for the specified community. |
| [GetUnitBalance](#GetUnitBalance) | Returns the unit balance of the specified project. |
| [SetUnitBalance](#SetUnitBalance) | Sets the unit balance of the specified project. |
| [Execute](#Execute) | Executes code in the specified cell or notebook. |
| [GetCellOutputs](#GetCellOutputs) | Returns outputs of the specified cell. |
| [GetStateVariables](#GetStateVariables) | Returns state variables of the specified notebook. |
| [ListAccessBindings](#ListAccessBindings) | Lists access bindings for the project. |
| [SetAccessBindings](#SetAccessBindings) | Sets access bindings for the project. |
| [UpdateAccessBindings](#UpdateAccessBindings) | Updates access bindings for the project. |
| [AddResource](#AddResource) | Adds shared resource to project |
| [RemoveResource](#RemoveResource) | Removes shared resource from project |

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
community_id | **string**<br>Required. ID of the community to create a project in. The maximum string length in characters is 50.
name | **string**<br>Name of the project. 0-63 characters long. The maximum string length in characters is 63. Value must match the regular expression ` [a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
description | **string**<br>Description of the project. 0-256 characters long. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Labels of the project. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
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
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
name | **string**<br>Name of the project. 1-63 characters long. 
description | **string**<br>Description of the project. 0-256 characters long. 
labels | **map<string,string>**<br> 
created_by_id | **string**<br> 
settings | **[Settings](#Settings)**<br>Settings of the project. 
limits | **[Limits](#Limits)**<br>Limits of the project. 
community_id | **string**<br>ID of the community that the project belongs to. 


### Settings {#Settings}

Field | Description
--- | ---
service_account_id | **string**<br>ID of the service account, on whose behalf all operations with clusters will be performed. 
subnet_id | **string**<br>ID of the subnet where the DataProc cluster resides. Currently only subnets created in the availability zone ru-central1-a are supported. 
data_proc_cluster_id | **string**<br>ID of the DataProc cluster. 
commit_mode | enum **CommitMode**<br>Commit mode that is assigned to the project. <ul><li>`STANDARD`: Commit happens after the execution of a cell or group of cells or after completion with an error.</li><li>`AUTO`: Commit happens periodically. Also, automatic saving of state occurs when switching to another type of computing resource.</li></ul>
security_group_ids[] | **string**<br>Network interfaces security groups. 
early_access | **bool**<br>Is early access preview enabled for the project. 
ide | enum **Ide**<br>Project IDE. <ul><li>`JUPYTER_LAB`: Project running on JupyterLab IDE.</li></ul>
default_folder_id | **string**<br>Default project folder ID. 
stale_exec_timeout_mode | enum **StaleExecutionTimeoutMode**<br>Timeout to automatically stop stale executions. <ul><li>`ONE_HOUR`: Setting to automatically stop stale execution after one hour with low consumption.</li><li>`THREE_HOURS`: Setting to automatically stop stale execution after three hours with low consumption.</li><li>`NO_TIMEOUT`: Setting to never automatically stop stale executions.</li></ul>
ide_execution_mode | enum **IdeExecutionMode**<br>VM allocation mode. <ul><li>`SERVERLESS`: VM is allocated for specific execution and deallocated after the execution ends.</li><li>`DEDICATED`: VM is allocated at the first execution and stays allocated until manually deallocated. Or until timeout exceeded.</li></ul>
vm_inactivity_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Timeout for VM deallocation. 
default_dedicated_spec | **string**<br>Default VM configuration for DEDICATED mode. 


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
project_id | **string**<br>Required. ID of the Project resource to update. To get the project ID use a [ProjectService.List](#List) request. The maximum string length in characters is 50.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Field mask that specifies which fields of the Project resource are going to be updated. 
name | **string**<br>Name of the project. 0-63 characters long. The maximum string length in characters is 63. Value must match the regular expression ` [a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
description | **string**<br>Description of the project. 0-256 characters long. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Labels of the project. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
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
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
name | **string**<br>Name of the project. 1-63 characters long. 
description | **string**<br>Description of the project. 0-256 characters long. 
labels | **map<string,string>**<br> 
created_by_id | **string**<br> 
settings | **[Settings](#Settings1)**<br>Settings of the project. 
limits | **[Limits](#Limits1)**<br>Limits of the project. 
community_id | **string**<br>ID of the community that the project belongs to. 


### Settings {#Settings1}

Field | Description
--- | ---
service_account_id | **string**<br>ID of the service account, on whose behalf all operations with clusters will be performed. 
subnet_id | **string**<br>ID of the subnet where the DataProc cluster resides. Currently only subnets created in the availability zone ru-central1-a are supported. 
data_proc_cluster_id | **string**<br>ID of the DataProc cluster. 
commit_mode | enum **CommitMode**<br>Commit mode that is assigned to the project. <ul><li>`STANDARD`: Commit happens after the execution of a cell or group of cells or after completion with an error.</li><li>`AUTO`: Commit happens periodically. Also, automatic saving of state occurs when switching to another type of computing resource.</li></ul>
security_group_ids[] | **string**<br>Network interfaces security groups. 
early_access | **bool**<br>Is early access preview enabled for the project. 
ide | enum **Ide**<br>Project IDE. <ul><li>`JUPYTER_LAB`: Project running on JupyterLab IDE.</li></ul>
default_folder_id | **string**<br>Default project folder ID. 
stale_exec_timeout_mode | enum **StaleExecutionTimeoutMode**<br>Timeout to automatically stop stale executions. <ul><li>`ONE_HOUR`: Setting to automatically stop stale execution after one hour with low consumption.</li><li>`THREE_HOURS`: Setting to automatically stop stale execution after three hours with low consumption.</li><li>`NO_TIMEOUT`: Setting to never automatically stop stale executions.</li></ul>
ide_execution_mode | enum **IdeExecutionMode**<br>VM allocation mode. <ul><li>`SERVERLESS`: VM is allocated for specific execution and deallocated after the execution ends.</li><li>`DEDICATED`: VM is allocated at the first execution and stays allocated until manually deallocated. Or until timeout exceeded.</li></ul>
vm_inactivity_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Timeout for VM deallocation. 
default_dedicated_spec | **string**<br>Default VM configuration for DEDICATED mode. 


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
project_id | **string**<br>Required. ID of the Project resource to delete. To get the project ID use a [ProjectService.List](#List) request. The maximum string length in characters is 50.


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
project_id | **string**<br>Required. ID of the Project resource to open. To get the project ID use a [ProjectService.List](#List) request. The maximum string length in characters is 50.


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
status | enum **OpenProjectStatus**<br>Project opening status. <ul><li>`OPEN_PROJECT_STATUS_CLOSING_IDE`: Closing previous IDE instance.</li><li>`OPEN_PROJECT_STATUS_UNZIPPING_PROJECT`: Unzipping project.</li><li>`OPEN_PROJECT_STATUS_ALLOCATING_VM`: Allocating VM for the project.</li><li>`OPEN_PROJECT_STATUS_ALLOCATING_RESOURCES`: Allocating resources for the project.</li><li>`OPEN_PROJECT_STATUS_STARTING_IDE`: Starting IDE.</li><li>`OPEN_PROJECT_STATUS_APPLYING_CHECKPOINT`: Applying checkpoint to project.</li><li>`OPEN_PROJECT_STATUS_UNKNOWN`: Unknown open project status.</li></ul>


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
project_id | **string**<br>Required. ID of the Project resource to return. To get the project ID use a [ProjectService.List](#List) request. The maximum string length in characters is 50.


### Project {#Project2}

Field | Description
--- | ---
id | **string**<br>ID of the project. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
name | **string**<br>Name of the project. 1-63 characters long. 
description | **string**<br>Description of the project. 0-256 characters long. 
labels | **map<string,string>**<br> 
created_by_id | **string**<br> 
settings | **[Settings](#Settings2)**<br>Settings of the project. 
limits | **[Limits](#Limits2)**<br>Limits of the project. 
community_id | **string**<br>ID of the community that the project belongs to. 


### Settings {#Settings2}

Field | Description
--- | ---
service_account_id | **string**<br>ID of the service account, on whose behalf all operations with clusters will be performed. 
subnet_id | **string**<br>ID of the subnet where the DataProc cluster resides. Currently only subnets created in the availability zone ru-central1-a are supported. 
data_proc_cluster_id | **string**<br>ID of the DataProc cluster. 
commit_mode | enum **CommitMode**<br>Commit mode that is assigned to the project. <ul><li>`STANDARD`: Commit happens after the execution of a cell or group of cells or after completion with an error.</li><li>`AUTO`: Commit happens periodically. Also, automatic saving of state occurs when switching to another type of computing resource.</li></ul>
security_group_ids[] | **string**<br>Network interfaces security groups. 
early_access | **bool**<br>Is early access preview enabled for the project. 
ide | enum **Ide**<br>Project IDE. <ul><li>`JUPYTER_LAB`: Project running on JupyterLab IDE.</li></ul>
default_folder_id | **string**<br>Default project folder ID. 
stale_exec_timeout_mode | enum **StaleExecutionTimeoutMode**<br>Timeout to automatically stop stale executions. <ul><li>`ONE_HOUR`: Setting to automatically stop stale execution after one hour with low consumption.</li><li>`THREE_HOURS`: Setting to automatically stop stale execution after three hours with low consumption.</li><li>`NO_TIMEOUT`: Setting to never automatically stop stale executions.</li></ul>
ide_execution_mode | enum **IdeExecutionMode**<br>VM allocation mode. <ul><li>`SERVERLESS`: VM is allocated for specific execution and deallocated after the execution ends.</li><li>`DEDICATED`: VM is allocated at the first execution and stays allocated until manually deallocated. Or until timeout exceeded.</li></ul>
vm_inactivity_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Timeout for VM deallocation. 
default_dedicated_spec | **string**<br>Default VM configuration for DEDICATED mode. 


### Limits {#Limits2}

Field | Description
--- | ---
max_units_per_hour | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of units that can be spent per hour. 
max_units_per_execution | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of units that can be spent on the one execution. 


## List {#List}

Lists projects for the specified community.

**rpc List ([ListProjectsRequest](#ListProjectsRequest)) returns ([ListProjectsResponse](#ListProjectsResponse))**

### ListProjectsRequest {#ListProjectsRequest}

Field | Description
--- | ---
community_id | **string**<br>Required. ID of the community to list projects in. 
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListProjectsResponse.next_page_token](#ListProjectsResponse) that can be used to get the next page of results in subsequent list requests. Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListProjectsResponse.next_page_token](#ListProjectsResponse) returned by a previous list request. The maximum string length in characters is 100.
project_name_pattern | **string**<br>Name pattern to filter projects that are returned. Only projects with names matching the pattern will be returned. 
owned_by_id | **string**<br>User ID to filter projects that are returned. Only projects that are owned by specified user will be returned. 


### ListProjectsResponse {#ListProjectsResponse}

Field | Description
--- | ---
projects[] | **[Project](#Project3)**<br>List of Project resources. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListProjectsRequest.page_size](#ListProjectsRequest), use the `next_page_token` as the value for the [ListProjectsRequest.page_token](#ListProjectsRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### Project {#Project3}

Field | Description
--- | ---
id | **string**<br>ID of the project. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
name | **string**<br>Name of the project. 1-63 characters long. 
description | **string**<br>Description of the project. 0-256 characters long. 
labels | **map<string,string>**<br> 
created_by_id | **string**<br> 
settings | **[Settings](#Settings3)**<br>Settings of the project. 
limits | **[Limits](#Limits3)**<br>Limits of the project. 
community_id | **string**<br>ID of the community that the project belongs to. 


### Settings {#Settings3}

Field | Description
--- | ---
service_account_id | **string**<br>ID of the service account, on whose behalf all operations with clusters will be performed. 
subnet_id | **string**<br>ID of the subnet where the DataProc cluster resides. Currently only subnets created in the availability zone ru-central1-a are supported. 
data_proc_cluster_id | **string**<br>ID of the DataProc cluster. 
commit_mode | enum **CommitMode**<br>Commit mode that is assigned to the project. <ul><li>`STANDARD`: Commit happens after the execution of a cell or group of cells or after completion with an error.</li><li>`AUTO`: Commit happens periodically. Also, automatic saving of state occurs when switching to another type of computing resource.</li></ul>
security_group_ids[] | **string**<br>Network interfaces security groups. 
early_access | **bool**<br>Is early access preview enabled for the project. 
ide | enum **Ide**<br>Project IDE. <ul><li>`JUPYTER_LAB`: Project running on JupyterLab IDE.</li></ul>
default_folder_id | **string**<br>Default project folder ID. 
stale_exec_timeout_mode | enum **StaleExecutionTimeoutMode**<br>Timeout to automatically stop stale executions. <ul><li>`ONE_HOUR`: Setting to automatically stop stale execution after one hour with low consumption.</li><li>`THREE_HOURS`: Setting to automatically stop stale execution after three hours with low consumption.</li><li>`NO_TIMEOUT`: Setting to never automatically stop stale executions.</li></ul>
ide_execution_mode | enum **IdeExecutionMode**<br>VM allocation mode. <ul><li>`SERVERLESS`: VM is allocated for specific execution and deallocated after the execution ends.</li><li>`DEDICATED`: VM is allocated at the first execution and stays allocated until manually deallocated. Or until timeout exceeded.</li></ul>
vm_inactivity_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Timeout for VM deallocation. 
default_dedicated_spec | **string**<br>Default VM configuration for DEDICATED mode. 


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
project_id | **string**<br>Required. ID of the project to return the unit balance for. The maximum string length in characters is 50.


### GetUnitBalanceResponse {#GetUnitBalanceResponse}

Field | Description
--- | ---
unit_balance | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of units available to the project. 


## SetUnitBalance {#SetUnitBalance}

Sets the unit balance of the specified project.

**rpc SetUnitBalance ([SetUnitBalanceRequest](#SetUnitBalanceRequest)) returns ([operation.Operation](#Operation4))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[SetUnitBalanceMetadata](#SetUnitBalanceMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### SetUnitBalanceRequest {#SetUnitBalanceRequest}

Field | Description
--- | ---
project_id | **string**<br>Required. ID of the project to set the unit balance for. The maximum string length in characters is 50.
unit_balance | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of units available to the project. 


### Operation {#Operation4}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[SetUnitBalanceMetadata](#SetUnitBalanceMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### SetUnitBalanceMetadata {#SetUnitBalanceMetadata}

Field | Description
--- | ---
project_id | **string**<br>ID of the project which unit balance is set. 


## Execute {#Execute}

Executes code in the specified cell or notebook.

**rpc Execute ([ProjectExecutionRequest](#ProjectExecutionRequest)) returns ([operation.Operation](#Operation5))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[ProjectExecutionMetadata](#ProjectExecutionMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[ProjectExecutionResponse](#ProjectExecutionResponse)<br>

### ProjectExecutionRequest {#ProjectExecutionRequest}

Field | Description
--- | ---
project_id | **string**<br>Required. ID of the project to execute notebook/cell in. The maximum string length in characters is 50.
target | **oneof:** `notebook_id` or `cell_id`<br>
&nbsp;&nbsp;notebook_id | **string**<br>ID of the notebook to execute. The maximum string length in characters is 200.
&nbsp;&nbsp;cell_id | **string**<br>ID of the cell to execute. The maximum string length in characters is 200.
input_variables | **google.protobuf.Struct**<br>Values of input variables. 
output_variable_names[] | **string**<br>Names of output variables. 


### Operation {#Operation5}

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
execution_status | enum **ExecutionStatus**<br>Execution final status. <ul><li>`OK`: Execution finished successfully.</li><li>`ERROR`: Execution ended with error.</li><li>`ABORTED`: Execution was aborted.</li></ul>


## GetCellOutputs {#GetCellOutputs}

Returns outputs of the specified cell.

**rpc GetCellOutputs ([CellOutputsRequest](#CellOutputsRequest)) returns ([CellOutputsResponse](#CellOutputsResponse))**

### CellOutputsRequest {#CellOutputsRequest}

Field | Description
--- | ---
project_id | **string**<br>Required. ID of the project to return cell outputs for. The maximum string length in characters is 50.
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
project_id | **string**<br>Required. ID of the project, for which to return state variables. The maximum string length in characters is 50.
notebook_id | **string**<br>Required. ID of the notebook, for which to return state variables. The maximum string length in characters is 200.
variable_names[] | **string**<br>Names of variables to return. 
checkpoint_id | **string**<br>ID of the checkpoint, for which to return state variables. 


### GetStateVariablesResponse {#GetStateVariablesResponse}

Field | Description
--- | ---
variables | **google.protobuf.Struct**<br>Values of the specified variables. 


## ListAccessBindings {#ListAccessBindings}

Lists access bindings for the project.

**rpc ListAccessBindings ([ListAccessBindingsRequest](#ListAccessBindingsRequest)) returns ([ListAccessBindingsResponse](#ListAccessBindingsResponse))**

### ListAccessBindingsRequest {#ListAccessBindingsRequest}

Field | Description
--- | ---
resource_id | **string**<br>Required. ID of the resource to list access bindings for. <br>To get the resource ID, use a corresponding List request. For example, use the [yandex.cloud.resourcemanager.v1.CloudService.List](/docs/resource-manager/api-ref/grpc/cloud_service#List) request to get the Cloud resource ID. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page that should be returned. If the number of available results is larger than `page_size`, the service returns a [ListAccessBindingsResponse.next_page_token](#ListAccessBindingsResponse) that can be used to get the next page of results in subsequent list requests. Default value: 100. The maximum value is 1000.
page_token | **string**<br>Page token. Set `page_token` to the [ListAccessBindingsResponse.next_page_token](#ListAccessBindingsResponse) returned by a previous list request to get the next page of results. The maximum string length in characters is 100.


### ListAccessBindingsResponse {#ListAccessBindingsResponse}

Field | Description
--- | ---
access_bindings[] | **[AccessBinding](#AccessBinding)**<br>List of access bindings for the specified resource. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListAccessBindingsRequest.page_size](#ListAccessBindingsRequest), use the `next_page_token` as the value for the [ListAccessBindingsRequest.page_token](#ListAccessBindingsRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### AccessBinding {#AccessBinding}

Field | Description
--- | ---
role_id | **string**<br>Required. ID of the `yandex.cloud.iam.v1.Role` that is assigned to the `subject`. The maximum string length in characters is 50.
subject | **[Subject](#Subject)**<br>Required. Identity for which access binding is being created. It can represent an account with a unique ID or several accounts with a system identifier. 


### Subject {#Subject}

Field | Description
--- | ---
id | **string**<br>Required. ID of the subject. <br>It can contain one of the following values: <ul><li>`allAuthenticatedUsers`: A special system identifier that represents anyone </li></ul>who is authenticated. It can be used only if the `type` is `system`. <ul><li>`allUsers`: A special system identifier that represents anyone. No authentication is required. </li></ul>For example, you don't need to specify the IAM token in an API query. <ul><li>`<cloud generated id>`: An identifier that represents a user account. </li></ul>It can be used only if the `type` is `userAccount`, `federatedUser` or `serviceAccount`. The maximum string length in characters is 50.
type | **string**<br>Required. Type of the subject. <br>It can contain one of the following values: <ul><li>`userAccount`: An account on Yandex or Yandex.Connect, added to Yandex.Cloud. </li><li>`serviceAccount`: A service account. This type represents the `yandex.cloud.iam.v1.ServiceAccount` resource. </li><li>`federatedUser`: A federated account. This type represents a user from an identity federation, like Active Directory. </li><li>`system`: System group. This type represents several accounts with a common system identifier. </li></ul><br>For more information, see [Subject to which the role is assigned](/docs/iam/concepts/access-control/#subject). The maximum string length in characters is 100.


## SetAccessBindings {#SetAccessBindings}

Sets access bindings for the project.

**rpc SetAccessBindings ([SetAccessBindingsRequest](#SetAccessBindingsRequest)) returns ([operation.Operation](#Operation6))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[SetProjectAccessBindingsMetadata](#SetProjectAccessBindingsMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### SetAccessBindingsRequest {#SetAccessBindingsRequest}

Field | Description
--- | ---
resource_id | **string**<br>Required. ID of the resource for which access bindings are being set. <br>To get the resource ID, use a corresponding List request. The maximum string length in characters is 50.
access_bindings[] | **[AccessBinding](#AccessBinding)**<br>Required. Access bindings to be set. For more information, see [Access Bindings](/docs/iam/concepts/access-control/#access-bindings). 


### AccessBinding {#AccessBinding1}

Field | Description
--- | ---
role_id | **string**<br>Required. ID of the `yandex.cloud.iam.v1.Role` that is assigned to the `subject`. The maximum string length in characters is 50.
subject | **[Subject](#Subject)**<br>Required. Identity for which access binding is being created. It can represent an account with a unique ID or several accounts with a system identifier. 


### Subject {#Subject1}

Field | Description
--- | ---
id | **string**<br>Required. ID of the subject. <br>It can contain one of the following values: <ul><li>`allAuthenticatedUsers`: A special system identifier that represents anyone </li></ul>who is authenticated. It can be used only if the `type` is `system`. <ul><li>`allUsers`: A special system identifier that represents anyone. No authentication is required. </li></ul>For example, you don't need to specify the IAM token in an API query. <ul><li>`<cloud generated id>`: An identifier that represents a user account. </li></ul>It can be used only if the `type` is `userAccount`, `federatedUser` or `serviceAccount`. The maximum string length in characters is 50.
type | **string**<br>Required. Type of the subject. <br>It can contain one of the following values: <ul><li>`userAccount`: An account on Yandex or Yandex.Connect, added to Yandex.Cloud. </li><li>`serviceAccount`: A service account. This type represents the `yandex.cloud.iam.v1.ServiceAccount` resource. </li><li>`federatedUser`: A federated account. This type represents a user from an identity federation, like Active Directory. </li><li>`system`: System group. This type represents several accounts with a common system identifier. </li></ul><br>For more information, see [Subject to which the role is assigned](/docs/iam/concepts/access-control/#subject). The maximum string length in characters is 100.


### Operation {#Operation6}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[SetProjectAccessBindingsMetadata](#SetProjectAccessBindingsMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### SetProjectAccessBindingsMetadata {#SetProjectAccessBindingsMetadata}

Field | Description
--- | ---
project_id | **string**<br>ID of the project which access bindings are set. 


## UpdateAccessBindings {#UpdateAccessBindings}

Updates access bindings for the project.

**rpc UpdateAccessBindings ([UpdateAccessBindingsRequest](#UpdateAccessBindingsRequest)) returns ([operation.Operation](#Operation7))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateProjectAccessBindingsMetadata](#UpdateProjectAccessBindingsMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### UpdateAccessBindingsRequest {#UpdateAccessBindingsRequest}

Field | Description
--- | ---
resource_id | **string**<br>Required. ID of the resource for which access bindings are being updated. The maximum string length in characters is 50.
access_binding_deltas[] | **[AccessBindingDelta](#AccessBindingDelta)**<br>Required. Updates to access bindings. The number of elements must be greater than 0.


### AccessBindingDelta {#AccessBindingDelta}

Field | Description
--- | ---
action | enum **AccessBindingAction**<br>Required. The action that is being performed on an access binding. <ul><li>`ADD`: Addition of an access binding.</li><li>`REMOVE`: Removal of an access binding.</li></ul>
access_binding | **[AccessBinding](#AccessBinding)**<br>Required. Access binding. For more information, see [Access Bindings](/docs/iam/concepts/access-control/#access-bindings). 


### AccessBinding {#AccessBinding2}

Field | Description
--- | ---
role_id | **string**<br>Required. ID of the `yandex.cloud.iam.v1.Role` that is assigned to the `subject`. The maximum string length in characters is 50.
subject | **[Subject](#Subject)**<br>Required. Identity for which access binding is being created. It can represent an account with a unique ID or several accounts with a system identifier. 


### Subject {#Subject2}

Field | Description
--- | ---
id | **string**<br>Required. ID of the subject. <br>It can contain one of the following values: <ul><li>`allAuthenticatedUsers`: A special system identifier that represents anyone </li></ul>who is authenticated. It can be used only if the `type` is `system`. <ul><li>`allUsers`: A special system identifier that represents anyone. No authentication is required. </li></ul>For example, you don't need to specify the IAM token in an API query. <ul><li>`<cloud generated id>`: An identifier that represents a user account. </li></ul>It can be used only if the `type` is `userAccount`, `federatedUser` or `serviceAccount`. The maximum string length in characters is 50.
type | **string**<br>Required. Type of the subject. <br>It can contain one of the following values: <ul><li>`userAccount`: An account on Yandex or Yandex.Connect, added to Yandex.Cloud. </li><li>`serviceAccount`: A service account. This type represents the `yandex.cloud.iam.v1.ServiceAccount` resource. </li><li>`federatedUser`: A federated account. This type represents a user from an identity federation, like Active Directory. </li><li>`system`: System group. This type represents several accounts with a common system identifier. </li></ul><br>For more information, see [Subject to which the role is assigned](/docs/iam/concepts/access-control/#subject). The maximum string length in characters is 100.


### Operation {#Operation7}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateProjectAccessBindingsMetadata](#UpdateProjectAccessBindingsMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### UpdateProjectAccessBindingsMetadata {#UpdateProjectAccessBindingsMetadata}

Field | Description
--- | ---
project_id | **string**<br>ID of the project which access bindings are updated. 


## AddResource {#AddResource}

Adds shared resource to project

**rpc AddResource ([AddResourceToProjectRequest](#AddResourceToProjectRequest)) returns ([operation.Operation](#Operation8))**

Response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### AddResourceToProjectRequest {#AddResourceToProjectRequest}

Field | Description
--- | ---
project_id | **string**<br>Required.  The maximum string length in characters is 50.
resource_type | enum **ResourceType**<br> 
resource_id | **string**<br>Required.  


### Operation {#Operation8}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


## RemoveResource {#RemoveResource}

Removes shared resource from project

**rpc RemoveResource ([RemoveResourceFromProjectRequest](#RemoveResourceFromProjectRequest)) returns ([operation.Operation](#Operation9))**

Response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### RemoveResourceFromProjectRequest {#RemoveResourceFromProjectRequest}

Field | Description
--- | ---
project_id | **string**<br>Required.  The maximum string length in characters is 50.
resource_type | enum **ResourceType**<br> 
resource_id | **string**<br>Required.  


### Operation {#Operation9}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


