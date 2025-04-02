---
editable: false
sourcePath: en/_api-ref/dataproc/v1/api-ref/Job/cancel.md
---

# Yandex Data Processing API, REST: Job.Cancel

Cancels the specified Yandex Data Processing job.

## HTTP request

```
POST https://dataproc.{{ api-host }}/dataproc/v1/clusters/{clusterId}/jobs/{jobId}:cancel
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. Required. ID of the Yandex Data Processing cluster. ||
|| jobId | **string**

Required field. Required. ID of the Yandex Data Processing job to cancel. ||
|#

## Response {#yandex.cloud.operation.Operation}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": "boolean",
  "metadata": {
    "clusterId": "string",
    "jobId": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": {
    "id": "string",
    "clusterId": "string",
    "createdAt": "string",
    "startedAt": "string",
    "finishedAt": "string",
    "name": "string",
    "createdBy": "string",
    "status": "string",
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
      "properties": "object",
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
      "properties": "object",
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
      "properties": "object",
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
      "properties": "object",
      "continueOnFailure": "boolean",
      "scriptVariables": "object",
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
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **string** (date-time)

The time when the Operation resource was last modified.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| done | **boolean**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[CreateJobMetadata](#yandex.cloud.dataproc.v1.CreateJobMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[Status](#google.rpc.Status)**

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

## Status {#google.rpc.Status}

The error result of the operation in case of failure or cancellation.

#|
||Field | Description ||
|| code | **integer** (int32)

Error code. An enum value of [google.rpc.Code](https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto). ||
|| message | **string**

An error message. ||
|| details[] | **object**

A list of messages that carry the error details. ||
|#

## Job {#yandex.cloud.dataproc.v1.Job}

A Yandex Data Processing job. For details about the concept, see [documentation](/docs/data-proc/concepts/jobs).

#|
||Field | Description ||
|| id | **string**

ID of the job. Generated at creation time. ||
|| clusterId | **string**

ID of the Yandex Data Processing cluster that the job belongs to. ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| startedAt | **string** (date-time)

The time when the job was started.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| finishedAt | **string** (date-time)

The time when the job was finished.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| name | **string**

Name of the job, specified in the [JobService.Create](/docs/data-proc/api-ref/Job/create#Create) request. ||
|| createdBy | **string**

The id of the user who created the job ||
|| status | **enum** (Status)

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

JAR file URIs to add to CLASSPATH of the Yandex Data Processing driver and each task. ||
|| fileUris[] | **string**

URIs of resource files to be copied to the working directory of Yandex Data Processing drivers
and distributed Hadoop tasks. ||
|| archiveUris[] | **string**

URIs of archives to be extracted to the working directory of Yandex Data Processing drivers and tasks. ||
|| properties | **object** (map<**string**, **string**>)

Property names and values, used to configure Yandex Data Processing and MapReduce. ||
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

JAR file URIs to add to CLASSPATH of the Yandex Data Processing driver and each task. ||
|| fileUris[] | **string**

URIs of resource files to be copied to the working directory of Yandex Data Processing drivers
and distributed Hadoop tasks. ||
|| archiveUris[] | **string**

URIs of archives to be extracted to the working directory of Yandex Data Processing drivers and tasks. ||
|| properties | **object** (map<**string**, **string**>)

Property names and values, used to configure Yandex Data Processing and Spark. ||
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

JAR file URIs to add to CLASSPATH of the Yandex Data Processing driver and each task. ||
|| fileUris[] | **string**

URIs of resource files to be copied to the working directory of Yandex Data Processing drivers
and distributed Hadoop tasks. ||
|| archiveUris[] | **string**

URIs of archives to be extracted to the working directory of Yandex Data Processing drivers and tasks. ||
|| properties | **object** (map<**string**, **string**>)

Property names and values, used to configure Yandex Data Processing and PySpark. ||
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
|| properties | **object** (map<**string**, **string**>)

Property names and values, used to configure Yandex Data Processing and Hive. ||
|| continueOnFailure | **boolean**

Flag indicating whether a job should continue to run if a query fails. ||
|| scriptVariables | **object** (map<**string**, **string**>)

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