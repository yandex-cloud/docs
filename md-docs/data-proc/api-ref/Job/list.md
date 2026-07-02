[Документация Yandex Cloud](../../../index.md) > [Yandex Data Processing](../../index.md) > Справочник API > [REST (англ.)](../index.md) > [Job](index.md) > List

# Yandex Data Processing API, REST: Job.List

Retrieves a list of jobs for a cluster.

## HTTP request

```
GET https://dataproc.api.cloud.yandex.net/dataproc/v1/clusters/{clusterId}/jobs
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the cluster to list jobs for.

The maximum string length in characters is 50. ||
|#

## Query parameters {#yandex.cloud.dataproc.v1.ListJobsRequest}

#|
||Field | Description ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`, the service returns a [ListJobsResponse.nextPageToken](#yandex.cloud.dataproc.v1.ListJobsResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100.

The maximum value is 1000. ||
|| pageToken | **string**

Page token. To get the next page of results, set `page_token` to the
[ListJobsResponse.nextPageToken](#yandex.cloud.dataproc.v1.ListJobsResponse) returned by a previous list request.

The maximum string length in characters is 100. ||
|| filter | **string**

A filter expression that filters jobs listed in the response.
The expression must specify:
1. The field name. Currently you can use filtering only on [Job.name](#yandex.cloud.dataproc.v1.Job) field.
2. An `=` operator.
3. The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`.
Example of a filter: `name=my-job`.

The maximum string length in characters is 1000. ||
|#

## Response {#yandex.cloud.dataproc.v1.ListJobsResponse}

**HTTP Code: 200 - OK**

```json
{
  "jobs": [
    {
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
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| jobs[] | **[Job](#yandex.cloud.dataproc.v1.Job)**

List of jobs for the specified cluster. ||
|| nextPageToken | **string**

Token for getting the next page of the list. If the number of results is greater than
the specified [ListJobsRequest.pageSize](#yandex.cloud.dataproc.v1.ListJobsRequest), use `next_page_token` as the value
for the [ListJobsRequest.pageToken](#yandex.cloud.dataproc.v1.ListJobsRequest) parameter in the next list request.
Each subsequent page will have its own `next_page_token` to continue paging through the results.

The maximum string length in characters is 200. ||
|#

## Job {#yandex.cloud.dataproc.v1.Job}

A Yandex Data Processing job. For details about the concept, see [documentation](../../concepts/jobs.md).

#|
||Field | Description ||
|| id | **string**

Required field. ID of the job. Generated at creation time.

The maximum string length in characters is 50. ||
|| clusterId | **string**

Required field. ID of the Yandex Data Processing cluster that the job belongs to.

The maximum string length in characters is 50. ||
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

Name of the job, specified in the [JobService.Create](create.md#Create) request. ||
|| createdBy | **string**

The id of the user who created the job ||
|| status | **enum** (Status)

Job status.

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

Optional arguments to pass to the driver.

The maximum string length in characters for each value is 1024. The maximum number of elements is 32. ||
|| jarFileUris[] | **string**

JAR file URIs to add to CLASSPATH of the Yandex Data Processing driver and each task.

The string length in characters for each value must be less than 2048. The maximum number of elements is 100. ||
|| fileUris[] | **string**

URIs of resource files to be copied to the working directory of Yandex Data Processing drivers
and distributed Hadoop tasks.

The string length in characters for each value must be less than 2048. The maximum number of elements is 100. ||
|| archiveUris[] | **string**

URIs of archives to be extracted to the working directory of Yandex Data Processing drivers and tasks.

The string length in characters for each value must be less than 2048. The maximum number of elements is 100. ||
|| properties | **object** (map<**string**, **string**>)

Property names and values, used to configure Yandex Data Processing and MapReduce.

The maximum string length in characters for each value is 256. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-zA-Z][-_0-9a-zA-Z.]* `. No more than 100 per resource. ||
|| mainJarFileUri | **string**

HCFS URI of the .jar file containing the driver class.

The string length in characters must be less than 2048.

Includes only one of the fields `mainJarFileUri`, `mainClass`. ||
|| mainClass | **string**

The name of the driver class.

The string length in characters must be less than 256.

Includes only one of the fields `mainJarFileUri`, `mainClass`. ||
|#

## SparkJob {#yandex.cloud.dataproc.v1.SparkJob}

#|
||Field | Description ||
|| args[] | **string**

Optional arguments to pass to the driver.

The maximum string length in characters for each value is 10000. The maximum number of elements is 256. ||
|| jarFileUris[] | **string**

JAR file URIs to add to CLASSPATH of the Yandex Data Processing driver and each task.

The string length in characters for each value must be less than 2048. The maximum number of elements is 100. ||
|| fileUris[] | **string**

URIs of resource files to be copied to the working directory of Yandex Data Processing drivers
and distributed Hadoop tasks.

The string length in characters for each value must be less than 2048. The maximum number of elements is 100. ||
|| archiveUris[] | **string**

URIs of archives to be extracted to the working directory of Yandex Data Processing drivers and tasks.

The string length in characters for each value must be less than 2048. The maximum number of elements is 100. ||
|| properties | **object** (map<**string**, **string**>)

Property names and values, used to configure Yandex Data Processing and Spark.

The maximum string length in characters for each value is 256. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-zA-Z][-_0-9a-zA-Z.]* `. No more than 100 per resource. ||
|| mainJarFileUri | **string**

Required field. The HCFS URI of the JAR file containing the `main` class for the job.

The string length in characters must be less than 2048. ||
|| mainClass | **string**

The name of the driver class.

The string length in characters must be less than 256. ||
|| packages[] | **string**

List of maven coordinates of jars to include on the driver and executor classpaths.

The string length in characters for each value must be less than 256. The maximum number of elements is 100. ||
|| repositories[] | **string**

List of additional remote repositories to search for the maven coordinates given with --packages.

The string length in characters for each value must be less than 2048. The maximum number of elements is 10. ||
|| excludePackages[] | **string**

List of groupId:artifactId, to exclude while resolving the dependencies provided in --packages to avoid dependency conflicts.

The string length in characters for each value must be less than 256. The maximum number of elements is 100. ||
|#

## PysparkJob {#yandex.cloud.dataproc.v1.PysparkJob}

#|
||Field | Description ||
|| args[] | **string**

Optional arguments to pass to the driver.

The maximum string length in characters for each value is 100000. The maximum number of elements is 2500. ||
|| jarFileUris[] | **string**

JAR file URIs to add to CLASSPATH of the Yandex Data Processing driver and each task.

The string length in characters for each value must be less than 2048. The maximum number of elements is 100. ||
|| fileUris[] | **string**

URIs of resource files to be copied to the working directory of Yandex Data Processing drivers
and distributed Hadoop tasks.

The string length in characters for each value must be less than 2048. The maximum number of elements is 100. ||
|| archiveUris[] | **string**

URIs of archives to be extracted to the working directory of Yandex Data Processing drivers and tasks.

The string length in characters for each value must be less than 2048. The maximum number of elements is 100. ||
|| properties | **object** (map<**string**, **string**>)

Property names and values, used to configure Yandex Data Processing and PySpark.

The maximum string length in characters for each value is 10000. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-zA-Z][-_0-9a-zA-Z.]* `. No more than 100 per resource. ||
|| mainPythonFileUri | **string**

Required field. URI of the file with the driver code. Must be a .py file.

The string length in characters must be less than 2048. ||
|| pythonFileUris[] | **string**

URIs of Python files to pass to the PySpark framework.

The string length in characters for each value must be less than 2048. The maximum number of elements is 100. ||
|| packages[] | **string**

List of maven coordinates of jars to include on the driver and executor classpaths.

The string length in characters for each value must be less than 256. The maximum number of elements is 100. ||
|| repositories[] | **string**

List of additional remote repositories to search for the maven coordinates given with --packages.

The string length in characters for each value must be less than 2048. The maximum number of elements is 10. ||
|| excludePackages[] | **string**

List of groupId:artifactId, to exclude while resolving the dependencies provided in --packages to avoid dependency conflicts.

The string length in characters for each value must be less than 256. The maximum number of elements is 100. ||
|#

## HiveJob {#yandex.cloud.dataproc.v1.HiveJob}

#|
||Field | Description ||
|| properties | **object** (map<**string**, **string**>)

Property names and values, used to configure Yandex Data Processing and Hive.

The maximum string length in characters for each value is 256. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-zA-Z][-_0-9a-zA-Z.]* `. No more than 100 per resource. ||
|| continueOnFailure | **boolean**

Flag indicating whether a job should continue to run if a query fails. ||
|| scriptVariables | **object** (map<**string**, **string**>)

Query variables and their values.

The maximum string length in characters for each value is 2048. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-zA-Z][_0-9a-zA-Z]* `. No more than 100 per resource. ||
|| jarFileUris[] | **string**

JAR file URIs to add to CLASSPATH of the Hive driver and each task.

The string length in characters for each value must be less than 2048. The maximum number of elements is 100. ||
|| queryFileUri | **string**

URI of the script with all the necessary Hive queries.

The string length in characters must be less than 2048.

Includes only one of the fields `queryFileUri`, `queryList`. ||
|| queryList | **[QueryList](#yandex.cloud.dataproc.v1.QueryList)**

List of Hive queries to be used in the job.

Includes only one of the fields `queryFileUri`, `queryList`. ||
|#

## QueryList {#yandex.cloud.dataproc.v1.QueryList}

#|
||Field | Description ||
|| queries[] | **string**

List of Hive queries.

The string length in characters for each value must be less than 10240. The maximum number of elements is 100. ||
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