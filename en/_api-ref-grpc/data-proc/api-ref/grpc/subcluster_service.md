---
editable: false
---

# SubclusterService

A set of methods for managing Data Proc subclusters.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specified subcluster. |
| [List](#List) | Retrieves a list of subclusters in the specified cluster. |
| [Create](#Create) | Creates a subcluster in the specified cluster. |
| [Update](#Update) | Updates the specified subcluster. |
| [Delete](#Delete) | Deletes the specified subcluster. |

## Calls SubclusterService {#calls}

## Get {#Get}

Returns the specified subcluster. <br>To get the list of all available subclusters, make a [SubclusterService.List](#List) request.

**rpc Get ([GetSubclusterRequest](#GetSubclusterRequest)) returns ([Subcluster](#Subcluster))**

### GetSubclusterRequest {#GetSubclusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Data Proc cluster that the subcluster belongs to.  The maximum string length in characters is 50.
subcluster_id | **string**<br>Required. ID of the subcluster to return. <br>To get a subcluster ID make a [SubclusterService.List](#List) request.  The maximum string length in characters is 50.


### Subcluster {#Subcluster}

Field | Description
--- | ---
id | **string**<br>ID of the subcluster. Generated at creation time. 
cluster_id | **string**<br>ID of the Data Proc cluster that the subcluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the subcluster. The name is unique within the cluster. The string length in characters must be 1-63.
role | enum **Role**<br>Role that is fulfilled by hosts of the subcluster. <ul><li>`MASTERNODE`: <ul><li>HDFS: Namenode, Secondary Namenode </li><li>YARN: ResourceManager, Timeline Server </li><li>HBase Master </li><li>Hive: Server, Metastore, HCatalog </li><li>Spark History Server </li><li>Zeppelin </li><li>ZooKeeper</li></ul></li><li>`DATANODE`: <ul><li>HDFS DataNode </li><li>YARN NodeManager </li><li>HBase RegionServer </li><li>Spark libraries</li></ul></li><li>`COMPUTENODE`: <ul><li>YARN NodeManager </li><li>Spark libraries</li></ul></li><ul/>
resources | **[Resources](#Resources)**<br>Resources allocated for each host in the subcluster. 
subnet_id | **string**<br>ID of the VPC subnet used for hosts in the subcluster. 
hosts_count | **int64**<br>Number of hosts in the subcluster. 


### Resources {#Resources}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the resource preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the [documentation](/docs/data-proc/concepts/instance-types). 
disk_type_id | **string**<br><ul><li>network-hdd — network HDD drive, </li><li>network-ssd — network SSD drive.</li></ul> 
disk_size | **int64**<br>Volume of the storage available to a host, in bytes. 


## List {#List}

Retrieves a list of subclusters in the specified cluster.

**rpc List ([ListSubclustersRequest](#ListSubclustersRequest)) returns ([ListSubclustersResponse](#ListSubclustersResponse))**

### ListSubclustersRequest {#ListSubclustersRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Data Proc cluster to list subclusters in.  The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListSubclustersResponse.next_page_token](#ListSubclustersResponse) that can be used to get the next page of results in subsequent list requests. Default value: 100. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListSubclustersResponse.next_page_token](#ListSubclustersResponse) returned by a previous list request. The maximum string length in characters is 100.
filter | **string**<br><ol><li>The field name. Currently you can use filtering only on [Subcluster.name](#Subcluster1) field. </li><li>An operator. Can be either `=` or `!=` for single values, `IN` or `NOT IN` for lists of values. </li><li>The value. Must be 3-63 characters long and match the regular expression `^[a-z][-a-z0-9]{1,61}[a-z0-9]. </li></ol> The maximum string length in characters is 1000.


### ListSubclustersResponse {#ListSubclustersResponse}

Field | Description
--- | ---
subclusters[] | **[Subcluster](#Subcluster1)**<br>List of subclusters in the specified cluster. 
next_page_token | **string**<br>Token for getting the next page of the list. If the number of results is greater than the specified [ListSubclustersRequest.page_size](#ListSubclustersRequest1), use `next_page_token` as the value for the [ListSubclustersRequest.page_token](#ListSubclustersRequest1) parameter in the next list request. <br>Each subsequent page will have its own `next_page_token` to continue paging through the results. 


### Subcluster {#Subcluster}

Field | Description
--- | ---
id | **string**<br>ID of the subcluster. Generated at creation time. 
cluster_id | **string**<br>ID of the Data Proc cluster that the subcluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the subcluster. The name is unique within the cluster. The string length in characters must be 1-63.
role | enum **Role**<br>Role that is fulfilled by hosts of the subcluster. <ul><li>`MASTERNODE`: <ul><li>HDFS: Namenode, Secondary Namenode </li><li>YARN: ResourceManager, Timeline Server </li><li>HBase Master </li><li>Hive: Server, Metastore, HCatalog </li><li>Spark History Server </li><li>Zeppelin </li><li>ZooKeeper</li></ul></li><li>`DATANODE`: <ul><li>HDFS DataNode </li><li>YARN NodeManager </li><li>HBase RegionServer </li><li>Spark libraries</li></ul></li><li>`COMPUTENODE`: <ul><li>YARN NodeManager </li><li>Spark libraries</li></ul></li><ul/>
resources | **[Resources](#Resources1)**<br>Resources allocated for each host in the subcluster. 
subnet_id | **string**<br>ID of the VPC subnet used for hosts in the subcluster. 
hosts_count | **int64**<br>Number of hosts in the subcluster. 


### Resources {#Resources}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the resource preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the [documentation](/docs/data-proc/concepts/instance-types). 
disk_type_id | **string**<br><ul><li>network-hdd — network HDD drive, </li><li>network-ssd — network SSD drive.</li></ul> 
disk_size | **int64**<br>Volume of the storage available to a host, in bytes. 


## Create {#Create}

Creates a subcluster in the specified cluster.

**rpc Create ([CreateSubclusterRequest](#CreateSubclusterRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateSubclusterMetadata](#CreateSubclusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Subcluster](#Subcluster2)<br>

### CreateSubclusterRequest {#CreateSubclusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Data Proc cluster to create a subcluster in. <br>To get a cluster ID, make a [ClusterService.List](./cluster_service#List) request.  The maximum string length in characters is 50.
name | **string**<br>Name of the subcluster. The name must be unique within the cluster. The name can’t be changed when the subcluster is created. Value must match the regular expression ` |[a-z][-a-z0-9]{1,61}[a-z0-9] `.
role | enum **Role**<br>Required. Role that is fulfilled by hosts of the subcluster. <ul><li>`MASTERNODE`: <ul><li>HDFS: Namenode, Secondary Namenode </li><li>YARN: ResourceManager, Timeline Server </li><li>HBase Master </li><li>Hive: Server, Metastore, HCatalog </li><li>Spark History Server </li><li>Zeppelin </li><li>ZooKeeper</li></ul></li><li>`DATANODE`: <ul><li>HDFS DataNode </li><li>YARN NodeManager </li><li>HBase RegionServer </li><li>Spark libraries</li></ul></li><li>`COMPUTENODE`: <ul><li>YARN NodeManager </li><li>Spark libraries</li></ul></li><ul/>
resources | **[Resources](#Resources2)**<br>Required. Resources allocated for each host in the subcluster. 
subnet_id | **string**<br>Required. ID of the VPC subnet used for hosts in the subcluster.  The maximum string length in characters is 50.
hosts_count | **int64**<br>Required. Number of hosts in the subcluster.  The minimum value is 1.


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
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateSubclusterMetadata](#CreateSubclusterMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Subcluster](#Subcluster2)>**<br>if operation finished successfully. 


### CreateSubclusterMetadata {#CreateSubclusterMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>ID of the cluster that the subcluster is being added to. The maximum string length in characters is 50.
subcluster_id | **string**<br>ID of the subcluster that is being created. The maximum string length in characters is 50.


### Subcluster {#Subcluster}

Field | Description
--- | ---
id | **string**<br>ID of the subcluster. Generated at creation time. 
cluster_id | **string**<br>ID of the Data Proc cluster that the subcluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the subcluster. The name is unique within the cluster. The string length in characters must be 1-63.
role | enum **Role**<br>Role that is fulfilled by hosts of the subcluster. <ul><li>`MASTERNODE`: <ul><li>HDFS: Namenode, Secondary Namenode </li><li>YARN: ResourceManager, Timeline Server </li><li>HBase Master </li><li>Hive: Server, Metastore, HCatalog </li><li>Spark History Server </li><li>Zeppelin </li><li>ZooKeeper</li></ul></li><li>`DATANODE`: <ul><li>HDFS DataNode </li><li>YARN NodeManager </li><li>HBase RegionServer </li><li>Spark libraries</li></ul></li><li>`COMPUTENODE`: <ul><li>YARN NodeManager </li><li>Spark libraries</li></ul></li><ul/>
resources | **[Resources](#Resources3)**<br>Resources allocated for each host in the subcluster. 
subnet_id | **string**<br>ID of the VPC subnet used for hosts in the subcluster. 
hosts_count | **int64**<br>Number of hosts in the subcluster. 


## Update {#Update}

Updates the specified subcluster.

**rpc Update ([UpdateSubclusterRequest](#UpdateSubclusterRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateSubclusterMetadata](#UpdateSubclusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Subcluster](#Subcluster3)<br>

### UpdateSubclusterRequest {#UpdateSubclusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the cluster to update a subcluster in. <br>To get a cluster ID, make a [ClusterService.List](./cluster_service#List) request.  The maximum string length in characters is 50.
subcluster_id | **string**<br>Required. ID of the subcluster to update. <br>To get a subcluster ID, make a [SubclusterService.List](#List) request.  The maximum string length in characters is 50.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Field mask that specifies which attributes of the subcluster should be updated. 
resources | **[Resources](#Resources3)**<br>New configuration of resources that should be allocated for each host in the subcluster. 
name | **string**<br>New name for the subcluster. The name must be unique within the cluster. Value must match the regular expression ` |[a-z][-a-z0-9]{1,61}[a-z0-9] `.
hosts_count | **int64**<br>Required. New number of hosts in the subcluster.  The minimum value is 1.


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
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateSubclusterMetadata](#UpdateSubclusterMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Subcluster](#Subcluster3)>**<br>if operation finished successfully. 


### UpdateSubclusterMetadata {#UpdateSubclusterMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>ID of the cluster whose subcluster is being updated. The maximum string length in characters is 50.
subcluster_id | **string**<br>ID of the subcluster that is being updated. The maximum string length in characters is 50.


### Subcluster {#Subcluster}

Field | Description
--- | ---
id | **string**<br>ID of the subcluster. Generated at creation time. 
cluster_id | **string**<br>ID of the Data Proc cluster that the subcluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the subcluster. The name is unique within the cluster. The string length in characters must be 1-63.
role | enum **Role**<br>Role that is fulfilled by hosts of the subcluster. <ul><li>`MASTERNODE`: <ul><li>HDFS: Namenode, Secondary Namenode </li><li>YARN: ResourceManager, Timeline Server </li><li>HBase Master </li><li>Hive: Server, Metastore, HCatalog </li><li>Spark History Server </li><li>Zeppelin </li><li>ZooKeeper</li></ul></li><li>`DATANODE`: <ul><li>HDFS DataNode </li><li>YARN NodeManager </li><li>HBase RegionServer </li><li>Spark libraries</li></ul></li><li>`COMPUTENODE`: <ul><li>YARN NodeManager </li><li>Spark libraries</li></ul></li><ul/>
resources | **[Resources](#Resources4)**<br>Resources allocated for each host in the subcluster. 
subnet_id | **string**<br>ID of the VPC subnet used for hosts in the subcluster. 
hosts_count | **int64**<br>Number of hosts in the subcluster. 


## Delete {#Delete}

Deletes the specified subcluster.

**rpc Delete ([DeleteSubclusterRequest](#DeleteSubclusterRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteSubclusterMetadata](#DeleteSubclusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteSubclusterRequest {#DeleteSubclusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the cluster to remove a subcluster from. <br>To get a cluster ID, make a [ClusterService.List](./cluster_service#List) request.  The maximum string length in characters is 50.
subcluster_id | **string**<br>Required. ID of the subcluster to delete.  The maximum string length in characters is 50.


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteSubclusterMetadata](#DeleteSubclusterMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### DeleteSubclusterMetadata {#DeleteSubclusterMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>ID of the cluster whose subcluster is being deleted. The maximum string length in characters is 50.
subcluster_id | **string**<br>ID of the subcluster that is being deleted. The maximum string length in characters is 50.


