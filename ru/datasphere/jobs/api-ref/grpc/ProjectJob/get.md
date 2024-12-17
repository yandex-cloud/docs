---
editable: false
sourcePath: en/_api-ref-grpc/datasphere/v2/jobs/api-ref/grpc/ProjectJob/get.md
---

# DataSphere Jobs API v2, gRPC: ProjectJobService.Get

Returns job by id.

## gRPC request

**rpc Get ([GetProjectJobRequest](#yandex.cloud.datasphere.v2.jobs.GetProjectJobRequest)) returns ([Job](#yandex.cloud.datasphere.v2.jobs.Job))**

## GetProjectJobRequest {#yandex.cloud.datasphere.v2.jobs.GetProjectJobRequest}

```json
{
  "job_id": "string"
}
```

#|
||Field | Description ||
|| job_id | **string**

ID of the job. ||
|#

## Job {#yandex.cloud.datasphere.v2.jobs.Job}

```json
{
  "id": "string",
  "name": "string",
  "desc": "string",
  "created_at": "google.protobuf.Timestamp",
  "finished_at": "google.protobuf.Timestamp",
  "status": "JobStatus",
  "config": "string",
  "created_by_id": "string",
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
      "vars": "map<string, string>",
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
        "labels": "map<string, string>",
        "size_gb": "int64",
        "var": "string"
      }
    ],
    "graceful_shutdown_parameters": {
      "timeout": "google.protobuf.Duration",
      "signal": "int64"
    },
    "spark_parameters": {
      "connector_id": "string"
    }
  },
  "data_expires_at": "google.protobuf.Timestamp",
  "data_cleared": "bool",
  "output_files": [
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
  "log_files": [
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
  "diagnostic_files": [
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
  "data_size_bytes": "int64",
  "started_at": "google.protobuf.Timestamp",
  "status_details": "string",
  "actual_cloud_instance_type": {
    "name": "string"
  },
  "parent_job_id": "string",
  "file_errors": [
    {
      // Includes only one of the fields `output_file_desc`, `log_file_name`
      "output_file_desc": {
        "path": "string",
        "var": "string"
      },
      "log_file_name": "string",
      // end of the list of possible fields
      "description": "string",
      "type": "ErrorType"
    }
  ],
  "output_datasets": [
    {
      "desc": {
        "name": "string",
        "description": "string",
        "labels": "map<string, string>",
        "size_gb": "int64",
        "var": "string"
      },
      "id": "string"
    }
  ]
}
```

Instance of the job.

#|
||Field | Description ||
|| id | **string**

ID of the job. ||
|| name | **string**

Name of the job. ||
|| desc | **string**

Description of the job. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Create job timestamp. ||
|| finished_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Finish job timestamp. ||
|| status | enum **JobStatus**

Status of the job.

- `JOB_STATUS_UNSPECIFIED`
- `CREATING`
- `EXECUTING`
- `UPLOADING_OUTPUT`
- `SUCCESS`
- `ERROR`
- `CANCELLED`
- `CANCELLING`
- `PREPARING` ||
|| config | **string**

Config of the job, copied from configuration file. ||
|| created_by_id | **string**

ID of the user who created the job. ||
|| project_id | **string**

ID of the project. ||
|| job_parameters | **[JobParameters](#yandex.cloud.datasphere.v2.jobs.JobParameters)** ||
|| data_expires_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Job data expiration timestamp. ||
|| data_cleared | **bool**

Marks if the job data has been cleared. ||
|| output_files[] | **[File](#yandex.cloud.datasphere.v2.jobs.File)**

Output files of the job. ||
|| log_files[] | **[File](#yandex.cloud.datasphere.v2.jobs.File)**

Job log files. ||
|| diagnostic_files[] | **[File](#yandex.cloud.datasphere.v2.jobs.File)**

Job diagnostics files. ||
|| data_size_bytes | **int64**

Job total data size. ||
|| started_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Start job timestamp. ||
|| status_details | **string**

Details. ||
|| actual_cloud_instance_type | **[CloudInstanceType](#yandex.cloud.datasphere.v2.jobs.CloudInstanceType)**

Actual VM instance type, job is running on. ||
|| parent_job_id | **string**

Reference to the parent job. ||
|| file_errors[] | **[FileUploadError](#yandex.cloud.datasphere.v2.jobs.FileUploadError)**

Failed uploads. ||
|| output_datasets[] | **[OutputDataset](#yandex.cloud.datasphere.v2.jobs.OutputDataset)**

Created datasets. ||
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
|| spark_parameters | **[SparkParameters](#yandex.cloud.datasphere.v2.jobs.SparkParameters)**

Spark connector settings. ||
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
|| vars | **object** (map<**string**, **string**>)

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
|| labels | **object** (map<**string**, **string**>) ||
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

## SparkParameters {#yandex.cloud.datasphere.v2.jobs.SparkParameters}

#|
||Field | Description ||
|| connector_id | **string**

ID of the Spark connector. ||
|#

## FileUploadError {#yandex.cloud.datasphere.v2.jobs.FileUploadError}

#|
||Field | Description ||
|| output_file_desc | **[FileDesc](#yandex.cloud.datasphere.v2.jobs.FileDesc)**

Includes only one of the fields `output_file_desc`, `log_file_name`. ||
|| log_file_name | **string**

Includes only one of the fields `output_file_desc`, `log_file_name`. ||
|| description | **string** ||
|| type | enum **ErrorType**

- `ERROR_TYPE_UNSPECIFIED`
- `UPLOAD_FAILED`
- `NOT_FOUND` ||
|#

## OutputDataset {#yandex.cloud.datasphere.v2.jobs.OutputDataset}

#|
||Field | Description ||
|| desc | **[OutputDatasetDesc](#yandex.cloud.datasphere.v2.jobs.OutputDatasetDesc)**

Dataset description ||
|| id | **string**

Id of created dataset ||
|#