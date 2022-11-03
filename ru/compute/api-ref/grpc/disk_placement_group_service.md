---
editable: false
sourcePath: en/_api-ref-grpc/compute/api-ref/grpc/disk_placement_group_service.md
---

# DiskPlacementGroupService

A set of methods for managing DiskPlacementGroup resources.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specified placement group. |
| [List](#List) | Retrieves the list of placement groups in the specified folder. |
| [Create](#Create) | Creates a placement group in the specified folder. |
| [Update](#Update) | Updates the specified placement group. |
| [Delete](#Delete) | Deletes the specified placement group. |
| [ListDisks](#ListDisks) | Lists disks for the specified placement group. |
| [ListOperations](#ListOperations) | Lists operations for the specified placement group. |

## Calls DiskPlacementGroupService {#calls}

## Get {#Get}

Returns the specified placement group.

**rpc Get ([GetDiskPlacementGroupRequest](#GetDiskPlacementGroupRequest)) returns ([DiskPlacementGroup](#DiskPlacementGroup))**

### GetDiskPlacementGroupRequest {#GetDiskPlacementGroupRequest}

Field | Description
--- | ---
disk_placement_group_id | **string**<br>Required. ID of the placement group to return. To get the placement group ID, use [DiskPlacementGroupService.List](#List) request. The maximum string length in characters is 50.


### DiskPlacementGroup {#DiskPlacementGroup}

Field | Description
--- | ---
id | **string**<br>ID of the placement group. 
folder_id | **string**<br>ID of the folder that the placement group belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the placement group. The name is unique within the folder. 
description | **string**<br>Description of the placement group. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. 
zone_id | **string**<br>ID of the availability zone where the placement group resides. 
status | enum **Status**<br>Current status of the placement group 
placement_strategy | **oneof:** `spread_placement_strategy`<br>Placement strategy.
&nbsp;&nbsp;spread_placement_strategy | **[DiskSpreadPlacementStrategy](#DiskSpreadPlacementStrategy)**<br>Distribute instances over distinct failure domains. 


### DiskSpreadPlacementStrategy {#DiskSpreadPlacementStrategy}



## List {#List}

Retrieves the list of placement groups in the specified folder.

**rpc List ([ListDiskPlacementGroupsRequest](#ListDiskPlacementGroupsRequest)) returns ([ListDiskPlacementGroupsResponse](#ListDiskPlacementGroupsResponse))**

### ListDiskPlacementGroupsRequest {#ListDiskPlacementGroupsRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to list placement groups in. To get the folder ID, use [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List) request. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListDiskPlacementGroupsResponse.next_page_token](#ListDiskPlacementGroupsResponse) that can be used to get the next page of results in subsequent list requests. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListDiskPlacementGroupsResponse.next_page_token](#ListDiskPlacementGroupsResponse) returned by a previous list request. The maximum string length in characters is 100.
filter | **string**<br>A filter expression that filters resources listed in the response. Currently you can use filtering only on the [DiskPlacementGroup.name](#DiskPlacementGroup1) field. The maximum string length in characters is 1000.


### ListDiskPlacementGroupsResponse {#ListDiskPlacementGroupsResponse}

Field | Description
--- | ---
disk_placement_groups[] | **[DiskPlacementGroup](#DiskPlacementGroup1)**<br>Lists placement groups for the specified folder. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListDiskPlacementGroupsRequest.page_size](#ListDiskPlacementGroupsRequest), use `next_page_token` as the value for the [ListDiskPlacementGroupsRequest.page_token](#ListDiskPlacementGroupsRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### DiskPlacementGroup {#DiskPlacementGroup1}

Field | Description
--- | ---
id | **string**<br>ID of the placement group. 
folder_id | **string**<br>ID of the folder that the placement group belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the placement group. The name is unique within the folder. 
description | **string**<br>Description of the placement group. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. 
zone_id | **string**<br>ID of the availability zone where the placement group resides. 
status | enum **Status**<br>Current status of the placement group 
placement_strategy | **oneof:** `spread_placement_strategy`<br>Placement strategy.
&nbsp;&nbsp;spread_placement_strategy | **[DiskSpreadPlacementStrategy](#DiskSpreadPlacementStrategy1)**<br>Distribute instances over distinct failure domains. 


### DiskSpreadPlacementStrategy {#DiskSpreadPlacementStrategy1}



## Create {#Create}

Creates a placement group in the specified folder.

**rpc Create ([CreateDiskPlacementGroupRequest](#CreateDiskPlacementGroupRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateDiskPlacementGroupMetadata](#CreateDiskPlacementGroupMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[DiskPlacementGroup](#DiskPlacementGroup2)<br>

### CreateDiskPlacementGroupRequest {#CreateDiskPlacementGroupRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to create a placement group in. To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List) request. The maximum string length in characters is 50.
name | **string**<br>Name of the placement group. Value must match the regular expression ` \|[a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
description | **string**<br>Description of the placement group. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_./\\@0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_./\\@0-9a-z]* `.
zone_id | **string**<br>Required. ID of the availability zone where the placement group resides. To get a list of available zones use the [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/api-ref/grpc/zone_service#List) request. The maximum string length in characters is 50.
placement_strategy | **oneof:** `spread_placement_strategy`<br>Placement strategy.
&nbsp;&nbsp;spread_placement_strategy | **[DiskSpreadPlacementStrategy](#DiskSpreadPlacementStrategy2)**<br>Distribute disks over distinct failure domains. 


### DiskSpreadPlacementStrategy {#DiskSpreadPlacementStrategy2}



### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateDiskPlacementGroupMetadata](#CreateDiskPlacementGroupMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DiskPlacementGroup](#DiskPlacementGroup2)>**<br>if operation finished successfully. 


### CreateDiskPlacementGroupMetadata {#CreateDiskPlacementGroupMetadata}

Field | Description
--- | ---
disk_placement_group_id | **string**<br>ID of the placement group that is being created. 


### DiskPlacementGroup {#DiskPlacementGroup2}

Field | Description
--- | ---
id | **string**<br>ID of the placement group. 
folder_id | **string**<br>ID of the folder that the placement group belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the placement group. The name is unique within the folder. 
description | **string**<br>Description of the placement group. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. 
zone_id | **string**<br>ID of the availability zone where the placement group resides. 
status | enum **Status**<br>Current status of the placement group 
placement_strategy | **oneof:** `spread_placement_strategy`<br>Placement strategy.
&nbsp;&nbsp;spread_placement_strategy | **[DiskSpreadPlacementStrategy](#DiskSpreadPlacementStrategy3)**<br>Distribute instances over distinct failure domains. 


## Update {#Update}

Updates the specified placement group.

**rpc Update ([UpdateDiskPlacementGroupRequest](#UpdateDiskPlacementGroupRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateDiskPlacementGroupMetadata](#UpdateDiskPlacementGroupMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[DiskPlacementGroup](#DiskPlacementGroup3)<br>

### UpdateDiskPlacementGroupRequest {#UpdateDiskPlacementGroupRequest}

Field | Description
--- | ---
disk_placement_group_id | **string**<br>Required. ID of the placement group to update. To get the placement group ID, use an [DiskPlacementGroupService.List](#List) request. The maximum string length in characters is 50.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Field mask that specifies which fields of the DiskPlacementGroup resource are going to be updated. 
name | **string**<br>Name of the placement group. Value must match the regular expression ` \|[a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
description | **string**<br>Description of the placement group. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. <br>The existing set of `labels` is completely replaced by the provided set. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_./\\@0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_./\\@0-9a-z]* `.


### Operation {#Operation1}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateDiskPlacementGroupMetadata](#UpdateDiskPlacementGroupMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DiskPlacementGroup](#DiskPlacementGroup3)>**<br>if operation finished successfully. 


### UpdateDiskPlacementGroupMetadata {#UpdateDiskPlacementGroupMetadata}

Field | Description
--- | ---
disk_placement_group_id | **string**<br>ID of the placement group that is being updated. 


### DiskPlacementGroup {#DiskPlacementGroup3}

Field | Description
--- | ---
id | **string**<br>ID of the placement group. 
folder_id | **string**<br>ID of the folder that the placement group belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the placement group. The name is unique within the folder. 
description | **string**<br>Description of the placement group. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. 
zone_id | **string**<br>ID of the availability zone where the placement group resides. 
status | enum **Status**<br>Current status of the placement group 
placement_strategy | **oneof:** `spread_placement_strategy`<br>Placement strategy.
&nbsp;&nbsp;spread_placement_strategy | **[DiskSpreadPlacementStrategy](#DiskSpreadPlacementStrategy3)**<br>Distribute instances over distinct failure domains. 


### DiskSpreadPlacementStrategy {#DiskSpreadPlacementStrategy3}



## Delete {#Delete}

Deletes the specified placement group.

**rpc Delete ([DeleteDiskPlacementGroupRequest](#DeleteDiskPlacementGroupRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteDiskPlacementGroupMetadata](#DeleteDiskPlacementGroupMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteDiskPlacementGroupRequest {#DeleteDiskPlacementGroupRequest}

Field | Description
--- | ---
disk_placement_group_id | **string**<br>Required. ID of the placement group to delete. To get the placement group ID, use [DiskPlacementGroupService.List](#List) request. The maximum string length in characters is 50.


### Operation {#Operation2}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteDiskPlacementGroupMetadata](#DeleteDiskPlacementGroupMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### DeleteDiskPlacementGroupMetadata {#DeleteDiskPlacementGroupMetadata}

Field | Description
--- | ---
disk_placement_group_id | **string**<br>ID of the placement group that is being deleted. 


## ListDisks {#ListDisks}

Lists disks for the specified placement group.

**rpc ListDisks ([ListDiskPlacementGroupDisksRequest](#ListDiskPlacementGroupDisksRequest)) returns ([ListDiskPlacementGroupDisksResponse](#ListDiskPlacementGroupDisksResponse))**

### ListDiskPlacementGroupDisksRequest {#ListDiskPlacementGroupDisksRequest}

Field | Description
--- | ---
disk_placement_group_id | **string**<br>Required. ID of the placement group to list disks for. To get the placement group ID, use [DiskPlacementGroupService.List](#List) request. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListDiskPlacementGroupDisksResponse.next_page_token](#ListDiskPlacementGroupDisksResponse) that can be used to get the next page of results in subsequent list requests. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListDiskPlacementGroupDisksResponse.next_page_token](#ListDiskPlacementGroupDisksResponse) returned by a previous list request. The maximum string length in characters is 100.


### ListDiskPlacementGroupDisksResponse {#ListDiskPlacementGroupDisksResponse}

Field | Description
--- | ---
disks[] | **[Disk](#Disk)**<br>Lists disks for the specified placement group. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is more than [ListDiskPlacementGroupDisksRequest.page_size](#ListDiskPlacementGroupDisksRequest), use `next_page_token` as the value for the [ListDiskPlacementGroupDisksRequest.page_token](#ListDiskPlacementGroupDisksRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### Disk {#Disk}

Field | Description
--- | ---
id | **string**<br>ID of the disk. 
folder_id | **string**<br>ID of the folder that the disk belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
name | **string**<br>Name of the disk. 1-63 characters long. 
description | **string**<br>Description of the disk. 0-256 characters long. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. Maximum of 64 per resource. 
type_id | **string**<br>ID of the disk type. 
zone_id | **string**<br>ID of the availability zone where the disk resides. 
size | **int64**<br>Size of the disk, specified in bytes. 
block_size | **int64**<br>Block size of the disk, specified in bytes. 
product_ids[] | **string**<br>License IDs that indicate which licenses are attached to this resource. License IDs are used to calculate additional charges for the use of the virtual machine. <br>The correct license ID is generated by the platform. IDs are inherited by new resources created from this resource. <br>If you know the license IDs, specify them when you create the image. For example, if you create a disk image using a third-party utility and load it into Object Storage, the license IDs will be lost. You can specify them in the [yandex.cloud.compute.v1.ImageService.Create](/docs/compute/api-ref/grpc/image_service#Create) request. 
status | enum **Status**<br>Current status of the disk. <ul><li>`CREATING`: Disk is being created.</li><li>`READY`: Disk is ready to use.</li><li>`ERROR`: Disk encountered a problem and cannot operate.</li><li>`DELETING`: Disk is being deleted.</li></ul>
source | **oneof:** `source_image_id` or `source_snapshot_id`<br>
&nbsp;&nbsp;source_image_id | **string**<br>ID of the image that was used for disk creation. 
&nbsp;&nbsp;source_snapshot_id | **string**<br>ID of the snapshot that was used for disk creation. 
instance_ids[] | **string**<br>Array of instances to which the disk is attached. 
disk_placement_policy | **[DiskPlacementPolicy](#DiskPlacementPolicy)**<br>Placement policy configuration. 


### DiskPlacementPolicy {#DiskPlacementPolicy}

Field | Description
--- | ---
placement_group_id | **string**<br>Placement group ID. 


## ListOperations {#ListOperations}

Lists operations for the specified placement group.

**rpc ListOperations ([ListDiskPlacementGroupOperationsRequest](#ListDiskPlacementGroupOperationsRequest)) returns ([ListDiskPlacementGroupOperationsResponse](#ListDiskPlacementGroupOperationsResponse))**

### ListDiskPlacementGroupOperationsRequest {#ListDiskPlacementGroupOperationsRequest}

Field | Description
--- | ---
disk_placement_group_id | **string**<br>Required. ID of the placement group to list operations for. To get the placement group ID, use [DiskPlacementGroupService.List](#List) request. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListDiskPlacementGroupOperationsResponse.next_page_token](#ListDiskPlacementGroupOperationsResponse) that can be used to get the next page of results in subsequent list requests. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListDiskPlacementGroupOperationsResponse.next_page_token](#ListDiskPlacementGroupOperationsResponse) returned by a previous list request. The maximum string length in characters is 100.


### ListDiskPlacementGroupOperationsResponse {#ListDiskPlacementGroupOperationsResponse}

Field | Description
--- | ---
operations[] | **[operation.Operation](#Operation3)**<br>List of operations for the specified placement group. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListDiskPlacementGroupOperationsRequest.page_size](#ListDiskPlacementGroupOperationsRequest), use the `next_page_token` as the value for the [ListDiskPlacementGroupOperationsRequest.page_token](#ListDiskPlacementGroupOperationsRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


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


