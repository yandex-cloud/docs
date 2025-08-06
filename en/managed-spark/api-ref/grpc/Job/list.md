---
editable: false
sourcePath: en/_api-ref-grpc/spark/v1/api-ref/grpc/Job/list.md
---

# Managed Spark API, gRPC: JobService.List

Retrieves a list of jobs for Spark cluster.

## gRPC request

**rpc List ([ListJobsRequest](#yandex.cloud.spark.v1.ListJobsRequest)) returns ([ListJobsResponse](#yandex.cloud.spark.v1.ListJobsResponse))**

## ListJobsRequest {#yandex.cloud.spark.v1.ListJobsRequest}

```json
{
  "cluster_id": "string",
  "page_size": "int64",
  "page_token": "string",
  "filter": "string"
}
```

#|
||Field | Description ||
|| cluster_id | **string**

Required field. ID of the cluster to list Spark jobs of. ||
|| page_size | **int64**

The maximum number of results per page that should be returned. If the number of available
results is larger than `page_size`, the service returns a `next_page_token` that can be used
to get the next page of results in subsequent ListJobs requests.
Acceptable values are 0 to 1000, inclusive. Default value: 100. ||
|| page_token | **string**

Page token. Set `page_token` to the `next_page_token` returned by a previous ListJobs
request to get the next page of results. ||
|| filter | **string**

String that describes a display filter. ||
|#

## ListJobsResponse {#yandex.cloud.spark.v1.ListJobsResponse}

```json
{
  "jobs": [
    {
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
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| jobs[] | **[Job](#yandex.cloud.spark.v1.Job)**

Requested list of Spark jobs. ||
|| next_page_token | **string**

This token allows you to get the next page of results for ListJobs requests,
if the number of results is larger than `page_size` specified in the request.
To get the next page, specify the value of `next_page_token` as a value for
the `page_token` parameter in the next ListClusters request. Subsequent ListClusters
requests will have their own `next_page_token` to continue paging through the results. ||
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