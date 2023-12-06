---
editable: false
sourcePath: en/_api-ref-grpc/compute/api-ref/grpc/gpu_cluster_service.md
---

# Compute Cloud API, gRPC: GpuClusterService

A set of methods for managing GPU clusters.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specified GPU cluster. |
| [List](#List) | Retrieves the list of GPU clusters in the specified folder. |
| [Create](#Create) | Creates a GPU cluster in the specified folder. |
| [Update](#Update) | Updates the specified GPU cluster. |
| [Delete](#Delete) | Deletes the specified GPU cluster. |
| [ListOperations](#ListOperations) | Lists operations for the specified GPU cluster. |
| [ListInstances](#ListInstances) | List instances created in this GPU cluster. |
| [ListAccessBindings](#ListAccessBindings) | Lists access bindings for the GPU cluster. |
| [SetAccessBindings](#SetAccessBindings) | Sets access bindings for the GPU cluster. |
| [UpdateAccessBindings](#UpdateAccessBindings) | Updates access bindings for the GPU cluster. |

## Calls GpuClusterService {#calls}

## Get {#Get}

Returns the specified GPU cluster. <br>To get the list of available GPU clusters, make a [List](#List) request.

**rpc Get ([GetGpuClusterRequest](#GetGpuClusterRequest)) returns ([GpuCluster](#GpuCluster))**

### GetGpuClusterRequest {#GetGpuClusterRequest}

Field | Description
--- | ---
gpu_cluster_id | **string**<br>ID of the GPU cluster to return. <br>To get a GPU cluster ID, make a [GpuClusterService.List](#List) request. 


### GpuCluster {#GpuCluster}

Field | Description
--- | ---
id | **string**<br>ID of GPU cluster. 
folder_id | **string**<br>ID of the folder that the GPU cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the GPU cluster. <br>The name is unique within the folder. 
description | **string**<br>Description of the GPU cluster. 
labels | **map<string,string>**<br>GPU cluster labels as `key:value` pairs. 
status | enum **Status**<br>Status of the GPU cluster. <ul><li>`CREATING`: GPU cluster is being created.</li><li>`READY`: GPU cluster is ready to use.</li><li>`ERROR`: GPU cluster encountered a problem and cannot operate.</li><li>`DELETING`: GPU cluster is being deleted.</li></ul>
zone_id | **string**<br>ID of the availability zone where the GPU cluster resides. 
interconnect_type | enum **GpuInterconnectType**<br>Type of interconnect used for this GPU cluster. <ul><li>`INFINIBAND`: InfiniBand interconnect.</li></ul>


## List {#List}

Retrieves the list of GPU clusters in the specified folder.

**rpc List ([ListGpuClustersRequest](#ListGpuClustersRequest)) returns ([ListGpuClustersResponse](#ListGpuClustersResponse))**

### ListGpuClustersRequest {#ListGpuClustersRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to list GPU clusters in. <br>To get the folder ID, make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List) request. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListGpuClustersResponse.next_page_token](#ListGpuClustersResponse) that can be used to get the next page of results in subsequent list requests. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListGpuClustersResponse.next_page_token](#ListGpuClustersResponse) returned by a previous list request. The maximum string length in characters is 100.
filter | **string**<br>A filter expression that filters GPU clusters listed in the response. <br>The expression must specify: <ol><li>The field name. Currently you can use filtering only on [GpuCluster.name](#GpuCluster1) field. </li><li>An operator. Can be either `=` or `!=` for single values, `IN` or `NOT IN` for lists of values. </li><li>The value. Must be 3-63 characters long and match the regular expression `^[a-z][-a-z0-9]{1,61}[a-z0-9]`. </li></ol>Example of a filter: `name=my-schedule`. The maximum string length in characters is 1000.
order_by | **string**<br>A sorting expression that sorts GPU clusters listed in the response. <br>The expression must specify the field name from [GpuCluster](#GpuCluster1) and `asc`ending or `desc`ending order, e.g. `createdAt desc`. <br>Default value: `id asc`. The maximum string length in characters is 100.


### ListGpuClustersResponse {#ListGpuClustersResponse}

Field | Description
--- | ---
gpu_clusters[] | **[GpuCluster](#GpuCluster1)**<br>List of GPU clusters in the specified folder. 
next_page_token | **string**<br>Token for getting the next page of the list. If the number of results is greater than the specified [ListGpuClustersRequest.page_size](#ListGpuClustersRequest), use `next_page_token` as the value for the [ListGpuClustersRequest.page_token](#ListGpuClustersRequest) parameter in the next list request. <br>Each subsequent page will have its own `next_page_token` to continue paging through the results. 


### GpuCluster {#GpuCluster1}

Field | Description
--- | ---
id | **string**<br>ID of GPU cluster. 
folder_id | **string**<br>ID of the folder that the GPU cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the GPU cluster. <br>The name is unique within the folder. 
description | **string**<br>Description of the GPU cluster. 
labels | **map<string,string>**<br>GPU cluster labels as `key:value` pairs. 
status | enum **Status**<br>Status of the GPU cluster. <ul><li>`CREATING`: GPU cluster is being created.</li><li>`READY`: GPU cluster is ready to use.</li><li>`ERROR`: GPU cluster encountered a problem and cannot operate.</li><li>`DELETING`: GPU cluster is being deleted.</li></ul>
zone_id | **string**<br>ID of the availability zone where the GPU cluster resides. 
interconnect_type | enum **GpuInterconnectType**<br>Type of interconnect used for this GPU cluster. <ul><li>`INFINIBAND`: InfiniBand interconnect.</li></ul>


## Create {#Create}

Creates a GPU cluster in the specified folder.

**rpc Create ([CreateGpuClusterRequest](#CreateGpuClusterRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateGpuClusterMetadata](#CreateGpuClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[GpuCluster](#GpuCluster2)<br>

### CreateGpuClusterRequest {#CreateGpuClusterRequest}

Field | Description
--- | ---
folder_id | **string**<br>ID of the folder to create a GPU cluster in. <br>To get a folder ID, make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List) request. 
name | **string**<br>Name of the GPU cluster. <br>The name must be unique within the folder. 
description | **string**<br>Description of the GPU cluster. 
labels | **map<string,string>**<br>GPU cluster labels as `key:value` pairs. 
zone_id | **string**<br>ID of the availability zone where the GPU cluster resides. To get a list of available zones use the [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/api-ref/grpc/zone_service#List) request. 
interconnect_type | enum **GpuInterconnectType**<br>Type of interconnect to use for this GPU cluster. <ul><li>`INFINIBAND`: InfiniBand interconnect.</li></ul>


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateGpuClusterMetadata](#CreateGpuClusterMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[GpuCluster](#GpuCluster2)>**<br>if operation finished successfully. 


### CreateGpuClusterMetadata {#CreateGpuClusterMetadata}

Field | Description
--- | ---
gpu_cluster_id | **string**<br>ID of the GPU cluster that is being created. 


### GpuCluster {#GpuCluster2}

Field | Description
--- | ---
id | **string**<br>ID of GPU cluster. 
folder_id | **string**<br>ID of the folder that the GPU cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the GPU cluster. <br>The name is unique within the folder. 
description | **string**<br>Description of the GPU cluster. 
labels | **map<string,string>**<br>GPU cluster labels as `key:value` pairs. 
status | enum **Status**<br>Status of the GPU cluster. <ul><li>`CREATING`: GPU cluster is being created.</li><li>`READY`: GPU cluster is ready to use.</li><li>`ERROR`: GPU cluster encountered a problem and cannot operate.</li><li>`DELETING`: GPU cluster is being deleted.</li></ul>
zone_id | **string**<br>ID of the availability zone where the GPU cluster resides. 
interconnect_type | enum **GpuInterconnectType**<br>Type of interconnect used for this GPU cluster. <ul><li>`INFINIBAND`: InfiniBand interconnect.</li></ul>


## Update {#Update}

Updates the specified GPU cluster. <br>Currently only name, description and labels can be updated.

**rpc Update ([UpdateGpuClusterRequest](#UpdateGpuClusterRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateGpuClusterMetadata](#UpdateGpuClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[GpuCluster](#GpuCluster3)<br>

### UpdateGpuClusterRequest {#UpdateGpuClusterRequest}

Field | Description
--- | ---
gpu_cluster_id | **string**<br>ID of the GPU cluster to update. <br>To get the GPU cluster ID, make a [GpuClusterService.List](#List) request. 
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Field mask that specifies which attributes of the GPU cluster should be updated. 
name | **string**<br>New name for the GPU cluster. <br>The name must be unique within the folder. 
description | **string**<br>New description of the GPU cluster. 
labels | **map<string,string>**<br>New GPU cluster labels as `key:value` pairs. <br>Existing set of labels is completely replaced by the provided set, so if you just want to add or remove a label: <ol><li>Get the current set of labels with a [GpuClusterService.Get](#Get) request. </li><li>Add or remove a label in this set. </li><li>Send the new set in this field.</li></ol> 


### Operation {#Operation1}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateGpuClusterMetadata](#UpdateGpuClusterMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[GpuCluster](#GpuCluster3)>**<br>if operation finished successfully. 


### UpdateGpuClusterMetadata {#UpdateGpuClusterMetadata}

Field | Description
--- | ---
gpu_cluster_id | **string**<br>ID of the GPU cluster that is being updated. 


### GpuCluster {#GpuCluster3}

Field | Description
--- | ---
id | **string**<br>ID of GPU cluster. 
folder_id | **string**<br>ID of the folder that the GPU cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the GPU cluster. <br>The name is unique within the folder. 
description | **string**<br>Description of the GPU cluster. 
labels | **map<string,string>**<br>GPU cluster labels as `key:value` pairs. 
status | enum **Status**<br>Status of the GPU cluster. <ul><li>`CREATING`: GPU cluster is being created.</li><li>`READY`: GPU cluster is ready to use.</li><li>`ERROR`: GPU cluster encountered a problem and cannot operate.</li><li>`DELETING`: GPU cluster is being deleted.</li></ul>
zone_id | **string**<br>ID of the availability zone where the GPU cluster resides. 
interconnect_type | enum **GpuInterconnectType**<br>Type of interconnect used for this GPU cluster. <ul><li>`INFINIBAND`: InfiniBand interconnect.</li></ul>


## Delete {#Delete}

Deletes the specified GPU cluster. <br>GPU cluster can be deleted only if it doesn't have any instances associated with it.

**rpc Delete ([DeleteGpuClusterRequest](#DeleteGpuClusterRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteGpuClusterMetadata](#DeleteGpuClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteGpuClusterRequest {#DeleteGpuClusterRequest}

Field | Description
--- | ---
gpu_cluster_id | **string**<br>ID of the GPU cluster to delete. <br>To get a GPU cluster ID, make a [GpuClusterService.List](#List) request. 


### Operation {#Operation2}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteGpuClusterMetadata](#DeleteGpuClusterMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### DeleteGpuClusterMetadata {#DeleteGpuClusterMetadata}

Field | Description
--- | ---
gpu_cluster_id | **string**<br>ID of the GPU cluster that is being deleted. 


## ListOperations {#ListOperations}

Lists operations for the specified GPU cluster.

**rpc ListOperations ([ListGpuClusterOperationsRequest](#ListGpuClusterOperationsRequest)) returns ([ListGpuClusterOperationsResponse](#ListGpuClusterOperationsResponse))**

### ListGpuClusterOperationsRequest {#ListGpuClusterOperationsRequest}

Field | Description
--- | ---
gpu_cluster_id | **string**<br>ID of the GPU cluster to list operations for. <br>To get a GPU cluster ID, make a [GpuClusterService.List](#List) request. 
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListGpuClusterOperationsResponse.next_page_token](#ListGpuClusterOperationsResponse) that can be used to get the next page of results in subsequent list requests. <br>Default value: 100. 
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListGpuClusterOperationsResponse.next_page_token](#ListGpuClusterOperationsResponse) returned by a previous list request. 


### ListGpuClusterOperationsResponse {#ListGpuClusterOperationsResponse}

Field | Description
--- | ---
operations[] | **[operation.Operation](#Operation3)**<br>List of operations for the specified GPU cluster. 
next_page_token | **string**<br>Token for getting the next page of the list. If the number of results is greater than the specified [ListGpuClusterOperationsRequest.page_size](#ListGpuClusterOperationsRequest), use `next_page_token` as the value for the [ListGpuClusterOperationsRequest.page_token](#ListGpuClusterOperationsRequest) parameter in the next list request. <br>Each subsequent page will have its own `next_page_token` to continue paging through the results. 


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


## ListInstances {#ListInstances}

List instances created in this GPU cluster.

**rpc ListInstances ([ListGpuClusterInstancesRequest](#ListGpuClusterInstancesRequest)) returns ([ListGpuClusterInstancesResponse](#ListGpuClusterInstancesResponse))**

### ListGpuClusterInstancesRequest {#ListGpuClusterInstancesRequest}

Field | Description
--- | ---
gpu_cluster_id | **string**<br>ID of the GPU cluster to list instances in. <br>To get a GPU cluster ID, make a [GpuClusterService.List](#List) request. 
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListGpuClusterInstancesResponse.next_page_token](#ListGpuClusterInstancesResponse) that can be used to get the next page of results in subsequent list requests. <br>Default value: 100. 
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListGpuClusterInstancesResponse.next_page_token](#ListGpuClusterInstancesResponse) returned by a previous list request. 
filter | **string**<br>A filter expression that filters resources listed in the response. Currently you can use filtering only on the [Instance.name](#Instance) field. 


### ListGpuClusterInstancesResponse {#ListGpuClusterInstancesResponse}

Field | Description
--- | ---
instances[] | **[Instance](#Instance)**<br>List of instances in the specified GPU cluster. 
next_page_token | **string**<br>Token for getting the next page of the list. If the number of results is greater than the specified [ListGpuClusterInstancesRequest.page_size](#ListGpuClusterInstancesRequest), use `next_page_token` as the value for the [ListGpuClusterInstancesRequest.page_token](#ListGpuClusterInstancesRequest) parameter in the next list request. <br>Each subsequent page will have its own `next_page_token` to continue paging through the results. 


### Instance {#Instance}

Field | Description
--- | ---
id | **string**<br>ID of the instance. 
folder_id | **string**<br>ID of the folder that the instance belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
name | **string**<br>Name of the instance. 1-63 characters long. 
description | **string**<br>Description of the instance. 0-256 characters long. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. Maximum of 64 per resource. 
zone_id | **string**<br>ID of the availability zone where the instance resides. 
platform_id | **string**<br>ID of the hardware platform configuration for the instance. 
resources | **[Resources](#Resources)**<br>Computing resources of the instance such as the amount of memory and number of cores. 
status | enum **Status**<br>Status of the instance. <ul><li>`PROVISIONING`: Instance is waiting for resources to be allocated.</li><li>`RUNNING`: Instance is running normally.</li><li>`STOPPING`: Instance is being stopped.</li><li>`STOPPED`: Instance stopped.</li><li>`STARTING`: Instance is being started.</li><li>`RESTARTING`: Instance is being restarted.</li><li>`UPDATING`: Instance is being updated.</li><li>`ERROR`: Instance encountered a problem and cannot operate.</li><li>`CRASHED`: Instance crashed and will be restarted automatically.</li><li>`DELETING`: Instance is being deleted.</li></ul>
metadata | **map<string,string>**<br>The metadata `key:value` pairs assigned to this instance. This includes custom metadata and predefined keys. <br>For example, you may use the metadata in order to provide your public SSH key to the instance. For more information, see [Metadata](/docs/compute/concepts/vm-metadata). 
metadata_options | **[MetadataOptions](#MetadataOptions)**<br>Options allow user to configure access to instance's metadata 
boot_disk | **[AttachedDisk](#AttachedDisk)**<br>Boot disk that is attached to the instance. 
secondary_disks[] | **[AttachedDisk](#AttachedDisk)**<br>Array of secondary disks that are attached to the instance. 
local_disks[] | **[AttachedLocalDisk](#AttachedLocalDisk)**<br>Array of local disks that are attached to the instance. 
filesystems[] | **[AttachedFilesystem](#AttachedFilesystem)**<br>Array of filesystems that are attached to the instance. 
network_interfaces[] | **[NetworkInterface](#NetworkInterface)**<br>Array of network interfaces that are attached to the instance. 
gpu_settings | **[GpuSettings](#GpuSettings)**<br>GPU settings 
fqdn | **string**<br>A domain name of the instance. FQDN is defined by the server in the format `<hostname>.<region_id>.internal` when the instance is created. If the hostname were not specified when the instance was created, FQDN would be `<id>.auto.internal`. 
scheduling_policy | **[SchedulingPolicy](#SchedulingPolicy)**<br>Scheduling policy configuration. 
service_account_id | **string**<br>ID of the service account to use for [authentication inside the instance](/docs/compute/operations/vm-connect/auth-inside-vm). To get the service account ID, use a [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/api-ref/grpc/service_account_service#List) request. 
network_settings | **[NetworkSettings](#NetworkSettings)**<br>Network Settings 
placement_policy | **[PlacementPolicy](#PlacementPolicy)**<br>Placement policy configuration. 
host_group_id | **string**<br>ID of the dedicated host group that the instance belongs to. 
host_id | **string**<br>ID of the dedicated host that the instance belongs to. 
maintenance_policy | enum **MaintenancePolicy**<br>Behaviour on maintenance events <ul><li>`RESTART`: Restart instance to move it to another host during maintenance</li><li>`MIGRATE`: Use live migration to move instance to another host during maintenance</li></ul>
maintenance_grace_period | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Time between notification via metadata service and maintenance 


### Resources {#Resources}

Field | Description
--- | ---
memory | **int64**<br>The amount of memory available to the instance, specified in bytes. 
cores | **int64**<br>The number of cores available to the instance. 
core_fraction | **int64**<br>Baseline level of CPU performance with the ability to burst performance above that baseline level. This field sets baseline performance for each core. 
gpus | **int64**<br>The number of GPUs available to the instance. 


### MetadataOptions {#MetadataOptions}

Field | Description
--- | ---
gce_http_endpoint | enum **MetadataOption**<br>Enabled access to GCE flavored metadata <ul><li>`ENABLED`: Option is enabled</li><li>`DISABLED`: Option is disabled</li></ul>
aws_v1_http_endpoint | enum **MetadataOption**<br>Enabled access to AWS flavored metadata (IMDSv1) <ul><li>`ENABLED`: Option is enabled</li><li>`DISABLED`: Option is disabled</li></ul>
gce_http_token | enum **MetadataOption**<br>Enabled access to IAM credentials with GCE flavored metadata <ul><li>`ENABLED`: Option is enabled</li><li>`DISABLED`: Option is disabled</li></ul>
aws_v1_http_token | enum **MetadataOption**<br>Enabled access to IAM credentials with AWS flavored metadata (IMDSv1) <ul><li>`ENABLED`: Option is enabled</li><li>`DISABLED`: Option is disabled</li></ul>


### AttachedDisk {#AttachedDisk}

Field | Description
--- | ---
mode | enum **Mode**<br>Access mode to the Disk resource. <ul><li>`READ_ONLY`: Read-only access.</li><li>`READ_WRITE`: Read/Write access.</li></ul>
device_name | **string**<br>Serial number that is reflected into the /dev/disk/by-id/ tree of a Linux operating system running within the instance. <br>This value can be used to reference the device for mounting, resizing, and so on, from within the instance. 
auto_delete | **bool**<br>Specifies whether the disk will be auto-deleted when the instance is deleted. 
disk_id | **string**<br>ID of the disk that is attached to the instance. 


### AttachedLocalDisk {#AttachedLocalDisk}

Field | Description
--- | ---
size | **int64**<br>Size of the disk, specified in bytes. 
device_name | **string**<br>Serial number that is reflected into the /dev/disk/by-id/ tree of a Linux operating system running within the instance. <br>This value can be used to reference the device for mounting, resizing, and so on, from within the instance. 


### AttachedFilesystem {#AttachedFilesystem}

Field | Description
--- | ---
mode | enum **Mode**<br>Access mode to the filesystem. <ul><li>`READ_ONLY`: Read-only access.</li><li>`READ_WRITE`: Read/Write access.</li></ul>
device_name | **string**<br>Name of the device representing the filesystem on the instance. <br>The name should be used for referencing the filesystem from within the instance when it's being mounted, resized etc. 
filesystem_id | **string**<br>ID of the filesystem that is attached to the instance. 


### NetworkInterface {#NetworkInterface}

Field | Description
--- | ---
index | **string**<br>The index of the network interface, generated by the server, 0,1,2... etc. Currently only one network interface is supported per instance. 
mac_address | **string**<br>MAC address that is assigned to the network interface. 
subnet_id | **string**<br>ID of the subnet. 
primary_v4_address | **[PrimaryAddress](#PrimaryAddress)**<br>Primary IPv4 address that is assigned to the instance for this network interface. 
primary_v6_address | **[PrimaryAddress](#PrimaryAddress)**<br>Primary IPv6 address that is assigned to the instance for this network interface. IPv6 not available yet. 
security_group_ids[] | **string**<br>ID's of security groups attached to the interface 


### PrimaryAddress {#PrimaryAddress}

Field | Description
--- | ---
address | **string**<br>An IPv4 internal network address that is assigned to the instance for this network interface. 
one_to_one_nat | **[OneToOneNat](#OneToOneNat)**<br>One-to-one NAT configuration. If missing, NAT has not been set up. 
dns_records[] | **[DnsRecord](#DnsRecord)**<br>Internal DNS configuration 


### OneToOneNat {#OneToOneNat}

Field | Description
--- | ---
address | **string**<br>An external IP address associated with this instance. 
ip_version | enum **IpVersion**<br>IP version for the external IP address. <ul><li>`IPV4`: IPv4 address, for example 192.0.2.235.</li><li>`IPV6`: IPv6 address. Not available yet.</li></ul>
dns_records[] | **[DnsRecord](#DnsRecord)**<br>External DNS configuration 


### DnsRecord {#DnsRecord}

Field | Description
--- | ---
fqdn | **string**<br>Name of the A/AAAA record as specified when creating the instance. Note that if `fqdn' has no trailing '.', it is specified relative to the zone (@see dns_zone_id). 
dns_zone_id | **string**<br>DNS zone id for the record (optional, if not set, some private zone is used). 
ttl | **int64**<br>DNS record ttl (optional, if not set, a reasonable default is used.) 
ptr | **bool**<br>When true, indicates there is a corresponding auto-created PTR DNS record. 


### GpuSettings {#GpuSettings}

Field | Description
--- | ---
gpu_cluster_id | **string**<br>Attach instance to specified GPU cluster. 


### SchedulingPolicy {#SchedulingPolicy}

Field | Description
--- | ---
preemptible | **bool**<br>True for short-lived compute instances. For more information, see [Preemptible VMs](/docs/compute/concepts/preemptible-vm). 


### NetworkSettings {#NetworkSettings}

Field | Description
--- | ---
type | enum **Type**<br>Network Type <ul><li>`STANDARD`: Standard network.</li><li>`SOFTWARE_ACCELERATED`: Software accelerated network.</li><li>`HARDWARE_ACCELERATED`: Hardware accelerated network (not available yet, reserved for future use).</li></ul>


### PlacementPolicy {#PlacementPolicy}

Field | Description
--- | ---
placement_group_id | **string**<br>Placement group ID. 
host_affinity_rules[] | **[HostAffinityRule](#HostAffinityRule)**<br>List of affinity rules. Scheduler will attempt to allocate instances according to order of rules. 
placement_group_partition | **int64**<br>Placement group partition 


### HostAffinityRule {#HostAffinityRule}

Field | Description
--- | ---
key | **string**<br>Affinity label or one of reserved values - 'yc.hostId', 'yc.hostGroupId' 
op | enum **Operator**<br>Include or exclude action 
values[] | **string**<br>Affinity value or host ID or host group ID 


## ListAccessBindings {#ListAccessBindings}

Lists access bindings for the GPU cluster.

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

Sets access bindings for the GPU cluster.

**rpc SetAccessBindings ([SetAccessBindingsRequest](#SetAccessBindingsRequest)) returns ([operation.Operation](#Operation4))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[SetAccessBindingsMetadata](#SetAccessBindingsMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[AccessBindingsOperationResult](#AccessBindingsOperationResult)<br>

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


### Operation {#Operation4}

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
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[AccessBindingsOperationResult](#AccessBindingsOperationResult)>**<br>if operation finished successfully. 


### SetAccessBindingsMetadata {#SetAccessBindingsMetadata}

Field | Description
--- | ---
resource_id | **string**<br>ID of the resource for which access bindings are being set. 


## UpdateAccessBindings {#UpdateAccessBindings}

Updates access bindings for the GPU cluster.

**rpc UpdateAccessBindings ([UpdateAccessBindingsRequest](#UpdateAccessBindingsRequest)) returns ([operation.Operation](#Operation5))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateAccessBindingsMetadata](#UpdateAccessBindingsMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[AccessBindingsOperationResult](#AccessBindingsOperationResult)<br>

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


### Operation {#Operation5}

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
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[AccessBindingsOperationResult](#AccessBindingsOperationResult)>**<br>if operation finished successfully. 


### UpdateAccessBindingsMetadata {#UpdateAccessBindingsMetadata}

Field | Description
--- | ---
resource_id | **string**<br>ID of the resource for which access bindings are being updated. 


