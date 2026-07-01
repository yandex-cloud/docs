---
editable: false
---

# Managed Spark API, gRPC: JobService.Get

Returns the specified Spark job.

## gRPC request

**rpc Get ([GetJobRequest](#yandex.cloud.spark.v1.GetJobRequest)) returns ([Job](#yandex.cloud.spark.v1.Job))**

## GetJobRequest {#yandex.cloud.spark.v1.GetJobRequest}

```json
{
  "cluster_id": "string",
  "job_id": "string"
}
```

#|
||Field | Description ||
|| cluster_id | **string**

Required field. ID of the Spark cluster.

The maximum string length in characters is 50. ||
|| job_id | **string**

Required field. ID of the Spark job to return.

The maximum string length in characters is 50. ||
|#

## Job {#yandex.cloud.spark.v1.Job}

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
  "ui_url": "string",
  "service_account_id": "string",
  "connect_url": "string",
  "environment_id": "string",
  "environment_build_revision": "int64"
}
```

Spark job.

#|
||Field | Description ||
|| id | **string**

Required field. Required. Unique ID of the Spark job.
This ID is assigned by MDB in the process of creating Spark job.

The maximum string length in characters is 50. ||
|| cluster_id | **string**

Required field. Required. Unique ID of the Spark cluster.

The maximum string length in characters is 50. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Spark job was created. ||
|| started_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Spark job was started. ||
|| finished_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Spark job was finished. ||
|| name | **string**

Name of the Spark job. ||
|| created_by | **string**

The id of the user who created the job. ||
|| status | enum **Status**

Job Status.

- `PROVISIONING`: Job created and is waiting to acquire.
- `PENDING`: Job acquired and is waiting for execution.
- `RUNNING`: Job is running.
- `ERROR`: Job failed.
- `DONE`: Job finished.
- `CANCELLED`: Job cancelled.
- `CANCELLING`: Job is waiting for cancellation. ||
|| spark_job | **[SparkJob](#yandex.cloud.spark.v1.SparkJob)**

Spark Job.

Includes only one of the fields `spark_job`, `pyspark_job`, `spark_connect_job`.

Job specification. ||
|| pyspark_job | **[PysparkJob](#yandex.cloud.spark.v1.PysparkJob)**

Pyspark Job.

Includes only one of the fields `spark_job`, `pyspark_job`, `spark_connect_job`.

Job specification. ||
|| spark_connect_job | **[SparkConnectJob](#yandex.cloud.spark.v1.SparkConnectJob)**

Spark-connect Job.

Includes only one of the fields `spark_job`, `pyspark_job`, `spark_connect_job`.

Job specification. ||
|| ui_url | **string**

Spark UI Url. ||
|| service_account_id | **string**

Service account used to access Cloud resources.

The maximum string length in characters is 50. ||
|| connect_url | **string**

Spark Connect Url. ||
|| environment_id | **string**

Job Environment ID.

The maximum string length in characters is 50. ||
|| environment_build_revision | **int64**

Environment build revision. ||
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