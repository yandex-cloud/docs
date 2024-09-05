---
editable: false
sourcePath: en/_api-ref-grpc/backup/backup/backup/api-ref/grpc/resource_service.md
---

# Cloud Backup API, gRPC: ResourceService

A set of methods for managing backup resources: [Compute Cloud instances](/docs/backup/concepts/vm-connection#os).

| Call | Description |
| --- | --- |
| [List](#List) | List resources: Compute Cloud instances. |
| [Get](#Get) | Get specific Compute Cloud instance. |
| [Delete](#Delete) | Delete specific Compute Cloud instance from Cloud Backup. |
| [ListTasks](#ListTasks) | List tasks of resources. |
| [ListDirectory](#ListDirectory) | ListDirectory returns all subdirectories found in requested directory identified by the id. |
| [CreateDirectory](#CreateDirectory) | CreateDirectory creates new directory by requested path. |
| [ListOperations](#ListOperations) | ListOperations return all operations in backup service for given instance |

## Calls ResourceService {#calls}

## List {#List}

List resources: Compute Cloud instances.

**rpc List ([ListResourcesRequest](#ListResourcesRequest)) returns ([ListResourcesResponse](#ListResourcesResponse))**

### ListResourcesRequest {#ListResourcesRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. Folder ID. The maximum string length in characters is 50.
page_size | **int64**<br>Number of results per page. The maximum value is 1000.
page_token | **string**<br>Token for the results page. The maximum string length in characters is 100.
type | enum **ResourceType**<br>Type of resource. Could be compute VM or baremetal server. <ul><li>`COMPUTE`: Resource is Compute Cloud VM</li><li>`BMS`: Resource is baremetal server</li></ul>


### ListResourcesResponse {#ListResourcesResponse}

Field | Description
--- | ---
resources[] | **[Resource](#Resource)**<br>Set of resource parameters. 
next_page_token | **string**<br>Token for the next results page. 


### Resource {#Resource}

Field | Description
--- | ---
compute_instance_id | **string**<br>Compute Cloud instance ID. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
online | **bool**<br>If this field is true, it means that instance is online. 
enabled | **bool**<br>If this field is true, it means that backup is enabled to instance. 
status | enum **Status**<br> <ul><li>`IDLE`: Compute Cloud instance is doing nothing right now.</li><li>`BACKUPING`: Compute Cloud instance is currently backing up itself.</li><li>`RECOVERING`: Compute Cloud instance is currently recovering itself.</li><li>`FAILED`: Compute Cloud instance is in failure state, check content of `status_details` field for more information.</li><li>`OTHER`: Unspecified state, check `status_details` field for more information.</li></ul>
status_details | **string**<br>If status value is one of `OTHER` or `FAILED`, detailed info might be stored here. 
status_progress | **int64**<br>In case status is one of `BACKUPING` or `RECOVERING`, progress value might be found here. 
last_backup_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
next_backup_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
resource_id | **string**<br>Resource ID is used to identify Compute Cloud instance in backup service. 
is_active | **bool**<br>Status `is_active` shows whether current Compute Cloud instance controls Cloud Backup resource. If status `is_active` is false it means Compute Cloud instance is not able to manipulate Cloud Backup resource. 
init_status | enum **InitStatus**<br>Status of resource initialization in cloud backup service. <ul><li>`REGISTERING`: Registration of instance in cloud backups have started.</li><li>`REGISTRED`: Instance is registered in cloud backups.</li><li>`FAILED_REGISTRATION`: Instance registration failed.</li><li>`DELETED`: Instance is deleted from cloud backup service.</li></ul>
metadata | **string**<br>Metadata to provide details about instance registration process if status is FAILED_REGISTRATION or REGISTERING 
type | enum **ResourceType**<br>Type of resource. Could be compute VM or baremetal server. <ul><li>`COMPUTE`: Resource is Compute Cloud VM</li><li>`BMS`: Resource is baremetal server</li></ul>


## Get {#Get}

Get specific Compute Cloud instance.

**rpc Get ([GetResourceRequest](#GetResourceRequest)) returns ([GetResourceResponse](#GetResourceResponse))**

### GetResourceRequest {#GetResourceRequest}

Field | Description
--- | ---
compute_instance_id | **string**<br>Required. Compute Cloud instance ID. The maximum string length in characters is 50.


### GetResourceResponse {#GetResourceResponse}

Field | Description
--- | ---
resource | **[Resource](#Resource1)**<br>Set of resource parameters. 


### Resource {#Resource1}

Field | Description
--- | ---
compute_instance_id | **string**<br>Compute Cloud instance ID. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
online | **bool**<br>If this field is true, it means that instance is online. 
enabled | **bool**<br>If this field is true, it means that backup is enabled to instance. 
status | enum **Status**<br> <ul><li>`IDLE`: Compute Cloud instance is doing nothing right now.</li><li>`BACKUPING`: Compute Cloud instance is currently backing up itself.</li><li>`RECOVERING`: Compute Cloud instance is currently recovering itself.</li><li>`FAILED`: Compute Cloud instance is in failure state, check content of `status_details` field for more information.</li><li>`OTHER`: Unspecified state, check `status_details` field for more information.</li></ul>
status_details | **string**<br>If status value is one of `OTHER` or `FAILED`, detailed info might be stored here. 
status_progress | **int64**<br>In case status is one of `BACKUPING` or `RECOVERING`, progress value might be found here. 
last_backup_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
next_backup_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
resource_id | **string**<br>Resource ID is used to identify Compute Cloud instance in backup service. 
is_active | **bool**<br>Status `is_active` shows whether current Compute Cloud instance controls Cloud Backup resource. If status `is_active` is false it means Compute Cloud instance is not able to manipulate Cloud Backup resource. 
init_status | enum **InitStatus**<br>Status of resource initialization in cloud backup service. <ul><li>`REGISTERING`: Registration of instance in cloud backups have started.</li><li>`REGISTRED`: Instance is registered in cloud backups.</li><li>`FAILED_REGISTRATION`: Instance registration failed.</li><li>`DELETED`: Instance is deleted from cloud backup service.</li></ul>
metadata | **string**<br>Metadata to provide details about instance registration process if status is FAILED_REGISTRATION or REGISTERING 
type | enum **ResourceType**<br>Type of resource. Could be compute VM or baremetal server. <ul><li>`COMPUTE`: Resource is Compute Cloud VM</li><li>`BMS`: Resource is baremetal server</li></ul>


## Delete {#Delete}

Delete specific Compute Cloud instance from Cloud Backup. It does not delete instance from Cloud Compute service.

**rpc Delete ([DeleteResourceRequest](#DeleteResourceRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteResourceMetadata](#DeleteResourceMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteResourceRequest {#DeleteResourceRequest}

Field | Description
--- | ---
compute_instance_id | **string**<br>Required. Compute Cloud instance ID. The maximum string length in characters is 50.
resource_id | **string**<br>Required. Resource ID is used to identify Compute Cloud instance in backup service. 


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteResourceMetadata](#DeleteResourceMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### DeleteResourceMetadata {#DeleteResourceMetadata}

Field | Description
--- | ---
compute_instance_id | **string**<br>Compute Cloud instance ID. 


## ListTasks {#ListTasks}

List tasks of resources.

**rpc ListTasks ([ListTasksRequest](#ListTasksRequest)) returns ([ListTasksResponse](#ListTasksResponse))**

### ListTasksRequest {#ListTasksRequest}

Field | Description
--- | ---
compute_instance_id | **string**<br>Required. Compute Cloud instance ID. The maximum string length in characters is 50.
page_size | **int64**<br>Number of results per page. The maximum value is 1000.
page_token | **string**<br>Token for the results page. The maximum string length in characters is 100.


### ListTasksResponse {#ListTasksResponse}

Field | Description
--- | ---
tasks[] | **[Task](#Task)**<br>Set of tasks parameters. 
next_page_token | **string**<br>Token for the next results page. 


### Task {#Task}

Field | Description
--- | ---
id | **int64**<br>Task ID. 
cancellable | **bool**<br>Shows whether the task is cancellable. Note: task cancellation is not supported yet. 
policy_id | **string**<br>Policy ID. 
type | enum **Type**<br>Type of the task. 
progress | **[Progress](#Progress)**<br>Task progress. 
status | enum **Status**<br>Task status. 
enqueued_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
started_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
completed_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
compute_instance_id | **string**<br>Compute Cloud instance ID. 
result_code | enum **Code**<br>Task result code. 


### Progress {#Progress}

Field | Description
--- | ---
current | **int64**<br> 
total | **int64**<br> 


## ListDirectory {#ListDirectory}

ListDirectory returns all subdirectories found in requested directory identified by the id.

**rpc ListDirectory ([ListDirectoryRequest](#ListDirectoryRequest)) returns ([ListDirectoryResponse](#ListDirectoryResponse))**

### ListDirectoryRequest {#ListDirectoryRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. Folder ID. The maximum string length in characters is 50.
compute_instance_id | **string**<br>Required. Compute Cloud instance ID. 
path | **string**<br>Path to list items in. 


### ListDirectoryResponse {#ListDirectoryResponse}

Field | Description
--- | ---
items[] | **FilesystemItem**<br> 


### FilesystemItem {#FilesystemItem}

Field | Description
--- | ---
name | **string**<br>Item name. 
type | enum **Type**<br>Might be Volume, Directory of File. 
file_type | enum **Type**<br>Might be Directory or File. 
size | **int64**<br> 


## CreateDirectory {#CreateDirectory}

CreateDirectory creates new directory by requested path.

**rpc CreateDirectory ([CreateDirectoryRequest](#CreateDirectoryRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateDirectoryMetadata](#CreateDirectoryMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### CreateDirectoryRequest {#CreateDirectoryRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. Folder ID. The maximum string length in characters is 50.
compute_instance_id | **string**<br>Required. Compute Cloud instance ID. 
path | **string**<br>Required. Path to create directory in. 


### Operation {#Operation1}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateDirectoryMetadata](#CreateDirectoryMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### CreateDirectoryMetadata {#CreateDirectoryMetadata}

Field | Description
--- | ---
compute_instance_id | **string**<br>Compute Cloud instance ID. 
path | **string**<br>Path to create directory metadata in. 


## ListOperations {#ListOperations}

ListOperations return all operations in backup service for given instance

**rpc ListOperations ([ListResourceOperationsRequest](#ListResourceOperationsRequest)) returns ([ListResourceOperationsResponse](#ListResourceOperationsResponse))**

### ListResourceOperationsRequest {#ListResourceOperationsRequest}

Field | Description
--- | ---
compute_instance_id | **string**<br>Required. Compute Cloud instance ID. The maximum string length in characters is 50.
page_size | **int64**<br>Number of results per page. The maximum value is 1000.
page_token | **string**<br>Token for the results page. The maximum string length in characters is 100.


### ListResourceOperationsResponse {#ListResourceOperationsResponse}

Field | Description
--- | ---
operations[] | **[operation.Operation](#Operation2)**<br>List of operations for the specified instance. 
next_page_token | **string**<br>Token for the next results page. 


### Operation {#Operation2}

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
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**<br>The normal response of the operation in case of success. If the original method returns no data on success, such as Delete, the response is [google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty). If the original method is the standard Create/Update, the response should be the target resource of the operation. Any method that returns a long-running operation should document the response type, if any. 


