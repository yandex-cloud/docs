---
editable: false
sourcePath: en/_api-ref-grpc/backup/backup/backup/api-ref/grpc/policy_service.md
---

# Cloud Backup API, gRPC: PolicyService

A set of methods for managing [policies](/docs/backup/concepts/policy).

| Call | Description |
| --- | --- |
| [List](#List) | List [policies](/docs/backup/concepts/policy) of specified folder. |
| [Create](#Create) | Create a new policy. |
| [Get](#Get) | Get specific policy. |
| [Update](#Update) | Update specific policy. |
| [Delete](#Delete) | Delete specific policy. |
| [Apply](#Apply) | Apply policy to [Compute Cloud instance](/docs/backup/concepts/vm-connection#os). |
| [ListApplications](#ListApplications) | List applied policies using filters. |
| [Execute](#Execute) | Run policy on specific Compute Cloud instance. |
| [Revoke](#Revoke) | Revoke policy from Compute Cloud instance. |

## Calls PolicyService {#calls}

## List {#List}

List [policies](/docs/backup/concepts/policy) of specified folder.

**rpc List ([ListPoliciesRequest](#ListPoliciesRequest)) returns ([ListPoliciesResponse](#ListPoliciesResponse))**

### ListPoliciesRequest {#ListPoliciesRequest}

Field | Description
--- | ---
folder_id | **string**<br>Folder ID. Either Folder ID or Compute Cloud instance ID should be set. The maximum string length in characters is 50.
compute_instance_id | **string**<br>Compute Cloud instance ID. Either Folder ID or Compute Cloud instance ID should be set. 


### ListPoliciesResponse {#ListPoliciesResponse}

Field | Description
--- | ---
policies[] | **[Policy](#Policy)**<br> 


### Policy {#Policy}

Field | Description
--- | ---
id | **string**<br>Required. Policy ID. The maximum string length in characters is 50.
name | **string**<br>Required. Policy name. The maximum string length in characters is 50.
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
enabled | **bool**<br>If this field is true, it means that the policy is enabled. 
settings | **[PolicySettings](#PolicySettings)**<br>Set of policy settings 
folder_id | **string**<br>ID of the folder that the policy belongs to. 


### PolicySettings {#PolicySettings}

Field | Description
--- | ---
compression | enum **Compression**<br>Required. Archive compression level. 
format | enum **Format**<br>Required. Format of the Acronis backup archive. <ul><li>`VERSION_11`: A legacy backup format used in older versions. It's not recommended to use.</li><li>`VERSION_12`: A new format recommended in most cases for fast backup and recovery.</li><li>`AUTO`: Automatic version selection. Will be used version 12 unless the protection plan (policy) appends backups to the ones created by earlier product versions.</li></ul>
multi_volume_snapshotting_enabled | **bool**<br>If true, snapshots of multiple volumes will be taken simultaneously. 
preserve_file_security_settings | **bool**<br>If true, the file security settings will be preserved. 
reattempts | **[RetriesConfiguration](#RetriesConfiguration)**<br>Required. Configuration of retries on recoverable errors during the backup operations like reconnection to destination. No attempts to fix recoverable errors will be made if retry configuration is not set. 
silent_mode_enabled | **bool**<br>If true, a user interaction will be avoided when possible. Equals to false if value is not specified. 
splitting | **[Splitting](#Splitting)**<br>Required. Determines the size to split backups on. Splitting is not performed if value is not specified. 
vm_snapshot_reattempts | **[RetriesConfiguration](#RetriesConfiguration)**<br>Required. Configuration of retries on errors during the creation of the virtual machine snapshot. No attempts to fix recoverable errors will be made if retry configuration is not set. 
vss | **[VolumeShadowCopyServiceSettings](#VolumeShadowCopyServiceSettings)**<br>Required. Settings for the Volume Shadow Copy Service (VSS) provider. If not set, no VSS provider is used. 
archive | **[ArchiveProperties](#ArchiveProperties)**<br>The archive properties. 
performance_window | **[PerformanceWindow](#PerformanceWindow)**<br>Required. Time windows for performance limitations of backup and storage maintenance operations. 
retention | **[Retention](#Retention)**<br>Required. Configuration of backup retention rules. 
scheduling | **[Scheduling](#Scheduling)**<br>Required. Configuration of the backup schedule. 
cbt | enum **ChangedBlockTracking**<br>Required. A configuration of Changed Block Tracking (CBT). 
fast_backup_enabled | **bool**<br>If true, determines whether a file has changed by the file size and timestamp. Otherwise, the entire file contents are compared to those stored in the backup. 
quiesce_snapshotting_enabled | **bool**<br>If true, a quiesced snapshot of the virtual machine will be taken. 


### Interval {#Interval}

Field | Description
--- | ---
type | enum **Type**<br>Required. A type of the interval. 
count | **int64**<br>The amount of value specified in `Interval.Type`. Value must be greater than 0.


### RetriesConfiguration {#RetriesConfiguration}

Field | Description
--- | ---
enabled | **bool**<br>If true, enables retry on errors. 
interval | **[Interval](#Interval)**<br>Required. An interval between retry attempts. 
max_attempts | **int64**<br>Max number of retry attempts. Operation will be considered as failed when max number of retry attempts is reached. Value must be greater than 0.


### Splitting {#Splitting}

Field | Description
--- | ---
size | **int64**<br>The size of split backup file in bytes. 


### VolumeShadowCopyServiceSettings {#VolumeShadowCopyServiceSettings}

Field | Description
--- | ---
enabled | **bool**<br>If true, the VSS will be enabled. 
provider | enum **VSSProvider**<br>Required. A type of VSS provider to use in backup. 


### ArchiveProperties {#ArchiveProperties}

Field | Description
--- | ---
name | **string**<br>The name of the generated archive. The name may use the following variables: `[Machine Name]`, `[Plan ID]`, `[Plan Name]`, `[Unique ID]`, `[Virtualization Server Type]`. Default value: `[Machine Name]-[Plan ID]-[Unique ID]A`. 


### PerformanceWindow {#PerformanceWindow}

Field | Description
--- | ---
enabled | **bool**<br>If true, the time windows will be enabled. 


### TimeOfDay {#TimeOfDay}

Field | Description
--- | ---
hour | **int64**<br>Hours. 
minute | **int64**<br>Minutes. 


### Retention {#Retention}

Field | Description
--- | ---
rules[] | **[RetentionRule](#RetentionRule)**<br>A list of retention rules. 
before_backup | **bool**<br>If true, retention rules will be applied before backup is finished. 


### RetentionRule {#RetentionRule}

Field | Description
--- | ---
backup_set[] | enum **RepeatePeriod**<br>A list of backup sets where rules are effective. 
condition | **oneof:** `max_age` or `max_count`<br>
&nbsp;&nbsp;max_age | **[Interval](#Interval)**<br> 
&nbsp;&nbsp;max_count | **int64**<br> 


### Scheduling {#Scheduling}

Field | Description
--- | ---
backup_sets[] | **[BackupSet](#BackupSet)**<br>A list of schedules with backup sets that compose the whole scheme. The number of elements must be greater than 0.
enabled | **bool**<br>If true, the backup schedule will be enabled. 
max_parallel_backups | **int64**<br>Max number of backup processes allowed to run in parallel. Unlimited if not set. 
rand_max_delay | **[Interval](#Interval)**<br>Required. Configuration of the random delay between the execution of parallel tasks. 
scheme | enum **Scheme**<br>Required. A backup scheme. Available values: `simple`, `always_full`, `always_incremental`, `weekly_incremental`, `weekly_full_daily_incremental`, `custom`, `cdp`. <ul><li>`CUSTOM`: Custom will require to specify schedules for full, differential and incremental backups additionally.</li></ul>
weekly_backup_day | enum **Day**<br>Required. A day of week to start weekly backups. 


### BackupSet {#BackupSet}

Field | Description
--- | ---
setting | **oneof:** `time` or `since_last_exec_time`<br>
&nbsp;&nbsp;time | **[Time](#Time)**<br> 
&nbsp;&nbsp;since_last_exec_time | **[SinceLastExecTime](#SinceLastExecTime)**<br> 
type | enum **Type**<br>BackupSet type -- one of incr, full, differential or auto. if custom scheme is used the BackupSet type should be specified 


### Time {#Time}

Field | Description
--- | ---
weekdays[] | enum **Day**<br>Days in a week to perform a backup. 
repeat_at[] | **[TimeOfDay](#TimeOfDay)**<br>Time to repeat the backup. 
repeat_every | **[Interval](#Interval)**<br>Frequency of backup repetition. 
time_from | **[TimeOfDay](#TimeOfDay)**<br>The start time of the backup time interval. 
time_to | **[TimeOfDay](#TimeOfDay)**<br>The end time of the backup time interval. 
monthdays[] | **int64**<br>Days in a month to perform a backup. Allowed values are from 1 to 31. 
include_last_day_of_month | **bool**<br>If set to true, last day of month will activate the policy. 
months[] | **int64**<br>Set of values. Allowed values form 1 to 12. 
type | enum **RepeatePeriod**<br>Required. Possible types: `REPEATE_PERIOD_UNSPECIFIED`, `HOURLY`, `DAILY`, `WEEKLY`, `MONTHLY`. 


### SinceLastExecTime {#SinceLastExecTime}

Field | Description
--- | ---
delay | **[Interval](#Interval)**<br>Required. The interval between backups. 


## Create {#Create}

Create a new policy. <br>For detailed information, please see [Creating a backup policy](/docs/backup/operations/policy-vm/create).

**rpc Create ([CreatePolicyRequest](#CreatePolicyRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreatePolicyMetadata](#CreatePolicyMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Policy](#Policy1)<br>

### CreatePolicyRequest {#CreatePolicyRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. Folder ID. The maximum string length in characters is 50.
name | **string**<br>Required. Policy name. The maximum string length in characters is 50.
settings | **[PolicySettings](#PolicySettings1)**<br>Required.  


### PolicySettings {#PolicySettings1}

Field | Description
--- | ---
compression | enum **Compression**<br>Required. Archive compression level. 
format | enum **Format**<br>Required. Format of the Acronis backup archive. <ul><li>`VERSION_11`: A legacy backup format used in older versions. It's not recommended to use.</li><li>`VERSION_12`: A new format recommended in most cases for fast backup and recovery.</li><li>`AUTO`: Automatic version selection. Will be used version 12 unless the protection plan (policy) appends backups to the ones created by earlier product versions.</li></ul>
multi_volume_snapshotting_enabled | **bool**<br>If true, snapshots of multiple volumes will be taken simultaneously. 
preserve_file_security_settings | **bool**<br>If true, the file security settings will be preserved. 
reattempts | **[RetriesConfiguration](#RetriesConfiguration1)**<br>Required. Configuration of retries on recoverable errors during the backup operations like reconnection to destination. No attempts to fix recoverable errors will be made if retry configuration is not set. 
silent_mode_enabled | **bool**<br>If true, a user interaction will be avoided when possible. Equals to false if value is not specified. 
splitting | **[Splitting](#Splitting1)**<br>Required. Determines the size to split backups on. Splitting is not performed if value is not specified. 
vm_snapshot_reattempts | **[RetriesConfiguration](#RetriesConfiguration1)**<br>Required. Configuration of retries on errors during the creation of the virtual machine snapshot. No attempts to fix recoverable errors will be made if retry configuration is not set. 
vss | **[VolumeShadowCopyServiceSettings](#VolumeShadowCopyServiceSettings1)**<br>Required. Settings for the Volume Shadow Copy Service (VSS) provider. If not set, no VSS provider is used. 
archive | **[ArchiveProperties](#ArchiveProperties1)**<br>The archive properties. 
performance_window | **[PerformanceWindow](#PerformanceWindow1)**<br>Required. Time windows for performance limitations of backup and storage maintenance operations. 
retention | **[Retention](#Retention1)**<br>Required. Configuration of backup retention rules. 
scheduling | **[Scheduling](#Scheduling1)**<br>Required. Configuration of the backup schedule. 
cbt | enum **ChangedBlockTracking**<br>Required. A configuration of Changed Block Tracking (CBT). 
fast_backup_enabled | **bool**<br>If true, determines whether a file has changed by the file size and timestamp. Otherwise, the entire file contents are compared to those stored in the backup. 
quiesce_snapshotting_enabled | **bool**<br>If true, a quiesced snapshot of the virtual machine will be taken. 


### Interval {#Interval1}

Field | Description
--- | ---
type | enum **Type**<br>Required. A type of the interval. 
count | **int64**<br>The amount of value specified in `Interval.Type`. Value must be greater than 0.


### RetriesConfiguration {#RetriesConfiguration1}

Field | Description
--- | ---
enabled | **bool**<br>If true, enables retry on errors. 
interval | **[Interval](#Interval1)**<br>Required. An interval between retry attempts. 
max_attempts | **int64**<br>Max number of retry attempts. Operation will be considered as failed when max number of retry attempts is reached. Value must be greater than 0.


### Splitting {#Splitting1}

Field | Description
--- | ---
size | **int64**<br>The size of split backup file in bytes. 


### VolumeShadowCopyServiceSettings {#VolumeShadowCopyServiceSettings1}

Field | Description
--- | ---
enabled | **bool**<br>If true, the VSS will be enabled. 
provider | enum **VSSProvider**<br>Required. A type of VSS provider to use in backup. 


### ArchiveProperties {#ArchiveProperties1}

Field | Description
--- | ---
name | **string**<br>The name of the generated archive. The name may use the following variables: `[Machine Name]`, `[Plan ID]`, `[Plan Name]`, `[Unique ID]`, `[Virtualization Server Type]`. Default value: `[Machine Name]-[Plan ID]-[Unique ID]A`. 


### PerformanceWindow {#PerformanceWindow1}

Field | Description
--- | ---
enabled | **bool**<br>If true, the time windows will be enabled. 


### TimeOfDay {#TimeOfDay1}

Field | Description
--- | ---
hour | **int64**<br>Hours. 
minute | **int64**<br>Minutes. 


### Retention {#Retention1}

Field | Description
--- | ---
rules[] | **[RetentionRule](#RetentionRule1)**<br>A list of retention rules. 
before_backup | **bool**<br>If true, retention rules will be applied before backup is finished. 


### RetentionRule {#RetentionRule1}

Field | Description
--- | ---
backup_set[] | enum **RepeatePeriod**<br>A list of backup sets where rules are effective. 
condition | **oneof:** `max_age` or `max_count`<br>
&nbsp;&nbsp;max_age | **[Interval](#Interval1)**<br> 
&nbsp;&nbsp;max_count | **int64**<br> 


### Scheduling {#Scheduling1}

Field | Description
--- | ---
backup_sets[] | **[BackupSet](#BackupSet1)**<br>A list of schedules with backup sets that compose the whole scheme. The number of elements must be greater than 0.
enabled | **bool**<br>If true, the backup schedule will be enabled. 
max_parallel_backups | **int64**<br>Max number of backup processes allowed to run in parallel. Unlimited if not set. 
rand_max_delay | **[Interval](#Interval1)**<br>Required. Configuration of the random delay between the execution of parallel tasks. 
scheme | enum **Scheme**<br>Required. A backup scheme. Available values: `simple`, `always_full`, `always_incremental`, `weekly_incremental`, `weekly_full_daily_incremental`, `custom`, `cdp`. <ul><li>`CUSTOM`: Custom will require to specify schedules for full, differential and incremental backups additionally.</li></ul>
weekly_backup_day | enum **Day**<br>Required. A day of week to start weekly backups. 


### BackupSet {#BackupSet1}

Field | Description
--- | ---
setting | **oneof:** `time` or `since_last_exec_time`<br>
&nbsp;&nbsp;time | **[Time](#Time1)**<br> 
&nbsp;&nbsp;since_last_exec_time | **[SinceLastExecTime](#SinceLastExecTime1)**<br> 
type | enum **Type**<br>BackupSet type -- one of incr, full, differential or auto. if custom scheme is used the BackupSet type should be specified 


### Time {#Time1}

Field | Description
--- | ---
weekdays[] | enum **Day**<br>Days in a week to perform a backup. 
repeat_at[] | **[TimeOfDay](#TimeOfDay1)**<br>Time to repeat the backup. 
repeat_every | **[Interval](#Interval1)**<br>Frequency of backup repetition. 
time_from | **[TimeOfDay](#TimeOfDay1)**<br>The start time of the backup time interval. 
time_to | **[TimeOfDay](#TimeOfDay1)**<br>The end time of the backup time interval. 
monthdays[] | **int64**<br>Days in a month to perform a backup. Allowed values are from 1 to 31. 
include_last_day_of_month | **bool**<br>If set to true, last day of month will activate the policy. 
months[] | **int64**<br>Set of values. Allowed values form 1 to 12. 
type | enum **RepeatePeriod**<br>Required. Possible types: `REPEATE_PERIOD_UNSPECIFIED`, `HOURLY`, `DAILY`, `WEEKLY`, `MONTHLY`. 


### SinceLastExecTime {#SinceLastExecTime1}

Field | Description
--- | ---
delay | **[Interval](#Interval1)**<br>Required. The interval between backups. 


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreatePolicyMetadata](#CreatePolicyMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Policy](#Policy1)>**<br>if operation finished successfully. 


### CreatePolicyMetadata {#CreatePolicyMetadata}

Field | Description
--- | ---
policy_id | **string**<br>Required. Policy ID. The maximum string length in characters is 50.


### Policy {#Policy1}

Field | Description
--- | ---
id | **string**<br>Required. Policy ID. The maximum string length in characters is 50.
name | **string**<br>Required. Policy name. The maximum string length in characters is 50.
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
enabled | **bool**<br>If this field is true, it means that the policy is enabled. 
settings | **[PolicySettings](#PolicySettings2)**<br>Set of policy settings 
folder_id | **string**<br>ID of the folder that the policy belongs to. 


## Get {#Get}

Get specific policy.

**rpc Get ([GetPolicyRequest](#GetPolicyRequest)) returns ([Policy](#Policy2))**

### GetPolicyRequest {#GetPolicyRequest}

Field | Description
--- | ---
policy_id | **string**<br>Required. Policy ID. The maximum string length in characters is 50.


### Policy {#Policy2}

Field | Description
--- | ---
id | **string**<br>Required. Policy ID. The maximum string length in characters is 50.
name | **string**<br>Required. Policy name. The maximum string length in characters is 50.
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
enabled | **bool**<br>If this field is true, it means that the policy is enabled. 
settings | **[PolicySettings](#PolicySettings2)**<br>Set of policy settings 
folder_id | **string**<br>ID of the folder that the policy belongs to. 


### PolicySettings {#PolicySettings2}

Field | Description
--- | ---
compression | enum **Compression**<br>Required. Archive compression level. 
format | enum **Format**<br>Required. Format of the Acronis backup archive. <ul><li>`VERSION_11`: A legacy backup format used in older versions. It's not recommended to use.</li><li>`VERSION_12`: A new format recommended in most cases for fast backup and recovery.</li><li>`AUTO`: Automatic version selection. Will be used version 12 unless the protection plan (policy) appends backups to the ones created by earlier product versions.</li></ul>
multi_volume_snapshotting_enabled | **bool**<br>If true, snapshots of multiple volumes will be taken simultaneously. 
preserve_file_security_settings | **bool**<br>If true, the file security settings will be preserved. 
reattempts | **[RetriesConfiguration](#RetriesConfiguration2)**<br>Required. Configuration of retries on recoverable errors during the backup operations like reconnection to destination. No attempts to fix recoverable errors will be made if retry configuration is not set. 
silent_mode_enabled | **bool**<br>If true, a user interaction will be avoided when possible. Equals to false if value is not specified. 
splitting | **[Splitting](#Splitting2)**<br>Required. Determines the size to split backups on. Splitting is not performed if value is not specified. 
vm_snapshot_reattempts | **[RetriesConfiguration](#RetriesConfiguration2)**<br>Required. Configuration of retries on errors during the creation of the virtual machine snapshot. No attempts to fix recoverable errors will be made if retry configuration is not set. 
vss | **[VolumeShadowCopyServiceSettings](#VolumeShadowCopyServiceSettings2)**<br>Required. Settings for the Volume Shadow Copy Service (VSS) provider. If not set, no VSS provider is used. 
archive | **[ArchiveProperties](#ArchiveProperties2)**<br>The archive properties. 
performance_window | **[PerformanceWindow](#PerformanceWindow2)**<br>Required. Time windows for performance limitations of backup and storage maintenance operations. 
retention | **[Retention](#Retention2)**<br>Required. Configuration of backup retention rules. 
scheduling | **[Scheduling](#Scheduling2)**<br>Required. Configuration of the backup schedule. 
cbt | enum **ChangedBlockTracking**<br>Required. A configuration of Changed Block Tracking (CBT). 
fast_backup_enabled | **bool**<br>If true, determines whether a file has changed by the file size and timestamp. Otherwise, the entire file contents are compared to those stored in the backup. 
quiesce_snapshotting_enabled | **bool**<br>If true, a quiesced snapshot of the virtual machine will be taken. 


### Interval {#Interval2}

Field | Description
--- | ---
type | enum **Type**<br>Required. A type of the interval. 
count | **int64**<br>The amount of value specified in `Interval.Type`. Value must be greater than 0.


### RetriesConfiguration {#RetriesConfiguration2}

Field | Description
--- | ---
enabled | **bool**<br>If true, enables retry on errors. 
interval | **[Interval](#Interval2)**<br>Required. An interval between retry attempts. 
max_attempts | **int64**<br>Max number of retry attempts. Operation will be considered as failed when max number of retry attempts is reached. Value must be greater than 0.


### Splitting {#Splitting2}

Field | Description
--- | ---
size | **int64**<br>The size of split backup file in bytes. 


### VolumeShadowCopyServiceSettings {#VolumeShadowCopyServiceSettings2}

Field | Description
--- | ---
enabled | **bool**<br>If true, the VSS will be enabled. 
provider | enum **VSSProvider**<br>Required. A type of VSS provider to use in backup. 


### ArchiveProperties {#ArchiveProperties2}

Field | Description
--- | ---
name | **string**<br>The name of the generated archive. The name may use the following variables: `[Machine Name]`, `[Plan ID]`, `[Plan Name]`, `[Unique ID]`, `[Virtualization Server Type]`. Default value: `[Machine Name]-[Plan ID]-[Unique ID]A`. 


### PerformanceWindow {#PerformanceWindow2}

Field | Description
--- | ---
enabled | **bool**<br>If true, the time windows will be enabled. 


### TimeOfDay {#TimeOfDay2}

Field | Description
--- | ---
hour | **int64**<br>Hours. 
minute | **int64**<br>Minutes. 


### Retention {#Retention2}

Field | Description
--- | ---
rules[] | **[RetentionRule](#RetentionRule2)**<br>A list of retention rules. 
before_backup | **bool**<br>If true, retention rules will be applied before backup is finished. 


### RetentionRule {#RetentionRule2}

Field | Description
--- | ---
backup_set[] | enum **RepeatePeriod**<br>A list of backup sets where rules are effective. 
condition | **oneof:** `max_age` or `max_count`<br>
&nbsp;&nbsp;max_age | **[Interval](#Interval2)**<br> 
&nbsp;&nbsp;max_count | **int64**<br> 


### Scheduling {#Scheduling2}

Field | Description
--- | ---
backup_sets[] | **[BackupSet](#BackupSet2)**<br>A list of schedules with backup sets that compose the whole scheme. The number of elements must be greater than 0.
enabled | **bool**<br>If true, the backup schedule will be enabled. 
max_parallel_backups | **int64**<br>Max number of backup processes allowed to run in parallel. Unlimited if not set. 
rand_max_delay | **[Interval](#Interval2)**<br>Required. Configuration of the random delay between the execution of parallel tasks. 
scheme | enum **Scheme**<br>Required. A backup scheme. Available values: `simple`, `always_full`, `always_incremental`, `weekly_incremental`, `weekly_full_daily_incremental`, `custom`, `cdp`. <ul><li>`CUSTOM`: Custom will require to specify schedules for full, differential and incremental backups additionally.</li></ul>
weekly_backup_day | enum **Day**<br>Required. A day of week to start weekly backups. 


### BackupSet {#BackupSet2}

Field | Description
--- | ---
setting | **oneof:** `time` or `since_last_exec_time`<br>
&nbsp;&nbsp;time | **[Time](#Time2)**<br> 
&nbsp;&nbsp;since_last_exec_time | **[SinceLastExecTime](#SinceLastExecTime2)**<br> 
type | enum **Type**<br>BackupSet type -- one of incr, full, differential or auto. if custom scheme is used the BackupSet type should be specified 


### Time {#Time2}

Field | Description
--- | ---
weekdays[] | enum **Day**<br>Days in a week to perform a backup. 
repeat_at[] | **[TimeOfDay](#TimeOfDay2)**<br>Time to repeat the backup. 
repeat_every | **[Interval](#Interval2)**<br>Frequency of backup repetition. 
time_from | **[TimeOfDay](#TimeOfDay2)**<br>The start time of the backup time interval. 
time_to | **[TimeOfDay](#TimeOfDay2)**<br>The end time of the backup time interval. 
monthdays[] | **int64**<br>Days in a month to perform a backup. Allowed values are from 1 to 31. 
include_last_day_of_month | **bool**<br>If set to true, last day of month will activate the policy. 
months[] | **int64**<br>Set of values. Allowed values form 1 to 12. 
type | enum **RepeatePeriod**<br>Required. Possible types: `REPEATE_PERIOD_UNSPECIFIED`, `HOURLY`, `DAILY`, `WEEKLY`, `MONTHLY`. 


### SinceLastExecTime {#SinceLastExecTime2}

Field | Description
--- | ---
delay | **[Interval](#Interval2)**<br>Required. The interval between backups. 


## Update {#Update}

Update specific policy.

**rpc Update ([UpdatePolicyRequest](#UpdatePolicyRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdatePolicyMetadata](#UpdatePolicyMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Policy](#Policy3)<br>

### UpdatePolicyRequest {#UpdatePolicyRequest}

Field | Description
--- | ---
policy_id | **string**<br>Required. Policy ID. The maximum string length in characters is 50.
settings | **[PolicySettings](#PolicySettings3)**<br>Required.  


### PolicySettings {#PolicySettings3}

Field | Description
--- | ---
compression | enum **Compression**<br>Required. Archive compression level. 
format | enum **Format**<br>Required. Format of the Acronis backup archive. <ul><li>`VERSION_11`: A legacy backup format used in older versions. It's not recommended to use.</li><li>`VERSION_12`: A new format recommended in most cases for fast backup and recovery.</li><li>`AUTO`: Automatic version selection. Will be used version 12 unless the protection plan (policy) appends backups to the ones created by earlier product versions.</li></ul>
multi_volume_snapshotting_enabled | **bool**<br>If true, snapshots of multiple volumes will be taken simultaneously. 
preserve_file_security_settings | **bool**<br>If true, the file security settings will be preserved. 
reattempts | **[RetriesConfiguration](#RetriesConfiguration3)**<br>Required. Configuration of retries on recoverable errors during the backup operations like reconnection to destination. No attempts to fix recoverable errors will be made if retry configuration is not set. 
silent_mode_enabled | **bool**<br>If true, a user interaction will be avoided when possible. Equals to false if value is not specified. 
splitting | **[Splitting](#Splitting3)**<br>Required. Determines the size to split backups on. Splitting is not performed if value is not specified. 
vm_snapshot_reattempts | **[RetriesConfiguration](#RetriesConfiguration3)**<br>Required. Configuration of retries on errors during the creation of the virtual machine snapshot. No attempts to fix recoverable errors will be made if retry configuration is not set. 
vss | **[VolumeShadowCopyServiceSettings](#VolumeShadowCopyServiceSettings3)**<br>Required. Settings for the Volume Shadow Copy Service (VSS) provider. If not set, no VSS provider is used. 
archive | **[ArchiveProperties](#ArchiveProperties3)**<br>The archive properties. 
performance_window | **[PerformanceWindow](#PerformanceWindow3)**<br>Required. Time windows for performance limitations of backup and storage maintenance operations. 
retention | **[Retention](#Retention3)**<br>Required. Configuration of backup retention rules. 
scheduling | **[Scheduling](#Scheduling3)**<br>Required. Configuration of the backup schedule. 
cbt | enum **ChangedBlockTracking**<br>Required. A configuration of Changed Block Tracking (CBT). 
fast_backup_enabled | **bool**<br>If true, determines whether a file has changed by the file size and timestamp. Otherwise, the entire file contents are compared to those stored in the backup. 
quiesce_snapshotting_enabled | **bool**<br>If true, a quiesced snapshot of the virtual machine will be taken. 


### Interval {#Interval3}

Field | Description
--- | ---
type | enum **Type**<br>Required. A type of the interval. 
count | **int64**<br>The amount of value specified in `Interval.Type`. Value must be greater than 0.


### RetriesConfiguration {#RetriesConfiguration3}

Field | Description
--- | ---
enabled | **bool**<br>If true, enables retry on errors. 
interval | **[Interval](#Interval3)**<br>Required. An interval between retry attempts. 
max_attempts | **int64**<br>Max number of retry attempts. Operation will be considered as failed when max number of retry attempts is reached. Value must be greater than 0.


### Splitting {#Splitting3}

Field | Description
--- | ---
size | **int64**<br>The size of split backup file in bytes. 


### VolumeShadowCopyServiceSettings {#VolumeShadowCopyServiceSettings3}

Field | Description
--- | ---
enabled | **bool**<br>If true, the VSS will be enabled. 
provider | enum **VSSProvider**<br>Required. A type of VSS provider to use in backup. 


### ArchiveProperties {#ArchiveProperties3}

Field | Description
--- | ---
name | **string**<br>The name of the generated archive. The name may use the following variables: `[Machine Name]`, `[Plan ID]`, `[Plan Name]`, `[Unique ID]`, `[Virtualization Server Type]`. Default value: `[Machine Name]-[Plan ID]-[Unique ID]A`. 


### PerformanceWindow {#PerformanceWindow3}

Field | Description
--- | ---
enabled | **bool**<br>If true, the time windows will be enabled. 


### TimeOfDay {#TimeOfDay3}

Field | Description
--- | ---
hour | **int64**<br>Hours. 
minute | **int64**<br>Minutes. 


### Retention {#Retention3}

Field | Description
--- | ---
rules[] | **[RetentionRule](#RetentionRule3)**<br>A list of retention rules. 
before_backup | **bool**<br>If true, retention rules will be applied before backup is finished. 


### RetentionRule {#RetentionRule3}

Field | Description
--- | ---
backup_set[] | enum **RepeatePeriod**<br>A list of backup sets where rules are effective. 
condition | **oneof:** `max_age` or `max_count`<br>
&nbsp;&nbsp;max_age | **[Interval](#Interval3)**<br> 
&nbsp;&nbsp;max_count | **int64**<br> 


### Scheduling {#Scheduling3}

Field | Description
--- | ---
backup_sets[] | **[BackupSet](#BackupSet3)**<br>A list of schedules with backup sets that compose the whole scheme. The number of elements must be greater than 0.
enabled | **bool**<br>If true, the backup schedule will be enabled. 
max_parallel_backups | **int64**<br>Max number of backup processes allowed to run in parallel. Unlimited if not set. 
rand_max_delay | **[Interval](#Interval3)**<br>Required. Configuration of the random delay between the execution of parallel tasks. 
scheme | enum **Scheme**<br>Required. A backup scheme. Available values: `simple`, `always_full`, `always_incremental`, `weekly_incremental`, `weekly_full_daily_incremental`, `custom`, `cdp`. <ul><li>`CUSTOM`: Custom will require to specify schedules for full, differential and incremental backups additionally.</li></ul>
weekly_backup_day | enum **Day**<br>Required. A day of week to start weekly backups. 


### BackupSet {#BackupSet3}

Field | Description
--- | ---
setting | **oneof:** `time` or `since_last_exec_time`<br>
&nbsp;&nbsp;time | **[Time](#Time3)**<br> 
&nbsp;&nbsp;since_last_exec_time | **[SinceLastExecTime](#SinceLastExecTime3)**<br> 
type | enum **Type**<br>BackupSet type -- one of incr, full, differential or auto. if custom scheme is used the BackupSet type should be specified 


### Time {#Time3}

Field | Description
--- | ---
weekdays[] | enum **Day**<br>Days in a week to perform a backup. 
repeat_at[] | **[TimeOfDay](#TimeOfDay3)**<br>Time to repeat the backup. 
repeat_every | **[Interval](#Interval3)**<br>Frequency of backup repetition. 
time_from | **[TimeOfDay](#TimeOfDay3)**<br>The start time of the backup time interval. 
time_to | **[TimeOfDay](#TimeOfDay3)**<br>The end time of the backup time interval. 
monthdays[] | **int64**<br>Days in a month to perform a backup. Allowed values are from 1 to 31. 
include_last_day_of_month | **bool**<br>If set to true, last day of month will activate the policy. 
months[] | **int64**<br>Set of values. Allowed values form 1 to 12. 
type | enum **RepeatePeriod**<br>Required. Possible types: `REPEATE_PERIOD_UNSPECIFIED`, `HOURLY`, `DAILY`, `WEEKLY`, `MONTHLY`. 


### SinceLastExecTime {#SinceLastExecTime3}

Field | Description
--- | ---
delay | **[Interval](#Interval3)**<br>Required. The interval between backups. 


### Operation {#Operation1}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdatePolicyMetadata](#UpdatePolicyMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Policy](#Policy3)>**<br>if operation finished successfully. 


### UpdatePolicyMetadata {#UpdatePolicyMetadata}

Field | Description
--- | ---
policy_id | **string**<br>Required. Policy ID. The maximum string length in characters is 50.


### Policy {#Policy3}

Field | Description
--- | ---
id | **string**<br>Required. Policy ID. The maximum string length in characters is 50.
name | **string**<br>Required. Policy name. The maximum string length in characters is 50.
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
enabled | **bool**<br>If this field is true, it means that the policy is enabled. 
settings | **[PolicySettings](#PolicySettings4)**<br>Set of policy settings 
folder_id | **string**<br>ID of the folder that the policy belongs to. 


## Delete {#Delete}

Delete specific policy.

**rpc Delete ([DeletePolicyRequest](#DeletePolicyRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeletePolicyMetadata](#DeletePolicyMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeletePolicyRequest {#DeletePolicyRequest}

Field | Description
--- | ---
policy_id | **string**<br>Required. Policy ID. The maximum string length in characters is 50.


### Operation {#Operation2}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeletePolicyMetadata](#DeletePolicyMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### DeletePolicyMetadata {#DeletePolicyMetadata}

Field | Description
--- | ---
policy_id | **string**<br>Required. Policy ID. The maximum string length in characters is 50.


## Apply {#Apply}

Apply policy to [Compute Cloud instance](/docs/backup/concepts/vm-connection#os).

**rpc Apply ([ApplyPolicyRequest](#ApplyPolicyRequest)) returns ([operation.Operation](#Operation3))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[ApplyPolicyMetadata](#ApplyPolicyMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### ApplyPolicyRequest {#ApplyPolicyRequest}

Field | Description
--- | ---
policy_id | **string**<br>Required. Policy ID. The maximum string length in characters is 50.
compute_instance_id | **string**<br>Required. Compute Cloud instance ID. The maximum string length in characters is 50.


### Operation {#Operation3}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[ApplyPolicyMetadata](#ApplyPolicyMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### ApplyPolicyMetadata {#ApplyPolicyMetadata}

Field | Description
--- | ---
policy_id | **string**<br>Policy ID. 
compute_instance_id | **string**<br>Compute Cloud instance ID. 


## ListApplications {#ListApplications}

List applied policies using filters.

**rpc ListApplications ([ListApplicationsRequest](#ListApplicationsRequest)) returns ([ListApplicationsResponse](#ListApplicationsResponse))**

### ListApplicationsRequest {#ListApplicationsRequest}

Field | Description
--- | ---
id | **oneof:** `folder_id`, `policy_id` or `compute_instance_id`<br>
&nbsp;&nbsp;folder_id | **string**<br>Folder ID. 
&nbsp;&nbsp;policy_id | **string**<br>Policy ID. 
&nbsp;&nbsp;compute_instance_id | **string**<br>Compute Cloud instance ID. 
show_processing | **bool**<br>If true, also returns applications that in the process of binding. 


### ListApplicationsResponse {#ListApplicationsResponse}

Field | Description
--- | ---
applications[] | **[PolicyApplication](#PolicyApplication)**<br> 


### PolicyApplication {#PolicyApplication}

Field | Description
--- | ---
policy_id | **string**<br>Policy ID. 
compute_instance_id | **string**<br>Compute Cloud instance ID. 
enabled | **bool**<br> 
status | enum **Status**<br> <ul><li>`OK`: Application is applied and everything is OK.</li><li>`RUNNING`: Application is currently running.</li><li>`DISABLED`: Application is disabled.</li></ul>
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
is_processing | **bool**<br>If true, then the policy is in in the process of binding to the instance. 


## Execute {#Execute}

Run policy on specific Compute Cloud instance. That will create backup according selected policy. In order to perform this action, policy should be applied to the Compute Cloud instance.

**rpc Execute ([ExecuteRequest](#ExecuteRequest)) returns ([operation.Operation](#Operation4))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[ExecuteMetadata](#ExecuteMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### ExecuteRequest {#ExecuteRequest}

Field | Description
--- | ---
policy_id | **string**<br>Required. Policy ID. The maximum string length in characters is 50.
compute_instance_id | **string**<br>Required. Compute Cloud instance ID. The maximum string length in characters is 50.


### Operation {#Operation4}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[ExecuteMetadata](#ExecuteMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### ExecuteMetadata {#ExecuteMetadata}

Field | Description
--- | ---
policy_id | **string**<br>Policy ID. 
compute_instance_id | **string**<br>Compute Cloud instance ID. 
progress_percentage | **double**<br>Progress of the backup process. 


## Revoke {#Revoke}

Revoke policy from Compute Cloud instance.

**rpc Revoke ([RevokeRequest](#RevokeRequest)) returns ([operation.Operation](#Operation5))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[RevokeMetadata](#RevokeMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### RevokeRequest {#RevokeRequest}

Field | Description
--- | ---
policy_id | **string**<br>Required. Policy ID. The maximum string length in characters is 50.
compute_instance_id | **string**<br>Required. Compute Cloud instance ID. The maximum string length in characters is 50.


### Operation {#Operation5}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[RevokeMetadata](#RevokeMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### RevokeMetadata {#RevokeMetadata}

Field | Description
--- | ---
policy_id | **string**<br>Policy ID. 
compute_instance_id | **string**<br>Compute Cloud instance ID. 


