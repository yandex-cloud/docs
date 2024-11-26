---
editable: false
sourcePath: en/_api-ref-grpc/dataproc/v1/api-ref/grpc/Job/get.md
---

# Data Proc API, gRPC: JobService.Get

Returns the specified job.

## gRPC request

**rpc Get ([GetJobRequest](#yandex.cloud.dataproc.v1.GetJobRequest)) returns ([Job](#yandex.cloud.dataproc.v1.Job))**

## GetJobRequest {#yandex.cloud.dataproc.v1.GetJobRequest}

```json
{
  "cluster_id": "string",
  "job_id": "string"
}
```

#|
||Field | Description ||
|| cluster_id | **string**

Required field. ID of the cluster to request a job from. ||
|| job_id | **string**

Required field. ID of the job to return.

To get a job ID make a [JobService.List](/docs/data-proc/api-ref/grpc/Job/list#List) request. ||
|#

## Job {#yandex.cloud.dataproc.v1.Job}

```json
{
  "id": "string",
  "cluster_id": "string",
  "created_at": "google.protobuf.Timestamp",
  "started_at": "google.protobuf.Timestamp",
  "finished_at": "google.protobuf.Timestamp",
  "name": "string",
  "created_by": "string",
  "status": "Status",
  // Includes only one of the fields `mapreduce_job`, `spark_job`, `pyspark_job`, `hive_job`
  "mapreduce_job": {
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
    "properties": "string",
    // Includes only one of the fields `main_jar_file_uri`, `main_class`
    "main_jar_file_uri": "string",
    "main_class": "string"
    // end of the list of possible fields
  },
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
    "properties": "string",
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
    "properties": "string",
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
  "hive_job": {
    "properties": "string",
    "continue_on_failure": "bool",
    "script_variables": "string",
    "jar_file_uris": [
      "string"
    ],
    // Includes only one of the fields `query_file_uri`, `query_list`
    "query_file_uri": "string",
    "query_list": {
      "queries": [
        "string"
      ]
    }
    // end of the list of possible fields
  },
  // end of the list of possible fields
  "application_info": {
    "id": "string",
    "application_attempts": [
      {
        "id": "string",
        "am_container_id": "string"
      }
    ]
  }
}
```

A Data Proc job. For details about the concept, see [documentation](/docs/data-proc/concepts/jobs).

#|
||Field | Description ||
|| id | **string**

ID of the job. Generated at creation time. ||
|| cluster_id | **string**

ID of the Data Proc cluster that the job belongs to. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| started_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the job was started. ||
|| finished_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the job was finished. ||
|| name | **string**

Name of the job, specified in the [JobService.Create](/docs/data-proc/api-ref/grpc/Job/create#Create) request. ||
|| created_by | **string**

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
|| mapreduce_job | **[MapreduceJob](#yandex.cloud.dataproc.v1.MapreduceJob)**

Specification for a MapReduce job.

Includes only one of the fields `mapreduce_job`, `spark_job`, `pyspark_job`, `hive_job`.

Specification for the job. ||
|| spark_job | **[SparkJob](#yandex.cloud.dataproc.v1.SparkJob)**

Specification for a Spark job.

Includes only one of the fields `mapreduce_job`, `spark_job`, `pyspark_job`, `hive_job`.

Specification for the job. ||
|| pyspark_job | **[PysparkJob](#yandex.cloud.dataproc.v1.PysparkJob)**

Specification for a PySpark job.

Includes only one of the fields `mapreduce_job`, `spark_job`, `pyspark_job`, `hive_job`.

Specification for the job. ||
|| hive_job | **[HiveJob](#yandex.cloud.dataproc.v1.HiveJob)**

Specification for a Hive job.

Includes only one of the fields `mapreduce_job`, `spark_job`, `pyspark_job`, `hive_job`.

Specification for the job. ||
|| application_info | **[ApplicationInfo](#yandex.cloud.dataproc.v1.ApplicationInfo)**

Attributes of YARN application. ||
|#

## MapreduceJob {#yandex.cloud.dataproc.v1.MapreduceJob}

#|
||Field | Description ||
|| args[] | **string**

Optional arguments to pass to the driver. ||
|| jar_file_uris[] | **string**

JAR file URIs to add to CLASSPATH of the Data Proc driver and each task. ||
|| file_uris[] | **string**

URIs of resource files to be copied to the working directory of Data Proc drivers
and distributed Hadoop tasks. ||
|| archive_uris[] | **string**

URIs of archives to be extracted to the working directory of Data Proc drivers and tasks. ||
|| properties | **string**

Property names and values, used to configure Data Proc and MapReduce. ||
|| main_jar_file_uri | **string**

HCFS URI of the .jar file containing the driver class.

Includes only one of the fields `main_jar_file_uri`, `main_class`. ||
|| main_class | **string**

The name of the driver class.

Includes only one of the fields `main_jar_file_uri`, `main_class`. ||
|#

## SparkJob {#yandex.cloud.dataproc.v1.SparkJob}

#|
||Field | Description ||
|| args[] | **string**

Optional arguments to pass to the driver. ||
|| jar_file_uris[] | **string**

JAR file URIs to add to CLASSPATH of the Data Proc driver and each task. ||
|| file_uris[] | **string**

URIs of resource files to be copied to the working directory of Data Proc drivers
and distributed Hadoop tasks. ||
|| archive_uris[] | **string**

URIs of archives to be extracted to the working directory of Data Proc drivers and tasks. ||
|| properties | **string**

Property names and values, used to configure Data Proc and Spark. ||
|| main_jar_file_uri | **string**

The HCFS URI of the JAR file containing the `main` class for the job. ||
|| main_class | **string**

The name of the driver class. ||
|| packages[] | **string**

List of maven coordinates of jars to include on the driver and executor classpaths. ||
|| repositories[] | **string**

List of additional remote repositories to search for the maven coordinates given with --packages. ||
|| exclude_packages[] | **string**

List of groupId:artifactId, to exclude while resolving the dependencies provided in --packages to avoid dependency conflicts. ||
|#

## PysparkJob {#yandex.cloud.dataproc.v1.PysparkJob}

#|
||Field | Description ||
|| args[] | **string**

Optional arguments to pass to the driver. ||
|| jar_file_uris[] | **string**

JAR file URIs to add to CLASSPATH of the Data Proc driver and each task. ||
|| file_uris[] | **string**

URIs of resource files to be copied to the working directory of Data Proc drivers
and distributed Hadoop tasks. ||
|| archive_uris[] | **string**

URIs of archives to be extracted to the working directory of Data Proc drivers and tasks. ||
|| properties | **string**

Property names and values, used to configure Data Proc and PySpark. ||
|| main_python_file_uri | **string**

URI of the file with the driver code. Must be a .py file. ||
|| python_file_uris[] | **string**

URIs of Python files to pass to the PySpark framework. ||
|| packages[] | **string**

List of maven coordinates of jars to include on the driver and executor classpaths. ||
|| repositories[] | **string**

List of additional remote repositories to search for the maven coordinates given with --packages. ||
|| exclude_packages[] | **string**

List of groupId:artifactId, to exclude while resolving the dependencies provided in --packages to avoid dependency conflicts. ||
|#

## HiveJob {#yandex.cloud.dataproc.v1.HiveJob}

#|
||Field | Description ||
|| properties | **string**

Property names and values, used to configure Data Proc and Hive. ||
|| continue_on_failure | **bool**

Flag indicating whether a job should continue to run if a query fails. ||
|| script_variables | **string**

Query variables and their values. ||
|| jar_file_uris[] | **string**

JAR file URIs to add to CLASSPATH of the Hive driver and each task. ||
|| query_file_uri | **string**

URI of the script with all the necessary Hive queries.

Includes only one of the fields `query_file_uri`, `query_list`. ||
|| query_list | **[QueryList](#yandex.cloud.dataproc.v1.QueryList)**

List of Hive queries to be used in the job.

Includes only one of the fields `query_file_uri`, `query_list`. ||
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
|| application_attempts[] | **[ApplicationAttempt](#yandex.cloud.dataproc.v1.ApplicationAttempt)**

YARN application attempts ||
|#

## ApplicationAttempt {#yandex.cloud.dataproc.v1.ApplicationAttempt}

#|
||Field | Description ||
|| id | **string**

ID of YARN application attempt ||
|| am_container_id | **string**

ID of YARN Application Master container ||
|#