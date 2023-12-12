---
editable: false
sourcePath: en/_api-ref-grpc/load-testing/user/user/api-ref/grpc/config_service.md
---

# Load Testing API, gRPC: ConfigService

A set of methods for managing test configurations.

| Call | Description |
| --- | --- |
| [Create](#Create) | Creates a test config in the specified folder. |
| [Get](#Get) | Returns the specified config. |
| [List](#List) | Retrieves the list of configs in the specified folder. |

## Calls ConfigService {#calls}

## Create {#Create}

Creates a test config in the specified folder.

**rpc Create ([CreateConfigRequest](#CreateConfigRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateConfigMetadata](#CreateConfigMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[config.Config](#Config)<br>

### CreateConfigRequest {#CreateConfigRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to create a config in. The maximum string length in characters is 50.
config | **oneof:** `yaml_string`<br>Config content.
&nbsp;&nbsp;yaml_string | **string**<br>Config content provided as a string in YAML format. 


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateConfigMetadata](#CreateConfigMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[config.Config](#Config)>**<br>if operation finished successfully. 


### CreateConfigMetadata {#CreateConfigMetadata}

Field | Description
--- | ---
config_id | **string**<br>ID of the config that is being created. 


## Get {#Get}

Returns the specified config. <br>To get the list of all available configs, make a [List](#List) request.

**rpc Get ([GetConfigRequest](#GetConfigRequest)) returns ([config.Config](#Config))**

### GetConfigRequest {#GetConfigRequest}

Field | Description
--- | ---
config_id | **string**<br>ID of the config to return. 


## List {#List}

Retrieves the list of configs in the specified folder.

**rpc List ([ListConfigsRequest](#ListConfigsRequest)) returns ([ListConfigsResponse](#ListConfigsResponse))**

### ListConfigsRequest {#ListConfigsRequest}

Field | Description
--- | ---
folder_id | **string**<br>ID of the folder to list configs in. 
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListConfigsResponse.next_page_token](#ListConfigsResponse) that can be used to get the next page of results in subsequent list requests. Default value: 100. 
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListConfigsResponse.next_page_token](#ListConfigsResponse) returned by a previous list request. 


### ListConfigsResponse {#ListConfigsResponse}

Field | Description
--- | ---
configs[] | **[config.Config](#Config)**<br>List of configs in the specified folder. 
next_page_token | **string**<br>Token for getting the next page of the list. If the number of results is greater than the specified [ListConfigsRequest.page_size](#ListConfigsRequest), use `next_page_token` as the value for the [ListConfigsRequest.page_token](#ListConfigsRequest) parameter in the next list request. <br>Each subsequent page will have its own `next_page_token` to continue paging through the results. 


