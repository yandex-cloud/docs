# Managed Spark API, gRPC: JobService.Create

Creates a job for Spark cluster.

## gRPC request

**rpc Create ([CreateJobRequest](#yandex.cloud.spark.v1.CreateJobRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## CreateJobRequest {#yandex.cloud.spark.v1.CreateJobRequest}

```json
{
  "cluster_id": "string",
  "name": "string",
  // Includes only one of the fields `spark_job`, `pyspark_job`, `spark_connect_job`
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
  "spark_connect_job": {
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
  "service_account_id": "string"
}
```

#|
||Field | Description ||
|| cluster_id | **string**

Required field. ID of the cluster to create Spark job in.

The maximum string length in characters is 50. ||
|| name | **string**

Optional. Name of the job.

The string length in characters must be less than 256. Value must match the regular expression ``` |[a-z][-a-z0-9]{1,61}[a-z0-9] ```. ||
|| spark_job | **[SparkJob](#yandex.cloud.spark.v1.SparkJob)**

Includes only one of the fields `spark_job`, `pyspark_job`, `spark_connect_job`. ||
|| pyspark_job | **[PysparkJob](#yandex.cloud.spark.v1.PysparkJob)**

Includes only one of the fields `spark_job`, `pyspark_job`, `spark_connect_job`. ||
|| spark_connect_job | **[SparkConnectJob](#yandex.cloud.spark.v1.SparkConnectJob)**

Includes only one of the fields `spark_job`, `pyspark_job`, `spark_connect_job`. ||
|| service_account_id | **string**

Service account used to access Cloud resources.

The maximum string length in characters is 50. ||
|#

## SparkJob {#yandex.cloud.spark.v1.SparkJob}

Spark Job.

#|
||Field | Description ||
|| args[] | **string**

Optional arguments to pass to the driver.

The string length in characters for each value must be less than 2048. The maximum number of elements is 100. ||
|| jar_file_uris[] | **string**

Jar file URIs to add to the CLASSPATHs of the Spark driver and tasks.

The string length in characters for each value must be less than 2048. The maximum number of elements is 100. ||
|| file_uris[] | **string**

URIs of files to be copied to the working directory of Spark drivers and distributed tasks.

The string length in characters for each value must be less than 2048. The maximum number of elements is 100. ||
|| archive_uris[] | **string**

URIs of archives to be extracted in the working directory of Spark drivers and tasks.

The string length in characters for each value must be less than 2048. The maximum number of elements is 100. ||
|| properties | **object** (map<**string**, **string**>)

A mapping of property names to values, used to configure Spark.

The maximum string length in characters for each value is 256. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-zA-Z][-_0-9a-zA-Z.]* `. No more than 100 per resource. ||
|| main_jar_file_uri | **string**

Required field. The HCFS URI of the jar file containing the main class.

The string length in characters must be less than 2048. ||
|| main_class | **string**

The name of the driver's main class.

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

## PysparkJob {#yandex.cloud.spark.v1.PysparkJob}

Pyspark Job.

#|
||Field | Description ||
|| args[] | **string**

Optional arguments to pass to the driver.

The string length in characters for each value must be less than 2048. The maximum number of elements is 100. ||
|| jar_file_uris[] | **string**

Jar file URIs to add to the CLASSPATHs of the Spark driver and tasks.

The string length in characters for each value must be less than 2048. The maximum number of elements is 100. ||
|| file_uris[] | **string**

URIs of files to be copied to the working directory of Spark drivers and distributed tasks.

The string length in characters for each value must be less than 2048. The maximum number of elements is 100. ||
|| archive_uris[] | **string**

URIs of archives to be extracted in the working directory of Spark drivers and tasks.

The string length in characters for each value must be less than 2048. The maximum number of elements is 100. ||
|| properties | **object** (map<**string**, **string**>)

A mapping of property names to values, used to configure Spark.

The maximum string length in characters for each value is 256. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-zA-Z][-_0-9a-zA-Z.]* `. No more than 100 per resource. ||
|| main_python_file_uri | **string**

Required field. URI of the main Python file to use as the driver. Must be a .py file.

The string length in characters must be less than 2048. ||
|| python_file_uris[] | **string**

URIs of Python files to pass to the PySpark framework.

The string length in characters for each value must be less than 2048. The maximum number of elements is 100. ||
|| packages[] | **string**

List of maven coordinates of jars (groupId:artifactId:version) to include on the driver and executor classpaths.

The string length in characters for each value must be less than 256. The maximum number of elements is 100. ||
|| repositories[] | **string**

List of additional remote repositories to search for the maven coordinates given with --packages.

The string length in characters for each value must be less than 2048. The maximum number of elements is 10. ||
|| exclude_packages[] | **string**

List of groupId:artifactId, to exclude while resolving the dependencies provided in --packages to avoid dependency conflicts.

The string length in characters for each value must be less than 256. The maximum number of elements is 100. ||
|#

## SparkConnectJob {#yandex.cloud.spark.v1.SparkConnectJob}

Spark-connect Job.

#|
||Field | Description ||
|| jar_file_uris[] | **string**

Jar file URIs to add to the CLASSPATHs of the Spark driver and tasks.

The string length in characters for each value must be less than 2048. The maximum number of elements is 100. ||
|| file_uris[] | **string**

URIs of files to be copied to the working directory of Spark drivers and distributed tasks.

The string length in characters for each value must be less than 2048. The maximum number of elements is 100. ||
|| archive_uris[] | **string**

URIs of archives to be extracted in the working directory of Spark drivers and tasks.

The string length in characters for each value must be less than 2048. The maximum number of elements is 100. ||
|| properties | **object** (map<**string**, **string**>)

A mapping of property names to values, used to configure Spark.

The maximum string length in characters for each value is 256. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-zA-Z][-_0-9a-zA-Z.]* `. No more than 100 per resource. ||
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