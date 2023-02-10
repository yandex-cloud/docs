---
editable: false
---

# DataSphere API v2, gRPC: ProjectService

A set of methods for managing Project resources.

| Call | Description |
| --- | --- |
| [Create](#Create) | Creates a project in the specified folder. |
| [Update](#Update) | Updates the specified project. |
| [Delete](#Delete) | Deletes the specified project. |
| [Open](#Open) | Opens the specified project. |
| [Stop](#Stop) | Stops the specified project. |
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
| [ListResources](#ListResources) | Lists project resources. |
| [ListSharedResources](#ListSharedResources) | Lists shared resources of the project. |

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
created_from | **oneof:** `checkpoint_id` or `checkpoint_token`<br>If project should be created from checkpoint, either checkpoint ID or token should be set.
&nbsp;&nbsp;checkpoint_id | **string**<br>If project should be created from checkpoint, either checkpoint ID or token should be set. 
&nbsp;&nbsp;checkpoint_token | **string**<br>If project should be created from checkpoint, either checkpoint ID or token should be set. 
zone_id | **string**<br>Zone in which project should be created. 


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
zone_id | **string**<br>ID of the zone that the project belongs to. 
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
zone_id | **string**<br>ID of the zone that the project belongs to. 
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
custom_versions | **CustomVersions**<br> 


### CustomVersions {#CustomVersions}

Field | Description
--- | ---
room_docker_image | **string**<br>Custom docker image tag for room. 
servant_docker_image | **string**<br>Custom docker image tag for servant. 


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
session_id | **string**<br>Session ID of the project that is being opened. 


## Stop {#Stop}

Stops the specified project.

**rpc Stop ([StopProjectRequest](#StopProjectRequest)) returns ([operation.Operation](#Operation4))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[StopProjectMetadata](#StopProjectMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### StopProjectRequest {#StopProjectRequest}

Field | Description
--- | ---
project_id | **string**<br>Required. ID of the Project resource to stop. To get the project ID use a [ProjectService.List](#List) request. The maximum string length in characters is 50.


### Operation {#Operation4}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[StopProjectMetadata](#StopProjectMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### StopProjectMetadata {#StopProjectMetadata}

Field | Description
--- | ---
project_id | **string**<br>ID of the project that is being stopped. 


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
zone_id | **string**<br>ID of the zone that the project belongs to. 
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
zone_id | **string**<br>ID of the zone that the project belongs to. 
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

**rpc SetUnitBalance ([SetUnitBalanceRequest](#SetUnitBalanceRequest)) returns ([operation.Operation](#Operation5))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[SetUnitBalanceMetadata](#SetUnitBalanceMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### SetUnitBalanceRequest {#SetUnitBalanceRequest}

Field | Description
--- | ---
project_id | **string**<br>Required. ID of the project to set the unit balance for. The maximum string length in characters is 50.
unit_balance | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of units available to the project. 


### Operation {#Operation5}

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

**rpc Execute ([ProjectExecutionRequest](#ProjectExecutionRequest)) returns ([operation.Operation](#Operation6))**

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


### Operation {#Operation6}

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

**rpc SetAccessBindings ([SetAccessBindingsRequest](#SetAccessBindingsRequest)) returns ([operation.Operation](#Operation7))**

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


### Operation {#Operation7}

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

**rpc UpdateAccessBindings ([UpdateAccessBindingsRequest](#UpdateAccessBindingsRequest)) returns ([operation.Operation](#Operation8))**

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


### Operation {#Operation8}

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


## ListResources {#ListResources}

Lists project resources.

**rpc ListResources ([ListProjectResourcesRequest](#ListProjectResourcesRequest)) returns ([ListProjectResourcesResponse](#ListProjectResourcesResponse))**

### ListProjectResourcesRequest {#ListProjectResourcesRequest}

Field | Description
--- | ---
project_id | **string**<br>Required. ID of the project to list resources in. The maximum string length in characters is 50.
resource_type | enum **[ResourceType](./resource_types#undefined)**<br>Required. Type of resources that should be listed. <ul><li>`RESOURCE_TYPE_UNPINNED_CHECKPOINT`: Unpinned checkpoint.</li><li>`RESOURCE_TYPE_SECRET`: Secret.</li><li>`RESOURCE_TYPE_DOCKER_IMAGE`: Docker image.</li><li>`RESOURCE_TYPE_DATASET`: Dataset.</li><li>`RESOURCE_TYPE_S3`: S3 object storage.</li><li>`RESOURCE_TYPE_NODE`: Node.</li><li>`RESOURCE_TYPE_PINNED_CHECKPOINT`: Pinned checkpoint.</li><li>`RESOURCE_TYPE_ALIAS`: Node alias.</li></ul>


### ListProjectResourcesResponse {#ListProjectResourcesResponse}

Field | Description
--- | ---
resource_list | **[ResourceList](#ResourceList)**<br>List of project resources. 


### ResourceList {#ResourceList}

Field | Description
--- | ---
resources | **oneof:** `unpinned_checkpoints`, `secrets`, `dockers`, `datasets`, `s3`, `pinned_checkpoints`, `node_list` or `alias_list`<br>
&nbsp;&nbsp;unpinned_checkpoints | **[CheckpointList](#CheckpointList)**<br>List of unpinned checkpoints. 
&nbsp;&nbsp;secrets | **[SecretList](#SecretList)**<br>List of secrets. 
&nbsp;&nbsp;dockers | **[DockerImageList](#DockerImageList)**<br>List of Docker images. 
&nbsp;&nbsp;datasets | **[DatasetList](#DatasetList)**<br>List of datasets. 
&nbsp;&nbsp;s3 | **[S3List](#S3List)**<br>List of S3 objects. 
&nbsp;&nbsp;pinned_checkpoints | **[CheckpointList](#CheckpointList)**<br>List of pinned checkpoints. 
&nbsp;&nbsp;node_list | **[NodeList](#NodeList)**<br>List of nodes. 
&nbsp;&nbsp;alias_list | **[AliasList](#AliasList)**<br>List of node aliases. 


### CheckpointList {#CheckpointList}

Field | Description
--- | ---
listed_checkpoints[] | **[ListedCheckpoint](#ListedCheckpoint)**<br>List of checkpoints. 


### ListedCheckpoint {#ListedCheckpoint}

Field | Description
--- | ---
checkpoint | **[Checkpoint](#Checkpoint)**<br>Checkpoint. 


### Checkpoint {#Checkpoint}

Field | Description
--- | ---
id | **string**<br>ID of the checkpoint. 
project_id | **string**<br>ID of the project. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time the checkpoint was created. 
name | **string**<br>Name of the checkpoint. Only pinned checkpoints have name. 
notebook_path | **string**<br>Path of the notebook; optional. 
created_by_id | **string**<br>ID of the user who created checkpoint. 
pinned_by_id | **string**<br>ID of the user who pinned checkpoint. Empty if checkpoint is not pinned. 
cell_info | **[CellInfo](#CellInfo)**<br>Cell info for checkpoint. Not all checkpoints have this info. 
type | enum **[Type](./resource_types#undefined)**<br>Checkpoint type. <ul><li>`CHECKPOINT_TYPE_INITIAL`: Checkpoint created on project initialization.</li><li>`CHECKPOINT_TYPE_EXPORTED`: Checkpoint created after importing checkpoint to project.</li><li>`CHECKPOINT_TYPE_CELL_RUN`: Checkpoint created after cell execution.</li><li>`CHECKPOINT_TYPE_MERGE_BACKGROUND`: Checkpoint created after merging background execution results.</li><li>`CHECKPOINT_TYPE_DATASET`: Checkpoint created on dataset creation.</li><li>`CHECKPOINT_TYPE_ROLLBACK`: Checkpoint created when rolling back to previous checkpoint.</li><li>`CHECKPOINT_TYPE_CLEAR_STATE`: Checkpoint created on clearing project state.</li><li>`CHECKPOINT_TYPE_ADD_NOTEBOOK`: Checkpoint created on adding a notebook.</li></ul>
tags[] | **string**<br>Tags of the checkpoint. 
labels | **map<string,string>**<br>Labels of the checkpoint. 
nb_checkpoints[] | **[NbCheckpoint](#NbCheckpoint)**<br>List of notebook checkpoints. 


### CellInfo {#CellInfo}

Field | Description
--- | ---
notebook_id | **string**<br>ID of the notebook. 
cell_id | **string**<br>ID of the cell. 
cell_version | **string**<br>Version of the cell. 
state_version | **string**<br>Version of the state. 
code | **string**<br>Code of the cell. 


### NbCheckpoint {#NbCheckpoint}

Field | Description
--- | ---
project_id | **string**<br>ID of the project. 
notebook_id | **string**<br>ID of the notebook. 
nb_checkpoint_id | **string**<br>ID of the notebook checkpoint. 
notebook_path | **string**<br>Path of the notebook. 
state_version | **int64**<br>Version of the state. 
view_version | **int64**<br>Version of the view. 
execution_count | **int64**<br>Notebook executions count. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when notebook checkpoint was created. 


### SecretList {#SecretList}

Field | Description
--- | ---
listed_secrets[] | **[ListedSecret](#ListedSecret)**<br>List of secrets. 


### ListedSecret {#ListedSecret}

Field | Description
--- | ---
secret | **[Secret](#Secret)**<br>Secret. 


### Secret {#Secret}

Field | Description
--- | ---
id | **string**<br>ID of the secret. 
project_id | **string**<br>ID of the project. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when secret was created. 
name | **string**<br>Name of the secret. 1-63 characters long. 
description | **string**<br>Description of the secret. 0-256 characters long. 
labels | **map<string,string>**<br>Labels of the secret. 
created_by_id | **string**<br>ID of the user who created secret. 
updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time of last secret update. 


### DockerImageList {#DockerImageList}

Field | Description
--- | ---
listed_docker_images[] | **[ListedDockerImage](#ListedDockerImage)**<br>List of Docker images. 


### ListedDockerImage {#ListedDockerImage}

Field | Description
--- | ---
docker_image | **[DockerImage](#DockerImage)**<br>Docker image. 
activated | **bool**<br>Is Docker image active. 


### DockerImage {#DockerImage}

Field | Description
--- | ---
id | **string**<br>ID of the Docker image. 
project_id | **string**<br>ID of the project. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time the Docker image was created. 
name | **string**<br>Name of the Docker image. 
description | **string**<br>Description of the Docker image. 
labels | **map<string,string>**<br>Labels of the Docker image. 
created_by_id | **string**<br>ID of the user who created the Docker image. 
build_path | **string**<br>Build path used for the Docker image. 
repository | **string**<br>Repository where Docker image is stored. 
tag | **string**<br>Tag of the Docker image. 
template_name | **string**<br>Name of the template used for Docker image. 
code | **string**<br>Code that created Docker image. 
build_status | enum **BuildStatus**<br>Docker image build status. <ul><li>`DRAFT`: Draft.</li><li>`QUEUED`: Build queued.</li><li>`BUILDING`: Build is in progress.</li><li>`SUCCESS`: Build finished successfully.</li><li>`ERROR`: Build finished with error.</li></ul>


### DatasetList {#DatasetList}

Field | Description
--- | ---
listed_datasets[] | **[ListedDataset](#ListedDataset)**<br>List of datasets. 


### ListedDataset {#ListedDataset}

Field | Description
--- | ---
dataset | **[Dataset](#Dataset)**<br>Dataset. 
dataset_status | **[DatasetStatus](#DatasetStatus)**<br>Status of the dataset. 


### Dataset {#Dataset}

Field | Description
--- | ---
id | **string**<br>ID of the dataset. 
project_id | **string**<br>ID of the project. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time the dataset was created. 
name | **string**<br>Name of the dataset. 
description | **string**<br>Description of the dataset. 
labels | **map<string,string>**<br>Labels of the dataset. 
created_by_id | **string**<br>ID of the user who created the dataset. 
code | **string**<br>Code used to create dataset. 
size_gb | **int64**<br>Size of the dataset, Gb. 
zone_ids[] | **string**<br>Zone IDs where dataset is available. 
mount_path | **string**<br>Dataset mount path. 
data_capsule_id | **string**<br>ID of the data capsule object, storing information about dataset storage. 


### DatasetStatus {#DatasetStatus}

Field | Description
--- | ---
status | **oneof:** `status_active`, `status_inactive` or `status_error`<br>
&nbsp;&nbsp;status_active | **[StatusActive](#StatusActive)**<br>Dataset is activated. 
&nbsp;&nbsp;status_inactive | **[StatusInactive](#StatusInactive)**<br>Dataset is inactive. 
&nbsp;&nbsp;status_error | **[StatusError](#StatusError)**<br>Error while activating dataset. 


### StatusActive {#StatusActive}



### StatusInactive {#StatusInactive}



### StatusError {#StatusError}

Field | Description
--- | ---
error | **string**<br>Text of the error. 


### S3List {#S3List}

Field | Description
--- | ---
listed_s3[] | **[ListedS3](#ListedS3)**<br>List of S3 objects. 


### ListedS3 {#ListedS3}

Field | Description
--- | ---
s3 | **[S3](#S3)**<br>S3 object. 
s3_status | **[S3Status](#S3Status)**<br>Status of the S3 object. 


### S3 {#S3}

Field | Description
--- | ---
id | **string**<br>ID of the S3 object. 
project_id | **string**<br>ID of the project. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when S3 object was created. 
name | **string**<br>Name of the S3 object. 0-64 characters long. 
description | **string**<br>Description of the S3 object. 0-256 characters long. 
labels | **map<string,string>**<br>Labels of the S3 object. 
created_by_id | **string**<br>ID of the user who created S3 object. 
endpoint | **string**<br>S3 service endpoint. 
bucket | **string**<br>S3 bucket containing the object. 
mount_path | **string**<br>Path for S3 object mounting. 
access_key_id | **string**<br>Public access key. 
secret_access_key_secret_id | **string**<br>ID of the secret containing private access key. 
s3_mount_mode | enum **S3MountMode**<br>S3 mount mode. <ul><li>`READ_ONLY`: Read-only mount.</li><li>`READ_WRITE`: Read-write mount.</li></ul>
s3_backend | enum **S3Backend**<br>S3 backend for mounting S3 buckets. <ul><li>`S3FS`: S3FS.</li><li>`GEESEFS`: GeeseFS</li></ul>


### S3Status {#S3Status}

Field | Description
--- | ---
status | **oneof:** `status_active`, `status_inactive` or `status_error`<br>
&nbsp;&nbsp;status_active | **[StatusActive](#StatusActive1)**<br>S3 object is active. 
&nbsp;&nbsp;status_inactive | **[StatusInactive](#StatusInactive1)**<br>S3 object is inactive. 
&nbsp;&nbsp;status_error | **[StatusError](#StatusError1)**<br>S3 object in error status. 


### StatusActive {#StatusActive1}



### StatusInactive {#StatusInactive1}



### StatusError {#StatusError1}

Field | Description
--- | ---
error | **string**<br>Error message. 


### NodeList {#NodeList}

Field | Description
--- | ---
listed_nodes[] | **[ListedNode](#ListedNode)**<br>List of nodes. 


### ListedNode {#ListedNode}

Field | Description
--- | ---
node | **[nodedeployer.Node](./nodedeployer/billing_spec#Node)**<br>Node. 
node_status | **[nodedeployer.NodeStatus](./nodedeployer/billing_spec#NodeStatus)**<br>Status of the node. 
instances[] | **[nodedeployer.Instance](./nodedeployer/billing_spec#Instance)**<br>List of node instances. 
related_aliases[] | **string**<br>List of aliases related to the node. 


### Node {#Node}

Field | Description
--- | ---
id | **string**<br>Required. ID of the node. 
project_id | **string**<br>Required. ID of the project. 
folder_id | **string**<br>Required. ID of the folder that the node belongs to. During deployment Compute resources of this folder used for creation of new instances 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Required. Time when node was created. 
created_by_id | **string**<br>ID of the user who created the node. 
node_spec | **[NodeSpec](#NodeSpec)**<br>Required. Specification of the node. 
tags[] | **string**<br>List of the node tags. 
updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when node was last updated. 


### NodeSpec {#NodeSpec}

Field | Description
--- | ---
name | **string**<br>Required. Name associated with current node specification. 2-63 characters long. Value must match the regular expression ` [a-zA-Z\u0401\u0451\u0410-\u044f][-\\s\\w\u0401\u0451\u0410-\u044f]{0,61}[a-zA-Z0-9\u0401\u0451\u0410-\u044f] `.
instance_spec | **[InstanceSpec](#InstanceSpec)**<br>Required. Instance deployment specifications. 
policies | **[Policies](#Policies)**<br>Required. Scaling and availability policies. 
permissions | **[Permissions](#Permissions)**<br>Permissions to perform actions with node and its instances. 
description | **string**<br>Description of the node specification. 


### InstanceSpec {#InstanceSpec}

Field | Description
--- | ---
hardware_spec | **[HardwareSpec](#HardwareSpec)**<br>Required. Specifications of the hardware. 
app_spec | **oneof:** `servant_app` or `docker_app`<br>Specifications of the application deployment.
&nbsp;&nbsp;servant_app | **[ServantApp](#ServantApp)**<br>Specifications of the application deployment. 
&nbsp;&nbsp;docker_app | **[DockerApp](#DockerApp)**<br>Specifications of the application deployment. 


### HardwareSpec {#HardwareSpec}

Field | Description
--- | ---
memory | **int64**<br>RAM amount, Gb. 
cores | **int64**<br>Number of cores. 
gpus | **int64**<br>Number of GPUs. 
compatibility_requirements[] | **string**<br>List of additional hardware requirements. 
image | **string**<br>Docker image. 
name | **string**<br>Required. Name of the hardware spec. 


### ServantApp {#ServantApp}

Field | Description
--- | ---
checkpoint | **[Checkpoint](#Checkpoint1)**<br>Required. Checkpoint used for node creation. 
signature | **[Signature](#Signature)**<br>Description of the input and output. 
jupyter_kernel_spec | **[JupyterKernelSpec](#JupyterKernelSpec)**<br>Jupyter kernel specification. 


### Signature {#Signature}

Field | Description
--- | ---
input_parameters[] | **[Parameter](#Parameter)**<br>List of the input parameters. 
output_parameters[] | **[Parameter](#Parameter)**<br>List of the output parameters. 


### Parameter {#Parameter}

Field | Description
--- | ---
name | **string**<br>Required. Name of the parameter. 
type | **string**<br>Type of the parameter. 
description | **string**<br>Description of the parameter. 


### JupyterKernelSpec {#JupyterKernelSpec}

Field | Description
--- | ---
docker_image | **string**<br>Required. Docker image name. 
username | **string**<br>Docker repository username. 
password_secret | **string**<br>Docker repository password secret. 


### DockerApp {#DockerApp}

Field | Description
--- | ---
container | **[Container](#Container)**<br>Required.  
endpoint | **[Endpoint](#Endpoint)**<br>Required.  
telemetry | **[Telemetry](#Telemetry)**<br> 
healthcheck | **[Healthcheck](#Healthcheck)**<br> 


### Container {#Container}

Field | Description
--- | ---
image | **string**<br>Required. Docker image name. 
username | **string**<br>Docker repository username. 
password_secret | **string**<br>Docker repository password secret. 
ports[] | **[ContainerPort](#ContainerPort)**<br>Docker port bindings. 


### ContainerPort {#ContainerPort}

Field | Description
--- | ---
container_port | **int64**<br>Container port to bind. 
host_port | **int64**<br>Host port to bind to. 
host_ip | **string**<br>Host IP address. 
protocol | **string**<br>Port protocol. 


### Endpoint {#Endpoint}

Field | Description
--- | ---
port | **int64**<br>Port of the endpoint. Acceptable values are 0 to 65535, inclusive.
endpoint_options | **[EndpointOptions](#EndpointOptions)**<br>Endpoint options. 
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Endpoint response timeout. 
idle_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Idle timeout for endpoint. Defines amount of time connection could exist without activity. 


### EndpointOptions {#EndpointOptions}

Field | Description
--- | ---
endpoint_type | **oneof:** `http` or `grpc`<br>
&nbsp;&nbsp;http | **[HttpEndpoint](#HttpEndpoint)**<br>HTTP endpoint. 
&nbsp;&nbsp;grpc | **[GrpcEndpoint](#GrpcEndpoint)**<br>gRPC endpoint. 


### HttpEndpoint {#HttpEndpoint}

Field | Description
--- | ---
use_http2 | **bool**<br>Use HTTP/2 protocol. 


### GrpcEndpoint {#GrpcEndpoint}



### Telemetry {#Telemetry}

Field | Description
--- | ---
path | **string**<br>Required. Relative path of the endpoint. 
port | **int64**<br>Port. Acceptable values are 0 to 65535, inclusive.
format | enum **Format**<br>Required. Metrics format. <ul><li>`SOLOMON_JSON`: Solomon (JSON) metrics format.</li><li>`PROMETHEUS`: Prometheus metrics format.</li></ul>


### Healthcheck {#Healthcheck}

Field | Description
--- | ---
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Timeout for performing healthcheck. 
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Interval for perform healthcheck. 
fails_threshold | **int64**<br>Number of subsequent healthcheck failures required to mark instance unhealthy. Value must be greater than 0.
passes_threshold | **int64**<br>Number of subsequent healthcheck passes required to mark instance healthy. Value must be greater than 0.
healthcheck_port | **int64**<br>Port to check health onto. Acceptable values are 0 to 65535, inclusive.
healthcheck | **oneof:** `http` or `grpc`<br>Healthcheck implementation.
&nbsp;&nbsp;http | **[HttpHealthcheck](#HttpHealthcheck)**<br>Healthcheck implementation. 
&nbsp;&nbsp;grpc | **[GrpcHealthcheck](#GrpcHealthcheck)**<br>Healthcheck implementation. 


### HttpHealthcheck {#HttpHealthcheck}

Field | Description
--- | ---
path | **string**<br>Path for healthcheck. Only HTTP response code will be checked. 


### GrpcHealthcheck {#GrpcHealthcheck}

Field | Description
--- | ---
service | **string**<br>Service to check. 


### Policies {#Policies}

Field | Description
--- | ---
availability_policy | **[AvailabilityPolicy](#AvailabilityPolicy)**<br>Required. Availability policies. 
scale_policy | **[ScalePolicy](#ScalePolicy)**<br>Scaling policies. 


### AvailabilityPolicy {#AvailabilityPolicy}

Field | Description
--- | ---
zones[] | **[ZoneAvailability](#ZoneAvailability)**<br>List of zone availability policies. The minimum number of elements is 1.


### ZoneAvailability {#ZoneAvailability}

Field | Description
--- | ---
zone_id | **string**<br>Required. ID of the zone. 
min_count | **int64**<br>Minimal number of running instances. Value must be greater than 0.
max_count | **int64**<br>Maximum number of running instances. 
subnet_id | **string**<br>ID of the subnet. 


### ScalePolicy {#ScalePolicy}

Field | Description
--- | ---
policy | **oneof:** `sessions_per_instance`<br>
&nbsp;&nbsp;sessions_per_instance | **[SessionBasedScalePolicy](#SessionBasedScalePolicy)**<br> 


### SessionBasedScalePolicy {#SessionBasedScalePolicy}

Field | Description
--- | ---
sessions_per_instance | **int64**<br>Maximum number of concurrent sessions per instance. 


### Permissions {#Permissions}

Field | Description
--- | ---
folders[] | **string**<br>List of folders. 


### Instance {#Instance}

Field | Description
--- | ---
instance_id | **string**<br>Required. ID of the instance. 
status | enum **Status**<br>Required. Status of the instance. <ul><li>`HEALTHY`: Instance is healthy and ready for load balancer.</li><li>`UNHEALTHY`: Instance has problems and excluded from load balancing.</li><li>`OUTDATED`: Instance is outdated.</li><li>`PREPARING`: Instance is preparing to service requests.</li><li>`UNDEFINED`: Initial instance state; VM not created.</li><li>`CREATED`: VM created for instance.</li><li>`STARTED`: Connection with instance VM established.</li><li>`DELETING`: Instance deletion is in progress.</li><li>`DELETED`: Instance is deleted.</li></ul>
updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when instance was last updated. 
endpoint | **[Endpoint](#Endpoint1)**<br>Instance endpoint. 
zone_id | **string**<br>Zone ID of the instance. 
billed_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when instance was last billed. 


### Endpoint {#Endpoint1}

Field | Description
--- | ---
address | **string**<br>Endpoint address. 
port | **int64**<br>Endpoint port. 


### AliasList {#AliasList}

Field | Description
--- | ---
listed_aliases[] | **[ListedAlias](#ListedAlias)**<br>List of node aliases. 


### ListedAlias {#ListedAlias}

Field | Description
--- | ---
alias | **[nodedeployer.NodeAlias](./nodedeployer/billing_spec#NodeAlias)**<br>Node alias. 


### NodeAlias {#NodeAlias}

Field | Description
--- | ---
name | **string**<br>Required. Name of the node alias. 2-79 characters long. 
project_id | **string**<br>Required. ID of the project. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Required. Time the node alias was created. 
created_by_id | **string**<br>Required. ID of the user who created the node alias. 
execution_acl | **[ACL](#ACL)**<br>ACL for the node alias. 
proxy_metadata | **[ProxyMetadata](#ProxyMetadata)**<br>Metadata that should be passed to backends. 
backends | **[Backends](#Backends)**<br>Required. Backends. 
billing_spec | **[BillingSpec](#BillingSpec)**<br>Billing specifications. 
updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when node alias was last updated. 
folder_id | **string**<br>Required. ID of the folder. 


### ACL {#ACL}

Field | Description
--- | ---
entries[] | **[ACLEntry](#ACLEntry)**<br>List of ACL entries. 
permission | **string**<br>Permission. 
is_public | **bool**<br>If true, allows everyone requests to alias 


### ACLEntry {#ACLEntry}

Field | Description
--- | ---
entry | **oneof:** `folder_entry`<br>
&nbsp;&nbsp;folder_entry | **[ACLFolderEntry](#ACLFolderEntry)**<br> 


### ACLFolderEntry {#ACLFolderEntry}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder. 


### ProxyMetadata {#ProxyMetadata}

Field | Description
--- | ---
headers[] | **[Header](#Header)**<br>List of headers. 


### Header {#Header}

Field | Description
--- | ---
name | **string**<br>Required. Name of th header. 
value | **string**<br>Required. Value of the header. 


### Backends {#Backends}

Field | Description
--- | ---
backend[] | **[Backend](#Backend)**<br>List of backends. The minimum number of elements is 1.


### Backend {#Backend}

Field | Description
--- | ---
node_id | **string**<br>Required. ID of the node. 
weight | **double**<br>Balancer weight of the node. Value must be greater than 0.


### BillingSpec {#BillingSpec}

Field | Description
--- | ---
billing_id | **string**<br>Required. Billing ID. 
billing_descriptor | **oneof:** `yandex_cloud_billing_descriptor`<br>
&nbsp;&nbsp;yandex_cloud_billing_descriptor | **[YandexCloudBillingDescriptor](#YandexCloudBillingDescriptor)**<br> 


### YandexCloudBillingDescriptor {#YandexCloudBillingDescriptor}

Field | Description
--- | ---
schema | **string**<br>Required. Billing schema. 
units | **string**<br>Required. Billing units. 
default_quantity | **int64**<br>Default billing quantity. 


## ListSharedResources {#ListSharedResources}

Lists shared resources of the project.

**rpc ListSharedResources ([ListProjectSharedResourcesRequest](#ListProjectSharedResourcesRequest)) returns ([ListProjectSharedResourcesResponse](#ListProjectSharedResourcesResponse))**

### ListProjectSharedResourcesRequest {#ListProjectSharedResourcesRequest}

Field | Description
--- | ---
project_id | **string**<br>Required. ID of the project to list shared resources in. The maximum string length in characters is 50.
resource_type | enum **[ResourceType](./resource_types#undefined)**<br>Required. Type of resources that should be listed. <ul><li>`RESOURCE_TYPE_UNPINNED_CHECKPOINT`: Unpinned checkpoint.</li><li>`RESOURCE_TYPE_SECRET`: Secret.</li><li>`RESOURCE_TYPE_DOCKER_IMAGE`: Docker image.</li><li>`RESOURCE_TYPE_DATASET`: Dataset.</li><li>`RESOURCE_TYPE_S3`: S3 object storage.</li><li>`RESOURCE_TYPE_NODE`: Node.</li><li>`RESOURCE_TYPE_PINNED_CHECKPOINT`: Pinned checkpoint.</li><li>`RESOURCE_TYPE_ALIAS`: Node alias.</li></ul>


### ListProjectSharedResourcesResponse {#ListProjectSharedResourcesResponse}

Field | Description
--- | ---
resource_list | **[ResourceList](#ResourceList1)**<br>List of shared project resources. 


### ResourceList {#ResourceList1}

Field | Description
--- | ---
resources | **oneof:** `unpinned_checkpoints`, `secrets`, `dockers`, `datasets`, `s3`, `pinned_checkpoints`, `node_list` or `alias_list`<br>
&nbsp;&nbsp;unpinned_checkpoints | **[CheckpointList](#CheckpointList1)**<br>List of unpinned checkpoints. 
&nbsp;&nbsp;secrets | **[SecretList](#SecretList1)**<br>List of secrets. 
&nbsp;&nbsp;dockers | **[DockerImageList](#DockerImageList1)**<br>List of Docker images. 
&nbsp;&nbsp;datasets | **[DatasetList](#DatasetList1)**<br>List of datasets. 
&nbsp;&nbsp;s3 | **[S3List](#S3List1)**<br>List of S3 objects. 
&nbsp;&nbsp;pinned_checkpoints | **[CheckpointList](#CheckpointList1)**<br>List of pinned checkpoints. 
&nbsp;&nbsp;node_list | **[NodeList](#NodeList1)**<br>List of nodes. 
&nbsp;&nbsp;alias_list | **[AliasList](#AliasList1)**<br>List of node aliases. 


### CheckpointList {#CheckpointList1}

Field | Description
--- | ---
listed_checkpoints[] | **[ListedCheckpoint](#ListedCheckpoint1)**<br>List of checkpoints. 


### ListedCheckpoint {#ListedCheckpoint1}

Field | Description
--- | ---
checkpoint | **[Checkpoint](#Checkpoint1)**<br>Checkpoint. 


### Checkpoint {#Checkpoint1}

Field | Description
--- | ---
id | **string**<br>ID of the checkpoint. 
project_id | **string**<br>ID of the project. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time the checkpoint was created. 
name | **string**<br>Name of the checkpoint. Only pinned checkpoints have name. 
notebook_path | **string**<br>Path of the notebook; optional. 
created_by_id | **string**<br>ID of the user who created checkpoint. 
pinned_by_id | **string**<br>ID of the user who pinned checkpoint. Empty if checkpoint is not pinned. 
cell_info | **[CellInfo](#CellInfo1)**<br>Cell info for checkpoint. Not all checkpoints have this info. 
type | enum **[Type](./resource_types#undefined)**<br>Checkpoint type. <ul><li>`CHECKPOINT_TYPE_INITIAL`: Checkpoint created on project initialization.</li><li>`CHECKPOINT_TYPE_EXPORTED`: Checkpoint created after importing checkpoint to project.</li><li>`CHECKPOINT_TYPE_CELL_RUN`: Checkpoint created after cell execution.</li><li>`CHECKPOINT_TYPE_MERGE_BACKGROUND`: Checkpoint created after merging background execution results.</li><li>`CHECKPOINT_TYPE_DATASET`: Checkpoint created on dataset creation.</li><li>`CHECKPOINT_TYPE_ROLLBACK`: Checkpoint created when rolling back to previous checkpoint.</li><li>`CHECKPOINT_TYPE_CLEAR_STATE`: Checkpoint created on clearing project state.</li><li>`CHECKPOINT_TYPE_ADD_NOTEBOOK`: Checkpoint created on adding a notebook.</li></ul>
tags[] | **string**<br>Tags of the checkpoint. 
labels | **map<string,string>**<br>Labels of the checkpoint. 
nb_checkpoints[] | **[NbCheckpoint](#NbCheckpoint1)**<br>List of notebook checkpoints. 


### CellInfo {#CellInfo1}

Field | Description
--- | ---
notebook_id | **string**<br>ID of the notebook. 
cell_id | **string**<br>ID of the cell. 
cell_version | **string**<br>Version of the cell. 
state_version | **string**<br>Version of the state. 
code | **string**<br>Code of the cell. 


### NbCheckpoint {#NbCheckpoint1}

Field | Description
--- | ---
project_id | **string**<br>ID of the project. 
notebook_id | **string**<br>ID of the notebook. 
nb_checkpoint_id | **string**<br>ID of the notebook checkpoint. 
notebook_path | **string**<br>Path of the notebook. 
state_version | **int64**<br>Version of the state. 
view_version | **int64**<br>Version of the view. 
execution_count | **int64**<br>Notebook executions count. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when notebook checkpoint was created. 


### SecretList {#SecretList1}

Field | Description
--- | ---
listed_secrets[] | **[ListedSecret](#ListedSecret1)**<br>List of secrets. 


### ListedSecret {#ListedSecret1}

Field | Description
--- | ---
secret | **[Secret](#Secret1)**<br>Secret. 


### Secret {#Secret1}

Field | Description
--- | ---
id | **string**<br>ID of the secret. 
project_id | **string**<br>ID of the project. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when secret was created. 
name | **string**<br>Name of the secret. 1-63 characters long. 
description | **string**<br>Description of the secret. 0-256 characters long. 
labels | **map<string,string>**<br>Labels of the secret. 
created_by_id | **string**<br>ID of the user who created secret. 
updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time of last secret update. 


### DockerImageList {#DockerImageList1}

Field | Description
--- | ---
listed_docker_images[] | **[ListedDockerImage](#ListedDockerImage1)**<br>List of Docker images. 


### ListedDockerImage {#ListedDockerImage1}

Field | Description
--- | ---
docker_image | **[DockerImage](#DockerImage1)**<br>Docker image. 
activated | **bool**<br>Is Docker image active. 


### DockerImage {#DockerImage1}

Field | Description
--- | ---
id | **string**<br>ID of the Docker image. 
project_id | **string**<br>ID of the project. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time the Docker image was created. 
name | **string**<br>Name of the Docker image. 
description | **string**<br>Description of the Docker image. 
labels | **map<string,string>**<br>Labels of the Docker image. 
created_by_id | **string**<br>ID of the user who created the Docker image. 
build_path | **string**<br>Build path used for the Docker image. 
repository | **string**<br>Repository where Docker image is stored. 
tag | **string**<br>Tag of the Docker image. 
template_name | **string**<br>Name of the template used for Docker image. 
code | **string**<br>Code that created Docker image. 
build_status | enum **BuildStatus**<br>Docker image build status. <ul><li>`DRAFT`: Draft.</li><li>`QUEUED`: Build queued.</li><li>`BUILDING`: Build is in progress.</li><li>`SUCCESS`: Build finished successfully.</li><li>`ERROR`: Build finished with error.</li></ul>


### DatasetList {#DatasetList1}

Field | Description
--- | ---
listed_datasets[] | **[ListedDataset](#ListedDataset1)**<br>List of datasets. 


### ListedDataset {#ListedDataset1}

Field | Description
--- | ---
dataset | **[Dataset](#Dataset1)**<br>Dataset. 
dataset_status | **[DatasetStatus](#DatasetStatus1)**<br>Status of the dataset. 


### Dataset {#Dataset1}

Field | Description
--- | ---
id | **string**<br>ID of the dataset. 
project_id | **string**<br>ID of the project. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time the dataset was created. 
name | **string**<br>Name of the dataset. 
description | **string**<br>Description of the dataset. 
labels | **map<string,string>**<br>Labels of the dataset. 
created_by_id | **string**<br>ID of the user who created the dataset. 
code | **string**<br>Code used to create dataset. 
size_gb | **int64**<br>Size of the dataset, Gb. 
zone_ids[] | **string**<br>Zone IDs where dataset is available. 
mount_path | **string**<br>Dataset mount path. 
data_capsule_id | **string**<br>ID of the data capsule object, storing information about dataset storage. 


### DatasetStatus {#DatasetStatus1}

Field | Description
--- | ---
status | **oneof:** `status_active`, `status_inactive` or `status_error`<br>
&nbsp;&nbsp;status_active | **[StatusActive](#StatusActive2)**<br>Dataset is activated. 
&nbsp;&nbsp;status_inactive | **[StatusInactive](#StatusInactive2)**<br>Dataset is inactive. 
&nbsp;&nbsp;status_error | **[StatusError](#StatusError2)**<br>Error while activating dataset. 


### StatusActive {#StatusActive2}



### StatusInactive {#StatusInactive2}



### StatusError {#StatusError2}

Field | Description
--- | ---
error | **string**<br>Text of the error. 


### S3List {#S3List1}

Field | Description
--- | ---
listed_s3[] | **[ListedS3](#ListedS31)**<br>List of S3 objects. 


### ListedS3 {#ListedS31}

Field | Description
--- | ---
s3 | **[S3](#S31)**<br>S3 object. 
s3_status | **[S3Status](#S3Status1)**<br>Status of the S3 object. 


### S3 {#S31}

Field | Description
--- | ---
id | **string**<br>ID of the S3 object. 
project_id | **string**<br>ID of the project. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when S3 object was created. 
name | **string**<br>Name of the S3 object. 0-64 characters long. 
description | **string**<br>Description of the S3 object. 0-256 characters long. 
labels | **map<string,string>**<br>Labels of the S3 object. 
created_by_id | **string**<br>ID of the user who created S3 object. 
endpoint | **string**<br>S3 service endpoint. 
bucket | **string**<br>S3 bucket containing the object. 
mount_path | **string**<br>Path for S3 object mounting. 
access_key_id | **string**<br>Public access key. 
secret_access_key_secret_id | **string**<br>ID of the secret containing private access key. 
s3_mount_mode | enum **S3MountMode**<br>S3 mount mode. <ul><li>`READ_ONLY`: Read-only mount.</li><li>`READ_WRITE`: Read-write mount.</li></ul>
s3_backend | enum **S3Backend**<br>S3 backend for mounting S3 buckets. <ul><li>`S3FS`: S3FS.</li><li>`GEESEFS`: GeeseFS</li></ul>


### S3Status {#S3Status1}

Field | Description
--- | ---
status | **oneof:** `status_active`, `status_inactive` or `status_error`<br>
&nbsp;&nbsp;status_active | **[StatusActive](#StatusActive3)**<br>S3 object is active. 
&nbsp;&nbsp;status_inactive | **[StatusInactive](#StatusInactive3)**<br>S3 object is inactive. 
&nbsp;&nbsp;status_error | **[StatusError](#StatusError3)**<br>S3 object in error status. 


### StatusActive {#StatusActive3}



### StatusInactive {#StatusInactive3}



### StatusError {#StatusError3}

Field | Description
--- | ---
error | **string**<br>Error message. 


### NodeList {#NodeList1}

Field | Description
--- | ---
listed_nodes[] | **[ListedNode](#ListedNode1)**<br>List of nodes. 


### ListedNode {#ListedNode1}

Field | Description
--- | ---
node | **[nodedeployer.Node](./nodedeployer/billing_spec#Node)**<br>Node. 
node_status | **[nodedeployer.NodeStatus](./nodedeployer/billing_spec#NodeStatus)**<br>Status of the node. 
instances[] | **[nodedeployer.Instance](./nodedeployer/billing_spec#Instance)**<br>List of node instances. 
related_aliases[] | **string**<br>List of aliases related to the node. 


### Node {#Node1}

Field | Description
--- | ---
id | **string**<br>Required. ID of the node. 
project_id | **string**<br>Required. ID of the project. 
folder_id | **string**<br>Required. ID of the folder that the node belongs to. During deployment Compute resources of this folder used for creation of new instances 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Required. Time when node was created. 
created_by_id | **string**<br>ID of the user who created the node. 
node_spec | **[NodeSpec](#NodeSpec1)**<br>Required. Specification of the node. 
tags[] | **string**<br>List of the node tags. 
updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when node was last updated. 


### NodeSpec {#NodeSpec1}

Field | Description
--- | ---
name | **string**<br>Required. Name associated with current node specification. 2-63 characters long. Value must match the regular expression ` [a-zA-Z\u0401\u0451\u0410-\u044f][-\\s\\w\u0401\u0451\u0410-\u044f]{0,61}[a-zA-Z0-9\u0401\u0451\u0410-\u044f] `.
instance_spec | **[InstanceSpec](#InstanceSpec1)**<br>Required. Instance deployment specifications. 
policies | **[Policies](#Policies1)**<br>Required. Scaling and availability policies. 
permissions | **[Permissions](#Permissions1)**<br>Permissions to perform actions with node and its instances. 
description | **string**<br>Description of the node specification. 


### InstanceSpec {#InstanceSpec1}

Field | Description
--- | ---
hardware_spec | **[HardwareSpec](#HardwareSpec1)**<br>Required. Specifications of the hardware. 
app_spec | **oneof:** `servant_app` or `docker_app`<br>Specifications of the application deployment.
&nbsp;&nbsp;servant_app | **[ServantApp](#ServantApp1)**<br>Specifications of the application deployment. 
&nbsp;&nbsp;docker_app | **[DockerApp](#DockerApp1)**<br>Specifications of the application deployment. 


### HardwareSpec {#HardwareSpec1}

Field | Description
--- | ---
memory | **int64**<br>RAM amount, Gb. 
cores | **int64**<br>Number of cores. 
gpus | **int64**<br>Number of GPUs. 
compatibility_requirements[] | **string**<br>List of additional hardware requirements. 
image | **string**<br>Docker image. 
name | **string**<br>Required. Name of the hardware spec. 


### ServantApp {#ServantApp1}

Field | Description
--- | ---
checkpoint | **[Checkpoint](#Checkpoint2)**<br>Required. Checkpoint used for node creation. 
signature | **[Signature](#Signature1)**<br>Description of the input and output. 
jupyter_kernel_spec | **[JupyterKernelSpec](#JupyterKernelSpec1)**<br>Jupyter kernel specification. 


### Signature {#Signature1}

Field | Description
--- | ---
input_parameters[] | **[Parameter](#Parameter1)**<br>List of the input parameters. 
output_parameters[] | **[Parameter](#Parameter1)**<br>List of the output parameters. 


### Parameter {#Parameter1}

Field | Description
--- | ---
name | **string**<br>Required. Name of the parameter. 
type | **string**<br>Type of the parameter. 
description | **string**<br>Description of the parameter. 


### JupyterKernelSpec {#JupyterKernelSpec1}

Field | Description
--- | ---
docker_image | **string**<br>Required. Docker image name. 
username | **string**<br>Docker repository username. 
password_secret | **string**<br>Docker repository password secret. 


### DockerApp {#DockerApp1}

Field | Description
--- | ---
container | **[Container](#Container1)**<br>Required.  
endpoint | **[Endpoint](#Endpoint2)**<br>Required.  
telemetry | **[Telemetry](#Telemetry1)**<br> 
healthcheck | **[Healthcheck](#Healthcheck1)**<br> 


### Container {#Container1}

Field | Description
--- | ---
image | **string**<br>Required. Docker image name. 
username | **string**<br>Docker repository username. 
password_secret | **string**<br>Docker repository password secret. 
ports[] | **[ContainerPort](#ContainerPort1)**<br>Docker port bindings. 


### ContainerPort {#ContainerPort1}

Field | Description
--- | ---
container_port | **int64**<br>Container port to bind. 
host_port | **int64**<br>Host port to bind to. 
host_ip | **string**<br>Host IP address. 
protocol | **string**<br>Port protocol. 


### Endpoint {#Endpoint2}

Field | Description
--- | ---
port | **int64**<br>Port of the endpoint. Acceptable values are 0 to 65535, inclusive.
endpoint_options | **[EndpointOptions](#EndpointOptions1)**<br>Endpoint options. 
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Endpoint response timeout. 
idle_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Idle timeout for endpoint. Defines amount of time connection could exist without activity. 


### EndpointOptions {#EndpointOptions1}

Field | Description
--- | ---
endpoint_type | **oneof:** `http` or `grpc`<br>
&nbsp;&nbsp;http | **[HttpEndpoint](#HttpEndpoint1)**<br>HTTP endpoint. 
&nbsp;&nbsp;grpc | **[GrpcEndpoint](#GrpcEndpoint1)**<br>gRPC endpoint. 


### HttpEndpoint {#HttpEndpoint1}

Field | Description
--- | ---
use_http2 | **bool**<br>Use HTTP/2 protocol. 


### GrpcEndpoint {#GrpcEndpoint1}



### Telemetry {#Telemetry1}

Field | Description
--- | ---
path | **string**<br>Required. Relative path of the endpoint. 
port | **int64**<br>Port. Acceptable values are 0 to 65535, inclusive.
format | enum **Format**<br>Required. Metrics format. <ul><li>`SOLOMON_JSON`: Solomon (JSON) metrics format.</li><li>`PROMETHEUS`: Prometheus metrics format.</li></ul>


### Healthcheck {#Healthcheck1}

Field | Description
--- | ---
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Timeout for performing healthcheck. 
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Interval for perform healthcheck. 
fails_threshold | **int64**<br>Number of subsequent healthcheck failures required to mark instance unhealthy. Value must be greater than 0.
passes_threshold | **int64**<br>Number of subsequent healthcheck passes required to mark instance healthy. Value must be greater than 0.
healthcheck_port | **int64**<br>Port to check health onto. Acceptable values are 0 to 65535, inclusive.
healthcheck | **oneof:** `http` or `grpc`<br>Healthcheck implementation.
&nbsp;&nbsp;http | **[HttpHealthcheck](#HttpHealthcheck1)**<br>Healthcheck implementation. 
&nbsp;&nbsp;grpc | **[GrpcHealthcheck](#GrpcHealthcheck1)**<br>Healthcheck implementation. 


### HttpHealthcheck {#HttpHealthcheck1}

Field | Description
--- | ---
path | **string**<br>Path for healthcheck. Only HTTP response code will be checked. 


### GrpcHealthcheck {#GrpcHealthcheck1}

Field | Description
--- | ---
service | **string**<br>Service to check. 


### Policies {#Policies1}

Field | Description
--- | ---
availability_policy | **[AvailabilityPolicy](#AvailabilityPolicy1)**<br>Required. Availability policies. 
scale_policy | **[ScalePolicy](#ScalePolicy1)**<br>Scaling policies. 


### AvailabilityPolicy {#AvailabilityPolicy1}

Field | Description
--- | ---
zones[] | **[ZoneAvailability](#ZoneAvailability1)**<br>List of zone availability policies. The minimum number of elements is 1.


### ZoneAvailability {#ZoneAvailability1}

Field | Description
--- | ---
zone_id | **string**<br>Required. ID of the zone. 
min_count | **int64**<br>Minimal number of running instances. Value must be greater than 0.
max_count | **int64**<br>Maximum number of running instances. 
subnet_id | **string**<br>ID of the subnet. 


### ScalePolicy {#ScalePolicy1}

Field | Description
--- | ---
policy | **oneof:** `sessions_per_instance`<br>
&nbsp;&nbsp;sessions_per_instance | **[SessionBasedScalePolicy](#SessionBasedScalePolicy1)**<br> 


### SessionBasedScalePolicy {#SessionBasedScalePolicy1}

Field | Description
--- | ---
sessions_per_instance | **int64**<br>Maximum number of concurrent sessions per instance. 


### Permissions {#Permissions1}

Field | Description
--- | ---
folders[] | **string**<br>List of folders. 


### Instance {#Instance1}

Field | Description
--- | ---
instance_id | **string**<br>Required. ID of the instance. 
status | enum **Status**<br>Required. Status of the instance. <ul><li>`HEALTHY`: Instance is healthy and ready for load balancer.</li><li>`UNHEALTHY`: Instance has problems and excluded from load balancing.</li><li>`OUTDATED`: Instance is outdated.</li><li>`PREPARING`: Instance is preparing to service requests.</li><li>`UNDEFINED`: Initial instance state; VM not created.</li><li>`CREATED`: VM created for instance.</li><li>`STARTED`: Connection with instance VM established.</li><li>`DELETING`: Instance deletion is in progress.</li><li>`DELETED`: Instance is deleted.</li></ul>
updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when instance was last updated. 
endpoint | **[Endpoint](#Endpoint3)**<br>Instance endpoint. 
zone_id | **string**<br>Zone ID of the instance. 
billed_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when instance was last billed. 


### Endpoint {#Endpoint3}

Field | Description
--- | ---
address | **string**<br>Endpoint address. 
port | **int64**<br>Endpoint port. 


### AliasList {#AliasList1}

Field | Description
--- | ---
listed_aliases[] | **[ListedAlias](#ListedAlias1)**<br>List of node aliases. 


### ListedAlias {#ListedAlias1}

Field | Description
--- | ---
alias | **[nodedeployer.NodeAlias](./nodedeployer/billing_spec#NodeAlias)**<br>Node alias. 


### NodeAlias {#NodeAlias1}

Field | Description
--- | ---
name | **string**<br>Required. Name of the node alias. 2-79 characters long. 
project_id | **string**<br>Required. ID of the project. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Required. Time the node alias was created. 
created_by_id | **string**<br>Required. ID of the user who created the node alias. 
execution_acl | **[ACL](#ACL1)**<br>ACL for the node alias. 
proxy_metadata | **[ProxyMetadata](#ProxyMetadata1)**<br>Metadata that should be passed to backends. 
backends | **[Backends](#Backends1)**<br>Required. Backends. 
billing_spec | **[BillingSpec](#BillingSpec1)**<br>Billing specifications. 
updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when node alias was last updated. 
folder_id | **string**<br>Required. ID of the folder. 


### ACL {#ACL1}

Field | Description
--- | ---
entries[] | **[ACLEntry](#ACLEntry1)**<br>List of ACL entries. 
permission | **string**<br>Permission. 
is_public | **bool**<br>If true, allows everyone requests to alias 


### ACLEntry {#ACLEntry1}

Field | Description
--- | ---
entry | **oneof:** `folder_entry`<br>
&nbsp;&nbsp;folder_entry | **[ACLFolderEntry](#ACLFolderEntry1)**<br> 


### ACLFolderEntry {#ACLFolderEntry1}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder. 


### ProxyMetadata {#ProxyMetadata1}

Field | Description
--- | ---
headers[] | **[Header](#Header1)**<br>List of headers. 


### Header {#Header1}

Field | Description
--- | ---
name | **string**<br>Required. Name of th header. 
value | **string**<br>Required. Value of the header. 


### Backends {#Backends1}

Field | Description
--- | ---
backend[] | **[Backend](#Backend1)**<br>List of backends. The minimum number of elements is 1.


### Backend {#Backend1}

Field | Description
--- | ---
node_id | **string**<br>Required. ID of the node. 
weight | **double**<br>Balancer weight of the node. Value must be greater than 0.


### BillingSpec {#BillingSpec1}

Field | Description
--- | ---
billing_id | **string**<br>Required. Billing ID. 
billing_descriptor | **oneof:** `yandex_cloud_billing_descriptor`<br>
&nbsp;&nbsp;yandex_cloud_billing_descriptor | **[YandexCloudBillingDescriptor](#YandexCloudBillingDescriptor1)**<br> 


### YandexCloudBillingDescriptor {#YandexCloudBillingDescriptor1}

Field | Description
--- | ---
schema | **string**<br>Required. Billing schema. 
units | **string**<br>Required. Billing units. 
default_quantity | **int64**<br>Default billing quantity. 


