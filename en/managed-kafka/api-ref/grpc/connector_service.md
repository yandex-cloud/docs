---
editable: false
sourcePath: en/_api-ref-grpc/managed-kafka/api-ref/grpc/connector_service.md
---

# ConnectorService

A set of methods for managing Apache Kafka® connectors.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns information about an Apache Kafka® connector. |
| [List](#List) | Retrieves the list of Apache Kafka® connectors in a cluster. |
| [Create](#Create) | Creates a new Apache Kafka® connector in a cluster. |
| [Update](#Update) | Updates an Apache Kafka® connector. |
| [Delete](#Delete) | Deletes an Apache Kafka® connector. |
| [Resume](#Resume) | Resumes an Apache Kafka® connector. |
| [Pause](#Pause) | Pauses an Apache Kafka® connector. |

## Calls ConnectorService {#calls}

## Get {#Get}

Returns information about an Apache Kafka® connector.

**rpc Get ([GetConnectorRequest](#GetConnectorRequest)) returns ([Connector](#Connector))**

### GetConnectorRequest {#GetConnectorRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the cluster the connector belongs to. <br>To get this ID, make a [ClusterService.List](./cluster_service#List) request. The maximum string length in characters is 50.
connector_name | **string**<br>Required. Name of the Apache Kafka® connector to return information about. <br>To get this name, make a [ConnectorService.List](#List) request. The maximum string length in characters is 256. Value must match the regular expression ` [a-zA-Z0-9_-]* `.


### Connector {#Connector}

Field | Description
--- | ---
name | **string**<br>Name of the connector. 
tasks_max | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of connector tasks. Default value is the number of brokers. 
properties | **map<string,string>**<br>A set of properties passed to Managed Service for Apache Kafka® with the connector configuration. Example: `sync.topics.config.enabled: true`. 
health | enum **Health**<br>Connector health. <ul><li>`HEALTH_UNKNOWN`: Health of the connector is unknown.</li><li>`ALIVE`: Connector is running.</li><li>`DEAD`: Connector has failed to start.</li></ul>
status | enum **Status**<br>Current status of the connector. <ul><li>`STATUS_UNKNOWN`: Connector state is unknown.</li><li>`RUNNING`: Connector is running normally.</li><li>`ERROR`: Connector has encountered a problem and cannot operate.</li><li>`PAUSED`: Connector is paused.</li></ul>
cluster_id | **string**<br>ID of the Apache Kafka® cluster that the connector belongs to. 
connector_config | **oneof:** `connector_config_mirrormaker` or `connector_config_s3_sink`<br>Additional settings for the connector.
&nbsp;&nbsp;connector_config_mirrormaker | **[ConnectorConfigMirrorMaker](#ConnectorConfigMirrorMaker)**<br>Configuration of the MirrorMaker connector. 
&nbsp;&nbsp;connector_config_s3_sink | **[ConnectorConfigS3Sink](#ConnectorConfigS3Sink)**<br>Additional settings for the connector. 


### ConnectorConfigMirrorMaker {#ConnectorConfigMirrorMaker}

Field | Description
--- | ---
source_cluster | **[ClusterConnection](#ClusterConnection)**<br>Source cluster connection configuration. 
target_cluster | **[ClusterConnection](#ClusterConnection)**<br>Target cluster connection configuration. 
topics | **string**<br>List of Kafka topics, separated by `,`. 
replication_factor | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Replication factor for automatically created topics. 


### ClusterConnection {#ClusterConnection}

Field | Description
--- | ---
alias | **string**<br>Alias of cluster connection configuration. Examples: `source`, `target`. 
cluster_connection | **oneof:** `this_cluster` or `external_cluster`<br>Type of connection to Apache Kafka® cluster.
&nbsp;&nbsp;this_cluster | **[ThisCluster](#ThisCluster)**<br>Connection configuration of the cluster the connector belongs to. As all credentials are already known, leave this parameter empty. 
&nbsp;&nbsp;external_cluster | **[ExternalClusterConnection](#ExternalClusterConnection)**<br>Configuration of connection to an external cluster with all the necessary credentials. 


### ThisCluster {#ThisCluster}



### ExternalClusterConnection {#ExternalClusterConnection}

Field | Description
--- | ---
bootstrap_servers | **string**<br>List of bootstrap servers of the cluster, separated by `,`. 
sasl_username | **string**<br>SASL username to use for connection to the cluster. 
sasl_mechanism | **string**<br>SASL mechanism to use for connection to the cluster. 
security_protocol | **string**<br>Security protocol to use for connection to the cluster. 


### ConnectorConfigS3Sink {#ConnectorConfigS3Sink}

Field | Description
--- | ---
topics | **string**<br>List of Kafka topics, separated by ',' 
file_compression_type | **string**<br>The compression type used for files put on GCS. The supported values are: `gzip`, `snappy`, `zstd`, `none`. Optional, the default is `none`. 
file_max_records | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Max records per file. 
s3_connection | **[S3Connection](#S3Connection)**<br>Credentials for connecting to S3 storage 


### S3Connection {#S3Connection}

Field | Description
--- | ---
bucket_name | **string**<br> 
storage | **oneof:** `external_s3`<br>
&nbsp;&nbsp;external_s3 | **[ExternalS3Storage](#ExternalS3Storage)**<br> 


### ExternalS3Storage {#ExternalS3Storage}

Field | Description
--- | ---
access_key_id | **string**<br> 
endpoint | **string**<br> 
region | **string**<br>Default is 'us-east-1' 


## List {#List}

Retrieves the list of Apache Kafka® connectors in a cluster.

**rpc List ([ListConnectorsRequest](#ListConnectorsRequest)) returns ([ListConnectorsResponse](#ListConnectorsResponse))**

### ListConnectorsRequest {#ListConnectorsRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Apache Kafka® cluster to list connectors in. <br>To get this ID, make a [ClusterService.List](./cluster_service#List) request. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. <br>If the number of available results is larger than `page_size`, the API returns a [ListConnectorsResponse.next_page_token](#ListConnectorsResponse) that can be used to get the next page of results in the subsequent [ConnectorService.List](#List) requests. The maximum value is 1000.
page_token | **string**<br>Page token that can be used to iterate through multiple pages of results. <br>To get the next page of results, set `page_token` to the [ListConnectorsResponse.next_page_token](#ListConnectorsResponse) returned by the previous [ConnectorService.List](#List) request. The maximum string length in characters is 100.


### ListConnectorsResponse {#ListConnectorsResponse}

Field | Description
--- | ---
connectors[] | **[Connector](#Connector1)**<br>List of Apache Kafka® Connectors. 
next_page_token | **string**<br>The token that can be used to get the next page of results. <br>If the number of results is larger than [ListConnectorsRequest.page_size](#ListConnectorsRequest), use the `next_page_token` as the value for the [ListConnectorsRequest.page_token](#ListConnectorsRequest) in the subsequent [ConnectorService.List](#List) request to iterate through multiple pages of results. 


### Connector {#Connector1}

Field | Description
--- | ---
name | **string**<br>Name of the connector. 
tasks_max | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of connector tasks. Default value is the number of brokers. 
properties | **map<string,string>**<br>A set of properties passed to Managed Service for Apache Kafka® with the connector configuration. Example: `sync.topics.config.enabled: true`. 
health | enum **Health**<br>Connector health. <ul><li>`HEALTH_UNKNOWN`: Health of the connector is unknown.</li><li>`ALIVE`: Connector is running.</li><li>`DEAD`: Connector has failed to start.</li></ul>
status | enum **Status**<br>Current status of the connector. <ul><li>`STATUS_UNKNOWN`: Connector state is unknown.</li><li>`RUNNING`: Connector is running normally.</li><li>`ERROR`: Connector has encountered a problem and cannot operate.</li><li>`PAUSED`: Connector is paused.</li></ul>
cluster_id | **string**<br>ID of the Apache Kafka® cluster that the connector belongs to. 
connector_config | **oneof:** `connector_config_mirrormaker` or `connector_config_s3_sink`<br>Additional settings for the connector.
&nbsp;&nbsp;connector_config_mirrormaker | **[ConnectorConfigMirrorMaker](#ConnectorConfigMirrorMaker1)**<br>Configuration of the MirrorMaker connector. 
&nbsp;&nbsp;connector_config_s3_sink | **[ConnectorConfigS3Sink](#ConnectorConfigS3Sink1)**<br>Additional settings for the connector. 


### ConnectorConfigMirrorMaker {#ConnectorConfigMirrorMaker1}

Field | Description
--- | ---
source_cluster | **[ClusterConnection](#ClusterConnection1)**<br>Source cluster connection configuration. 
target_cluster | **[ClusterConnection](#ClusterConnection1)**<br>Target cluster connection configuration. 
topics | **string**<br>List of Kafka topics, separated by `,`. 
replication_factor | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Replication factor for automatically created topics. 


### ClusterConnection {#ClusterConnection1}

Field | Description
--- | ---
alias | **string**<br>Alias of cluster connection configuration. Examples: `source`, `target`. 
cluster_connection | **oneof:** `this_cluster` or `external_cluster`<br>Type of connection to Apache Kafka® cluster.
&nbsp;&nbsp;this_cluster | **[ThisCluster](#ThisCluster1)**<br>Connection configuration of the cluster the connector belongs to. As all credentials are already known, leave this parameter empty. 
&nbsp;&nbsp;external_cluster | **[ExternalClusterConnection](#ExternalClusterConnection1)**<br>Configuration of connection to an external cluster with all the necessary credentials. 


### ThisCluster {#ThisCluster1}



### ExternalClusterConnection {#ExternalClusterConnection1}

Field | Description
--- | ---
bootstrap_servers | **string**<br>List of bootstrap servers of the cluster, separated by `,`. 
sasl_username | **string**<br>SASL username to use for connection to the cluster. 
sasl_mechanism | **string**<br>SASL mechanism to use for connection to the cluster. 
security_protocol | **string**<br>Security protocol to use for connection to the cluster. 


### ConnectorConfigS3Sink {#ConnectorConfigS3Sink1}

Field | Description
--- | ---
topics | **string**<br>List of Kafka topics, separated by ',' 
file_compression_type | **string**<br>The compression type used for files put on GCS. The supported values are: `gzip`, `snappy`, `zstd`, `none`. Optional, the default is `none`. 
file_max_records | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Max records per file. 
s3_connection | **[S3Connection](#S3Connection1)**<br>Credentials for connecting to S3 storage 


### S3Connection {#S3Connection1}

Field | Description
--- | ---
bucket_name | **string**<br> 
storage | **oneof:** `external_s3`<br>
&nbsp;&nbsp;external_s3 | **[ExternalS3Storage](#ExternalS3Storage1)**<br> 


### ExternalS3Storage {#ExternalS3Storage1}

Field | Description
--- | ---
access_key_id | **string**<br> 
endpoint | **string**<br> 
region | **string**<br>Default is 'us-east-1' 


## Create {#Create}

Creates a new Apache Kafka® connector in a cluster.

**rpc Create ([CreateConnectorRequest](#CreateConnectorRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateConnectorMetadata](#CreateConnectorMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Connector](#Connector2)<br>

### CreateConnectorRequest {#CreateConnectorRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Apache Kafka® cluster to create the connector in. <br>To get this ID, make a [ClusterService.List](./cluster_service#List) request. The maximum string length in characters is 50.
connector_spec | **[ConnectorSpec](#ConnectorSpec)**<br>Required. Configuration of the connector to create. 


### ConnectorSpec {#ConnectorSpec}

Field | Description
--- | ---
name | **string**<br>Name of the connector. 
tasks_max | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of connector tasks. Default value is the number of brokers. 
properties | **map<string,string>**<br>A set of properties passed to Managed Service for Apache Kafka® with the connector configuration. Example: `sync.topics.config.enabled: true`. 
connector_config | **oneof:** `connector_config_mirrormaker` or `connector_config_s3_sink`<br>Additional settings for the connector.
&nbsp;&nbsp;connector_config_mirrormaker | **[ConnectorConfigMirrorMakerSpec](#ConnectorConfigMirrorMakerSpec)**<br>Configuration of the MirrorMaker connector. 
&nbsp;&nbsp;connector_config_s3_sink | **[ConnectorConfigS3SinkSpec](#ConnectorConfigS3SinkSpec)**<br>Configuration of S3-Sink connector 


### ConnectorConfigMirrorMakerSpec {#ConnectorConfigMirrorMakerSpec}

Field | Description
--- | ---
source_cluster | **[ClusterConnectionSpec](#ClusterConnectionSpec)**<br>Source cluster configuration for the MirrorMaker connector. 
target_cluster | **[ClusterConnectionSpec](#ClusterConnectionSpec)**<br>Target cluster configuration for the MirrorMaker connector. 
topics | **string**<br>List of Kafka topics, separated by `,`. 
replication_factor | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Replication factor for automatically created topics. 


### ClusterConnectionSpec {#ClusterConnectionSpec}

Field | Description
--- | ---
alias | **string**<br>Alias of cluster connection configuration. Examples: `source`, `target`. 
cluster_connection | **oneof:** `this_cluster` or `external_cluster`<br>Type of connection to Apache Kafka® cluster.
&nbsp;&nbsp;this_cluster | **[ThisClusterSpec](#ThisClusterSpec)**<br>Connection configuration of the cluster the connector belongs to. As all credentials are already known, leave this parameter empty. 
&nbsp;&nbsp;external_cluster | **[ExternalClusterConnectionSpec](#ExternalClusterConnectionSpec)**<br>Configuration of connection to an external cluster with all the necessary credentials. 


### ThisClusterSpec {#ThisClusterSpec}



### ExternalClusterConnectionSpec {#ExternalClusterConnectionSpec}

Field | Description
--- | ---
bootstrap_servers | **string**<br>List of bootstrap servers of the cluster, separated by `,`. 
sasl_username | **string**<br>SASL username to use for connection to the cluster. 
sasl_password | **string**<br>SASL password to use for connection to the cluster. 
sasl_mechanism | **string**<br>SASL mechanism to use for connection to the cluster. 
security_protocol | **string**<br>Security protocol to use for connection to the cluster. 
ssl_truststore_certificates | **string**<br>CA in PEM format to connect to external cluster. Lines of certificate separated by '\n' symbol. 


### ConnectorConfigS3SinkSpec {#ConnectorConfigS3SinkSpec}

Field | Description
--- | ---
topics | **string**<br>List of Kafka topics, separated by ','. 
file_compression_type | **string**<br>The compression type used for files put on GCS. The supported values are: `gzip`, `snappy`, `zstd`, `none`. Optional, the default is `none`. 
file_max_records | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Max records per file. 
s3_connection | **[S3ConnectionSpec](#S3ConnectionSpec)**<br>Credentials for connecting to S3 storage 


### S3ConnectionSpec {#S3ConnectionSpec}

Field | Description
--- | ---
bucket_name | **string**<br> 
storage | **oneof:** `external_s3`<br>
&nbsp;&nbsp;external_s3 | **[ExternalS3StorageSpec](#ExternalS3StorageSpec)**<br> 


### ExternalS3StorageSpec {#ExternalS3StorageSpec}

Field | Description
--- | ---
access_key_id | **string**<br> 
secret_access_key | **string**<br> 
endpoint | **string**<br> 
region | **string**<br>Default is 'us-east-1' 


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateConnectorMetadata](#CreateConnectorMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Connector](#Connector2)>**<br>if operation finished successfully. 


### CreateConnectorMetadata {#CreateConnectorMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>ID of the Apache Kafka® cluster the connector is being created in. 
connector_name | **string**<br>Required. Name of the Apache Kafka® connector that is being created. The maximum string length in characters is 256. Value must match the regular expression ` [a-zA-Z0-9_-]* `.


### Connector {#Connector2}

Field | Description
--- | ---
name | **string**<br>Name of the connector. 
tasks_max | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of connector tasks. Default value is the number of brokers. 
properties | **map<string,string>**<br>A set of properties passed to Managed Service for Apache Kafka® with the connector configuration. Example: `sync.topics.config.enabled: true`. 
health | enum **Health**<br>Connector health. <ul><li>`HEALTH_UNKNOWN`: Health of the connector is unknown.</li><li>`ALIVE`: Connector is running.</li><li>`DEAD`: Connector has failed to start.</li></ul>
status | enum **Status**<br>Current status of the connector. <ul><li>`STATUS_UNKNOWN`: Connector state is unknown.</li><li>`RUNNING`: Connector is running normally.</li><li>`ERROR`: Connector has encountered a problem and cannot operate.</li><li>`PAUSED`: Connector is paused.</li></ul>
cluster_id | **string**<br>ID of the Apache Kafka® cluster that the connector belongs to. 
connector_config | **oneof:** `connector_config_mirrormaker` or `connector_config_s3_sink`<br>Additional settings for the connector.
&nbsp;&nbsp;connector_config_mirrormaker | **[ConnectorConfigMirrorMaker](#ConnectorConfigMirrorMaker2)**<br>Configuration of the MirrorMaker connector. 
&nbsp;&nbsp;connector_config_s3_sink | **[ConnectorConfigS3Sink](#ConnectorConfigS3Sink2)**<br>Additional settings for the connector. 


### ConnectorConfigMirrorMaker {#ConnectorConfigMirrorMaker2}

Field | Description
--- | ---
source_cluster | **[ClusterConnection](#ClusterConnection2)**<br>Source cluster connection configuration. 
target_cluster | **[ClusterConnection](#ClusterConnection2)**<br>Target cluster connection configuration. 
topics | **string**<br>List of Kafka topics, separated by `,`. 
replication_factor | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Replication factor for automatically created topics. 


### ClusterConnection {#ClusterConnection2}

Field | Description
--- | ---
alias | **string**<br>Alias of cluster connection configuration. Examples: `source`, `target`. 
cluster_connection | **oneof:** `this_cluster` or `external_cluster`<br>Type of connection to Apache Kafka® cluster.
&nbsp;&nbsp;this_cluster | **[ThisCluster](#ThisCluster2)**<br>Connection configuration of the cluster the connector belongs to. As all credentials are already known, leave this parameter empty. 
&nbsp;&nbsp;external_cluster | **[ExternalClusterConnection](#ExternalClusterConnection2)**<br>Configuration of connection to an external cluster with all the necessary credentials. 


### ThisCluster {#ThisCluster2}



### ExternalClusterConnection {#ExternalClusterConnection2}

Field | Description
--- | ---
bootstrap_servers | **string**<br>List of bootstrap servers of the cluster, separated by `,`. 
sasl_username | **string**<br>SASL username to use for connection to the cluster. 
sasl_mechanism | **string**<br>SASL mechanism to use for connection to the cluster. 
security_protocol | **string**<br>Security protocol to use for connection to the cluster. 


### ConnectorConfigS3Sink {#ConnectorConfigS3Sink2}

Field | Description
--- | ---
topics | **string**<br>List of Kafka topics, separated by ',' 
file_compression_type | **string**<br>The compression type used for files put on GCS. The supported values are: `gzip`, `snappy`, `zstd`, `none`. Optional, the default is `none`. 
file_max_records | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Max records per file. 
s3_connection | **[S3Connection](#S3Connection2)**<br>Credentials for connecting to S3 storage 


### S3Connection {#S3Connection2}

Field | Description
--- | ---
bucket_name | **string**<br> 
storage | **oneof:** `external_s3`<br>
&nbsp;&nbsp;external_s3 | **[ExternalS3Storage](#ExternalS3Storage2)**<br> 


### ExternalS3Storage {#ExternalS3Storage2}

Field | Description
--- | ---
access_key_id | **string**<br> 
endpoint | **string**<br> 
region | **string**<br>Default is 'us-east-1' 


## Update {#Update}

Updates an Apache Kafka® connector.

**rpc Update ([UpdateConnectorRequest](#UpdateConnectorRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateConnectorMetadata](#UpdateConnectorMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Connector](#Connector3)<br>

### UpdateConnectorRequest {#UpdateConnectorRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Apache Kafka® cluster to update the connector in. <br>To get this ID, make a [ClusterService.List](./cluster_service#List) request. The maximum string length in characters is 50.
connector_name | **string**<br>Required. Name of the connector to update. <br>To get this name, make a [ConnectorService.List](#List) request. The maximum string length in characters is 256. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Field mask that specifies which settings of the connector should be updated. 
connector_spec | **[UpdateConnectorSpec](#UpdateConnectorSpec)**<br>Required. Configuration of the connector to update. 


### UpdateConnectorSpec {#UpdateConnectorSpec}

Field | Description
--- | ---
tasks_max | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of connector tasks to update. 
properties | **map<string,string>**<br>A set of new or changed properties to update for the connector. They are passed with the connector configuration to Managed Service for Apache Kafka®. Example: `sync.topics.config.enabled: false`. 
connector_config | **oneof:** `connector_config_mirrormaker` or `connector_config_s3_sink`<br>Updated configuration for the connector.
&nbsp;&nbsp;connector_config_mirrormaker | **[ConnectorConfigMirrorMakerSpec](#ConnectorConfigMirrorMakerSpec1)**<br>Configuration of the MirrorMaker connector. 
&nbsp;&nbsp;connector_config_s3_sink | **[UpdateConnectorConfigS3SinkSpec](#UpdateConnectorConfigS3SinkSpec)**<br>Update specification for S3-Sink Connector. 


### ConnectorConfigMirrorMakerSpec {#ConnectorConfigMirrorMakerSpec1}

Field | Description
--- | ---
source_cluster | **[ClusterConnectionSpec](#ClusterConnectionSpec1)**<br>Source cluster configuration for the MirrorMaker connector. 
target_cluster | **[ClusterConnectionSpec](#ClusterConnectionSpec1)**<br>Target cluster configuration for the MirrorMaker connector. 
topics | **string**<br>List of Kafka topics, separated by `,`. 
replication_factor | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Replication factor for automatically created topics. 


### ClusterConnectionSpec {#ClusterConnectionSpec1}

Field | Description
--- | ---
alias | **string**<br>Alias of cluster connection configuration. Examples: `source`, `target`. 
cluster_connection | **oneof:** `this_cluster` or `external_cluster`<br>Type of connection to Apache Kafka® cluster.
&nbsp;&nbsp;this_cluster | **[ThisClusterSpec](#ThisClusterSpec1)**<br>Connection configuration of the cluster the connector belongs to. As all credentials are already known, leave this parameter empty. 
&nbsp;&nbsp;external_cluster | **[ExternalClusterConnectionSpec](#ExternalClusterConnectionSpec1)**<br>Configuration of connection to an external cluster with all the necessary credentials. 


### ThisClusterSpec {#ThisClusterSpec1}



### ExternalClusterConnectionSpec {#ExternalClusterConnectionSpec1}

Field | Description
--- | ---
bootstrap_servers | **string**<br>List of bootstrap servers of the cluster, separated by `,`. 
sasl_username | **string**<br>SASL username to use for connection to the cluster. 
sasl_password | **string**<br>SASL password to use for connection to the cluster. 
sasl_mechanism | **string**<br>SASL mechanism to use for connection to the cluster. 
security_protocol | **string**<br>Security protocol to use for connection to the cluster. 
ssl_truststore_certificates | **string**<br>CA in PEM format to connect to external cluster. Lines of certificate separated by '\n' symbol. 


### UpdateConnectorConfigS3SinkSpec {#UpdateConnectorConfigS3SinkSpec}

Field | Description
--- | ---
topics | **string**<br>List of Kafka topics, separated by ','. 
file_max_records | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Max records per file. 
s3_connection | **[S3ConnectionSpec](#S3ConnectionSpec1)**<br>Credentials for connecting to S3 storage 


### S3ConnectionSpec {#S3ConnectionSpec1}

Field | Description
--- | ---
bucket_name | **string**<br> 
storage | **oneof:** `external_s3`<br>
&nbsp;&nbsp;external_s3 | **[ExternalS3StorageSpec](#ExternalS3StorageSpec1)**<br> 


### ExternalS3StorageSpec {#ExternalS3StorageSpec1}

Field | Description
--- | ---
access_key_id | **string**<br> 
secret_access_key | **string**<br> 
endpoint | **string**<br> 
region | **string**<br>Default is 'us-east-1' 


### Operation {#Operation1}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateConnectorMetadata](#UpdateConnectorMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Connector](#Connector3)>**<br>if operation finished successfully. 


### UpdateConnectorMetadata {#UpdateConnectorMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Apache Kafka® cluster the connector is being updated in. The maximum string length in characters is 50.
connector_name | **string**<br>Required. Name of the Apache Kafka connector that is being updated. The maximum string length in characters is 256. Value must match the regular expression ` [a-zA-Z0-9_-]* `.


### Connector {#Connector3}

Field | Description
--- | ---
name | **string**<br>Name of the connector. 
tasks_max | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of connector tasks. Default value is the number of brokers. 
properties | **map<string,string>**<br>A set of properties passed to Managed Service for Apache Kafka® with the connector configuration. Example: `sync.topics.config.enabled: true`. 
health | enum **Health**<br>Connector health. <ul><li>`HEALTH_UNKNOWN`: Health of the connector is unknown.</li><li>`ALIVE`: Connector is running.</li><li>`DEAD`: Connector has failed to start.</li></ul>
status | enum **Status**<br>Current status of the connector. <ul><li>`STATUS_UNKNOWN`: Connector state is unknown.</li><li>`RUNNING`: Connector is running normally.</li><li>`ERROR`: Connector has encountered a problem and cannot operate.</li><li>`PAUSED`: Connector is paused.</li></ul>
cluster_id | **string**<br>ID of the Apache Kafka® cluster that the connector belongs to. 
connector_config | **oneof:** `connector_config_mirrormaker` or `connector_config_s3_sink`<br>Additional settings for the connector.
&nbsp;&nbsp;connector_config_mirrormaker | **[ConnectorConfigMirrorMaker](#ConnectorConfigMirrorMaker3)**<br>Configuration of the MirrorMaker connector. 
&nbsp;&nbsp;connector_config_s3_sink | **[ConnectorConfigS3Sink](#ConnectorConfigS3Sink3)**<br>Additional settings for the connector. 


### ConnectorConfigMirrorMaker {#ConnectorConfigMirrorMaker3}

Field | Description
--- | ---
source_cluster | **[ClusterConnection](#ClusterConnection3)**<br>Source cluster connection configuration. 
target_cluster | **[ClusterConnection](#ClusterConnection3)**<br>Target cluster connection configuration. 
topics | **string**<br>List of Kafka topics, separated by `,`. 
replication_factor | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Replication factor for automatically created topics. 


### ClusterConnection {#ClusterConnection3}

Field | Description
--- | ---
alias | **string**<br>Alias of cluster connection configuration. Examples: `source`, `target`. 
cluster_connection | **oneof:** `this_cluster` or `external_cluster`<br>Type of connection to Apache Kafka® cluster.
&nbsp;&nbsp;this_cluster | **[ThisCluster](#ThisCluster3)**<br>Connection configuration of the cluster the connector belongs to. As all credentials are already known, leave this parameter empty. 
&nbsp;&nbsp;external_cluster | **[ExternalClusterConnection](#ExternalClusterConnection3)**<br>Configuration of connection to an external cluster with all the necessary credentials. 


### ThisCluster {#ThisCluster3}



### ExternalClusterConnection {#ExternalClusterConnection3}

Field | Description
--- | ---
bootstrap_servers | **string**<br>List of bootstrap servers of the cluster, separated by `,`. 
sasl_username | **string**<br>SASL username to use for connection to the cluster. 
sasl_mechanism | **string**<br>SASL mechanism to use for connection to the cluster. 
security_protocol | **string**<br>Security protocol to use for connection to the cluster. 


### ConnectorConfigS3Sink {#ConnectorConfigS3Sink3}

Field | Description
--- | ---
topics | **string**<br>List of Kafka topics, separated by ',' 
file_compression_type | **string**<br>The compression type used for files put on GCS. The supported values are: `gzip`, `snappy`, `zstd`, `none`. Optional, the default is `none`. 
file_max_records | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Max records per file. 
s3_connection | **[S3Connection](#S3Connection3)**<br>Credentials for connecting to S3 storage 


### S3Connection {#S3Connection3}

Field | Description
--- | ---
bucket_name | **string**<br> 
storage | **oneof:** `external_s3`<br>
&nbsp;&nbsp;external_s3 | **[ExternalS3Storage](#ExternalS3Storage3)**<br> 


### ExternalS3Storage {#ExternalS3Storage3}

Field | Description
--- | ---
access_key_id | **string**<br> 
endpoint | **string**<br> 
region | **string**<br>Default is 'us-east-1' 


## Delete {#Delete}

Deletes an Apache Kafka® connector.

**rpc Delete ([DeleteConnectorRequest](#DeleteConnectorRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteConnectorMetadata](#DeleteConnectorMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteConnectorRequest {#DeleteConnectorRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Apache Kafka® cluster to delete the connector from. <br>To get this ID, make a [ClusterService.List](./cluster_service#List) request. The maximum string length in characters is 50.
connector_name | **string**<br>Required. Name of the connector to delete. <br>To get this name, make a [ConnectorService.List](#List) request. The maximum string length in characters is 256. Value must match the regular expression ` [a-zA-Z0-9_-]* `.


### Operation {#Operation2}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteConnectorMetadata](#DeleteConnectorMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### DeleteConnectorMetadata {#DeleteConnectorMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>ID of the Apache Kafka® cluster the connector is being deleted from. 
connector_name | **string**<br>Name of the Apache Kafka® connector that is being deleted. 


## Resume {#Resume}

Resumes an Apache Kafka® connector.

**rpc Resume ([ResumeConnectorRequest](#ResumeConnectorRequest)) returns ([operation.Operation](#Operation3))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[ResumeConnectorMetadata](#ResumeConnectorMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Connector](#Connector4)<br>

### ResumeConnectorRequest {#ResumeConnectorRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Apache Kafka® cluster to resume the connector in. <br>To get this ID, make a [ClusterService.List](./cluster_service#List) request. The maximum string length in characters is 50.
connector_name | **string**<br>Required. Name of the Apache Kafka® connector to resume. <br>To get this name, make a [ConnectorService.List](#List) request. The maximum string length in characters is 256. Value must match the regular expression ` [a-zA-Z0-9_-]* `.


### Operation {#Operation3}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[ResumeConnectorMetadata](#ResumeConnectorMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Connector](#Connector4)>**<br>if operation finished successfully. 


### ResumeConnectorMetadata {#ResumeConnectorMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>ID of the Apache Kafka® cluster the connector is being resumed in. 
connector_name | **string**<br>Required. Name of the Apache Kafka® connector that is beign resumed. The maximum string length in characters is 256. Value must match the regular expression ` [a-zA-Z0-9_-]* `.


### Connector {#Connector4}

Field | Description
--- | ---
name | **string**<br>Name of the connector. 
tasks_max | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of connector tasks. Default value is the number of brokers. 
properties | **map<string,string>**<br>A set of properties passed to Managed Service for Apache Kafka® with the connector configuration. Example: `sync.topics.config.enabled: true`. 
health | enum **Health**<br>Connector health. <ul><li>`HEALTH_UNKNOWN`: Health of the connector is unknown.</li><li>`ALIVE`: Connector is running.</li><li>`DEAD`: Connector has failed to start.</li></ul>
status | enum **Status**<br>Current status of the connector. <ul><li>`STATUS_UNKNOWN`: Connector state is unknown.</li><li>`RUNNING`: Connector is running normally.</li><li>`ERROR`: Connector has encountered a problem and cannot operate.</li><li>`PAUSED`: Connector is paused.</li></ul>
cluster_id | **string**<br>ID of the Apache Kafka® cluster that the connector belongs to. 
connector_config | **oneof:** `connector_config_mirrormaker` or `connector_config_s3_sink`<br>Additional settings for the connector.
&nbsp;&nbsp;connector_config_mirrormaker | **[ConnectorConfigMirrorMaker](#ConnectorConfigMirrorMaker4)**<br>Configuration of the MirrorMaker connector. 
&nbsp;&nbsp;connector_config_s3_sink | **[ConnectorConfigS3Sink](#ConnectorConfigS3Sink4)**<br>Additional settings for the connector. 


### ConnectorConfigMirrorMaker {#ConnectorConfigMirrorMaker4}

Field | Description
--- | ---
source_cluster | **[ClusterConnection](#ClusterConnection4)**<br>Source cluster connection configuration. 
target_cluster | **[ClusterConnection](#ClusterConnection4)**<br>Target cluster connection configuration. 
topics | **string**<br>List of Kafka topics, separated by `,`. 
replication_factor | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Replication factor for automatically created topics. 


### ClusterConnection {#ClusterConnection4}

Field | Description
--- | ---
alias | **string**<br>Alias of cluster connection configuration. Examples: `source`, `target`. 
cluster_connection | **oneof:** `this_cluster` or `external_cluster`<br>Type of connection to Apache Kafka® cluster.
&nbsp;&nbsp;this_cluster | **[ThisCluster](#ThisCluster4)**<br>Connection configuration of the cluster the connector belongs to. As all credentials are already known, leave this parameter empty. 
&nbsp;&nbsp;external_cluster | **[ExternalClusterConnection](#ExternalClusterConnection4)**<br>Configuration of connection to an external cluster with all the necessary credentials. 


### ThisCluster {#ThisCluster4}



### ExternalClusterConnection {#ExternalClusterConnection4}

Field | Description
--- | ---
bootstrap_servers | **string**<br>List of bootstrap servers of the cluster, separated by `,`. 
sasl_username | **string**<br>SASL username to use for connection to the cluster. 
sasl_mechanism | **string**<br>SASL mechanism to use for connection to the cluster. 
security_protocol | **string**<br>Security protocol to use for connection to the cluster. 


### ConnectorConfigS3Sink {#ConnectorConfigS3Sink4}

Field | Description
--- | ---
topics | **string**<br>List of Kafka topics, separated by ',' 
file_compression_type | **string**<br>The compression type used for files put on GCS. The supported values are: `gzip`, `snappy`, `zstd`, `none`. Optional, the default is `none`. 
file_max_records | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Max records per file. 
s3_connection | **[S3Connection](#S3Connection4)**<br>Credentials for connecting to S3 storage 


### S3Connection {#S3Connection4}

Field | Description
--- | ---
bucket_name | **string**<br> 
storage | **oneof:** `external_s3`<br>
&nbsp;&nbsp;external_s3 | **[ExternalS3Storage](#ExternalS3Storage4)**<br> 


### ExternalS3Storage {#ExternalS3Storage4}

Field | Description
--- | ---
access_key_id | **string**<br> 
endpoint | **string**<br> 
region | **string**<br>Default is 'us-east-1' 


## Pause {#Pause}

Pauses an Apache Kafka® connector.

**rpc Pause ([PauseConnectorRequest](#PauseConnectorRequest)) returns ([operation.Operation](#Operation4))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[PauseConnectorMetadata](#PauseConnectorMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Connector](#Connector5)<br>

### PauseConnectorRequest {#PauseConnectorRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Apache Kafka® cluster to pause the connector in. <br>To get this ID, make a [ClusterService.List](./cluster_service#List) request. The maximum string length in characters is 50.
connector_name | **string**<br>Required. Name of the Apache Kafka® connector to pause. <br>To get this name, make a [ConnectorService.List](#List) request. The maximum string length in characters is 256. Value must match the regular expression ` [a-zA-Z0-9_-]* `.


### Operation {#Operation4}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[PauseConnectorMetadata](#PauseConnectorMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Connector](#Connector5)>**<br>if operation finished successfully. 


### PauseConnectorMetadata {#PauseConnectorMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>ID of the Apache Kafka® cluster the connector is being paused in. 
connector_name | **string**<br>Required. Name of the Apache Kafka® connector that is being paused. The maximum string length in characters is 256. Value must match the regular expression ` [a-zA-Z0-9_-]* `.


### Connector {#Connector5}

Field | Description
--- | ---
name | **string**<br>Name of the connector. 
tasks_max | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of connector tasks. Default value is the number of brokers. 
properties | **map<string,string>**<br>A set of properties passed to Managed Service for Apache Kafka® with the connector configuration. Example: `sync.topics.config.enabled: true`. 
health | enum **Health**<br>Connector health. <ul><li>`HEALTH_UNKNOWN`: Health of the connector is unknown.</li><li>`ALIVE`: Connector is running.</li><li>`DEAD`: Connector has failed to start.</li></ul>
status | enum **Status**<br>Current status of the connector. <ul><li>`STATUS_UNKNOWN`: Connector state is unknown.</li><li>`RUNNING`: Connector is running normally.</li><li>`ERROR`: Connector has encountered a problem and cannot operate.</li><li>`PAUSED`: Connector is paused.</li></ul>
cluster_id | **string**<br>ID of the Apache Kafka® cluster that the connector belongs to. 
connector_config | **oneof:** `connector_config_mirrormaker` or `connector_config_s3_sink`<br>Additional settings for the connector.
&nbsp;&nbsp;connector_config_mirrormaker | **[ConnectorConfigMirrorMaker](#ConnectorConfigMirrorMaker5)**<br>Configuration of the MirrorMaker connector. 
&nbsp;&nbsp;connector_config_s3_sink | **[ConnectorConfigS3Sink](#ConnectorConfigS3Sink5)**<br>Additional settings for the connector. 


### ConnectorConfigMirrorMaker {#ConnectorConfigMirrorMaker5}

Field | Description
--- | ---
source_cluster | **[ClusterConnection](#ClusterConnection5)**<br>Source cluster connection configuration. 
target_cluster | **[ClusterConnection](#ClusterConnection5)**<br>Target cluster connection configuration. 
topics | **string**<br>List of Kafka topics, separated by `,`. 
replication_factor | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Replication factor for automatically created topics. 


### ClusterConnection {#ClusterConnection5}

Field | Description
--- | ---
alias | **string**<br>Alias of cluster connection configuration. Examples: `source`, `target`. 
cluster_connection | **oneof:** `this_cluster` or `external_cluster`<br>Type of connection to Apache Kafka® cluster.
&nbsp;&nbsp;this_cluster | **[ThisCluster](#ThisCluster5)**<br>Connection configuration of the cluster the connector belongs to. As all credentials are already known, leave this parameter empty. 
&nbsp;&nbsp;external_cluster | **[ExternalClusterConnection](#ExternalClusterConnection5)**<br>Configuration of connection to an external cluster with all the necessary credentials. 


### ThisCluster {#ThisCluster5}



### ExternalClusterConnection {#ExternalClusterConnection5}

Field | Description
--- | ---
bootstrap_servers | **string**<br>List of bootstrap servers of the cluster, separated by `,`. 
sasl_username | **string**<br>SASL username to use for connection to the cluster. 
sasl_mechanism | **string**<br>SASL mechanism to use for connection to the cluster. 
security_protocol | **string**<br>Security protocol to use for connection to the cluster. 


### ConnectorConfigS3Sink {#ConnectorConfigS3Sink5}

Field | Description
--- | ---
topics | **string**<br>List of Kafka topics, separated by ',' 
file_compression_type | **string**<br>The compression type used for files put on GCS. The supported values are: `gzip`, `snappy`, `zstd`, `none`. Optional, the default is `none`. 
file_max_records | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Max records per file. 
s3_connection | **[S3Connection](#S3Connection5)**<br>Credentials for connecting to S3 storage 


### S3Connection {#S3Connection5}

Field | Description
--- | ---
bucket_name | **string**<br> 
storage | **oneof:** `external_s3`<br>
&nbsp;&nbsp;external_s3 | **[ExternalS3Storage](#ExternalS3Storage5)**<br> 


### ExternalS3Storage {#ExternalS3Storage5}

Field | Description
--- | ---
access_key_id | **string**<br> 
endpoint | **string**<br> 
region | **string**<br>Default is 'us-east-1' 


