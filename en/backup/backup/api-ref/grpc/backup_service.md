---
editable: false
sourcePath: en/_api-ref-grpc/backup/backup/backup/api-ref/grpc/backup_service.md
---

# Cloud Backup API, gRPC: BackupService

A set of methods for managing [backups](/docs/backup/concepts/backup).

| Call | Description |
| --- | --- |
| [List](#List) | List backups using filters. |
| [ListArchives](#ListArchives) | List archives that holds backups for specified folder or specified [Compute Cloud instance](/docs/backup/concepts/vm-connection#os). |
| [ListFiles](#ListFiles) | ListFiles of the backup. |
| [Get](#Get) | Get backup by its id. |
| [StartRecovery](#StartRecovery) | Start recovery process of specified backup to specific Compute Cloud instance. |
| [StartFilesRecovery](#StartFilesRecovery) | StartFilesRecovery runs recovery process of selected files to specific Compute Cloud instance. |
| [Delete](#Delete) | Delete specific backup. |

## Calls BackupService {#calls}

## List {#List}

List backups using filters.

**rpc List ([ListBackupsRequest](#ListBackupsRequest)) returns ([ListBackupsResponse](#ListBackupsResponse))**

### ListBackupsRequest {#ListBackupsRequest}

Field | Description
--- | ---
id | **oneof:** `compute_instance_id`, `archive`, `folder_id`, `instance_policy`, `resource_id` or `policy_id`<br>
&nbsp;&nbsp;compute_instance_id | **string**<br>List backups that belongs to specific Compute Cloud instance. 
&nbsp;&nbsp;archive | **ArchiveParameters**<br>List backups that belongs to specific archive of specific folder. 
&nbsp;&nbsp;folder_id | **string**<br>List backups that belongs to specific folder. 
&nbsp;&nbsp;instance_policy | **InstancePolicy**<br>List backups that belongs to specific instance and policy at the same time. 
&nbsp;&nbsp;resource_id | **string**<br>List backups by specific resource ID. 
&nbsp;&nbsp;policy_id | **string**<br>List backups by specific policy ID. 
order_by | **string**<br>By which column the listing should be ordered and in which direction, format is "createdAt desc". "createdAt desc" if omitted. 
filter | **string**<br>Filter list by various parameters. Supported parameters are: <ul><li>created_at </li></ul><br>Supported logic operators: <ul><li>AND</li></ul> 


### ArchiveParameters {#ArchiveParameters}

Field | Description
--- | ---
archive_id | **string**<br>Required. Archive ID. 
folder_id | **string**<br>Required. Folder ID. 


### InstancePolicy {#InstancePolicy}

Field | Description
--- | ---
compute_instance_id | **string**<br>Compute Cloud instance ID. 
policy_id | **string**<br>Policy ID. 


### ListBackupsResponse {#ListBackupsResponse}

Field | Description
--- | ---
backups[] | **[Backup](#Backup)**<br> 


### Backup {#Backup}

Field | Description
--- | ---
id | **string**<br>ID of the backup. 
vault_id | **string**<br>ID of the backup vault. 
archive_id | **string**<br>ID of the backup archive. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
last_seen_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
size | **int64**<br>Backup size. 
deduplicated_size | **int64**<br>Deduplicated backup size. 
backed_up_data_size | **int64**<br>Backed up data size. 
original_data_size | **int64**<br>Original data size. 
attributes | **[BackupAttributes](#BackupAttributes)**<br> 
compute_instance_id | **string**<br>Compute Cloud instance ID. 
disks[] | **[Disk](#Disk)**<br> 
type | enum **Type**<br> 
deleted | **bool**<br>If this field is true, it means that the backup was deleted. 
policy_id | **string**<br>[Policy](/docs/backup/concepts/policy) ID. 
resource_id | **string**<br>Resource ID. It identifies Compute Cloud instance in backup service. 


### BackupAttributes {#BackupAttributes}

Field | Description
--- | ---
stream_name | **string**<br>Backup stream name. 
uri | **string**<br>URI of the backup archive. 


### Disk {#Disk}

Field | Description
--- | ---
device_model | **string**<br>Device model. 
name | **string**<br>Disk name. 
size | **int64**<br>Disk size. 
volumes[] | **[Volume](#Volume)**<br> 


### Volume {#Volume}

Field | Description
--- | ---
free_space | **int64**<br>Free space in the volume. 
is_bootable | **bool**<br>If this field is true, it means that the volume is bootable. 
is_system | **bool**<br>If this field is true, it means that the volume is a system volume. 
name | **string**<br>Volume name. 
size | **int64**<br>Volume size. 
mount_strid | **string**<br>Mount string ID. 


## ListArchives {#ListArchives}

List archives that holds backups for specified folder or specified [Compute Cloud instance](/docs/backup/concepts/vm-connection#os).

**rpc ListArchives ([ListArchivesRequest](#ListArchivesRequest)) returns ([ListArchivesResponse](#ListArchivesResponse))**

### ListArchivesRequest {#ListArchivesRequest}

Field | Description
--- | ---
id | **oneof:** `folder_id` or `compute_instance_id`<br>
&nbsp;&nbsp;folder_id | **string**<br>List of archives in specified folder. 
&nbsp;&nbsp;compute_instance_id | **string**<br>List of archives of the specified Compute Cloud instance. 


### ListArchivesResponse {#ListArchivesResponse}

Field | Description
--- | ---
archives[] | **[Archive](#Archive)**<br> 


### Archive {#Archive}

Field | Description
--- | ---
id | **string**<br>ID of the backup. 
name | **string**<br>Name of the backup. 
vault_id | **string**<br>ID of the backup vault. 
attributes | **[ArchiveAttributes](#ArchiveAttributes)**<br>Archive attributes. 
size | **int64**<br>Archive size. 
compressed_data_size | **int64**<br>Compressed data size. 
data_size | **int64**<br>Data size. 
original_data_size | **int64**<br>Original data size. 
logical_size | **int64**<br>Logical size. 
format | enum **Format**<br> <ul><li>`VERSION_11`: A legacy backup format used in older versions. It's not recommended to use.</li><li>`VERSION_12`: A new format recommended in most cases for fast backup and recovery.</li><li>`AUTO`: Automatic version selection. Will be used version 12 unless the protection plan (policy) appends backups to the ones created by earlier product versions.</li></ul>
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
last_backup_created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
last_seen_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
protected_by_password | **bool**<br>If this field is true, it means that any of encryption algorithm has been chosen. 
encryption_algorithm | enum **EncryptionAlgorithm**<br> 
actions[] | enum **Action**<br> 
backup_plan_id | **string**<br>Backup plan ID. 
backup_plan_name | **string**<br>Backup plan name. 
description | **string**<br>Backup plan description. 
display_name | **string**<br>Display name, e.g. `INSTANCE_NAME - POLICY_NAME`. 
compute_instance_id | **string**<br>Compute Cloud instance ID. 
consistent | **bool**<br>If this field is true, it means that the archive is consistent. 
deleted | **bool**<br>If this field is true, it means that the archive was deleted. 
resource_id | **string**<br>Resource ID. 


### ArchiveAttributes {#ArchiveAttributes}

Field | Description
--- | ---
aaib | **string**<br>Archive attribute. Default value: `0`. 
uri | **string**<br>URI of the backup archive. 


## ListFiles {#ListFiles}

ListFiles of the backup.

**rpc ListFiles ([ListFilesRequest](#ListFilesRequest)) returns ([ListFilesResponse](#ListFilesResponse))**

### ListFilesRequest {#ListFilesRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. Folder ID. 
backup_id | **string**<br>Required. Backup ID. 
source_id | **string**<br>Empty source will list disks of the backup. 


### ListFilesResponse {#ListFilesResponse}

Field | Description
--- | ---
files[] | **[BackupFile](#BackupFile)**<br> 


### BackupFile {#BackupFile}

Field | Description
--- | ---
id | **string**<br>Required. ID of the item. Should be used as source ID in case of listing. 
parent_id | **google.protobuf.StringValue**<br>Might be empty if this is root directory. 
type | enum **Type**<br>Required. Type of the item. 
full_path | **string**<br>Required. Absolute path of the item. 
name | **string**<br>Required. Name of the directory / file. 
size | **int64**<br>Size in bytes of the item. 
actions | **[Actions](#Actions)**<br>Required. Actions that might be done on the object. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Required.  


### Actions {#Actions}

Field | Description
--- | ---
restore_to_disk | **bool**<br>Allows to send request to restore item to disk 
go_to_location | **bool**<br>Allows to move to location by id. 


## Get {#Get}

Get backup by its id.

**rpc Get ([GetBackupRequest](#GetBackupRequest)) returns ([Backup](#Backup1))**

### GetBackupRequest {#GetBackupRequest}

Field | Description
--- | ---
backup_id | **string**<br>Required. Backup ID. 
folder_id | **string**<br>Required. Folder ID. 


### Backup {#Backup1}

Field | Description
--- | ---
id | **string**<br>ID of the backup. 
vault_id | **string**<br>ID of the backup vault. 
archive_id | **string**<br>ID of the backup archive. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
last_seen_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
size | **int64**<br>Backup size. 
deduplicated_size | **int64**<br>Deduplicated backup size. 
backed_up_data_size | **int64**<br>Backed up data size. 
original_data_size | **int64**<br>Original data size. 
attributes | **[BackupAttributes](#BackupAttributes1)**<br> 
compute_instance_id | **string**<br>Compute Cloud instance ID. 
disks[] | **[Disk](#Disk1)**<br> 
type | enum **Type**<br> 
deleted | **bool**<br>If this field is true, it means that the backup was deleted. 
policy_id | **string**<br>[Policy](/docs/backup/concepts/policy) ID. 
resource_id | **string**<br>Resource ID. It identifies Compute Cloud instance in backup service. 


### BackupAttributes {#BackupAttributes1}

Field | Description
--- | ---
stream_name | **string**<br>Backup stream name. 
uri | **string**<br>URI of the backup archive. 


### Disk {#Disk1}

Field | Description
--- | ---
device_model | **string**<br>Device model. 
name | **string**<br>Disk name. 
size | **int64**<br>Disk size. 
volumes[] | **[Volume](#Volume1)**<br> 


### Volume {#Volume1}

Field | Description
--- | ---
free_space | **int64**<br>Free space in the volume. 
is_bootable | **bool**<br>If this field is true, it means that the volume is bootable. 
is_system | **bool**<br>If this field is true, it means that the volume is a system volume. 
name | **string**<br>Volume name. 
size | **int64**<br>Volume size. 
mount_strid | **string**<br>Mount string ID. 


## StartRecovery {#StartRecovery}

Start recovery process of specified backup to specific Compute Cloud instance. <br>For details, see [Restoring a VM from a backup](/docs/backup/operations/backup-vm/recover).

**rpc StartRecovery ([StartRecoveryRequest](#StartRecoveryRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[StartRecoveryMetadata](#StartRecoveryMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### StartRecoveryRequest {#StartRecoveryRequest}

Field | Description
--- | ---
compute_instance_id | **string**<br>Required. Destination Compute Cloud instance ID to which backup should be applied. The maximum string length in characters is 50.
backup_id | **string**<br>Required. Backup ID that will be applied to destination Compute Cloud instance. 


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[StartRecoveryMetadata](#StartRecoveryMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### StartRecoveryMetadata {#StartRecoveryMetadata}

Field | Description
--- | ---
progress_percentage | **double**<br>Progress of the backup process. 
src_backup_id | **string**<br>Source Backup ID that will be applied. 
dst_compute_instance_id | **string**<br>Destination Compute Cloud instance ID to which backup will be applied. 


## StartFilesRecovery {#StartFilesRecovery}

StartFilesRecovery runs recovery process of selected files to specific Compute Cloud instance.

**rpc StartFilesRecovery ([StartFilesRecoveryRequest](#StartFilesRecoveryRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[StartFilesRecoveryMetadata](#StartFilesRecoveryMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### StartFilesRecoveryRequest {#StartFilesRecoveryRequest}

Field | Description
--- | ---
compute_instance_id | **string**<br>Required. Destination instance ID. 
backup_id | **string**<br>Required. Backup ID. 
opts | **[FilesRecoveryOptions](#FilesRecoveryOptions)**<br>Required.  
source_ids[] | **string**<br> The number of elements must be greater than 0.


### FilesRecoveryOptions {#FilesRecoveryOptions}

Field | Description
--- | ---
overwrite | enum **Overwrite**<br>Overwrite options declares the behavior for files that already exists on the file system. <ul><li>`OVERWRITE_UNSPECIFIED`: Unspecified value treated as Overwrite all</li><li>`OVERWRITE_ALL`: All overwrites all existing files by recovered ones.</li><li>`OVERWRITE_OLDER`: Older overwrites older files only.</li><li>`OVERWRITE_NONE`: None does not overwrites files at all.</li></ul>
reboot_if_needed | **bool**<br>specifies whether the recovery plan is able to reboot host if needed. 
type | **oneof:** `original` or `custom`<br>Path strategy for selected files.
&nbsp;&nbsp;original | **[TargetPathOriginal](#TargetPathOriginal)**<br>Keep original paths of files. 
&nbsp;&nbsp;custom | **[TargetPathCustom](#TargetPathCustom)**<br>Set custom folder for file recovery. 


### TargetPathOriginal {#TargetPathOriginal}

Empty.

### TargetPathCustom {#TargetPathCustom}

Field | Description
--- | ---
path | **string**<br>Custom folder for file recovery. 


### Operation {#Operation1}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[StartFilesRecoveryMetadata](#StartFilesRecoveryMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### StartFilesRecoveryMetadata {#StartFilesRecoveryMetadata}

Field | Description
--- | ---
progress_percentage | **double**<br> 
compute_instance_id | **string**<br>Required. Destination instance ID. 
backup_id | **string**<br>Required. Backup ID. 
source_ids[] | **string**<br> The number of elements must be greater than 0.


## Delete {#Delete}

Delete specific backup.

**rpc Delete ([DeleteBackupRequest](#DeleteBackupRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteBackupMetadata](#DeleteBackupMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteBackupRequest {#DeleteBackupRequest}

Field | Description
--- | ---
compute_instance_id | **string**<br>Required. Compute Cloud instance ID of the Backup. The maximum string length in characters is 50.
backup_id | **string**<br>Required. Backup ID that should be deleted. 


### Operation {#Operation2}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteBackupMetadata](#DeleteBackupMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### DeleteBackupMetadata {#DeleteBackupMetadata}

Field | Description
--- | ---
compute_instance_id | **string**<br>Compute Cloud instance ID of the Backup. 
backup_id | **string**<br>Backup ID that should be deleted. 


