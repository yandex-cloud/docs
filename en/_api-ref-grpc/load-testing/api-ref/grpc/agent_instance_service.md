---
editable: false
---

# Load Testing API, gRPC: AgentInstanceService



| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specified agent instance |
| [List](#List) | Retrieves the list of agent instances in the specified folder |
| [Create](#Create) | Creates the agent instance in specified folder |
| [Delete](#Delete) | Deletes the specified agent instance |
| [Restart](#Restart) | Restarts the specified agent instance. |
| [Stop](#Stop) | Stops the specified agent instance. |
| [Start](#Start) | Starts the specified agent instance. |
| [UpgradeImage](#UpgradeImage) | Upgrades the specified agent instance to the latest agent image. |

## Calls AgentInstanceService {#calls}

## Get {#Get}

Returns the specified agent instance

**rpc Get ([GetAgentInstanceRequest](#GetAgentInstanceRequest)) returns ([GetAgentInstanceResponse](#GetAgentInstanceResponse))**

### GetAgentInstanceRequest {#GetAgentInstanceRequest}

Field | Description
--- | ---
agent_instance_id | **string**<br> The maximum string length in characters is 50.


### GetAgentInstanceResponse {#GetAgentInstanceResponse}

Field | Description
--- | ---
agent_instance | **[AgentInstance](#AgentInstance)**<br> 


### AgentInstance {#AgentInstance}

Field | Description
--- | ---
id | **string**<br> 
folder_id | **string**<br> 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
compute_instance_updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
name | **string**<br> 
description | **string**<br> 
labels | **map<string,string>**<br> 
service_account_id | **string**<br> 
preset_id | **string**<br> 
yandex_tank_version | **string**<br> 
status | enum **Status**<br>Current status: current job, errors, Status 
errors[] | **string**<br> 
current_job | **string**<br> 
compute_instance_id | **string**<br>Compute Instance Id and status 
agent_version | **[AgentVersion](#AgentVersion)**<br> 


### AgentVersion {#AgentVersion}

Field | Description
--- | ---
id | **string**<br> 
status | enum **VersionStatus**<br> 
revision | **int64**<br> 
description | **string**<br> 
status_comment | **string**<br> 


## List {#List}

Retrieves the list of agent instances in the specified folder

**rpc List ([ListAgentInstancesRequest](#ListAgentInstancesRequest)) returns ([ListAgentInstancesResponse](#ListAgentInstancesResponse))**

### ListAgentInstancesRequest {#ListAgentInstancesRequest}

Field | Description
--- | ---
folder_id | **string**<br> The maximum string length in characters is 50.
page_size | **int64**<br> Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br> The maximum string length in characters is 100.
filter | **string**<br> The maximum string length in characters is 1000.


### ListAgentInstancesResponse {#ListAgentInstancesResponse}

Field | Description
--- | ---
folder_id | **string**<br> 
agent_instances[] | **[AgentInstance](#AgentInstance1)**<br> 
next_page_token | **string**<br> 


### AgentInstance {#AgentInstance1}

Field | Description
--- | ---
id | **string**<br> 
folder_id | **string**<br> 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
compute_instance_updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
name | **string**<br> 
description | **string**<br> 
labels | **map<string,string>**<br> 
service_account_id | **string**<br> 
preset_id | **string**<br> 
yandex_tank_version | **string**<br> 
status | enum **Status**<br>Current status: current job, errors, Status 
errors[] | **string**<br> 
current_job | **string**<br> 
compute_instance_id | **string**<br>Compute Instance Id and status 
agent_version | **[AgentVersion](#AgentVersion1)**<br> 


### AgentVersion {#AgentVersion1}

Field | Description
--- | ---
id | **string**<br> 
status | enum **VersionStatus**<br> 
revision | **int64**<br> 
description | **string**<br> 
status_comment | **string**<br> 


## Create {#Create}

Creates the agent instance in specified folder

**rpc Create ([CreateAgentInstanceRequest](#CreateAgentInstanceRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateAgentInstanceMetadata](#CreateAgentInstanceMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[AgentInstance](#AgentInstance2)<br>

### CreateAgentInstanceRequest {#CreateAgentInstanceRequest}

Field | Description
--- | ---
folder_id | **string**<br> The maximum string length in characters is 50.
name | **string**<br> Value must match the regular expression ` \|[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br> The maximum string length in characters is 256.
labels | **map<string,string>**<br> No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The string length in characters for each value must be 1-63. Each value must match the regular expression ` [a-z][-_0-9a-z]* `.
preset_id | **string**<br> The maximum string length in characters is 50.
service_account_id | **string**<br> The maximum string length in characters is 256.
zone_id | **string**<br>Instance cpu/memory/disk resources are managed by ResourcePreset, all the rest fields are taken from CreateInstanceRequest The maximum string length in characters is 50.
network_interface_specs[] | **compute.v1.NetworkInterfaceSpec**<br> The number of elements must be greater than 0.
metadata | **map<string,string>**<br> 


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateAgentInstanceMetadata](#CreateAgentInstanceMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[AgentInstance](#AgentInstance2)>**<br>if operation finished successfully. 


### CreateAgentInstanceMetadata {#CreateAgentInstanceMetadata}

Field | Description
--- | ---
agent_instance_id | **string**<br> 


### AgentInstance {#AgentInstance2}

Field | Description
--- | ---
id | **string**<br> 
folder_id | **string**<br> 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
compute_instance_updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
name | **string**<br> 
description | **string**<br> 
labels | **map<string,string>**<br> 
service_account_id | **string**<br> 
preset_id | **string**<br> 
yandex_tank_version | **string**<br> 
status | enum **Status**<br>Current status: current job, errors, Status 
errors[] | **string**<br> 
current_job | **string**<br> 
compute_instance_id | **string**<br>Compute Instance Id and status 
agent_version | **[AgentVersion](#AgentVersion2)**<br> 


### AgentVersion {#AgentVersion2}

Field | Description
--- | ---
id | **string**<br> 
status | enum **VersionStatus**<br> 
revision | **int64**<br> 
description | **string**<br> 
status_comment | **string**<br> 


## Delete {#Delete}

Deletes the specified agent instance

**rpc Delete ([DeleteAgentInstanceRequest](#DeleteAgentInstanceRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteAgentInstanceMetadata](#DeleteAgentInstanceMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteAgentInstanceRequest {#DeleteAgentInstanceRequest}

Field | Description
--- | ---
agent_instance_id | **string**<br> The maximum string length in characters is 50.


### Operation {#Operation1}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteAgentInstanceMetadata](#DeleteAgentInstanceMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### DeleteAgentInstanceMetadata {#DeleteAgentInstanceMetadata}

Field | Description
--- | ---
agent_instance_id | **string**<br> 


## Restart {#Restart}

Restarts the specified agent instance.

**rpc Restart ([RestartAgentInstanceRequest](#RestartAgentInstanceRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[RestartAgentInstanceMetadata](#RestartAgentInstanceMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[AgentInstance](#AgentInstance3)<br>

### RestartAgentInstanceRequest {#RestartAgentInstanceRequest}

Field | Description
--- | ---
agent_instance_id | **string**<br> The maximum string length in characters is 50.


### Operation {#Operation2}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[RestartAgentInstanceMetadata](#RestartAgentInstanceMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[AgentInstance](#AgentInstance3)>**<br>if operation finished successfully. 


### RestartAgentInstanceMetadata {#RestartAgentInstanceMetadata}

Field | Description
--- | ---
agent_instance_id | **string**<br> 


### AgentInstance {#AgentInstance3}

Field | Description
--- | ---
id | **string**<br> 
folder_id | **string**<br> 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
compute_instance_updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
name | **string**<br> 
description | **string**<br> 
labels | **map<string,string>**<br> 
service_account_id | **string**<br> 
preset_id | **string**<br> 
yandex_tank_version | **string**<br> 
status | enum **Status**<br>Current status: current job, errors, Status 
errors[] | **string**<br> 
current_job | **string**<br> 
compute_instance_id | **string**<br>Compute Instance Id and status 
agent_version | **[AgentVersion](#AgentVersion3)**<br> 


### AgentVersion {#AgentVersion3}

Field | Description
--- | ---
id | **string**<br> 
status | enum **VersionStatus**<br> 
revision | **int64**<br> 
description | **string**<br> 
status_comment | **string**<br> 


## Stop {#Stop}

Stops the specified agent instance.

**rpc Stop ([StopAgentInstanceRequest](#StopAgentInstanceRequest)) returns ([operation.Operation](#Operation3))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[StopAgentInstanceMetadata](#StopAgentInstanceMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[AgentInstance](#AgentInstance4)<br>

### StopAgentInstanceRequest {#StopAgentInstanceRequest}

Field | Description
--- | ---
agent_instance_id | **string**<br> The maximum string length in characters is 50.


### Operation {#Operation3}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[StopAgentInstanceMetadata](#StopAgentInstanceMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[AgentInstance](#AgentInstance4)>**<br>if operation finished successfully. 


### StopAgentInstanceMetadata {#StopAgentInstanceMetadata}

Field | Description
--- | ---
agent_instance_id | **string**<br> 


### AgentInstance {#AgentInstance4}

Field | Description
--- | ---
id | **string**<br> 
folder_id | **string**<br> 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
compute_instance_updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
name | **string**<br> 
description | **string**<br> 
labels | **map<string,string>**<br> 
service_account_id | **string**<br> 
preset_id | **string**<br> 
yandex_tank_version | **string**<br> 
status | enum **Status**<br>Current status: current job, errors, Status 
errors[] | **string**<br> 
current_job | **string**<br> 
compute_instance_id | **string**<br>Compute Instance Id and status 
agent_version | **[AgentVersion](#AgentVersion4)**<br> 


### AgentVersion {#AgentVersion4}

Field | Description
--- | ---
id | **string**<br> 
status | enum **VersionStatus**<br> 
revision | **int64**<br> 
description | **string**<br> 
status_comment | **string**<br> 


## Start {#Start}

Starts the specified agent instance.

**rpc Start ([StartAgentInstanceRequest](#StartAgentInstanceRequest)) returns ([operation.Operation](#Operation4))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[StartAgentInstanceMetadata](#StartAgentInstanceMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[AgentInstance](#AgentInstance5)<br>

### StartAgentInstanceRequest {#StartAgentInstanceRequest}

Field | Description
--- | ---
agent_instance_id | **string**<br> The maximum string length in characters is 50.


### Operation {#Operation4}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[StartAgentInstanceMetadata](#StartAgentInstanceMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[AgentInstance](#AgentInstance5)>**<br>if operation finished successfully. 


### StartAgentInstanceMetadata {#StartAgentInstanceMetadata}

Field | Description
--- | ---
agent_instance_id | **string**<br> 


### AgentInstance {#AgentInstance5}

Field | Description
--- | ---
id | **string**<br> 
folder_id | **string**<br> 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
compute_instance_updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
name | **string**<br> 
description | **string**<br> 
labels | **map<string,string>**<br> 
service_account_id | **string**<br> 
preset_id | **string**<br> 
yandex_tank_version | **string**<br> 
status | enum **Status**<br>Current status: current job, errors, Status 
errors[] | **string**<br> 
current_job | **string**<br> 
compute_instance_id | **string**<br>Compute Instance Id and status 
agent_version | **[AgentVersion](#AgentVersion5)**<br> 


### AgentVersion {#AgentVersion5}

Field | Description
--- | ---
id | **string**<br> 
status | enum **VersionStatus**<br> 
revision | **int64**<br> 
description | **string**<br> 
status_comment | **string**<br> 


## UpgradeImage {#UpgradeImage}

Upgrades the specified agent instance to the latest agent image.

**rpc UpgradeImage ([UpgradeImageAgentInstanceRequest](#UpgradeImageAgentInstanceRequest)) returns ([operation.Operation](#Operation5))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpgradeImageAgentInstanceMetadata](#UpgradeImageAgentInstanceMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[AgentInstance](#AgentInstance6)<br>

### UpgradeImageAgentInstanceRequest {#UpgradeImageAgentInstanceRequest}

Field | Description
--- | ---
agent_instance_id | **string**<br> The maximum string length in characters is 50.


### Operation {#Operation5}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpgradeImageAgentInstanceMetadata](#UpgradeImageAgentInstanceMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[AgentInstance](#AgentInstance6)>**<br>if operation finished successfully. 


### UpgradeImageAgentInstanceMetadata {#UpgradeImageAgentInstanceMetadata}

Field | Description
--- | ---
agent_instance_id | **string**<br> 


### AgentInstance {#AgentInstance6}

Field | Description
--- | ---
id | **string**<br> 
folder_id | **string**<br> 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
compute_instance_updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
name | **string**<br> 
description | **string**<br> 
labels | **map<string,string>**<br> 
service_account_id | **string**<br> 
preset_id | **string**<br> 
yandex_tank_version | **string**<br> 
status | enum **Status**<br>Current status: current job, errors, Status 
errors[] | **string**<br> 
current_job | **string**<br> 
compute_instance_id | **string**<br>Compute Instance Id and status 
agent_version | **[AgentVersion](#AgentVersion6)**<br> 


### AgentVersion {#AgentVersion6}

Field | Description
--- | ---
id | **string**<br> 
status | enum **VersionStatus**<br> 
revision | **int64**<br> 
description | **string**<br> 
status_comment | **string**<br> 


