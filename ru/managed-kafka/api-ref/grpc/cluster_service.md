---
editable: false
sourcePath: en/_api-ref-grpc/managed-kafka/api-ref/grpc/cluster_service.md
---

# Managed Service for Apache Kafka® API, gRPC: ClusterService

A set of methods for managing Apache Kafka® clusters.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specified Apache Kafka® cluster. |
| [List](#List) | Retrieves the list of Apache Kafka® clusters that belong to the specified folder. |
| [Create](#Create) | Creates a new Apache Kafka® cluster in the specified folder. |
| [Update](#Update) | Updates the specified Apache Kafka® cluster. |
| [Delete](#Delete) | Deletes the specified Apache Kafka® cluster. |
| [Move](#Move) | Moves the specified Apache Kafka® cluster to the specified folder. |
| [Start](#Start) | Starts the specified Apache Kafka® cluster. |
| [Stop](#Stop) | Stops the specified Apache Kafka® cluster. |
| [RescheduleMaintenance](#RescheduleMaintenance) | Reschedule planned maintenance operation. |
| [ListLogs](#ListLogs) | Retrieves logs for the specified Apache Kafka® cluster. |
| [StreamLogs](#StreamLogs) | Same as [ListLogs](#ListLogs) but using server-side streaming. |
| [ListOperations](#ListOperations) | Retrieves the list of operations for the specified Apache Kafka® cluster. |
| [ListHosts](#ListHosts) | Retrieves a list of hosts for the specified Apache Kafka® cluster. |

## Calls ClusterService {#calls}

## Get {#Get}

Returns the specified Apache Kafka® cluster. <br>To get the list of available Apache Kafka® clusters, make a [List](#List) request.

**rpc Get ([GetClusterRequest](#GetClusterRequest)) returns ([Cluster](#Cluster))**

### GetClusterRequest {#GetClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Apache Kafka® Cluster resource to return. <br>To get the cluster ID, make a [ClusterService.List](#List) request. The maximum string length in characters is 50.


### Cluster {#Cluster}

Field | Description
--- | ---
id | **string**<br>ID of the Apache Kafka® cluster. This ID is assigned at creation time. 
folder_id | **string**<br>ID of the folder that the Apache Kafka® cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the Apache Kafka® cluster. The name must be unique within the folder. 1-63 characters long. Value must match the regular expression `[a-zA-Z0-9_-]*`. 
description | **string**<br>Description of the Apache Kafka® cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the Apache Kafka® cluster as `key:value` pairs. A maximum of 64 labels per resource is allowed. 
environment | enum **Environment**<br>Deployment environment of the Apache Kafka® cluster. <ul><li>`PRODUCTION`: stable environment with a conservative update policy when only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: environment with a more aggressive update policy when new versions are rolled out irrespective of backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring)**<br>Description of monitoring systems relevant to the Apache Kafka® cluster. 
config | **[ConfigSpec](#ConfigSpec)**<br>Configuration of the Apache Kafka® cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: state of the cluster is unknown ([Host.health](#Host) of all hosts in the cluster is `UNKNOWN`).</li><li>`ALIVE`: cluster is alive and well ([Host.health](#Host) of all hosts in the cluster is `ALIVE`).</li><li>`DEAD`: cluster is inoperable ([Host.health](#Host) of all hosts in the cluster is `DEAD`).</li><li>`DEGRADED`: cluster is in degraded state ([Host.health](#Host) of at least one of the hosts in the cluster is not `ALIVE`).</li></ul>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: cluster state is unknown.</li><li>`CREATING`: cluster is being created.</li><li>`RUNNING`: cluster is running normally.</li><li>`ERROR`: cluster encountered a problem and cannot operate.</li><li>`UPDATING`: cluster is being updated.</li><li>`STOPPING`: cluster is stopping.</li><li>`STOPPED`: cluster stopped.</li><li>`STARTING`: cluster is starting.</li></ul>
security_group_ids[] | **string**<br>User security groups 
host_group_ids[] | **string**<br>Host groups hosting VMs of the cluster. 
deletion_protection | **bool**<br>Deletion Protection inhibits deletion of the cluster 
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow)**<br>Window of maintenance operations. 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation)**<br>Scheduled maintenance operation. 


### Monitoring {#Monitoring}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the Apache Kafka® cluster. 


### ConfigSpec {#ConfigSpec}

Field | Description
--- | ---
version | **string**<br>Version of Apache Kafka® used in the cluster. Possible values: `2.1`, `2.6`. 
kafka | **[Kafka](#Kafka)**<br>Configuration and resource allocation for Kafka brokers. 
zookeeper | **[Zookeeper](#Zookeeper)**<br>Configuration and resource allocation for ZooKeeper hosts. 
zone_id[] | **string**<br>IDs of availability zones where Kafka brokers reside. 
brokers_count | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of Kafka brokers deployed in each availability zone. 
assign_public_ip | **bool**<br>The flag that defines whether a public IP address is assigned to the cluster. If the value is `true`, then Apache Kafka® cluster is available on the Internet via it's public IP address. 
unmanaged_topics | **bool**<br>Allows to manage topics via AdminAPI Deprecated. Feature enabled permanently. 
schema_registry | **bool**<br>Enables managed schema registry on cluster 
access | **[Access](#Access)**<br>Access policy for external services. 
rest_api_config | **[RestAPIConfig](#RestAPIConfig)**<br>Configuration of REST API. 


### Kafka {#Kafka}

Field | Description
--- | ---
resources | **[Resources](#Resources)**<br>Resources allocated to Kafka brokers. 
kafka_config | **oneof:** `kafka_config_2_8` or `kafka_config_3`<br>Kafka broker configuration.
&nbsp;&nbsp;kafka_config_2_8 | **[KafkaConfig2_8](#KafkaConfig2_8)**<br>Kafka broker configuration. 
&nbsp;&nbsp;kafka_config_3 | **[KafkaConfig3](#KafkaConfig3)**<br>Kafka broker configuration. 


### Zookeeper {#Zookeeper}

Field | Description
--- | ---
resources | **[Resources](#Resources)**<br>Resources allocated to ZooKeeper hosts. 


### RestAPIConfig {#RestAPIConfig}

Field | Description
--- | ---
enabled | **bool**<br>Is REST API enabled for this cluster. 


### Access {#Access}

Field | Description
--- | ---
data_transfer | **bool**<br>Allow access for DataTransfer. 


### Resources {#Resources}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory, etc.). All available presets are listed in the [documentation](/docs/managed-kafka/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage available to a host, in bytes. Must be greater than 2 * partition segment size in bytes * partitions count, so each partition can have one active segment file and one closed segment file that can be deleted. 
disk_type_id | **string**<br>Type of the storage environment for the host. 


### KafkaConfig2_8 {#KafkaConfig2_8}

Field | Description
--- | ---
compression_type | enum **CompressionType**<br>Cluster topics compression type. <ul><li>`COMPRESSION_TYPE_UNCOMPRESSED`: no codec (uncompressed).</li><li>`COMPRESSION_TYPE_ZSTD`: Zstandard codec.</li><li>`COMPRESSION_TYPE_LZ4`: LZ4 codec.</li><li>`COMPRESSION_TYPE_SNAPPY`: Snappy codec.</li><li>`COMPRESSION_TYPE_GZIP`: GZip codec.</li><li>`COMPRESSION_TYPE_PRODUCER`: the codec to use is set by a producer (can be any of `ZSTD`, `LZ4`, `GZIP` or `SNAPPY` codecs).</li></ul>
log_flush_interval_messages | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of messages accumulated on a log partition before messages are flushed to disk. <br>This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig2_8.flush_messages](#TopicConfig2_8) setting. 
log_flush_interval_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time (in milliseconds) that a message in any topic is kept in memory before flushed to disk. If not set, the value of `log_flush_scheduler_interval_ms` is used. <br>This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig2_8.flush_ms](#TopicConfig2_8) setting. 
log_flush_scheduler_interval_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The frequency of checks (in milliseconds) for any logs that need to be flushed to disk. This check is done by the log flusher. 
log_retention_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Partition size limit; Kafka will discard old log segments to free up space if `delete` [TopicConfig2_8.cleanup_policy](#TopicConfig2_8) is in effect. This setting is helpful if you need to control the size of a log due to limited disk space. <br>This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig2_8.retention_bytes](#TopicConfig2_8) setting. 
log_retention_hours | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of hours to keep a log segment file before deleting it. 
log_retention_minutes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of minutes to keep a log segment file before deleting it. <br>If not set, the value of `log_retention_hours` is used. 
log_retention_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of milliseconds to keep a log segment file before deleting it. <br>If not set, the value of `log_retention_minutes` is used. <br>This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig2_8.retention_ms](#TopicConfig2_8) setting. 
log_segment_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size of a single log file. <br>This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig2_8.segment_bytes](#TopicConfig2_8) setting. 
log_preallocate | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Should pre allocate file when create new segment? <br>This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig2_8.preallocate](#TopicConfig2_8) setting. 
socket_send_buffer_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The SO_SNDBUF buffer of the socket server sockets. If the value is -1, the OS default will be used. 
socket_receive_buffer_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The SO_RCVBUF buffer of the socket server sockets. If the value is -1, the OS default will be used. 
auto_create_topics_enable | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Enable auto creation of topic on the server 
num_partitions | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Default number of partitions per topic on the whole cluster 
default_replication_factor | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Default replication factor of the topic on the whole cluster 
message_max_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The largest record batch size allowed by Kafka. Default value: 1048588. 
replica_fetch_max_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of bytes of messages to attempt to fetch for each partition. Default value: 1048576. 
ssl_cipher_suites[] | **string**<br>A list of cipher suites. 
offsets_retention_minutes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Offset storage time after a consumer group loses all its consumers. Default: 10080. 
sasl_enabled_mechanisms[] | enum **SaslMechanism**<br>The list of SASL mechanisms enabled in the Kafka server. Default: [SCRAM_SHA_512]. 


### KafkaConfig3 {#KafkaConfig3}

Field | Description
--- | ---
compression_type | enum **CompressionType**<br>Cluster topics compression type. <ul><li>`COMPRESSION_TYPE_UNCOMPRESSED`: no codec (uncompressed).</li><li>`COMPRESSION_TYPE_ZSTD`: Zstandard codec.</li><li>`COMPRESSION_TYPE_LZ4`: LZ4 codec.</li><li>`COMPRESSION_TYPE_SNAPPY`: Snappy codec.</li><li>`COMPRESSION_TYPE_GZIP`: GZip codec.</li><li>`COMPRESSION_TYPE_PRODUCER`: the codec to use is set by a producer (can be any of `ZSTD`, `LZ4`, `GZIP` or `SNAPPY` codecs).</li></ul>
log_flush_interval_messages | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of messages accumulated on a log partition before messages are flushed to disk. <br>This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig3.flush_messages](#TopicConfig3) setting. 
log_flush_interval_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time (in milliseconds) that a message in any topic is kept in memory before flushed to disk. If not set, the value of `log_flush_scheduler_interval_ms` is used. <br>This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig3.flush_ms](#TopicConfig3) setting. 
log_flush_scheduler_interval_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The frequency of checks (in milliseconds) for any logs that need to be flushed to disk. This check is done by the log flusher. 
log_retention_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Partition size limit; Kafka will discard old log segments to free up space if `delete` [TopicConfig3.cleanup_policy](#TopicConfig3) is in effect. This setting is helpful if you need to control the size of a log due to limited disk space. <br>This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig3.retention_bytes](#TopicConfig3) setting. 
log_retention_hours | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of hours to keep a log segment file before deleting it. 
log_retention_minutes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of minutes to keep a log segment file before deleting it. <br>If not set, the value of `log_retention_hours` is used. 
log_retention_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of milliseconds to keep a log segment file before deleting it. <br>If not set, the value of `log_retention_minutes` is used. <br>This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig3.retention_ms](#TopicConfig3) setting. 
log_segment_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size of a single log file. <br>This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig3.segment_bytes](#TopicConfig3) setting. 
log_preallocate | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Should pre allocate file when create new segment? <br>This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig3.preallocate](#TopicConfig3) setting. 
socket_send_buffer_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The SO_SNDBUF buffer of the socket server sockets. If the value is -1, the OS default will be used. 
socket_receive_buffer_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The SO_RCVBUF buffer of the socket server sockets. If the value is -1, the OS default will be used. 
auto_create_topics_enable | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Enable auto creation of topic on the server 
num_partitions | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Default number of partitions per topic on the whole cluster 
default_replication_factor | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Default replication factor of the topic on the whole cluster 
message_max_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The largest record batch size allowed by Kafka. Default value: 1048588. 
replica_fetch_max_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of bytes of messages to attempt to fetch for each partition. Default value: 1048576. 
ssl_cipher_suites[] | **string**<br>A list of cipher suites. 
offsets_retention_minutes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Offset storage time after a consumer group loses all its consumers. Default: 10080. 
sasl_enabled_mechanisms[] | enum **SaslMechanism**<br>The list of SASL mechanisms enabled in the Kafka server. Default: [SCRAM_SHA_512]. 


### MaintenanceWindow {#MaintenanceWindow}

Field | Description
--- | ---
policy | **oneof:** `anytime` or `weekly_maintenance_window`<br>
&nbsp;&nbsp;anytime | **[AnytimeMaintenanceWindow](#AnytimeMaintenanceWindow)**<br> 
&nbsp;&nbsp;weekly_maintenance_window | **[WeeklyMaintenanceWindow](#WeeklyMaintenanceWindow)**<br> 


### AnytimeMaintenanceWindow {#AnytimeMaintenanceWindow}

Empty.

### WeeklyMaintenanceWindow {#WeeklyMaintenanceWindow}

Field | Description
--- | ---
day | enum **WeekDay**<br> 
hour | **int64**<br>Hour of the day in UTC. Acceptable values are 1 to 24, inclusive.


### MaintenanceOperation {#MaintenanceOperation}

Field | Description
--- | ---
info | **string**<br> The maximum string length in characters is 256.
delayed_until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 


## List {#List}

Retrieves the list of Apache Kafka® clusters that belong to the specified folder.

**rpc List ([ListClustersRequest](#ListClustersRequest)) returns ([ListClustersResponse](#ListClustersResponse))**

### ListClustersRequest {#ListClustersRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to list Apache Kafka® clusters in. <br>To get the folder ID, make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List) request. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. <br>If the number of available results is larger than `page_size`, the service returns a [ListClustersResponse.next_page_token](#ListClustersResponse) that can be used to get the next page of results in subsequent list requests. The maximum value is 1000.
page_token | **string**<br>Page token. <br>To get the next page of results, set `page_token` to the [ListClustersResponse.next_page_token](#ListClustersResponse) returned by the previous list request. The maximum string length in characters is 100.
filter | **string**<br>Filter support is not currently implemented. Any filters are ignored. The maximum string length in characters is 1000.


### ListClustersResponse {#ListClustersResponse}

Field | Description
--- | ---
clusters[] | **[Cluster](#Cluster1)**<br>List of Apache Kafka® clusters. 
next_page_token | **string**<br>Token that allows you to get the next page of results for list requests. <br>If the number of results is larger than [ListClustersRequest.page_size](#ListClustersRequest), use `next_page_token` as the value for the [ListClustersRequest.page_token](#ListClustersRequest) parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### Cluster {#Cluster1}

Field | Description
--- | ---
id | **string**<br>ID of the Apache Kafka® cluster. This ID is assigned at creation time. 
folder_id | **string**<br>ID of the folder that the Apache Kafka® cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the Apache Kafka® cluster. The name must be unique within the folder. 1-63 characters long. Value must match the regular expression `[a-zA-Z0-9_-]*`. 
description | **string**<br>Description of the Apache Kafka® cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the Apache Kafka® cluster as `key:value` pairs. A maximum of 64 labels per resource is allowed. 
environment | enum **Environment**<br>Deployment environment of the Apache Kafka® cluster. <ul><li>`PRODUCTION`: stable environment with a conservative update policy when only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: environment with a more aggressive update policy when new versions are rolled out irrespective of backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring1)**<br>Description of monitoring systems relevant to the Apache Kafka® cluster. 
config | **[ConfigSpec](#ConfigSpec1)**<br>Configuration of the Apache Kafka® cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: state of the cluster is unknown ([Host.health](#Host) of all hosts in the cluster is `UNKNOWN`).</li><li>`ALIVE`: cluster is alive and well ([Host.health](#Host) of all hosts in the cluster is `ALIVE`).</li><li>`DEAD`: cluster is inoperable ([Host.health](#Host) of all hosts in the cluster is `DEAD`).</li><li>`DEGRADED`: cluster is in degraded state ([Host.health](#Host) of at least one of the hosts in the cluster is not `ALIVE`).</li></ul>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: cluster state is unknown.</li><li>`CREATING`: cluster is being created.</li><li>`RUNNING`: cluster is running normally.</li><li>`ERROR`: cluster encountered a problem and cannot operate.</li><li>`UPDATING`: cluster is being updated.</li><li>`STOPPING`: cluster is stopping.</li><li>`STOPPED`: cluster stopped.</li><li>`STARTING`: cluster is starting.</li></ul>
security_group_ids[] | **string**<br>User security groups 
host_group_ids[] | **string**<br>Host groups hosting VMs of the cluster. 
deletion_protection | **bool**<br>Deletion Protection inhibits deletion of the cluster 
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow1)**<br>Window of maintenance operations. 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation1)**<br>Scheduled maintenance operation. 


### Monitoring {#Monitoring1}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the Apache Kafka® cluster. 


### ConfigSpec {#ConfigSpec1}

Field | Description
--- | ---
version | **string**<br>Version of Apache Kafka® used in the cluster. Possible values: `2.1`, `2.6`. 
kafka | **[Kafka](#Kafka1)**<br>Configuration and resource allocation for Kafka brokers. 
zookeeper | **[Zookeeper](#Zookeeper1)**<br>Configuration and resource allocation for ZooKeeper hosts. 
zone_id[] | **string**<br>IDs of availability zones where Kafka brokers reside. 
brokers_count | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of Kafka brokers deployed in each availability zone. 
assign_public_ip | **bool**<br>The flag that defines whether a public IP address is assigned to the cluster. If the value is `true`, then Apache Kafka® cluster is available on the Internet via it's public IP address. 
unmanaged_topics | **bool**<br>Allows to manage topics via AdminAPI Deprecated. Feature enabled permanently. 
schema_registry | **bool**<br>Enables managed schema registry on cluster 
access | **[Access](#Access1)**<br>Access policy for external services. 
rest_api_config | **[RestAPIConfig](#RestAPIConfig1)**<br>Configuration of REST API. 


### Kafka {#Kafka1}

Field | Description
--- | ---
resources | **[Resources](#Resources1)**<br>Resources allocated to Kafka brokers. 
kafka_config | **oneof:** `kafka_config_2_8` or `kafka_config_3`<br>Kafka broker configuration.
&nbsp;&nbsp;kafka_config_2_8 | **[KafkaConfig2_8](#KafkaConfig2_81)**<br>Kafka broker configuration. 
&nbsp;&nbsp;kafka_config_3 | **[KafkaConfig3](#KafkaConfig31)**<br>Kafka broker configuration. 


### Zookeeper {#Zookeeper1}

Field | Description
--- | ---
resources | **[Resources](#Resources1)**<br>Resources allocated to ZooKeeper hosts. 


### RestAPIConfig {#RestAPIConfig1}

Field | Description
--- | ---
enabled | **bool**<br>Is REST API enabled for this cluster. 


### Access {#Access1}

Field | Description
--- | ---
data_transfer | **bool**<br>Allow access for DataTransfer. 


### Resources {#Resources1}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory, etc.). All available presets are listed in the [documentation](/docs/managed-kafka/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage available to a host, in bytes. Must be greater than 2 * partition segment size in bytes * partitions count, so each partition can have one active segment file and one closed segment file that can be deleted. 
disk_type_id | **string**<br>Type of the storage environment for the host. 


### KafkaConfig2_8 {#KafkaConfig2_81}

Field | Description
--- | ---
compression_type | enum **CompressionType**<br>Cluster topics compression type. <ul><li>`COMPRESSION_TYPE_UNCOMPRESSED`: no codec (uncompressed).</li><li>`COMPRESSION_TYPE_ZSTD`: Zstandard codec.</li><li>`COMPRESSION_TYPE_LZ4`: LZ4 codec.</li><li>`COMPRESSION_TYPE_SNAPPY`: Snappy codec.</li><li>`COMPRESSION_TYPE_GZIP`: GZip codec.</li><li>`COMPRESSION_TYPE_PRODUCER`: the codec to use is set by a producer (can be any of `ZSTD`, `LZ4`, `GZIP` or `SNAPPY` codecs).</li></ul>
log_flush_interval_messages | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of messages accumulated on a log partition before messages are flushed to disk. <br>This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig2_8.flush_messages](#TopicConfig2_8) setting. 
log_flush_interval_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time (in milliseconds) that a message in any topic is kept in memory before flushed to disk. If not set, the value of `log_flush_scheduler_interval_ms` is used. <br>This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig2_8.flush_ms](#TopicConfig2_8) setting. 
log_flush_scheduler_interval_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The frequency of checks (in milliseconds) for any logs that need to be flushed to disk. This check is done by the log flusher. 
log_retention_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Partition size limit; Kafka will discard old log segments to free up space if `delete` [TopicConfig2_8.cleanup_policy](#TopicConfig2_8) is in effect. This setting is helpful if you need to control the size of a log due to limited disk space. <br>This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig2_8.retention_bytes](#TopicConfig2_8) setting. 
log_retention_hours | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of hours to keep a log segment file before deleting it. 
log_retention_minutes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of minutes to keep a log segment file before deleting it. <br>If not set, the value of `log_retention_hours` is used. 
log_retention_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of milliseconds to keep a log segment file before deleting it. <br>If not set, the value of `log_retention_minutes` is used. <br>This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig2_8.retention_ms](#TopicConfig2_8) setting. 
log_segment_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size of a single log file. <br>This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig2_8.segment_bytes](#TopicConfig2_8) setting. 
log_preallocate | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Should pre allocate file when create new segment? <br>This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig2_8.preallocate](#TopicConfig2_8) setting. 
socket_send_buffer_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The SO_SNDBUF buffer of the socket server sockets. If the value is -1, the OS default will be used. 
socket_receive_buffer_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The SO_RCVBUF buffer of the socket server sockets. If the value is -1, the OS default will be used. 
auto_create_topics_enable | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Enable auto creation of topic on the server 
num_partitions | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Default number of partitions per topic on the whole cluster 
default_replication_factor | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Default replication factor of the topic on the whole cluster 
message_max_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The largest record batch size allowed by Kafka. Default value: 1048588. 
replica_fetch_max_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of bytes of messages to attempt to fetch for each partition. Default value: 1048576. 
ssl_cipher_suites[] | **string**<br>A list of cipher suites. 
offsets_retention_minutes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Offset storage time after a consumer group loses all its consumers. Default: 10080. 
sasl_enabled_mechanisms[] | enum **SaslMechanism**<br>The list of SASL mechanisms enabled in the Kafka server. Default: [SCRAM_SHA_512]. 


### KafkaConfig3 {#KafkaConfig31}

Field | Description
--- | ---
compression_type | enum **CompressionType**<br>Cluster topics compression type. <ul><li>`COMPRESSION_TYPE_UNCOMPRESSED`: no codec (uncompressed).</li><li>`COMPRESSION_TYPE_ZSTD`: Zstandard codec.</li><li>`COMPRESSION_TYPE_LZ4`: LZ4 codec.</li><li>`COMPRESSION_TYPE_SNAPPY`: Snappy codec.</li><li>`COMPRESSION_TYPE_GZIP`: GZip codec.</li><li>`COMPRESSION_TYPE_PRODUCER`: the codec to use is set by a producer (can be any of `ZSTD`, `LZ4`, `GZIP` or `SNAPPY` codecs).</li></ul>
log_flush_interval_messages | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of messages accumulated on a log partition before messages are flushed to disk. <br>This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig3.flush_messages](#TopicConfig3) setting. 
log_flush_interval_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time (in milliseconds) that a message in any topic is kept in memory before flushed to disk. If not set, the value of `log_flush_scheduler_interval_ms` is used. <br>This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig3.flush_ms](#TopicConfig3) setting. 
log_flush_scheduler_interval_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The frequency of checks (in milliseconds) for any logs that need to be flushed to disk. This check is done by the log flusher. 
log_retention_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Partition size limit; Kafka will discard old log segments to free up space if `delete` [TopicConfig3.cleanup_policy](#TopicConfig3) is in effect. This setting is helpful if you need to control the size of a log due to limited disk space. <br>This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig3.retention_bytes](#TopicConfig3) setting. 
log_retention_hours | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of hours to keep a log segment file before deleting it. 
log_retention_minutes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of minutes to keep a log segment file before deleting it. <br>If not set, the value of `log_retention_hours` is used. 
log_retention_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of milliseconds to keep a log segment file before deleting it. <br>If not set, the value of `log_retention_minutes` is used. <br>This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig3.retention_ms](#TopicConfig3) setting. 
log_segment_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size of a single log file. <br>This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig3.segment_bytes](#TopicConfig3) setting. 
log_preallocate | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Should pre allocate file when create new segment? <br>This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig3.preallocate](#TopicConfig3) setting. 
socket_send_buffer_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The SO_SNDBUF buffer of the socket server sockets. If the value is -1, the OS default will be used. 
socket_receive_buffer_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The SO_RCVBUF buffer of the socket server sockets. If the value is -1, the OS default will be used. 
auto_create_topics_enable | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Enable auto creation of topic on the server 
num_partitions | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Default number of partitions per topic on the whole cluster 
default_replication_factor | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Default replication factor of the topic on the whole cluster 
message_max_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The largest record batch size allowed by Kafka. Default value: 1048588. 
replica_fetch_max_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of bytes of messages to attempt to fetch for each partition. Default value: 1048576. 
ssl_cipher_suites[] | **string**<br>A list of cipher suites. 
offsets_retention_minutes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Offset storage time after a consumer group loses all its consumers. Default: 10080. 
sasl_enabled_mechanisms[] | enum **SaslMechanism**<br>The list of SASL mechanisms enabled in the Kafka server. Default: [SCRAM_SHA_512]. 


### MaintenanceWindow {#MaintenanceWindow1}

Field | Description
--- | ---
policy | **oneof:** `anytime` or `weekly_maintenance_window`<br>
&nbsp;&nbsp;anytime | **[AnytimeMaintenanceWindow](#AnytimeMaintenanceWindow1)**<br> 
&nbsp;&nbsp;weekly_maintenance_window | **[WeeklyMaintenanceWindow](#WeeklyMaintenanceWindow1)**<br> 


### AnytimeMaintenanceWindow {#AnytimeMaintenanceWindow1}

Empty.

### WeeklyMaintenanceWindow {#WeeklyMaintenanceWindow1}

Field | Description
--- | ---
day | enum **WeekDay**<br> 
hour | **int64**<br>Hour of the day in UTC. Acceptable values are 1 to 24, inclusive.


### MaintenanceOperation {#MaintenanceOperation1}

Field | Description
--- | ---
info | **string**<br> The maximum string length in characters is 256.
delayed_until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 


## Create {#Create}

Creates a new Apache Kafka® cluster in the specified folder.

**rpc Create ([CreateClusterRequest](#CreateClusterRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateClusterMetadata](#CreateClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster2)<br>

### CreateClusterRequest {#CreateClusterRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to create the Apache Kafka® cluster in. <br>To get the folder ID, make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List) request. The maximum string length in characters is 50.
name | **string**<br>Required. Name of the Apache Kafka® cluster. The name must be unique within the folder. The string length in characters must be 1-63. Value must match the regular expression ` [a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
description | **string**<br>Description of the Apache Kafka® cluster. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Custom labels for the Apache Kafka® cluster as `key:value` pairs. <br>For example, "project": "mvp" or "source": "dictionary". No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_./\\@0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_./\\@0-9a-z]* `.
environment | **[Cluster.Environment](#Cluster2)**<br>Deployment environment of the Apache Kafka® cluster. 
config_spec | **[ConfigSpec](#ConfigSpec2)**<br>Kafka and hosts configuration the Apache Kafka® cluster. 
topic_specs[] | **[TopicSpec](#TopicSpec)**<br>One or more configurations of topics to be created in the Apache Kafka® cluster. 
user_specs[] | **[UserSpec](#UserSpec)**<br>Configurations of accounts to be created in the Apache Kafka® cluster. 
network_id | **string**<br>ID of the network to create the Apache Kafka® cluster in. The maximum string length in characters is 50.
subnet_id[] | **string**<br>IDs of subnets to create brokers in. 
security_group_ids[] | **string**<br>User security groups 
host_group_ids[] | **string**<br>Host groups to place VMs of cluster on. 
deletion_protection | **bool**<br>Deletion Protection inhibits deletion of the cluster 
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow2)**<br>Window of maintenance operations. 


### ConfigSpec {#ConfigSpec2}

Field | Description
--- | ---
version | **string**<br>Version of Apache Kafka® used in the cluster. Possible values: `2.1`, `2.6`. 
kafka | **[Kafka](#Kafka2)**<br>Configuration and resource allocation for Kafka brokers. 
zookeeper | **[Zookeeper](#Zookeeper2)**<br>Configuration and resource allocation for ZooKeeper hosts. 
zone_id[] | **string**<br>IDs of availability zones where Kafka brokers reside. 
brokers_count | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of Kafka brokers deployed in each availability zone. 
assign_public_ip | **bool**<br>The flag that defines whether a public IP address is assigned to the cluster. If the value is `true`, then Apache Kafka® cluster is available on the Internet via it's public IP address. 
unmanaged_topics | **bool**<br>Allows to manage topics via AdminAPI Deprecated. Feature enabled permanently. 
schema_registry | **bool**<br>Enables managed schema registry on cluster 
access | **[Access](#Access2)**<br>Access policy for external services. 
rest_api_config | **[RestAPIConfig](#RestAPIConfig2)**<br>Configuration of REST API. 


### Kafka {#Kafka2}

Field | Description
--- | ---
resources | **[Resources](#Resources2)**<br>Resources allocated to Kafka brokers. 
kafka_config | **oneof:** `kafka_config_2_8` or `kafka_config_3`<br>Kafka broker configuration.
&nbsp;&nbsp;kafka_config_2_8 | **[KafkaConfig2_8](#KafkaConfig2_82)**<br>Kafka broker configuration. 
&nbsp;&nbsp;kafka_config_3 | **[KafkaConfig3](#KafkaConfig32)**<br>Kafka broker configuration. 


### Zookeeper {#Zookeeper2}

Field | Description
--- | ---
resources | **[Resources](#Resources2)**<br>Resources allocated to ZooKeeper hosts. 


### RestAPIConfig {#RestAPIConfig2}

Field | Description
--- | ---
enabled | **bool**<br>Is REST API enabled for this cluster. 


### Access {#Access2}

Field | Description
--- | ---
data_transfer | **bool**<br>Allow access for DataTransfer. 


### Resources {#Resources2}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory, etc.). All available presets are listed in the [documentation](/docs/managed-kafka/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage available to a host, in bytes. Must be greater than 2 * partition segment size in bytes * partitions count, so each partition can have one active segment file and one closed segment file that can be deleted. 
disk_type_id | **string**<br>Type of the storage environment for the host. 


### KafkaConfig2_8 {#KafkaConfig2_82}

Field | Description
--- | ---
compression_type | enum **CompressionType**<br>Cluster topics compression type. <ul><li>`COMPRESSION_TYPE_UNCOMPRESSED`: no codec (uncompressed).</li><li>`COMPRESSION_TYPE_ZSTD`: Zstandard codec.</li><li>`COMPRESSION_TYPE_LZ4`: LZ4 codec.</li><li>`COMPRESSION_TYPE_SNAPPY`: Snappy codec.</li><li>`COMPRESSION_TYPE_GZIP`: GZip codec.</li><li>`COMPRESSION_TYPE_PRODUCER`: the codec to use is set by a producer (can be any of `ZSTD`, `LZ4`, `GZIP` or `SNAPPY` codecs).</li></ul>
log_flush_interval_messages | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of messages accumulated on a log partition before messages are flushed to disk. <br>This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig2_8.flush_messages](#TopicConfig2_8) setting. 
log_flush_interval_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time (in milliseconds) that a message in any topic is kept in memory before flushed to disk. If not set, the value of `log_flush_scheduler_interval_ms` is used. <br>This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig2_8.flush_ms](#TopicConfig2_8) setting. 
log_flush_scheduler_interval_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The frequency of checks (in milliseconds) for any logs that need to be flushed to disk. This check is done by the log flusher. 
log_retention_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Partition size limit; Kafka will discard old log segments to free up space if `delete` [TopicConfig2_8.cleanup_policy](#TopicConfig2_8) is in effect. This setting is helpful if you need to control the size of a log due to limited disk space. <br>This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig2_8.retention_bytes](#TopicConfig2_8) setting. 
log_retention_hours | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of hours to keep a log segment file before deleting it. 
log_retention_minutes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of minutes to keep a log segment file before deleting it. <br>If not set, the value of `log_retention_hours` is used. 
log_retention_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of milliseconds to keep a log segment file before deleting it. <br>If not set, the value of `log_retention_minutes` is used. <br>This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig2_8.retention_ms](#TopicConfig2_8) setting. 
log_segment_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size of a single log file. <br>This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig2_8.segment_bytes](#TopicConfig2_8) setting. 
log_preallocate | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Should pre allocate file when create new segment? <br>This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig2_8.preallocate](#TopicConfig2_8) setting. 
socket_send_buffer_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The SO_SNDBUF buffer of the socket server sockets. If the value is -1, the OS default will be used. 
socket_receive_buffer_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The SO_RCVBUF buffer of the socket server sockets. If the value is -1, the OS default will be used. 
auto_create_topics_enable | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Enable auto creation of topic on the server 
num_partitions | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Default number of partitions per topic on the whole cluster 
default_replication_factor | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Default replication factor of the topic on the whole cluster 
message_max_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The largest record batch size allowed by Kafka. Default value: 1048588. 
replica_fetch_max_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of bytes of messages to attempt to fetch for each partition. Default value: 1048576. 
ssl_cipher_suites[] | **string**<br>A list of cipher suites. 
offsets_retention_minutes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Offset storage time after a consumer group loses all its consumers. Default: 10080. 
sasl_enabled_mechanisms[] | enum **SaslMechanism**<br>The list of SASL mechanisms enabled in the Kafka server. Default: [SCRAM_SHA_512]. 


### KafkaConfig3 {#KafkaConfig32}

Field | Description
--- | ---
compression_type | enum **CompressionType**<br>Cluster topics compression type. <ul><li>`COMPRESSION_TYPE_UNCOMPRESSED`: no codec (uncompressed).</li><li>`COMPRESSION_TYPE_ZSTD`: Zstandard codec.</li><li>`COMPRESSION_TYPE_LZ4`: LZ4 codec.</li><li>`COMPRESSION_TYPE_SNAPPY`: Snappy codec.</li><li>`COMPRESSION_TYPE_GZIP`: GZip codec.</li><li>`COMPRESSION_TYPE_PRODUCER`: the codec to use is set by a producer (can be any of `ZSTD`, `LZ4`, `GZIP` or `SNAPPY` codecs).</li></ul>
log_flush_interval_messages | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of messages accumulated on a log partition before messages are flushed to disk. <br>This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig3.flush_messages](#TopicConfig3) setting. 
log_flush_interval_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time (in milliseconds) that a message in any topic is kept in memory before flushed to disk. If not set, the value of `log_flush_scheduler_interval_ms` is used. <br>This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig3.flush_ms](#TopicConfig3) setting. 
log_flush_scheduler_interval_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The frequency of checks (in milliseconds) for any logs that need to be flushed to disk. This check is done by the log flusher. 
log_retention_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Partition size limit; Kafka will discard old log segments to free up space if `delete` [TopicConfig3.cleanup_policy](#TopicConfig3) is in effect. This setting is helpful if you need to control the size of a log due to limited disk space. <br>This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig3.retention_bytes](#TopicConfig3) setting. 
log_retention_hours | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of hours to keep a log segment file before deleting it. 
log_retention_minutes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of minutes to keep a log segment file before deleting it. <br>If not set, the value of `log_retention_hours` is used. 
log_retention_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of milliseconds to keep a log segment file before deleting it. <br>If not set, the value of `log_retention_minutes` is used. <br>This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig3.retention_ms](#TopicConfig3) setting. 
log_segment_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size of a single log file. <br>This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig3.segment_bytes](#TopicConfig3) setting. 
log_preallocate | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Should pre allocate file when create new segment? <br>This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig3.preallocate](#TopicConfig3) setting. 
socket_send_buffer_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The SO_SNDBUF buffer of the socket server sockets. If the value is -1, the OS default will be used. 
socket_receive_buffer_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The SO_RCVBUF buffer of the socket server sockets. If the value is -1, the OS default will be used. 
auto_create_topics_enable | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Enable auto creation of topic on the server 
num_partitions | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Default number of partitions per topic on the whole cluster 
default_replication_factor | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Default replication factor of the topic on the whole cluster 
message_max_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The largest record batch size allowed by Kafka. Default value: 1048588. 
replica_fetch_max_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of bytes of messages to attempt to fetch for each partition. Default value: 1048576. 
ssl_cipher_suites[] | **string**<br>A list of cipher suites. 
offsets_retention_minutes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Offset storage time after a consumer group loses all its consumers. Default: 10080. 
sasl_enabled_mechanisms[] | enum **SaslMechanism**<br>The list of SASL mechanisms enabled in the Kafka server. Default: [SCRAM_SHA_512]. 


### TopicSpec {#TopicSpec}

Field | Description
--- | ---
name | **string**<br>Name of the topic. 
partitions | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of the topic's partitions. 
replication_factor | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Amount of copies of a topic data kept in the cluster. 
topic_config | **oneof:** `topic_config_2_8` or `topic_config_3`<br>User-defined settings for the topic.
&nbsp;&nbsp;topic_config_2_8 | **[TopicConfig2_8](#TopicConfig2_8)**<br>User-defined settings for the topic. 
&nbsp;&nbsp;topic_config_3 | **[TopicConfig3](#TopicConfig3)**<br>User-defined settings for the topic. 


### TopicConfig2_8 {#TopicConfig2_8}

Field | Description
--- | ---
cleanup_policy | enum **CleanupPolicy**<br>Retention policy to use on old log messages. <ul><li>`CLEANUP_POLICY_DELETE`: this policy discards log segments when either their retention time or log size limit is reached. See also: [KafkaConfig2_8.log_retention_ms](#KafkaConfig2_83) and other similar parameters.</li><li>`CLEANUP_POLICY_COMPACT`: this policy compacts messages in log.</li><li>`CLEANUP_POLICY_COMPACT_AND_DELETE`: this policy use both compaction and deletion for messages and log segments.</li></ul>
compression_type | enum **CompressionType**<br>The compression type for a given topic. <ul><li>`COMPRESSION_TYPE_UNCOMPRESSED`: no codec (uncompressed).</li><li>`COMPRESSION_TYPE_ZSTD`: Zstandard codec.</li><li>`COMPRESSION_TYPE_LZ4`: LZ4 codec.</li><li>`COMPRESSION_TYPE_SNAPPY`: Snappy codec.</li><li>`COMPRESSION_TYPE_GZIP`: GZip codec.</li><li>`COMPRESSION_TYPE_PRODUCER`: the codec to use is set by a producer (can be any of `ZSTD`, `LZ4`, `GZIP` or `SNAPPY` codecs).</li></ul>
delete_retention_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The amount of time in milliseconds to retain delete tombstone markers for log compacted topics. 
file_delete_delay_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The time to wait before deleting a file from the filesystem. 
flush_messages | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of messages accumulated on a log partition before messages are flushed to disk. <br>This setting overrides the cluster-level [KafkaConfig2_8.log_flush_interval_messages](#KafkaConfig2_83) setting on the topic level. 
flush_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time in milliseconds that a message in the topic is kept in memory before flushed to disk. <br>This setting overrides the cluster-level [KafkaConfig2_8.log_flush_interval_ms](#KafkaConfig2_83) setting on the topic level. 
min_compaction_lag_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The minimum time in milliseconds a message will remain uncompacted in the log. 
retention_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size a partition can grow to before Kafka will discard old log segments to free up space if the `delete` `cleanup_policy` is in effect. It is helpful if you need to control the size of log due to limited disk space. <br>This setting overrides the cluster-level [KafkaConfig2_8.log_retention_bytes](#KafkaConfig2_83) setting on the topic level. 
retention_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of milliseconds to keep a log segment's file before deleting it. <br>This setting overrides the cluster-level [KafkaConfig2_8.log_retention_ms](#KafkaConfig2_83) setting on the topic level. 
max_message_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The largest record batch size allowed in topic. 
min_insync_replicas | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>This configuration specifies the minimum number of replicas that must acknowledge a write to topic for the write to be considered successful (when a producer sets acks to "all"). 
segment_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>This configuration controls the segment file size for the log. Retention and cleaning is always done a file at a time so a larger segment size means fewer files but less granular control over retention. <br>This setting overrides the cluster-level [KafkaConfig2_8.log_segment_bytes](#KafkaConfig2_83) setting on the topic level. 
preallocate | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>True if we should preallocate the file on disk when creating a new log segment. <br>This setting overrides the cluster-level [KafkaConfig2_8.log_preallocate](#KafkaConfig2_83) setting on the topic level. 


### TopicConfig3 {#TopicConfig3}

Field | Description
--- | ---
cleanup_policy | enum **CleanupPolicy**<br>Retention policy to use on old log messages. <ul><li>`CLEANUP_POLICY_DELETE`: this policy discards log segments when either their retention time or log size limit is reached. See also: [KafkaConfig3.log_retention_ms](#KafkaConfig33) and other similar parameters.</li><li>`CLEANUP_POLICY_COMPACT`: this policy compacts messages in log.</li><li>`CLEANUP_POLICY_COMPACT_AND_DELETE`: this policy use both compaction and deletion for messages and log segments.</li></ul>
compression_type | enum **CompressionType**<br>The compression type for a given topic. <ul><li>`COMPRESSION_TYPE_UNCOMPRESSED`: no codec (uncompressed).</li><li>`COMPRESSION_TYPE_ZSTD`: Zstandard codec.</li><li>`COMPRESSION_TYPE_LZ4`: LZ4 codec.</li><li>`COMPRESSION_TYPE_SNAPPY`: Snappy codec.</li><li>`COMPRESSION_TYPE_GZIP`: GZip codec.</li><li>`COMPRESSION_TYPE_PRODUCER`: the codec to use is set by a producer (can be any of `ZSTD`, `LZ4`, `GZIP` or `SNAPPY` codecs).</li></ul>
delete_retention_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The amount of time in milliseconds to retain delete tombstone markers for log compacted topics. 
file_delete_delay_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The time to wait before deleting a file from the filesystem. 
flush_messages | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of messages accumulated on a log partition before messages are flushed to disk. <br>This setting overrides the cluster-level [KafkaConfig3.log_flush_interval_messages](#KafkaConfig33) setting on the topic level. 
flush_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time in milliseconds that a message in the topic is kept in memory before flushed to disk. <br>This setting overrides the cluster-level [KafkaConfig3.log_flush_interval_ms](#KafkaConfig33) setting on the topic level. 
min_compaction_lag_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The minimum time in milliseconds a message will remain uncompacted in the log. 
retention_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size a partition can grow to before Kafka will discard old log segments to free up space if the `delete` `cleanup_policy` is in effect. It is helpful if you need to control the size of log due to limited disk space. <br>This setting overrides the cluster-level [KafkaConfig3.log_retention_bytes](#KafkaConfig33) setting on the topic level. 
retention_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of milliseconds to keep a log segment's file before deleting it. <br>This setting overrides the cluster-level [KafkaConfig3.log_retention_ms](#KafkaConfig33) setting on the topic level. 
max_message_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The largest record batch size allowed in topic. 
min_insync_replicas | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>This configuration specifies the minimum number of replicas that must acknowledge a write to topic for the write to be considered successful (when a producer sets acks to "all"). 
segment_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>This configuration controls the segment file size for the log. Retention and cleaning is always done a file at a time so a larger segment size means fewer files but less granular control over retention. <br>This setting overrides the cluster-level [KafkaConfig3.log_segment_bytes](#KafkaConfig33) setting on the topic level. 
preallocate | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>True if we should preallocate the file on disk when creating a new log segment. <br>This setting overrides the cluster-level [KafkaConfig3.log_preallocate](#KafkaConfig33) setting on the topic level. 


### UserSpec {#UserSpec}

Field | Description
--- | ---
name | **string**<br>Required. Name of the Kafka user. The string length in characters must be 1-256. Value must match the regular expression ` [a-zA-Z0-9_]* `.
password | **string**<br>Required. Password of the Kafka user. The string length in characters must be 8-128.
permissions[] | **[Permission](#Permission)**<br>Set of permissions granted to the user. 


### Permission {#Permission}

Field | Description
--- | ---
topic_name | **string**<br>Name or prefix-pattern with wildcard for the topic that the permission grants access to. <br>To get the topic name, make a [TopicService.List](./topic_service#List) request. 
role | enum **AccessRole**<br>Access role type to grant to the user. <ul><li>`ACCESS_ROLE_PRODUCER`: producer role for the user.</li><li>`ACCESS_ROLE_CONSUMER`: consumer role for the user.</li><li>`ACCESS_ROLE_ADMIN`: admin role for the user.</li></ul>
allow_hosts[] | **string**<br>Lists hosts allowed for this permission. When not defined, access from any host is allowed. <br>Bare in mind that the same host might appear in multiple permissions at the same time, hence removing individual permission doesn't automatically restricts access from the `allow_hosts` of the permission. If the same host(s) is listed for another permission of the same principal/topic, the host(s) remains allowed. 


### MaintenanceWindow {#MaintenanceWindow2}

Field | Description
--- | ---
policy | **oneof:** `anytime` or `weekly_maintenance_window`<br>
&nbsp;&nbsp;anytime | **[AnytimeMaintenanceWindow](#AnytimeMaintenanceWindow2)**<br> 
&nbsp;&nbsp;weekly_maintenance_window | **[WeeklyMaintenanceWindow](#WeeklyMaintenanceWindow2)**<br> 


### AnytimeMaintenanceWindow {#AnytimeMaintenanceWindow2}

Empty.

### WeeklyMaintenanceWindow {#WeeklyMaintenanceWindow2}

Field | Description
--- | ---
day | enum **WeekDay**<br> 
hour | **int64**<br>Hour of the day in UTC. Acceptable values are 1 to 24, inclusive.


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
cluster_id | **string**<br>ID of the Apache Kafka® cluster that is being created. 


### Cluster {#Cluster2}

Field | Description
--- | ---
id | **string**<br>ID of the Apache Kafka® cluster. This ID is assigned at creation time. 
folder_id | **string**<br>ID of the folder that the Apache Kafka® cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the Apache Kafka® cluster. The name must be unique within the folder. 1-63 characters long. Value must match the regular expression `[a-zA-Z0-9_-]*`. 
description | **string**<br>Description of the Apache Kafka® cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the Apache Kafka® cluster as `key:value` pairs. A maximum of 64 labels per resource is allowed. 
environment | enum **Environment**<br>Deployment environment of the Apache Kafka® cluster. <ul><li>`PRODUCTION`: stable environment with a conservative update policy when only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: environment with a more aggressive update policy when new versions are rolled out irrespective of backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring2)**<br>Description of monitoring systems relevant to the Apache Kafka® cluster. 
config | **[ConfigSpec](#ConfigSpec3)**<br>Configuration of the Apache Kafka® cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: state of the cluster is unknown ([Host.health](#Host) of all hosts in the cluster is `UNKNOWN`).</li><li>`ALIVE`: cluster is alive and well ([Host.health](#Host) of all hosts in the cluster is `ALIVE`).</li><li>`DEAD`: cluster is inoperable ([Host.health](#Host) of all hosts in the cluster is `DEAD`).</li><li>`DEGRADED`: cluster is in degraded state ([Host.health](#Host) of at least one of the hosts in the cluster is not `ALIVE`).</li></ul>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: cluster state is unknown.</li><li>`CREATING`: cluster is being created.</li><li>`RUNNING`: cluster is running normally.</li><li>`ERROR`: cluster encountered a problem and cannot operate.</li><li>`UPDATING`: cluster is being updated.</li><li>`STOPPING`: cluster is stopping.</li><li>`STOPPED`: cluster stopped.</li><li>`STARTING`: cluster is starting.</li></ul>
security_group_ids[] | **string**<br>User security groups 
host_group_ids[] | **string**<br>Host groups hosting VMs of the cluster. 
deletion_protection | **bool**<br>Deletion Protection inhibits deletion of the cluster 
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow3)**<br>Window of maintenance operations. 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation2)**<br>Scheduled maintenance operation. 


### Monitoring {#Monitoring2}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the Apache Kafka® cluster. 


### MaintenanceOperation {#MaintenanceOperation2}

Field | Description
--- | ---
info | **string**<br> The maximum string length in characters is 256.
delayed_until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 


## Update {#Update}

Updates the specified Apache Kafka® cluster.

**rpc Update ([UpdateClusterRequest](#UpdateClusterRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateClusterMetadata](#UpdateClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster3)<br>

### UpdateClusterRequest {#UpdateClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Apache Kafka® cluster to update. <br>To get the Apache Kafka® cluster ID, make a [ClusterService.List](#List) request. The maximum string length in characters is 50.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br> 
description | **string**<br>New description of the Apache Kafka® cluster. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Custom labels for the Apache Kafka® cluster as `key:value` pairs. <br>For example, "project": "mvp" or "source": "dictionary". <br>The new set of labels will completely replace the old ones. To add a label, request the current set with the [ClusterService.Get](#Get) method, then send an [ClusterService.Update](#Update) request with the new label added to the set. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
config_spec | **[ConfigSpec](#ConfigSpec3)**<br>New configuration and resources for hosts in the Apache Kafka® cluster. <br>Use `update_mask` to prevent reverting all cluster settings that are not listed in `config_spec` to their default values. 
name | **string**<br>New name for the Apache Kafka® cluster. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
security_group_ids[] | **string**<br>User security groups 
deletion_protection | **bool**<br>Deletion Protection inhibits deletion of the cluster 
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow3)**<br>New maintenance window settings for the cluster. 


### ConfigSpec {#ConfigSpec3}

Field | Description
--- | ---
version | **string**<br>Version of Apache Kafka® used in the cluster. Possible values: `2.1`, `2.6`. 
kafka | **[Kafka](#Kafka3)**<br>Configuration and resource allocation for Kafka brokers. 
zookeeper | **[Zookeeper](#Zookeeper3)**<br>Configuration and resource allocation for ZooKeeper hosts. 
zone_id[] | **string**<br>IDs of availability zones where Kafka brokers reside. 
brokers_count | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of Kafka brokers deployed in each availability zone. 
assign_public_ip | **bool**<br>The flag that defines whether a public IP address is assigned to the cluster. If the value is `true`, then Apache Kafka® cluster is available on the Internet via it's public IP address. 
unmanaged_topics | **bool**<br>Allows to manage topics via AdminAPI Deprecated. Feature enabled permanently. 
schema_registry | **bool**<br>Enables managed schema registry on cluster 
access | **[Access](#Access3)**<br>Access policy for external services. 
rest_api_config | **[RestAPIConfig](#RestAPIConfig3)**<br>Configuration of REST API. 


### Kafka {#Kafka3}

Field | Description
--- | ---
resources | **[Resources](#Resources3)**<br>Resources allocated to Kafka brokers. 
kafka_config | **oneof:** `kafka_config_2_8` or `kafka_config_3`<br>Kafka broker configuration.
&nbsp;&nbsp;kafka_config_2_8 | **[KafkaConfig2_8](#KafkaConfig2_83)**<br>Kafka broker configuration. 
&nbsp;&nbsp;kafka_config_3 | **[KafkaConfig3](#KafkaConfig33)**<br>Kafka broker configuration. 


### Zookeeper {#Zookeeper3}

Field | Description
--- | ---
resources | **[Resources](#Resources3)**<br>Resources allocated to ZooKeeper hosts. 


### RestAPIConfig {#RestAPIConfig3}

Field | Description
--- | ---
enabled | **bool**<br>Is REST API enabled for this cluster. 


### Access {#Access3}

Field | Description
--- | ---
data_transfer | **bool**<br>Allow access for DataTransfer. 


### Resources {#Resources3}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory, etc.). All available presets are listed in the [documentation](/docs/managed-kafka/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage available to a host, in bytes. Must be greater than 2 * partition segment size in bytes * partitions count, so each partition can have one active segment file and one closed segment file that can be deleted. 
disk_type_id | **string**<br>Type of the storage environment for the host. 


### KafkaConfig2_8 {#KafkaConfig2_83}

Field | Description
--- | ---
compression_type | enum **CompressionType**<br>Cluster topics compression type. <ul><li>`COMPRESSION_TYPE_UNCOMPRESSED`: no codec (uncompressed).</li><li>`COMPRESSION_TYPE_ZSTD`: Zstandard codec.</li><li>`COMPRESSION_TYPE_LZ4`: LZ4 codec.</li><li>`COMPRESSION_TYPE_SNAPPY`: Snappy codec.</li><li>`COMPRESSION_TYPE_GZIP`: GZip codec.</li><li>`COMPRESSION_TYPE_PRODUCER`: the codec to use is set by a producer (can be any of `ZSTD`, `LZ4`, `GZIP` or `SNAPPY` codecs).</li></ul>
log_flush_interval_messages | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of messages accumulated on a log partition before messages are flushed to disk. <br>This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig2_8.flush_messages](#TopicConfig2_81) setting. 
log_flush_interval_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time (in milliseconds) that a message in any topic is kept in memory before flushed to disk. If not set, the value of `log_flush_scheduler_interval_ms` is used. <br>This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig2_8.flush_ms](#TopicConfig2_81) setting. 
log_flush_scheduler_interval_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The frequency of checks (in milliseconds) for any logs that need to be flushed to disk. This check is done by the log flusher. 
log_retention_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Partition size limit; Kafka will discard old log segments to free up space if `delete` [TopicConfig2_8.cleanup_policy](#TopicConfig2_81) is in effect. This setting is helpful if you need to control the size of a log due to limited disk space. <br>This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig2_8.retention_bytes](#TopicConfig2_81) setting. 
log_retention_hours | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of hours to keep a log segment file before deleting it. 
log_retention_minutes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of minutes to keep a log segment file before deleting it. <br>If not set, the value of `log_retention_hours` is used. 
log_retention_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of milliseconds to keep a log segment file before deleting it. <br>If not set, the value of `log_retention_minutes` is used. <br>This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig2_8.retention_ms](#TopicConfig2_81) setting. 
log_segment_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size of a single log file. <br>This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig2_8.segment_bytes](#TopicConfig2_81) setting. 
log_preallocate | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Should pre allocate file when create new segment? <br>This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig2_8.preallocate](#TopicConfig2_81) setting. 
socket_send_buffer_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The SO_SNDBUF buffer of the socket server sockets. If the value is -1, the OS default will be used. 
socket_receive_buffer_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The SO_RCVBUF buffer of the socket server sockets. If the value is -1, the OS default will be used. 
auto_create_topics_enable | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Enable auto creation of topic on the server 
num_partitions | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Default number of partitions per topic on the whole cluster 
default_replication_factor | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Default replication factor of the topic on the whole cluster 
message_max_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The largest record batch size allowed by Kafka. Default value: 1048588. 
replica_fetch_max_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of bytes of messages to attempt to fetch for each partition. Default value: 1048576. 
ssl_cipher_suites[] | **string**<br>A list of cipher suites. 
offsets_retention_minutes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Offset storage time after a consumer group loses all its consumers. Default: 10080. 
sasl_enabled_mechanisms[] | enum **SaslMechanism**<br>The list of SASL mechanisms enabled in the Kafka server. Default: [SCRAM_SHA_512]. 


### KafkaConfig3 {#KafkaConfig33}

Field | Description
--- | ---
compression_type | enum **CompressionType**<br>Cluster topics compression type. <ul><li>`COMPRESSION_TYPE_UNCOMPRESSED`: no codec (uncompressed).</li><li>`COMPRESSION_TYPE_ZSTD`: Zstandard codec.</li><li>`COMPRESSION_TYPE_LZ4`: LZ4 codec.</li><li>`COMPRESSION_TYPE_SNAPPY`: Snappy codec.</li><li>`COMPRESSION_TYPE_GZIP`: GZip codec.</li><li>`COMPRESSION_TYPE_PRODUCER`: the codec to use is set by a producer (can be any of `ZSTD`, `LZ4`, `GZIP` or `SNAPPY` codecs).</li></ul>
log_flush_interval_messages | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of messages accumulated on a log partition before messages are flushed to disk. <br>This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig3.flush_messages](#TopicConfig31) setting. 
log_flush_interval_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time (in milliseconds) that a message in any topic is kept in memory before flushed to disk. If not set, the value of `log_flush_scheduler_interval_ms` is used. <br>This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig3.flush_ms](#TopicConfig31) setting. 
log_flush_scheduler_interval_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The frequency of checks (in milliseconds) for any logs that need to be flushed to disk. This check is done by the log flusher. 
log_retention_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Partition size limit; Kafka will discard old log segments to free up space if `delete` [TopicConfig3.cleanup_policy](#TopicConfig31) is in effect. This setting is helpful if you need to control the size of a log due to limited disk space. <br>This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig3.retention_bytes](#TopicConfig31) setting. 
log_retention_hours | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of hours to keep a log segment file before deleting it. 
log_retention_minutes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of minutes to keep a log segment file before deleting it. <br>If not set, the value of `log_retention_hours` is used. 
log_retention_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of milliseconds to keep a log segment file before deleting it. <br>If not set, the value of `log_retention_minutes` is used. <br>This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig3.retention_ms](#TopicConfig31) setting. 
log_segment_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size of a single log file. <br>This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig3.segment_bytes](#TopicConfig31) setting. 
log_preallocate | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Should pre allocate file when create new segment? <br>This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig3.preallocate](#TopicConfig31) setting. 
socket_send_buffer_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The SO_SNDBUF buffer of the socket server sockets. If the value is -1, the OS default will be used. 
socket_receive_buffer_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The SO_RCVBUF buffer of the socket server sockets. If the value is -1, the OS default will be used. 
auto_create_topics_enable | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Enable auto creation of topic on the server 
num_partitions | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Default number of partitions per topic on the whole cluster 
default_replication_factor | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Default replication factor of the topic on the whole cluster 
message_max_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The largest record batch size allowed by Kafka. Default value: 1048588. 
replica_fetch_max_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of bytes of messages to attempt to fetch for each partition. Default value: 1048576. 
ssl_cipher_suites[] | **string**<br>A list of cipher suites. 
offsets_retention_minutes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Offset storage time after a consumer group loses all its consumers. Default: 10080. 
sasl_enabled_mechanisms[] | enum **SaslMechanism**<br>The list of SASL mechanisms enabled in the Kafka server. Default: [SCRAM_SHA_512]. 


### MaintenanceWindow {#MaintenanceWindow3}

Field | Description
--- | ---
policy | **oneof:** `anytime` or `weekly_maintenance_window`<br>
&nbsp;&nbsp;anytime | **[AnytimeMaintenanceWindow](#AnytimeMaintenanceWindow3)**<br> 
&nbsp;&nbsp;weekly_maintenance_window | **[WeeklyMaintenanceWindow](#WeeklyMaintenanceWindow3)**<br> 


### AnytimeMaintenanceWindow {#AnytimeMaintenanceWindow3}

Empty.

### WeeklyMaintenanceWindow {#WeeklyMaintenanceWindow3}

Field | Description
--- | ---
day | enum **WeekDay**<br> 
hour | **int64**<br>Hour of the day in UTC. Acceptable values are 1 to 24, inclusive.


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
cluster_id | **string**<br>ID of the Apache Kafka® cluster that is being updated. 


### Cluster {#Cluster3}

Field | Description
--- | ---
id | **string**<br>ID of the Apache Kafka® cluster. This ID is assigned at creation time. 
folder_id | **string**<br>ID of the folder that the Apache Kafka® cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the Apache Kafka® cluster. The name must be unique within the folder. 1-63 characters long. Value must match the regular expression `[a-zA-Z0-9_-]*`. 
description | **string**<br>Description of the Apache Kafka® cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the Apache Kafka® cluster as `key:value` pairs. A maximum of 64 labels per resource is allowed. 
environment | enum **Environment**<br>Deployment environment of the Apache Kafka® cluster. <ul><li>`PRODUCTION`: stable environment with a conservative update policy when only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: environment with a more aggressive update policy when new versions are rolled out irrespective of backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring3)**<br>Description of monitoring systems relevant to the Apache Kafka® cluster. 
config | **[ConfigSpec](#ConfigSpec4)**<br>Configuration of the Apache Kafka® cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: state of the cluster is unknown ([Host.health](#Host) of all hosts in the cluster is `UNKNOWN`).</li><li>`ALIVE`: cluster is alive and well ([Host.health](#Host) of all hosts in the cluster is `ALIVE`).</li><li>`DEAD`: cluster is inoperable ([Host.health](#Host) of all hosts in the cluster is `DEAD`).</li><li>`DEGRADED`: cluster is in degraded state ([Host.health](#Host) of at least one of the hosts in the cluster is not `ALIVE`).</li></ul>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: cluster state is unknown.</li><li>`CREATING`: cluster is being created.</li><li>`RUNNING`: cluster is running normally.</li><li>`ERROR`: cluster encountered a problem and cannot operate.</li><li>`UPDATING`: cluster is being updated.</li><li>`STOPPING`: cluster is stopping.</li><li>`STOPPED`: cluster stopped.</li><li>`STARTING`: cluster is starting.</li></ul>
security_group_ids[] | **string**<br>User security groups 
host_group_ids[] | **string**<br>Host groups hosting VMs of the cluster. 
deletion_protection | **bool**<br>Deletion Protection inhibits deletion of the cluster 
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow4)**<br>Window of maintenance operations. 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation3)**<br>Scheduled maintenance operation. 


### Monitoring {#Monitoring3}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the Apache Kafka® cluster. 


### MaintenanceOperation {#MaintenanceOperation3}

Field | Description
--- | ---
info | **string**<br> The maximum string length in characters is 256.
delayed_until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 


## Delete {#Delete}

Deletes the specified Apache Kafka® cluster.

**rpc Delete ([DeleteClusterRequest](#DeleteClusterRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteClusterMetadata](#DeleteClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteClusterRequest {#DeleteClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Apache Kafka® cluster to delete. <br>To get the Apache Kafka® cluster ID, make a [ClusterService.List](#List) request. The maximum string length in characters is 50.


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
cluster_id | **string**<br>ID of the Apache Kafka® cluster that is being deleted. 


## Move {#Move}

Moves the specified Apache Kafka® cluster to the specified folder.

**rpc Move ([MoveClusterRequest](#MoveClusterRequest)) returns ([operation.Operation](#Operation3))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[MoveClusterMetadata](#MoveClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster4)<br>

### MoveClusterRequest {#MoveClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Apache Kafka® cluster to move. <br>To get the Apache Kafka® cluster ID, make a [ClusterService.List](#List) request. The maximum string length in characters is 50.
destination_folder_id | **string**<br>Required. ID of the destination folder. The maximum string length in characters is 50.


### Operation {#Operation3}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[MoveClusterMetadata](#MoveClusterMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Cluster](#Cluster4)>**<br>if operation finished successfully. 


### MoveClusterMetadata {#MoveClusterMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>ID of the Apache Kafka® cluster being moved. 
source_folder_id | **string**<br>ID of the source folder. 
destination_folder_id | **string**<br>ID of the destnation folder. 


### Cluster {#Cluster4}

Field | Description
--- | ---
id | **string**<br>ID of the Apache Kafka® cluster. This ID is assigned at creation time. 
folder_id | **string**<br>ID of the folder that the Apache Kafka® cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the Apache Kafka® cluster. The name must be unique within the folder. 1-63 characters long. Value must match the regular expression `[a-zA-Z0-9_-]*`. 
description | **string**<br>Description of the Apache Kafka® cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the Apache Kafka® cluster as `key:value` pairs. A maximum of 64 labels per resource is allowed. 
environment | enum **Environment**<br>Deployment environment of the Apache Kafka® cluster. <ul><li>`PRODUCTION`: stable environment with a conservative update policy when only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: environment with a more aggressive update policy when new versions are rolled out irrespective of backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring4)**<br>Description of monitoring systems relevant to the Apache Kafka® cluster. 
config | **[ConfigSpec](#ConfigSpec4)**<br>Configuration of the Apache Kafka® cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: state of the cluster is unknown ([Host.health](#Host) of all hosts in the cluster is `UNKNOWN`).</li><li>`ALIVE`: cluster is alive and well ([Host.health](#Host) of all hosts in the cluster is `ALIVE`).</li><li>`DEAD`: cluster is inoperable ([Host.health](#Host) of all hosts in the cluster is `DEAD`).</li><li>`DEGRADED`: cluster is in degraded state ([Host.health](#Host) of at least one of the hosts in the cluster is not `ALIVE`).</li></ul>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: cluster state is unknown.</li><li>`CREATING`: cluster is being created.</li><li>`RUNNING`: cluster is running normally.</li><li>`ERROR`: cluster encountered a problem and cannot operate.</li><li>`UPDATING`: cluster is being updated.</li><li>`STOPPING`: cluster is stopping.</li><li>`STOPPED`: cluster stopped.</li><li>`STARTING`: cluster is starting.</li></ul>
security_group_ids[] | **string**<br>User security groups 
host_group_ids[] | **string**<br>Host groups hosting VMs of the cluster. 
deletion_protection | **bool**<br>Deletion Protection inhibits deletion of the cluster 
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow4)**<br>Window of maintenance operations. 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation4)**<br>Scheduled maintenance operation. 


### Monitoring {#Monitoring4}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the Apache Kafka® cluster. 


### ConfigSpec {#ConfigSpec4}

Field | Description
--- | ---
version | **string**<br>Version of Apache Kafka® used in the cluster. Possible values: `2.1`, `2.6`. 
kafka | **[Kafka](#Kafka4)**<br>Configuration and resource allocation for Kafka brokers. 
zookeeper | **[Zookeeper](#Zookeeper4)**<br>Configuration and resource allocation for ZooKeeper hosts. 
zone_id[] | **string**<br>IDs of availability zones where Kafka brokers reside. 
brokers_count | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of Kafka brokers deployed in each availability zone. 
assign_public_ip | **bool**<br>The flag that defines whether a public IP address is assigned to the cluster. If the value is `true`, then Apache Kafka® cluster is available on the Internet via it's public IP address. 
unmanaged_topics | **bool**<br>Allows to manage topics via AdminAPI Deprecated. Feature enabled permanently. 
schema_registry | **bool**<br>Enables managed schema registry on cluster 
access | **[Access](#Access4)**<br>Access policy for external services. 
rest_api_config | **[RestAPIConfig](#RestAPIConfig4)**<br>Configuration of REST API. 


### Kafka {#Kafka4}

Field | Description
--- | ---
resources | **[Resources](#Resources4)**<br>Resources allocated to Kafka brokers. 
kafka_config | **oneof:** `kafka_config_2_8` or `kafka_config_3`<br>Kafka broker configuration.
&nbsp;&nbsp;kafka_config_2_8 | **[KafkaConfig2_8](#KafkaConfig2_84)**<br>Kafka broker configuration. 
&nbsp;&nbsp;kafka_config_3 | **[KafkaConfig3](#KafkaConfig34)**<br>Kafka broker configuration. 


### Zookeeper {#Zookeeper4}

Field | Description
--- | ---
resources | **[Resources](#Resources4)**<br>Resources allocated to ZooKeeper hosts. 


### RestAPIConfig {#RestAPIConfig4}

Field | Description
--- | ---
enabled | **bool**<br>Is REST API enabled for this cluster. 


### Access {#Access4}

Field | Description
--- | ---
data_transfer | **bool**<br>Allow access for DataTransfer. 


### Resources {#Resources4}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory, etc.). All available presets are listed in the [documentation](/docs/managed-kafka/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage available to a host, in bytes. Must be greater than 2 * partition segment size in bytes * partitions count, so each partition can have one active segment file and one closed segment file that can be deleted. 
disk_type_id | **string**<br>Type of the storage environment for the host. 


### KafkaConfig2_8 {#KafkaConfig2_84}

Field | Description
--- | ---
compression_type | enum **CompressionType**<br>Cluster topics compression type. <ul><li>`COMPRESSION_TYPE_UNCOMPRESSED`: no codec (uncompressed).</li><li>`COMPRESSION_TYPE_ZSTD`: Zstandard codec.</li><li>`COMPRESSION_TYPE_LZ4`: LZ4 codec.</li><li>`COMPRESSION_TYPE_SNAPPY`: Snappy codec.</li><li>`COMPRESSION_TYPE_GZIP`: GZip codec.</li><li>`COMPRESSION_TYPE_PRODUCER`: the codec to use is set by a producer (can be any of `ZSTD`, `LZ4`, `GZIP` or `SNAPPY` codecs).</li></ul>
log_flush_interval_messages | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of messages accumulated on a log partition before messages are flushed to disk. <br>This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig2_8.flush_messages](#TopicConfig2_81) setting. 
log_flush_interval_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time (in milliseconds) that a message in any topic is kept in memory before flushed to disk. If not set, the value of `log_flush_scheduler_interval_ms` is used. <br>This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig2_8.flush_ms](#TopicConfig2_81) setting. 
log_flush_scheduler_interval_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The frequency of checks (in milliseconds) for any logs that need to be flushed to disk. This check is done by the log flusher. 
log_retention_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Partition size limit; Kafka will discard old log segments to free up space if `delete` [TopicConfig2_8.cleanup_policy](#TopicConfig2_81) is in effect. This setting is helpful if you need to control the size of a log due to limited disk space. <br>This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig2_8.retention_bytes](#TopicConfig2_81) setting. 
log_retention_hours | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of hours to keep a log segment file before deleting it. 
log_retention_minutes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of minutes to keep a log segment file before deleting it. <br>If not set, the value of `log_retention_hours` is used. 
log_retention_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of milliseconds to keep a log segment file before deleting it. <br>If not set, the value of `log_retention_minutes` is used. <br>This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig2_8.retention_ms](#TopicConfig2_81) setting. 
log_segment_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size of a single log file. <br>This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig2_8.segment_bytes](#TopicConfig2_81) setting. 
log_preallocate | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Should pre allocate file when create new segment? <br>This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig2_8.preallocate](#TopicConfig2_81) setting. 
socket_send_buffer_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The SO_SNDBUF buffer of the socket server sockets. If the value is -1, the OS default will be used. 
socket_receive_buffer_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The SO_RCVBUF buffer of the socket server sockets. If the value is -1, the OS default will be used. 
auto_create_topics_enable | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Enable auto creation of topic on the server 
num_partitions | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Default number of partitions per topic on the whole cluster 
default_replication_factor | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Default replication factor of the topic on the whole cluster 
message_max_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The largest record batch size allowed by Kafka. Default value: 1048588. 
replica_fetch_max_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of bytes of messages to attempt to fetch for each partition. Default value: 1048576. 
ssl_cipher_suites[] | **string**<br>A list of cipher suites. 
offsets_retention_minutes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Offset storage time after a consumer group loses all its consumers. Default: 10080. 
sasl_enabled_mechanisms[] | enum **SaslMechanism**<br>The list of SASL mechanisms enabled in the Kafka server. Default: [SCRAM_SHA_512]. 


### KafkaConfig3 {#KafkaConfig34}

Field | Description
--- | ---
compression_type | enum **CompressionType**<br>Cluster topics compression type. <ul><li>`COMPRESSION_TYPE_UNCOMPRESSED`: no codec (uncompressed).</li><li>`COMPRESSION_TYPE_ZSTD`: Zstandard codec.</li><li>`COMPRESSION_TYPE_LZ4`: LZ4 codec.</li><li>`COMPRESSION_TYPE_SNAPPY`: Snappy codec.</li><li>`COMPRESSION_TYPE_GZIP`: GZip codec.</li><li>`COMPRESSION_TYPE_PRODUCER`: the codec to use is set by a producer (can be any of `ZSTD`, `LZ4`, `GZIP` or `SNAPPY` codecs).</li></ul>
log_flush_interval_messages | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of messages accumulated on a log partition before messages are flushed to disk. <br>This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig3.flush_messages](#TopicConfig31) setting. 
log_flush_interval_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time (in milliseconds) that a message in any topic is kept in memory before flushed to disk. If not set, the value of `log_flush_scheduler_interval_ms` is used. <br>This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig3.flush_ms](#TopicConfig31) setting. 
log_flush_scheduler_interval_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The frequency of checks (in milliseconds) for any logs that need to be flushed to disk. This check is done by the log flusher. 
log_retention_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Partition size limit; Kafka will discard old log segments to free up space if `delete` [TopicConfig3.cleanup_policy](#TopicConfig31) is in effect. This setting is helpful if you need to control the size of a log due to limited disk space. <br>This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig3.retention_bytes](#TopicConfig31) setting. 
log_retention_hours | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of hours to keep a log segment file before deleting it. 
log_retention_minutes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of minutes to keep a log segment file before deleting it. <br>If not set, the value of `log_retention_hours` is used. 
log_retention_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of milliseconds to keep a log segment file before deleting it. <br>If not set, the value of `log_retention_minutes` is used. <br>This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig3.retention_ms](#TopicConfig31) setting. 
log_segment_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size of a single log file. <br>This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig3.segment_bytes](#TopicConfig31) setting. 
log_preallocate | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Should pre allocate file when create new segment? <br>This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig3.preallocate](#TopicConfig31) setting. 
socket_send_buffer_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The SO_SNDBUF buffer of the socket server sockets. If the value is -1, the OS default will be used. 
socket_receive_buffer_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The SO_RCVBUF buffer of the socket server sockets. If the value is -1, the OS default will be used. 
auto_create_topics_enable | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Enable auto creation of topic on the server 
num_partitions | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Default number of partitions per topic on the whole cluster 
default_replication_factor | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Default replication factor of the topic on the whole cluster 
message_max_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The largest record batch size allowed by Kafka. Default value: 1048588. 
replica_fetch_max_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of bytes of messages to attempt to fetch for each partition. Default value: 1048576. 
ssl_cipher_suites[] | **string**<br>A list of cipher suites. 
offsets_retention_minutes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Offset storage time after a consumer group loses all its consumers. Default: 10080. 
sasl_enabled_mechanisms[] | enum **SaslMechanism**<br>The list of SASL mechanisms enabled in the Kafka server. Default: [SCRAM_SHA_512]. 


### MaintenanceWindow {#MaintenanceWindow4}

Field | Description
--- | ---
policy | **oneof:** `anytime` or `weekly_maintenance_window`<br>
&nbsp;&nbsp;anytime | **[AnytimeMaintenanceWindow](#AnytimeMaintenanceWindow4)**<br> 
&nbsp;&nbsp;weekly_maintenance_window | **[WeeklyMaintenanceWindow](#WeeklyMaintenanceWindow4)**<br> 


### AnytimeMaintenanceWindow {#AnytimeMaintenanceWindow4}

Empty.

### WeeklyMaintenanceWindow {#WeeklyMaintenanceWindow4}

Field | Description
--- | ---
day | enum **WeekDay**<br> 
hour | **int64**<br>Hour of the day in UTC. Acceptable values are 1 to 24, inclusive.


### MaintenanceOperation {#MaintenanceOperation4}

Field | Description
--- | ---
info | **string**<br> The maximum string length in characters is 256.
delayed_until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 


## Start {#Start}

Starts the specified Apache Kafka® cluster.

**rpc Start ([StartClusterRequest](#StartClusterRequest)) returns ([operation.Operation](#Operation4))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[StartClusterMetadata](#StartClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster5)<br>

### StartClusterRequest {#StartClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Apache Kafka® cluster to start. <br>To get the Apache Kafka® cluster ID, make a [ClusterService.List](#List) request. The maximum string length in characters is 50.


### Operation {#Operation4}

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
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Cluster](#Cluster5)>**<br>if operation finished successfully. 


### StartClusterMetadata {#StartClusterMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>ID of the Apache Kafka® cluster. 


### Cluster {#Cluster5}

Field | Description
--- | ---
id | **string**<br>ID of the Apache Kafka® cluster. This ID is assigned at creation time. 
folder_id | **string**<br>ID of the folder that the Apache Kafka® cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the Apache Kafka® cluster. The name must be unique within the folder. 1-63 characters long. Value must match the regular expression `[a-zA-Z0-9_-]*`. 
description | **string**<br>Description of the Apache Kafka® cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the Apache Kafka® cluster as `key:value` pairs. A maximum of 64 labels per resource is allowed. 
environment | enum **Environment**<br>Deployment environment of the Apache Kafka® cluster. <ul><li>`PRODUCTION`: stable environment with a conservative update policy when only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: environment with a more aggressive update policy when new versions are rolled out irrespective of backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring5)**<br>Description of monitoring systems relevant to the Apache Kafka® cluster. 
config | **[ConfigSpec](#ConfigSpec5)**<br>Configuration of the Apache Kafka® cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: state of the cluster is unknown ([Host.health](#Host) of all hosts in the cluster is `UNKNOWN`).</li><li>`ALIVE`: cluster is alive and well ([Host.health](#Host) of all hosts in the cluster is `ALIVE`).</li><li>`DEAD`: cluster is inoperable ([Host.health](#Host) of all hosts in the cluster is `DEAD`).</li><li>`DEGRADED`: cluster is in degraded state ([Host.health](#Host) of at least one of the hosts in the cluster is not `ALIVE`).</li></ul>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: cluster state is unknown.</li><li>`CREATING`: cluster is being created.</li><li>`RUNNING`: cluster is running normally.</li><li>`ERROR`: cluster encountered a problem and cannot operate.</li><li>`UPDATING`: cluster is being updated.</li><li>`STOPPING`: cluster is stopping.</li><li>`STOPPED`: cluster stopped.</li><li>`STARTING`: cluster is starting.</li></ul>
security_group_ids[] | **string**<br>User security groups 
host_group_ids[] | **string**<br>Host groups hosting VMs of the cluster. 
deletion_protection | **bool**<br>Deletion Protection inhibits deletion of the cluster 
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow5)**<br>Window of maintenance operations. 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation5)**<br>Scheduled maintenance operation. 


### Monitoring {#Monitoring5}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the Apache Kafka® cluster. 


### ConfigSpec {#ConfigSpec5}

Field | Description
--- | ---
version | **string**<br>Version of Apache Kafka® used in the cluster. Possible values: `2.1`, `2.6`. 
kafka | **[Kafka](#Kafka5)**<br>Configuration and resource allocation for Kafka brokers. 
zookeeper | **[Zookeeper](#Zookeeper5)**<br>Configuration and resource allocation for ZooKeeper hosts. 
zone_id[] | **string**<br>IDs of availability zones where Kafka brokers reside. 
brokers_count | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of Kafka brokers deployed in each availability zone. 
assign_public_ip | **bool**<br>The flag that defines whether a public IP address is assigned to the cluster. If the value is `true`, then Apache Kafka® cluster is available on the Internet via it's public IP address. 
unmanaged_topics | **bool**<br>Allows to manage topics via AdminAPI Deprecated. Feature enabled permanently. 
schema_registry | **bool**<br>Enables managed schema registry on cluster 
access | **[Access](#Access5)**<br>Access policy for external services. 
rest_api_config | **[RestAPIConfig](#RestAPIConfig5)**<br>Configuration of REST API. 


### Kafka {#Kafka5}

Field | Description
--- | ---
resources | **[Resources](#Resources5)**<br>Resources allocated to Kafka brokers. 
kafka_config | **oneof:** `kafka_config_2_8` or `kafka_config_3`<br>Kafka broker configuration.
&nbsp;&nbsp;kafka_config_2_8 | **[KafkaConfig2_8](#KafkaConfig2_85)**<br>Kafka broker configuration. 
&nbsp;&nbsp;kafka_config_3 | **[KafkaConfig3](#KafkaConfig35)**<br>Kafka broker configuration. 


### Zookeeper {#Zookeeper5}

Field | Description
--- | ---
resources | **[Resources](#Resources5)**<br>Resources allocated to ZooKeeper hosts. 


### RestAPIConfig {#RestAPIConfig5}

Field | Description
--- | ---
enabled | **bool**<br>Is REST API enabled for this cluster. 


### Access {#Access5}

Field | Description
--- | ---
data_transfer | **bool**<br>Allow access for DataTransfer. 


### Resources {#Resources5}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory, etc.). All available presets are listed in the [documentation](/docs/managed-kafka/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage available to a host, in bytes. Must be greater than 2 * partition segment size in bytes * partitions count, so each partition can have one active segment file and one closed segment file that can be deleted. 
disk_type_id | **string**<br>Type of the storage environment for the host. 


### KafkaConfig2_8 {#KafkaConfig2_85}

Field | Description
--- | ---
compression_type | enum **CompressionType**<br>Cluster topics compression type. <ul><li>`COMPRESSION_TYPE_UNCOMPRESSED`: no codec (uncompressed).</li><li>`COMPRESSION_TYPE_ZSTD`: Zstandard codec.</li><li>`COMPRESSION_TYPE_LZ4`: LZ4 codec.</li><li>`COMPRESSION_TYPE_SNAPPY`: Snappy codec.</li><li>`COMPRESSION_TYPE_GZIP`: GZip codec.</li><li>`COMPRESSION_TYPE_PRODUCER`: the codec to use is set by a producer (can be any of `ZSTD`, `LZ4`, `GZIP` or `SNAPPY` codecs).</li></ul>
log_flush_interval_messages | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of messages accumulated on a log partition before messages are flushed to disk. <br>This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig2_8.flush_messages](#TopicConfig2_81) setting. 
log_flush_interval_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time (in milliseconds) that a message in any topic is kept in memory before flushed to disk. If not set, the value of `log_flush_scheduler_interval_ms` is used. <br>This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig2_8.flush_ms](#TopicConfig2_81) setting. 
log_flush_scheduler_interval_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The frequency of checks (in milliseconds) for any logs that need to be flushed to disk. This check is done by the log flusher. 
log_retention_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Partition size limit; Kafka will discard old log segments to free up space if `delete` [TopicConfig2_8.cleanup_policy](#TopicConfig2_81) is in effect. This setting is helpful if you need to control the size of a log due to limited disk space. <br>This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig2_8.retention_bytes](#TopicConfig2_81) setting. 
log_retention_hours | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of hours to keep a log segment file before deleting it. 
log_retention_minutes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of minutes to keep a log segment file before deleting it. <br>If not set, the value of `log_retention_hours` is used. 
log_retention_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of milliseconds to keep a log segment file before deleting it. <br>If not set, the value of `log_retention_minutes` is used. <br>This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig2_8.retention_ms](#TopicConfig2_81) setting. 
log_segment_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size of a single log file. <br>This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig2_8.segment_bytes](#TopicConfig2_81) setting. 
log_preallocate | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Should pre allocate file when create new segment? <br>This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig2_8.preallocate](#TopicConfig2_81) setting. 
socket_send_buffer_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The SO_SNDBUF buffer of the socket server sockets. If the value is -1, the OS default will be used. 
socket_receive_buffer_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The SO_RCVBUF buffer of the socket server sockets. If the value is -1, the OS default will be used. 
auto_create_topics_enable | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Enable auto creation of topic on the server 
num_partitions | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Default number of partitions per topic on the whole cluster 
default_replication_factor | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Default replication factor of the topic on the whole cluster 
message_max_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The largest record batch size allowed by Kafka. Default value: 1048588. 
replica_fetch_max_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of bytes of messages to attempt to fetch for each partition. Default value: 1048576. 
ssl_cipher_suites[] | **string**<br>A list of cipher suites. 
offsets_retention_minutes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Offset storage time after a consumer group loses all its consumers. Default: 10080. 
sasl_enabled_mechanisms[] | enum **SaslMechanism**<br>The list of SASL mechanisms enabled in the Kafka server. Default: [SCRAM_SHA_512]. 


### KafkaConfig3 {#KafkaConfig35}

Field | Description
--- | ---
compression_type | enum **CompressionType**<br>Cluster topics compression type. <ul><li>`COMPRESSION_TYPE_UNCOMPRESSED`: no codec (uncompressed).</li><li>`COMPRESSION_TYPE_ZSTD`: Zstandard codec.</li><li>`COMPRESSION_TYPE_LZ4`: LZ4 codec.</li><li>`COMPRESSION_TYPE_SNAPPY`: Snappy codec.</li><li>`COMPRESSION_TYPE_GZIP`: GZip codec.</li><li>`COMPRESSION_TYPE_PRODUCER`: the codec to use is set by a producer (can be any of `ZSTD`, `LZ4`, `GZIP` or `SNAPPY` codecs).</li></ul>
log_flush_interval_messages | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of messages accumulated on a log partition before messages are flushed to disk. <br>This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig3.flush_messages](#TopicConfig31) setting. 
log_flush_interval_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time (in milliseconds) that a message in any topic is kept in memory before flushed to disk. If not set, the value of `log_flush_scheduler_interval_ms` is used. <br>This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig3.flush_ms](#TopicConfig31) setting. 
log_flush_scheduler_interval_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The frequency of checks (in milliseconds) for any logs that need to be flushed to disk. This check is done by the log flusher. 
log_retention_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Partition size limit; Kafka will discard old log segments to free up space if `delete` [TopicConfig3.cleanup_policy](#TopicConfig31) is in effect. This setting is helpful if you need to control the size of a log due to limited disk space. <br>This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig3.retention_bytes](#TopicConfig31) setting. 
log_retention_hours | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of hours to keep a log segment file before deleting it. 
log_retention_minutes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of minutes to keep a log segment file before deleting it. <br>If not set, the value of `log_retention_hours` is used. 
log_retention_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of milliseconds to keep a log segment file before deleting it. <br>If not set, the value of `log_retention_minutes` is used. <br>This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig3.retention_ms](#TopicConfig31) setting. 
log_segment_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size of a single log file. <br>This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig3.segment_bytes](#TopicConfig31) setting. 
log_preallocate | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Should pre allocate file when create new segment? <br>This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig3.preallocate](#TopicConfig31) setting. 
socket_send_buffer_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The SO_SNDBUF buffer of the socket server sockets. If the value is -1, the OS default will be used. 
socket_receive_buffer_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The SO_RCVBUF buffer of the socket server sockets. If the value is -1, the OS default will be used. 
auto_create_topics_enable | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Enable auto creation of topic on the server 
num_partitions | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Default number of partitions per topic on the whole cluster 
default_replication_factor | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Default replication factor of the topic on the whole cluster 
message_max_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The largest record batch size allowed by Kafka. Default value: 1048588. 
replica_fetch_max_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of bytes of messages to attempt to fetch for each partition. Default value: 1048576. 
ssl_cipher_suites[] | **string**<br>A list of cipher suites. 
offsets_retention_minutes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Offset storage time after a consumer group loses all its consumers. Default: 10080. 
sasl_enabled_mechanisms[] | enum **SaslMechanism**<br>The list of SASL mechanisms enabled in the Kafka server. Default: [SCRAM_SHA_512]. 


### MaintenanceWindow {#MaintenanceWindow5}

Field | Description
--- | ---
policy | **oneof:** `anytime` or `weekly_maintenance_window`<br>
&nbsp;&nbsp;anytime | **[AnytimeMaintenanceWindow](#AnytimeMaintenanceWindow5)**<br> 
&nbsp;&nbsp;weekly_maintenance_window | **[WeeklyMaintenanceWindow](#WeeklyMaintenanceWindow5)**<br> 


### AnytimeMaintenanceWindow {#AnytimeMaintenanceWindow5}

Empty.

### WeeklyMaintenanceWindow {#WeeklyMaintenanceWindow5}

Field | Description
--- | ---
day | enum **WeekDay**<br> 
hour | **int64**<br>Hour of the day in UTC. Acceptable values are 1 to 24, inclusive.


### MaintenanceOperation {#MaintenanceOperation5}

Field | Description
--- | ---
info | **string**<br> The maximum string length in characters is 256.
delayed_until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 


## Stop {#Stop}

Stops the specified Apache Kafka® cluster.

**rpc Stop ([StopClusterRequest](#StopClusterRequest)) returns ([operation.Operation](#Operation5))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[StopClusterMetadata](#StopClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster6)<br>

### StopClusterRequest {#StopClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Apache Kafka® cluster to stop. <br>To get the Apache Kafka® cluster ID, make a [ClusterService.List](#List) request. The maximum string length in characters is 50.


### Operation {#Operation5}

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
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Cluster](#Cluster6)>**<br>if operation finished successfully. 


### StopClusterMetadata {#StopClusterMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>ID of the Apache Kafka® cluster. 


### Cluster {#Cluster6}

Field | Description
--- | ---
id | **string**<br>ID of the Apache Kafka® cluster. This ID is assigned at creation time. 
folder_id | **string**<br>ID of the folder that the Apache Kafka® cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the Apache Kafka® cluster. The name must be unique within the folder. 1-63 characters long. Value must match the regular expression `[a-zA-Z0-9_-]*`. 
description | **string**<br>Description of the Apache Kafka® cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the Apache Kafka® cluster as `key:value` pairs. A maximum of 64 labels per resource is allowed. 
environment | enum **Environment**<br>Deployment environment of the Apache Kafka® cluster. <ul><li>`PRODUCTION`: stable environment with a conservative update policy when only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: environment with a more aggressive update policy when new versions are rolled out irrespective of backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring6)**<br>Description of monitoring systems relevant to the Apache Kafka® cluster. 
config | **[ConfigSpec](#ConfigSpec6)**<br>Configuration of the Apache Kafka® cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: state of the cluster is unknown ([Host.health](#Host) of all hosts in the cluster is `UNKNOWN`).</li><li>`ALIVE`: cluster is alive and well ([Host.health](#Host) of all hosts in the cluster is `ALIVE`).</li><li>`DEAD`: cluster is inoperable ([Host.health](#Host) of all hosts in the cluster is `DEAD`).</li><li>`DEGRADED`: cluster is in degraded state ([Host.health](#Host) of at least one of the hosts in the cluster is not `ALIVE`).</li></ul>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: cluster state is unknown.</li><li>`CREATING`: cluster is being created.</li><li>`RUNNING`: cluster is running normally.</li><li>`ERROR`: cluster encountered a problem and cannot operate.</li><li>`UPDATING`: cluster is being updated.</li><li>`STOPPING`: cluster is stopping.</li><li>`STOPPED`: cluster stopped.</li><li>`STARTING`: cluster is starting.</li></ul>
security_group_ids[] | **string**<br>User security groups 
host_group_ids[] | **string**<br>Host groups hosting VMs of the cluster. 
deletion_protection | **bool**<br>Deletion Protection inhibits deletion of the cluster 
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow6)**<br>Window of maintenance operations. 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation6)**<br>Scheduled maintenance operation. 


### Monitoring {#Monitoring6}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the Apache Kafka® cluster. 


### ConfigSpec {#ConfigSpec6}

Field | Description
--- | ---
version | **string**<br>Version of Apache Kafka® used in the cluster. Possible values: `2.1`, `2.6`. 
kafka | **[Kafka](#Kafka6)**<br>Configuration and resource allocation for Kafka brokers. 
zookeeper | **[Zookeeper](#Zookeeper6)**<br>Configuration and resource allocation for ZooKeeper hosts. 
zone_id[] | **string**<br>IDs of availability zones where Kafka brokers reside. 
brokers_count | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of Kafka brokers deployed in each availability zone. 
assign_public_ip | **bool**<br>The flag that defines whether a public IP address is assigned to the cluster. If the value is `true`, then Apache Kafka® cluster is available on the Internet via it's public IP address. 
unmanaged_topics | **bool**<br>Allows to manage topics via AdminAPI Deprecated. Feature enabled permanently. 
schema_registry | **bool**<br>Enables managed schema registry on cluster 
access | **[Access](#Access6)**<br>Access policy for external services. 
rest_api_config | **[RestAPIConfig](#RestAPIConfig6)**<br>Configuration of REST API. 


### Kafka {#Kafka6}

Field | Description
--- | ---
resources | **[Resources](#Resources6)**<br>Resources allocated to Kafka brokers. 
kafka_config | **oneof:** `kafka_config_2_8` or `kafka_config_3`<br>Kafka broker configuration.
&nbsp;&nbsp;kafka_config_2_8 | **[KafkaConfig2_8](#KafkaConfig2_86)**<br>Kafka broker configuration. 
&nbsp;&nbsp;kafka_config_3 | **[KafkaConfig3](#KafkaConfig36)**<br>Kafka broker configuration. 


### Zookeeper {#Zookeeper6}

Field | Description
--- | ---
resources | **[Resources](#Resources6)**<br>Resources allocated to ZooKeeper hosts. 


### RestAPIConfig {#RestAPIConfig6}

Field | Description
--- | ---
enabled | **bool**<br>Is REST API enabled for this cluster. 


### Access {#Access6}

Field | Description
--- | ---
data_transfer | **bool**<br>Allow access for DataTransfer. 


### Resources {#Resources6}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory, etc.). All available presets are listed in the [documentation](/docs/managed-kafka/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage available to a host, in bytes. Must be greater than 2 * partition segment size in bytes * partitions count, so each partition can have one active segment file and one closed segment file that can be deleted. 
disk_type_id | **string**<br>Type of the storage environment for the host. 


### KafkaConfig2_8 {#KafkaConfig2_86}

Field | Description
--- | ---
compression_type | enum **CompressionType**<br>Cluster topics compression type. <ul><li>`COMPRESSION_TYPE_UNCOMPRESSED`: no codec (uncompressed).</li><li>`COMPRESSION_TYPE_ZSTD`: Zstandard codec.</li><li>`COMPRESSION_TYPE_LZ4`: LZ4 codec.</li><li>`COMPRESSION_TYPE_SNAPPY`: Snappy codec.</li><li>`COMPRESSION_TYPE_GZIP`: GZip codec.</li><li>`COMPRESSION_TYPE_PRODUCER`: the codec to use is set by a producer (can be any of `ZSTD`, `LZ4`, `GZIP` or `SNAPPY` codecs).</li></ul>
log_flush_interval_messages | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of messages accumulated on a log partition before messages are flushed to disk. <br>This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig2_8.flush_messages](#TopicConfig2_81) setting. 
log_flush_interval_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time (in milliseconds) that a message in any topic is kept in memory before flushed to disk. If not set, the value of `log_flush_scheduler_interval_ms` is used. <br>This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig2_8.flush_ms](#TopicConfig2_81) setting. 
log_flush_scheduler_interval_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The frequency of checks (in milliseconds) for any logs that need to be flushed to disk. This check is done by the log flusher. 
log_retention_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Partition size limit; Kafka will discard old log segments to free up space if `delete` [TopicConfig2_8.cleanup_policy](#TopicConfig2_81) is in effect. This setting is helpful if you need to control the size of a log due to limited disk space. <br>This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig2_8.retention_bytes](#TopicConfig2_81) setting. 
log_retention_hours | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of hours to keep a log segment file before deleting it. 
log_retention_minutes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of minutes to keep a log segment file before deleting it. <br>If not set, the value of `log_retention_hours` is used. 
log_retention_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of milliseconds to keep a log segment file before deleting it. <br>If not set, the value of `log_retention_minutes` is used. <br>This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig2_8.retention_ms](#TopicConfig2_81) setting. 
log_segment_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size of a single log file. <br>This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig2_8.segment_bytes](#TopicConfig2_81) setting. 
log_preallocate | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Should pre allocate file when create new segment? <br>This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig2_8.preallocate](#TopicConfig2_81) setting. 
socket_send_buffer_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The SO_SNDBUF buffer of the socket server sockets. If the value is -1, the OS default will be used. 
socket_receive_buffer_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The SO_RCVBUF buffer of the socket server sockets. If the value is -1, the OS default will be used. 
auto_create_topics_enable | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Enable auto creation of topic on the server 
num_partitions | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Default number of partitions per topic on the whole cluster 
default_replication_factor | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Default replication factor of the topic on the whole cluster 
message_max_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The largest record batch size allowed by Kafka. Default value: 1048588. 
replica_fetch_max_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of bytes of messages to attempt to fetch for each partition. Default value: 1048576. 
ssl_cipher_suites[] | **string**<br>A list of cipher suites. 
offsets_retention_minutes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Offset storage time after a consumer group loses all its consumers. Default: 10080. 
sasl_enabled_mechanisms[] | enum **SaslMechanism**<br>The list of SASL mechanisms enabled in the Kafka server. Default: [SCRAM_SHA_512]. 


### KafkaConfig3 {#KafkaConfig36}

Field | Description
--- | ---
compression_type | enum **CompressionType**<br>Cluster topics compression type. <ul><li>`COMPRESSION_TYPE_UNCOMPRESSED`: no codec (uncompressed).</li><li>`COMPRESSION_TYPE_ZSTD`: Zstandard codec.</li><li>`COMPRESSION_TYPE_LZ4`: LZ4 codec.</li><li>`COMPRESSION_TYPE_SNAPPY`: Snappy codec.</li><li>`COMPRESSION_TYPE_GZIP`: GZip codec.</li><li>`COMPRESSION_TYPE_PRODUCER`: the codec to use is set by a producer (can be any of `ZSTD`, `LZ4`, `GZIP` or `SNAPPY` codecs).</li></ul>
log_flush_interval_messages | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of messages accumulated on a log partition before messages are flushed to disk. <br>This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig3.flush_messages](#TopicConfig31) setting. 
log_flush_interval_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time (in milliseconds) that a message in any topic is kept in memory before flushed to disk. If not set, the value of `log_flush_scheduler_interval_ms` is used. <br>This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig3.flush_ms](#TopicConfig31) setting. 
log_flush_scheduler_interval_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The frequency of checks (in milliseconds) for any logs that need to be flushed to disk. This check is done by the log flusher. 
log_retention_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Partition size limit; Kafka will discard old log segments to free up space if `delete` [TopicConfig3.cleanup_policy](#TopicConfig31) is in effect. This setting is helpful if you need to control the size of a log due to limited disk space. <br>This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig3.retention_bytes](#TopicConfig31) setting. 
log_retention_hours | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of hours to keep a log segment file before deleting it. 
log_retention_minutes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of minutes to keep a log segment file before deleting it. <br>If not set, the value of `log_retention_hours` is used. 
log_retention_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of milliseconds to keep a log segment file before deleting it. <br>If not set, the value of `log_retention_minutes` is used. <br>This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig3.retention_ms](#TopicConfig31) setting. 
log_segment_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size of a single log file. <br>This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig3.segment_bytes](#TopicConfig31) setting. 
log_preallocate | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Should pre allocate file when create new segment? <br>This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig3.preallocate](#TopicConfig31) setting. 
socket_send_buffer_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The SO_SNDBUF buffer of the socket server sockets. If the value is -1, the OS default will be used. 
socket_receive_buffer_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The SO_RCVBUF buffer of the socket server sockets. If the value is -1, the OS default will be used. 
auto_create_topics_enable | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Enable auto creation of topic on the server 
num_partitions | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Default number of partitions per topic on the whole cluster 
default_replication_factor | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Default replication factor of the topic on the whole cluster 
message_max_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The largest record batch size allowed by Kafka. Default value: 1048588. 
replica_fetch_max_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of bytes of messages to attempt to fetch for each partition. Default value: 1048576. 
ssl_cipher_suites[] | **string**<br>A list of cipher suites. 
offsets_retention_minutes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Offset storage time after a consumer group loses all its consumers. Default: 10080. 
sasl_enabled_mechanisms[] | enum **SaslMechanism**<br>The list of SASL mechanisms enabled in the Kafka server. Default: [SCRAM_SHA_512]. 


### MaintenanceWindow {#MaintenanceWindow6}

Field | Description
--- | ---
policy | **oneof:** `anytime` or `weekly_maintenance_window`<br>
&nbsp;&nbsp;anytime | **[AnytimeMaintenanceWindow](#AnytimeMaintenanceWindow6)**<br> 
&nbsp;&nbsp;weekly_maintenance_window | **[WeeklyMaintenanceWindow](#WeeklyMaintenanceWindow6)**<br> 


### AnytimeMaintenanceWindow {#AnytimeMaintenanceWindow6}

Empty.

### WeeklyMaintenanceWindow {#WeeklyMaintenanceWindow6}

Field | Description
--- | ---
day | enum **WeekDay**<br> 
hour | **int64**<br>Hour of the day in UTC. Acceptable values are 1 to 24, inclusive.


### MaintenanceOperation {#MaintenanceOperation6}

Field | Description
--- | ---
info | **string**<br> The maximum string length in characters is 256.
delayed_until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 


## RescheduleMaintenance {#RescheduleMaintenance}

Reschedule planned maintenance operation.

**rpc RescheduleMaintenance ([RescheduleMaintenanceRequest](#RescheduleMaintenanceRequest)) returns ([operation.Operation](#Operation6))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[RescheduleMaintenanceMetadata](#RescheduleMaintenanceMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster7)<br>

### RescheduleMaintenanceRequest {#RescheduleMaintenanceRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Kafka cluster to reschedule the maintenance operation for. The maximum string length in characters is 50.
reschedule_type | enum **RescheduleType**<br>Required. The type of reschedule request. <ul><li>`IMMEDIATE`: Start the maintenance operation immediately.</li><li>`NEXT_AVAILABLE_WINDOW`: Start the maintenance operation within the next available maintenance window.</li><li>`SPECIFIC_TIME`: Start the maintenance operation at the specific time.</li></ul>
delayed_until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time until which this maintenance operation should be delayed. The value should be ahead of the first time when the maintenance operation has been scheduled for no more than two weeks. The value can also point to the past moment of time if `reschedule_type.IMMEDIATE` reschedule type is chosen. 


### Operation {#Operation6}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[RescheduleMaintenanceMetadata](#RescheduleMaintenanceMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Cluster](#Cluster7)>**<br>if operation finished successfully. 


### RescheduleMaintenanceMetadata {#RescheduleMaintenanceMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>ID of the Kafka cluster. 
delayed_until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time until which this maintenance operation is to be delayed. 


### Cluster {#Cluster7}

Field | Description
--- | ---
id | **string**<br>ID of the Apache Kafka® cluster. This ID is assigned at creation time. 
folder_id | **string**<br>ID of the folder that the Apache Kafka® cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the Apache Kafka® cluster. The name must be unique within the folder. 1-63 characters long. Value must match the regular expression `[a-zA-Z0-9_-]*`. 
description | **string**<br>Description of the Apache Kafka® cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the Apache Kafka® cluster as `key:value` pairs. A maximum of 64 labels per resource is allowed. 
environment | enum **Environment**<br>Deployment environment of the Apache Kafka® cluster. <ul><li>`PRODUCTION`: stable environment with a conservative update policy when only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: environment with a more aggressive update policy when new versions are rolled out irrespective of backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring7)**<br>Description of monitoring systems relevant to the Apache Kafka® cluster. 
config | **[ConfigSpec](#ConfigSpec7)**<br>Configuration of the Apache Kafka® cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: state of the cluster is unknown ([Host.health](#Host) of all hosts in the cluster is `UNKNOWN`).</li><li>`ALIVE`: cluster is alive and well ([Host.health](#Host) of all hosts in the cluster is `ALIVE`).</li><li>`DEAD`: cluster is inoperable ([Host.health](#Host) of all hosts in the cluster is `DEAD`).</li><li>`DEGRADED`: cluster is in degraded state ([Host.health](#Host) of at least one of the hosts in the cluster is not `ALIVE`).</li></ul>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: cluster state is unknown.</li><li>`CREATING`: cluster is being created.</li><li>`RUNNING`: cluster is running normally.</li><li>`ERROR`: cluster encountered a problem and cannot operate.</li><li>`UPDATING`: cluster is being updated.</li><li>`STOPPING`: cluster is stopping.</li><li>`STOPPED`: cluster stopped.</li><li>`STARTING`: cluster is starting.</li></ul>
security_group_ids[] | **string**<br>User security groups 
host_group_ids[] | **string**<br>Host groups hosting VMs of the cluster. 
deletion_protection | **bool**<br>Deletion Protection inhibits deletion of the cluster 
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow7)**<br>Window of maintenance operations. 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation7)**<br>Scheduled maintenance operation. 


### Monitoring {#Monitoring7}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the Apache Kafka® cluster. 


### ConfigSpec {#ConfigSpec7}

Field | Description
--- | ---
version | **string**<br>Version of Apache Kafka® used in the cluster. Possible values: `2.1`, `2.6`. 
kafka | **[Kafka](#Kafka7)**<br>Configuration and resource allocation for Kafka brokers. 
zookeeper | **[Zookeeper](#Zookeeper7)**<br>Configuration and resource allocation for ZooKeeper hosts. 
zone_id[] | **string**<br>IDs of availability zones where Kafka brokers reside. 
brokers_count | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of Kafka brokers deployed in each availability zone. 
assign_public_ip | **bool**<br>The flag that defines whether a public IP address is assigned to the cluster. If the value is `true`, then Apache Kafka® cluster is available on the Internet via it's public IP address. 
unmanaged_topics | **bool**<br>Allows to manage topics via AdminAPI Deprecated. Feature enabled permanently. 
schema_registry | **bool**<br>Enables managed schema registry on cluster 
access | **[Access](#Access7)**<br>Access policy for external services. 
rest_api_config | **[RestAPIConfig](#RestAPIConfig7)**<br>Configuration of REST API. 


### Kafka {#Kafka7}

Field | Description
--- | ---
resources | **[Resources](#Resources7)**<br>Resources allocated to Kafka brokers. 
kafka_config | **oneof:** `kafka_config_2_8` or `kafka_config_3`<br>Kafka broker configuration.
&nbsp;&nbsp;kafka_config_2_8 | **[KafkaConfig2_8](#KafkaConfig2_87)**<br>Kafka broker configuration. 
&nbsp;&nbsp;kafka_config_3 | **[KafkaConfig3](#KafkaConfig37)**<br>Kafka broker configuration. 


### Zookeeper {#Zookeeper7}

Field | Description
--- | ---
resources | **[Resources](#Resources7)**<br>Resources allocated to ZooKeeper hosts. 


### RestAPIConfig {#RestAPIConfig7}

Field | Description
--- | ---
enabled | **bool**<br>Is REST API enabled for this cluster. 


### Access {#Access7}

Field | Description
--- | ---
data_transfer | **bool**<br>Allow access for DataTransfer. 


### Resources {#Resources7}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory, etc.). All available presets are listed in the [documentation](/docs/managed-kafka/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage available to a host, in bytes. Must be greater than 2 * partition segment size in bytes * partitions count, so each partition can have one active segment file and one closed segment file that can be deleted. 
disk_type_id | **string**<br>Type of the storage environment for the host. 


### KafkaConfig2_8 {#KafkaConfig2_87}

Field | Description
--- | ---
compression_type | enum **CompressionType**<br>Cluster topics compression type. <ul><li>`COMPRESSION_TYPE_UNCOMPRESSED`: no codec (uncompressed).</li><li>`COMPRESSION_TYPE_ZSTD`: Zstandard codec.</li><li>`COMPRESSION_TYPE_LZ4`: LZ4 codec.</li><li>`COMPRESSION_TYPE_SNAPPY`: Snappy codec.</li><li>`COMPRESSION_TYPE_GZIP`: GZip codec.</li><li>`COMPRESSION_TYPE_PRODUCER`: the codec to use is set by a producer (can be any of `ZSTD`, `LZ4`, `GZIP` or `SNAPPY` codecs).</li></ul>
log_flush_interval_messages | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of messages accumulated on a log partition before messages are flushed to disk. <br>This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig2_8.flush_messages](#TopicConfig2_81) setting. 
log_flush_interval_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time (in milliseconds) that a message in any topic is kept in memory before flushed to disk. If not set, the value of `log_flush_scheduler_interval_ms` is used. <br>This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig2_8.flush_ms](#TopicConfig2_81) setting. 
log_flush_scheduler_interval_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The frequency of checks (in milliseconds) for any logs that need to be flushed to disk. This check is done by the log flusher. 
log_retention_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Partition size limit; Kafka will discard old log segments to free up space if `delete` [TopicConfig2_8.cleanup_policy](#TopicConfig2_81) is in effect. This setting is helpful if you need to control the size of a log due to limited disk space. <br>This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig2_8.retention_bytes](#TopicConfig2_81) setting. 
log_retention_hours | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of hours to keep a log segment file before deleting it. 
log_retention_minutes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of minutes to keep a log segment file before deleting it. <br>If not set, the value of `log_retention_hours` is used. 
log_retention_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of milliseconds to keep a log segment file before deleting it. <br>If not set, the value of `log_retention_minutes` is used. <br>This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig2_8.retention_ms](#TopicConfig2_81) setting. 
log_segment_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size of a single log file. <br>This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig2_8.segment_bytes](#TopicConfig2_81) setting. 
log_preallocate | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Should pre allocate file when create new segment? <br>This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig2_8.preallocate](#TopicConfig2_81) setting. 
socket_send_buffer_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The SO_SNDBUF buffer of the socket server sockets. If the value is -1, the OS default will be used. 
socket_receive_buffer_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The SO_RCVBUF buffer of the socket server sockets. If the value is -1, the OS default will be used. 
auto_create_topics_enable | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Enable auto creation of topic on the server 
num_partitions | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Default number of partitions per topic on the whole cluster 
default_replication_factor | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Default replication factor of the topic on the whole cluster 
message_max_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The largest record batch size allowed by Kafka. Default value: 1048588. 
replica_fetch_max_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of bytes of messages to attempt to fetch for each partition. Default value: 1048576. 
ssl_cipher_suites[] | **string**<br>A list of cipher suites. 
offsets_retention_minutes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Offset storage time after a consumer group loses all its consumers. Default: 10080. 
sasl_enabled_mechanisms[] | enum **SaslMechanism**<br>The list of SASL mechanisms enabled in the Kafka server. Default: [SCRAM_SHA_512]. 


### KafkaConfig3 {#KafkaConfig37}

Field | Description
--- | ---
compression_type | enum **CompressionType**<br>Cluster topics compression type. <ul><li>`COMPRESSION_TYPE_UNCOMPRESSED`: no codec (uncompressed).</li><li>`COMPRESSION_TYPE_ZSTD`: Zstandard codec.</li><li>`COMPRESSION_TYPE_LZ4`: LZ4 codec.</li><li>`COMPRESSION_TYPE_SNAPPY`: Snappy codec.</li><li>`COMPRESSION_TYPE_GZIP`: GZip codec.</li><li>`COMPRESSION_TYPE_PRODUCER`: the codec to use is set by a producer (can be any of `ZSTD`, `LZ4`, `GZIP` or `SNAPPY` codecs).</li></ul>
log_flush_interval_messages | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of messages accumulated on a log partition before messages are flushed to disk. <br>This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig3.flush_messages](#TopicConfig31) setting. 
log_flush_interval_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time (in milliseconds) that a message in any topic is kept in memory before flushed to disk. If not set, the value of `log_flush_scheduler_interval_ms` is used. <br>This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig3.flush_ms](#TopicConfig31) setting. 
log_flush_scheduler_interval_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The frequency of checks (in milliseconds) for any logs that need to be flushed to disk. This check is done by the log flusher. 
log_retention_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Partition size limit; Kafka will discard old log segments to free up space if `delete` [TopicConfig3.cleanup_policy](#TopicConfig31) is in effect. This setting is helpful if you need to control the size of a log due to limited disk space. <br>This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig3.retention_bytes](#TopicConfig31) setting. 
log_retention_hours | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of hours to keep a log segment file before deleting it. 
log_retention_minutes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of minutes to keep a log segment file before deleting it. <br>If not set, the value of `log_retention_hours` is used. 
log_retention_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of milliseconds to keep a log segment file before deleting it. <br>If not set, the value of `log_retention_minutes` is used. <br>This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig3.retention_ms](#TopicConfig31) setting. 
log_segment_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size of a single log file. <br>This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig3.segment_bytes](#TopicConfig31) setting. 
log_preallocate | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Should pre allocate file when create new segment? <br>This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig3.preallocate](#TopicConfig31) setting. 
socket_send_buffer_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The SO_SNDBUF buffer of the socket server sockets. If the value is -1, the OS default will be used. 
socket_receive_buffer_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The SO_RCVBUF buffer of the socket server sockets. If the value is -1, the OS default will be used. 
auto_create_topics_enable | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Enable auto creation of topic on the server 
num_partitions | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Default number of partitions per topic on the whole cluster 
default_replication_factor | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Default replication factor of the topic on the whole cluster 
message_max_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The largest record batch size allowed by Kafka. Default value: 1048588. 
replica_fetch_max_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of bytes of messages to attempt to fetch for each partition. Default value: 1048576. 
ssl_cipher_suites[] | **string**<br>A list of cipher suites. 
offsets_retention_minutes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Offset storage time after a consumer group loses all its consumers. Default: 10080. 
sasl_enabled_mechanisms[] | enum **SaslMechanism**<br>The list of SASL mechanisms enabled in the Kafka server. Default: [SCRAM_SHA_512]. 


### MaintenanceWindow {#MaintenanceWindow7}

Field | Description
--- | ---
policy | **oneof:** `anytime` or `weekly_maintenance_window`<br>
&nbsp;&nbsp;anytime | **[AnytimeMaintenanceWindow](#AnytimeMaintenanceWindow7)**<br> 
&nbsp;&nbsp;weekly_maintenance_window | **[WeeklyMaintenanceWindow](#WeeklyMaintenanceWindow7)**<br> 


### AnytimeMaintenanceWindow {#AnytimeMaintenanceWindow7}

Empty.

### WeeklyMaintenanceWindow {#WeeklyMaintenanceWindow7}

Field | Description
--- | ---
day | enum **WeekDay**<br> 
hour | **int64**<br>Hour of the day in UTC. Acceptable values are 1 to 24, inclusive.


### MaintenanceOperation {#MaintenanceOperation7}

Field | Description
--- | ---
info | **string**<br> The maximum string length in characters is 256.
delayed_until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 


## ListLogs {#ListLogs}

Retrieves logs for the specified Apache Kafka® cluster. <br>For more information about logs, see the [Logs](/docs/managed-kafka/operations/cluster-logs) section in the documentation.

**rpc ListLogs ([ListClusterLogsRequest](#ListClusterLogsRequest)) returns ([ListClusterLogsResponse](#ListClusterLogsResponse))**

### ListClusterLogsRequest {#ListClusterLogsRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Apache Kafka® cluster to request logs for. <br>To get the Apache Kafka® cluster ID, make a [ClusterService.List](#List) request. The maximum string length in characters is 50.
column_filter[] | **string**<br>Columns from the logs table to request. <br>If no columns are specified, full log records are returned. 
from_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Start timestamp for the logs request. 
to_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>End timestamp for the logs request. 
page_size | **int64**<br>The maximum number of results per page to return. <br>If the number of available results is larger than `page_size`, the service returns a [ListClusterLogsResponse.next_page_token](#ListClusterLogsResponse) that can be used to get the next page of results in subsequent list requests. The maximum value is 1000.
page_token | **string**<br>Page token. <br>To get the next page of results, set `page_token` to the [ListClusterLogsResponse.next_page_token](#ListClusterLogsResponse) returned by the previous list request. The maximum string length in characters is 100.
always_next_page_token | **bool**<br>The flag that defines behavior of providing the next page token. <br>If this flag is set to `true`, this API method will always return [ListClusterLogsResponse.next_page_token](#ListClusterLogsResponse), even if current page is empty. 
filter | **string**<br>A filter expression that filters resources listed in the response. <br>The expression must specify: <ol><li>The field name to filter by. Currently filtering can be applied to the `hostname` field. </li><li>An `=` operator. </li><li>The value in double quotes (`"`). Must be 1-63 characters long and match the regular expression `[a-z0-9.-]{1,61}`. </li></ol><br>Example of a filter: `message.hostname='node1.db.cloud.yandex.net'` The maximum string length in characters is 1000.


### ListClusterLogsResponse {#ListClusterLogsResponse}

Field | Description
--- | ---
logs[] | **[LogRecord](#LogRecord)**<br>Requested log records. 
next_page_token | **string**<br>Token that allows you to get the next page of results for list requests. <br>If the number of results is larger than [ListClusterLogsRequest.page_size](#ListClusterLogsRequest), use `next_page_token` as the value for the [ListClusterLogsRequest.page_token](#ListClusterLogsRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. This value is interchangeable with [StreamLogRecord.next_record_token](#StreamLogRecord) from StreamLogs method. 


### LogRecord {#LogRecord}

Field | Description
--- | ---
timestamp | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Log record timestamp. 
message | **map<string,string>**<br>Contents of the log record. 


## StreamLogs {#StreamLogs}

Same as [ListLogs](#ListLogs) but using server-side streaming. Also allows for `tail -f` semantics.

**rpc StreamLogs ([StreamClusterLogsRequest](#StreamClusterLogsRequest)) returns (stream [StreamLogRecord](#StreamLogRecord))**

### StreamClusterLogsRequest {#StreamClusterLogsRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Apache Kafka® cluster. <br>To get the Apache Kafka® cluster ID, make a [ClusterService.List](#List) request. The maximum string length in characters is 50.
column_filter[] | **string**<br>Columns from logs table to get in the response. <br>If no columns are specified, full log records are returned. 
from_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Start timestamp for the logs request. 
to_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>End timestamp for the logs request. <br>If this field is not set, all existing logs will be sent and then the new ones as they appear. In essence it has `tail -f` semantics. 
record_token | **string**<br>Record token. <br>Set `record_token` to the [StreamLogRecord.next_record_token](#StreamLogRecord) returned by a previous [ClusterService.StreamLogs](#StreamLogs) request to start streaming from next log record. The maximum string length in characters is 100.
filter | **string**<br>A filter expression that filters resources listed in the response. <br>The expression must specify: <ol><li>The field name to filter by. Currently filtering can be applied to the `hostname` field. </li><li>An `=` operator. </li><li>The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`. </li></ol><br>Example of a filter: `message.hostname='node1.db.cloud.yandex.net'` The maximum string length in characters is 1000.


### StreamLogRecord {#StreamLogRecord}

Field | Description
--- | ---
record | **[LogRecord](#LogRecord)**<br>One of the requested log records. 
next_record_token | **string**<br>This token allows you to continue streaming logs starting from the exact same record. <br>To continue streaming, specify value of `next_record_token` as value for [StreamClusterLogsRequest.record_token](#StreamClusterLogsRequest) parameter in the next StreamLogs request. <br>This value is interchangeable with [ListClusterLogsResponse.next_page_token](#ListClusterLogsResponse) from ListLogs method. 


### LogRecord {#LogRecord1}

Field | Description
--- | ---
timestamp | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Log record timestamp. 
message | **map<string,string>**<br>Contents of the log record. 


## ListOperations {#ListOperations}

Retrieves the list of operations for the specified Apache Kafka® cluster.

**rpc ListOperations ([ListClusterOperationsRequest](#ListClusterOperationsRequest)) returns ([ListClusterOperationsResponse](#ListClusterOperationsResponse))**

### ListClusterOperationsRequest {#ListClusterOperationsRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Apache Kafka® cluster to list operations for. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. <br>If the number of available results is larger than `page_size`, the service returns a [ListClusterOperationsResponse.next_page_token](#ListClusterOperationsResponse) that can be used to get the next page of results in subsequent list requests. The maximum value is 1000.
page_token | **string**<br>Page token. <br>To get the next page of results, set `page_token` to the [ListClusterOperationsResponse.next_page_token](#ListClusterOperationsResponse) returned by the previous list request. The maximum string length in characters is 100.


### ListClusterOperationsResponse {#ListClusterOperationsResponse}

Field | Description
--- | ---
operations[] | **[operation.Operation](#Operation7)**<br>List of operations for the specified Apache Kafka® cluster. 
next_page_token | **string**<br>Token that allows you to get the next page of results for list requests. <br>If the number of results is larger than [ListClusterOperationsRequest.page_size](#ListClusterOperationsRequest), use `next_page_token` as the value for the [ListClusterOperationsRequest.page_token](#ListClusterOperationsRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### Operation {#Operation7}

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

Retrieves a list of hosts for the specified Apache Kafka® cluster.

**rpc ListHosts ([ListClusterHostsRequest](#ListClusterHostsRequest)) returns ([ListClusterHostsResponse](#ListClusterHostsResponse))**

### ListClusterHostsRequest {#ListClusterHostsRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Apache Kafka® cluster. <br>To get the Apache Kafka® cluster ID, make a [ClusterService.List](#List) request. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. <br>If the number of available results is larger than `page_size`, the service returns a [ListClusterHostsResponse.next_page_token](#ListClusterHostsResponse) that can be used to get the next page of results in subsequent list requests. The maximum value is 1000.
page_token | **string**<br>Page token. <br>To get the next page of results, set `page_token` to the [ListClusterHostsResponse.next_page_token](#ListClusterHostsResponse) returned by the previous list request. The maximum string length in characters is 100.


### ListClusterHostsResponse {#ListClusterHostsResponse}

Field | Description
--- | ---
hosts[] | **[Host](#Host)**<br>List of hosts. 
next_page_token | **string**<br>Token that allows you to get the next page of results for list requests. <br>If the number of results is larger than [ListClusterHostsRequest.page_size](#ListClusterHostsRequest), use the `next_page_token` as the value for the [ListClusterHostsRequest.page_token](#ListClusterHostsRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### Host {#Host}

Field | Description
--- | ---
name | **string**<br>Name of the host. 
cluster_id | **string**<br>ID of the Apache Kafka® cluster. 
zone_id | **string**<br>ID of the availability zone where the host resides. 
role | enum **Role**<br>Host role. <ul><li>`KAFKA`: the host is a Kafka broker.</li><li>`ZOOKEEPER`: the host is a ZooKeeper server.</li></ul>
resources | **[Resources](#Resources8)**<br>Computational resources allocated to the host. 
health | enum **Health**<br>Aggregated host health data. <ul><li>`UNKNOWN`: health of the host is unknown.</li><li>`ALIVE`: the host is performing all its functions normally.</li><li>`DEAD`: the host is inoperable and cannot perform any of its essential functions.</li><li>`DEGRADED`: the host is degraded and can perform only some of its essential functions.</li></ul>
subnet_id | **string**<br>ID of the subnet the host resides in. 
assign_public_ip | **bool**<br>The flag that defines whether a public IP address is assigned to the node. <br>If the value is `true`, then this node is available on the Internet via it's public IP address. 


### Resources {#Resources8}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory, etc.). All available presets are listed in the [documentation](/docs/managed-kafka/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage available to a host, in bytes. Must be greater than 2 * partition segment size in bytes * partitions count, so each partition can have one active segment file and one closed segment file that can be deleted. 
disk_type_id | **string**<br>Type of the storage environment for the host. 


