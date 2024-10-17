---
editable: false
sourcePath: en/_api-ref-grpc/dataproc/v1/api-ref/grpc/Job/cancel.md
---

# Data Proc API, gRPC: JobService.Cancel {#Cancel}

Cancels the specified Dataproc job.

## gRPC request

**rpc Cancel ([CancelJobRequest](#yandex.cloud.dataproc.v1.CancelJobRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## CancelJobRequest {#yandex.cloud.dataproc.v1.CancelJobRequest}

```json
{
  "clusterId": "string",
  "jobId": "string"
}
```

#|
||Field | Description ||
|| clusterId | **string**

Required field. Required. ID of the Dataproc cluster. ||
|| jobId | **string**

Required field. Required. ID of the Dataproc job to cancel. ||
|#

## operation.Operation {#yandex.cloud.operation.Operation}

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "google.protobuf.Timestamp",
  "createdBy": "string",
  "modifiedAt": "google.protobuf.Timestamp",
  "done": "bool",
  "metadata": {
    "clusterId": "string",
    "jobId": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "string",
    "clusterId": "string",
    "createdAt": "google.protobuf.Timestamp",
    "startedAt": "google.protobuf.Timestamp",
    "finishedAt": "google.protobuf.Timestamp",
    "name": "string",
    "createdBy": "string",
    "status": "Status",
    // Includes only one of the fields `mapreduceJob`, `sparkJob`, `pysparkJob`, `hiveJob`
    "mapreduceJob": {
      "args": [
        "string"
      ],
      "jarFileUris": [
        "string"
      ],
      "fileUris": [
        "string"
      ],
      "archiveUris": [
        "string"
      ],
      "properties": "string",
      // Includes only one of the fields `mainJarFileUri`, `mainClass`
      "mainJarFileUri": "string",
      "mainClass": "string"
      // end of the list of possible fields
    },
    "sparkJob": {
      "args": [
        "string"
      ],
      "jarFileUris": [
        "string"
      ],
      "fileUris": [
        "string"
      ],
      "archiveUris": [
        "string"
      ],
      "properties": "string",
      "mainJarFileUri": "string",
      "mainClass": "string",
      "packages": [
        "string"
      ],
      "repositories": [
        "string"
      ],
      "excludePackages": [
        "string"
      ]
    },
    "pysparkJob": {
      "args": [
        "string"
      ],
      "jarFileUris": [
        "string"
      ],
      "fileUris": [
        "string"
      ],
      "archiveUris": [
        "string"
      ],
      "properties": "string",
      "mainPythonFileUri": "string",
      "pythonFileUris": [
        "string"
      ],
      "packages": [
        "string"
      ],
      "repositories": [
        "string"
      ],
      "excludePackages": [
        "string"
      ]
    },
    "hiveJob": {
      "properties": "string",
      "continueOnFailure": "bool",
      "scriptVariables": "string",
      "jarFileUris": [
        "string"
      ],
      // Includes only one of the fields `queryFileUri`, `queryList`
      "queryFileUri": "string",
      "queryList": {
        "queries": [
          "string"
        ]
      }
      // end of the list of possible fields
    },
    // end of the list of possible fields
    "applicationInfo": {
      "id": "string",
      "applicationAttempts": [
        {
          "id": "string",
          "amContainerId": "string"
        }
      ]
    }
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
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[CreateJobMetadata](#yandex.cloud.dataproc.v1.CreateJobMetadata)**

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
|| response | **[Job](#yandex.cloud.dataproc.v1.Job)**

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

## CreateJobMetadata {#yandex.cloud.dataproc.v1.CreateJobMetadata}

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the cluster that the job is being created for. ||
|| jobId | **string**

ID of the job being created. ||
|#

## Job {#yandex.cloud.dataproc.v1.Job}

A Data Proc job. For details about the concept, see [documentation](/docs/data-proc/concepts/jobs).

#|
||Field | Description ||
|| id | **string**

ID of the job. Generated at creation time. ||
|| clusterId | **string**

ID of the Data Proc cluster that the job belongs to. ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| startedAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the job was started. ||
|| finishedAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the job was finished. ||
|| name | **string**

Name of the job, specified in the [JobService.Create](/docs/data-proc/api-ref/grpc/Job/create#Create) request. ||
|| createdBy | **string**

The id of the user who created the job ||
|| status | enum **Status**

Job status.

- `STATUS_UNSPECIFIED`
- `PROVISIONING`: Job is logged in the database and is waiting for the agent to run it.
- `PENDING`: Job is acquired by the agent and is in the queue for execution.
- `RUNNING`: Job is being run in the cluster.
- `ERROR`: Job failed to finish the run properly.
- `DONE`: Job is finished.
- `CANCELLED`: Job is cancelled.
- `CANCELLING`: Job is waiting for cancellation. ||
|| mapreduceJob | **[MapreduceJob](#yandex.cloud.dataproc.v1.MapreduceJob)**

Specification for a MapReduce job.

Includes only one of the fields `mapreduceJob`, `sparkJob`, `pysparkJob`, `hiveJob`.

Specification for the job. ||
|| sparkJob | **[SparkJob](#yandex.cloud.dataproc.v1.SparkJob)**

Specification for a Spark job.

Includes only one of the fields `mapreduceJob`, `sparkJob`, `pysparkJob`, `hiveJob`.

Specification for the job. ||
|| pysparkJob | **[PysparkJob](#yandex.cloud.dataproc.v1.PysparkJob)**

Specification for a PySpark job.

Includes only one of the fields `mapreduceJob`, `sparkJob`, `pysparkJob`, `hiveJob`.

Specification for the job. ||
|| hiveJob | **[HiveJob](#yandex.cloud.dataproc.v1.HiveJob)**

Specification for a Hive job.

Includes only one of the fields `mapreduceJob`, `sparkJob`, `pysparkJob`, `hiveJob`.

Specification for the job. ||
|| applicationInfo | **[ApplicationInfo](#yandex.cloud.dataproc.v1.ApplicationInfo)**

Attributes of YARN application. ||
|#

## MapreduceJob {#yandex.cloud.dataproc.v1.MapreduceJob}

#|
||Field | Description ||
|| args[] | **string**

Optional arguments to pass to the driver. ||
|| jarFileUris[] | **string**

JAR file URIs to add to CLASSPATH of the Data Proc driver and each task. ||
|| fileUris[] | **string**

URIs of resource files to be copied to the working directory of Data Proc drivers
and distributed Hadoop tasks. ||
|| archiveUris[] | **string**

URIs of archives to be extracted to the working directory of Data Proc drivers and tasks. ||
|| properties | **string**

Property names and values, used to configure Data Proc and MapReduce. ||
|| mainJarFileUri | **string**

HCFS URI of the .jar file containing the driver class.

Includes only one of the fields `mainJarFileUri`, `mainClass`. ||
|| mainClass | **string**

The name of the driver class.

Includes only one of the fields `mainJarFileUri`, `mainClass`. ||
|#

## SparkJob {#yandex.cloud.dataproc.v1.SparkJob}

#|
||Field | Description ||
|| args[] | **string**

Optional arguments to pass to the driver. ||
|| jarFileUris[] | **string**

JAR file URIs to add to CLASSPATH of the Data Proc driver and each task. ||
|| fileUris[] | **string**

URIs of resource files to be copied to the working directory of Data Proc drivers
and distributed Hadoop tasks. ||
|| archiveUris[] | **string**

URIs of archives to be extracted to the working directory of Data Proc drivers and tasks. ||
|| properties | **string**

Property names and values, used to configure Data Proc and Spark. ||
|| mainJarFileUri | **string**

The HCFS URI of the JAR file containing the `main` class for the job. ||
|| mainClass | **string**

The name of the driver class. ||
|| packages[] | **string**

List of maven coordinates of jars to include on the driver and executor classpaths. ||
|| repositories[] | **string**

List of additional remote repositories to search for the maven coordinates given with --packages. ||
|| excludePackages[] | **string**

List of groupId:artifactId, to exclude while resolving the dependencies provided in --packages to avoid dependency conflicts. ||
|#

## PysparkJob {#yandex.cloud.dataproc.v1.PysparkJob}

#|
||Field | Description ||
|| args[] | **string**

Optional arguments to pass to the driver. ||
|| jarFileUris[] | **string**

JAR file URIs to add to CLASSPATH of the Data Proc driver and each task. ||
|| fileUris[] | **string**

URIs of resource files to be copied to the working directory of Data Proc drivers
and distributed Hadoop tasks. ||
|| archiveUris[] | **string**

URIs of archives to be extracted to the working directory of Data Proc drivers and tasks. ||
|| properties | **string**

Property names and values, used to configure Data Proc and PySpark. ||
|| mainPythonFileUri | **string**

URI of the file with the driver code. Must be a .py file. ||
|| pythonFileUris[] | **string**

URIs of Python files to pass to the PySpark framework. ||
|| packages[] | **string**

List of maven coordinates of jars to include on the driver and executor classpaths. ||
|| repositories[] | **string**

List of additional remote repositories to search for the maven coordinates given with --packages. ||
|| excludePackages[] | **string**

List of groupId:artifactId, to exclude while resolving the dependencies provided in --packages to avoid dependency conflicts. ||
|#

## HiveJob {#yandex.cloud.dataproc.v1.HiveJob}

#|
||Field | Description ||
|| properties | **string**

Property names and values, used to configure Data Proc and Hive. ||
|| continueOnFailure | **bool**

Flag indicating whether a job should continue to run if a query fails. ||
|| scriptVariables | **string**

Query variables and their values. ||
|| jarFileUris[] | **string**

JAR file URIs to add to CLASSPATH of the Hive driver and each task. ||
|| queryFileUri | **string**

URI of the script with all the necessary Hive queries.

Includes only one of the fields `queryFileUri`, `queryList`. ||
|| queryList | **[QueryList](#yandex.cloud.dataproc.v1.QueryList)**

List of Hive queries to be used in the job.

Includes only one of the fields `queryFileUri`, `queryList`. ||
|#

## QueryList {#yandex.cloud.dataproc.v1.QueryList}

#|
||Field | Description ||
|| queries[] | **string**

List of Hive queries. ||
|#

## ApplicationInfo {#yandex.cloud.dataproc.v1.ApplicationInfo}

#|
||Field | Description ||
|| id | **string**

ID of YARN application ||
|| applicationAttempts[] | **[ApplicationAttempt](#yandex.cloud.dataproc.v1.ApplicationAttempt)**

YARN application attempts ||
|#

## ApplicationAttempt {#yandex.cloud.dataproc.v1.ApplicationAttempt}

#|
||Field | Description ||
|| id | **string**

ID of YARN application attempt ||
|| amContainerId | **string**

ID of YARN Application Master container ||
|#