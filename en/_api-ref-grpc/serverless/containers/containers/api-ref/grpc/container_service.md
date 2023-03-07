---
editable: false
---

# Serverless Containers Service, gRPC: ContainerService

A set of methods for managing serverless containers.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specified container. |
| [List](#List) | Retrieves the list of containers in the specified folder. |
| [Create](#Create) | Creates a container in the specified folder. |
| [Update](#Update) | Updates the specified container. |
| [Delete](#Delete) | Deletes the specified container. |
| [DeployRevision](#DeployRevision) | Deploys a revision for the specified container. |
| [Rollback](#Rollback) | Rollback the specified container to an old revision. |
| [GetRevision](#GetRevision) | Returns the specified revision of a container. |
| [ListRevisions](#ListRevisions) | Retrieves the list of revisions for the specified container, or of all container revisions in the specified folder. |
| [ListOperations](#ListOperations) | Lists operations for the specified container. |
| [ListAccessBindings](#ListAccessBindings) | Lists existing access bindings for the specified container. |
| [SetAccessBindings](#SetAccessBindings) | Sets access bindings for the container. |
| [UpdateAccessBindings](#UpdateAccessBindings) | Updates access bindings for the specified container. |

## Calls ContainerService {#calls}

## Get {#Get}

Returns the specified container. <br>To get the list of all available containers, make a [List](#List) request.

**rpc Get ([GetContainerRequest](#GetContainerRequest)) returns ([Container](#Container))**

### GetContainerRequest {#GetContainerRequest}

Field | Description
--- | ---
container_id | **string**<br>Required. ID of the container to return. <br>To get a container ID make a [ContainerService.List](#List) request. 


### Container {#Container}

Field | Description
--- | ---
id | **string**<br>ID of the container. Generated at creation time. 
folder_id | **string**<br>ID of the folder that the container belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp for the container. 
name | **string**<br>Name of the container. The name is unique within the folder. 
description | **string**<br>Description of the container. 
labels | **map<string,string>**<br>Container labels as `key:value` pairs. 
url | **string**<br>URL that needs to be requested to call the container. 
status | enum **Status**<br>Status of the container. <ul><li>`CREATING`: Container is being created.</li><li>`ACTIVE`: Container is ready for use.</li><li>`DELETING`: Container is being deleted.</li><li>`ERROR`: Container failed. The only allowed action is delete.</li></ul>


## List {#List}

Retrieves the list of containers in the specified folder.

**rpc List ([ListContainersRequest](#ListContainersRequest)) returns ([ListContainersResponse](#ListContainersResponse))**

### ListContainersRequest {#ListContainersRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to list containers in. <br>To get a folder ID make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List) request. 
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `pageSize`, the service returns a [ListContainersResponse.next_page_token](#ListContainersResponse) that can be used to get the next page of results in subsequent list requests. <br>Default value: 100. 
page_token | **string**<br>Page token. To get the next page of results, set `pageToken` to the [ListContainersResponse.next_page_token](#ListContainersResponse) returned by a previous list request. 
filter | **string**<br>A filter expression that filters containers listed in the response. <br>The expression must specify: <ol><li>The field name. Currently filtering can only be applied to the [Container.name](#Container1) field. </li><li>An `=` operator. </li><li>The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`. </li></ol>Example of a filter: `name="my-container"`. 


### ListContainersResponse {#ListContainersResponse}

Field | Description
--- | ---
containers[] | **[Container](#Container1)**<br>List of containers in the specified folder. 
next_page_token | **string**<br>Token for getting the next page of the list. If the number of results is greater than the specified [ListContainersRequest.page_size](#ListContainersRequest), use `nextPageToken` as the value for the [ListContainersRequest.page_token](#ListContainersRequest) parameter in the next list request. <br>Each subsequent page will have its own `nextPageToken` to continue paging through the results. 


### Container {#Container1}

Field | Description
--- | ---
id | **string**<br>ID of the container. Generated at creation time. 
folder_id | **string**<br>ID of the folder that the container belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp for the container. 
name | **string**<br>Name of the container. The name is unique within the folder. 
description | **string**<br>Description of the container. 
labels | **map<string,string>**<br>Container labels as `key:value` pairs. 
url | **string**<br>URL that needs to be requested to call the container. 
status | enum **Status**<br>Status of the container. <ul><li>`CREATING`: Container is being created.</li><li>`ACTIVE`: Container is ready for use.</li><li>`DELETING`: Container is being deleted.</li><li>`ERROR`: Container failed. The only allowed action is delete.</li></ul>


## Create {#Create}

Creates a container in the specified folder.

**rpc Create ([CreateContainerRequest](#CreateContainerRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateContainerMetadata](#CreateContainerMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Container](#Container2)<br>

### CreateContainerRequest {#CreateContainerRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to create a container in. <br>To get a folder ID make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List) request. 
name | **string**<br>Name of the container. The name must be unique within the folder. Value must match the regular expression ` \|[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br>Description of the container. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.


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
container_id | **string**<br>ID of the container that is being created. 


### Container {#Container2}

Field | Description
--- | ---
id | **string**<br>ID of the container. Generated at creation time. 
folder_id | **string**<br>ID of the folder that the container belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp for the container. 
name | **string**<br>Name of the container. The name is unique within the folder. 
description | **string**<br>Description of the container. 
labels | **map<string,string>**<br>Container labels as `key:value` pairs. 
url | **string**<br>URL that needs to be requested to call the container. 
status | enum **Status**<br>Status of the container. <ul><li>`CREATING`: Container is being created.</li><li>`ACTIVE`: Container is ready for use.</li><li>`DELETING`: Container is being deleted.</li><li>`ERROR`: Container failed. The only allowed action is delete.</li></ul>


## Update {#Update}

Updates the specified container.

**rpc Update ([UpdateContainerRequest](#UpdateContainerRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateContainerMetadata](#UpdateContainerMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Container](#Container3)<br>

### UpdateContainerRequest {#UpdateContainerRequest}

Field | Description
--- | ---
container_id | **string**<br>Required. ID of the container to update. <br>To get a container ID make a [ContainerService.List](#List) request. 
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Field mask that specifies which attributes of the container should be updated. 
name | **string**<br>New name for the container. The name must be unique within the folder. Value must match the regular expression ` \|[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br>New description for the container. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Container labels as `key:value` pairs. <br>Existing set of labels is completely replaced by the provided set, so if you just want to add or remove a label, request the current set of labels with a [ContainerService.Get](#Get) request. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.


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
container_id | **string**<br>ID of the container that is being updated. 


### Container {#Container3}

Field | Description
--- | ---
id | **string**<br>ID of the container. Generated at creation time. 
folder_id | **string**<br>ID of the folder that the container belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp for the container. 
name | **string**<br>Name of the container. The name is unique within the folder. 
description | **string**<br>Description of the container. 
labels | **map<string,string>**<br>Container labels as `key:value` pairs. 
url | **string**<br>URL that needs to be requested to call the container. 
status | enum **Status**<br>Status of the container. <ul><li>`CREATING`: Container is being created.</li><li>`ACTIVE`: Container is ready for use.</li><li>`DELETING`: Container is being deleted.</li><li>`ERROR`: Container failed. The only allowed action is delete.</li></ul>


## Delete {#Delete}

Deletes the specified container.

**rpc Delete ([DeleteContainerRequest](#DeleteContainerRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteContainerMetadata](#DeleteContainerMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteContainerRequest {#DeleteContainerRequest}

Field | Description
--- | ---
container_id | **string**<br>Required. ID of the container to delete. To get a container ID make a [ContainerService.List](#List) request. 


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
container_id | **string**<br>ID of the container that is being deleted. 


## DeployRevision {#DeployRevision}

Deploys a revision for the specified container.

**rpc DeployRevision ([DeployContainerRevisionRequest](#DeployContainerRevisionRequest)) returns ([operation.Operation](#Operation3))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeployContainerRevisionMetadata](#DeployContainerRevisionMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Revision](#Revision)<br>

### DeployContainerRevisionRequest {#DeployContainerRevisionRequest}

Field | Description
--- | ---
container_id | **string**<br>Required. ID of the container to create a revision for. <br>To get a container ID, make a [ContainerService.List](#List) request. 
description | **string**<br>Description of the revision. 
resources | **[Resources](#Resources)**<br>Required. Resources allocated to the revision. 
execution_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Timeout for the execution of the revision. <br>If the timeout is exceeded, Serverless Containers responds with a 504 HTTP code. The maximum value is 600s.
service_account_id | **string**<br>ID of the service account to associate with the revision. 
image_spec | **[ImageSpec](#ImageSpec)**<br>Required. Image configuration for the revision. 
concurrency | **int64**<br>The number of concurrent requests allowed per container instance. <br>The default value is 1. 
secrets[] | **[Secret](#Secret)**<br>Yandex Lockbox secrets to be used by the revision. 
connectivity | **[Connectivity](#Connectivity)**<br>Network access. If specified the revision will be attached to specified network/subnet(s). 
provision_policy | **[ProvisionPolicy](#ProvisionPolicy)**<br>Policy for provisioning instances of the revision. <br>The policy is only applied when the revision is ACTIVE. 
scaling_policy | **[ScalingPolicy](#ScalingPolicy)**<br>Policy for scaling instances of the revision. 
log_options | **[LogOptions](#LogOptions)**<br>Options for logging from the container. 


### Resources {#Resources}

Field | Description
--- | ---
memory | **int64**<br>Amount of memory available to the revision, specified in bytes. Acceptable values are 134217728 to 4294967296, inclusive.
cores | **int64**<br>Number of cores available to the revision. Acceptable values are 0 to 1, inclusive.
core_fraction | **int64**<br>Specifies baseline performance for a core in percent. Acceptable values are 0 to 100, inclusive.


### ImageSpec {#ImageSpec}

Field | Description
--- | ---
image_url | **string**<br>Required. Image URL, that is used by the revision. 
command | **[Command](#Command)**<br>Override for the image's ENTRYPOINT. 
args | **[Args](#Args)**<br>Override for the image's CMD. 
environment | **map<string,string>**<br>Additional environment for the container. The maximum string length in characters for each value is 4096. Each key must match the regular expression ` [a-zA-Z][a-zA-Z0-9_]* `.
working_dir | **string**<br>Override for the image's WORKDIR. 


### Command {#Command}

Field | Description
--- | ---
command[] | **string**<br>Command that will override ENTRYPOINT of an image. <br>Commands will be executed as is. The runtime will not substitute environment variables or execute shell commands. If one wants to do that, they should invoke shell interpreter with an appropriate shell script. 


### Args {#Args}

Field | Description
--- | ---
args[] | **string**<br>Arguments that will override CMD of an image. <br>Arguments will be passed as is. The runtime will not substitute environment variables or execute shell commands. If one wants to do that, they should invoke shell interpreter with an appropriate shell script. 


### Secret {#Secret}

Field | Description
--- | ---
id | **string**<br>ID of Yandex Lockbox secret. 
version_id | **string**<br>ID of Yandex Lockbox secret. 
key | **string**<br>Key in secret's payload, which value to be delivered into container environment. 
reference | **oneof:** `environment_variable`<br>
&nbsp;&nbsp;environment_variable | **string**<br>Environment variable in which secret's value is delivered. 


### Connectivity {#Connectivity}

Field | Description
--- | ---
network_id | **string**<br>Network the revision will have access to. 
subnet_ids[] | **string**<br>The list of subnets (from the same network) the revision can be attached to. <br>Deprecated, it is sufficient to specify only network_id, without the list of subnet_ids. The string length in characters for each value must be greater than 0.


### ProvisionPolicy {#ProvisionPolicy}

Field | Description
--- | ---
min_instances | **int64**<br>Minimum number of guaranteed provisioned container instances for all zones in total. 


### ScalingPolicy {#ScalingPolicy}

Field | Description
--- | ---
zone_instances_limit | **int64**<br>Upper limit for instance count in each zone. 0 means no limit. 
zone_requests_limit | **int64**<br>Upper limit of requests count in each zone. 0 means no limit. 


### LogOptions {#LogOptions}

Field | Description
--- | ---
disabled | **bool**<br>Is logging from container disabled. 
destination | **oneof:** `log_group_id` or `folder_id`<br>Log entries destination.
&nbsp;&nbsp;log_group_id | **string**<br>Entry should be written to log group resolved by ID. Value must match the regular expression ` ([a-zA-Z][-a-zA-Z0-9_.]{0,63})? `.
&nbsp;&nbsp;folder_id | **string**<br>Entry should be written to default log group for specified folder. Value must match the regular expression ` ([a-zA-Z][-a-zA-Z0-9_.]{0,63})? `.
min_level | **`yandex.cloud.logging.v1.LogLevel.Level`**<br>Minimum log entry level. <br>See [LogLevel.Level] for details. 


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
container_revision_id | **string**<br>ID of the revision that is being created. 


### Revision {#Revision}

Field | Description
--- | ---
id | **string**<br>ID of the revision. 
container_id | **string**<br>ID of the container that the revision belongs to. 
description | **string**<br>Description of the revision. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp for the revision. 
image | **[Image](#Image)**<br>Image configuration for the revision. 
resources | **[Resources](#Resources1)**<br>Resources allocated to the revision. 
execution_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Timeout for the execution of the revision. <br>If the timeout is exceeded, Serverless Containers responds with a 504 HTTP code. 
concurrency | **int64**<br>The number of concurrent requests allowed per container instance. 
service_account_id | **string**<br>ID of the service account associated with the revision. 
status | enum **Status**<br>Status of the revision. <ul><li>`CREATING`: Revision is being created.</li><li>`ACTIVE`: Revision is currently used by the container.</li><li>`OBSOLETE`: Revision is not used by the container. May be deleted later.</li></ul>
secrets[] | **[Secret](#Secret1)**<br>Yandex Lockbox secrets to be used by the revision. 
connectivity | **[Connectivity](#Connectivity1)**<br>Network access. If specified the revision will be attached to specified network/subnet(s). 
provision_policy | **[ProvisionPolicy](#ProvisionPolicy1)**<br>Policy for provisioning instances of the revision. <br>The policy is only applied when the revision is ACTIVE. 
scaling_policy | **[ScalingPolicy](#ScalingPolicy1)**<br>Policy for scaling instances of the revision. 
log_options | **[LogOptions](#LogOptions1)**<br>Options for logging from the container. 


### Image {#Image}

Field | Description
--- | ---
image_url | **string**<br>Image URL, that is used by the revision. 
image_digest | **string**<br>Digest of the image. Calculated at creation time. 
command | **[Command](#Command1)**<br>Override for the image's ENTRYPOINT. 
args | **[Args](#Args1)**<br>Override for the image's CMD. 
environment | **map<string,string>**<br>Additional environment for the container. The maximum string length in characters for each value is 4096. Each key must match the regular expression ` [a-zA-Z][a-zA-Z0-9_]* `.
working_dir | **string**<br>Override for the image's WORKDIR. 


## Rollback {#Rollback}

Rollback the specified container to an old revision.

**rpc Rollback ([RollbackContainerRequest](#RollbackContainerRequest)) returns ([operation.Operation](#Operation4))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[RollbackContainerMetadata](#RollbackContainerMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Container](#Container4)<br>

### RollbackContainerRequest {#RollbackContainerRequest}

Field | Description
--- | ---
container_id | **string**<br>Required. ID of the container to rollback to an old revision. <br>To get a container ID, make a [ContainerService.List](#List) request. 
revision_id | **string**<br>Required. ID of the revision to rollback to. <br>To get a revision ID make a [ContainerService.ListRevisions](#ListRevisions) request. 


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
container_id | **string**<br>ID of the container that is being rolled back. 
revision_id | **string**<br>ID of the revision that the container is being rolled back to. 


### Container {#Container4}

Field | Description
--- | ---
id | **string**<br>ID of the container. Generated at creation time. 
folder_id | **string**<br>ID of the folder that the container belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp for the container. 
name | **string**<br>Name of the container. The name is unique within the folder. 
description | **string**<br>Description of the container. 
labels | **map<string,string>**<br>Container labels as `key:value` pairs. 
url | **string**<br>URL that needs to be requested to call the container. 
status | enum **Status**<br>Status of the container. <ul><li>`CREATING`: Container is being created.</li><li>`ACTIVE`: Container is ready for use.</li><li>`DELETING`: Container is being deleted.</li><li>`ERROR`: Container failed. The only allowed action is delete.</li></ul>


## GetRevision {#GetRevision}

Returns the specified revision of a container. <br>To get the list of available revision, make a [ListRevisions](#ListRevisions) request.

**rpc GetRevision ([GetContainerRevisionRequest](#GetContainerRevisionRequest)) returns ([Revision](#Revision1))**

### GetContainerRevisionRequest {#GetContainerRevisionRequest}

Field | Description
--- | ---
container_revision_id | **string**<br>Required. ID of the revision to return. <br>To get a revision ID make a [ContainerService.ListRevisions](#ListRevisions) request. 


### Revision {#Revision1}

Field | Description
--- | ---
id | **string**<br>ID of the revision. 
container_id | **string**<br>ID of the container that the revision belongs to. 
description | **string**<br>Description of the revision. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp for the revision. 
image | **[Image](#Image1)**<br>Image configuration for the revision. 
resources | **[Resources](#Resources1)**<br>Resources allocated to the revision. 
execution_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Timeout for the execution of the revision. <br>If the timeout is exceeded, Serverless Containers responds with a 504 HTTP code. 
concurrency | **int64**<br>The number of concurrent requests allowed per container instance. 
service_account_id | **string**<br>ID of the service account associated with the revision. 
status | enum **Status**<br>Status of the revision. <ul><li>`CREATING`: Revision is being created.</li><li>`ACTIVE`: Revision is currently used by the container.</li><li>`OBSOLETE`: Revision is not used by the container. May be deleted later.</li></ul>
secrets[] | **[Secret](#Secret1)**<br>Yandex Lockbox secrets to be used by the revision. 
connectivity | **[Connectivity](#Connectivity1)**<br>Network access. If specified the revision will be attached to specified network/subnet(s). 
provision_policy | **[ProvisionPolicy](#ProvisionPolicy1)**<br>Policy for provisioning instances of the revision. <br>The policy is only applied when the revision is ACTIVE. 
scaling_policy | **[ScalingPolicy](#ScalingPolicy1)**<br>Policy for scaling instances of the revision. 
log_options | **[LogOptions](#LogOptions1)**<br>Options for logging from the container. 


### Image {#Image1}

Field | Description
--- | ---
image_url | **string**<br>Image URL, that is used by the revision. 
image_digest | **string**<br>Digest of the image. Calculated at creation time. 
command | **[Command](#Command1)**<br>Override for the image's ENTRYPOINT. 
args | **[Args](#Args1)**<br>Override for the image's CMD. 
environment | **map<string,string>**<br>Additional environment for the container. The maximum string length in characters for each value is 4096. Each key must match the regular expression ` [a-zA-Z][a-zA-Z0-9_]* `.
working_dir | **string**<br>Override for the image's WORKDIR. 


### Command {#Command1}

Field | Description
--- | ---
command[] | **string**<br>Command that will override ENTRYPOINT of an image. <br>Commands will be executed as is. The runtime will not substitute environment variables or execute shell commands. If one wants to do that, they should invoke shell interpreter with an appropriate shell script. 


### Args {#Args1}

Field | Description
--- | ---
args[] | **string**<br>Arguments that will override CMD of an image. <br>Arguments will be passed as is. The runtime will not substitute environment variables or execute shell commands. If one wants to do that, they should invoke shell interpreter with an appropriate shell script. 


### Resources {#Resources1}

Field | Description
--- | ---
memory | **int64**<br>Amount of memory available to the revision, specified in bytes. Acceptable values are 134217728 to 4294967296, inclusive.
cores | **int64**<br>Number of cores available to the revision. Acceptable values are 0 to 1, inclusive.
core_fraction | **int64**<br>Specifies baseline performance for a core in percent. Acceptable values are 0 to 100, inclusive.


### Secret {#Secret1}

Field | Description
--- | ---
id | **string**<br>ID of Yandex Lockbox secret. 
version_id | **string**<br>ID of Yandex Lockbox secret. 
key | **string**<br>Key in secret's payload, which value to be delivered into container environment. 
reference | **oneof:** `environment_variable`<br>
&nbsp;&nbsp;environment_variable | **string**<br>Environment variable in which secret's value is delivered. 


### Connectivity {#Connectivity1}

Field | Description
--- | ---
network_id | **string**<br>Network the revision will have access to. 
subnet_ids[] | **string**<br>The list of subnets (from the same network) the revision can be attached to. <br>Deprecated, it is sufficient to specify only network_id, without the list of subnet_ids. The string length in characters for each value must be greater than 0.


### ProvisionPolicy {#ProvisionPolicy1}

Field | Description
--- | ---
min_instances | **int64**<br>Minimum number of guaranteed provisioned container instances for all zones in total. 


### ScalingPolicy {#ScalingPolicy1}

Field | Description
--- | ---
zone_instances_limit | **int64**<br>Upper limit for instance count in each zone. 0 means no limit. 
zone_requests_limit | **int64**<br>Upper limit of requests count in each zone. 0 means no limit. 


### LogOptions {#LogOptions1}

Field | Description
--- | ---
disabled | **bool**<br>Is logging from container disabled. 
destination | **oneof:** `log_group_id` or `folder_id`<br>Log entries destination.
&nbsp;&nbsp;log_group_id | **string**<br>Entry should be written to log group resolved by ID. Value must match the regular expression ` ([a-zA-Z][-a-zA-Z0-9_.]{0,63})? `.
&nbsp;&nbsp;folder_id | **string**<br>Entry should be written to default log group for specified folder. Value must match the regular expression ` ([a-zA-Z][-a-zA-Z0-9_.]{0,63})? `.
min_level | **`yandex.cloud.logging.v1.LogLevel.Level`**<br>Minimum log entry level. <br>See [LogLevel.Level] for details. 


## ListRevisions {#ListRevisions}

Retrieves the list of revisions for the specified container, or of all container revisions in the specified folder.

**rpc ListRevisions ([ListContainersRevisionsRequest](#ListContainersRevisionsRequest)) returns ([ListContainersRevisionsResponse](#ListContainersRevisionsResponse))**

### ListContainersRevisionsRequest {#ListContainersRevisionsRequest}

Field | Description
--- | ---
id | **oneof:** `folder_id` or `container_id`<br>
&nbsp;&nbsp;folder_id | **string**<br>ID of the folder to list container revisions for. To get a folder ID make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List) request. 
&nbsp;&nbsp;container_id | **string**<br>ID of the container to list revisions for. To get a container ID use a [ContainerService.List](#List) request. 
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `pageSize`, the service returns a [ListContainersRevisionsResponse.next_page_token](#ListContainersRevisionsResponse) that can be used to get the next page of results in subsequent list requests. <br>Default value: 100. Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br>Page token. To get the next page of results, set `pageToken` to the [ListContainersRevisionsResponse.next_page_token](#ListContainersRevisionsResponse) returned by a previous list request. The maximum string length in characters is 100.
filter | **string**<br>A filter expression that filters resources listed in the response. <br>The expression must specify: <ol><li>The field name. Currently filtering can only be applied to the [Revision.status](#Revision2) and [Revision.runtime](#Revision2) fields. </li><li>An `=` operator. </li><li>The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`. </li></ol>Example of a filter: `status="ACTIVE"`. The maximum string length in characters is 1000.


### ListContainersRevisionsResponse {#ListContainersRevisionsResponse}

Field | Description
--- | ---
revisions[] | **[Revision](#Revision2)**<br>List of revisions for the specified folder or container. 
next_page_token | **string**<br>Token for getting the next page of the list. If the number of results is greater than the specified [ListContainersRevisionsRequest.page_size](#ListContainersRevisionsRequest), use `nextPageToken` as the value for the [ListContainersRevisionsRequest.page_token](#ListContainersRevisionsRequest) parameter in the next list request. <br>Each subsequent page will have its own `nextPageToken` to continue paging through the results. 


### Revision {#Revision2}

Field | Description
--- | ---
id | **string**<br>ID of the revision. 
container_id | **string**<br>ID of the container that the revision belongs to. 
description | **string**<br>Description of the revision. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp for the revision. 
image | **[Image](#Image2)**<br>Image configuration for the revision. 
resources | **[Resources](#Resources2)**<br>Resources allocated to the revision. 
execution_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Timeout for the execution of the revision. <br>If the timeout is exceeded, Serverless Containers responds with a 504 HTTP code. 
concurrency | **int64**<br>The number of concurrent requests allowed per container instance. 
service_account_id | **string**<br>ID of the service account associated with the revision. 
status | enum **Status**<br>Status of the revision. <ul><li>`CREATING`: Revision is being created.</li><li>`ACTIVE`: Revision is currently used by the container.</li><li>`OBSOLETE`: Revision is not used by the container. May be deleted later.</li></ul>
secrets[] | **[Secret](#Secret2)**<br>Yandex Lockbox secrets to be used by the revision. 
connectivity | **[Connectivity](#Connectivity2)**<br>Network access. If specified the revision will be attached to specified network/subnet(s). 
provision_policy | **[ProvisionPolicy](#ProvisionPolicy2)**<br>Policy for provisioning instances of the revision. <br>The policy is only applied when the revision is ACTIVE. 
scaling_policy | **[ScalingPolicy](#ScalingPolicy2)**<br>Policy for scaling instances of the revision. 
log_options | **[LogOptions](#LogOptions2)**<br>Options for logging from the container. 


### Image {#Image2}

Field | Description
--- | ---
image_url | **string**<br>Image URL, that is used by the revision. 
image_digest | **string**<br>Digest of the image. Calculated at creation time. 
command | **[Command](#Command2)**<br>Override for the image's ENTRYPOINT. 
args | **[Args](#Args2)**<br>Override for the image's CMD. 
environment | **map<string,string>**<br>Additional environment for the container. The maximum string length in characters for each value is 4096. Each key must match the regular expression ` [a-zA-Z][a-zA-Z0-9_]* `.
working_dir | **string**<br>Override for the image's WORKDIR. 


### Command {#Command2}

Field | Description
--- | ---
command[] | **string**<br>Command that will override ENTRYPOINT of an image. <br>Commands will be executed as is. The runtime will not substitute environment variables or execute shell commands. If one wants to do that, they should invoke shell interpreter with an appropriate shell script. 


### Args {#Args2}

Field | Description
--- | ---
args[] | **string**<br>Arguments that will override CMD of an image. <br>Arguments will be passed as is. The runtime will not substitute environment variables or execute shell commands. If one wants to do that, they should invoke shell interpreter with an appropriate shell script. 


### Resources {#Resources2}

Field | Description
--- | ---
memory | **int64**<br>Amount of memory available to the revision, specified in bytes. Acceptable values are 134217728 to 4294967296, inclusive.
cores | **int64**<br>Number of cores available to the revision. Acceptable values are 0 to 1, inclusive.
core_fraction | **int64**<br>Specifies baseline performance for a core in percent. Acceptable values are 0 to 100, inclusive.


### Secret {#Secret2}

Field | Description
--- | ---
id | **string**<br>ID of Yandex Lockbox secret. 
version_id | **string**<br>ID of Yandex Lockbox secret. 
key | **string**<br>Key in secret's payload, which value to be delivered into container environment. 
reference | **oneof:** `environment_variable`<br>
&nbsp;&nbsp;environment_variable | **string**<br>Environment variable in which secret's value is delivered. 


### Connectivity {#Connectivity2}

Field | Description
--- | ---
network_id | **string**<br>Network the revision will have access to. 
subnet_ids[] | **string**<br>The list of subnets (from the same network) the revision can be attached to. <br>Deprecated, it is sufficient to specify only network_id, without the list of subnet_ids. The string length in characters for each value must be greater than 0.


### ProvisionPolicy {#ProvisionPolicy2}

Field | Description
--- | ---
min_instances | **int64**<br>Minimum number of guaranteed provisioned container instances for all zones in total. 


### ScalingPolicy {#ScalingPolicy2}

Field | Description
--- | ---
zone_instances_limit | **int64**<br>Upper limit for instance count in each zone. 0 means no limit. 
zone_requests_limit | **int64**<br>Upper limit of requests count in each zone. 0 means no limit. 


### LogOptions {#LogOptions2}

Field | Description
--- | ---
disabled | **bool**<br>Is logging from container disabled. 
destination | **oneof:** `log_group_id` or `folder_id`<br>Log entries destination.
&nbsp;&nbsp;log_group_id | **string**<br>Entry should be written to log group resolved by ID. Value must match the regular expression ` ([a-zA-Z][-a-zA-Z0-9_.]{0,63})? `.
&nbsp;&nbsp;folder_id | **string**<br>Entry should be written to default log group for specified folder. Value must match the regular expression ` ([a-zA-Z][-a-zA-Z0-9_.]{0,63})? `.
min_level | **`yandex.cloud.logging.v1.LogLevel.Level`**<br>Minimum log entry level. <br>See [LogLevel.Level] for details. 


## ListOperations {#ListOperations}

Lists operations for the specified container.

**rpc ListOperations ([ListContainerOperationsRequest](#ListContainerOperationsRequest)) returns ([ListContainerOperationsResponse](#ListContainerOperationsResponse))**

### ListContainerOperationsRequest {#ListContainerOperationsRequest}

Field | Description
--- | ---
container_id | **string**<br>Required. ID of the container to list operations for. 
page_size | **int64**<br>The maximum number of results per page that should be returned. If the number of available results is larger than `pageSize`, the service returns a [ListContainerOperationsResponse.next_page_token](#ListContainerOperationsResponse) that can be used to get the next page of results in subsequent list requests. <br>Default value: 100. Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br>Page token. To get the next page of results, set `pageToken` to the [ListContainerOperationsResponse.next_page_token](#ListContainerOperationsResponse) returned by a previous list request. The maximum string length in characters is 100.
filter | **string**<br>A filter expression that filters resources listed in the response. <br>The expression must specify: <ol><li>The field name. Currently filtering can be applied to the [operation.Operation.done](#Operation5), [operation.Operation.created_by](#Operation5) field. </li><li>An `=` operator. </li><li>The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`. </li></ol>Examples of a filter: `done=false`, `created_by='John.Doe'`. The maximum string length in characters is 1000.


### ListContainerOperationsResponse {#ListContainerOperationsResponse}

Field | Description
--- | ---
operations[] | **[operation.Operation](#Operation5)**<br>List of operations for the specified container. 
next_page_token | **string**<br>Token for getting the next page of the list. If the number of results is greater than the specified [ListContainerOperationsRequest.page_size](#ListContainerOperationsRequest), use `nextPageToken` as the value for the [ListContainerOperationsRequest.page_token](#ListContainerOperationsRequest) parameter in the next list request. <br>Each subsequent page will have its own `nextPageToken` to continue paging through the results. 


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

Lists existing access bindings for the specified container.

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

Sets access bindings for the container.

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

Updates access bindings for the specified container.

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


