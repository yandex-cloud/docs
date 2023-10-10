---
editable: false
sourcePath: en/_api-ref-grpc/compute/api-ref/grpc/snapshot_schedule_service.md
---

# Compute Cloud API, gRPC: SnapshotScheduleService

A set of methods for managing snapshot schedules.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specified snapshot schedule. |
| [List](#List) | Retrieves the list of snapshot schedules in the specified folder. |
| [Create](#Create) | Creates a snapshot schedule in the specified folder. |
| [Update](#Update) | Updates the specified snapshot schedule. |
| [Delete](#Delete) | Deletes the specified snapshot schedule. |
| [UpdateDisks](#UpdateDisks) | Updates the list of disks attached to the specified schedule. |
| [Disable](#Disable) | Disables the specified snapshot schedule. |
| [Enable](#Enable) | Enables the specified snapshot schedule. |
| [ListOperations](#ListOperations) | Lists operations for the specified snapshot schedule. |
| [ListSnapshots](#ListSnapshots) | Retrieves the list of snapshots created by the specified snapshot schedule. |
| [ListDisks](#ListDisks) | Retrieves the list of disks attached to the specified snapshot schedule. |
| [ListAccessBindings](#ListAccessBindings) | Lists access bindings for the snapshot schedule. |
| [SetAccessBindings](#SetAccessBindings) | Sets access bindings for the snapshot schedule. |
| [UpdateAccessBindings](#UpdateAccessBindings) | Updates access bindings for the snapshot schedule. |

## Calls SnapshotScheduleService {#calls}

## Get {#Get}

Returns the specified snapshot schedule. <br>To get the list of available snapshot schedules, make a [List](#List) request.

**rpc Get ([GetSnapshotScheduleRequest](#GetSnapshotScheduleRequest)) returns ([SnapshotSchedule](#SnapshotSchedule))**

### GetSnapshotScheduleRequest {#GetSnapshotScheduleRequest}

Field | Description
--- | ---
snapshot_schedule_id | **string**<br>ID of the snapshot schedule to return. <br>To get a schedule ID, make a [SnapshotScheduleService.List](#List) request. 


### SnapshotSchedule {#SnapshotSchedule}

Field | Description
--- | ---
id | **string**<br>ID of the snapshot schedule. 
folder_id | **string**<br>ID of the folder that the snapshot schedule belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the snapshot schedule. <br>The name is unique within the folder. 
description | **string**<br>Description of the snapshot schedule. 
labels | **map<string,string>**<br>Snapshot schedule labels as `key:value` pairs. 
status | enum **Status**<br>Status of the snapshot schedule. <ul><li>`CREATING`: The snapshot schedule is being created.</li><li>`ACTIVE`: The snapshot schedule is on: new disk snapshots will be created, old ones deleted (if [SnapshotSchedule.retention_policy](#SnapshotSchedule) is specified).</li><li>`INACTIVE`: The schedule is interrupted, snapshots won't be created or deleted.</li><li>`DELETING`: The schedule is being deleted.</li><li>`UPDATING`: Changes are being made to snapshot schedule settings or a list of attached disks.</li></ul>
schedule_policy | **[SchedulePolicy](#SchedulePolicy)**<br>Frequency settings of the snapshot schedule. 
retention_policy | **oneof:** `retention_period` or `snapshot_count`<br>Retention policy of the snapshot schedule.
&nbsp;&nbsp;retention_period | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Retention period of the snapshot schedule. Once a snapshot created by the schedule reaches this age, it is automatically deleted. 
&nbsp;&nbsp;snapshot_count | **int64**<br>Retention count of the snapshot schedule. Once the number of snapshots created by the schedule exceeds this number, the oldest ones are automatically deleted. E.g. if the number is 5, the first snapshot is deleted after the sixth one is created, the second is deleted after the seventh one is created, and so on. 
snapshot_spec | **[SnapshotSpec](#SnapshotSpec)**<br>Attributes of snapshots created by the snapshot schedule. 


### SchedulePolicy {#SchedulePolicy}

Field | Description
--- | ---
start_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Timestamp for creating the first snapshot. 
expression | **string**<br>Cron expression for the snapshot schedule (UTC+0). <br>The expression must consist of five fields (`Minutes Hours Day-of-month Month Day-of-week`) or be one of nonstandard predefined expressions (e.g. `@hourly`). For details about the format, see [documentation](/docs/compute/concepts/snapshot-schedule#cron) 


### SnapshotSpec {#SnapshotSpec}

Field | Description
--- | ---
description | **string**<br>Description of the created snapshot. 
labels | **map<string,string>**<br>Snapshot labels as `key:value` pairs. 


## List {#List}

Retrieves the list of snapshot schedules in the specified folder.

**rpc List ([ListSnapshotSchedulesRequest](#ListSnapshotSchedulesRequest)) returns ([ListSnapshotSchedulesResponse](#ListSnapshotSchedulesResponse))**

### ListSnapshotSchedulesRequest {#ListSnapshotSchedulesRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to list snapshot schedules in. <br>To get the folder ID, make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List) request. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListSnapshotSchedulesResponse.next_page_token](#ListSnapshotSchedulesResponse) that can be used to get the next page of results in subsequent list requests. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListSnapshotSchedulesResponse.next_page_token](#ListSnapshotSchedulesResponse) returned by a previous list request. The maximum string length in characters is 100.
filter | **string**<br>A filter expression that filters snapshot schedules listed in the response. <br>The expression must specify: <ol><li>The field name. Currently you can use filtering only on [SnapshotSchedule.name](#SnapshotSchedule1) field. </li><li>An operator. Can be either `=` or `!=` for single values, `IN` or `NOT IN` for lists of values. </li><li>The value. Must be 3-63 characters long and match the regular expression `^[a-z][-a-z0-9]{1,61}[a-z0-9]`. </li></ol>Example of a filter: `name=my-schedule`. The maximum string length in characters is 1000.
order_by | **string**<br>A sorting expression that sorts snapshot schedules listed in the response. <br>The expression must specify the field name from [SnapshotSchedule](#SnapshotSchedule1) and `asc`ending or `desc`ending order, e.g. `createdAt desc`. <br>Default value: `id asc`. The maximum string length in characters is 100.


### ListSnapshotSchedulesResponse {#ListSnapshotSchedulesResponse}

Field | Description
--- | ---
snapshot_schedules[] | **[SnapshotSchedule](#SnapshotSchedule1)**<br>List of snapshot schedules in the specified folder. 
next_page_token | **string**<br>Token for getting the next page of the list. If the number of results is greater than the specified [ListSnapshotSchedulesRequest.page_size](#ListSnapshotSchedulesRequest), use `next_page_token` as the value for the [ListSnapshotSchedulesRequest.page_token](#ListSnapshotSchedulesRequest) parameter in the next list request. <br>Each subsequent page will have its own `next_page_token` to continue paging through the results. 


### SnapshotSchedule {#SnapshotSchedule1}

Field | Description
--- | ---
id | **string**<br>ID of the snapshot schedule. 
folder_id | **string**<br>ID of the folder that the snapshot schedule belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the snapshot schedule. <br>The name is unique within the folder. 
description | **string**<br>Description of the snapshot schedule. 
labels | **map<string,string>**<br>Snapshot schedule labels as `key:value` pairs. 
status | enum **Status**<br>Status of the snapshot schedule. <ul><li>`CREATING`: The snapshot schedule is being created.</li><li>`ACTIVE`: The snapshot schedule is on: new disk snapshots will be created, old ones deleted (if [SnapshotSchedule.retention_policy](#SnapshotSchedule1) is specified).</li><li>`INACTIVE`: The schedule is interrupted, snapshots won't be created or deleted.</li><li>`DELETING`: The schedule is being deleted.</li><li>`UPDATING`: Changes are being made to snapshot schedule settings or a list of attached disks.</li></ul>
schedule_policy | **[SchedulePolicy](#SchedulePolicy1)**<br>Frequency settings of the snapshot schedule. 
retention_policy | **oneof:** `retention_period` or `snapshot_count`<br>Retention policy of the snapshot schedule.
&nbsp;&nbsp;retention_period | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Retention period of the snapshot schedule. Once a snapshot created by the schedule reaches this age, it is automatically deleted. 
&nbsp;&nbsp;snapshot_count | **int64**<br>Retention count of the snapshot schedule. Once the number of snapshots created by the schedule exceeds this number, the oldest ones are automatically deleted. E.g. if the number is 5, the first snapshot is deleted after the sixth one is created, the second is deleted after the seventh one is created, and so on. 
snapshot_spec | **[SnapshotSpec](#SnapshotSpec1)**<br>Attributes of snapshots created by the snapshot schedule. 


### SchedulePolicy {#SchedulePolicy1}

Field | Description
--- | ---
start_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Timestamp for creating the first snapshot. 
expression | **string**<br>Cron expression for the snapshot schedule (UTC+0). <br>The expression must consist of five fields (`Minutes Hours Day-of-month Month Day-of-week`) or be one of nonstandard predefined expressions (e.g. `@hourly`). For details about the format, see [documentation](/docs/compute/concepts/snapshot-schedule#cron) 


### SnapshotSpec {#SnapshotSpec1}

Field | Description
--- | ---
description | **string**<br>Description of the created snapshot. 
labels | **map<string,string>**<br>Snapshot labels as `key:value` pairs. 


## Create {#Create}

Creates a snapshot schedule in the specified folder.

**rpc Create ([CreateSnapshotScheduleRequest](#CreateSnapshotScheduleRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateSnapshotScheduleMetadata](#CreateSnapshotScheduleMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[SnapshotSchedule](#SnapshotSchedule2)<br>

### CreateSnapshotScheduleRequest {#CreateSnapshotScheduleRequest}

Field | Description
--- | ---
folder_id | **string**<br>ID of the folder to create a snapshot schedule in. <br>Snapshots are created in the same folder as the schedule, even if disks from other folders are attached to the schedule. <br>To get a folder ID, make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List) request. 
name | **string**<br>Name of the snapshot schedule. <br>The name must be unique within the folder. 
description | **string**<br>Description of the snapshot schedule. 
labels | **map<string,string>**<br>Snapshot schedule labels as `key:value` pairs. 
schedule_policy | **[SchedulePolicy](#SchedulePolicy2)**<br>Frequency settings of the snapshot schedule. 
retention_policy | **oneof:** `retention_period` or `snapshot_count`<br>Retention policy of the snapshot schedule.
&nbsp;&nbsp;retention_period | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Retention period of the snapshot schedule. Once a snapshot created by the schedule reaches this age, it is automatically deleted. 
&nbsp;&nbsp;snapshot_count | **int64**<br>Retention count of the snapshot schedule. Once the number of snapshots created by the schedule exceeds this number, the oldest ones are automatically deleted. E.g. if the number is 5, the first snapshot is deleted after the sixth one is created, the second is deleted after the seventh one is created, and so on. 
snapshot_spec | **[SnapshotSpec](#SnapshotSpec2)**<br>Attributes of snapshots created by the snapshot schedule. 
disk_ids[] | **string**<br>List of IDs of the disks attached to the snapshot schedule. <br>To get a disk ID, make a [yandex.cloud.compute.v1.DiskService.List](/docs/compute/api-ref/grpc/disk_service#List) request. 


### SchedulePolicy {#SchedulePolicy2}

Field | Description
--- | ---
start_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Timestamp for creating the first snapshot. 
expression | **string**<br>Cron expression for the snapshot schedule (UTC+0). <br>The expression must consist of five fields (`Minutes Hours Day-of-month Month Day-of-week`) or be one of nonstandard predefined expressions (e.g. `@hourly`). For details about the format, see [documentation](/docs/compute/concepts/snapshot-schedule#cron) 


### SnapshotSpec {#SnapshotSpec2}

Field | Description
--- | ---
description | **string**<br>Description of the created snapshot. 
labels | **map<string,string>**<br>Snapshot labels as `key:value` pairs. 


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
snapshot_schedule_id | **string**<br>ID of the snapshot schedule that is being created. 


### SnapshotSchedule {#SnapshotSchedule2}

Field | Description
--- | ---
id | **string**<br>ID of the snapshot schedule. 
folder_id | **string**<br>ID of the folder that the snapshot schedule belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the snapshot schedule. <br>The name is unique within the folder. 
description | **string**<br>Description of the snapshot schedule. 
labels | **map<string,string>**<br>Snapshot schedule labels as `key:value` pairs. 
status | enum **Status**<br>Status of the snapshot schedule. <ul><li>`CREATING`: The snapshot schedule is being created.</li><li>`ACTIVE`: The snapshot schedule is on: new disk snapshots will be created, old ones deleted (if [SnapshotSchedule.retention_policy](#SnapshotSchedule2) is specified).</li><li>`INACTIVE`: The schedule is interrupted, snapshots won't be created or deleted.</li><li>`DELETING`: The schedule is being deleted.</li><li>`UPDATING`: Changes are being made to snapshot schedule settings or a list of attached disks.</li></ul>
schedule_policy | **[SchedulePolicy](#SchedulePolicy3)**<br>Frequency settings of the snapshot schedule. 
retention_policy | **oneof:** `retention_period` or `snapshot_count`<br>Retention policy of the snapshot schedule.
&nbsp;&nbsp;retention_period | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Retention period of the snapshot schedule. Once a snapshot created by the schedule reaches this age, it is automatically deleted. 
&nbsp;&nbsp;snapshot_count | **int64**<br>Retention count of the snapshot schedule. Once the number of snapshots created by the schedule exceeds this number, the oldest ones are automatically deleted. E.g. if the number is 5, the first snapshot is deleted after the sixth one is created, the second is deleted after the seventh one is created, and so on. 
snapshot_spec | **[SnapshotSpec](#SnapshotSpec3)**<br>Attributes of snapshots created by the snapshot schedule. 


## Update {#Update}

Updates the specified snapshot schedule. <br>The schedule is updated only after all snapshot creations and deletions triggered by the schedule are completed.

**rpc Update ([UpdateSnapshotScheduleRequest](#UpdateSnapshotScheduleRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateSnapshotScheduleMetadata](#UpdateSnapshotScheduleMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[SnapshotSchedule](#SnapshotSchedule3)<br>

### UpdateSnapshotScheduleRequest {#UpdateSnapshotScheduleRequest}

Field | Description
--- | ---
snapshot_schedule_id | **string**<br>ID of the snapshot schedule to update. <br>To get the snapshot schedule ID, make a [SnapshotScheduleService.List](#List) request. 
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Field mask that specifies which attributes of the snapshot schedule should be updated. 
name | **string**<br>New name for the snapshot schedule. <br>The name must be unique within the folder. 
description | **string**<br>New description of the snapshot schedule. 
labels | **map<string,string>**<br>Snapshot schedule labels as `key:value` pairs. <br>Existing set of labels is completely replaced by the provided set, so if you just want to add or remove a label: <ol><li>Get the current set of labels with a [SnapshotScheduleService.Get](#Get) request. </li><li>Add or remove a label in this set. </li><li>Send the new set in this field.</li></ol> 
schedule_policy | **[SchedulePolicy](#SchedulePolicy3)**<br>New frequency settings of the snapshot schedule. 
retention_policy | **oneof:** `retention_period` or `snapshot_count`<br>New retention policy of the snapshot schedule.
&nbsp;&nbsp;retention_period | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Retention period of the snapshot schedule. Once a snapshot created by the schedule reaches this age, it is automatically deleted. 
&nbsp;&nbsp;snapshot_count | **int64**<br>Retention count of the snapshot schedule. Once the number of snapshots created by the schedule exceeds this number, the oldest ones are automatically deleted. E.g. if the number is 5, the first snapshot is deleted after the sixth one is created, the second is deleted after the seventh one is created, and so on. 
snapshot_spec | **[SnapshotSpec](#SnapshotSpec3)**<br>New attributes of snapshots created by the snapshot schedule. 


### SchedulePolicy {#SchedulePolicy3}

Field | Description
--- | ---
start_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Timestamp for creating the first snapshot. 
expression | **string**<br>Cron expression for the snapshot schedule (UTC+0). <br>The expression must consist of five fields (`Minutes Hours Day-of-month Month Day-of-week`) or be one of nonstandard predefined expressions (e.g. `@hourly`). For details about the format, see [documentation](/docs/compute/concepts/snapshot-schedule#cron) 


### SnapshotSpec {#SnapshotSpec3}

Field | Description
--- | ---
description | **string**<br>Description of the created snapshot. 
labels | **map<string,string>**<br>Snapshot labels as `key:value` pairs. 


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
snapshot_schedule_id | **string**<br>ID of the snapshot schedule that is being updated. 


### SnapshotSchedule {#SnapshotSchedule3}

Field | Description
--- | ---
id | **string**<br>ID of the snapshot schedule. 
folder_id | **string**<br>ID of the folder that the snapshot schedule belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the snapshot schedule. <br>The name is unique within the folder. 
description | **string**<br>Description of the snapshot schedule. 
labels | **map<string,string>**<br>Snapshot schedule labels as `key:value` pairs. 
status | enum **Status**<br>Status of the snapshot schedule. <ul><li>`CREATING`: The snapshot schedule is being created.</li><li>`ACTIVE`: The snapshot schedule is on: new disk snapshots will be created, old ones deleted (if [SnapshotSchedule.retention_policy](#SnapshotSchedule3) is specified).</li><li>`INACTIVE`: The schedule is interrupted, snapshots won't be created or deleted.</li><li>`DELETING`: The schedule is being deleted.</li><li>`UPDATING`: Changes are being made to snapshot schedule settings or a list of attached disks.</li></ul>
schedule_policy | **[SchedulePolicy](#SchedulePolicy4)**<br>Frequency settings of the snapshot schedule. 
retention_policy | **oneof:** `retention_period` or `snapshot_count`<br>Retention policy of the snapshot schedule.
&nbsp;&nbsp;retention_period | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Retention period of the snapshot schedule. Once a snapshot created by the schedule reaches this age, it is automatically deleted. 
&nbsp;&nbsp;snapshot_count | **int64**<br>Retention count of the snapshot schedule. Once the number of snapshots created by the schedule exceeds this number, the oldest ones are automatically deleted. E.g. if the number is 5, the first snapshot is deleted after the sixth one is created, the second is deleted after the seventh one is created, and so on. 
snapshot_spec | **[SnapshotSpec](#SnapshotSpec4)**<br>Attributes of snapshots created by the snapshot schedule. 


## Delete {#Delete}

Deletes the specified snapshot schedule. <br>Deleting a snapshot schedule removes its data permanently and is irreversible. However, deleting a schedule does not delete any snapshots created by the schedule. You must delete snapshots separately. <br>The schedule is deleted only after all snapshot creations and deletions triggered by the schedule are completed.

**rpc Delete ([DeleteSnapshotScheduleRequest](#DeleteSnapshotScheduleRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteSnapshotScheduleMetadata](#DeleteSnapshotScheduleMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteSnapshotScheduleRequest {#DeleteSnapshotScheduleRequest}

Field | Description
--- | ---
snapshot_schedule_id | **string**<br>ID of the snapshot schedule to delete. <br>To get a snapshot schedule ID, make a [SnapshotScheduleService.List](#List) request. 


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
snapshot_schedule_id | **string**<br>ID of the snapshot schedule that is being deleted. 


## UpdateDisks {#UpdateDisks}

Updates the list of disks attached to the specified schedule. <br>The schedule is updated only after all snapshot creations and deletions triggered by the schedule are completed.

**rpc UpdateDisks ([UpdateSnapshotScheduleDisksRequest](#UpdateSnapshotScheduleDisksRequest)) returns ([operation.Operation](#Operation3))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateSnapshotScheduleDisksMetadata](#UpdateSnapshotScheduleDisksMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[SnapshotSchedule](#SnapshotSchedule4)<br>

### UpdateSnapshotScheduleDisksRequest {#UpdateSnapshotScheduleDisksRequest}

Field | Description
--- | ---
snapshot_schedule_id | **string**<br>ID of the snapshot schedule to update. <br>To get a snapshot schedule ID, make a [SnapshotScheduleService.List](#List) request. 
remove[] | **string**<br>List of IDs of the disks to detach from the specified schedule. <br>To get an ID of a disk attached to the schedule, make a [SnapshotScheduleService.ListDisks](#ListDisks) request. 
add[] | **string**<br>List of IDs of the disks to attach to the specified schedule. <br>To get a disk ID, make a [yandex.cloud.compute.v1.DiskService.List](/docs/compute/api-ref/grpc/disk_service#List) request. 


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
snapshot_schedule_id | **string**<br>ID of the snapshot schedule that is being updated. 


### SnapshotSchedule {#SnapshotSchedule4}

Field | Description
--- | ---
id | **string**<br>ID of the snapshot schedule. 
folder_id | **string**<br>ID of the folder that the snapshot schedule belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the snapshot schedule. <br>The name is unique within the folder. 
description | **string**<br>Description of the snapshot schedule. 
labels | **map<string,string>**<br>Snapshot schedule labels as `key:value` pairs. 
status | enum **Status**<br>Status of the snapshot schedule. <ul><li>`CREATING`: The snapshot schedule is being created.</li><li>`ACTIVE`: The snapshot schedule is on: new disk snapshots will be created, old ones deleted (if [SnapshotSchedule.retention_policy](#SnapshotSchedule4) is specified).</li><li>`INACTIVE`: The schedule is interrupted, snapshots won't be created or deleted.</li><li>`DELETING`: The schedule is being deleted.</li><li>`UPDATING`: Changes are being made to snapshot schedule settings or a list of attached disks.</li></ul>
schedule_policy | **[SchedulePolicy](#SchedulePolicy4)**<br>Frequency settings of the snapshot schedule. 
retention_policy | **oneof:** `retention_period` or `snapshot_count`<br>Retention policy of the snapshot schedule.
&nbsp;&nbsp;retention_period | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Retention period of the snapshot schedule. Once a snapshot created by the schedule reaches this age, it is automatically deleted. 
&nbsp;&nbsp;snapshot_count | **int64**<br>Retention count of the snapshot schedule. Once the number of snapshots created by the schedule exceeds this number, the oldest ones are automatically deleted. E.g. if the number is 5, the first snapshot is deleted after the sixth one is created, the second is deleted after the seventh one is created, and so on. 
snapshot_spec | **[SnapshotSpec](#SnapshotSpec4)**<br>Attributes of snapshots created by the snapshot schedule. 


### SchedulePolicy {#SchedulePolicy4}

Field | Description
--- | ---
start_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Timestamp for creating the first snapshot. 
expression | **string**<br>Cron expression for the snapshot schedule (UTC+0). <br>The expression must consist of five fields (`Minutes Hours Day-of-month Month Day-of-week`) or be one of nonstandard predefined expressions (e.g. `@hourly`). For details about the format, see [documentation](/docs/compute/concepts/snapshot-schedule#cron) 


### SnapshotSpec {#SnapshotSpec4}

Field | Description
--- | ---
description | **string**<br>Description of the created snapshot. 
labels | **map<string,string>**<br>Snapshot labels as `key:value` pairs. 


## Disable {#Disable}

Disables the specified snapshot schedule. <br>The [SnapshotSchedule.status](#SnapshotSchedule5) is changed to `INACTIVE`: the schedule is interrupted, snapshots won't be created or deleted. <br>The schedule is disabled only after all snapshot creations and deletions triggered by the schedule are completed.

**rpc Disable ([DisableSnapshotScheduleRequest](#DisableSnapshotScheduleRequest)) returns ([operation.Operation](#Operation4))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DisableSnapshotScheduleMetadata](#DisableSnapshotScheduleMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[SnapshotSchedule](#SnapshotSchedule5)<br>

### DisableSnapshotScheduleRequest {#DisableSnapshotScheduleRequest}

Field | Description
--- | ---
snapshot_schedule_id | **string**<br>ID of the snapshot schedule to disable. <br>To get a snapshot schedule ID, make a [SnapshotScheduleService.List](#List) request. 


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
snapshot_schedule_id | **string**<br>ID of the snapshot schedule that is being disabled. 


### SnapshotSchedule {#SnapshotSchedule5}

Field | Description
--- | ---
id | **string**<br>ID of the snapshot schedule. 
folder_id | **string**<br>ID of the folder that the snapshot schedule belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the snapshot schedule. <br>The name is unique within the folder. 
description | **string**<br>Description of the snapshot schedule. 
labels | **map<string,string>**<br>Snapshot schedule labels as `key:value` pairs. 
status | enum **Status**<br>Status of the snapshot schedule. <ul><li>`CREATING`: The snapshot schedule is being created.</li><li>`ACTIVE`: The snapshot schedule is on: new disk snapshots will be created, old ones deleted (if [SnapshotSchedule.retention_policy](#SnapshotSchedule5) is specified).</li><li>`INACTIVE`: The schedule is interrupted, snapshots won't be created or deleted.</li><li>`DELETING`: The schedule is being deleted.</li><li>`UPDATING`: Changes are being made to snapshot schedule settings or a list of attached disks.</li></ul>
schedule_policy | **[SchedulePolicy](#SchedulePolicy5)**<br>Frequency settings of the snapshot schedule. 
retention_policy | **oneof:** `retention_period` or `snapshot_count`<br>Retention policy of the snapshot schedule.
&nbsp;&nbsp;retention_period | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Retention period of the snapshot schedule. Once a snapshot created by the schedule reaches this age, it is automatically deleted. 
&nbsp;&nbsp;snapshot_count | **int64**<br>Retention count of the snapshot schedule. Once the number of snapshots created by the schedule exceeds this number, the oldest ones are automatically deleted. E.g. if the number is 5, the first snapshot is deleted after the sixth one is created, the second is deleted after the seventh one is created, and so on. 
snapshot_spec | **[SnapshotSpec](#SnapshotSpec5)**<br>Attributes of snapshots created by the snapshot schedule. 


### SchedulePolicy {#SchedulePolicy5}

Field | Description
--- | ---
start_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Timestamp for creating the first snapshot. 
expression | **string**<br>Cron expression for the snapshot schedule (UTC+0). <br>The expression must consist of five fields (`Minutes Hours Day-of-month Month Day-of-week`) or be one of nonstandard predefined expressions (e.g. `@hourly`). For details about the format, see [documentation](/docs/compute/concepts/snapshot-schedule#cron) 


### SnapshotSpec {#SnapshotSpec5}

Field | Description
--- | ---
description | **string**<br>Description of the created snapshot. 
labels | **map<string,string>**<br>Snapshot labels as `key:value` pairs. 


## Enable {#Enable}

Enables the specified snapshot schedule. <br>The [SnapshotSchedule.status](#SnapshotSchedule6) is changed to `ACTIVE`: new disk snapshots will be created, old ones deleted (if [SnapshotSchedule.retention_policy](#SnapshotSchedule6) is specified).

**rpc Enable ([EnableSnapshotScheduleRequest](#EnableSnapshotScheduleRequest)) returns ([operation.Operation](#Operation5))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[EnableSnapshotScheduleMetadata](#EnableSnapshotScheduleMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[SnapshotSchedule](#SnapshotSchedule6)<br>

### EnableSnapshotScheduleRequest {#EnableSnapshotScheduleRequest}

Field | Description
--- | ---
snapshot_schedule_id | **string**<br>ID of the snapshot schedule to enable. <br>To get a snapshot schedule ID, make a [SnapshotScheduleService.List](#List) request. 


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
snapshot_schedule_id | **string**<br>ID of the snapshot schedule that is being enabled. 


### SnapshotSchedule {#SnapshotSchedule6}

Field | Description
--- | ---
id | **string**<br>ID of the snapshot schedule. 
folder_id | **string**<br>ID of the folder that the snapshot schedule belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the snapshot schedule. <br>The name is unique within the folder. 
description | **string**<br>Description of the snapshot schedule. 
labels | **map<string,string>**<br>Snapshot schedule labels as `key:value` pairs. 
status | enum **Status**<br>Status of the snapshot schedule. <ul><li>`CREATING`: The snapshot schedule is being created.</li><li>`ACTIVE`: The snapshot schedule is on: new disk snapshots will be created, old ones deleted (if [SnapshotSchedule.retention_policy](#SnapshotSchedule6) is specified).</li><li>`INACTIVE`: The schedule is interrupted, snapshots won't be created or deleted.</li><li>`DELETING`: The schedule is being deleted.</li><li>`UPDATING`: Changes are being made to snapshot schedule settings or a list of attached disks.</li></ul>
schedule_policy | **[SchedulePolicy](#SchedulePolicy6)**<br>Frequency settings of the snapshot schedule. 
retention_policy | **oneof:** `retention_period` or `snapshot_count`<br>Retention policy of the snapshot schedule.
&nbsp;&nbsp;retention_period | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Retention period of the snapshot schedule. Once a snapshot created by the schedule reaches this age, it is automatically deleted. 
&nbsp;&nbsp;snapshot_count | **int64**<br>Retention count of the snapshot schedule. Once the number of snapshots created by the schedule exceeds this number, the oldest ones are automatically deleted. E.g. if the number is 5, the first snapshot is deleted after the sixth one is created, the second is deleted after the seventh one is created, and so on. 
snapshot_spec | **[SnapshotSpec](#SnapshotSpec6)**<br>Attributes of snapshots created by the snapshot schedule. 


### SchedulePolicy {#SchedulePolicy6}

Field | Description
--- | ---
start_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Timestamp for creating the first snapshot. 
expression | **string**<br>Cron expression for the snapshot schedule (UTC+0). <br>The expression must consist of five fields (`Minutes Hours Day-of-month Month Day-of-week`) or be one of nonstandard predefined expressions (e.g. `@hourly`). For details about the format, see [documentation](/docs/compute/concepts/snapshot-schedule#cron) 


### SnapshotSpec {#SnapshotSpec6}

Field | Description
--- | ---
description | **string**<br>Description of the created snapshot. 
labels | **map<string,string>**<br>Snapshot labels as `key:value` pairs. 


## ListOperations {#ListOperations}

Lists operations for the specified snapshot schedule.

**rpc ListOperations ([ListSnapshotScheduleOperationsRequest](#ListSnapshotScheduleOperationsRequest)) returns ([ListSnapshotScheduleOperationsResponse](#ListSnapshotScheduleOperationsResponse))**

### ListSnapshotScheduleOperationsRequest {#ListSnapshotScheduleOperationsRequest}

Field | Description
--- | ---
snapshot_schedule_id | **string**<br>ID of the snapshot schedule to list operations for. <br>To get a snapshot schedule ID, make a [SnapshotScheduleService.List](#List) request. 
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListSnapshotScheduleOperationsResponse.next_page_token](#ListSnapshotScheduleOperationsResponse) that can be used to get the next page of results in subsequent list requests. <br>Default value: 100. 
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListSnapshotScheduleOperationsResponse.next_page_token](#ListSnapshotScheduleOperationsResponse) returned by a previous list request. 


### ListSnapshotScheduleOperationsResponse {#ListSnapshotScheduleOperationsResponse}

Field | Description
--- | ---
operations[] | **[operation.Operation](#Operation6)**<br>List of operations for the specified snapshot schedule. 
next_page_token | **string**<br>Token for getting the next page of the list. If the number of results is greater than the specified [ListSnapshotScheduleOperationsRequest.page_size](#ListSnapshotScheduleOperationsRequest), use `next_page_token` as the value for the [ListSnapshotScheduleOperationsRequest.page_token](#ListSnapshotScheduleOperationsRequest) parameter in the next list request. <br>Each subsequent page will have its own `next_page_token` to continue paging through the results. 


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

Retrieves the list of snapshots created by the specified snapshot schedule.

**rpc ListSnapshots ([ListSnapshotScheduleSnapshotsRequest](#ListSnapshotScheduleSnapshotsRequest)) returns ([ListSnapshotScheduleSnapshotsResponse](#ListSnapshotScheduleSnapshotsResponse))**

### ListSnapshotScheduleSnapshotsRequest {#ListSnapshotScheduleSnapshotsRequest}

Field | Description
--- | ---
snapshot_schedule_id | **string**<br>ID of the snapshot schedule to list created snapshots for. <br>To get a snapshot schedule ID, make a [SnapshotScheduleService.List](#List) request. 
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListSnapshotScheduleOperationsResponse.next_page_token](#ListSnapshotScheduleOperationsResponse) that can be used to get the next page of results in subsequent list requests. <br>Default value: 100. 
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListSnapshotScheduleOperationsResponse.next_page_token](#ListSnapshotScheduleOperationsResponse) returned by a previous list request. 


### ListSnapshotScheduleSnapshotsResponse {#ListSnapshotScheduleSnapshotsResponse}

Field | Description
--- | ---
snapshots[] | **[Snapshot](#Snapshot)**<br>List of snapshots created by the specified snapshot schedule. 
next_page_token | **string**<br>Token for getting the next page of the list. If the number of results is greater than the specified [ListSnapshotScheduleSnapshotsRequest.page_size](#ListSnapshotScheduleSnapshotsRequest), use `next_page_token` as the value for the [ListSnapshotScheduleSnapshotsRequest.page_token](#ListSnapshotScheduleSnapshotsRequest) parameter in the next list request. <br>Each subsequent page will have its own `next_page_token` to continue paging through the results. 


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

Retrieves the list of disks attached to the specified snapshot schedule.

**rpc ListDisks ([ListSnapshotScheduleDisksRequest](#ListSnapshotScheduleDisksRequest)) returns ([ListSnapshotScheduleDisksResponse](#ListSnapshotScheduleDisksResponse))**

### ListSnapshotScheduleDisksRequest {#ListSnapshotScheduleDisksRequest}

Field | Description
--- | ---
snapshot_schedule_id | **string**<br>ID of the snapshot schedule to list attached disks for. <br>To get a snapshot schedule ID, make a [SnapshotScheduleService.List](#List) request. 
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListSnapshotScheduleDisksResponse.next_page_token](#ListSnapshotScheduleDisksResponse) that can be used to get the next page of results in subsequent list requests. <br>Default value: 100. 
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListSnapshotScheduleDisksResponse.next_page_token](#ListSnapshotScheduleDisksResponse) returned by a previous list request. 


### ListSnapshotScheduleDisksResponse {#ListSnapshotScheduleDisksResponse}

Field | Description
--- | ---
disks[] | **[Disk](#Disk)**<br>List of disks attached to the specified snapshot schedule. 
next_page_token | **string**<br>Token for getting the next page of the list. If the number of results is greater than the specified [ListSnapshotScheduleDisksRequest.page_size](#ListSnapshotScheduleDisksRequest), use `next_page_token` as the value for the [ListSnapshotScheduleDisksRequest.page_token](#ListSnapshotScheduleDisksRequest) parameter in the next list request. <br>Each subsequent page will have its own `next_page_token` to continue paging through the results. 


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
placement_group_partition | **int64**<br> 


## ListAccessBindings {#ListAccessBindings}

Lists access bindings for the snapshot schedule.

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

Sets access bindings for the snapshot schedule.

**rpc SetAccessBindings ([SetAccessBindingsRequest](#SetAccessBindingsRequest)) returns ([operation.Operation](#Operation7))**

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


### Operation {#Operation7}

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

Updates access bindings for the snapshot schedule.

**rpc UpdateAccessBindings ([UpdateAccessBindingsRequest](#UpdateAccessBindingsRequest)) returns ([operation.Operation](#Operation8))**

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


### Operation {#Operation8}

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


