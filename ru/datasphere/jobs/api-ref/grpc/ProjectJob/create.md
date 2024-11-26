---
editable: false
sourcePath: en/_api-ref-grpc/datasphere/v2/jobs/api-ref/grpc/ProjectJob/create.md
---

# DataSphere Jobs API v2, gRPC: ProjectJobService.Create

Creates job.

## gRPC request

**rpc Create ([CreateProjectJobRequest](#yandex.cloud.datasphere.v2.jobs.CreateProjectJobRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## CreateProjectJobRequest {#yandex.cloud.datasphere.v2.jobs.CreateProjectJobRequest}

```json
{
  "project_id": "string",
  "job_parameters": {
    "input_files": [
      {
        "desc": {
          "path": "string",
          "var": "string"
        },
        "sha256": "string",
        "size_bytes": "int64",
        "compression_type": "FileCompressionType"
      }
    ],
    "output_files": [
      {
        "path": "string",
        "var": "string"
      }
    ],
    "s3_mount_ids": [
      "string"
    ],
    "dataset_ids": [
      "string"
    ],
    "cmd": "string",
    "env": {
      "vars": "string",
      // Includes only one of the fields `docker_image_resource_id`, `docker_image_spec`
      "docker_image_resource_id": "string",
      "docker_image_spec": {
        "image_url": "string",
        "username": "string",
        // Includes only one of the fields `password_plain_text`, `password_ds_secret_name`
        "password_plain_text": "string",
        "password_ds_secret_name": "string"
        // end of the list of possible fields
      },
      // end of the list of possible fields
      "python_env": {
        "conda_yaml": "string",
        "local_modules": [
          {
            "desc": {
              "path": "string",
              "var": "string"
            },
            "sha256": "string",
            "size_bytes": "int64",
            "compression_type": "FileCompressionType"
          }
        ],
        "python_version": "string",
        "requirements": [
          "string"
        ],
        "pip_options": {
          "index_url": "string",
          "extra_index_urls": [
            "string"
          ],
          "trusted_hosts": [
            "string"
          ],
          "no_deps": "bool"
        }
      }
    },
    "attach_project_disk": "bool",
    "cloud_instance_types": [
      {
        "name": "string"
      }
    ],
    "extended_working_storage": {
      "type": "StorageType",
      "size_gb": "int64"
    },
    "arguments": [
      {
        "name": "string",
        "value": "string"
      }
    ],
    "output_datasets": [
      {
        "name": "string",
        "description": "string",
        "labels": "string",
        "size_gb": "int64",
        "var": "string"
      }
    ],
    "graceful_shutdown_parameters": {
      "timeout": "google.protobuf.Duration",
      "signal": "int64"
    }
  },
  "config": "string",
  "name": "string",
  "desc": "string",
  "data_ttl": "google.protobuf.Duration"
}
```

#|
||Field | Description ||
|| project_id | **string**

ID of the project. ||
|| job_parameters | **[JobParameters](#yandex.cloud.datasphere.v2.jobs.JobParameters)**

Parameters of the job. ||
|| config | **string**

Config of the job. ||
|| name | **string**

Name of the job. ||
|| desc | **string**

Description of the job. ||
|| data_ttl | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Job data TTL. ||
|#

## JobParameters {#yandex.cloud.datasphere.v2.jobs.JobParameters}

Job parameters.

#|
||Field | Description ||
|| input_files[] | **[File](#yandex.cloud.datasphere.v2.jobs.File)**

List of input files. ||
|| output_files[] | **[FileDesc](#yandex.cloud.datasphere.v2.jobs.FileDesc)**

List of output files descriptions. ||
|| s3_mount_ids[] | **string**

List of DataSphere S3 mount ids. ||
|| dataset_ids[] | **string**

List of DataSphere dataset ids. ||
|| cmd | **string**

Job run command. ||
|| env | **[Environment](#yandex.cloud.datasphere.v2.jobs.Environment)**

Job environment description. ||
|| attach_project_disk | **bool**

Should project disk be attached to VM. ||
|| cloud_instance_types[] | **[CloudInstanceType](#yandex.cloud.datasphere.v2.jobs.CloudInstanceType)**

VM specification. ||
|| extended_working_storage | **[ExtendedWorkingStorage](#yandex.cloud.datasphere.v2.jobs.ExtendedWorkingStorage)**

Extended working storage configuration. ||
|| arguments[] | **[Argument](#yandex.cloud.datasphere.v2.jobs.Argument)**

List of literal arguments. ||
|| output_datasets[] | **[OutputDatasetDesc](#yandex.cloud.datasphere.v2.jobs.OutputDatasetDesc)**

List of DataSets descriptions to create. ||
|| graceful_shutdown_parameters | **[GracefulShutdownParameters](#yandex.cloud.datasphere.v2.jobs.GracefulShutdownParameters)**

Graceful shutdown settings. ||
|#

## File {#yandex.cloud.datasphere.v2.jobs.File}

#|
||Field | Description ||
|| desc | **[FileDesc](#yandex.cloud.datasphere.v2.jobs.FileDesc)** ||
|| sha256 | **string**

SHA256 of the file. ||
|| size_bytes | **int64**

File size in bytes. ||
|| compression_type | enum **FileCompressionType**

File compression info

- `FILE_COMPRESSION_TYPE_UNSPECIFIED`
- `NONE`
- `ZIP` ||
|#

## FileDesc {#yandex.cloud.datasphere.v2.jobs.FileDesc}

#|
||Field | Description ||
|| path | **string**

Path of the file on filesystem. ||
|| var | **string**

Variable to use in cmd substitution. ||
|#

## Environment {#yandex.cloud.datasphere.v2.jobs.Environment}

#|
||Field | Description ||
|| vars | **string**

Environment variables. ||
|| docker_image_resource_id | **string**

DS docker image id.

Includes only one of the fields `docker_image_resource_id`, `docker_image_spec`. ||
|| docker_image_spec | **[DockerImageSpec](#yandex.cloud.datasphere.v2.jobs.DockerImageSpec)**

Includes only one of the fields `docker_image_resource_id`, `docker_image_spec`. ||
|| python_env | **[PythonEnv](#yandex.cloud.datasphere.v2.jobs.PythonEnv)** ||
|#

## DockerImageSpec {#yandex.cloud.datasphere.v2.jobs.DockerImageSpec}

#|
||Field | Description ||
|| image_url | **string**

Docker image URL. ||
|| username | **string**

Username for container registry. ||
|| password_plain_text | **string**

Plaintext password.

Includes only one of the fields `password_plain_text`, `password_ds_secret_name`.

Password for container registry. ||
|| password_ds_secret_name | **string**

ID of DataSphere secret containing password.

Includes only one of the fields `password_plain_text`, `password_ds_secret_name`.

Password for container registry. ||
|#

## PythonEnv {#yandex.cloud.datasphere.v2.jobs.PythonEnv}

#|
||Field | Description ||
|| conda_yaml | **string**

Conda YAML. ||
|| local_modules[] | **[File](#yandex.cloud.datasphere.v2.jobs.File)**

List of local modules descriptions. ||
|| python_version | **string**

Python version reduced to major.minor ||
|| requirements[] | **string**

List of pip requirements ||
|| pip_options | **[PipOptions](#yandex.cloud.datasphere.v2.jobs.PipOptions)**

Pip install options ||
|#

## PipOptions {#yandex.cloud.datasphere.v2.jobs.PipOptions}

#|
||Field | Description ||
|| index_url | **string**

--index-url option ||
|| extra_index_urls[] | **string**

--extra-index-urls option ||
|| trusted_hosts[] | **string**

--trusted-hosts option ||
|| no_deps | **bool**

--no-deps option ||
|#

## CloudInstanceType {#yandex.cloud.datasphere.v2.jobs.CloudInstanceType}

#|
||Field | Description ||
|| name | **string**

Name of DataSphere VM configuration. ||
|#

## ExtendedWorkingStorage {#yandex.cloud.datasphere.v2.jobs.ExtendedWorkingStorage}

Extended working storage configuration.

#|
||Field | Description ||
|| type | enum **StorageType**

- `STORAGE_TYPE_UNSPECIFIED`
- `SSD` ||
|| size_gb | **int64** ||
|#

## Argument {#yandex.cloud.datasphere.v2.jobs.Argument}

#|
||Field | Description ||
|| name | **string** ||
|| value | **string** ||
|#

## OutputDatasetDesc {#yandex.cloud.datasphere.v2.jobs.OutputDatasetDesc}

#|
||Field | Description ||
|| name | **string**

Name to create dataset with ||
|| description | **string**

Description to show in UI ||
|| labels | **string** ||
|| size_gb | **int64**

Size of dataset to create ||
|| var | **string**

Var name to replace in cmd, like in FileDesc ||
|#

## GracefulShutdownParameters {#yandex.cloud.datasphere.v2.jobs.GracefulShutdownParameters}

#|
||Field | Description ||
|| timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)** ||
|| signal | **int64**

default 15 (SIGTERM) ||
|#

## operation.Operation {#yandex.cloud.operation.Operation}

```json
{
  "id": "string",
  "description": "string",
  "created_at": "google.protobuf.Timestamp",
  "created_by": "string",
  "modified_at": "google.protobuf.Timestamp",
  "done": "bool",
  "metadata": {
    "project_id": "string",
    "job_id": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "job_id": "string",
    "upload_files": [
      {
        "file": {
          "desc": {
            "path": "string",
            "var": "string"
          },
          "sha256": "string",
          "size_bytes": "int64",
          "compression_type": "FileCompressionType"
        },
        "url": "string"
      }
    ]
  }
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).

#|
||Field | Description ||
|| id | **string**

ID of the operation. ||
|| description | **string**

Description of the operation. 0-256 characters long. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| created_by | **string**

ID of the user or service account who initiated the operation. ||
|| modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[CreateProjectJobMetadata](#yandex.cloud.datasphere.v2.jobs.CreateProjectJobMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **[CreateProjectJobResponse](#yandex.cloud.datasphere.v2.jobs.CreateProjectJobResponse)**

The normal response of the operation in case of success.
If the original method returns no data on success, such as Delete,
the response is [google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty).
If the original method is the standard Create/Update,
the response should be the target resource of the operation.
Any method that returns a long-running operation should document the response type, if any.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|#

## CreateProjectJobMetadata {#yandex.cloud.datasphere.v2.jobs.CreateProjectJobMetadata}

#|
||Field | Description ||
|| project_id | **string**

ID of the project. ||
|| job_id | **string**

Job ID. ||
|#

## CreateProjectJobResponse {#yandex.cloud.datasphere.v2.jobs.CreateProjectJobResponse}

#|
||Field | Description ||
|| job_id | **string**

ID of the job. ||
|| upload_files[] | **[StorageFile](#yandex.cloud.datasphere.v2.jobs.StorageFile)**

Files to upload with their presigned URLs for upload. ||
|#

## StorageFile {#yandex.cloud.datasphere.v2.jobs.StorageFile}

#|
||Field | Description ||
|| file | **[File](#yandex.cloud.datasphere.v2.jobs.File2)** ||
|| url | **string**

File URL. ||
|#

## File {#yandex.cloud.datasphere.v2.jobs.File2}

#|
||Field | Description ||
|| desc | **[FileDesc](#yandex.cloud.datasphere.v2.jobs.FileDesc2)** ||
|| sha256 | **string**

SHA256 of the file. ||
|| size_bytes | **int64**

File size in bytes. ||
|| compression_type | enum **FileCompressionType**

File compression info

- `FILE_COMPRESSION_TYPE_UNSPECIFIED`
- `NONE`
- `ZIP` ||
|#

## FileDesc {#yandex.cloud.datasphere.v2.jobs.FileDesc2}

#|
||Field | Description ||
|| path | **string**

Path of the file on filesystem. ||
|| var | **string**

Variable to use in cmd substitution. ||
|#