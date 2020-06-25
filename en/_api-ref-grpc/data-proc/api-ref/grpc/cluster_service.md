---
editable: false
---

# ClusterService

A set of methods for managing Data Proc clusters.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specified cluster. |
| [List](#List) | Retrieves the list of clusters in the specified folder. |
| [Create](#Create) | Creates a cluster in the specified folder. |
| [Update](#Update) | Updates the configuration of the specified cluster. |
| [Delete](#Delete) | Deletes the specified cluster. |
| [Start](#Start) | Starts the specified cluster. |
| [Stop](#Stop) | Stops the specified cluster. |
| [ListOperations](#ListOperations) | Lists operations for the specified cluster. |
| [ListHosts](#ListHosts) | Retrieves the list of hosts in the specified cluster. |

## Calls ClusterService {#calls}

## Get {#Get}

Returns the specified cluster. <br>To get the list of all available clusters, make a [ClusterService.List](#List) request.

**rpc Get ([GetClusterRequest](#GetClusterRequest)) returns ([Cluster](#Cluster))**

### GetClusterRequest {#GetClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Data Proc cluster. <br>To get a cluster ID make a [ClusterService.List](#List) request. false The maximum string length in characters is 50.


### Cluster {#Cluster}

Field | Description
--- | ---
id | **string**<br>ID of the cluster. Generated at creation time. 
folder_id | **string**<br>ID of the folder that the cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the cluster. The name is unique within the folder. The string length in characters must be 1-63.
description | **string**<br>Description of the cluster. The string length in characters must be 0-256.
labels | **map<string,string>**<br>Cluster labels as `key:value` pairs. No more than 64 per resource.
monitoring[] | **[Monitoring](#Monitoring)**<br>Monitoring systems relevant to the cluster. 
config | **[ClusterConfig](#ClusterConfig)**<br>Configuration of the cluster. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](#Host) for every host in the cluster is UNKNOWN).</li><li>`ALIVE`: Cluster is alive and well ([Host.health](#Host) for every host in the cluster is ALIVE).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) for every host in the cluster is DEAD).</li><li>`DEGRADED`: Cluster is working below capacity ([Host.health](#Host) for at least one host in the cluster is not ALIVE).</li><ul/>
status | enum **Status**<br>Cluster status. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li><ul/>
zone_id | **string**<br>ID of the availability zone where the cluster resides. 
service_account_id | **string**<br>ID of service account for the Data Proc manager agent. 
bucket | **string**<br>Object Storage bucket to be used for Data Proc jobs that are run in the cluster. 


### Monitoring {#Monitoring}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system. 


### ClusterConfig {#ClusterConfig}

Field | Description
--- | ---
version_id | **string**<br>Image version for cluster provisioning. All available versions are listed in the [documentation](/docs/managed-hadoop/concepts/image-versions). 
hadoop | **[HadoopConfig](#HadoopConfig)**<br>Data Proc specific configuration options. 


### HadoopConfig {#HadoopConfig}

Field | Description
--- | ---
services[] | enum **[Service](./cluster_service#undefined)**<br>Set of services used in the cluster (if empty, the default set is used). <ul><ul/>
properties | **map<string,string>**<br>Properties set for all hosts in `*-site.xml` configurations. The key should indicate the service and the property. <br>For example, use the key 'hdfs:dfs.replication' to set the `dfs.replication` property in the file `/etc/hadoop/conf/hdfs-site.xml`. 
ssh_public_keys[] | **string**<br>List of public SSH keys to access to cluster hosts. 


## List {#List}

Retrieves the list of clusters in the specified folder.

**rpc List ([ListClustersRequest](#ListClustersRequest)) returns ([ListClustersResponse](#ListClustersResponse))**

### ListClustersRequest {#ListClustersRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to list clusters in. <br>To get the folder ID make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/grpc/folder_service#List) request. false The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListClustersResponse.next_page_token](#ListClustersResponse) that can be used to get the next page of results in subsequent list requests. Default value: 100. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListClustersResponse.next_page_token](#ListClustersResponse) returned by a previous list request. The maximum string length in characters is 100.
filter | **string**<br><ol><li>The field name. Currently you can use filtering only on [Cluster.name](#Cluster1) field. </li><li>An operator. Can be either `=` or `!=` for single values, `IN` or `NOT IN` for lists of values. </li><li>The value. Must be 3-63 characters long and match the regular expression `^[a-z][-a-z0-9]{1,61}[a-z0-9]. </li></ol> The maximum string length in characters is 1000.


### ListClustersResponse {#ListClustersResponse}

Field | Description
--- | ---
clusters[] | **[Cluster](#Cluster1)**<br>List of clusters in the specified folder. 
next_page_token | **string**<br>Token for getting the next page of the list. If the number of results is greater than the specified [ListClustersRequest.page_size](#ListClustersRequest1), use `next_page_token` as the value for the [ListClustersRequest.page_token](#ListClustersRequest1) parameter in the next list request. <br>Each subsequent page will have its own `next_page_token` to continue paging through the results. 


### Cluster {#Cluster}

Field | Description
--- | ---
id | **string**<br>ID of the cluster. Generated at creation time. 
folder_id | **string**<br>ID of the folder that the cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the cluster. The name is unique within the folder. The string length in characters must be 1-63.
description | **string**<br>Description of the cluster. The string length in characters must be 0-256.
labels | **map<string,string>**<br>Cluster labels as `key:value` pairs. No more than 64 per resource.
monitoring[] | **[Monitoring](#Monitoring1)**<br>Monitoring systems relevant to the cluster. 
config | **[ClusterConfig](#ClusterConfig1)**<br>Configuration of the cluster. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](#Host) for every host in the cluster is UNKNOWN).</li><li>`ALIVE`: Cluster is alive and well ([Host.health](#Host) for every host in the cluster is ALIVE).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) for every host in the cluster is DEAD).</li><li>`DEGRADED`: Cluster is working below capacity ([Host.health](#Host) for at least one host in the cluster is not ALIVE).</li><ul/>
status | enum **Status**<br>Cluster status. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li><ul/>
zone_id | **string**<br>ID of the availability zone where the cluster resides. 
service_account_id | **string**<br>ID of service account for the Data Proc manager agent. 
bucket | **string**<br>Object Storage bucket to be used for Data Proc jobs that are run in the cluster. 


### Monitoring {#Monitoring}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system. 


### ClusterConfig {#ClusterConfig}

Field | Description
--- | ---
version_id | **string**<br>Image version for cluster provisioning. All available versions are listed in the [documentation](/docs/managed-hadoop/concepts/image-versions). 
hadoop | **[HadoopConfig](#HadoopConfig1)**<br>Data Proc specific configuration options. 


### HadoopConfig {#HadoopConfig}

Field | Description
--- | ---
services[] | enum **[Service](./cluster_service#undefined)**<br>Set of services used in the cluster (if empty, the default set is used). <ul><ul/>
properties | **map<string,string>**<br>Properties set for all hosts in `*-site.xml` configurations. The key should indicate the service and the property. <br>For example, use the key 'hdfs:dfs.replication' to set the `dfs.replication` property in the file `/etc/hadoop/conf/hdfs-site.xml`. 
ssh_public_keys[] | **string**<br>List of public SSH keys to access to cluster hosts. 


## Create {#Create}

Creates a cluster in the specified folder.

**rpc Create ([CreateClusterRequest](#CreateClusterRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateClusterMetadata](#CreateClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster2)<br>

### CreateClusterRequest {#CreateClusterRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to create a cluster in. <br>To get a folder ID make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/grpc/folder_service#List) request. false The maximum string length in characters is 50.
name | **string**<br>Name of the cluster. The name must be unique within the folder. The name can’t be changed after the Data Proc cluster is created. Value must match the regular expression ` |[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br>Description of the cluster. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Cluster labels as `key:value` pairs. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
config_spec | **[CreateClusterConfigSpec](#CreateClusterConfigSpec)**<br>Required. Configuration and resources for hosts that should be created with the cluster. false
zone_id | **string**<br>Required. ID of the availability zone where the cluster should be placed. <br>To get the list of available zones make a [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/grpc/zone_service#List) request. false The maximum string length in characters is 50.
service_account_id | **string**<br>Required. ID of the service account to be used by the Data Proc manager agent. false
bucket | **string**<br>Name of the Object Storage bucket to use for Data Proc jobs. 


### CreateClusterConfigSpec {#CreateClusterConfigSpec}

Field | Description
--- | ---
version_id | **string**<br>Version of the image for cluster provisioning. <br>All available versions are listed in the [documentation](/docs/data-proc/concepts/image-versions). 
hadoop | **[HadoopConfig](#HadoopConfig2)**<br>Data Proc specific options. 
subclusters_spec[] | **[CreateSubclusterConfigSpec](#CreateSubclusterConfigSpec)**<br>Specification for creating subclusters. 


### HadoopConfig {#HadoopConfig}

Field | Description
--- | ---
services[] | enum **[Service](./cluster_service#undefined)**<br>Set of services used in the cluster (if empty, the default set is used). <ul><ul/>
properties | **map<string,string>**<br>Properties set for all hosts in `*-site.xml` configurations. The key should indicate the service and the property. <br>For example, use the key 'hdfs:dfs.replication' to set the `dfs.replication` property in the file `/etc/hadoop/conf/hdfs-site.xml`. 
ssh_public_keys[] | **string**<br>List of public SSH keys to access to cluster hosts. 


### CreateSubclusterConfigSpec {#CreateSubclusterConfigSpec}

Field | Description
--- | ---
name | **string**<br>Name of the subcluster. Value must match the regular expression ` |[a-z][-a-z0-9]{1,61}[a-z0-9] `.
role | enum **Role**<br>Required. Role of the subcluster in the Data Proc cluster. false<ul><li>`MASTERNODE`: <ul><li>HDFS: Namenode, Secondary Namenode </li><li>YARN: ResourceManager, Timeline Server </li><li>HBase Master </li><li>Hive: Server, Metastore, HCatalog </li><li>Spark History Server </li><li>Zeppelin </li><li>ZooKeeper</li></ul></li><li>`DATANODE`: <ul><li>HDFS DataNode </li><li>YARN NodeManager </li><li>HBase RegionServer </li><li>Spark libraries</li></ul></li><li>`COMPUTENODE`: <ul><li>YARN NodeManager </li><li>Spark libraries</li></ul></li><ul/>
resources | **[Resources](#Resources)**<br>Required. Resource configuration for hosts in the subcluster. false
subnet_id | **string**<br>Required. ID of the VPC subnet used for hosts in the subcluster. false The maximum string length in characters is 50.
hosts_count | **int64**<br>Required. Number of hosts in the subcluster. false The minimum value is 1.


### Resources {#Resources}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the resource preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the [documentation](/docs/data-proc/concepts/instance-types). 
disk_type_id | **string**<br><ul><li>network-hdd — network HDD drive, </li><li>network-ssd — network SSD drive.</li></ul> 
disk_size | **int64**<br>Volume of the storage available to a host, in bytes. 


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
cluster_id | **string**<br>ID of the cluster that is being created. 


### Cluster {#Cluster}

Field | Description
--- | ---
id | **string**<br>ID of the cluster. Generated at creation time. 
folder_id | **string**<br>ID of the folder that the cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the cluster. The name is unique within the folder. The string length in characters must be 1-63.
description | **string**<br>Description of the cluster. The string length in characters must be 0-256.
labels | **map<string,string>**<br>Cluster labels as `key:value` pairs. No more than 64 per resource.
monitoring[] | **[Monitoring](#Monitoring2)**<br>Monitoring systems relevant to the cluster. 
config | **[ClusterConfig](#ClusterConfig2)**<br>Configuration of the cluster. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](#Host) for every host in the cluster is UNKNOWN).</li><li>`ALIVE`: Cluster is alive and well ([Host.health](#Host) for every host in the cluster is ALIVE).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) for every host in the cluster is DEAD).</li><li>`DEGRADED`: Cluster is working below capacity ([Host.health](#Host) for at least one host in the cluster is not ALIVE).</li><ul/>
status | enum **Status**<br>Cluster status. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li><ul/>
zone_id | **string**<br>ID of the availability zone where the cluster resides. 
service_account_id | **string**<br>ID of service account for the Data Proc manager agent. 
bucket | **string**<br>Object Storage bucket to be used for Data Proc jobs that are run in the cluster. 


## Update {#Update}

Updates the configuration of the specified cluster.

**rpc Update ([UpdateClusterRequest](#UpdateClusterRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateClusterMetadata](#UpdateClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster3)<br>

### UpdateClusterRequest {#UpdateClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>ID of the cluster to update. <br>To get the cluster ID, make a [ClusterService.List](#List) request. The maximum string length in characters is 50.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Field mask that specifies which attributes of the cluster should be updated. 
description | **string**<br>New description for the cluster. The maximum string length in characters is 256.
labels | **map<string,string>**<br>A new set of cluster labels as `key:value` pairs. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
config_spec | **[UpdateClusterConfigSpec](#UpdateClusterConfigSpec)**<br>Configuration and resources for hosts that should be created with the Data Proc cluster. 
name | **string**<br>New name for the Data Proc cluster. The name must be unique within the folder. Value must match the regular expression ` |[a-z][-a-z0-9]{1,61}[a-z0-9] `.
service_account_id | **string**<br>ID of the new service account to be used by the Data Proc manager agent. 
bucket | **string**<br>Name of the new Object Storage bucket to use for Data Proc jobs. 
decommission_timeout | **int64**<br>Timeout to gracefully decommission nodes. In seconds. Default value: 0 Acceptable values are 0 to 86400, inclusive.


### UpdateClusterConfigSpec {#UpdateClusterConfigSpec}

Field | Description
--- | ---
subclusters_spec[] | **[UpdateSubclusterConfigSpec](#UpdateSubclusterConfigSpec)**<br>New configuration for subclusters in a cluster. 


### UpdateSubclusterConfigSpec {#UpdateSubclusterConfigSpec}

Field | Description
--- | ---
id | **string**<br>ID of the subcluster to update. <br>To get the subcluster ID make a [SubclusterService.List](./subcluster_service#List) request. 
name | **string**<br>Name of the subcluster. Value must match the regular expression ` |[a-z][-a-z0-9]{1,61}[a-z0-9] `.
resources | **[Resources](#Resources1)**<br>Resource configuration for each host in the subcluster. 
hosts_count | **int64**<br>Number of hosts in the subcluster. The minimum value is 1.


### Resources {#Resources}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the resource preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the [documentation](/docs/data-proc/concepts/instance-types). 
disk_type_id | **string**<br><ul><li>network-hdd — network HDD drive, </li><li>network-ssd — network SSD drive.</li></ul> 
disk_size | **int64**<br>Volume of the storage available to a host, in bytes. 


### Operation {#Operation}

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
cluster_id | **string**<br>ID of the cluster that is being updated. 


### Cluster {#Cluster}

Field | Description
--- | ---
id | **string**<br>ID of the cluster. Generated at creation time. 
folder_id | **string**<br>ID of the folder that the cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the cluster. The name is unique within the folder. The string length in characters must be 1-63.
description | **string**<br>Description of the cluster. The string length in characters must be 0-256.
labels | **map<string,string>**<br>Cluster labels as `key:value` pairs. No more than 64 per resource.
monitoring[] | **[Monitoring](#Monitoring2)**<br>Monitoring systems relevant to the cluster. 
config | **[ClusterConfig](#ClusterConfig2)**<br>Configuration of the cluster. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](#Host) for every host in the cluster is UNKNOWN).</li><li>`ALIVE`: Cluster is alive and well ([Host.health](#Host) for every host in the cluster is ALIVE).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) for every host in the cluster is DEAD).</li><li>`DEGRADED`: Cluster is working below capacity ([Host.health](#Host) for at least one host in the cluster is not ALIVE).</li><ul/>
status | enum **Status**<br>Cluster status. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li><ul/>
zone_id | **string**<br>ID of the availability zone where the cluster resides. 
service_account_id | **string**<br>ID of service account for the Data Proc manager agent. 
bucket | **string**<br>Object Storage bucket to be used for Data Proc jobs that are run in the cluster. 


## Delete {#Delete}

Deletes the specified cluster.

**rpc Delete ([DeleteClusterRequest](#DeleteClusterRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteClusterMetadata](#DeleteClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteClusterRequest {#DeleteClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the cluster to delete. <br>To get a cluster ID, make a [ClusterService.List](#List) request. false The maximum string length in characters is 50.
decommission_timeout | **int64**<br>Timeout to gracefully decommission nodes. In seconds. Default value: 0 Acceptable values are 0 to 86400, inclusive.


### Operation {#Operation}

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
cluster_id | **string**<br>ID of the Data Proc cluster that is being deleted. 


## Start {#Start}

Starts the specified cluster.

**rpc Start ([StartClusterRequest](#StartClusterRequest)) returns ([operation.Operation](#Operation3))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[StartClusterMetadata](#StartClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster4)<br>

### StartClusterRequest {#StartClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the cluster to start. <br>To get a cluster ID, make a [ClusterService.List](#List) request. false The maximum string length in characters is 50.


### Operation {#Operation}

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
cluster_id | **string**<br>ID of the Data Proc cluster that is being started. 


### Cluster {#Cluster}

Field | Description
--- | ---
id | **string**<br>ID of the cluster. Generated at creation time. 
folder_id | **string**<br>ID of the folder that the cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the cluster. The name is unique within the folder. The string length in characters must be 1-63.
description | **string**<br>Description of the cluster. The string length in characters must be 0-256.
labels | **map<string,string>**<br>Cluster labels as `key:value` pairs. No more than 64 per resource.
monitoring[] | **[Monitoring](#Monitoring2)**<br>Monitoring systems relevant to the cluster. 
config | **[ClusterConfig](#ClusterConfig2)**<br>Configuration of the cluster. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](#Host) for every host in the cluster is UNKNOWN).</li><li>`ALIVE`: Cluster is alive and well ([Host.health](#Host) for every host in the cluster is ALIVE).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) for every host in the cluster is DEAD).</li><li>`DEGRADED`: Cluster is working below capacity ([Host.health](#Host) for at least one host in the cluster is not ALIVE).</li><ul/>
status | enum **Status**<br>Cluster status. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li><ul/>
zone_id | **string**<br>ID of the availability zone where the cluster resides. 
service_account_id | **string**<br>ID of service account for the Data Proc manager agent. 
bucket | **string**<br>Object Storage bucket to be used for Data Proc jobs that are run in the cluster. 


## Stop {#Stop}

Stops the specified cluster.

**rpc Stop ([StopClusterRequest](#StopClusterRequest)) returns ([operation.Operation](#Operation4))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[StopClusterMetadata](#StopClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster5)<br>

### StopClusterRequest {#StopClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the cluster to stop. <br>To get a cluster ID, make a [ClusterService.List](#List) request. false The maximum string length in characters is 50.
decommission_timeout | **int64**<br>Timeout to gracefully decommission nodes. In seconds. Default value: 0 Acceptable values are 0 to 86400, inclusive.


### Operation {#Operation}

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
cluster_id | **string**<br>ID of the Data Proc cluster that is being stopped. 


### Cluster {#Cluster}

Field | Description
--- | ---
id | **string**<br>ID of the cluster. Generated at creation time. 
folder_id | **string**<br>ID of the folder that the cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the cluster. The name is unique within the folder. The string length in characters must be 1-63.
description | **string**<br>Description of the cluster. The string length in characters must be 0-256.
labels | **map<string,string>**<br>Cluster labels as `key:value` pairs. No more than 64 per resource.
monitoring[] | **[Monitoring](#Monitoring2)**<br>Monitoring systems relevant to the cluster. 
config | **[ClusterConfig](#ClusterConfig2)**<br>Configuration of the cluster. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](#Host) for every host in the cluster is UNKNOWN).</li><li>`ALIVE`: Cluster is alive and well ([Host.health](#Host) for every host in the cluster is ALIVE).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) for every host in the cluster is DEAD).</li><li>`DEGRADED`: Cluster is working below capacity ([Host.health](#Host) for at least one host in the cluster is not ALIVE).</li><ul/>
status | enum **Status**<br>Cluster status. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li><ul/>
zone_id | **string**<br>ID of the availability zone where the cluster resides. 
service_account_id | **string**<br>ID of service account for the Data Proc manager agent. 
bucket | **string**<br>Object Storage bucket to be used for Data Proc jobs that are run in the cluster. 


## ListOperations {#ListOperations}

Lists operations for the specified cluster.

**rpc ListOperations ([ListClusterOperationsRequest](#ListClusterOperationsRequest)) returns ([ListClusterOperationsResponse](#ListClusterOperationsResponse))**

### ListClusterOperationsRequest {#ListClusterOperationsRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the cluster to list operations for. false The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListClusterOperationsResponse.next_page_token](#ListClusterOperationsResponse) that can be used to get the next page of results in subsequent list requests. Default value: 100. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListClusterOperationsResponse.next_page_token](#ListClusterOperationsResponse) returned by a previous list request. The maximum string length in characters is 100.


### ListClusterOperationsResponse {#ListClusterOperationsResponse}

Field | Description
--- | ---
operations[] | **[operation.Operation](#Operation5)**<br>List of operations for the specified cluster. 
next_page_token | **string**<br>Token for getting the next page of the list. If the number of results is greater than the specified [ListClusterOperationsRequest.page_size](#ListClusterOperationsRequest1), use `next_page_token` as the value for the [ListClusterOperationsRequest.page_token](#ListClusterOperationsRequest1) parameter in the next list request. <br>Each subsequent page will have its own `next_page_token` to continue paging through the results. 


### Operation {#Operation}

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


## ListHosts {#ListHosts}

Retrieves the list of hosts in the specified cluster.

**rpc ListHosts ([ListClusterHostsRequest](#ListClusterHostsRequest)) returns ([ListClusterHostsResponse](#ListClusterHostsResponse))**

### ListClusterHostsRequest {#ListClusterHostsRequest}

Field | Description
--- | ---
cluster_id | **string**<br>ID of the cluster to list hosts for. <br>To get a cluster ID, make a [ClusterService.List](#List) request. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListClusterHostsResponse.next_page_token](#ListClusterHostsResponse) that can be used to get the next page of results in subsequent list requests. Default value: 100. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListClusterHostsResponse.next_page_token](#ListClusterHostsResponse) returned by a previous list request. The maximum string length in characters is 100.
filter | **string**<br><ol><li>The field name. Currently you can use filtering only on [Cluster.name](#Cluster6) field. </li><li>An operator. Can be either `=` or `!=` for single values, `IN` or `NOT IN` for lists of values. </li><li>The value. Must be 3-63 characters long and match the regular expression `^[a-z][-a-z0-9]{1,61}[a-z0-9]. </li></ol> The maximum string length in characters is 1000.


### ListClusterHostsResponse {#ListClusterHostsResponse}

Field | Description
--- | ---
hosts[] | **[Host](#Host)**<br>Requested list of hosts. 
next_page_token | **string**<br>Token for getting the next page of the list. If the number of results is greater than the specified [ListClusterHostsRequest.page_size](#ListClusterHostsRequest1), use `next_page_token` as the value for the [ListClusterHostsRequest.page_token](#ListClusterHostsRequest1) parameter in the next list request. <br>Each subsequent page will have its own `next_page_token` to continue paging through the results. 


### Host {#Host}

Field | Description
--- | ---
name | **string**<br>Name of the Data Proc host. The host name is assigned by Data Proc at creation time and cannot be changed. The name is generated to be unique across all existing Data Proc hosts in Yandex.Cloud, as it defines the FQDN of the host. 
subcluster_id | **string**<br>ID of the Data Proc subcluster that the host belongs to. 
health | enum **Health**<br>Host status code. <ul><li>`HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](#Host) for every host in the cluster is UNKNOWN).</li><li>`ALIVE`: Cluster is alive and well ([Host.health](#Host) for every host in the cluster is ALIVE).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) for every host in the cluster is DEAD).</li><li>`DEGRADED`: Cluster is working below capacity ([Host.health](#Host) for at least one host in the cluster is not ALIVE).</li><ul/>
compute_instance_id | **string**<br>ID of the Compute virtual machine that is used as the Data Proc host. 
role | enum **Role**<br>Role of the host in the cluster. <ul><li>`MASTERNODE`: <ul><li>HDFS: Namenode, Secondary Namenode </li><li>YARN: ResourceManager, Timeline Server </li><li>HBase Master </li><li>Hive: Server, Metastore, HCatalog </li><li>Spark History Server </li><li>Zeppelin </li><li>ZooKeeper</li></ul></li><li>`DATANODE`: <ul><li>HDFS DataNode </li><li>YARN NodeManager </li><li>HBase RegionServer </li><li>Spark libraries</li></ul></li><li>`COMPUTENODE`: <ul><li>YARN NodeManager </li><li>Spark libraries</li></ul></li><ul/>


