---
editable: false
sourcePath: en/_api-ref-grpc/data-proc/api-ref/grpc/job_service.md
---

# JobService

A set of methods for managing Data Proc jobs.

| Call | Description |
| --- | --- |
| [List](#List) | Retrieves a list of jobs for a cluster. |
| [Create](#Create) | Creates a job for a cluster. |
| [Get](#Get) | Returns the specified job. |
| [ListLog](#ListLog) | Returns a log for specified job. |
| [Cancel](#Cancel) | Cancels the specified Dataproc job. |

## Calls JobService {#calls}

## List {#List}

Retrieves a list of jobs for a cluster.

**rpc List ([ListJobsRequest](#ListJobsRequest)) returns ([ListJobsResponse](#ListJobsResponse))**

### ListJobsRequest {#ListJobsRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the cluster to list jobs for. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListJobsResponse.next_page_token](#ListJobsResponse) that can be used to get the next page of results in subsequent list requests. Default value: 100. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListJobsResponse.next_page_token](#ListJobsResponse) returned by a previous list request. The maximum string length in characters is 100.
filter | **string**<br>A filter expression that filters jobs listed in the response. <br>The expression must specify: <ol><li>The field name. Currently you can use filtering only on [Job.name](#Job) field. </li><li>An `=` operator. </li><li>The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`. </li></ol>Example of a filter: `name=my-job`. The maximum string length in characters is 1000.


### ListJobsResponse {#ListJobsResponse}

Field | Description
--- | ---
jobs[] | **[Job](#Job)**<br>List of jobs for the specified cluster. 
next_page_token | **string**<br>Token for getting the next page of the list. If the number of results is greater than the specified [ListJobsRequest.page_size](#ListJobsRequest), use `next_page_token` as the value for the [ListJobsRequest.page_token](#ListJobsRequest) parameter in the next list request. <br>Each subsequent page will have its own `next_page_token` to continue paging through the results. 


### Job {#Job}

Field | Description
--- | ---
id | **string**<br>ID of the job. Generated at creation time. 
cluster_id | **string**<br>ID of the Data Proc cluster that the job belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
started_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the job was started. 
finished_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the job was finished. 
name | **string**<br>Name of the job, specified in the [JobService.Create](#Create) request. 
created_by | **string**<br>The id of the user who created the job 
status | enum **Status**<br>Job status. <ul><li>`PROVISIONING`: Job is logged in the database and is waiting for the agent to run it.</li><li>`PENDING`: Job is acquired by the agent and is in the queue for execution.</li><li>`RUNNING`: Job is being run in the cluster.</li><li>`ERROR`: Job failed to finish the run properly.</li><li>`DONE`: Job is finished.</li><li>`CANCELLED`: Job is cancelled.</li><li>`CANCELLING`: Job is waiting for cancellation.</li></ul>
job_spec | **oneof:** `mapreduce_job`, `spark_job`, `pyspark_job` or `hive_job`<br>Specification for the job.
&nbsp;&nbsp;mapreduce_job | **[MapreduceJob](#MapreduceJob)**<br>Specification for a MapReduce job. 
&nbsp;&nbsp;spark_job | **[SparkJob](#SparkJob)**<br>Specification for a Spark job. 
&nbsp;&nbsp;pyspark_job | **[PysparkJob](#PysparkJob)**<br>Specification for a PySpark job. 
&nbsp;&nbsp;hive_job | **[HiveJob](#HiveJob)**<br>Specification for a Hive job. 
application_info | **[ApplicationInfo](#ApplicationInfo)**<br>Attributes of YARN application. 


### MapreduceJob {#MapreduceJob}

Field | Description
--- | ---
args[] | **string**<br>Optional arguments to pass to the driver. 
jar_file_uris[] | **string**<br>JAR file URIs to add to CLASSPATH of the Data Proc driver and each task. 
file_uris[] | **string**<br>URIs of resource files to be copied to the working directory of Data Proc drivers and distributed Hadoop tasks. 
archive_uris[] | **string**<br>URIs of archives to be extracted to the working directory of Data Proc drivers and tasks. 
properties | **map<string,string>**<br>Property names and values, used to configure Data Proc and MapReduce. 
driver | **oneof:** `main_jar_file_uri` or `main_class`<br>
&nbsp;&nbsp;main_jar_file_uri | **string**<br>HCFS URI of the .jar file containing the driver class. 
&nbsp;&nbsp;main_class | **string**<br>The name of the driver class. 


### SparkJob {#SparkJob}

Field | Description
--- | ---
args[] | **string**<br>Optional arguments to pass to the driver. 
jar_file_uris[] | **string**<br>JAR file URIs to add to CLASSPATH of the Data Proc driver and each task. 
file_uris[] | **string**<br>URIs of resource files to be copied to the working directory of Data Proc drivers and distributed Hadoop tasks. 
archive_uris[] | **string**<br>URIs of archives to be extracted to the working directory of Data Proc drivers and tasks. 
properties | **map<string,string>**<br>Property names and values, used to configure Data Proc and Spark. 
main_jar_file_uri | **string**<br>The HCFS URI of the JAR file containing the `main` class for the job. 
main_class | **string**<br>The name of the driver class. 
packages[] | **string**<br>List of maven coordinates of jars to include on the driver and executor classpaths. 
repositories[] | **string**<br>List of additional remote repositories to search for the maven coordinates given with --packages. 
exclude_packages[] | **string**<br>List of groupId:artifactId, to exclude while resolving the dependencies provided in --packages to avoid dependency conflicts. 


### PysparkJob {#PysparkJob}

Field | Description
--- | ---
args[] | **string**<br>Optional arguments to pass to the driver. 
jar_file_uris[] | **string**<br>JAR file URIs to add to CLASSPATH of the Data Proc driver and each task. 
file_uris[] | **string**<br>URIs of resource files to be copied to the working directory of Data Proc drivers and distributed Hadoop tasks. 
archive_uris[] | **string**<br>URIs of archives to be extracted to the working directory of Data Proc drivers and tasks. 
properties | **map<string,string>**<br>Property names and values, used to configure Data Proc and PySpark. 
main_python_file_uri | **string**<br>URI of the file with the driver code. Must be a .py file. 
python_file_uris[] | **string**<br>URIs of Python files to pass to the PySpark framework. 
packages[] | **string**<br>List of maven coordinates of jars to include on the driver and executor classpaths. 
repositories[] | **string**<br>List of additional remote repositories to search for the maven coordinates given with --packages. 
exclude_packages[] | **string**<br>List of groupId:artifactId, to exclude while resolving the dependencies provided in --packages to avoid dependency conflicts. 


### HiveJob {#HiveJob}

Field | Description
--- | ---
properties | **map<string,string>**<br>Property names and values, used to configure Data Proc and Hive. 
continue_on_failure | **bool**<br>Flag indicating whether a job should continue to run if a query fails. 
script_variables | **map<string,string>**<br>Query variables and their values. 
jar_file_uris[] | **string**<br>JAR file URIs to add to CLASSPATH of the Hive driver and each task. 
query_type | **oneof:** `query_file_uri` or `query_list`<br>
&nbsp;&nbsp;query_file_uri | **string**<br>URI of the script with all the necessary Hive queries. 
&nbsp;&nbsp;query_list | **[QueryList](#QueryList)**<br>List of Hive queries to be used in the job. 


### QueryList {#QueryList}

Field | Description
--- | ---
queries[] | **string**<br>List of Hive queries. 


### ApplicationInfo {#ApplicationInfo}

Field | Description
--- | ---
id | **string**<br>ID of YARN application 
application_attempts[] | **[ApplicationAttempt](#ApplicationAttempt)**<br>YARN application attempts 


### ApplicationAttempt {#ApplicationAttempt}

Field | Description
--- | ---
id | **string**<br>ID of YARN application attempt 
am_container_id | **string**<br>ID of YARN Application Master container 


## Create {#Create}

Creates a job for a cluster.

**rpc Create ([CreateJobRequest](#CreateJobRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateJobMetadata](#CreateJobMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Job](#Job1)<br>

### CreateJobRequest {#CreateJobRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the cluster to create a job for. The maximum string length in characters is 50.
name | **string**<br>Name of the job. Value must match the regular expression ` \|[a-z][-a-z0-9]{1,61}[a-z0-9] `.
job_spec | **oneof:** `mapreduce_job`, `spark_job`, `pyspark_job` or `hive_job`<br>Specification for the job.
&nbsp;&nbsp;mapreduce_job | **[MapreduceJob](#MapreduceJob1)**<br>Specification for a MapReduce job. 
&nbsp;&nbsp;spark_job | **[SparkJob](#SparkJob1)**<br>Specification for a Spark job. 
&nbsp;&nbsp;pyspark_job | **[PysparkJob](#PysparkJob1)**<br>Specification for a PySpark job. 
&nbsp;&nbsp;hive_job | **[HiveJob](#HiveJob1)**<br>Specification for a Hive job. 


### MapreduceJob {#MapreduceJob1}

Field | Description
--- | ---
args[] | **string**<br>Optional arguments to pass to the driver. 
jar_file_uris[] | **string**<br>JAR file URIs to add to CLASSPATH of the Data Proc driver and each task. 
file_uris[] | **string**<br>URIs of resource files to be copied to the working directory of Data Proc drivers and distributed Hadoop tasks. 
archive_uris[] | **string**<br>URIs of archives to be extracted to the working directory of Data Proc drivers and tasks. 
properties | **map<string,string>**<br>Property names and values, used to configure Data Proc and MapReduce. 
driver | **oneof:** `main_jar_file_uri` or `main_class`<br>
&nbsp;&nbsp;main_jar_file_uri | **string**<br>HCFS URI of the .jar file containing the driver class. 
&nbsp;&nbsp;main_class | **string**<br>The name of the driver class. 


### SparkJob {#SparkJob1}

Field | Description
--- | ---
args[] | **string**<br>Optional arguments to pass to the driver. 
jar_file_uris[] | **string**<br>JAR file URIs to add to CLASSPATH of the Data Proc driver and each task. 
file_uris[] | **string**<br>URIs of resource files to be copied to the working directory of Data Proc drivers and distributed Hadoop tasks. 
archive_uris[] | **string**<br>URIs of archives to be extracted to the working directory of Data Proc drivers and tasks. 
properties | **map<string,string>**<br>Property names and values, used to configure Data Proc and Spark. 
main_jar_file_uri | **string**<br>The HCFS URI of the JAR file containing the `main` class for the job. 
main_class | **string**<br>The name of the driver class. 
packages[] | **string**<br>List of maven coordinates of jars to include on the driver and executor classpaths. 
repositories[] | **string**<br>List of additional remote repositories to search for the maven coordinates given with --packages. 
exclude_packages[] | **string**<br>List of groupId:artifactId, to exclude while resolving the dependencies provided in --packages to avoid dependency conflicts. 


### PysparkJob {#PysparkJob1}

Field | Description
--- | ---
args[] | **string**<br>Optional arguments to pass to the driver. 
jar_file_uris[] | **string**<br>JAR file URIs to add to CLASSPATH of the Data Proc driver and each task. 
file_uris[] | **string**<br>URIs of resource files to be copied to the working directory of Data Proc drivers and distributed Hadoop tasks. 
archive_uris[] | **string**<br>URIs of archives to be extracted to the working directory of Data Proc drivers and tasks. 
properties | **map<string,string>**<br>Property names and values, used to configure Data Proc and PySpark. 
main_python_file_uri | **string**<br>URI of the file with the driver code. Must be a .py file. 
python_file_uris[] | **string**<br>URIs of Python files to pass to the PySpark framework. 
packages[] | **string**<br>List of maven coordinates of jars to include on the driver and executor classpaths. 
repositories[] | **string**<br>List of additional remote repositories to search for the maven coordinates given with --packages. 
exclude_packages[] | **string**<br>List of groupId:artifactId, to exclude while resolving the dependencies provided in --packages to avoid dependency conflicts. 


### HiveJob {#HiveJob1}

Field | Description
--- | ---
properties | **map<string,string>**<br>Property names and values, used to configure Data Proc and Hive. 
continue_on_failure | **bool**<br>Flag indicating whether a job should continue to run if a query fails. 
script_variables | **map<string,string>**<br>Query variables and their values. 
jar_file_uris[] | **string**<br>JAR file URIs to add to CLASSPATH of the Hive driver and each task. 
query_type | **oneof:** `query_file_uri` or `query_list`<br>
&nbsp;&nbsp;query_file_uri | **string**<br>URI of the script with all the necessary Hive queries. 
&nbsp;&nbsp;query_list | **[QueryList](#QueryList1)**<br>List of Hive queries to be used in the job. 


### QueryList {#QueryList1}

Field | Description
--- | ---
queries[] | **string**<br>List of Hive queries. 


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateJobMetadata](#CreateJobMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Job](#Job1)>**<br>if operation finished successfully. 


### CreateJobMetadata {#CreateJobMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the cluster that the job is being created for. The maximum string length in characters is 50.
job_id | **string**<br>ID of the job being created. The maximum string length in characters is 50.


### Job {#Job1}

Field | Description
--- | ---
id | **string**<br>ID of the job. Generated at creation time. 
cluster_id | **string**<br>ID of the Data Proc cluster that the job belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
started_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the job was started. 
finished_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the job was finished. 
name | **string**<br>Name of the job, specified in the [JobService.Create](#Create) request. 
created_by | **string**<br>The id of the user who created the job 
status | enum **Status**<br>Job status. <ul><li>`PROVISIONING`: Job is logged in the database and is waiting for the agent to run it.</li><li>`PENDING`: Job is acquired by the agent and is in the queue for execution.</li><li>`RUNNING`: Job is being run in the cluster.</li><li>`ERROR`: Job failed to finish the run properly.</li><li>`DONE`: Job is finished.</li><li>`CANCELLED`: Job is cancelled.</li><li>`CANCELLING`: Job is waiting for cancellation.</li></ul>
job_spec | **oneof:** `mapreduce_job`, `spark_job`, `pyspark_job` or `hive_job`<br>Specification for the job.
&nbsp;&nbsp;mapreduce_job | **[MapreduceJob](#MapreduceJob2)**<br>Specification for a MapReduce job. 
&nbsp;&nbsp;spark_job | **[SparkJob](#SparkJob2)**<br>Specification for a Spark job. 
&nbsp;&nbsp;pyspark_job | **[PysparkJob](#PysparkJob2)**<br>Specification for a PySpark job. 
&nbsp;&nbsp;hive_job | **[HiveJob](#HiveJob2)**<br>Specification for a Hive job. 
application_info | **[ApplicationInfo](#ApplicationInfo1)**<br>Attributes of YARN application. 


### ApplicationInfo {#ApplicationInfo1}

Field | Description
--- | ---
id | **string**<br>ID of YARN application 
application_attempts[] | **[ApplicationAttempt](#ApplicationAttempt1)**<br>YARN application attempts 


### ApplicationAttempt {#ApplicationAttempt1}

Field | Description
--- | ---
id | **string**<br>ID of YARN application attempt 
am_container_id | **string**<br>ID of YARN Application Master container 


## Get {#Get}

Returns the specified job.

**rpc Get ([GetJobRequest](#GetJobRequest)) returns ([Job](#Job2))**

### GetJobRequest {#GetJobRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the cluster to request a job from. The maximum string length in characters is 50.
job_id | **string**<br>Required. ID of the job to return. <br>To get a job ID make a [JobService.List](#List) request. The maximum string length in characters is 50.


### Job {#Job2}

Field | Description
--- | ---
id | **string**<br>ID of the job. Generated at creation time. 
cluster_id | **string**<br>ID of the Data Proc cluster that the job belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
started_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the job was started. 
finished_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the job was finished. 
name | **string**<br>Name of the job, specified in the [JobService.Create](#Create) request. 
created_by | **string**<br>The id of the user who created the job 
status | enum **Status**<br>Job status. <ul><li>`PROVISIONING`: Job is logged in the database and is waiting for the agent to run it.</li><li>`PENDING`: Job is acquired by the agent and is in the queue for execution.</li><li>`RUNNING`: Job is being run in the cluster.</li><li>`ERROR`: Job failed to finish the run properly.</li><li>`DONE`: Job is finished.</li><li>`CANCELLED`: Job is cancelled.</li><li>`CANCELLING`: Job is waiting for cancellation.</li></ul>
job_spec | **oneof:** `mapreduce_job`, `spark_job`, `pyspark_job` or `hive_job`<br>Specification for the job.
&nbsp;&nbsp;mapreduce_job | **[MapreduceJob](#MapreduceJob2)**<br>Specification for a MapReduce job. 
&nbsp;&nbsp;spark_job | **[SparkJob](#SparkJob2)**<br>Specification for a Spark job. 
&nbsp;&nbsp;pyspark_job | **[PysparkJob](#PysparkJob2)**<br>Specification for a PySpark job. 
&nbsp;&nbsp;hive_job | **[HiveJob](#HiveJob2)**<br>Specification for a Hive job. 
application_info | **[ApplicationInfo](#ApplicationInfo2)**<br>Attributes of YARN application. 


### MapreduceJob {#MapreduceJob2}

Field | Description
--- | ---
args[] | **string**<br>Optional arguments to pass to the driver. 
jar_file_uris[] | **string**<br>JAR file URIs to add to CLASSPATH of the Data Proc driver and each task. 
file_uris[] | **string**<br>URIs of resource files to be copied to the working directory of Data Proc drivers and distributed Hadoop tasks. 
archive_uris[] | **string**<br>URIs of archives to be extracted to the working directory of Data Proc drivers and tasks. 
properties | **map<string,string>**<br>Property names and values, used to configure Data Proc and MapReduce. 
driver | **oneof:** `main_jar_file_uri` or `main_class`<br>
&nbsp;&nbsp;main_jar_file_uri | **string**<br>HCFS URI of the .jar file containing the driver class. 
&nbsp;&nbsp;main_class | **string**<br>The name of the driver class. 


### SparkJob {#SparkJob2}

Field | Description
--- | ---
args[] | **string**<br>Optional arguments to pass to the driver. 
jar_file_uris[] | **string**<br>JAR file URIs to add to CLASSPATH of the Data Proc driver and each task. 
file_uris[] | **string**<br>URIs of resource files to be copied to the working directory of Data Proc drivers and distributed Hadoop tasks. 
archive_uris[] | **string**<br>URIs of archives to be extracted to the working directory of Data Proc drivers and tasks. 
properties | **map<string,string>**<br>Property names and values, used to configure Data Proc and Spark. 
main_jar_file_uri | **string**<br>The HCFS URI of the JAR file containing the `main` class for the job. 
main_class | **string**<br>The name of the driver class. 
packages[] | **string**<br>List of maven coordinates of jars to include on the driver and executor classpaths. 
repositories[] | **string**<br>List of additional remote repositories to search for the maven coordinates given with --packages. 
exclude_packages[] | **string**<br>List of groupId:artifactId, to exclude while resolving the dependencies provided in --packages to avoid dependency conflicts. 


### PysparkJob {#PysparkJob2}

Field | Description
--- | ---
args[] | **string**<br>Optional arguments to pass to the driver. 
jar_file_uris[] | **string**<br>JAR file URIs to add to CLASSPATH of the Data Proc driver and each task. 
file_uris[] | **string**<br>URIs of resource files to be copied to the working directory of Data Proc drivers and distributed Hadoop tasks. 
archive_uris[] | **string**<br>URIs of archives to be extracted to the working directory of Data Proc drivers and tasks. 
properties | **map<string,string>**<br>Property names and values, used to configure Data Proc and PySpark. 
main_python_file_uri | **string**<br>URI of the file with the driver code. Must be a .py file. 
python_file_uris[] | **string**<br>URIs of Python files to pass to the PySpark framework. 
packages[] | **string**<br>List of maven coordinates of jars to include on the driver and executor classpaths. 
repositories[] | **string**<br>List of additional remote repositories to search for the maven coordinates given with --packages. 
exclude_packages[] | **string**<br>List of groupId:artifactId, to exclude while resolving the dependencies provided in --packages to avoid dependency conflicts. 


### HiveJob {#HiveJob2}

Field | Description
--- | ---
properties | **map<string,string>**<br>Property names and values, used to configure Data Proc and Hive. 
continue_on_failure | **bool**<br>Flag indicating whether a job should continue to run if a query fails. 
script_variables | **map<string,string>**<br>Query variables and their values. 
jar_file_uris[] | **string**<br>JAR file URIs to add to CLASSPATH of the Hive driver and each task. 
query_type | **oneof:** `query_file_uri` or `query_list`<br>
&nbsp;&nbsp;query_file_uri | **string**<br>URI of the script with all the necessary Hive queries. 
&nbsp;&nbsp;query_list | **[QueryList](#QueryList2)**<br>List of Hive queries to be used in the job. 


### QueryList {#QueryList2}

Field | Description
--- | ---
queries[] | **string**<br>List of Hive queries. 


### ApplicationInfo {#ApplicationInfo2}

Field | Description
--- | ---
id | **string**<br>ID of YARN application 
application_attempts[] | **[ApplicationAttempt](#ApplicationAttempt2)**<br>YARN application attempts 


### ApplicationAttempt {#ApplicationAttempt2}

Field | Description
--- | ---
id | **string**<br>ID of YARN application attempt 
am_container_id | **string**<br>ID of YARN Application Master container 


## ListLog {#ListLog}

Returns a log for specified job.

**rpc ListLog ([ListJobLogRequest](#ListJobLogRequest)) returns ([ListJobLogResponse](#ListJobLogResponse))**

### ListJobLogRequest {#ListJobLogRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the cluster that the job is being created for. The maximum string length in characters is 50.
job_id | **string**<br>ID of the job being created. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum bytes of job log per response to return. If the number of available bytes is larger than `page_size`, the service returns a [ListJobLogResponse.next_page_token](#ListJobLogResponse) that can be used to get the next page of output in subsequent list requests. Default value: 1048576. The maximum value is 1048576.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListJobLogResponse.next_page_token](#ListJobLogResponse) returned by a previous list request. The maximum string length in characters is 100.


### ListJobLogResponse {#ListJobLogResponse}

Field | Description
--- | ---
content | **string**<br>Requested part of Data Proc Job log. 
next_page_token | **string**<br>This token allows you to get the next page of results for ListLog requests, if the number of results is larger than `page_size` specified in the request. To get the next page, specify the value of `next_page_token` as a value for the `page_token` parameter in the next ListLog request. Subsequent ListLog requests will have their own `next_page_token` to continue paging through the results. 


## Cancel {#Cancel}

Cancels the specified Dataproc job.

**rpc Cancel ([CancelJobRequest](#CancelJobRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateJobMetadata](#CreateJobMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Job](#Job3)<br>

### CancelJobRequest {#CancelJobRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. Required. ID of the Dataproc cluster. The maximum string length in characters is 50.
job_id | **string**<br>Required. Required. ID of the Dataproc job to cancel. The maximum string length in characters is 50.


### Operation {#Operation1}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateJobMetadata](#CreateJobMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Job](#Job3)>**<br>if operation finished successfully. 


### CreateJobMetadata {#CreateJobMetadata1}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the cluster that the job is being created for. The maximum string length in characters is 50.
job_id | **string**<br>ID of the job being created. The maximum string length in characters is 50.


### Job {#Job3}

Field | Description
--- | ---
id | **string**<br>ID of the job. Generated at creation time. 
cluster_id | **string**<br>ID of the Data Proc cluster that the job belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
started_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the job was started. 
finished_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the job was finished. 
name | **string**<br>Name of the job, specified in the [JobService.Create](#Create) request. 
created_by | **string**<br>The id of the user who created the job 
status | enum **Status**<br>Job status. <ul><li>`PROVISIONING`: Job is logged in the database and is waiting for the agent to run it.</li><li>`PENDING`: Job is acquired by the agent and is in the queue for execution.</li><li>`RUNNING`: Job is being run in the cluster.</li><li>`ERROR`: Job failed to finish the run properly.</li><li>`DONE`: Job is finished.</li><li>`CANCELLED`: Job is cancelled.</li><li>`CANCELLING`: Job is waiting for cancellation.</li></ul>
job_spec | **oneof:** `mapreduce_job`, `spark_job`, `pyspark_job` or `hive_job`<br>Specification for the job.
&nbsp;&nbsp;mapreduce_job | **[MapreduceJob](#MapreduceJob3)**<br>Specification for a MapReduce job. 
&nbsp;&nbsp;spark_job | **[SparkJob](#SparkJob3)**<br>Specification for a Spark job. 
&nbsp;&nbsp;pyspark_job | **[PysparkJob](#PysparkJob3)**<br>Specification for a PySpark job. 
&nbsp;&nbsp;hive_job | **[HiveJob](#HiveJob3)**<br>Specification for a Hive job. 
application_info | **[ApplicationInfo](#ApplicationInfo3)**<br>Attributes of YARN application. 


### MapreduceJob {#MapreduceJob3}

Field | Description
--- | ---
args[] | **string**<br>Optional arguments to pass to the driver. 
jar_file_uris[] | **string**<br>JAR file URIs to add to CLASSPATH of the Data Proc driver and each task. 
file_uris[] | **string**<br>URIs of resource files to be copied to the working directory of Data Proc drivers and distributed Hadoop tasks. 
archive_uris[] | **string**<br>URIs of archives to be extracted to the working directory of Data Proc drivers and tasks. 
properties | **map<string,string>**<br>Property names and values, used to configure Data Proc and MapReduce. 
driver | **oneof:** `main_jar_file_uri` or `main_class`<br>
&nbsp;&nbsp;main_jar_file_uri | **string**<br>HCFS URI of the .jar file containing the driver class. 
&nbsp;&nbsp;main_class | **string**<br>The name of the driver class. 


### SparkJob {#SparkJob3}

Field | Description
--- | ---
args[] | **string**<br>Optional arguments to pass to the driver. 
jar_file_uris[] | **string**<br>JAR file URIs to add to CLASSPATH of the Data Proc driver and each task. 
file_uris[] | **string**<br>URIs of resource files to be copied to the working directory of Data Proc drivers and distributed Hadoop tasks. 
archive_uris[] | **string**<br>URIs of archives to be extracted to the working directory of Data Proc drivers and tasks. 
properties | **map<string,string>**<br>Property names and values, used to configure Data Proc and Spark. 
main_jar_file_uri | **string**<br>The HCFS URI of the JAR file containing the `main` class for the job. 
main_class | **string**<br>The name of the driver class. 
packages[] | **string**<br>List of maven coordinates of jars to include on the driver and executor classpaths. 
repositories[] | **string**<br>List of additional remote repositories to search for the maven coordinates given with --packages. 
exclude_packages[] | **string**<br>List of groupId:artifactId, to exclude while resolving the dependencies provided in --packages to avoid dependency conflicts. 


### PysparkJob {#PysparkJob3}

Field | Description
--- | ---
args[] | **string**<br>Optional arguments to pass to the driver. 
jar_file_uris[] | **string**<br>JAR file URIs to add to CLASSPATH of the Data Proc driver and each task. 
file_uris[] | **string**<br>URIs of resource files to be copied to the working directory of Data Proc drivers and distributed Hadoop tasks. 
archive_uris[] | **string**<br>URIs of archives to be extracted to the working directory of Data Proc drivers and tasks. 
properties | **map<string,string>**<br>Property names and values, used to configure Data Proc and PySpark. 
main_python_file_uri | **string**<br>URI of the file with the driver code. Must be a .py file. 
python_file_uris[] | **string**<br>URIs of Python files to pass to the PySpark framework. 
packages[] | **string**<br>List of maven coordinates of jars to include on the driver and executor classpaths. 
repositories[] | **string**<br>List of additional remote repositories to search for the maven coordinates given with --packages. 
exclude_packages[] | **string**<br>List of groupId:artifactId, to exclude while resolving the dependencies provided in --packages to avoid dependency conflicts. 


### HiveJob {#HiveJob3}

Field | Description
--- | ---
properties | **map<string,string>**<br>Property names and values, used to configure Data Proc and Hive. 
continue_on_failure | **bool**<br>Flag indicating whether a job should continue to run if a query fails. 
script_variables | **map<string,string>**<br>Query variables and their values. 
jar_file_uris[] | **string**<br>JAR file URIs to add to CLASSPATH of the Hive driver and each task. 
query_type | **oneof:** `query_file_uri` or `query_list`<br>
&nbsp;&nbsp;query_file_uri | **string**<br>URI of the script with all the necessary Hive queries. 
&nbsp;&nbsp;query_list | **[QueryList](#QueryList3)**<br>List of Hive queries to be used in the job. 


### QueryList {#QueryList3}

Field | Description
--- | ---
queries[] | **string**<br>List of Hive queries. 


### ApplicationInfo {#ApplicationInfo3}

Field | Description
--- | ---
id | **string**<br>ID of YARN application 
application_attempts[] | **[ApplicationAttempt](#ApplicationAttempt3)**<br>YARN application attempts 


### ApplicationAttempt {#ApplicationAttempt3}

Field | Description
--- | ---
id | **string**<br>ID of YARN application attempt 
am_container_id | **string**<br>ID of YARN Application Master container 


