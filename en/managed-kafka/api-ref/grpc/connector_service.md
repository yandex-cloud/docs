---
editable: false
sourcePath: en/_api-ref-grpc/managed-kafka/api-ref/grpc/connector_service.md
---


# ConnectorService

A set of methods for managing Apache Kafka Connectors resources.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specified Apache Kafka Connector resource. |
| [List](#List) | Retrieves the list of Apache Kafka Connector resources in the specified cluster. |
| [Create](#Create) | Creates a new Apache Kafka connector in the specified cluster. |
| [Update](#Update) | Updates an Apache Kafka connector in the specified cluster. |
| [Delete](#Delete) | Deletes the specified Apache Kafka connector. |
| [Resume](#Resume) | Resume the specified Apache Kafka connector. |
| [Pause](#Pause) | Pause the specified Apache Kafka connector. |

## Calls ConnectorService {#calls}

## Get {#Get}

Returns the specified Apache Kafka Connector resource. <br>To get the list of available Apache Kafka Connector resources, make a [List](#List) request.

**rpc Get ([GetConnectorRequest](#GetConnectorRequest)) returns ([Connector](#Connector))**

### GetConnectorRequest {#GetConnectorRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Apache Kafka Cluster resource to return. To get the cluster ID use a [ClusterService.List](./cluster_service#List) request. The maximum string length in characters is 50.
connector_name | **string**<br>Required. Name of the Apache Kafka Connector resource to return. To get the name of the connector use a [ConnectorService.List](#List) request. The maximum string length in characters is 256. Value must match the regular expression ` [a-zA-Z0-9_-]* `.


### Connector {#Connector}

Field | Description
--- | ---
name | **string**<br>Name of the connector. 
tasks_max | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of tasks. Default is the number of brokers 
properties | **map<string,string>**<br>Properties passed with connector config to Connect service Example: 'sync.topics.config.enabled: true' 
health | enum **Health**<br>Connector health. <ul><li>`HEALTH_UNKNOWN`: State of the connector is unknown.</li><li>`ALIVE`: Connector is running.</li><li>`DEAD`: Connector is failed to start.</li><ul/>
status | enum **Status**<br>Current status of the connector. <ul><li>`STATUS_UNKNOWN`: Connector state is unknown.</li><li>`RUNNING`: Connector is running normally.</li><li>`ERROR`: Connector encountered a problem and cannot operate.</li><li>`PAUSED`: Connector paused.</li><ul/>
cluster_id | **string**<br>ID of the Apache Kafka cluster that the connector belongs to. 
connector_config | **oneof:** `connector_config_mirrormaker`<br>Additional settings for specific connector. For example, of MirrorMaker.
&nbsp;&nbsp;connector_config_mirrormaker | **[ConnectorConfigMirrorMaker](#ConnectorConfigMirrorMaker)**<br>Additional settings for specific connector. For example, of MirrorMaker. 


### ConnectorConfigMirrorMaker {#ConnectorConfigMirrorMaker}

Field | Description
--- | ---
source_cluster | **[ClusterConnection](#ClusterConnection)**<br>Source cluster resource settings. 
target_cluster | **[ClusterConnection](#ClusterConnection)**<br>Target cluster resource settings. 
topics | **string**<br>List of Kafka topics, separated by ',' 
replication_factor | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Replication factor for automatically created topics. 


### ClusterConnection {#ClusterConnection}

Field | Description
--- | ---
alias | **string**<br>Alias of ClusterConnection resource. For example: 'source', 'target', ... 
cluster_connection | **oneof:** `this_cluster` or `external_cluster`<br>Type of connection to Kafka cluster.
&nbsp;&nbsp;this_cluster | **[ThisCluster](#ThisCluster)**<br>If type is 'this_cluster' - we connect to cluster that is handle Kafka Connect Worker, on which we try to register connector. 
&nbsp;&nbsp;external_cluster | **[ExternalClusterConnection](#ExternalClusterConnection)**<br>If type is 'external_cluster' - we connect to cluster that is not handle Kafka Connect Worker, on which we try to register connector. 


### ThisCluster {#ThisCluster}



### ExternalClusterConnection {#ExternalClusterConnection}

Field | Description
--- | ---
bootstrap_servers | **string**<br>List bootstrap servers of cluster, separated by ',' 
sasl_username | **string**<br>Sasl username which we use to connect to cluster. 
sasl_mechanism | **string**<br>Sasl mechanism, which we should use to connect to cluster. 
security_protocol | **string**<br>Security protocol, which we should use to connect to cluster. 


## List {#List}

Retrieves the list of Apache Kafka Connector resources in the specified cluster.

**rpc List ([ListConnectorsRequest](#ListConnectorsRequest)) returns ([ListConnectorsResponse](#ListConnectorsResponse))**

### ListConnectorsRequest {#ListConnectorsRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Apache Kafka cluster to list connectors in. To get the cluster ID use a [ClusterService.List](./cluster_service#List) request. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListConnectorsResponse.next_page_token](#ListConnectorsResponse) that can be used to get the next page of results in subsequent list requests. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, Set `page_token` to the [ListConnectorsResponse.next_page_token](#ListConnectorsResponse) returned by a previous list request. The maximum string length in characters is 100.


### ListConnectorsResponse {#ListConnectorsResponse}

Field | Description
--- | ---
connectors[] | **[Connector](#Connector1)**<br>List of Apache Kafka Connector resources. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListConnectorsRequest.page_size](#ListConnectorsRequest), use the `next_page_token` as the value for the [ListConnectorsRequest.page_token](#ListConnectorsRequest) parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### Connector {#Connector1}

Field | Description
--- | ---
name | **string**<br>Name of the connector. 
tasks_max | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of tasks. Default is the number of brokers 
properties | **map<string,string>**<br>Properties passed with connector config to Connect service Example: 'sync.topics.config.enabled: true' 
health | enum **Health**<br>Connector health. <ul><li>`HEALTH_UNKNOWN`: State of the connector is unknown.</li><li>`ALIVE`: Connector is running.</li><li>`DEAD`: Connector is failed to start.</li><ul/>
status | enum **Status**<br>Current status of the connector. <ul><li>`STATUS_UNKNOWN`: Connector state is unknown.</li><li>`RUNNING`: Connector is running normally.</li><li>`ERROR`: Connector encountered a problem and cannot operate.</li><li>`PAUSED`: Connector paused.</li><ul/>
cluster_id | **string**<br>ID of the Apache Kafka cluster that the connector belongs to. 
connector_config | **oneof:** `connector_config_mirrormaker`<br>Additional settings for specific connector. For example, of MirrorMaker.
&nbsp;&nbsp;connector_config_mirrormaker | **[ConnectorConfigMirrorMaker](#ConnectorConfigMirrorMaker1)**<br>Additional settings for specific connector. For example, of MirrorMaker. 


### ConnectorConfigMirrorMaker {#ConnectorConfigMirrorMaker1}

Field | Description
--- | ---
source_cluster | **[ClusterConnection](#ClusterConnection1)**<br>Source cluster resource settings. 
target_cluster | **[ClusterConnection](#ClusterConnection1)**<br>Target cluster resource settings. 
topics | **string**<br>List of Kafka topics, separated by ',' 
replication_factor | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Replication factor for automatically created topics. 


### ClusterConnection {#ClusterConnection1}

Field | Description
--- | ---
alias | **string**<br>Alias of ClusterConnection resource. For example: 'source', 'target', ... 
cluster_connection | **oneof:** `this_cluster` or `external_cluster`<br>Type of connection to Kafka cluster.
&nbsp;&nbsp;this_cluster | **[ThisCluster](#ThisCluster1)**<br>If type is 'this_cluster' - we connect to cluster that is handle Kafka Connect Worker, on which we try to register connector. 
&nbsp;&nbsp;external_cluster | **[ExternalClusterConnection](#ExternalClusterConnection1)**<br>If type is 'external_cluster' - we connect to cluster that is not handle Kafka Connect Worker, on which we try to register connector. 


### ThisCluster {#ThisCluster1}



### ExternalClusterConnection {#ExternalClusterConnection1}

Field | Description
--- | ---
bootstrap_servers | **string**<br>List bootstrap servers of cluster, separated by ',' 
sasl_username | **string**<br>Sasl username which we use to connect to cluster. 
sasl_mechanism | **string**<br>Sasl mechanism, which we should use to connect to cluster. 
security_protocol | **string**<br>Security protocol, which we should use to connect to cluster. 


## Create {#Create}

Creates a new Apache Kafka connector in the specified cluster.

**rpc Create ([CreateConnectorRequest](#CreateConnectorRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateConnectorMetadata](#CreateConnectorMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Connector](#Connector2)<br>

### CreateConnectorRequest {#CreateConnectorRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. Required. ID of the Apache Kafka cluster to create a connector in. To get the cluster ID use a [ClusterService.List](./cluster_service#List) request. The maximum string length in characters is 50.
connector_spec | **[ConnectorSpec](#ConnectorSpec)**<br>Required. Required. Configuration of the connector to create. 


### ConnectorSpec {#ConnectorSpec}

Field | Description
--- | ---
name | **string**<br>Name of the connector. 
tasks_max | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of connector tasks. Default is the number of brokers. 
properties | **map<string,string>**<br>Properties passed with connector config to Connect service. Example: 'sync.topics.config.enabled: true'. 
connector_config | **oneof:** `connector_config_mirrormaker`<br>Additional settings for specific connector. For example, of MirrorMaker.
&nbsp;&nbsp;connector_config_mirrormaker | **[ConnectorConfigMirrorMakerSpec](#ConnectorConfigMirrorMakerSpec)**<br>Configuration of MirrorMaker connector 


### ConnectorConfigMirrorMakerSpec {#ConnectorConfigMirrorMakerSpec}

Field | Description
--- | ---
source_cluster | **[ClusterConnectionSpec](#ClusterConnectionSpec)**<br>Source cluster configuration. 
target_cluster | **[ClusterConnectionSpec](#ClusterConnectionSpec)**<br>Target cluster configuration. 
topics | **string**<br>List of Kafka topics, separated by ',' 
replication_factor | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Replication factor for automatically created topics. 


### ClusterConnectionSpec {#ClusterConnectionSpec}

Field | Description
--- | ---
alias | **string**<br>Alias of ClusterConnection. For example: 'source', 'target', ... 
cluster_connection | **oneof:** `this_cluster` or `external_cluster`<br>Type of connection to Kafka cluster.
&nbsp;&nbsp;this_cluster | **[ThisClusterSpec](#ThisClusterSpec)**<br>If type is 'this_cluster' - we connect to cluster that is handle Kafka Connect Worker, on which we try to register connector. 
&nbsp;&nbsp;external_cluster | **[ExternalClusterConnectionSpec](#ExternalClusterConnectionSpec)**<br>If type is 'external_cluster' - we connect to cluster that is not handle Kafka Connect Worker, on which we try to register connector. 


### ThisClusterSpec {#ThisClusterSpec}



### ExternalClusterConnectionSpec {#ExternalClusterConnectionSpec}

Field | Description
--- | ---
bootstrap_servers | **string**<br>List bootstrap servers of cluster, separated by ','. 
sasl_username | **string**<br>Sasl username which we use to connect to cluster. 
sasl_password | **string**<br>Sasl password which we use to connect to cluster. 
sasl_mechanism | **string**<br>Sasl mechanism, which we should use to connect to cluster. 
security_protocol | **string**<br>Security protocol, which we should use to connect to cluster. 


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
cluster_id | **string**<br>ID of the Apache Kafka cluster where a connector is being created. 
connector_name | **string**<br>Required. Name of the Apache Kafka connector that is being created. The maximum string length in characters is 256. Value must match the regular expression ` [a-zA-Z0-9_-]* `.


### Connector {#Connector2}

Field | Description
--- | ---
name | **string**<br>Name of the connector. 
tasks_max | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of tasks. Default is the number of brokers 
properties | **map<string,string>**<br>Properties passed with connector config to Connect service Example: 'sync.topics.config.enabled: true' 
health | enum **Health**<br>Connector health. <ul><li>`HEALTH_UNKNOWN`: State of the connector is unknown.</li><li>`ALIVE`: Connector is running.</li><li>`DEAD`: Connector is failed to start.</li><ul/>
status | enum **Status**<br>Current status of the connector. <ul><li>`STATUS_UNKNOWN`: Connector state is unknown.</li><li>`RUNNING`: Connector is running normally.</li><li>`ERROR`: Connector encountered a problem and cannot operate.</li><li>`PAUSED`: Connector paused.</li><ul/>
cluster_id | **string**<br>ID of the Apache Kafka cluster that the connector belongs to. 
connector_config | **oneof:** `connector_config_mirrormaker`<br>Additional settings for specific connector. For example, of MirrorMaker.
&nbsp;&nbsp;connector_config_mirrormaker | **[ConnectorConfigMirrorMaker](#ConnectorConfigMirrorMaker2)**<br>Additional settings for specific connector. For example, of MirrorMaker. 


### ConnectorConfigMirrorMaker {#ConnectorConfigMirrorMaker2}

Field | Description
--- | ---
source_cluster | **[ClusterConnection](#ClusterConnection2)**<br>Source cluster resource settings. 
target_cluster | **[ClusterConnection](#ClusterConnection2)**<br>Target cluster resource settings. 
topics | **string**<br>List of Kafka topics, separated by ',' 
replication_factor | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Replication factor for automatically created topics. 


### ClusterConnection {#ClusterConnection2}

Field | Description
--- | ---
alias | **string**<br>Alias of ClusterConnection resource. For example: 'source', 'target', ... 
cluster_connection | **oneof:** `this_cluster` or `external_cluster`<br>Type of connection to Kafka cluster.
&nbsp;&nbsp;this_cluster | **[ThisCluster](#ThisCluster2)**<br>If type is 'this_cluster' - we connect to cluster that is handle Kafka Connect Worker, on which we try to register connector. 
&nbsp;&nbsp;external_cluster | **[ExternalClusterConnection](#ExternalClusterConnection2)**<br>If type is 'external_cluster' - we connect to cluster that is not handle Kafka Connect Worker, on which we try to register connector. 


### ThisCluster {#ThisCluster2}



### ExternalClusterConnection {#ExternalClusterConnection2}

Field | Description
--- | ---
bootstrap_servers | **string**<br>List bootstrap servers of cluster, separated by ',' 
sasl_username | **string**<br>Sasl username which we use to connect to cluster. 
sasl_mechanism | **string**<br>Sasl mechanism, which we should use to connect to cluster. 
security_protocol | **string**<br>Security protocol, which we should use to connect to cluster. 


## Update {#Update}

Updates an Apache Kafka connector in the specified cluster.

**rpc Update ([UpdateConnectorRequest](#UpdateConnectorRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateConnectorMetadata](#UpdateConnectorMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Connector](#Connector3)<br>

### UpdateConnectorRequest {#UpdateConnectorRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. Required. ID of the Apache Kafka cluster to update a connector in. To get the cluster ID use a [ClusterService.List](./cluster_service#List) request. The maximum string length in characters is 50.
connector_name | **string**<br>Required. Required. Name of the connector to update. To get the name of the connector, use a [ConnectorService.List](#List) request. The maximum string length in characters is 256. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Field mask that specifies which fields of the Connector resource should be updated. 
connector_spec | **[UpdateConnectorSpec](#UpdateConnectorSpec)**<br>Required. Required. Configuration of the connector to update. 


### UpdateConnectorSpec {#UpdateConnectorSpec}

Field | Description
--- | ---
tasks_max | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of tasks to update. 
properties | **map<string,string>**<br>Properties passed with connector config to Connect service, that we should change or add in existing Properties-set of connector. Example: 'sync.topics.config.enabled: false' 
connector_config | **oneof:** `connector_config_mirrormaker`<br>Update specification for specific connector (for example, MirrorMaker).
&nbsp;&nbsp;connector_config_mirrormaker | **[ConnectorConfigMirrorMakerSpec](#ConnectorConfigMirrorMakerSpec1)**<br>Update specification for MirrorMaker. 


### ConnectorConfigMirrorMakerSpec {#ConnectorConfigMirrorMakerSpec1}

Field | Description
--- | ---
source_cluster | **[ClusterConnectionSpec](#ClusterConnectionSpec1)**<br>Source cluster configuration. 
target_cluster | **[ClusterConnectionSpec](#ClusterConnectionSpec1)**<br>Target cluster configuration. 
topics | **string**<br>List of Kafka topics, separated by ',' 
replication_factor | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Replication factor for automatically created topics. 


### ClusterConnectionSpec {#ClusterConnectionSpec1}

Field | Description
--- | ---
alias | **string**<br>Alias of ClusterConnection. For example: 'source', 'target', ... 
cluster_connection | **oneof:** `this_cluster` or `external_cluster`<br>Type of connection to Kafka cluster.
&nbsp;&nbsp;this_cluster | **[ThisClusterSpec](#ThisClusterSpec1)**<br>If type is 'this_cluster' - we connect to cluster that is handle Kafka Connect Worker, on which we try to register connector. 
&nbsp;&nbsp;external_cluster | **[ExternalClusterConnectionSpec](#ExternalClusterConnectionSpec1)**<br>If type is 'external_cluster' - we connect to cluster that is not handle Kafka Connect Worker, on which we try to register connector. 


### ThisClusterSpec {#ThisClusterSpec1}



### ExternalClusterConnectionSpec {#ExternalClusterConnectionSpec1}

Field | Description
--- | ---
bootstrap_servers | **string**<br>List bootstrap servers of cluster, separated by ','. 
sasl_username | **string**<br>Sasl username which we use to connect to cluster. 
sasl_password | **string**<br>Sasl password which we use to connect to cluster. 
sasl_mechanism | **string**<br>Sasl mechanism, which we should use to connect to cluster. 
security_protocol | **string**<br>Security protocol, which we should use to connect to cluster. 


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
cluster_id | **string**<br>Required. ID of the Apache Kafka cluster where a connector is being updated. The maximum string length in characters is 50.
connector_name | **string**<br>Required. Name of the Apache Kafka connector that is being updated. The maximum string length in characters is 256. Value must match the regular expression ` [a-zA-Z0-9_-]* `.


### Connector {#Connector3}

Field | Description
--- | ---
name | **string**<br>Name of the connector. 
tasks_max | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of tasks. Default is the number of brokers 
properties | **map<string,string>**<br>Properties passed with connector config to Connect service Example: 'sync.topics.config.enabled: true' 
health | enum **Health**<br>Connector health. <ul><li>`HEALTH_UNKNOWN`: State of the connector is unknown.</li><li>`ALIVE`: Connector is running.</li><li>`DEAD`: Connector is failed to start.</li><ul/>
status | enum **Status**<br>Current status of the connector. <ul><li>`STATUS_UNKNOWN`: Connector state is unknown.</li><li>`RUNNING`: Connector is running normally.</li><li>`ERROR`: Connector encountered a problem and cannot operate.</li><li>`PAUSED`: Connector paused.</li><ul/>
cluster_id | **string**<br>ID of the Apache Kafka cluster that the connector belongs to. 
connector_config | **oneof:** `connector_config_mirrormaker`<br>Additional settings for specific connector. For example, of MirrorMaker.
&nbsp;&nbsp;connector_config_mirrormaker | **[ConnectorConfigMirrorMaker](#ConnectorConfigMirrorMaker3)**<br>Additional settings for specific connector. For example, of MirrorMaker. 


### ConnectorConfigMirrorMaker {#ConnectorConfigMirrorMaker3}

Field | Description
--- | ---
source_cluster | **[ClusterConnection](#ClusterConnection3)**<br>Source cluster resource settings. 
target_cluster | **[ClusterConnection](#ClusterConnection3)**<br>Target cluster resource settings. 
topics | **string**<br>List of Kafka topics, separated by ',' 
replication_factor | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Replication factor for automatically created topics. 


### ClusterConnection {#ClusterConnection3}

Field | Description
--- | ---
alias | **string**<br>Alias of ClusterConnection resource. For example: 'source', 'target', ... 
cluster_connection | **oneof:** `this_cluster` or `external_cluster`<br>Type of connection to Kafka cluster.
&nbsp;&nbsp;this_cluster | **[ThisCluster](#ThisCluster3)**<br>If type is 'this_cluster' - we connect to cluster that is handle Kafka Connect Worker, on which we try to register connector. 
&nbsp;&nbsp;external_cluster | **[ExternalClusterConnection](#ExternalClusterConnection3)**<br>If type is 'external_cluster' - we connect to cluster that is not handle Kafka Connect Worker, on which we try to register connector. 


### ThisCluster {#ThisCluster3}



### ExternalClusterConnection {#ExternalClusterConnection3}

Field | Description
--- | ---
bootstrap_servers | **string**<br>List bootstrap servers of cluster, separated by ',' 
sasl_username | **string**<br>Sasl username which we use to connect to cluster. 
sasl_mechanism | **string**<br>Sasl mechanism, which we should use to connect to cluster. 
security_protocol | **string**<br>Security protocol, which we should use to connect to cluster. 


## Delete {#Delete}

Deletes the specified Apache Kafka connector.

**rpc Delete ([DeleteConnectorRequest](#DeleteConnectorRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteConnectorMetadata](#DeleteConnectorMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteConnectorRequest {#DeleteConnectorRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. Required. ID of the Apache Kafka cluster to delete a connector in. To get the cluster ID, use a [ClusterService.List](./cluster_service#List) request. The maximum string length in characters is 50.
connector_name | **string**<br>Required. Required. Name of the connector to delete. To get the name of the connector, use a [ConnectorService.List](#List) request. The maximum string length in characters is 256. Value must match the regular expression ` [a-zA-Z0-9_-]* `.


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
cluster_id | **string**<br>ID of the Apache Kafka cluster where a connector is being deleted. 
connector_name | **string**<br>Name of the Apache Kafka connector that is being deleted. 


## Resume {#Resume}

Resume the specified Apache Kafka connector.

**rpc Resume ([ResumeConnectorRequest](#ResumeConnectorRequest)) returns ([operation.Operation](#Operation3))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[ResumeConnectorMetadata](#ResumeConnectorMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Connector](#Connector4)<br>

### ResumeConnectorRequest {#ResumeConnectorRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. Required. ID of the Apache Kafka cluster to resume connector in. The maximum string length in characters is 50.
connector_name | **string**<br>Required. Name of the Apache Kafka Connector resource to resume. To get the name of the connector use a [ConnectorService.List](#List) request. The maximum string length in characters is 256. Value must match the regular expression ` [a-zA-Z0-9_-]* `.


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
cluster_id | **string**<br>Required. ID of the Apache Kafka cluster. 
connector_name | **string**<br>Required. Name of the Apache Kafka Connector resource that is beign resumed. The maximum string length in characters is 256. Value must match the regular expression ` [a-zA-Z0-9_-]* `.


### Connector {#Connector4}

Field | Description
--- | ---
name | **string**<br>Name of the connector. 
tasks_max | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of tasks. Default is the number of brokers 
properties | **map<string,string>**<br>Properties passed with connector config to Connect service Example: 'sync.topics.config.enabled: true' 
health | enum **Health**<br>Connector health. <ul><li>`HEALTH_UNKNOWN`: State of the connector is unknown.</li><li>`ALIVE`: Connector is running.</li><li>`DEAD`: Connector is failed to start.</li><ul/>
status | enum **Status**<br>Current status of the connector. <ul><li>`STATUS_UNKNOWN`: Connector state is unknown.</li><li>`RUNNING`: Connector is running normally.</li><li>`ERROR`: Connector encountered a problem and cannot operate.</li><li>`PAUSED`: Connector paused.</li><ul/>
cluster_id | **string**<br>ID of the Apache Kafka cluster that the connector belongs to. 
connector_config | **oneof:** `connector_config_mirrormaker`<br>Additional settings for specific connector. For example, of MirrorMaker.
&nbsp;&nbsp;connector_config_mirrormaker | **[ConnectorConfigMirrorMaker](#ConnectorConfigMirrorMaker4)**<br>Additional settings for specific connector. For example, of MirrorMaker. 


### ConnectorConfigMirrorMaker {#ConnectorConfigMirrorMaker4}

Field | Description
--- | ---
source_cluster | **[ClusterConnection](#ClusterConnection4)**<br>Source cluster resource settings. 
target_cluster | **[ClusterConnection](#ClusterConnection4)**<br>Target cluster resource settings. 
topics | **string**<br>List of Kafka topics, separated by ',' 
replication_factor | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Replication factor for automatically created topics. 


### ClusterConnection {#ClusterConnection4}

Field | Description
--- | ---
alias | **string**<br>Alias of ClusterConnection resource. For example: 'source', 'target', ... 
cluster_connection | **oneof:** `this_cluster` or `external_cluster`<br>Type of connection to Kafka cluster.
&nbsp;&nbsp;this_cluster | **[ThisCluster](#ThisCluster4)**<br>If type is 'this_cluster' - we connect to cluster that is handle Kafka Connect Worker, on which we try to register connector. 
&nbsp;&nbsp;external_cluster | **[ExternalClusterConnection](#ExternalClusterConnection4)**<br>If type is 'external_cluster' - we connect to cluster that is not handle Kafka Connect Worker, on which we try to register connector. 


### ThisCluster {#ThisCluster4}



### ExternalClusterConnection {#ExternalClusterConnection4}

Field | Description
--- | ---
bootstrap_servers | **string**<br>List bootstrap servers of cluster, separated by ',' 
sasl_username | **string**<br>Sasl username which we use to connect to cluster. 
sasl_mechanism | **string**<br>Sasl mechanism, which we should use to connect to cluster. 
security_protocol | **string**<br>Security protocol, which we should use to connect to cluster. 


## Pause {#Pause}

Pause the specified Apache Kafka connector.

**rpc Pause ([PauseConnectorRequest](#PauseConnectorRequest)) returns ([operation.Operation](#Operation4))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[PauseConnectorMetadata](#PauseConnectorMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Connector](#Connector5)<br>

### PauseConnectorRequest {#PauseConnectorRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. Required. ID of the Apache Kafka cluster to pause connector in. The maximum string length in characters is 50.
connector_name | **string**<br>Required. Name of the Apache Kafka Connector resource to pause. To get the name of the connector use a [ConnectorService.List](#List) request. The maximum string length in characters is 256. Value must match the regular expression ` [a-zA-Z0-9_-]* `.


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
cluster_id | **string**<br>Required. ID of the Apache Kafka cluster. 
connector_name | **string**<br>Required. Name of the Apache Kafka Connector resource that is being paused. The maximum string length in characters is 256. Value must match the regular expression ` [a-zA-Z0-9_-]* `.


### Connector {#Connector5}

Field | Description
--- | ---
name | **string**<br>Name of the connector. 
tasks_max | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of tasks. Default is the number of brokers 
properties | **map<string,string>**<br>Properties passed with connector config to Connect service Example: 'sync.topics.config.enabled: true' 
health | enum **Health**<br>Connector health. <ul><li>`HEALTH_UNKNOWN`: State of the connector is unknown.</li><li>`ALIVE`: Connector is running.</li><li>`DEAD`: Connector is failed to start.</li><ul/>
status | enum **Status**<br>Current status of the connector. <ul><li>`STATUS_UNKNOWN`: Connector state is unknown.</li><li>`RUNNING`: Connector is running normally.</li><li>`ERROR`: Connector encountered a problem and cannot operate.</li><li>`PAUSED`: Connector paused.</li><ul/>
cluster_id | **string**<br>ID of the Apache Kafka cluster that the connector belongs to. 
connector_config | **oneof:** `connector_config_mirrormaker`<br>Additional settings for specific connector. For example, of MirrorMaker.
&nbsp;&nbsp;connector_config_mirrormaker | **[ConnectorConfigMirrorMaker](#ConnectorConfigMirrorMaker5)**<br>Additional settings for specific connector. For example, of MirrorMaker. 


### ConnectorConfigMirrorMaker {#ConnectorConfigMirrorMaker5}

Field | Description
--- | ---
source_cluster | **[ClusterConnection](#ClusterConnection5)**<br>Source cluster resource settings. 
target_cluster | **[ClusterConnection](#ClusterConnection5)**<br>Target cluster resource settings. 
topics | **string**<br>List of Kafka topics, separated by ',' 
replication_factor | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Replication factor for automatically created topics. 


### ClusterConnection {#ClusterConnection5}

Field | Description
--- | ---
alias | **string**<br>Alias of ClusterConnection resource. For example: 'source', 'target', ... 
cluster_connection | **oneof:** `this_cluster` or `external_cluster`<br>Type of connection to Kafka cluster.
&nbsp;&nbsp;this_cluster | **[ThisCluster](#ThisCluster5)**<br>If type is 'this_cluster' - we connect to cluster that is handle Kafka Connect Worker, on which we try to register connector. 
&nbsp;&nbsp;external_cluster | **[ExternalClusterConnection](#ExternalClusterConnection5)**<br>If type is 'external_cluster' - we connect to cluster that is not handle Kafka Connect Worker, on which we try to register connector. 


### ThisCluster {#ThisCluster5}



### ExternalClusterConnection {#ExternalClusterConnection5}

Field | Description
--- | ---
bootstrap_servers | **string**<br>List bootstrap servers of cluster, separated by ',' 
sasl_username | **string**<br>Sasl username which we use to connect to cluster. 
sasl_mechanism | **string**<br>Sasl mechanism, which we should use to connect to cluster. 
security_protocol | **string**<br>Security protocol, which we should use to connect to cluster. 


