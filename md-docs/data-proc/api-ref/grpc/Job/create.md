[Документация Yandex Cloud](../../../../index.md) > [Yandex Data Processing](../../../index.md) > Справочник API > [gRPC (англ.)](../index.md) > [Job](index.md) > Create

# Yandex Data Processing API, gRPC: JobService.Create

Creates a job for a cluster.

## gRPC request

**rpc Create ([CreateJobRequest](#yandex.cloud.dataproc.v1.CreateJobRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## CreateJobRequest {#yandex.cloud.dataproc.v1.CreateJobRequest}

```json
{
  "cluster_id": "string",
  "name": "string",
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
    "properties": "map<string, string>",
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
  "hive_job": {
    "properties": "map<string, string>",
    "continue_on_failure": "bool",
    "script_variables": "map<string, string>",
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
  }
  // end of the list of possible fields
}
```

#|
||Field | Description ||
|| cluster_id | **string**

Required field. ID of the cluster to create a job for.

The maximum string length in characters is 50. ||
|| name | **string**

Name of the job.

The string length in characters must be less than 256. Value must match the regular expression ``` |[a-z][-a-z0-9]{1,61}[a-z0-9] ```. ||
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
|#

## MapreduceJob {#yandex.cloud.dataproc.v1.MapreduceJob}

#|
||Field | Description ||
|| args[] | **string**

Optional arguments to pass to the driver.

The maximum string length in characters for each value is 1024. The maximum number of elements is 32. ||
|| jar_file_uris[] | **string**

JAR file URIs to add to CLASSPATH of the Yandex Data Processing driver and each task.

The string length in characters for each value must be less than 2048. The maximum number of elements is 100. ||
|| file_uris[] | **string**

URIs of resource files to be copied to the working directory of Yandex Data Processing drivers
and distributed Hadoop tasks.

The string length in characters for each value must be less than 2048. The maximum number of elements is 100. ||
|| archive_uris[] | **string**

URIs of archives to be extracted to the working directory of Yandex Data Processing drivers and tasks.

The string length in characters for each value must be less than 2048. The maximum number of elements is 100. ||
|| properties | **object** (map<**string**, **string**>)

Property names and values, used to configure Yandex Data Processing and MapReduce.

The maximum string length in characters for each value is 256. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-zA-Z][-_0-9a-zA-Z.]* `. No more than 100 per resource. ||
|| main_jar_file_uri | **string**

HCFS URI of the .jar file containing the driver class.

The string length in characters must be less than 2048.

Includes only one of the fields `main_jar_file_uri`, `main_class`. ||
|| main_class | **string**

The name of the driver class.

The string length in characters must be less than 256.

Includes only one of the fields `main_jar_file_uri`, `main_class`. ||
|#

## SparkJob {#yandex.cloud.dataproc.v1.SparkJob}

#|
||Field | Description ||
|| args[] | **string**

Optional arguments to pass to the driver.

The maximum string length in characters for each value is 10000. The maximum number of elements is 256. ||
|| jar_file_uris[] | **string**

JAR file URIs to add to CLASSPATH of the Yandex Data Processing driver and each task.

The string length in characters for each value must be less than 2048. The maximum number of elements is 100. ||
|| file_uris[] | **string**

URIs of resource files to be copied to the working directory of Yandex Data Processing drivers
and distributed Hadoop tasks.

The string length in characters for each value must be less than 2048. The maximum number of elements is 100. ||
|| archive_uris[] | **string**

URIs of archives to be extracted to the working directory of Yandex Data Processing drivers and tasks.

The string length in characters for each value must be less than 2048. The maximum number of elements is 100. ||
|| properties | **object** (map<**string**, **string**>)

Property names and values, used to configure Yandex Data Processing and Spark.

The maximum string length in characters for each value is 256. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-zA-Z][-_0-9a-zA-Z.]* `. No more than 100 per resource. ||
|| main_jar_file_uri | **string**

Required field. The HCFS URI of the JAR file containing the `main` class for the job.

The string length in characters must be less than 2048. ||
|| main_class | **string**

The name of the driver class.

The string length in characters must be less than 256. ||
|| packages[] | **string**

List of maven coordinates of jars to include on the driver and executor classpaths.

The string length in characters for each value must be less than 256. The maximum number of elements is 100. ||
|| repositories[] | **string**

List of additional remote repositories to search for the maven coordinates given with --packages.

The string length in characters for each value must be less than 2048. The maximum number of elements is 10. ||
|| exclude_packages[] | **string**

List of groupId:artifactId, to exclude while resolving the dependencies provided in --packages to avoid dependency conflicts.

The string length in characters for each value must be less than 256. The maximum number of elements is 100. ||
|#

## PysparkJob {#yandex.cloud.dataproc.v1.PysparkJob}

#|
||Field | Description ||
|| args[] | **string**

Optional arguments to pass to the driver.

The maximum string length in characters for each value is 100000. The maximum number of elements is 2500. ||
|| jar_file_uris[] | **string**

JAR file URIs to add to CLASSPATH of the Yandex Data Processing driver and each task.

The string length in characters for each value must be less than 2048. The maximum number of elements is 100. ||
|| file_uris[] | **string**

URIs of resource files to be copied to the working directory of Yandex Data Processing drivers
and distributed Hadoop tasks.

The string length in characters for each value must be less than 2048. The maximum number of elements is 100. ||
|| archive_uris[] | **string**

URIs of archives to be extracted to the working directory of Yandex Data Processing drivers and tasks.

The string length in characters for each value must be less than 2048. The maximum number of elements is 100. ||
|| properties | **object** (map<**string**, **string**>)

Property names and values, used to configure Yandex Data Processing and PySpark.

The maximum string length in characters for each value is 10000. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-zA-Z][-_0-9a-zA-Z.]* `. No more than 100 per resource. ||
|| main_python_file_uri | **string**

Required field. URI of the file with the driver code. Must be a .py file.

The string length in characters must be less than 2048. ||
|| python_file_uris[] | **string**

URIs of Python files to pass to the PySpark framework.

The string length in characters for each value must be less than 2048. The maximum number of elements is 100. ||
|| packages[] | **string**

List of maven coordinates of jars to include on the driver and executor classpaths.

The string length in characters for each value must be less than 256. The maximum number of elements is 100. ||
|| repositories[] | **string**

List of additional remote repositories to search for the maven coordinates given with --packages.

The string length in characters for each value must be less than 2048. The maximum number of elements is 10. ||
|| exclude_packages[] | **string**

List of groupId:artifactId, to exclude while resolving the dependencies provided in --packages to avoid dependency conflicts.

The string length in characters for each value must be less than 256. The maximum number of elements is 100. ||
|#

## HiveJob {#yandex.cloud.dataproc.v1.HiveJob}

#|
||Field | Description ||
|| properties | **object** (map<**string**, **string**>)

Property names and values, used to configure Yandex Data Processing and Hive.

The maximum string length in characters for each value is 256. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-zA-Z][-_0-9a-zA-Z.]* `. No more than 100 per resource. ||
|| continue_on_failure | **bool**

Flag indicating whether a job should continue to run if a query fails. ||
|| script_variables | **object** (map<**string**, **string**>)

Query variables and their values.

The maximum string length in characters for each value is 2048. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-zA-Z][_0-9a-zA-Z]* `. No more than 100 per resource. ||
|| jar_file_uris[] | **string**

JAR file URIs to add to CLASSPATH of the Hive driver and each task.

The string length in characters for each value must be less than 2048. The maximum number of elements is 100. ||
|| query_file_uri | **string**

URI of the script with all the necessary Hive queries.

The string length in characters must be less than 2048.

Includes only one of the fields `query_file_uri`, `query_list`. ||
|| query_list | **[QueryList](#yandex.cloud.dataproc.v1.QueryList)**

List of Hive queries to be used in the job.

Includes only one of the fields `query_file_uri`, `query_list`. ||
|#

## QueryList {#yandex.cloud.dataproc.v1.QueryList}

#|
||Field | Description ||
|| queries[] | **string**

List of Hive queries.

The string length in characters for each value must be less than 10240. The maximum number of elements is 100. ||
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
  "metadata": "google.protobuf.Any",
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": "google.protobuf.Any"
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](../../../../api-design-guide/concepts/operation.md).

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
|| metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**

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
|| response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**

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