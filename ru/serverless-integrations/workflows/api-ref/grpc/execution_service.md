---
editable: false
sourcePath: en/_api-ref-grpc/functions/workflows/workflows/api-ref/grpc/execution_service.md
---

# Workflows Service, gRPC: ExecutionService

Set of methods for managing Workflows Executions.

| Call | Description |
| --- | --- |
| [Start](#Start) | Starts new Workflow execution. |
| [Stop](#Stop) | Stops specified Workflow execution. |
| [Get](#Get) | Retrieves specified Workflow execution. |
| [GetHistory](#GetHistory) | Retrieves detailed history of specified Workflow execution. |
| [List](#List) | Retrieves list of Workflow executions. |

## Calls ExecutionService {#calls}

## Start {#Start}

Starts new Workflow execution.

**rpc Start ([StartExecutionRequest](#StartExecutionRequest)) returns ([StartExecutionResponse](#StartExecutionResponse))**

### StartExecutionRequest {#StartExecutionRequest}

Field | Description
--- | ---
workflow_id | **string**<br>Required. ID of the Workflow. 
input | **[ExecutionInput](#ExecutionInput)**<br>Input for the Workflow execution 


### ExecutionInput {#ExecutionInput}

Field | Description
--- | ---
input | **oneof:** `input_json`<br>
&nbsp;&nbsp;input_json | **string**<br>JSON input data for the Workflow execution. 


### StartExecutionResponse {#StartExecutionResponse}

Field | Description
--- | ---
execution_id | **string**<br>ID of the Workflow execution. 


## Stop {#Stop}

Stops specified Workflow execution.

**rpc Stop ([StopExecutionRequest](#StopExecutionRequest)) returns ([StopExecutionResponse](#StopExecutionResponse))**

### StopExecutionRequest {#StopExecutionRequest}

Field | Description
--- | ---
execution_id | **string**<br>Required. ID of the Workflow execution. 


### StopExecutionResponse {#StopExecutionResponse}

Field | Description
--- | ---
execution_id | **string**<br>ID of the Workflow execution. 


## Get {#Get}

Retrieves specified Workflow execution.

**rpc Get ([GetExecutionRequest](#GetExecutionRequest)) returns ([GetExecutionResponse](#GetExecutionResponse))**

### GetExecutionRequest {#GetExecutionRequest}

Field | Description
--- | ---
execution_id | **string**<br>Required. ID of the Workflow execution. 


### GetExecutionResponse {#GetExecutionResponse}

Field | Description
--- | ---
execution | **[Execution](#Execution)**<br>Workflow execution details. 


### Execution {#Execution}

Field | Description
--- | ---
id | **string**<br>ID of the Workflow execution. Generated at creation time. 
workflow_id | **string**<br>ID of the Workflow. 
input | **[ExecutionInput](#ExecutionInput1)**<br>Input data for the Workflow execution. 
result | **[ExecutionResult](#ExecutionResult)**<br>Result of the Workflow execution. 
error | **[ExecutionError](#ExecutionError)**<br>Error details, in case Workflow execution failed. 
status | enum **Status**<br>Status of the Workflow execution <ul><li>`QUEUED`: Workflow execution is being queued.</li><li>`RUNNING`: Workflow execution is running.</li><li>`PAUSED`: Workflow execution is being paused.</li><li>`STOPPED`: Workflow execution is stopped.</li><li>`FAILED`: Workflow execution is failed.</li><li>`FINISHED`: Workflow execution is finished.</li></ul>
started_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Start timestamp for the Workflow execution. 
duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Duration of the Workflow execution. 


### ExecutionInput {#ExecutionInput1}

Field | Description
--- | ---
input | **oneof:** `input_json`<br>
&nbsp;&nbsp;input_json | **string**<br>JSON input data for the Workflow execution. 


### ExecutionResult {#ExecutionResult}

Field | Description
--- | ---
result | **oneof:** `result_json`<br>
&nbsp;&nbsp;result_json | **string**<br>JSON result of the Workflow execution. 


### ExecutionError {#ExecutionError}

Field | Description
--- | ---
message | **string**<br>Error message of the Workflow execution. 
error_code | **string**<br>Error code of the Workflow execution. 


## GetHistory {#GetHistory}

Retrieves detailed history of specified Workflow execution.

**rpc GetHistory ([GetExecutionHistoryRequest](#GetExecutionHistoryRequest)) returns ([GetExecutionHistoryResponse](#GetExecutionHistoryResponse))**

### GetExecutionHistoryRequest {#GetExecutionHistoryRequest}

Field | Description
--- | ---
execution_id | **string**<br>Required. ID of the Workflow execution. 


### GetExecutionHistoryResponse {#GetExecutionHistoryResponse}

Field | Description
--- | ---
execution | **[ExecutionPreview](#ExecutionPreview)**<br>Workflow execution details. 
entries[] | **[HistoryEntry](#HistoryEntry)**<br>Workflow execution detailed history items. The number of elements must be greater than 0.


### ExecutionPreview {#ExecutionPreview}

Field | Description
--- | ---
id | **string**<br>ID of the Workflow execution. Generated at creation time. 
workflow_id | **string**<br>ID of the Workflow. 
status | **[Execution.Status](#Execution1)**<br>Status of the Workflow execution 
started_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Start timestamp for the Workflow execution. 
duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Duration of the Workflow execution. 


### HistoryEntry {#HistoryEntry}

Field | Description
--- | ---
id | **string**<br>ID of the Workflow step. 
title | **string**<br>Title of the Workflow step. 
description | **string**<br>Description of the Workflow step. 
started_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Start timestamp for the Workflow step. 
duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Duration of the Workflow step. 
input | **[HistoryEntryInput](#HistoryEntryInput)**<br>Input data for the Workflow step. 
output | **[HistoryEntryOutput](#HistoryEntryOutput)**<br>Result of the Workflow step. 
error | **[HistoryEntryError](#HistoryEntryError)**<br>Error details, in case Workflow step failed. 
status | enum **Status**<br>Status of the Workflow step. <ul><li>`SCHEDULED`: Step execution is being scheduled.</li><li>`STARTED`: Step execution is started.</li><li>`COMPLETED`: Step execution is completed.</li><li>`FAILED`: Step execution is failed.</li><li>`CANCEL_REQUESTED`: Step execution is requested to be cancelled.</li><li>`CANCELLED`: Step execution is canceled.</li></ul>
type | **string**<br>Type of the Workflow step (for example, FunctionCall or HttpCall). 


### HistoryEntryInput {#HistoryEntryInput}

Field | Description
--- | ---
input | **oneof:** `input_json`<br>
&nbsp;&nbsp;input_json | **string**<br>JSON input data for the Workflow step. 


### HistoryEntryOutput {#HistoryEntryOutput}

Field | Description
--- | ---
output | **oneof:** `output_json`<br>
&nbsp;&nbsp;output_json | **string**<br>JSON result for the Workflow step. 


### HistoryEntryError {#HistoryEntryError}

Field | Description
--- | ---
message | **string**<br>Error message of the Workflow step. 
error_code | **string**<br>Error code of the Workflow step. 


## List {#List}

Retrieves list of Workflow executions.

**rpc List ([ListExecutionsRequest](#ListExecutionsRequest)) returns ([ListExecutionsResponse](#ListExecutionsResponse))**

### ListExecutionsRequest {#ListExecutionsRequest}

Field | Description
--- | ---
workflow_id | **string**<br>Required. ID of the Workflow. 
page_size | **int64**<br>The maximum number of results per page that should be returned. If the number of available results is larger than `pageSize`, the service returns a [ListExecutionsResponse.next_page_token](#ListExecutionsResponse) that can be used to get the next page of results in subsequent list requests. <br>Default value: 100. Acceptable values are 0 to 2147483647, inclusive.
page_token | **string**<br>Page token. To get the next page of results, set `pageToken` to the [ListExecutionsResponse.next_page_token](#ListExecutionsResponse) returned by a previous list request. 
filter | **string**<br>A filter expression that filters resources listed in the response. <br>The expression must specify: <ol><li>The field name. Currently filtering can be applied to the following fields: status, started_at, finished_at. </li><li>Operator: `=`, `<` or `>`. </li><li>The value. Must be sting and match the regular expression `[+:\.-a-z0-9]`. </li></ol>Examples of a filter: `status=ERROR`, `created_by=John.Doe`. 


### ListExecutionsResponse {#ListExecutionsResponse}

Field | Description
--- | ---
executions[] | **[ExecutionPreview](#ExecutionPreview1)**<br>List of Workflow executions. 
next_page_token | **string**<br>Token for getting the next page of the list. If the number of results is greater than the specified [ListExecutionsRequest.page_size](#ListExecutionsRequest), use `next_page_token` as the value for the [ListExecutionsRequest.page_token](#ListExecutionsRequest) parameter in the next list request. <br>Each subsequent page will have its own `next_page_token` to continue paging through the results. 


### ExecutionPreview {#ExecutionPreview1}

Field | Description
--- | ---
id | **string**<br>ID of the Workflow execution. Generated at creation time. 
workflow_id | **string**<br>ID of the Workflow. 
status | **[Execution.Status](#Execution1)**<br>Status of the Workflow execution 
started_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Start timestamp for the Workflow execution. 
duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Duration of the Workflow execution. 


