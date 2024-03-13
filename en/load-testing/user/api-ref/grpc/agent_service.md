---
editable: false
sourcePath: en/_api-ref-grpc/load-testing/user/user/api-ref/grpc/agent_service.md
---

# Load Testing API, gRPC: AgentService

A set of methods for managing Load Testing agents.

| Call | Description |
| --- | --- |
| [Create](#Create) | Creates an agent in the specified folder. |
| [Get](#Get) | Returns the specified agent. |
| [List](#List) | Retrieves the list of agents in the specified folder. |
| [Delete](#Delete) | Deletes the specified agent. |
| [Update](#Update) | Updates the specified agent. |

## Calls AgentService {#calls}

## Create {#Create}

Creates an agent in the specified folder. <br>Also creates a corresponding compute instance.

**rpc Create ([CreateAgentRequest](#CreateAgentRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateAgentMetadata](#CreateAgentMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[agent.Agent](#Agent)<br>

### CreateAgentRequest {#CreateAgentRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to create an agent in. The maximum string length in characters is 50.
name | **string**<br>Name of the agent. <br>A created compute instance will have the same name. Value must match the regular expression ` \|[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br>Description of the agent. <br>A created compute instance will have the same description. The maximum string length in characters is 256.
compute_instance_params | **[agent.CreateComputeInstance](#CreateComputeInstance)**<br>Parameters for compute instance to be created. 
agent_version | **string**<br>Version of the agent. <br>If not provided, the most recent agent version will be used. 
labels | **map<string,string>**<br>Agent labels as `key:value` pairs. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.


### CreateComputeInstance {#CreateComputeInstance}

Field | Description
--- | ---
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_./\\@0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_./\\@0-9a-z]* `.
zone_id | **string**<br>Required. ID of the availability zone where the instance resides. To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/api-ref/grpc/zone_service#List) request The maximum string length in characters is 50.
resources_spec | **[compute.v1.ResourcesSpec](./agent/create_compute_instance#v1)**<br>Required. Computing resources of the instance, such as the amount of memory and number of cores. To get a list of available values, see [Levels of core performance](/docs/compute/concepts/performance-levels). 
metadata | **map<string,string>**<br>The metadata `key:value` pairs that will be assigned to this instance. This includes custom metadata and predefined keys. The total size of all keys and values must be less than 512 KB. <br>Values are free-form strings, and only have meaning as interpreted by the programs which configure the instance. The values must be 256 KB or less. <br>For example, you may use the metadata in order to provide your public SSH key to the instance. For more information, see [Metadata](/docs/compute/concepts/vm-metadata). 
boot_disk_spec | **[compute.v1.AttachedDiskSpec](./agent/create_compute_instance#v1)**<br>Required. Boot disk to attach to the instance. 
network_interface_specs[] | **[compute.v1.NetworkInterfaceSpec](./agent/create_compute_instance#v1)**<br>Network configuration for the instance. Specifies how the network interface is configured to interact with other services on the internal network and on the internet. Currently only one network interface is supported per instance. The number of elemets must be exactly 1.
service_account_id | **string**<br>ID of the service account to use for [authentication inside the instance](/docs/compute/operations/vm-connect/auth-inside-vm). To get the service account ID, use a [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/api-ref/grpc/service_account_service#List) request. 


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateAgentMetadata](#CreateAgentMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[agent.Agent](#Agent)>**<br>if operation finished successfully. 


### CreateAgentMetadata {#CreateAgentMetadata}

Field | Description
--- | ---
agent_id | **string**<br>ID of the agent that is being created. 


### Agent {#Agent}

Field | Description
--- | ---
id | **string**<br>ID of the agent. Generated at creation time. 
folder_id | **string**<br>ID of the folder that the agent belongs to. 
name | **string**<br>Name of the agent. 
description | **string**<br>Description of the agent. 
compute_instance_id | **string**<br>ID of the compute instance managed by the agent. <br>Empty if there is no such instance (i.e. the case of external agent). 
status | enum **Status**<br>Status of the agent. <ul><li>`STATUS_UNSPECIFIED`: Status is not specified.</li><li>`PREPARING_TEST`: Agent is preparing a test to be executed.</li><li>`READY_FOR_TEST`: Agent is ready to take a test.</li><li>`TESTING`: Agent is executing a test.</li><li>`TANK_FAILED`: Agent application encountered an error and cannot operate normally.</li><li>`PROVISIONING`: Agent is waiting for resources to be allocated.</li><li>`STOPPING`: Agent is being stopped.</li><li>`STOPPED`: Agent is stopped.</li><li>`STARTING`: Agent is being started.</li><li>`RESTARTING`: Agent is being restarted.</li><li>`UPDATING`: Agent is being updated.</li><li>`ERROR`: Agent encountered an error and cannot operate.</li><li>`CRASHED`: Agent is crashed and will be restarted automatically.</li><li>`DELETING`: Agent is being deleted.</li><li>`INITIALIZING_CONNECTION`: Service is waiting for connection with agent to be established.</li><li>`LOST_CONNECTION_WITH_AGENT`: Service has lost connection with agent.</li><li>`UPLOADING_ARTIFACTS`: Agent is uploading test artifacts.</li></ul>
errors[] | **string**<br>List of errors reported by the agent. 
current_job_id | **string**<br>ID of the test that is currently being executed by the agent. 
agent_version_id | **string**<br>Version of the agent. 
labels | **map<string,string>**<br>Agent labels as `key:value` pairs. 


## Get {#Get}

Returns the specified agent. <br>To get the list of all available agents, make a [List](#List) request.

**rpc Get ([GetAgentRequest](#GetAgentRequest)) returns ([agent.Agent](#Agent1))**

### GetAgentRequest {#GetAgentRequest}

Field | Description
--- | ---
agent_id | **string**<br>ID of the agent to return. 


### Agent {#Agent1}

Field | Description
--- | ---
id | **string**<br>ID of the agent. Generated at creation time. 
folder_id | **string**<br>ID of the folder that the agent belongs to. 
name | **string**<br>Name of the agent. 
description | **string**<br>Description of the agent. 
compute_instance_id | **string**<br>ID of the compute instance managed by the agent. <br>Empty if there is no such instance (i.e. the case of external agent). 
status | enum **Status**<br>Status of the agent. <ul><li>`STATUS_UNSPECIFIED`: Status is not specified.</li><li>`PREPARING_TEST`: Agent is preparing a test to be executed.</li><li>`READY_FOR_TEST`: Agent is ready to take a test.</li><li>`TESTING`: Agent is executing a test.</li><li>`TANK_FAILED`: Agent application encountered an error and cannot operate normally.</li><li>`PROVISIONING`: Agent is waiting for resources to be allocated.</li><li>`STOPPING`: Agent is being stopped.</li><li>`STOPPED`: Agent is stopped.</li><li>`STARTING`: Agent is being started.</li><li>`RESTARTING`: Agent is being restarted.</li><li>`UPDATING`: Agent is being updated.</li><li>`ERROR`: Agent encountered an error and cannot operate.</li><li>`CRASHED`: Agent is crashed and will be restarted automatically.</li><li>`DELETING`: Agent is being deleted.</li><li>`INITIALIZING_CONNECTION`: Service is waiting for connection with agent to be established.</li><li>`LOST_CONNECTION_WITH_AGENT`: Service has lost connection with agent.</li><li>`UPLOADING_ARTIFACTS`: Agent is uploading test artifacts.</li></ul>
errors[] | **string**<br>List of errors reported by the agent. 
current_job_id | **string**<br>ID of the test that is currently being executed by the agent. 
agent_version_id | **string**<br>Version of the agent. 
labels | **map<string,string>**<br>Agent labels as `key:value` pairs. 


## List {#List}

Retrieves the list of agents in the specified folder.

**rpc List ([ListAgentsRequest](#ListAgentsRequest)) returns ([ListAgentsResponse](#ListAgentsResponse))**

### ListAgentsRequest {#ListAgentsRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to list agents in. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListAgentsResponse.next_page_token](#ListAgentsResponse) that can be used to get the next page of results in subsequent list requests. Default value: 100. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListAgentsResponse.next_page_token](#ListAgentsResponse) returned by a previous list request. The maximum string length in characters is 100.
filter | **string**<br>A filter expression that filters agents listed in the response. <br>The filter expression may contain multiple field expressions joined by `AND`. The field expression must specify: <ol><li>The field name. </li><li>An operator: </li><li>`=`, `!=`, `CONTAINS`, for single values. </li><li>`IN` or `NOT IN` for lists of values. </li><li>The value. String values must be encosed in `"`, boolean values are {`true`, `false`}, timestamp values in ISO-8601. </li></ol><br>Currently supported fields: <ul><li>`id` `yandex.cloud.loadtesting.api.v1.agent.Agent.id` </li><li>operators: `=`, `!=`, `IN`, `NOT IN` </li><li>`name` `yandex.cloud.loadtesting.api.v1.agent.Agent.name` </li><li>operators: `=`, `!=`, `IN`, `NOT IN`, `CONTAINS` </li></ul><br>Examples: <ul><li>`id IN ("1", "2", "3")` </li><li>`name CONTAINS "compute-agent-large" AND id NOT IN ("4", "5")`</li></ul> The maximum string length in characters is 1000.


### ListAgentsResponse {#ListAgentsResponse}

Field | Description
--- | ---
agents[] | **[agent.Agent](#Agent2)**<br>List of agents in the specified folder. 
next_page_token | **string**<br>Token for getting the next page of the list. If the number of results is greater than the specified [ListAgentsRequest.page_size](#ListAgentsRequest), use `next_page_token` as the value for the [ListAgentsRequest.page_token](#ListAgentsRequest) parameter in the next list request. <br>Each subsequent page will have its own `next_page_token` to continue paging through the results. The maximum string length in characters is 100.


### Agent {#Agent2}

Field | Description
--- | ---
id | **string**<br>ID of the agent. Generated at creation time. 
folder_id | **string**<br>ID of the folder that the agent belongs to. 
name | **string**<br>Name of the agent. 
description | **string**<br>Description of the agent. 
compute_instance_id | **string**<br>ID of the compute instance managed by the agent. <br>Empty if there is no such instance (i.e. the case of external agent). 
status | enum **Status**<br>Status of the agent. <ul><li>`STATUS_UNSPECIFIED`: Status is not specified.</li><li>`PREPARING_TEST`: Agent is preparing a test to be executed.</li><li>`READY_FOR_TEST`: Agent is ready to take a test.</li><li>`TESTING`: Agent is executing a test.</li><li>`TANK_FAILED`: Agent application encountered an error and cannot operate normally.</li><li>`PROVISIONING`: Agent is waiting for resources to be allocated.</li><li>`STOPPING`: Agent is being stopped.</li><li>`STOPPED`: Agent is stopped.</li><li>`STARTING`: Agent is being started.</li><li>`RESTARTING`: Agent is being restarted.</li><li>`UPDATING`: Agent is being updated.</li><li>`ERROR`: Agent encountered an error and cannot operate.</li><li>`CRASHED`: Agent is crashed and will be restarted automatically.</li><li>`DELETING`: Agent is being deleted.</li><li>`INITIALIZING_CONNECTION`: Service is waiting for connection with agent to be established.</li><li>`LOST_CONNECTION_WITH_AGENT`: Service has lost connection with agent.</li><li>`UPLOADING_ARTIFACTS`: Agent is uploading test artifacts.</li></ul>
errors[] | **string**<br>List of errors reported by the agent. 
current_job_id | **string**<br>ID of the test that is currently being executed by the agent. 
agent_version_id | **string**<br>Version of the agent. 
labels | **map<string,string>**<br>Agent labels as `key:value` pairs. 


## Delete {#Delete}

Deletes the specified agent. <br>Also deletes a corresponding compute instance.

**rpc Delete ([DeleteAgentRequest](#DeleteAgentRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteAgentMetadata](#DeleteAgentMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteAgentRequest {#DeleteAgentRequest}

Field | Description
--- | ---
agent_id | **string**<br>ID of the agent to delete. 


### Operation {#Operation1}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteAgentMetadata](#DeleteAgentMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### DeleteAgentMetadata {#DeleteAgentMetadata}

Field | Description
--- | ---
agent_id | **string**<br>ID of the agent that is being deleted. 


## Update {#Update}

Updates the specified agent.

**rpc Update ([UpdateAgentRequest](#UpdateAgentRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateAgentMetadata](#UpdateAgentMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[agent.Agent](#Agent3)<br>

### UpdateAgentRequest {#UpdateAgentRequest}

Field | Description
--- | ---
agent_id | **string**<br>Required. ID of the agent to update. 
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Required. Field mask that specifies which attributes of the agent are going to be updated. 
name | **string**<br>New name of the agent. Value must match the regular expression ` \|[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br>New description of the agent. The maximum string length in characters is 256.
compute_instance_params | **[agent.CreateComputeInstance](#CreateComputeInstance1)**<br>New parameters of compute instance managed by the agent. 
labels | **map<string,string>**<br>New labels of the agent. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.


### CreateComputeInstance {#CreateComputeInstance1}

Field | Description
--- | ---
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_./\\@0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_./\\@0-9a-z]* `.
zone_id | **string**<br>Required. ID of the availability zone where the instance resides. To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/api-ref/grpc/zone_service#List) request The maximum string length in characters is 50.
resources_spec | **[compute.v1.ResourcesSpec](./agent/create_compute_instance#v1)**<br>Required. Computing resources of the instance, such as the amount of memory and number of cores. To get a list of available values, see [Levels of core performance](/docs/compute/concepts/performance-levels). 
metadata | **map<string,string>**<br>The metadata `key:value` pairs that will be assigned to this instance. This includes custom metadata and predefined keys. The total size of all keys and values must be less than 512 KB. <br>Values are free-form strings, and only have meaning as interpreted by the programs which configure the instance. The values must be 256 KB or less. <br>For example, you may use the metadata in order to provide your public SSH key to the instance. For more information, see [Metadata](/docs/compute/concepts/vm-metadata). 
boot_disk_spec | **[compute.v1.AttachedDiskSpec](./agent/create_compute_instance#v1)**<br>Required. Boot disk to attach to the instance. 
network_interface_specs[] | **[compute.v1.NetworkInterfaceSpec](./agent/create_compute_instance#v1)**<br>Network configuration for the instance. Specifies how the network interface is configured to interact with other services on the internal network and on the internet. Currently only one network interface is supported per instance. The number of elemets must be exactly 1.
service_account_id | **string**<br>ID of the service account to use for [authentication inside the instance](/docs/compute/operations/vm-connect/auth-inside-vm). To get the service account ID, use a [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/api-ref/grpc/service_account_service#List) request. 


### Operation {#Operation2}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateAgentMetadata](#UpdateAgentMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[agent.Agent](#Agent3)>**<br>if operation finished successfully. 


### UpdateAgentMetadata {#UpdateAgentMetadata}

Field | Description
--- | ---
agent_id | **string**<br>ID of the agent that is being updated. 


### Agent {#Agent3}

Field | Description
--- | ---
id | **string**<br>ID of the agent. Generated at creation time. 
folder_id | **string**<br>ID of the folder that the agent belongs to. 
name | **string**<br>Name of the agent. 
description | **string**<br>Description of the agent. 
compute_instance_id | **string**<br>ID of the compute instance managed by the agent. <br>Empty if there is no such instance (i.e. the case of external agent). 
status | enum **Status**<br>Status of the agent. <ul><li>`STATUS_UNSPECIFIED`: Status is not specified.</li><li>`PREPARING_TEST`: Agent is preparing a test to be executed.</li><li>`READY_FOR_TEST`: Agent is ready to take a test.</li><li>`TESTING`: Agent is executing a test.</li><li>`TANK_FAILED`: Agent application encountered an error and cannot operate normally.</li><li>`PROVISIONING`: Agent is waiting for resources to be allocated.</li><li>`STOPPING`: Agent is being stopped.</li><li>`STOPPED`: Agent is stopped.</li><li>`STARTING`: Agent is being started.</li><li>`RESTARTING`: Agent is being restarted.</li><li>`UPDATING`: Agent is being updated.</li><li>`ERROR`: Agent encountered an error and cannot operate.</li><li>`CRASHED`: Agent is crashed and will be restarted automatically.</li><li>`DELETING`: Agent is being deleted.</li><li>`INITIALIZING_CONNECTION`: Service is waiting for connection with agent to be established.</li><li>`LOST_CONNECTION_WITH_AGENT`: Service has lost connection with agent.</li><li>`UPLOADING_ARTIFACTS`: Agent is uploading test artifacts.</li></ul>
errors[] | **string**<br>List of errors reported by the agent. 
current_job_id | **string**<br>ID of the test that is currently being executed by the agent. 
agent_version_id | **string**<br>Version of the agent. 
labels | **map<string,string>**<br>Agent labels as `key:value` pairs. 


