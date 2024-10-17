---
editable: false
sourcePath: en/_api-ref-grpc/datasphere/v2/jobs/api-ref/grpc/ProjectJob/list.md
---

# DataSphere Jobs API v2, gRPC: ProjectJobService.List {#List}

Lists jobs.

## gRPC request

**rpc List ([ListProjectJobRequest](#yandex.cloud.datasphere.v2.jobs.ListProjectJobRequest)) returns ([ListProjectJobResponse](#yandex.cloud.datasphere.v2.jobs.ListProjectJobResponse))**

## ListProjectJobRequest {#yandex.cloud.datasphere.v2.jobs.ListProjectJobRequest}

```json
{
  "projectId": "string",
  "pageSize": "int64",
  "pageToken": "string",
  "filter": "string"
}
```

#|
||Field | Description ||
|| projectId | **string**

ID of the project. ||
|| pageSize | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`,
the service returns a `ListProjectJobResponse.pageToken`
that can be used to get the next page of results in subsequent list requests. ||
|| pageToken | **string**

Page token. To get the next page of results, set `pageToken` to the
`ListProjectJobResponse.pageToken` returned by a previous list request. ||
|| filter | **string**

restrictions:
* only `status` field is supported
* only `IN` operator is supported
example:
* only running jobs == "status IN (EXECUTING, UPLOADING_OUTPUT)" ||
|#

## ListProjectJobResponse {#yandex.cloud.datasphere.v2.jobs.ListProjectJobResponse}

```json
{
  "jobs": [
    {
      "id": "string",
      "name": "string",
      "desc": "string",
      "createdAt": "google.protobuf.Timestamp",
      "finishedAt": "google.protobuf.Timestamp",
      "status": "JobStatus",
      "config": "string",
      "createdById": "string",
      "projectId": "string",
      "jobParameters": {
        "inputFiles": [
          {
            "desc": {
              "path": "string",
              "var": "string"
            },
            "sha256": "string",
            "sizeBytes": "int64",
            "compressionType": "FileCompressionType"
          }
        ],
        "outputFiles": [
          {
            "path": "string",
            "var": "string"
          }
        ],
        "s3MountIds": [
          "string"
        ],
        "datasetIds": [
          "string"
        ],
        "cmd": "string",
        "env": {
          "vars": "string",
          // Includes only one of the fields `dockerImageResourceId`, `dockerImageSpec`
          "dockerImageResourceId": "string",
          "dockerImageSpec": {
            "imageUrl": "string",
            "username": "string",
            // Includes only one of the fields `passwordPlainText`, `passwordDsSecretName`
            "passwordPlainText": "string",
            "passwordDsSecretName": "string"
            // end of the list of possible fields
          },
          // end of the list of possible fields
          "pythonEnv": {
            "condaYaml": "string",
            "localModules": [
              {
                "desc": {
                  "path": "string",
                  "var": "string"
                },
                "sha256": "string",
                "sizeBytes": "int64",
                "compressionType": "FileCompressionType"
              }
            ],
            "pythonVersion": "string",
            "requirements": [
              "string"
            ],
            "pipOptions": {
              "indexUrl": "string",
              "extraIndexUrls": [
                "string"
              ],
              "trustedHosts": [
                "string"
              ],
              "noDeps": "bool"
            }
          }
        },
        "attachProjectDisk": "bool",
        "cloudInstanceTypes": [
          {
            "name": "string"
          }
        ],
        "extendedWorkingStorage": {
          "type": "StorageType",
          "sizeGb": "int64"
        },
        "arguments": [
          {
            "name": "string",
            "value": "string"
          }
        ],
        "outputDatasets": [
          {
            "name": "string",
            "description": "string",
            "labels": "string",
            "sizeGb": "int64",
            "var": "string"
          }
        ],
        "gracefulShutdownParameters": {
          "timeout": "google.protobuf.Duration",
          "signal": "int64"
        }
      },
      "dataExpiresAt": "google.protobuf.Timestamp",
      "dataCleared": "bool",
      "outputFiles": [
        {
          "desc": {
            "path": "string",
            "var": "string"
          },
          "sha256": "string",
          "sizeBytes": "int64",
          "compressionType": "FileCompressionType"
        }
      ],
      "logFiles": [
        {
          "desc": {
            "path": "string",
            "var": "string"
          },
          "sha256": "string",
          "sizeBytes": "int64",
          "compressionType": "FileCompressionType"
        }
      ],
      "diagnosticFiles": [
        {
          "desc": {
            "path": "string",
            "var": "string"
          },
          "sha256": "string",
          "sizeBytes": "int64",
          "compressionType": "FileCompressionType"
        }
      ],
      "dataSizeBytes": "int64",
      "startedAt": "google.protobuf.Timestamp",
      "statusDetails": "string",
      "actualCloudInstanceType": {
        "name": "string"
      },
      "parentJobId": "string",
      "fileErrors": [
        {
          // Includes only one of the fields `outputFileDesc`, `logFileName`
          "outputFileDesc": {
            "path": "string",
            "var": "string"
          },
          "logFileName": "string",
          // end of the list of possible fields
          "description": "string"
        }
      ],
      "outputDatasets": [
        {
          "desc": {
            "name": "string",
            "description": "string",
            "labels": "string",
            "sizeGb": "int64",
            "var": "string"
          },
          "id": "string"
        }
      ]
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| jobs[] | **[Job](#yandex.cloud.datasphere.v2.jobs.Job)**

Instances of the jobs. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListProjectJobRequest.pageSize](#yandex.cloud.datasphere.v2.jobs.ListProjectJobRequest), use
the `nextPageToken` as the value
for the [ListProjectJobRequest.pageToken](#yandex.cloud.datasphere.v2.jobs.ListProjectJobRequest) query parameter
in the next list request. Each subsequent list request will have its own
[pageToken](#yandex.cloud.datasphere.v2.jobs.ListProjectJobRequest) to continue paging through the results. ||
|#

## Job {#yandex.cloud.datasphere.v2.jobs.Job}

Instance of the job.

#|
||Field | Description ||
|| id | **string**

ID of the job. ||
|| name | **string**

Name of the job. ||
|| desc | **string**

Description of the job. ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Create job timestamp. ||
|| finishedAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

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
- `CANCELLING` ||
|| config | **string**

Config of the job, copied from configuration file. ||
|| createdById | **string**

ID of the user who created the job. ||
|| projectId | **string**

ID of the project. ||
|| jobParameters | **[JobParameters](#yandex.cloud.datasphere.v2.jobs.JobParameters)** ||
|| dataExpiresAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Job data expiration timestamp. ||
|| dataCleared | **bool**

Marks if the job data has been cleared. ||
|| outputFiles[] | **[File](#yandex.cloud.datasphere.v2.jobs.File)**

Output files of the job. ||
|| logFiles[] | **[File](#yandex.cloud.datasphere.v2.jobs.File)**

Job log files. ||
|| diagnosticFiles[] | **[File](#yandex.cloud.datasphere.v2.jobs.File)**

Job diagnostics files. ||
|| dataSizeBytes | **int64**

Job total data size. ||
|| startedAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Start job timestamp. ||
|| statusDetails | **string**

Details. ||
|| actualCloudInstanceType | **[CloudInstanceType](#yandex.cloud.datasphere.v2.jobs.CloudInstanceType)**

Actual VM instance type, job is running on. ||
|| parentJobId | **string**

Reference to the parent job. ||
|| fileErrors[] | **[FileUploadError](#yandex.cloud.datasphere.v2.jobs.FileUploadError)**

Failed uploads. ||
|| outputDatasets[] | **[OutputDataset](#yandex.cloud.datasphere.v2.jobs.OutputDataset)**

Created datasets. ||
|#

## JobParameters {#yandex.cloud.datasphere.v2.jobs.JobParameters}

Job parameters.

#|
||Field | Description ||
|| inputFiles[] | **[File](#yandex.cloud.datasphere.v2.jobs.File)**

List of input files. ||
|| outputFiles[] | **[FileDesc](#yandex.cloud.datasphere.v2.jobs.FileDesc)**

List of output files descriptions. ||
|| s3MountIds[] | **string**

List of DataSphere S3 mount ids. ||
|| datasetIds[] | **string**

List of DataSphere dataset ids. ||
|| cmd | **string**

Job run command. ||
|| env | **[Environment](#yandex.cloud.datasphere.v2.jobs.Environment)**

Job environment description. ||
|| attachProjectDisk | **bool**

Should project disk be attached to VM. ||
|| cloudInstanceTypes[] | **[CloudInstanceType](#yandex.cloud.datasphere.v2.jobs.CloudInstanceType)**

VM specification. ||
|| extendedWorkingStorage | **[ExtendedWorkingStorage](#yandex.cloud.datasphere.v2.jobs.ExtendedWorkingStorage)**

Extended working storage configuration. ||
|| arguments[] | **[Argument](#yandex.cloud.datasphere.v2.jobs.Argument)**

List of literal arguments. ||
|| outputDatasets[] | **[OutputDatasetDesc](#yandex.cloud.datasphere.v2.jobs.OutputDatasetDesc)**

List of DataSets descriptions to create. ||
|| gracefulShutdownParameters | **[GracefulShutdownParameters](#yandex.cloud.datasphere.v2.jobs.GracefulShutdownParameters)**

Graceful shutdown settings. ||
|#

## File {#yandex.cloud.datasphere.v2.jobs.File}

#|
||Field | Description ||
|| desc | **[FileDesc](#yandex.cloud.datasphere.v2.jobs.FileDesc)** ||
|| sha256 | **string**

SHA256 of the file. ||
|| sizeBytes | **int64**

File size in bytes. ||
|| compressionType | enum **FileCompressionType**

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
|| dockerImageResourceId | **string**

DS docker image id.

Includes only one of the fields `dockerImageResourceId`, `dockerImageSpec`. ||
|| dockerImageSpec | **[DockerImageSpec](#yandex.cloud.datasphere.v2.jobs.DockerImageSpec)**

Includes only one of the fields `dockerImageResourceId`, `dockerImageSpec`. ||
|| pythonEnv | **[PythonEnv](#yandex.cloud.datasphere.v2.jobs.PythonEnv)** ||
|#

## DockerImageSpec {#yandex.cloud.datasphere.v2.jobs.DockerImageSpec}

#|
||Field | Description ||
|| imageUrl | **string**

Docker image URL. ||
|| username | **string**

Username for container registry. ||
|| passwordPlainText | **string**

Plaintext password.

Includes only one of the fields `passwordPlainText`, `passwordDsSecretName`.

Password for container registry. ||
|| passwordDsSecretName | **string**

ID of DataSphere secret containing password.

Includes only one of the fields `passwordPlainText`, `passwordDsSecretName`.

Password for container registry. ||
|#

## PythonEnv {#yandex.cloud.datasphere.v2.jobs.PythonEnv}

#|
||Field | Description ||
|| condaYaml | **string**

Conda YAML. ||
|| localModules[] | **[File](#yandex.cloud.datasphere.v2.jobs.File)**

List of local modules descriptions. ||
|| pythonVersion | **string**

Python version reduced to major.minor ||
|| requirements[] | **string**

List of pip requirements ||
|| pipOptions | **[PipOptions](#yandex.cloud.datasphere.v2.jobs.PipOptions)**

Pip install options ||
|#

## PipOptions {#yandex.cloud.datasphere.v2.jobs.PipOptions}

#|
||Field | Description ||
|| indexUrl | **string**

--index-url option ||
|| extraIndexUrls[] | **string**

--extra-index-urls option ||
|| trustedHosts[] | **string**

--trusted-hosts option ||
|| noDeps | **bool**

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
|| sizeGb | **int64** ||
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
|| sizeGb | **int64**

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

## FileUploadError {#yandex.cloud.datasphere.v2.jobs.FileUploadError}

#|
||Field | Description ||
|| outputFileDesc | **[FileDesc](#yandex.cloud.datasphere.v2.jobs.FileDesc)**

Includes only one of the fields `outputFileDesc`, `logFileName`. ||
|| logFileName | **string**

Includes only one of the fields `outputFileDesc`, `logFileName`. ||
|| description | **string** ||
|#

## OutputDataset {#yandex.cloud.datasphere.v2.jobs.OutputDataset}

#|
||Field | Description ||
|| desc | **[OutputDatasetDesc](#yandex.cloud.datasphere.v2.jobs.OutputDatasetDesc)**

Dataset description ||
|| id | **string**

Id of created dataset ||
|#