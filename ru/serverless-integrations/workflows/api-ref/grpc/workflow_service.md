---
editable: false
sourcePath: en/_api-ref-grpc/functions/workflows/workflows/api-ref/grpc/workflow_service.md
---

# Workflows Service, gRPC: WorkflowService

Set of methods for managing Workflows.

| Call | Description |
| --- | --- |
| [Create](#Create) | Creates Workflow in specified folder. |
| [Update](#Update) | Updates specified Workflow. |
| [Get](#Get) | Retrieves specified Workflow. |
| [Delete](#Delete) | Deletes specified Workflow. |
| [List](#List) | Retrieves list of Workflows in specified folder. |
| [ListOperations](#ListOperations) | Lists operations for specified Workflow. |

## Calls WorkflowService {#calls}

## Create {#Create}

Creates Workflow in specified folder.

**rpc Create ([CreateWorkflowRequest](#CreateWorkflowRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateWorkflowMetadata](#CreateWorkflowMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Workflow](#Workflow)<br>

### CreateWorkflowRequest {#CreateWorkflowRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to create Workflow in. 
name | **string**<br>Required. Name of Workflow. The name must be unique within the folder. Value must match the regular expression ` \|[a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
description | **string**<br>Description of Workflow. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Workflow labels as `key:value` pairs. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_./\\@0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_./\\@0-9a-z]* `.
specification | **[WorkflowSpecification](#WorkflowSpecification)**<br>Required. Specification of Workflow 
log_options | **[LogOptions](#LogOptions)**<br>Options for logging from Workflow. 
network_id | **string**<br>ID of the VPC network Workflow will be executed in, in order to access private resources. 
service_account_id | **string**<br>ID of the Service Account which will be used for resources access in Workflow execution. 


### WorkflowSpecification {#WorkflowSpecification}

Field | Description
--- | ---
spec | **oneof:** `spec_yaml`<br>
&nbsp;&nbsp;spec_yaml | **string**<br>Workflow specification in YAML format. 


### LogOptions {#LogOptions}

Field | Description
--- | ---
disabled | **bool**<br>Is logging from Workflow disabled. 
destination | **oneof:** `log_group_id` or `folder_id`<br>
&nbsp;&nbsp;log_group_id | **string**<br>ID of the logging group which should be used for Workflows logs. 
&nbsp;&nbsp;folder_id | **string**<br>ID of the folder which default logging group should be used for Workflows. 
min_level | **`yandex.cloud.logging.v1.LogLevel.Level`**<br>Minimum logs level. <br>See [LogLevel.Level] for details. 


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateWorkflowMetadata](#CreateWorkflowMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Workflow](#Workflow)>**<br>if operation finished successfully. 


### CreateWorkflowMetadata {#CreateWorkflowMetadata}

Field | Description
--- | ---
workflow_id | **string**<br>Required. ID of the Workflow. 


### Workflow {#Workflow}

Field | Description
--- | ---
id | **string**<br>ID of the Workflow. Generated at creation time. 
folder_id | **string**<br>ID of the folder that the Workflow belongs to. 
specification | **[WorkflowSpecification](#WorkflowSpecification1)**<br>Specification of the Workflow 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp for the Workflow. 
name | **string**<br>Name of the Workflow. The name is unique within the folder. 
description | **string**<br>Description of the Workflow. 
labels | **map<string,string>**<br>Workflow labels as `key:value` pairs. 
status | enum **Status**<br>Status of the Workflow. <ul><li>`CREATING`: Workflow is being created.</li><li>`ACTIVE`: Workflow is ready for use.</li><li>`UPDATING`: Workflow is being updated.</li><li>`DELETING`: Workflow is being deleted.</li><li>`ERROR`: Workflow failed. The only allowed action is delete.</li></ul>
log_options | **[LogOptions](#LogOptions1)**<br>Options for logging from the Workflow. 
network_id | **string**<br>ID of the VPC network Workflow will be executed in, in order to access private resources. 
service_account_id | **string**<br>ID of the Service Account which will be used for resource access in Workflow execution. 


## Update {#Update}

Updates specified Workflow.

**rpc Update ([UpdateWorkflowRequest](#UpdateWorkflowRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateWorkflowMetadata](#UpdateWorkflowMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Workflow](#Workflow1)<br>

### UpdateWorkflowRequest {#UpdateWorkflowRequest}

Field | Description
--- | ---
workflow_id | **string**<br>Required. ID of the Workflow. 
name | **string**<br>Name of the Workflow. The name is unique within the folder. Value must match the regular expression ` \|[a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
description | **string**<br>Description of the Workflow. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Workflow labels as `key:value` pairs. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_./\\@0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_./\\@0-9a-z]* `.
specification | **[WorkflowSpecification](#WorkflowSpecification1)**<br>Specification of the Workflow. 
log_options | **[LogOptions](#LogOptions1)**<br>Options for logging from the Workflow. 
network_id | **string**<br>ID of the VPC network Workflow will be executed in, in order to access private resources. 
service_account_id | **string**<br>ID of the Service Account which will be used for resources access in Workflow execution. 
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Field mask that specifies which fields of the Workflow should be updated. 


### WorkflowSpecification {#WorkflowSpecification1}

Field | Description
--- | ---
spec | **oneof:** `spec_yaml`<br>
&nbsp;&nbsp;spec_yaml | **string**<br>Workflow specification in YAML format. 


### LogOptions {#LogOptions1}

Field | Description
--- | ---
disabled | **bool**<br>Is logging from Workflow disabled. 
destination | **oneof:** `log_group_id` or `folder_id`<br>
&nbsp;&nbsp;log_group_id | **string**<br>ID of the logging group which should be used for Workflows logs. 
&nbsp;&nbsp;folder_id | **string**<br>ID of the folder which default logging group should be used for Workflows. 
min_level | **`yandex.cloud.logging.v1.LogLevel.Level`**<br>Minimum logs level. <br>See [LogLevel.Level] for details. 


### Operation {#Operation1}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateWorkflowMetadata](#UpdateWorkflowMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Workflow](#Workflow1)>**<br>if operation finished successfully. 


### UpdateWorkflowMetadata {#UpdateWorkflowMetadata}

Field | Description
--- | ---
workflow_id | **string**<br>Required. ID of the Workflow. 


### Workflow {#Workflow1}

Field | Description
--- | ---
id | **string**<br>ID of the Workflow. Generated at creation time. 
folder_id | **string**<br>ID of the folder that the Workflow belongs to. 
specification | **[WorkflowSpecification](#WorkflowSpecification2)**<br>Specification of the Workflow 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp for the Workflow. 
name | **string**<br>Name of the Workflow. The name is unique within the folder. 
description | **string**<br>Description of the Workflow. 
labels | **map<string,string>**<br>Workflow labels as `key:value` pairs. 
status | enum **Status**<br>Status of the Workflow. <ul><li>`CREATING`: Workflow is being created.</li><li>`ACTIVE`: Workflow is ready for use.</li><li>`UPDATING`: Workflow is being updated.</li><li>`DELETING`: Workflow is being deleted.</li><li>`ERROR`: Workflow failed. The only allowed action is delete.</li></ul>
log_options | **[LogOptions](#LogOptions2)**<br>Options for logging from the Workflow. 
network_id | **string**<br>ID of the VPC network Workflow will be executed in, in order to access private resources. 
service_account_id | **string**<br>ID of the Service Account which will be used for resource access in Workflow execution. 


## Get {#Get}

Retrieves specified Workflow.

**rpc Get ([GetWorkflowRequest](#GetWorkflowRequest)) returns ([GetWorkflowResponse](#GetWorkflowResponse))**

### GetWorkflowRequest {#GetWorkflowRequest}

Field | Description
--- | ---
workflow_id | **string**<br>Required. ID of the Workflow. 


### GetWorkflowResponse {#GetWorkflowResponse}

Field | Description
--- | ---
workflow | **[Workflow](#Workflow2)**<br>Workflow properties. 


### Workflow {#Workflow2}

Field | Description
--- | ---
id | **string**<br>ID of the Workflow. Generated at creation time. 
folder_id | **string**<br>ID of the folder that the Workflow belongs to. 
specification | **[WorkflowSpecification](#WorkflowSpecification2)**<br>Specification of the Workflow 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp for the Workflow. 
name | **string**<br>Name of the Workflow. The name is unique within the folder. 
description | **string**<br>Description of the Workflow. 
labels | **map<string,string>**<br>Workflow labels as `key:value` pairs. 
status | enum **Status**<br>Status of the Workflow. <ul><li>`CREATING`: Workflow is being created.</li><li>`ACTIVE`: Workflow is ready for use.</li><li>`UPDATING`: Workflow is being updated.</li><li>`DELETING`: Workflow is being deleted.</li><li>`ERROR`: Workflow failed. The only allowed action is delete.</li></ul>
log_options | **[LogOptions](#LogOptions2)**<br>Options for logging from the Workflow. 
network_id | **string**<br>ID of the VPC network Workflow will be executed in, in order to access private resources. 
service_account_id | **string**<br>ID of the Service Account which will be used for resource access in Workflow execution. 


### WorkflowSpecification {#WorkflowSpecification2}

Field | Description
--- | ---
spec | **oneof:** `spec_yaml`<br>
&nbsp;&nbsp;spec_yaml | **string**<br>Workflow specification in YAML format. 


### LogOptions {#LogOptions2}

Field | Description
--- | ---
disabled | **bool**<br>Is logging from Workflow disabled. 
destination | **oneof:** `log_group_id` or `folder_id`<br>
&nbsp;&nbsp;log_group_id | **string**<br>ID of the logging group which should be used for Workflows logs. 
&nbsp;&nbsp;folder_id | **string**<br>ID of the folder which default logging group should be used for Workflows. 
min_level | **`yandex.cloud.logging.v1.LogLevel.Level`**<br>Minimum logs level. <br>See [LogLevel.Level] for details. 


## Delete {#Delete}

Deletes specified Workflow.

**rpc Delete ([DeleteWorkflowRequest](#DeleteWorkflowRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteWorkflowMetadata](#DeleteWorkflowMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteWorkflowRequest {#DeleteWorkflowRequest}

Field | Description
--- | ---
workflow_id | **string**<br>Required. ID of the Workflow. 


### Operation {#Operation2}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteWorkflowMetadata](#DeleteWorkflowMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### DeleteWorkflowMetadata {#DeleteWorkflowMetadata}

Field | Description
--- | ---
workflow_id | **string**<br>ID of the Workflow. 


## List {#List}

Retrieves list of Workflows in specified folder.

**rpc List ([ListWorkflowsRequest](#ListWorkflowsRequest)) returns ([ListWorkflowsResponse](#ListWorkflowsResponse))**

### ListWorkflowsRequest {#ListWorkflowsRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to list Workflows in. 
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `pageSize`, the service returns a [ListWorkflowsResponse.next_page_token](#ListWorkflowsResponse) that can be used to get the next page of results in subsequent list requests. <br>Default value: 100. 
page_token | **string**<br>Page token. To get the next page of results, set `pageToken` to the [ListWorkflowsResponse.next_page_token](#ListWorkflowsResponse) returned by a previous list request. 
filter | **string**<br>A filter expression that filters functions listed in the response. <br>The expression must specify: <ol><li>The field name. Currently filtering can only be applied to following fields: name, created_at. </li><li>An `=` operator. </li><li>The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z]([-a-z0-9]{0,61}[a-z0-9])?`. </li></ol>Example of a filter: `name=my-workflow`. 


### ListWorkflowsResponse {#ListWorkflowsResponse}

Field | Description
--- | ---
workflows[] | **[WorkflowPreview](#WorkflowPreview)**<br>List of Workflows. 
next_page_token | **string**<br>Token for getting the next page of the list. If the number of results is greater than the specified [ListWorkflowsRequest.page_size](#ListWorkflowsRequest), use `next_page_token` as the value for the [ListWorkflowsRequest.page_token](#ListWorkflowsRequest) parameter in the next list request. <br>Each subsequent page will have its own `next_page_token` to continue paging through the results. 


### WorkflowPreview {#WorkflowPreview}

Field | Description
--- | ---
id | **string**<br>ID of the Workflow. Generated at creation time. 
folder_id | **string**<br>ID of the folder that the Workflow belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp for the Workflow. 
name | **string**<br>Name of the Workflow. The name is unique within the folder. 
description | **string**<br>Description of the Workflow. 
labels | **map<string,string>**<br>Workflow labels as `key:value` pairs. 
status | **[Workflow.Status](#Workflow3)**<br>Status of the Workflow. 
log_options | **[LogOptions](#LogOptions3)**<br>Options for logging from the Workflow. 
network_id | **string**<br>ID of the VPC network Workflow will be executed in, in order to access private resources. 
service_account_id | **string**<br>ID of the Service Account which will be used for resources access in Workflow execution. 


### LogOptions {#LogOptions3}

Field | Description
--- | ---
disabled | **bool**<br>Is logging from Workflow disabled. 
destination | **oneof:** `log_group_id` or `folder_id`<br>
&nbsp;&nbsp;log_group_id | **string**<br>ID of the logging group which should be used for Workflows logs. 
&nbsp;&nbsp;folder_id | **string**<br>ID of the folder which default logging group should be used for Workflows. 
min_level | **`yandex.cloud.logging.v1.LogLevel.Level`**<br>Minimum logs level. <br>See [LogLevel.Level] for details. 


## ListOperations {#ListOperations}

Lists operations for specified Workflow.

**rpc ListOperations ([ListOperationsRequest](#ListOperationsRequest)) returns ([ListOperationsResponse](#ListOperationsResponse))**

### ListOperationsRequest {#ListOperationsRequest}

Field | Description
--- | ---
workflow_id | **string**<br>Required. ID of the Workflow to list operations for. 
page_size | **int64**<br>The maximum number of results per page that should be returned. If the number of available results is larger than `pageSize`, the service returns a [ListOperationsResponse.next_page_token](#ListOperationsResponse) that can be used to get the next page of results in subsequent list requests. <br>Default value: 100. Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br>Page token. To get the next page of results, set `pageToken` to the [ListOperationsResponse.next_page_token](#ListOperationsResponse) returned by a previous list request. The maximum string length in characters is 100.
filter | **string**<br>A filter expression that filters resources listed in the response. <br>The expression must specify: <ol><li>The field name. Currently filtering can be applied to the [operation.Operation.done](#Operation3), [operation.Operation.created_by](#Operation3) field. </li><li>An `=` operator. </li><li>The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`. </li></ol>Examples of a filter: `done=false`, `created_by='John.Doe'`. The maximum string length in characters is 1000.


### ListOperationsResponse {#ListOperationsResponse}

Field | Description
--- | ---
operations[] | **[operation.Operation](#Operation3)**<br>List of operations for the specified Workflow. 
next_page_token | **string**<br>Token for getting the next page of the list. If the number of results is greater than the specified [ListOperationsRequest.page_size](#ListOperationsRequest), use `next_page_token` as the value for the [ListOperationsRequest.page_token](#ListOperationsRequest) parameter in the next list request. <br>Each subsequent page will have its own `next_page_token` to continue paging through the results. 


### Operation {#Operation3}

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


