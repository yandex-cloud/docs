---
editable: false
---

# SnapshotScheduleService

A set of methods for managing SnapshotSchedule resources.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specified SnapshotSchedule resource. |
| [List](#List) | Retrieves the list of SnapshotSchedule resources in the specified folder. |
| [Create](#Create) | Creates a snapshot schedule in the specified folder. |
| [Update](#Update) | Updates the specified snapshot schedule. |
| [Delete](#Delete) | Deletes the specified snapshot schedule. |
| [UpdateDisks](#UpdateDisks) | UpdateDisks of schedule |
| [Disable](#Disable) | Disable schedule sets status InActive. |
| [Enable](#Enable) | Enable schedule sets status Active. |
| [ListOperations](#ListOperations) | Lists operations for the specified snapshot schedule. |
| [ListSnapshots](#ListSnapshots) | List snapshot created by schedule. |
| [ListDisks](#ListDisks) | List disks that belong to schedule. |

## Calls SnapshotScheduleService {#calls}

## Get {#Get}

Returns the specified SnapshotSchedule resource. <br>To get the list of available SnapshotSchedule resources, make a [List](#List) request.

**rpc Get ([GetSnapshotScheduleRequest](#GetSnapshotScheduleRequest)) returns ([SnapshotSchedule](#SnapshotSchedule))**

### GetSnapshotScheduleRequest {#GetSnapshotScheduleRequest}

Field | Description
--- | ---
snapshot_schedule_id | **string**<br>ID of the SnapshotSchedule resource to return. 


### SnapshotSchedule {#SnapshotSchedule}

Field | Description
--- | ---
id | **string**<br>ID of the snapshot schedule policy. 
folder_id | **string**<br>ID of the folder that the scheduler policy belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
name | **string**<br>Name of the schedule policy. The name is unique within the folder. 
description | **string**<br>Description of the schedule policy. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. 
status | enum **Status**<br> 
schedule_policy | **[SchedulePolicy](#SchedulePolicy)**<br>schedule properties 
retention_policy | **oneof:** `retention_period` or `snapshot_count`<br>
&nbsp;&nbsp;retention_period | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br> 
&nbsp;&nbsp;snapshot_count | **int64**<br> 
snapshot_spec | **[SnapshotSpec](#SnapshotSpec)**<br>properties to create snapshot with. 


### SchedulePolicy {#SchedulePolicy}

Field | Description
--- | ---
start_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>start time for the first run. 
expression | **string**<br>cron format (* * * * *) 


### SnapshotSpec {#SnapshotSpec}

Field | Description
--- | ---
description | **string**<br>Description of the created snapshot. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. 


## List {#List}

Retrieves the list of SnapshotSchedule resources in the specified folder.

**rpc List ([ListSnapshotSchedulesRequest](#ListSnapshotSchedulesRequest)) returns ([ListSnapshotSchedulesResponse](#ListSnapshotSchedulesResponse))**

### ListSnapshotSchedulesRequest {#ListSnapshotSchedulesRequest}

Field | Description
--- | ---
folder_id | **string**<br>ID of the folder to list snapshot schedules in. 
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListSnapshotSchedulesResponse.next_page_token](#ListSnapshotSchedulesResponse) that can be used to get the next page of results in subsequent list requests. 
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListSnapshotSchedulesResponse.next_page_token](#ListSnapshotSchedulesResponse) returned by a previous list request. 
filter | **string**<br> 
order_by | **string**<br>By which column the listing should be ordered and in which direction, format is "createdAt desc". "id asc" if omitted. 


### ListSnapshotSchedulesResponse {#ListSnapshotSchedulesResponse}

Field | Description
--- | ---
snapshot_schedules[] | **[SnapshotSchedule](#SnapshotSchedule1)**<br>List of SnapshotSchedule resources. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListSnapshotSchedulesRequest.page_size](#ListSnapshotSchedulesRequest), use the `next_page_token` as the value for the [ListSnapshotSchedulesRequest.page_token](#ListSnapshotSchedulesRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### SnapshotSchedule {#SnapshotSchedule1}

Field | Description
--- | ---
id | **string**<br>ID of the snapshot schedule policy. 
folder_id | **string**<br>ID of the folder that the scheduler policy belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
name | **string**<br>Name of the schedule policy. The name is unique within the folder. 
description | **string**<br>Description of the schedule policy. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. 
status | enum **Status**<br> 
schedule_policy | **[SchedulePolicy](#SchedulePolicy1)**<br>schedule properties 
retention_policy | **oneof:** `retention_period` or `snapshot_count`<br>
&nbsp;&nbsp;retention_period | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br> 
&nbsp;&nbsp;snapshot_count | **int64**<br> 
snapshot_spec | **[SnapshotSpec](#SnapshotSpec1)**<br>properties to create snapshot with. 


### SchedulePolicy {#SchedulePolicy1}

Field | Description
--- | ---
start_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>start time for the first run. 
expression | **string**<br>cron format (* * * * *) 


### SnapshotSpec {#SnapshotSpec1}

Field | Description
--- | ---
description | **string**<br>Description of the created snapshot. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. 


## Create {#Create}

Creates a snapshot schedule in the specified folder.

**rpc Create ([CreateSnapshotScheduleRequest](#CreateSnapshotScheduleRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateSnapshotScheduleMetadata](#CreateSnapshotScheduleMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[SnapshotSchedule](#SnapshotSchedule2)<br>

### CreateSnapshotScheduleRequest {#CreateSnapshotScheduleRequest}

Field | Description
--- | ---
folder_id | **string**<br>ID of the folder to create a snapshot schedule in. 
name | **string**<br> 
description | **string**<br> 
labels | **map<string,string>**<br> 
schedule_policy | **[SchedulePolicy](#SchedulePolicy2)**<br>schedule properties 
retention_policy | **oneof:** `retention_period` or `snapshot_count`<br>
&nbsp;&nbsp;retention_period | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br> 
&nbsp;&nbsp;snapshot_count | **int64**<br> 
snapshot_spec | **[SnapshotSpec](#SnapshotSpec2)**<br> 
disk_ids[] | **string**<br> 


### SchedulePolicy {#SchedulePolicy2}

Field | Description
--- | ---
start_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>start time for the first run. 
expression | **string**<br>cron format (* * * * *) 


### SnapshotSpec {#SnapshotSpec2}

Field | Description
--- | ---
description | **string**<br>Description of the created snapshot. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. 


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateSnapshotScheduleMetadata](#CreateSnapshotScheduleMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[SnapshotSchedule](#SnapshotSchedule2)>**<br>if operation finished successfully. 


### CreateSnapshotScheduleMetadata {#CreateSnapshotScheduleMetadata}

Field | Description
--- | ---
snapshot_schedule_id | **string**<br> 


### SnapshotSchedule {#SnapshotSchedule2}

Field | Description
--- | ---
id | **string**<br>ID of the snapshot schedule policy. 
folder_id | **string**<br>ID of the folder that the scheduler policy belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
name | **string**<br>Name of the schedule policy. The name is unique within the folder. 
description | **string**<br>Description of the schedule policy. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. 
status | enum **Status**<br> 
schedule_policy | **[SchedulePolicy](#SchedulePolicy3)**<br>schedule properties 
retention_policy | **oneof:** `retention_period` or `snapshot_count`<br>
&nbsp;&nbsp;retention_period | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br> 
&nbsp;&nbsp;snapshot_count | **int64**<br> 
snapshot_spec | **[SnapshotSpec](#SnapshotSpec3)**<br>properties to create snapshot with. 


## Update {#Update}

Updates the specified snapshot schedule.

**rpc Update ([UpdateSnapshotScheduleRequest](#UpdateSnapshotScheduleRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateSnapshotScheduleMetadata](#UpdateSnapshotScheduleMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[SnapshotSchedule](#SnapshotSchedule3)<br>

### UpdateSnapshotScheduleRequest {#UpdateSnapshotScheduleRequest}

Field | Description
--- | ---
snapshot_schedule_id | **string**<br>ID of the SnapshotSchedule resource to update. 
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Field mask that specifies which fields of the SnapshotSchedule resource are going to be updated. 
name | **string**<br>schedule properties 
description | **string**<br> 
labels | **map<string,string>**<br> 
schedule_policy | **[SchedulePolicy](#SchedulePolicy3)**<br> 
retention_policy | **oneof:** `retention_period` or `snapshot_count`<br>
&nbsp;&nbsp;retention_period | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br> 
&nbsp;&nbsp;snapshot_count | **int64**<br> 
snapshot_spec | **[SnapshotSpec](#SnapshotSpec3)**<br> 


### SchedulePolicy {#SchedulePolicy3}

Field | Description
--- | ---
start_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>start time for the first run. 
expression | **string**<br>cron format (* * * * *) 


### SnapshotSpec {#SnapshotSpec3}

Field | Description
--- | ---
description | **string**<br>Description of the created snapshot. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. 


### Operation {#Operation1}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateSnapshotScheduleMetadata](#UpdateSnapshotScheduleMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[SnapshotSchedule](#SnapshotSchedule3)>**<br>if operation finished successfully. 


### UpdateSnapshotScheduleMetadata {#UpdateSnapshotScheduleMetadata}

Field | Description
--- | ---
snapshot_schedule_id | **string**<br> 


### SnapshotSchedule {#SnapshotSchedule3}

Field | Description
--- | ---
id | **string**<br>ID of the snapshot schedule policy. 
folder_id | **string**<br>ID of the folder that the scheduler policy belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
name | **string**<br>Name of the schedule policy. The name is unique within the folder. 
description | **string**<br>Description of the schedule policy. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. 
status | enum **Status**<br> 
schedule_policy | **[SchedulePolicy](#SchedulePolicy4)**<br>schedule properties 
retention_policy | **oneof:** `retention_period` or `snapshot_count`<br>
&nbsp;&nbsp;retention_period | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br> 
&nbsp;&nbsp;snapshot_count | **int64**<br> 
snapshot_spec | **[SnapshotSpec](#SnapshotSpec4)**<br>properties to create snapshot with. 


## Delete {#Delete}

Deletes the specified snapshot schedule. <br>Deleting a snapshot schedule removes its data permanently and is irreversible. However, deleting a schedule does not delete any snapshots previously made by the schedule. You must delete snapshots separately.

**rpc Delete ([DeleteSnapshotScheduleRequest](#DeleteSnapshotScheduleRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteSnapshotScheduleMetadata](#DeleteSnapshotScheduleMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteSnapshotScheduleRequest {#DeleteSnapshotScheduleRequest}

Field | Description
--- | ---
snapshot_schedule_id | **string**<br>ID of the snapshot schedule to delete. 


### Operation {#Operation2}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteSnapshotScheduleMetadata](#DeleteSnapshotScheduleMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### DeleteSnapshotScheduleMetadata {#DeleteSnapshotScheduleMetadata}

Field | Description
--- | ---
snapshot_schedule_id | **string**<br> 


## UpdateDisks {#UpdateDisks}

UpdateDisks of schedule

**rpc UpdateDisks ([UpdateSnapshotScheduleDisksRequest](#UpdateSnapshotScheduleDisksRequest)) returns ([operation.Operation](#Operation3))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateSnapshotScheduleDisksMetadata](#UpdateSnapshotScheduleDisksMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[SnapshotSchedule](#SnapshotSchedule4)<br>

### UpdateSnapshotScheduleDisksRequest {#UpdateSnapshotScheduleDisksRequest}

Field | Description
--- | ---
snapshot_schedule_id | **string**<br>ID of the snapshot schedule to update. 
remove[] | **string**<br>List of disk ids to remove from the specified schedule. 
add[] | **string**<br>List of disk ids to add to the specified schedule 


### Operation {#Operation3}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateSnapshotScheduleDisksMetadata](#UpdateSnapshotScheduleDisksMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[SnapshotSchedule](#SnapshotSchedule4)>**<br>if operation finished successfully. 


### UpdateSnapshotScheduleDisksMetadata {#UpdateSnapshotScheduleDisksMetadata}

Field | Description
--- | ---
snapshot_schedule_id | **string**<br> 


### SnapshotSchedule {#SnapshotSchedule4}

Field | Description
--- | ---
id | **string**<br>ID of the snapshot schedule policy. 
folder_id | **string**<br>ID of the folder that the scheduler policy belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
name | **string**<br>Name of the schedule policy. The name is unique within the folder. 
description | **string**<br>Description of the schedule policy. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. 
status | enum **Status**<br> 
schedule_policy | **[SchedulePolicy](#SchedulePolicy4)**<br>schedule properties 
retention_policy | **oneof:** `retention_period` or `snapshot_count`<br>
&nbsp;&nbsp;retention_period | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br> 
&nbsp;&nbsp;snapshot_count | **int64**<br> 
snapshot_spec | **[SnapshotSpec](#SnapshotSpec4)**<br>properties to create snapshot with. 


### SchedulePolicy {#SchedulePolicy4}

Field | Description
--- | ---
start_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>start time for the first run. 
expression | **string**<br>cron format (* * * * *) 


### SnapshotSpec {#SnapshotSpec4}

Field | Description
--- | ---
description | **string**<br>Description of the created snapshot. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. 


## Disable {#Disable}

Disable schedule sets status InActive. <br>When schedule os disabled snapshots will not be created or deleted according to retention policy.

**rpc Disable ([DisableSnapshotScheduleRequest](#DisableSnapshotScheduleRequest)) returns ([operation.Operation](#Operation4))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DisableSnapshotScheduleMetadata](#DisableSnapshotScheduleMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[SnapshotSchedule](#SnapshotSchedule5)<br>

### DisableSnapshotScheduleRequest {#DisableSnapshotScheduleRequest}

Field | Description
--- | ---
snapshot_schedule_id | **string**<br>ID of the snapshot schedule to disable. 


### Operation {#Operation4}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DisableSnapshotScheduleMetadata](#DisableSnapshotScheduleMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[SnapshotSchedule](#SnapshotSchedule5)>**<br>if operation finished successfully. 


### DisableSnapshotScheduleMetadata {#DisableSnapshotScheduleMetadata}

Field | Description
--- | ---
snapshot_schedule_id | **string**<br> 


### SnapshotSchedule {#SnapshotSchedule5}

Field | Description
--- | ---
id | **string**<br>ID of the snapshot schedule policy. 
folder_id | **string**<br>ID of the folder that the scheduler policy belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
name | **string**<br>Name of the schedule policy. The name is unique within the folder. 
description | **string**<br>Description of the schedule policy. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. 
status | enum **Status**<br> 
schedule_policy | **[SchedulePolicy](#SchedulePolicy5)**<br>schedule properties 
retention_policy | **oneof:** `retention_period` or `snapshot_count`<br>
&nbsp;&nbsp;retention_period | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br> 
&nbsp;&nbsp;snapshot_count | **int64**<br> 
snapshot_spec | **[SnapshotSpec](#SnapshotSpec5)**<br>properties to create snapshot with. 


### SchedulePolicy {#SchedulePolicy5}

Field | Description
--- | ---
start_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>start time for the first run. 
expression | **string**<br>cron format (* * * * *) 


### SnapshotSpec {#SnapshotSpec5}

Field | Description
--- | ---
description | **string**<br>Description of the created snapshot. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. 


## Enable {#Enable}

Enable schedule sets status Active.

**rpc Enable ([EnableSnapshotScheduleRequest](#EnableSnapshotScheduleRequest)) returns ([operation.Operation](#Operation5))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[EnableSnapshotScheduleMetadata](#EnableSnapshotScheduleMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[SnapshotSchedule](#SnapshotSchedule6)<br>

### EnableSnapshotScheduleRequest {#EnableSnapshotScheduleRequest}

Field | Description
--- | ---
snapshot_schedule_id | **string**<br>ID of the snapshot schedule to enable. 


### Operation {#Operation5}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[EnableSnapshotScheduleMetadata](#EnableSnapshotScheduleMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[SnapshotSchedule](#SnapshotSchedule6)>**<br>if operation finished successfully. 


### EnableSnapshotScheduleMetadata {#EnableSnapshotScheduleMetadata}

Field | Description
--- | ---
snapshot_schedule_id | **string**<br> 


### SnapshotSchedule {#SnapshotSchedule6}

Field | Description
--- | ---
id | **string**<br>ID of the snapshot schedule policy. 
folder_id | **string**<br>ID of the folder that the scheduler policy belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
name | **string**<br>Name of the schedule policy. The name is unique within the folder. 
description | **string**<br>Description of the schedule policy. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. 
status | enum **Status**<br> 
schedule_policy | **[SchedulePolicy](#SchedulePolicy6)**<br>schedule properties 
retention_policy | **oneof:** `retention_period` or `snapshot_count`<br>
&nbsp;&nbsp;retention_period | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br> 
&nbsp;&nbsp;snapshot_count | **int64**<br> 
snapshot_spec | **[SnapshotSpec](#SnapshotSpec6)**<br>properties to create snapshot with. 


### SchedulePolicy {#SchedulePolicy6}

Field | Description
--- | ---
start_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>start time for the first run. 
expression | **string**<br>cron format (* * * * *) 


### SnapshotSpec {#SnapshotSpec6}

Field | Description
--- | ---
description | **string**<br>Description of the created snapshot. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. 


## ListOperations {#ListOperations}

Lists operations for the specified snapshot schedule.

**rpc ListOperations ([ListSnapshotScheduleOperationsRequest](#ListSnapshotScheduleOperationsRequest)) returns ([ListSnapshotScheduleOperationsResponse](#ListSnapshotScheduleOperationsResponse))**

### ListSnapshotScheduleOperationsRequest {#ListSnapshotScheduleOperationsRequest}

Field | Description
--- | ---
snapshot_schedule_id | **string**<br>ID of the SnapshotSchedule resource to list operations for. 
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListSnapshotScheduleOperationsResponse.next_page_token](#ListSnapshotScheduleOperationsResponse) that can be used to get the next page of results in subsequent list requests. 
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListSnapshotScheduleOperationsResponse.next_page_token](#ListSnapshotScheduleOperationsResponse) returned by a previous list request. 


### ListSnapshotScheduleOperationsResponse {#ListSnapshotScheduleOperationsResponse}

Field | Description
--- | ---
operations[] | **[operation.Operation](#Operation6)**<br>List of operations for the specified snapshot schedule. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListSnapshotScheduleOperationsRequest.page_size](#ListSnapshotScheduleOperationsRequest), use the `next_page_token` as the value for the [ListSnapshotScheduleOperationsRequest.page_token](#ListSnapshotScheduleOperationsRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### Operation {#Operation6}

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


## ListSnapshots {#ListSnapshots}

List snapshot created by schedule.

**rpc ListSnapshots ([ListSnapshotScheduleSnapshotsRequest](#ListSnapshotScheduleSnapshotsRequest)) returns ([ListSnapshotScheduleSnapshotsResponse](#ListSnapshotScheduleSnapshotsResponse))**

### ListSnapshotScheduleSnapshotsRequest {#ListSnapshotScheduleSnapshotsRequest}

Field | Description
--- | ---
snapshot_schedule_id | **string**<br>ID of the SnapshotSchedule resource to list snapshots for. 
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListSnapshotScheduleSnapshotsResponse.next_page_token](#ListSnapshotScheduleSnapshotsResponse) that can be used to get the next page of results in subsequent list requests. 
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListSnapshotScheduleSnapshotsResponse.next_page_token](#ListSnapshotScheduleSnapshotsResponse) returned by a previous list request. 


### ListSnapshotScheduleSnapshotsResponse {#ListSnapshotScheduleSnapshotsResponse}

Field | Description
--- | ---
snapshots[] | **[Snapshot](#Snapshot)**<br>List of snapshots for the specified snapshot schedule. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListSnapshotScheduleSnapshotsRequest.page_size](#ListSnapshotScheduleSnapshotsRequest), use the `next_page_token` as the value for the [ListSnapshotScheduleSnapshotsRequest.page_token](#ListSnapshotScheduleSnapshotsRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### Snapshot {#Snapshot}

Field | Description
--- | ---
id | **string**<br>ID of the snapshot. 
folder_id | **string**<br>ID of the folder that the snapshot belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
name | **string**<br>Name of the snapshot. 1-63 characters long. 
description | **string**<br>Description of the snapshot. 0-256 characters long. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. Maximum of 64 per resource. 
storage_size | **int64**<br>Size of the snapshot, specified in bytes. 
disk_size | **int64**<br>Size of the disk when the snapshot was created, specified in bytes. 
product_ids[] | **string**<br>License IDs that indicate which licenses are attached to this resource. License IDs are used to calculate additional charges for the use of the virtual machine. <br>The correct license ID is generated by the platform. IDs are inherited by new resources created from this resource. <br>If you know the license IDs, specify them when you create the image. For example, if you create a disk image using a third-party utility and load it into Object Storage, the license IDs will be lost. You can specify them in the [yandex.cloud.compute.v1.ImageService.Create](/docs/compute/api-ref/grpc/image_service#Create) request. 
status | enum **Status**<br>Current status of the snapshot. <ul><li>`CREATING`: Snapshot is being created.</li><li>`READY`: Snapshot is ready to use.</li><li>`ERROR`: Snapshot encountered a problem and cannot operate.</li><li>`DELETING`: Snapshot is being deleted.</li></ul>
source_disk_id | **string**<br>ID of the source disk used to create this snapshot. 


## ListDisks {#ListDisks}

List disks that belong to schedule.

**rpc ListDisks ([ListSnapshotScheduleDisksRequest](#ListSnapshotScheduleDisksRequest)) returns ([ListSnapshotScheduleDisksResponse](#ListSnapshotScheduleDisksResponse))**

### ListSnapshotScheduleDisksRequest {#ListSnapshotScheduleDisksRequest}

Field | Description
--- | ---
snapshot_schedule_id | **string**<br>ID of the SnapshotSchedule resource to list disks for. 
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListSnapshotScheduleDisksResponse.next_page_token](#ListSnapshotScheduleDisksResponse) that can be used to get the next page of results in subsequent list requests. 
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListSnapshotScheduleDisksResponse.next_page_token](#ListSnapshotScheduleDisksResponse) returned by a previous list request. 


### ListSnapshotScheduleDisksResponse {#ListSnapshotScheduleDisksResponse}

Field | Description
--- | ---
disks[] | **[Disk](#Disk)**<br>List of disks for the specified snapshot schedule. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListSnapshotScheduleDisksRequest.page_size](#ListSnapshotScheduleDisksRequest), use the `next_page_token` as the value for the [ListSnapshotScheduleDisksRequest.page_token](#ListSnapshotScheduleDisksRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


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


