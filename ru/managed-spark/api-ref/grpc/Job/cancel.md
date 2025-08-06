---
editable: false
sourcePath: en/_api-ref-grpc/spark/v1/api-ref/grpc/Job/cancel.md
---

# Managed Spark API, gRPC: JobService.Cancel

Cancels the specified Spark job.

## gRPC request

**rpc Cancel ([CancelJobRequest](#yandex.cloud.spark.v1.CancelJobRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## CancelJobRequest {#yandex.cloud.spark.v1.CancelJobRequest}

```json
{
  "cluster_id": "string",
  "job_id": "string"
}
```

#|
||Field | Description ||
|| cluster_id | **string**

Required field. ID of the Spark cluster. ||
|| job_id | **string**

Required field. ID of the Spark job to cancel. ||
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
    "cluster_id": "string",
    "job_id": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "string",
    "cluster_id": "string",
    "created_at": "google.protobuf.Timestamp",
    "started_at": "google.protobuf.Timestamp",
    "finished_at": "google.protobuf.Timestamp",
    "name": "string",
    "created_by": "string",
    "status": "Status",
    // Includes only one of the fields `spark_job`, `pyspark_job`
    "spark_job": {
      "args": [
        "string"
      ],
      "jar_file_uris": [
        "string"
      ],
      "file_uris": [
        "string"
      ],
      "archive_uris": [
        "string"
      ],
      "properties": "map<string, string>",
      "main_jar_file_uri": "string",
      "main_class": "string",
      "packages": [
        "string"
      ],
      "repositories": [
        "string"
      ],
      "exclude_packages": [
        "string"
      ]
    },
    "pyspark_job": {
      "args": [
        "string"
      ],
      "jar_file_uris": [
        "string"
      ],
      "file_uris": [
        "string"
      ],
      "archive_uris": [
        "string"
      ],
      "properties": "map<string, string>",
      "main_python_file_uri": "string",
      "python_file_uris": [
        "string"
      ],
      "packages": [
        "string"
      ],
      "repositories": [
        "string"
      ],
      "exclude_packages": [
        "string"
      ]
    },
    // end of the list of possible fields
    "ui_url": "string"
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
|| metadata | **[CreateJobMetadata](#yandex.cloud.spark.v1.CreateJobMetadata)**

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
|| response | **[Job](#yandex.cloud.spark.v1.Job)**

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

## CreateJobMetadata {#yandex.cloud.spark.v1.CreateJobMetadata}

#|
||Field | Description ||
|| cluster_id | **string**

Required field. ID of the Spark cluster. ||
|| job_id | **string**

ID of the Spark job. ||
|#

## Job {#yandex.cloud.spark.v1.Job}

Spark job.

#|
||Field | Description ||
|| id | **string**

Required. Unique ID of the Spark job.
This ID is assigned by MDB in the process of creating Spark job. ||
|| cluster_id | **string**

Required. Unique ID of the Spark cluster. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Spark job was created. ||
|| started_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Spark job was started. ||
|| finished_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Spark job was finished. ||
|| name | **string**

Name of the Spark job. ||
|| created_by | **string**

The id of the user who created the job ||
|| status | enum **Status**

Status.

- `STATUS_UNSPECIFIED`
- `PROVISIONING`: Job created and is waiting to acquire.
- `PENDING`: Job acquired and is waiting for execution.
- `RUNNING`: Job is running.
- `ERROR`: Job failed.
- `DONE`: Job finished.
- `CANCELLED`: Job cancelled.
- `CANCELLING`: Job is waiting for cancellation. ||
|| spark_job | **[SparkJob](#yandex.cloud.spark.v1.SparkJob)**

Includes only one of the fields `spark_job`, `pyspark_job`.

Job specification. ||
|| pyspark_job | **[PysparkJob](#yandex.cloud.spark.v1.PysparkJob)**

Includes only one of the fields `spark_job`, `pyspark_job`.

Job specification. ||
|| ui_url | **string**

Spark UI Url. ||
|#

## SparkJob {#yandex.cloud.spark.v1.SparkJob}

#|
||Field | Description ||
|| args[] | **string**

Optional arguments to pass to the driver. ||
|| jar_file_uris[] | **string**

Jar file URIs to add to the CLASSPATHs of the Spark driver and tasks. ||
|| file_uris[] | **string**

URIs of files to be copied to the working directory of Spark drivers and distributed tasks. ||
|| archive_uris[] | **string**

URIs of archives to be extracted in the working directory of Spark drivers and tasks. ||
|| properties | **object** (map<**string**, **string**>)

A mapping of property names to values, used to configure Spark. ||
|| main_jar_file_uri | **string**

URI of the jar file containing the main class. ||
|| main_class | **string**

The name of the driver's main class. ||
|| packages[] | **string**

List of maven coordinates of jars to include on the driver and executor classpaths. ||
|| repositories[] | **string**

List of additional remote repositories to search for the maven coordinates given with --packages. ||
|| exclude_packages[] | **string**

List of groupId:artifactId, to exclude while resolving the dependencies provided in --packages to avoid dependency conflicts. ||
|#

## PysparkJob {#yandex.cloud.spark.v1.PysparkJob}

#|
||Field | Description ||
|| args[] | **string**

Optional arguments to pass to the driver. ||
|| jar_file_uris[] | **string**

Jar file URIs to add to the CLASSPATHs of the Spark driver and tasks. ||
|| file_uris[] | **string**

URIs of files to be copied to the working directory of Spark drivers and distributed tasks. ||
|| archive_uris[] | **string**

URIs of archives to be extracted in the working directory of Spark drivers and tasks. ||
|| properties | **object** (map<**string**, **string**>)

A mapping of property names to values, used to configure Spark. ||
|| main_python_file_uri | **string**

URI of the main Python file to use as the driver. Must be a .py file. ||
|| python_file_uris[] | **string**

URIs of Python files to pass to the PySpark framework. ||
|| packages[] | **string**

List of maven coordinates of jars to include on the driver and executor classpaths. ||
|| repositories[] | **string**

List of additional remote repositories to search for the maven coordinates given with --packages. ||
|| exclude_packages[] | **string**

List of groupId:artifactId, to exclude while resolving the dependencies provided in --packages to avoid dependency conflicts. ||
|#