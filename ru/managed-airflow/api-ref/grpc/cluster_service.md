---
editable: false
sourcePath: en/_api-ref-grpc/managed-airflow/api-ref/grpc/cluster_service.md
---

# Managed Service for Apache Airflow™ API, gRPC: ClusterService

A set of methods for managing Apache Airflow Cluster resources.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specified Apache Airflow Cluster resource. |
| [List](#List) | Retrieves a list of Apache Airflow Cluster resources. |
| [Create](#Create) | Creates an Apache Airflow cluster. |
| [Update](#Update) | Updates the specified Apache Airflow cluster. |
| [Delete](#Delete) | Deletes the specified Apache Airflow cluster. |
| [Start](#Start) | Starts the specified Apache Airflow cluster. |
| [Stop](#Stop) | Stops the specified Apache Airflow cluster. |
| [ListOperations](#ListOperations) | Retrieves the list of Operation resources for the specified cluster. |

## Calls ClusterService {#calls}

## Get {#Get}

Returns the specified Apache Airflow Cluster resource.

**rpc Get ([GetClusterRequest](#GetClusterRequest)) returns ([Cluster](#Cluster))**

### GetClusterRequest {#GetClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Apache Airflow Cluster resource to return. The maximum string length in characters is 50.


### Cluster {#Cluster}

Field | Description
--- | ---
id | **string**<br>Unique ID of the Apache Airflow cluster. This ID is assigned by Cloud during cluster creation. 
folder_id | **string**<br>ID of the folder that the Apache Airflow cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Apache Airflow cluster was created. 
name | **string**<br>Name of the Apache Airflow cluster. The name is unique within the folder. 1-64 characters long. 
description | **string**<br>Description of the Apache Airflow cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. Maximum of 64 per resource. 
monitoring[] | **[Monitoring](#Monitoring)**<br>Monitoring systems relevant to the Apache Airflow cluster. 
config | **[ClusterConfig](#ClusterConfig)**<br>Configuration of Apache Airflow components. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: Cluster is in unknown state (we have no data).</li><li>`ALIVE`: Cluster is alive and well.</li><li>`DEAD`: Cluster is inoperable (it cannot perform any of its essential functions).</li><li>`DEGRADED`: Cluster is partially alive (it can perform some of its essential functions).</li></ul>
status | enum **Status**<br>Cluster status. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster is stopped.</li><li>`STARTING`: Cluster is starting.</li><li>`UPDATING`: Cluster is being updated.</li></ul>
network | **[NetworkConfig](#NetworkConfig)**<br>Network related configuration options. 
code_sync | **[CodeSyncConfig](#CodeSyncConfig)**<br>Parameters of the location and access to the code that will be executed in the cluster. 
deletion_protection | **bool**<br>Deletion Protection inhibits deletion of the cluster. 
webserver_url | **string**<br>Address of Apache Airflow web UI. 
service_account_id | **string**<br>Service account used to access Cloud resources. For more information, see [documentation](/docs/managed-airflow/concepts/impersonation). The maximum string length in characters is 50.
logging | **[LoggingConfig](#LoggingConfig)**<br>Cloud Logging configuration. 


### Monitoring {#Monitoring}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system. 


### ClusterConfig {#ClusterConfig}

Field | Description
--- | ---
version_id | **string**<br>Version of Apache that runs on the cluster. 
airflow | **[AirflowConfig](#AirflowConfig)**<br>Configuration of the Apache Airflow application itself. 
webserver | **[WebserverConfig](#WebserverConfig)**<br>Required. Configuration of webserver instances. 
scheduler | **[SchedulerConfig](#SchedulerConfig)**<br>Required. Configuration of scheduler instances. 
triggerer | **[TriggererConfig](#TriggererConfig)**<br>Configuration of triggerer instances. 
worker | **[WorkerConfig](#WorkerConfig)**<br>Required. Configuration of worker instances. 
dependencies | **[Dependencies](#Dependencies)**<br>The list of additional packages installed in the cluster. 
lockbox | **[LockboxConfig](#LockboxConfig)**<br>Configuration of Lockbox Secret Backend. 


### AirflowConfig {#AirflowConfig}

Field | Description
--- | ---
config | **map<string,string>**<br>Properties to be passed to Apache Airflow configuration file. 


### WebserverConfig {#WebserverConfig}

Field | Description
--- | ---
count | **int64**<br>The number of webserver instances in the cluster. Acceptable values are 1 to 512, inclusive.
resources | **[Resources](#Resources)**<br>Resources allocated to webserver instances. 


### Resources {#Resources}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to an instance (CPU, memory etc.). 


### SchedulerConfig {#SchedulerConfig}

Field | Description
--- | ---
count | **int64**<br>The number of scheduler instances in the cluster. Acceptable values are 1 to 512, inclusive.
resources | **[Resources](#Resources1)**<br>Resources allocated to scheduler instances. 


### TriggererConfig {#TriggererConfig}

Field | Description
--- | ---
count | **int64**<br>The number of triggerer instances in the cluster. Acceptable values are 0 to 512, inclusive.
resources | **[Resources](#Resources1)**<br>Resources allocated to triggerer instances. 


### WorkerConfig {#WorkerConfig}

Field | Description
--- | ---
min_count | **int64**<br>The minimum number of worker instances in the cluster. Acceptable values are 0 to 512, inclusive.
max_count | **int64**<br>The maximum number of worker instances in the cluster. Acceptable values are 1 to 512, inclusive.
resources | **[Resources](#Resources1)**<br>Resources allocated to worker instances. 


### Dependencies {#Dependencies}

Field | Description
--- | ---
pip_packages[] | **string**<br>Python packages that are installed in the cluster. 
deb_packages[] | **string**<br>System packages that are installed in the cluster. 


### LockboxConfig {#LockboxConfig}

Field | Description
--- | ---
enabled | **bool**<br>The setting allows to enable Lockbox Secret Backend. 


### NetworkConfig {#NetworkConfig}

Field | Description
--- | ---
subnet_ids[] | **string**<br>IDs of VPC network subnets where instances of the cluster are attached. 
security_group_ids[] | **string**<br>User security groups. 


### CodeSyncConfig {#CodeSyncConfig}

Field | Description
--- | ---
source | **oneof:** `s3`<br>
&nbsp;&nbsp;s3 | **[S3Config](#S3Config)**<br> 


### S3Config {#S3Config}

Field | Description
--- | ---
bucket | **string**<br>The name of the Object Storage bucket that stores DAG files used in the cluster. 


### LoggingConfig {#LoggingConfig}

Field | Description
--- | ---
enabled | **bool**<br>Logs generated by the Airflow components are delivered to Cloud Logging. 
destination | **oneof:** `folder_id` or `log_group_id`<br>Destination of log records.
&nbsp;&nbsp;folder_id | **string**<br>Logs should be written to default log group for specified folder. Value must match the regular expression ` ([a-zA-Z][-a-zA-Z0-9_.]{0,63})? `.
&nbsp;&nbsp;log_group_id | **string**<br>Logs should be written to log group resolved by ID. Value must match the regular expression ` ([a-zA-Z][-a-zA-Z0-9_.]{0,63})? `.
min_level | **`yandex.cloud.logging.v1.LogLevel.Level`**<br>Minimum log entry level. <br>See [LogLevel.Level] for details. 


## List {#List}

Retrieves a list of Apache Airflow Cluster resources.

**rpc List ([ListClustersRequest](#ListClustersRequest)) returns ([ListClustersResponse](#ListClustersResponse))**

### ListClustersRequest {#ListClustersRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to list Apache Airflow clusters in. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListClustersResponse.next_page_token](#ListClustersResponse) that can be used to get the next page of results in subsequent list requests. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListClustersResponse.next_page_token](#ListClustersResponse) returned by the previous list request. The maximum string length in characters is 100.
filter | **string**<br>A filter expression that filters resources listed in the response. The expression must specify: <ol><li>The field name. Currently you can only use filtering with the [Cluster.name](#Cluster1) field. </li><li>An `=` operator. </li><li>The value in double quotes (`"`). Must be 1-63 characters long and match the regular expression `[a-zA-Z0-9_-]+`.</li></ol> The maximum string length in characters is 1000.


### ListClustersResponse {#ListClustersResponse}

Field | Description
--- | ---
clusters[] | **[Cluster](#Cluster1)**<br>List of Apache Airflow Cluster resources. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListClustersRequest.page_size](#ListClustersRequest), use the `next_page_token` as the value for the [ListClustersRequest.page_token](#ListClustersRequest) parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### Cluster {#Cluster1}

Field | Description
--- | ---
id | **string**<br>Unique ID of the Apache Airflow cluster. This ID is assigned by Cloud during cluster creation. 
folder_id | **string**<br>ID of the folder that the Apache Airflow cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Apache Airflow cluster was created. 
name | **string**<br>Name of the Apache Airflow cluster. The name is unique within the folder. 1-64 characters long. 
description | **string**<br>Description of the Apache Airflow cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. Maximum of 64 per resource. 
monitoring[] | **[Monitoring](#Monitoring1)**<br>Monitoring systems relevant to the Apache Airflow cluster. 
config | **[ClusterConfig](#ClusterConfig1)**<br>Configuration of Apache Airflow components. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: Cluster is in unknown state (we have no data).</li><li>`ALIVE`: Cluster is alive and well.</li><li>`DEAD`: Cluster is inoperable (it cannot perform any of its essential functions).</li><li>`DEGRADED`: Cluster is partially alive (it can perform some of its essential functions).</li></ul>
status | enum **Status**<br>Cluster status. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster is stopped.</li><li>`STARTING`: Cluster is starting.</li><li>`UPDATING`: Cluster is being updated.</li></ul>
network | **[NetworkConfig](#NetworkConfig1)**<br>Network related configuration options. 
code_sync | **[CodeSyncConfig](#CodeSyncConfig1)**<br>Parameters of the location and access to the code that will be executed in the cluster. 
deletion_protection | **bool**<br>Deletion Protection inhibits deletion of the cluster. 
webserver_url | **string**<br>Address of Apache Airflow web UI. 
service_account_id | **string**<br>Service account used to access Cloud resources. For more information, see [documentation](/docs/managed-airflow/concepts/impersonation). The maximum string length in characters is 50.
logging | **[LoggingConfig](#LoggingConfig1)**<br>Cloud Logging configuration. 


### Monitoring {#Monitoring1}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system. 


### ClusterConfig {#ClusterConfig1}

Field | Description
--- | ---
version_id | **string**<br>Version of Apache that runs on the cluster. 
airflow | **[AirflowConfig](#AirflowConfig1)**<br>Configuration of the Apache Airflow application itself. 
webserver | **[WebserverConfig](#WebserverConfig1)**<br>Required. Configuration of webserver instances. 
scheduler | **[SchedulerConfig](#SchedulerConfig1)**<br>Required. Configuration of scheduler instances. 
triggerer | **[TriggererConfig](#TriggererConfig1)**<br>Configuration of triggerer instances. 
worker | **[WorkerConfig](#WorkerConfig1)**<br>Required. Configuration of worker instances. 
dependencies | **[Dependencies](#Dependencies1)**<br>The list of additional packages installed in the cluster. 
lockbox | **[LockboxConfig](#LockboxConfig1)**<br>Configuration of Lockbox Secret Backend. 


### AirflowConfig {#AirflowConfig1}

Field | Description
--- | ---
config | **map<string,string>**<br>Properties to be passed to Apache Airflow configuration file. 


### WebserverConfig {#WebserverConfig1}

Field | Description
--- | ---
count | **int64**<br>The number of webserver instances in the cluster. Acceptable values are 1 to 512, inclusive.
resources | **[Resources](#Resources1)**<br>Resources allocated to webserver instances. 


### Resources {#Resources1}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to an instance (CPU, memory etc.). 


### SchedulerConfig {#SchedulerConfig1}

Field | Description
--- | ---
count | **int64**<br>The number of scheduler instances in the cluster. Acceptable values are 1 to 512, inclusive.
resources | **[Resources](#Resources2)**<br>Resources allocated to scheduler instances. 


### TriggererConfig {#TriggererConfig1}

Field | Description
--- | ---
count | **int64**<br>The number of triggerer instances in the cluster. Acceptable values are 0 to 512, inclusive.
resources | **[Resources](#Resources2)**<br>Resources allocated to triggerer instances. 


### WorkerConfig {#WorkerConfig1}

Field | Description
--- | ---
min_count | **int64**<br>The minimum number of worker instances in the cluster. Acceptable values are 0 to 512, inclusive.
max_count | **int64**<br>The maximum number of worker instances in the cluster. Acceptable values are 1 to 512, inclusive.
resources | **[Resources](#Resources2)**<br>Resources allocated to worker instances. 


### Dependencies {#Dependencies1}

Field | Description
--- | ---
pip_packages[] | **string**<br>Python packages that are installed in the cluster. 
deb_packages[] | **string**<br>System packages that are installed in the cluster. 


### LockboxConfig {#LockboxConfig1}

Field | Description
--- | ---
enabled | **bool**<br>The setting allows to enable Lockbox Secret Backend. 


### NetworkConfig {#NetworkConfig1}

Field | Description
--- | ---
subnet_ids[] | **string**<br>IDs of VPC network subnets where instances of the cluster are attached. 
security_group_ids[] | **string**<br>User security groups. 


### CodeSyncConfig {#CodeSyncConfig1}

Field | Description
--- | ---
source | **oneof:** `s3`<br>
&nbsp;&nbsp;s3 | **[S3Config](#S3Config1)**<br> 


### S3Config {#S3Config1}

Field | Description
--- | ---
bucket | **string**<br>The name of the Object Storage bucket that stores DAG files used in the cluster. 


### LoggingConfig {#LoggingConfig1}

Field | Description
--- | ---
enabled | **bool**<br>Logs generated by the Airflow components are delivered to Cloud Logging. 
destination | **oneof:** `folder_id` or `log_group_id`<br>Destination of log records.
&nbsp;&nbsp;folder_id | **string**<br>Logs should be written to default log group for specified folder. Value must match the regular expression ` ([a-zA-Z][-a-zA-Z0-9_.]{0,63})? `.
&nbsp;&nbsp;log_group_id | **string**<br>Logs should be written to log group resolved by ID. Value must match the regular expression ` ([a-zA-Z][-a-zA-Z0-9_.]{0,63})? `.
min_level | **`yandex.cloud.logging.v1.LogLevel.Level`**<br>Minimum log entry level. <br>See [LogLevel.Level] for details. 


## Create {#Create}

Creates an Apache Airflow cluster.

**rpc Create ([CreateClusterRequest](#CreateClusterRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateClusterMetadata](#CreateClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster2)<br>

### CreateClusterRequest {#CreateClusterRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to create Apache Airflow cluster in. The maximum string length in characters is 50.
name | **string**<br>Required. Name of the Apache Airflow cluster. The name must be unique within the folder. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
description | **string**<br>Description of the Apache Airflow cluster. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Custom labels for the Apache Airflow cluster as `` key:value `` pairs. For example, "env": "prod". No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The maximum string length in characters for each key is 63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
config | **[ClusterConfig](#ClusterConfig2)**<br>Required. Configuration of Apache Airflow components. 
network | **[NetworkConfig](#NetworkConfig2)**<br>Network related configuration options. 
code_sync | **[CodeSyncConfig](#CodeSyncConfig2)**<br>Parameters of the location and access to the code that will be executed in the cluster. 
deletion_protection | **bool**<br>Deletion Protection inhibits deletion of the cluster. 
service_account_id | **string**<br>Service account used to access Cloud resources. For more information, see [documentation](/docs/managed-airflow/concepts/impersonation). The maximum string length in characters is 50.
logging | **[LoggingConfig](#LoggingConfig2)**<br>Cloud Logging configuration. 
admin_password | **string**<br>Required. Password of user `admin`. The string length in characters must be 8-128.


### ClusterConfig {#ClusterConfig2}

Field | Description
--- | ---
version_id | **string**<br>Version of Apache that runs on the cluster. 
airflow | **[AirflowConfig](#AirflowConfig2)**<br>Configuration of the Apache Airflow application itself. 
webserver | **[WebserverConfig](#WebserverConfig2)**<br>Required. Configuration of webserver instances. 
scheduler | **[SchedulerConfig](#SchedulerConfig2)**<br>Required. Configuration of scheduler instances. 
triggerer | **[TriggererConfig](#TriggererConfig2)**<br>Configuration of triggerer instances. 
worker | **[WorkerConfig](#WorkerConfig2)**<br>Required. Configuration of worker instances. 
dependencies | **[Dependencies](#Dependencies2)**<br>The list of additional packages installed in the cluster. 
lockbox | **[LockboxConfig](#LockboxConfig2)**<br>Configuration of Lockbox Secret Backend. 


### AirflowConfig {#AirflowConfig2}

Field | Description
--- | ---
config | **map<string,string>**<br>Properties to be passed to Apache Airflow configuration file. 


### WebserverConfig {#WebserverConfig2}

Field | Description
--- | ---
count | **int64**<br>The number of webserver instances in the cluster. Acceptable values are 1 to 512, inclusive.
resources | **[Resources](#Resources2)**<br>Resources allocated to webserver instances. 


### Resources {#Resources2}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to an instance (CPU, memory etc.). 


### SchedulerConfig {#SchedulerConfig2}

Field | Description
--- | ---
count | **int64**<br>The number of scheduler instances in the cluster. Acceptable values are 1 to 512, inclusive.
resources | **[Resources](#Resources3)**<br>Resources allocated to scheduler instances. 


### TriggererConfig {#TriggererConfig2}

Field | Description
--- | ---
count | **int64**<br>The number of triggerer instances in the cluster. Acceptable values are 0 to 512, inclusive.
resources | **[Resources](#Resources3)**<br>Resources allocated to triggerer instances. 


### WorkerConfig {#WorkerConfig2}

Field | Description
--- | ---
min_count | **int64**<br>The minimum number of worker instances in the cluster. Acceptable values are 0 to 512, inclusive.
max_count | **int64**<br>The maximum number of worker instances in the cluster. Acceptable values are 1 to 512, inclusive.
resources | **[Resources](#Resources3)**<br>Resources allocated to worker instances. 


### Dependencies {#Dependencies2}

Field | Description
--- | ---
pip_packages[] | **string**<br>Python packages that are installed in the cluster. 
deb_packages[] | **string**<br>System packages that are installed in the cluster. 


### LockboxConfig {#LockboxConfig2}

Field | Description
--- | ---
enabled | **bool**<br>The setting allows to enable Lockbox Secret Backend. 


### NetworkConfig {#NetworkConfig2}

Field | Description
--- | ---
subnet_ids[] | **string**<br>IDs of VPC network subnets where instances of the cluster are attached. 
security_group_ids[] | **string**<br>User security groups. 


### CodeSyncConfig {#CodeSyncConfig2}

Field | Description
--- | ---
source | **oneof:** `s3`<br>
&nbsp;&nbsp;s3 | **[S3Config](#S3Config2)**<br> 


### S3Config {#S3Config2}

Field | Description
--- | ---
bucket | **string**<br>The name of the Object Storage bucket that stores DAG files used in the cluster. 


### LoggingConfig {#LoggingConfig2}

Field | Description
--- | ---
enabled | **bool**<br>Logs generated by the Airflow components are delivered to Cloud Logging. 
destination | **oneof:** `folder_id` or `log_group_id`<br>Destination of log records.
&nbsp;&nbsp;folder_id | **string**<br>Logs should be written to default log group for specified folder. Value must match the regular expression ` ([a-zA-Z][-a-zA-Z0-9_.]{0,63})? `.
&nbsp;&nbsp;log_group_id | **string**<br>Logs should be written to log group resolved by ID. Value must match the regular expression ` ([a-zA-Z][-a-zA-Z0-9_.]{0,63})? `.
min_level | **`yandex.cloud.logging.v1.LogLevel.Level`**<br>Minimum log entry level. <br>See [LogLevel.Level] for details. 


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateClusterMetadata](#CreateClusterMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Cluster](#Cluster2)>**<br>if operation finished successfully. 


### CreateClusterMetadata {#CreateClusterMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>ID of the Apache Airflow cluster that is being created. 


### Cluster {#Cluster2}

Field | Description
--- | ---
id | **string**<br>Unique ID of the Apache Airflow cluster. This ID is assigned by Cloud during cluster creation. 
folder_id | **string**<br>ID of the folder that the Apache Airflow cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Apache Airflow cluster was created. 
name | **string**<br>Name of the Apache Airflow cluster. The name is unique within the folder. 1-64 characters long. 
description | **string**<br>Description of the Apache Airflow cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. Maximum of 64 per resource. 
monitoring[] | **[Monitoring](#Monitoring2)**<br>Monitoring systems relevant to the Apache Airflow cluster. 
config | **[ClusterConfig](#ClusterConfig3)**<br>Configuration of Apache Airflow components. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: Cluster is in unknown state (we have no data).</li><li>`ALIVE`: Cluster is alive and well.</li><li>`DEAD`: Cluster is inoperable (it cannot perform any of its essential functions).</li><li>`DEGRADED`: Cluster is partially alive (it can perform some of its essential functions).</li></ul>
status | enum **Status**<br>Cluster status. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster is stopped.</li><li>`STARTING`: Cluster is starting.</li><li>`UPDATING`: Cluster is being updated.</li></ul>
network | **[NetworkConfig](#NetworkConfig3)**<br>Network related configuration options. 
code_sync | **[CodeSyncConfig](#CodeSyncConfig3)**<br>Parameters of the location and access to the code that will be executed in the cluster. 
deletion_protection | **bool**<br>Deletion Protection inhibits deletion of the cluster. 
webserver_url | **string**<br>Address of Apache Airflow web UI. 
service_account_id | **string**<br>Service account used to access Cloud resources. For more information, see [documentation](/docs/managed-airflow/concepts/impersonation). The maximum string length in characters is 50.
logging | **[LoggingConfig](#LoggingConfig3)**<br>Cloud Logging configuration. 


### Monitoring {#Monitoring2}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system. 


## Update {#Update}

Updates the specified Apache Airflow cluster.

**rpc Update ([UpdateClusterRequest](#UpdateClusterRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateClusterMetadata](#UpdateClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster3)<br>

### UpdateClusterRequest {#UpdateClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Apache Airflow Cluster resource to update. The maximum string length in characters is 50.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Field mask that specifies which fields of the Apache Airflow Cluster resource should be updated. 
name | **string**<br>New name of the cluster. Value must match the regular expression ` \|[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br>New description of the Apache Airflow cluster. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Custom labels for the Apache Airflow cluster as `` key:value `` pairs. For example, "env": "prod". <br>The new set of labels will completely replace the old ones. To add a label, request the current set with the [ClusterService.Get](#Get) method, then send an [ClusterService.Update](#Update) request with the new label added to the set. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
config_spec | **[UpdateClusterConfigSpec](#UpdateClusterConfigSpec)**<br>Configuration of Apache Airflow components. 
code_sync | **[CodeSyncConfig](#CodeSyncConfig3)**<br>Parameters of the location and access to the code that will be executed in the cluster. 
network_spec | **[UpdateNetworkConfigSpec](#UpdateNetworkConfigSpec)**<br>Network related configuration options. 
deletion_protection | **bool**<br>Deletion Protection inhibits deletion of the cluster 
service_account_id | **string**<br>Service account used to access Cloud resources. For more information, see [documentation](/docs/managed-airflow/concepts/impersonation). The maximum string length in characters is 50.
logging | **[LoggingConfig](#LoggingConfig3)**<br>Cloud Logging configuration. 


### UpdateClusterConfigSpec {#UpdateClusterConfigSpec}

Field | Description
--- | ---
airflow | **[AirflowConfig](#AirflowConfig3)**<br>Configuration of the Apache Airflow application itself. 
webserver | **[WebserverConfig](#WebserverConfig3)**<br>Configuration of webserver instances. 
scheduler | **[SchedulerConfig](#SchedulerConfig3)**<br>Configuration of scheduler instances. 
triggerer | **[TriggererConfig](#TriggererConfig3)**<br>Configuration of triggerer instances. 
worker | **[WorkerConfig](#WorkerConfig3)**<br>Configuration of worker instances. 
dependencies | **[Dependencies](#Dependencies3)**<br>The list of additional packages installed in the cluster. 
lockbox | **[LockboxConfig](#LockboxConfig3)**<br>Configuration of Lockbox Secret Backend. 


### AirflowConfig {#AirflowConfig3}

Field | Description
--- | ---
config | **map<string,string>**<br>Properties to be passed to Apache Airflow configuration file. 


### WebserverConfig {#WebserverConfig3}

Field | Description
--- | ---
count | **int64**<br>The number of webserver instances in the cluster. Acceptable values are 1 to 512, inclusive.
resources | **[Resources](#Resources3)**<br>Resources allocated to webserver instances. 


### Resources {#Resources3}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to an instance (CPU, memory etc.). 


### SchedulerConfig {#SchedulerConfig3}

Field | Description
--- | ---
count | **int64**<br>The number of scheduler instances in the cluster. Acceptable values are 1 to 512, inclusive.
resources | **[Resources](#Resources4)**<br>Resources allocated to scheduler instances. 


### TriggererConfig {#TriggererConfig3}

Field | Description
--- | ---
count | **int64**<br>The number of triggerer instances in the cluster. Acceptable values are 0 to 512, inclusive.
resources | **[Resources](#Resources4)**<br>Resources allocated to triggerer instances. 


### WorkerConfig {#WorkerConfig3}

Field | Description
--- | ---
min_count | **int64**<br>The minimum number of worker instances in the cluster. Acceptable values are 0 to 512, inclusive.
max_count | **int64**<br>The maximum number of worker instances in the cluster. Acceptable values are 1 to 512, inclusive.
resources | **[Resources](#Resources4)**<br>Resources allocated to worker instances. 


### Dependencies {#Dependencies3}

Field | Description
--- | ---
pip_packages[] | **string**<br>Python packages that are installed in the cluster. 
deb_packages[] | **string**<br>System packages that are installed in the cluster. 


### LockboxConfig {#LockboxConfig3}

Field | Description
--- | ---
enabled | **bool**<br>The setting allows to enable Lockbox Secret Backend. 


### CodeSyncConfig {#CodeSyncConfig3}

Field | Description
--- | ---
source | **oneof:** `s3`<br>
&nbsp;&nbsp;s3 | **[S3Config](#S3Config3)**<br> 


### S3Config {#S3Config3}

Field | Description
--- | ---
bucket | **string**<br>The name of the Object Storage bucket that stores DAG files used in the cluster. 


### UpdateNetworkConfigSpec {#UpdateNetworkConfigSpec}

Field | Description
--- | ---
security_group_ids[] | **string**<br>User security groups. 


### LoggingConfig {#LoggingConfig3}

Field | Description
--- | ---
enabled | **bool**<br>Logs generated by the Airflow components are delivered to Cloud Logging. 
destination | **oneof:** `folder_id` or `log_group_id`<br>Destination of log records.
&nbsp;&nbsp;folder_id | **string**<br>Logs should be written to default log group for specified folder. Value must match the regular expression ` ([a-zA-Z][-a-zA-Z0-9_.]{0,63})? `.
&nbsp;&nbsp;log_group_id | **string**<br>Logs should be written to log group resolved by ID. Value must match the regular expression ` ([a-zA-Z][-a-zA-Z0-9_.]{0,63})? `.
min_level | **`yandex.cloud.logging.v1.LogLevel.Level`**<br>Minimum log entry level. <br>See [LogLevel.Level] for details. 


### Operation {#Operation1}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateClusterMetadata](#UpdateClusterMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Cluster](#Cluster3)>**<br>if operation finished successfully. 


### UpdateClusterMetadata {#UpdateClusterMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>ID of the Apache Airflow Cluster resource that is being updated. 


### Cluster {#Cluster3}

Field | Description
--- | ---
id | **string**<br>Unique ID of the Apache Airflow cluster. This ID is assigned by Cloud during cluster creation. 
folder_id | **string**<br>ID of the folder that the Apache Airflow cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Apache Airflow cluster was created. 
name | **string**<br>Name of the Apache Airflow cluster. The name is unique within the folder. 1-64 characters long. 
description | **string**<br>Description of the Apache Airflow cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. Maximum of 64 per resource. 
monitoring[] | **[Monitoring](#Monitoring3)**<br>Monitoring systems relevant to the Apache Airflow cluster. 
config | **[ClusterConfig](#ClusterConfig3)**<br>Configuration of Apache Airflow components. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: Cluster is in unknown state (we have no data).</li><li>`ALIVE`: Cluster is alive and well.</li><li>`DEAD`: Cluster is inoperable (it cannot perform any of its essential functions).</li><li>`DEGRADED`: Cluster is partially alive (it can perform some of its essential functions).</li></ul>
status | enum **Status**<br>Cluster status. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster is stopped.</li><li>`STARTING`: Cluster is starting.</li><li>`UPDATING`: Cluster is being updated.</li></ul>
network | **[NetworkConfig](#NetworkConfig3)**<br>Network related configuration options. 
code_sync | **[CodeSyncConfig](#CodeSyncConfig4)**<br>Parameters of the location and access to the code that will be executed in the cluster. 
deletion_protection | **bool**<br>Deletion Protection inhibits deletion of the cluster. 
webserver_url | **string**<br>Address of Apache Airflow web UI. 
service_account_id | **string**<br>Service account used to access Cloud resources. For more information, see [documentation](/docs/managed-airflow/concepts/impersonation). The maximum string length in characters is 50.
logging | **[LoggingConfig](#LoggingConfig4)**<br>Cloud Logging configuration. 


### Monitoring {#Monitoring3}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system. 


### ClusterConfig {#ClusterConfig3}

Field | Description
--- | ---
version_id | **string**<br>Version of Apache that runs on the cluster. 
airflow | **[AirflowConfig](#AirflowConfig4)**<br>Configuration of the Apache Airflow application itself. 
webserver | **[WebserverConfig](#WebserverConfig4)**<br>Required. Configuration of webserver instances. 
scheduler | **[SchedulerConfig](#SchedulerConfig4)**<br>Required. Configuration of scheduler instances. 
triggerer | **[TriggererConfig](#TriggererConfig4)**<br>Configuration of triggerer instances. 
worker | **[WorkerConfig](#WorkerConfig4)**<br>Required. Configuration of worker instances. 
dependencies | **[Dependencies](#Dependencies4)**<br>The list of additional packages installed in the cluster. 
lockbox | **[LockboxConfig](#LockboxConfig4)**<br>Configuration of Lockbox Secret Backend. 


### NetworkConfig {#NetworkConfig3}

Field | Description
--- | ---
subnet_ids[] | **string**<br>IDs of VPC network subnets where instances of the cluster are attached. 
security_group_ids[] | **string**<br>User security groups. 


## Delete {#Delete}

Deletes the specified Apache Airflow cluster.

**rpc Delete ([DeleteClusterRequest](#DeleteClusterRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteClusterMetadata](#DeleteClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteClusterRequest {#DeleteClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Apache Airflow cluster to delete. The maximum string length in characters is 50.


### Operation {#Operation2}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteClusterMetadata](#DeleteClusterMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### DeleteClusterMetadata {#DeleteClusterMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>ID of the Apache Airflow cluster that is being deleted. 


## Start {#Start}

Starts the specified Apache Airflow cluster.

**rpc Start ([StartClusterRequest](#StartClusterRequest)) returns ([operation.Operation](#Operation3))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[StartClusterMetadata](#StartClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster4)<br>

### StartClusterRequest {#StartClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Apache Airflow cluster to start. The maximum string length in characters is 50.


### Operation {#Operation3}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[StartClusterMetadata](#StartClusterMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Cluster](#Cluster4)>**<br>if operation finished successfully. 


### StartClusterMetadata {#StartClusterMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>ID of the Apache Airflow cluster that is being started. 


### Cluster {#Cluster4}

Field | Description
--- | ---
id | **string**<br>Unique ID of the Apache Airflow cluster. This ID is assigned by Cloud during cluster creation. 
folder_id | **string**<br>ID of the folder that the Apache Airflow cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Apache Airflow cluster was created. 
name | **string**<br>Name of the Apache Airflow cluster. The name is unique within the folder. 1-64 characters long. 
description | **string**<br>Description of the Apache Airflow cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. Maximum of 64 per resource. 
monitoring[] | **[Monitoring](#Monitoring4)**<br>Monitoring systems relevant to the Apache Airflow cluster. 
config | **[ClusterConfig](#ClusterConfig4)**<br>Configuration of Apache Airflow components. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: Cluster is in unknown state (we have no data).</li><li>`ALIVE`: Cluster is alive and well.</li><li>`DEAD`: Cluster is inoperable (it cannot perform any of its essential functions).</li><li>`DEGRADED`: Cluster is partially alive (it can perform some of its essential functions).</li></ul>
status | enum **Status**<br>Cluster status. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster is stopped.</li><li>`STARTING`: Cluster is starting.</li><li>`UPDATING`: Cluster is being updated.</li></ul>
network | **[NetworkConfig](#NetworkConfig4)**<br>Network related configuration options. 
code_sync | **[CodeSyncConfig](#CodeSyncConfig4)**<br>Parameters of the location and access to the code that will be executed in the cluster. 
deletion_protection | **bool**<br>Deletion Protection inhibits deletion of the cluster. 
webserver_url | **string**<br>Address of Apache Airflow web UI. 
service_account_id | **string**<br>Service account used to access Cloud resources. For more information, see [documentation](/docs/managed-airflow/concepts/impersonation). The maximum string length in characters is 50.
logging | **[LoggingConfig](#LoggingConfig4)**<br>Cloud Logging configuration. 


### Monitoring {#Monitoring4}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system. 


### ClusterConfig {#ClusterConfig4}

Field | Description
--- | ---
version_id | **string**<br>Version of Apache that runs on the cluster. 
airflow | **[AirflowConfig](#AirflowConfig4)**<br>Configuration of the Apache Airflow application itself. 
webserver | **[WebserverConfig](#WebserverConfig4)**<br>Required. Configuration of webserver instances. 
scheduler | **[SchedulerConfig](#SchedulerConfig4)**<br>Required. Configuration of scheduler instances. 
triggerer | **[TriggererConfig](#TriggererConfig4)**<br>Configuration of triggerer instances. 
worker | **[WorkerConfig](#WorkerConfig4)**<br>Required. Configuration of worker instances. 
dependencies | **[Dependencies](#Dependencies4)**<br>The list of additional packages installed in the cluster. 
lockbox | **[LockboxConfig](#LockboxConfig4)**<br>Configuration of Lockbox Secret Backend. 


### AirflowConfig {#AirflowConfig4}

Field | Description
--- | ---
config | **map<string,string>**<br>Properties to be passed to Apache Airflow configuration file. 


### WebserverConfig {#WebserverConfig4}

Field | Description
--- | ---
count | **int64**<br>The number of webserver instances in the cluster. Acceptable values are 1 to 512, inclusive.
resources | **[Resources](#Resources4)**<br>Resources allocated to webserver instances. 


### Resources {#Resources4}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to an instance (CPU, memory etc.). 


### SchedulerConfig {#SchedulerConfig4}

Field | Description
--- | ---
count | **int64**<br>The number of scheduler instances in the cluster. Acceptable values are 1 to 512, inclusive.
resources | **[Resources](#Resources5)**<br>Resources allocated to scheduler instances. 


### TriggererConfig {#TriggererConfig4}

Field | Description
--- | ---
count | **int64**<br>The number of triggerer instances in the cluster. Acceptable values are 0 to 512, inclusive.
resources | **[Resources](#Resources5)**<br>Resources allocated to triggerer instances. 


### WorkerConfig {#WorkerConfig4}

Field | Description
--- | ---
min_count | **int64**<br>The minimum number of worker instances in the cluster. Acceptable values are 0 to 512, inclusive.
max_count | **int64**<br>The maximum number of worker instances in the cluster. Acceptable values are 1 to 512, inclusive.
resources | **[Resources](#Resources5)**<br>Resources allocated to worker instances. 


### Dependencies {#Dependencies4}

Field | Description
--- | ---
pip_packages[] | **string**<br>Python packages that are installed in the cluster. 
deb_packages[] | **string**<br>System packages that are installed in the cluster. 


### LockboxConfig {#LockboxConfig4}

Field | Description
--- | ---
enabled | **bool**<br>The setting allows to enable Lockbox Secret Backend. 


### NetworkConfig {#NetworkConfig4}

Field | Description
--- | ---
subnet_ids[] | **string**<br>IDs of VPC network subnets where instances of the cluster are attached. 
security_group_ids[] | **string**<br>User security groups. 


### CodeSyncConfig {#CodeSyncConfig4}

Field | Description
--- | ---
source | **oneof:** `s3`<br>
&nbsp;&nbsp;s3 | **[S3Config](#S3Config4)**<br> 


### S3Config {#S3Config4}

Field | Description
--- | ---
bucket | **string**<br>The name of the Object Storage bucket that stores DAG files used in the cluster. 


### LoggingConfig {#LoggingConfig4}

Field | Description
--- | ---
enabled | **bool**<br>Logs generated by the Airflow components are delivered to Cloud Logging. 
destination | **oneof:** `folder_id` or `log_group_id`<br>Destination of log records.
&nbsp;&nbsp;folder_id | **string**<br>Logs should be written to default log group for specified folder. Value must match the regular expression ` ([a-zA-Z][-a-zA-Z0-9_.]{0,63})? `.
&nbsp;&nbsp;log_group_id | **string**<br>Logs should be written to log group resolved by ID. Value must match the regular expression ` ([a-zA-Z][-a-zA-Z0-9_.]{0,63})? `.
min_level | **`yandex.cloud.logging.v1.LogLevel.Level`**<br>Minimum log entry level. <br>See [LogLevel.Level] for details. 


## Stop {#Stop}

Stops the specified Apache Airflow cluster.

**rpc Stop ([StopClusterRequest](#StopClusterRequest)) returns ([operation.Operation](#Operation4))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[StopClusterMetadata](#StopClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster5)<br>

### StopClusterRequest {#StopClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Apache Airflow cluster to stop. The maximum string length in characters is 50.


### Operation {#Operation4}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[StopClusterMetadata](#StopClusterMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Cluster](#Cluster5)>**<br>if operation finished successfully. 


### StopClusterMetadata {#StopClusterMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>ID of the Apache Airflow cluster that is being stopped. 


### Cluster {#Cluster5}

Field | Description
--- | ---
id | **string**<br>Unique ID of the Apache Airflow cluster. This ID is assigned by Cloud during cluster creation. 
folder_id | **string**<br>ID of the folder that the Apache Airflow cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Apache Airflow cluster was created. 
name | **string**<br>Name of the Apache Airflow cluster. The name is unique within the folder. 1-64 characters long. 
description | **string**<br>Description of the Apache Airflow cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. Maximum of 64 per resource. 
monitoring[] | **[Monitoring](#Monitoring5)**<br>Monitoring systems relevant to the Apache Airflow cluster. 
config | **[ClusterConfig](#ClusterConfig5)**<br>Configuration of Apache Airflow components. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: Cluster is in unknown state (we have no data).</li><li>`ALIVE`: Cluster is alive and well.</li><li>`DEAD`: Cluster is inoperable (it cannot perform any of its essential functions).</li><li>`DEGRADED`: Cluster is partially alive (it can perform some of its essential functions).</li></ul>
status | enum **Status**<br>Cluster status. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster is stopped.</li><li>`STARTING`: Cluster is starting.</li><li>`UPDATING`: Cluster is being updated.</li></ul>
network | **[NetworkConfig](#NetworkConfig5)**<br>Network related configuration options. 
code_sync | **[CodeSyncConfig](#CodeSyncConfig5)**<br>Parameters of the location and access to the code that will be executed in the cluster. 
deletion_protection | **bool**<br>Deletion Protection inhibits deletion of the cluster. 
webserver_url | **string**<br>Address of Apache Airflow web UI. 
service_account_id | **string**<br>Service account used to access Cloud resources. For more information, see [documentation](/docs/managed-airflow/concepts/impersonation). The maximum string length in characters is 50.
logging | **[LoggingConfig](#LoggingConfig5)**<br>Cloud Logging configuration. 


### Monitoring {#Monitoring5}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system. 


### ClusterConfig {#ClusterConfig5}

Field | Description
--- | ---
version_id | **string**<br>Version of Apache that runs on the cluster. 
airflow | **[AirflowConfig](#AirflowConfig5)**<br>Configuration of the Apache Airflow application itself. 
webserver | **[WebserverConfig](#WebserverConfig5)**<br>Required. Configuration of webserver instances. 
scheduler | **[SchedulerConfig](#SchedulerConfig5)**<br>Required. Configuration of scheduler instances. 
triggerer | **[TriggererConfig](#TriggererConfig5)**<br>Configuration of triggerer instances. 
worker | **[WorkerConfig](#WorkerConfig5)**<br>Required. Configuration of worker instances. 
dependencies | **[Dependencies](#Dependencies5)**<br>The list of additional packages installed in the cluster. 
lockbox | **[LockboxConfig](#LockboxConfig5)**<br>Configuration of Lockbox Secret Backend. 


### AirflowConfig {#AirflowConfig5}

Field | Description
--- | ---
config | **map<string,string>**<br>Properties to be passed to Apache Airflow configuration file. 


### WebserverConfig {#WebserverConfig5}

Field | Description
--- | ---
count | **int64**<br>The number of webserver instances in the cluster. Acceptable values are 1 to 512, inclusive.
resources | **[Resources](#Resources5)**<br>Resources allocated to webserver instances. 


### Resources {#Resources5}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to an instance (CPU, memory etc.). 


### SchedulerConfig {#SchedulerConfig5}

Field | Description
--- | ---
count | **int64**<br>The number of scheduler instances in the cluster. Acceptable values are 1 to 512, inclusive.
resources | **[Resources](#Resources6)**<br>Resources allocated to scheduler instances. 


### TriggererConfig {#TriggererConfig5}

Field | Description
--- | ---
count | **int64**<br>The number of triggerer instances in the cluster. Acceptable values are 0 to 512, inclusive.
resources | **[Resources](#Resources6)**<br>Resources allocated to triggerer instances. 


### WorkerConfig {#WorkerConfig5}

Field | Description
--- | ---
min_count | **int64**<br>The minimum number of worker instances in the cluster. Acceptable values are 0 to 512, inclusive.
max_count | **int64**<br>The maximum number of worker instances in the cluster. Acceptable values are 1 to 512, inclusive.
resources | **[Resources](#Resources6)**<br>Resources allocated to worker instances. 


### Dependencies {#Dependencies5}

Field | Description
--- | ---
pip_packages[] | **string**<br>Python packages that are installed in the cluster. 
deb_packages[] | **string**<br>System packages that are installed in the cluster. 


### LockboxConfig {#LockboxConfig5}

Field | Description
--- | ---
enabled | **bool**<br>The setting allows to enable Lockbox Secret Backend. 


### NetworkConfig {#NetworkConfig5}

Field | Description
--- | ---
subnet_ids[] | **string**<br>IDs of VPC network subnets where instances of the cluster are attached. 
security_group_ids[] | **string**<br>User security groups. 


### CodeSyncConfig {#CodeSyncConfig5}

Field | Description
--- | ---
source | **oneof:** `s3`<br>
&nbsp;&nbsp;s3 | **[S3Config](#S3Config5)**<br> 


### S3Config {#S3Config5}

Field | Description
--- | ---
bucket | **string**<br>The name of the Object Storage bucket that stores DAG files used in the cluster. 


### LoggingConfig {#LoggingConfig5}

Field | Description
--- | ---
enabled | **bool**<br>Logs generated by the Airflow components are delivered to Cloud Logging. 
destination | **oneof:** `folder_id` or `log_group_id`<br>Destination of log records.
&nbsp;&nbsp;folder_id | **string**<br>Logs should be written to default log group for specified folder. Value must match the regular expression ` ([a-zA-Z][-a-zA-Z0-9_.]{0,63})? `.
&nbsp;&nbsp;log_group_id | **string**<br>Logs should be written to log group resolved by ID. Value must match the regular expression ` ([a-zA-Z][-a-zA-Z0-9_.]{0,63})? `.
min_level | **`yandex.cloud.logging.v1.LogLevel.Level`**<br>Minimum log entry level. <br>See [LogLevel.Level] for details. 


## ListOperations {#ListOperations}

Retrieves the list of Operation resources for the specified cluster.

**rpc ListOperations ([ListClusterOperationsRequest](#ListClusterOperationsRequest)) returns ([ListClusterOperationsResponse](#ListClusterOperationsResponse))**

### ListClusterOperationsRequest {#ListClusterOperationsRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Apache Airflow Cluster resource to list operations for. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListClusterOperationsResponse.next_page_token](#ListClusterOperationsResponse) that can be used to get the next page of results in subsequent list requests. The maximum value is 1000.
page_token | **string**<br>Page token.  To get the next page of results, set `page_token` to the [ListClusterOperationsResponse.next_page_token](#ListClusterOperationsResponse) returned by the previous list request. The maximum string length in characters is 100.


### ListClusterOperationsResponse {#ListClusterOperationsResponse}

Field | Description
--- | ---
operations[] | **[operation.Operation](#Operation5)**<br>List of Operation resources for the specified Apache Airflow cluster. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListClusterOperationsRequest.page_size](#ListClusterOperationsRequest), use the `next_page_token` as the value for the [ListClusterOperationsRequest.page_token](#ListClusterOperationsRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### Operation {#Operation5}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**<br>The normal response of the operation in case of success. If the original method returns no data on success, such as Delete, the response is [google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty). If the original method is the standard Create/Update, the response should be the target resource of the operation. Any method that returns a long-running operation should document the response type, if any. 


