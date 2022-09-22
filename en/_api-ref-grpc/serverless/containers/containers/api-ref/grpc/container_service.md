---
editable: false
---

# ContainerService



| Call | Description |
| --- | --- |
| [Get](#Get) |  |
| [List](#List) |  |
| [Create](#Create) |  |
| [Update](#Update) |  |
| [Delete](#Delete) |  |
| [DeployRevision](#DeployRevision) |  |
| [Rollback](#Rollback) |  |
| [GetRevision](#GetRevision) |  |
| [ListRevisions](#ListRevisions) |  |
| [ListOperations](#ListOperations) |  |
| [ListAccessBindings](#ListAccessBindings) |  |
| [SetAccessBindings](#SetAccessBindings) |  |
| [UpdateAccessBindings](#UpdateAccessBindings) |  |

## Calls ContainerService {#calls}

## Get {#Get}



**rpc Get ([GetContainerRequest](#GetContainerRequest)) returns ([Container](#Container))**

### GetContainerRequest {#GetContainerRequest}

Field | Description
--- | ---
container_id | **string**<br>Required.  


### Container {#Container}

Field | Description
--- | ---
id | **string**<br> 
folder_id | **string**<br> 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
name | **string**<br> 
description | **string**<br> 
labels | **map<string,string>**<br> 
url | **string**<br> 
status | enum **Status**<br> 


## List {#List}



**rpc List ([ListContainersRequest](#ListContainersRequest)) returns ([ListContainersResponse](#ListContainersResponse))**

### ListContainersRequest {#ListContainersRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required.  
page_size | **int64**<br> 
page_token | **string**<br> 
filter | **string**<br> 


### ListContainersResponse {#ListContainersResponse}

Field | Description
--- | ---
containers[] | **[Container](#Container1)**<br> 
next_page_token | **string**<br> 


### Container {#Container1}

Field | Description
--- | ---
id | **string**<br> 
folder_id | **string**<br> 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
name | **string**<br> 
description | **string**<br> 
labels | **map<string,string>**<br> 
url | **string**<br> 
status | enum **Status**<br> 


## Create {#Create}



**rpc Create ([CreateContainerRequest](#CreateContainerRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateContainerMetadata](#CreateContainerMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Container](#Container2)<br>

### CreateContainerRequest {#CreateContainerRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required.  
name | **string**<br> Value must match the regular expression ` \|[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br> The maximum string length in characters is 256.
labels | **map<string,string>**<br> No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateContainerMetadata](#CreateContainerMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Container](#Container2)>**<br>if operation finished successfully. 


### CreateContainerMetadata {#CreateContainerMetadata}

Field | Description
--- | ---
container_id | **string**<br> 


### Container {#Container2}

Field | Description
--- | ---
id | **string**<br> 
folder_id | **string**<br> 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
name | **string**<br> 
description | **string**<br> 
labels | **map<string,string>**<br> 
url | **string**<br> 
status | enum **Status**<br> 


## Update {#Update}



**rpc Update ([UpdateContainerRequest](#UpdateContainerRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateContainerMetadata](#UpdateContainerMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Container](#Container3)<br>

### UpdateContainerRequest {#UpdateContainerRequest}

Field | Description
--- | ---
container_id | **string**<br>Required.  
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br> 
name | **string**<br> Value must match the regular expression ` \|[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br> The maximum string length in characters is 256.
labels | **map<string,string>**<br> No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.


### Operation {#Operation1}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateContainerMetadata](#UpdateContainerMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Container](#Container3)>**<br>if operation finished successfully. 


### UpdateContainerMetadata {#UpdateContainerMetadata}

Field | Description
--- | ---
container_id | **string**<br> 


### Container {#Container3}

Field | Description
--- | ---
id | **string**<br> 
folder_id | **string**<br> 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
name | **string**<br> 
description | **string**<br> 
labels | **map<string,string>**<br> 
url | **string**<br> 
status | enum **Status**<br> 


## Delete {#Delete}



**rpc Delete ([DeleteContainerRequest](#DeleteContainerRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteContainerMetadata](#DeleteContainerMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteContainerRequest {#DeleteContainerRequest}

Field | Description
--- | ---
container_id | **string**<br>Required.  


### Operation {#Operation2}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteContainerMetadata](#DeleteContainerMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### DeleteContainerMetadata {#DeleteContainerMetadata}

Field | Description
--- | ---
container_id | **string**<br> 


## DeployRevision {#DeployRevision}



**rpc DeployRevision ([DeployContainerRevisionRequest](#DeployContainerRevisionRequest)) returns ([operation.Operation](#Operation3))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeployContainerRevisionMetadata](#DeployContainerRevisionMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Revision](#Revision)<br>

### DeployContainerRevisionRequest {#DeployContainerRevisionRequest}

Field | Description
--- | ---
container_id | **string**<br>Required.  
description | **string**<br> 
resources | **[Resources](#Resources)**<br>Required.  
execution_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br> The maximum value is 600s.
service_account_id | **string**<br> 
image_spec | **[ImageSpec](#ImageSpec)**<br>Required.  
concurrency | **int64**<br> 
secrets[] | **[Secret](#Secret)**<br> 
connectivity | **[Connectivity](#Connectivity)**<br> 
provision_policy | **[ProvisionPolicy](#ProvisionPolicy)**<br> 


### Resources {#Resources}

Field | Description
--- | ---
memory | **int64**<br> Acceptable values are 134217728 to 8589934592, inclusive.
cores | **int64**<br> Acceptable values are 0 to 1, inclusive.
core_fraction | **int64**<br> Acceptable values are 0 to 100, inclusive.


### ImageSpec {#ImageSpec}

Field | Description
--- | ---
image_url | **string**<br>Required.  
command | **[Command](#Command)**<br> 
args | **[Args](#Args)**<br> 
environment | **map<string,string>**<br> The maximum string length in characters for each value is 4096. Each key must match the regular expression ` [a-zA-Z][a-zA-Z0-9_]* `.
working_dir | **string**<br> 


### Command {#Command}

Field | Description
--- | ---
command[] | **string**<br> 


### Args {#Args}

Field | Description
--- | ---
args[] | **string**<br> 


### Secret {#Secret}

Field | Description
--- | ---
id | **string**<br> 
version_id | **string**<br> 
key | **string**<br> 
reference | **oneof:** `environment_variable`<br>
&nbsp;&nbsp;environment_variable | **string**<br> 


### Connectivity {#Connectivity}

Field | Description
--- | ---
network_id | **string**<br> 
subnet_ids[] | **string**<br> 


### ProvisionPolicy {#ProvisionPolicy}

Field | Description
--- | ---
min_instances | **int64**<br> 


### Operation {#Operation3}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeployContainerRevisionMetadata](#DeployContainerRevisionMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Revision](#Revision)>**<br>if operation finished successfully. 


### DeployContainerRevisionMetadata {#DeployContainerRevisionMetadata}

Field | Description
--- | ---
container_revision_id | **string**<br> 


### Revision {#Revision}

Field | Description
--- | ---
id | **string**<br> 
container_id | **string**<br> 
description | **string**<br> 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
image | **[Image](#Image)**<br> 
resources | **[Resources](#Resources1)**<br> 
execution_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br> 
concurrency | **int64**<br> 
service_account_id | **string**<br> 
status | enum **Status**<br> 
secrets[] | **[Secret](#Secret1)**<br> 
connectivity | **[Connectivity](#Connectivity1)**<br> 
provision_policy | **[ProvisionPolicy](#ProvisionPolicy1)**<br> 


### Image {#Image}

Field | Description
--- | ---
image_url | **string**<br> 
image_digest | **string**<br> 
command | **[Command](#Command1)**<br> 
args | **[Args](#Args1)**<br> 
environment | **map<string,string>**<br> The maximum string length in characters for each value is 4096. Each key must match the regular expression ` [a-zA-Z][a-zA-Z0-9_]* `.
working_dir | **string**<br> 


## Rollback {#Rollback}



**rpc Rollback ([RollbackContainerRequest](#RollbackContainerRequest)) returns ([operation.Operation](#Operation4))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[RollbackContainerMetadata](#RollbackContainerMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Container](#Container4)<br>

### RollbackContainerRequest {#RollbackContainerRequest}

Field | Description
--- | ---
container_id | **string**<br>Required.  
revision_id | **string**<br>Required.  


### Operation {#Operation4}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[RollbackContainerMetadata](#RollbackContainerMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Container](#Container4)>**<br>if operation finished successfully. 


### RollbackContainerMetadata {#RollbackContainerMetadata}

Field | Description
--- | ---
container_id | **string**<br> 
revision_id | **string**<br> 


### Container {#Container4}

Field | Description
--- | ---
id | **string**<br> 
folder_id | **string**<br> 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
name | **string**<br> 
description | **string**<br> 
labels | **map<string,string>**<br> 
url | **string**<br> 
status | enum **Status**<br> 


## GetRevision {#GetRevision}



**rpc GetRevision ([GetContainerRevisionRequest](#GetContainerRevisionRequest)) returns ([Revision](#Revision1))**

### GetContainerRevisionRequest {#GetContainerRevisionRequest}

Field | Description
--- | ---
container_revision_id | **string**<br>Required.  


### Revision {#Revision1}

Field | Description
--- | ---
id | **string**<br> 
container_id | **string**<br> 
description | **string**<br> 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
image | **[Image](#Image1)**<br> 
resources | **[Resources](#Resources1)**<br> 
execution_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br> 
concurrency | **int64**<br> 
service_account_id | **string**<br> 
status | enum **Status**<br> 
secrets[] | **[Secret](#Secret1)**<br> 
connectivity | **[Connectivity](#Connectivity1)**<br> 
provision_policy | **[ProvisionPolicy](#ProvisionPolicy1)**<br> 


### Image {#Image1}

Field | Description
--- | ---
image_url | **string**<br> 
image_digest | **string**<br> 
command | **[Command](#Command1)**<br> 
args | **[Args](#Args1)**<br> 
environment | **map<string,string>**<br> The maximum string length in characters for each value is 4096. Each key must match the regular expression ` [a-zA-Z][a-zA-Z0-9_]* `.
working_dir | **string**<br> 


### Command {#Command1}

Field | Description
--- | ---
command[] | **string**<br> 


### Args {#Args1}

Field | Description
--- | ---
args[] | **string**<br> 


### Resources {#Resources1}

Field | Description
--- | ---
memory | **int64**<br> Acceptable values are 134217728 to 8589934592, inclusive.
cores | **int64**<br> Acceptable values are 0 to 1, inclusive.
core_fraction | **int64**<br> Acceptable values are 0 to 100, inclusive.


### Secret {#Secret1}

Field | Description
--- | ---
id | **string**<br> 
version_id | **string**<br> 
key | **string**<br> 
reference | **oneof:** `environment_variable`<br>
&nbsp;&nbsp;environment_variable | **string**<br> 


### Connectivity {#Connectivity1}

Field | Description
--- | ---
network_id | **string**<br> 
subnet_ids[] | **string**<br> 


### ProvisionPolicy {#ProvisionPolicy1}

Field | Description
--- | ---
min_instances | **int64**<br> 


## ListRevisions {#ListRevisions}



**rpc ListRevisions ([ListContainersRevisionsRequest](#ListContainersRevisionsRequest)) returns ([ListContainersRevisionsResponse](#ListContainersRevisionsResponse))**

### ListContainersRevisionsRequest {#ListContainersRevisionsRequest}

Field | Description
--- | ---
id | **oneof:** `folder_id` or `container_id`<br>
&nbsp;&nbsp;folder_id | **string**<br> 
&nbsp;&nbsp;container_id | **string**<br> 
page_size | **int64**<br> Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br> The maximum string length in characters is 100.
filter | **string**<br> The maximum string length in characters is 1000.


### ListContainersRevisionsResponse {#ListContainersRevisionsResponse}

Field | Description
--- | ---
revisions[] | **[Revision](#Revision2)**<br> 
next_page_token | **string**<br> 


### Revision {#Revision2}

Field | Description
--- | ---
id | **string**<br> 
container_id | **string**<br> 
description | **string**<br> 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
image | **[Image](#Image2)**<br> 
resources | **[Resources](#Resources2)**<br> 
execution_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br> 
concurrency | **int64**<br> 
service_account_id | **string**<br> 
status | enum **Status**<br> 
secrets[] | **[Secret](#Secret2)**<br> 
connectivity | **[Connectivity](#Connectivity2)**<br> 
provision_policy | **[ProvisionPolicy](#ProvisionPolicy2)**<br> 


### Image {#Image2}

Field | Description
--- | ---
image_url | **string**<br> 
image_digest | **string**<br> 
command | **[Command](#Command2)**<br> 
args | **[Args](#Args2)**<br> 
environment | **map<string,string>**<br> The maximum string length in characters for each value is 4096. Each key must match the regular expression ` [a-zA-Z][a-zA-Z0-9_]* `.
working_dir | **string**<br> 


### Command {#Command2}

Field | Description
--- | ---
command[] | **string**<br> 


### Args {#Args2}

Field | Description
--- | ---
args[] | **string**<br> 


### Resources {#Resources2}

Field | Description
--- | ---
memory | **int64**<br> Acceptable values are 134217728 to 8589934592, inclusive.
cores | **int64**<br> Acceptable values are 0 to 1, inclusive.
core_fraction | **int64**<br> Acceptable values are 0 to 100, inclusive.


### Secret {#Secret2}

Field | Description
--- | ---
id | **string**<br> 
version_id | **string**<br> 
key | **string**<br> 
reference | **oneof:** `environment_variable`<br>
&nbsp;&nbsp;environment_variable | **string**<br> 


### Connectivity {#Connectivity2}

Field | Description
--- | ---
network_id | **string**<br> 
subnet_ids[] | **string**<br> 


### ProvisionPolicy {#ProvisionPolicy2}

Field | Description
--- | ---
min_instances | **int64**<br> 


## ListOperations {#ListOperations}



**rpc ListOperations ([ListContainerOperationsRequest](#ListContainerOperationsRequest)) returns ([ListContainerOperationsResponse](#ListContainerOperationsResponse))**

### ListContainerOperationsRequest {#ListContainerOperationsRequest}

Field | Description
--- | ---
container_id | **string**<br>Required.  
page_size | **int64**<br> Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br> The maximum string length in characters is 100.
filter | **string**<br> The maximum string length in characters is 1000.


### ListContainerOperationsResponse {#ListContainerOperationsResponse}

Field | Description
--- | ---
operations[] | **[operation.Operation](#Operation5)**<br> 
next_page_token | **string**<br> 


### Operation {#Operation5}

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


## ListAccessBindings {#ListAccessBindings}



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



**rpc SetAccessBindings ([SetAccessBindingsRequest](#SetAccessBindingsRequest)) returns ([operation.Operation](#Operation6))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[SetAccessBindingsMetadata](#SetAccessBindingsMetadata)<br>
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
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[SetAccessBindingsMetadata](#SetAccessBindingsMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### SetAccessBindingsMetadata {#SetAccessBindingsMetadata}

Field | Description
--- | ---
resource_id | **string**<br>ID of the resource for which access bindings are being set. 


## UpdateAccessBindings {#UpdateAccessBindings}



**rpc UpdateAccessBindings ([UpdateAccessBindingsRequest](#UpdateAccessBindingsRequest)) returns ([operation.Operation](#Operation7))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateAccessBindingsMetadata](#UpdateAccessBindingsMetadata)<br>
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
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateAccessBindingsMetadata](#UpdateAccessBindingsMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### UpdateAccessBindingsMetadata {#UpdateAccessBindingsMetadata}

Field | Description
--- | ---
resource_id | **string**<br>ID of the resource for which access bindings are being updated. 


