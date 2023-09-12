---
editable: false
sourcePath: en/_api-ref-grpc/datasphere/v2/api-ref/grpc/project_job_service.md
---

# DataSphere API v2, gRPC: ProjectJobService

A set of methods for managing Project Jobs.

| Call | Description |
| --- | --- |
| [Create](#Create) | Creates job. |
| [Execute](#Execute) | Runs job execution. |
| [Cancel](#Cancel) | Cancels running job. |
| [Finalize](#Finalize) | Triggers cleanup after downloading job results. |
| [ReadStdLogs](#ReadStdLogs) | Returns stream of job logs. |
| [DownloadStdLogs](#DownloadStdLogs) | Returns URL for downloading job logs. |
| [List](#List) | Lists jobs. |
| [Get](#Get) | Returns job by id. |
| [Delete](#Delete) | Deletes specified job. |

## Calls ProjectJobService {#calls}

## Create {#Create}

Creates job.

**rpc Create ([CreateProjectJobRequest](#CreateProjectJobRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateProjectJobMetadata](#CreateProjectJobMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[CreateProjectJobResponse](#CreateProjectJobResponse)<br>

### CreateProjectJobRequest {#CreateProjectJobRequest}

Field | Description
--- | ---
project_id | **string**<br>ID of the project. 
job_parameters | **[JobParameters](#JobParameters)**<br>Parameters of the job. 
config | **string**<br>Config of the job. 
name | **string**<br>Name of the job. 
desc | **string**<br>Description of the job. 


### JobParameters {#JobParameters}

Field | Description
--- | ---
input_files[] | **[File](#File)**<br> 
output_files[] | **[FileDesc](#FileDesc)**<br> 
s3_mount_ids[] | **string**<br> 
dataset_ids[] | **string**<br> 
cmd | **string**<br> 
env | **[Environment](#Environment)**<br> 
attach_project_disk | **bool**<br> 
cloud_instance_type | **[CloudInstanceType](#CloudInstanceType)**<br> 


### File {#File}

Field | Description
--- | ---
desc | **[FileDesc](#FileDesc)**<br> 
sha256 | **string**<br> 
size_bytes | **int64**<br> 


### FileDesc {#FileDesc}

Field | Description
--- | ---
path | **string**<br>Path to file can be: <ul><li>Hard-coded, only path, which can be only relative. </li><li>Variable, user will specify `var` for file besides path, this `var` will be in `cmd` template.</li></ul> 
var | **string**<br> 


### Environment {#Environment}

Field | Description
--- | ---
vars | **map<string,string>**<br> 
docker_image | **oneof:** `docker_image_resource_id` or `docker_image_spec`<br>
&nbsp;&nbsp;docker_image_resource_id | **string**<br> 
&nbsp;&nbsp;docker_image_spec | **[DockerImageSpec](#DockerImageSpec)**<br> 
python_env | **[PythonEnv](#PythonEnv)**<br> 


### DockerImageSpec {#DockerImageSpec}

Field | Description
--- | ---
image_url | **string**<br> 
username | **string**<br> 
password | **oneof:** `password_plain_text` or `password_ds_secret_name`<br>
&nbsp;&nbsp;password_plain_text | **string**<br> 
&nbsp;&nbsp;password_ds_secret_name | **string**<br> 


### PythonEnv {#PythonEnv}

Field | Description
--- | ---
conda_yaml | **string**<br> 
local_modules[] | **[File](#File1)**<br> 


### CloudInstanceType {#CloudInstanceType}

Field | Description
--- | ---
name | **string**<br>Currently is DS pool name (g2.8, c1.4, ...). Additional spec providers can be added here in the future. 


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateProjectJobMetadata](#CreateProjectJobMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateProjectJobResponse](#CreateProjectJobResponse)>**<br>if operation finished successfully. 


### CreateProjectJobMetadata {#CreateProjectJobMetadata}

Field | Description
--- | ---
project_id | **string**<br>ID of the project. 


### CreateProjectJobResponse {#CreateProjectJobResponse}

Field | Description
--- | ---
job_id | **string**<br>ID of the job. 
upload_files[] | **[StorageFile](#StorageFile)**<br>Files to upload with their presigned URLs for upload. 


### StorageFile {#StorageFile}

Field | Description
--- | ---
file | **[File](#File1)**<br> 
url | **string**<br> 


## Execute {#Execute}

Runs job execution.

**rpc Execute ([ExecuteProjectJobRequest](#ExecuteProjectJobRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[ExecuteProjectJobMetadata](#ExecuteProjectJobMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[ExecuteProjectJobResponse](#ExecuteProjectJobResponse)<br>

### ExecuteProjectJobRequest {#ExecuteProjectJobRequest}

Field | Description
--- | ---
job_id | **string**<br>ID of the job. 


### Operation {#Operation1}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[ExecuteProjectJobMetadata](#ExecuteProjectJobMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[ExecuteProjectJobResponse](#ExecuteProjectJobResponse)>**<br>if operation finished successfully. 


### ExecuteProjectJobMetadata {#ExecuteProjectJobMetadata}

Field | Description
--- | ---
job | **[Job](#Job)**<br>Instance of the job. 


### Job {#Job}

Field | Description
--- | ---
id | **string**<br> 
name | **string**<br> 
desc | **string**<br> 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
finished_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
status | enum **JobStatus**<br> 
config | **string**<br> 
created_by_id | **string**<br> 
project_id | **string**<br> 
job_parameters | **[JobParameters](#JobParameters1)**<br> 


### JobParameters {#JobParameters1}

Field | Description
--- | ---
input_files[] | **[File](#File1)**<br> 
output_files[] | **[FileDesc](#FileDesc1)**<br> 
s3_mount_ids[] | **string**<br> 
dataset_ids[] | **string**<br> 
cmd | **string**<br> 
env | **[Environment](#Environment1)**<br> 
attach_project_disk | **bool**<br> 
cloud_instance_type | **[CloudInstanceType](#CloudInstanceType1)**<br> 


### File {#File1}

Field | Description
--- | ---
desc | **[FileDesc](#FileDesc1)**<br> 
sha256 | **string**<br> 
size_bytes | **int64**<br> 


### FileDesc {#FileDesc1}

Field | Description
--- | ---
path | **string**<br>Path to file can be: <ul><li>Hard-coded, only path, which can be only relative. </li><li>Variable, user will specify `var` for file besides path, this `var` will be in `cmd` template.</li></ul> 
var | **string**<br> 


### Environment {#Environment1}

Field | Description
--- | ---
vars | **map<string,string>**<br> 
docker_image | **oneof:** `docker_image_resource_id` or `docker_image_spec`<br>
&nbsp;&nbsp;docker_image_resource_id | **string**<br> 
&nbsp;&nbsp;docker_image_spec | **[DockerImageSpec](#DockerImageSpec1)**<br> 
python_env | **[PythonEnv](#PythonEnv1)**<br> 


### DockerImageSpec {#DockerImageSpec1}

Field | Description
--- | ---
image_url | **string**<br> 
username | **string**<br> 
password | **oneof:** `password_plain_text` or `password_ds_secret_name`<br>
&nbsp;&nbsp;password_plain_text | **string**<br> 
&nbsp;&nbsp;password_ds_secret_name | **string**<br> 


### PythonEnv {#PythonEnv1}

Field | Description
--- | ---
conda_yaml | **string**<br> 
local_modules[] | **[File](#File2)**<br> 


### CloudInstanceType {#CloudInstanceType1}

Field | Description
--- | ---
name | **string**<br>Currently is DS pool name (g2.8, c1.4, ...). Additional spec providers can be added here in the future. 


### ExecuteProjectJobResponse {#ExecuteProjectJobResponse}

Field | Description
--- | ---
output_files[] | **[StorageFile](#StorageFile1)**<br>Uploaded output files with URLs. 
result | **[JobResult](#JobResult)**<br>Result of the job. 


### StorageFile {#StorageFile1}

Field | Description
--- | ---
file | **[File](#File2)**<br> 
url | **string**<br> 


### JobResult {#JobResult}

Field | Description
--- | ---
return_code | **int64**<br> 


## Cancel {#Cancel}

Cancels running job.

**rpc Cancel ([CancelProjectJobRequest](#CancelProjectJobRequest)) returns ([google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty))**

### CancelProjectJobRequest {#CancelProjectJobRequest}

Field | Description
--- | ---
job_id | **string**<br>ID of the job. 
reason | **string**<br>Optional cancellation reason. 


## Finalize {#Finalize}

Triggers cleanup after downloading job results.

**rpc Finalize ([FinalizeProjectJobRequest](#FinalizeProjectJobRequest)) returns ([FinalizeProjectJobResponse](#FinalizeProjectJobResponse))**

### FinalizeProjectJobRequest {#FinalizeProjectJobRequest}

Field | Description
--- | ---
job_id | **string**<br>ID of the job. 


### FinalizeProjectJobResponse {#FinalizeProjectJobResponse}

Field | Description
--- | ---
job_id | **string**<br>ID of the job. 


## ReadStdLogs {#ReadStdLogs}

Returns stream of job logs.

**rpc ReadStdLogs ([ReadProjectJobStdLogsRequest](#ReadProjectJobStdLogsRequest)) returns (stream [ReadProjectJobStdLogsResponse](#ReadProjectJobStdLogsResponse))**

### ReadProjectJobStdLogsRequest {#ReadProjectJobStdLogsRequest}

Field | Description
--- | ---
job_id | **string**<br>ID of the job. 
offset | **int64**<br>Log offset. 


### ReadProjectJobStdLogsResponse {#ReadProjectJobStdLogsResponse}

Field | Description
--- | ---
logs[] | **[StdLog](#StdLog)**<br> 
offset | **int64**<br>Log offset. 


### StdLog {#StdLog}

Field | Description
--- | ---
content | **bytes**<br>Log contents. 
type | enum **Type**<br>Log type. <ul><li>`OUT`: stdout.</li><li>`ERR`: stderr.</li></ul>


## DownloadStdLogs {#DownloadStdLogs}

Returns URL for downloading job logs.

**rpc DownloadStdLogs ([DownloadProjectJobStdLogsRequest](#DownloadProjectJobStdLogsRequest)) returns ([DownloadProjectJobStdLogsResponse](#DownloadProjectJobStdLogsResponse))**

### DownloadProjectJobStdLogsRequest {#DownloadProjectJobStdLogsRequest}

Field | Description
--- | ---
job_id | **string**<br>ID of the job. 


### DownloadProjectJobStdLogsResponse {#DownloadProjectJobStdLogsResponse}

Field | Description
--- | ---
stdout_url | **string**<br>URL to download stdout log. 
stderr_url | **string**<br>URL to download stderr log. 


## List {#List}

Lists jobs.

**rpc List ([ListProjectJobRequest](#ListProjectJobRequest)) returns ([ListProjectJobResponse](#ListProjectJobResponse))**

### ListProjectJobRequest {#ListProjectJobRequest}

Field | Description
--- | ---
project_id | **string**<br>ID of the project. 
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListProjectJobResponse.page_token](#ListProjectJobResponse) that can be used to get the next page of results in subsequent list requests. 
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListProjectJobResponse.page_token](#ListProjectJobResponse) returned by a previous list request. 


### ListProjectJobResponse {#ListProjectJobResponse}

Field | Description
--- | ---
jobs[] | **[Job](#Job1)**<br>Instances of the jobs. 
page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListProjectJobRequest.page_size](#ListProjectJobRequest), use the [next_page_token] as the value for the [ListProjectJobRequest.page_token](#ListProjectJobRequest) query parameter in the next list request. Each subsequent list request will have its own `page_token` to continue paging through the results. 


### Job {#Job1}

Field | Description
--- | ---
id | **string**<br> 
name | **string**<br> 
desc | **string**<br> 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
finished_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
status | enum **JobStatus**<br> 
config | **string**<br> 
created_by_id | **string**<br> 
project_id | **string**<br> 
job_parameters | **[JobParameters](#JobParameters2)**<br> 


### JobParameters {#JobParameters2}

Field | Description
--- | ---
input_files[] | **[File](#File2)**<br> 
output_files[] | **[FileDesc](#FileDesc2)**<br> 
s3_mount_ids[] | **string**<br> 
dataset_ids[] | **string**<br> 
cmd | **string**<br> 
env | **[Environment](#Environment2)**<br> 
attach_project_disk | **bool**<br> 
cloud_instance_type | **[CloudInstanceType](#CloudInstanceType2)**<br> 


### File {#File2}

Field | Description
--- | ---
desc | **[FileDesc](#FileDesc2)**<br> 
sha256 | **string**<br> 
size_bytes | **int64**<br> 


### FileDesc {#FileDesc2}

Field | Description
--- | ---
path | **string**<br>Path to file can be: <ul><li>Hard-coded, only path, which can be only relative. </li><li>Variable, user will specify `var` for file besides path, this `var` will be in `cmd` template.</li></ul> 
var | **string**<br> 


### Environment {#Environment2}

Field | Description
--- | ---
vars | **map<string,string>**<br> 
docker_image | **oneof:** `docker_image_resource_id` or `docker_image_spec`<br>
&nbsp;&nbsp;docker_image_resource_id | **string**<br> 
&nbsp;&nbsp;docker_image_spec | **[DockerImageSpec](#DockerImageSpec2)**<br> 
python_env | **[PythonEnv](#PythonEnv2)**<br> 


### DockerImageSpec {#DockerImageSpec2}

Field | Description
--- | ---
image_url | **string**<br> 
username | **string**<br> 
password | **oneof:** `password_plain_text` or `password_ds_secret_name`<br>
&nbsp;&nbsp;password_plain_text | **string**<br> 
&nbsp;&nbsp;password_ds_secret_name | **string**<br> 


### PythonEnv {#PythonEnv2}

Field | Description
--- | ---
conda_yaml | **string**<br> 
local_modules[] | **[File](#File3)**<br> 


### CloudInstanceType {#CloudInstanceType2}

Field | Description
--- | ---
name | **string**<br>Currently is DS pool name (g2.8, c1.4, ...). Additional spec providers can be added here in the future. 


## Get {#Get}

Returns job by id.

**rpc Get ([GetProjectJobRequest](#GetProjectJobRequest)) returns ([Job](#Job2))**

### GetProjectJobRequest {#GetProjectJobRequest}

Field | Description
--- | ---
job_id | **string**<br>ID of the job. 


### Job {#Job2}

Field | Description
--- | ---
id | **string**<br> 
name | **string**<br> 
desc | **string**<br> 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
finished_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
status | enum **JobStatus**<br> 
config | **string**<br> 
created_by_id | **string**<br> 
project_id | **string**<br> 
job_parameters | **[JobParameters](#JobParameters3)**<br> 


### JobParameters {#JobParameters3}

Field | Description
--- | ---
input_files[] | **[File](#File3)**<br> 
output_files[] | **[FileDesc](#FileDesc3)**<br> 
s3_mount_ids[] | **string**<br> 
dataset_ids[] | **string**<br> 
cmd | **string**<br> 
env | **[Environment](#Environment3)**<br> 
attach_project_disk | **bool**<br> 
cloud_instance_type | **[CloudInstanceType](#CloudInstanceType3)**<br> 


### File {#File3}

Field | Description
--- | ---
desc | **[FileDesc](#FileDesc3)**<br> 
sha256 | **string**<br> 
size_bytes | **int64**<br> 


### FileDesc {#FileDesc3}

Field | Description
--- | ---
path | **string**<br>Path to file can be: <ul><li>Hard-coded, only path, which can be only relative. </li><li>Variable, user will specify `var` for file besides path, this `var` will be in `cmd` template.</li></ul> 
var | **string**<br> 


### Environment {#Environment3}

Field | Description
--- | ---
vars | **map<string,string>**<br> 
docker_image | **oneof:** `docker_image_resource_id` or `docker_image_spec`<br>
&nbsp;&nbsp;docker_image_resource_id | **string**<br> 
&nbsp;&nbsp;docker_image_spec | **[DockerImageSpec](#DockerImageSpec3)**<br> 
python_env | **[PythonEnv](#PythonEnv3)**<br> 


### DockerImageSpec {#DockerImageSpec3}

Field | Description
--- | ---
image_url | **string**<br> 
username | **string**<br> 
password | **oneof:** `password_plain_text` or `password_ds_secret_name`<br>
&nbsp;&nbsp;password_plain_text | **string**<br> 
&nbsp;&nbsp;password_ds_secret_name | **string**<br> 


### PythonEnv {#PythonEnv3}

Field | Description
--- | ---
conda_yaml | **string**<br> 
local_modules[] | **[File](#File4)**<br> 


### CloudInstanceType {#CloudInstanceType3}

Field | Description
--- | ---
name | **string**<br>Currently is DS pool name (g2.8, c1.4, ...). Additional spec providers can be added here in the future. 


## Delete {#Delete}

Deletes specified job.

**rpc Delete ([DeleteProjectJobRequest](#DeleteProjectJobRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteProjectJobMetadata](#DeleteProjectJobMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteProjectJobRequest {#DeleteProjectJobRequest}

Field | Description
--- | ---
job_id | **string**<br>ID of the job. 


### Operation {#Operation2}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteProjectJobMetadata](#DeleteProjectJobMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### DeleteProjectJobMetadata {#DeleteProjectJobMetadata}

Field | Description
--- | ---
job_id | **string**<br>ID of the job. 


