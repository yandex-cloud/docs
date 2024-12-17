---
editable: false
sourcePath: en/_api-ref-grpc/mdb/kafka/v1/api-ref/grpc/Connector/resume.md
---

# Managed Service for Apache Kafka® API, gRPC: ConnectorService.Resume

Resumes an Apache Kafka® connector.

## gRPC request

**rpc Resume ([ResumeConnectorRequest](#yandex.cloud.mdb.kafka.v1.ResumeConnectorRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## ResumeConnectorRequest {#yandex.cloud.mdb.kafka.v1.ResumeConnectorRequest}

```json
{
  "cluster_id": "string",
  "connector_name": "string"
}
```

#|
||Field | Description ||
|| cluster_id | **string**

Required field. ID of the Apache Kafka® cluster to resume the connector in.

To get this ID, make a [ClusterService.List](/docs/managed-kafka/api-ref/grpc/Cluster/list#List) request. ||
|| connector_name | **string**

Required field. Name of the Apache Kafka® connector to resume.

To get this name, make a [ConnectorService.List](/docs/managed-kafka/api-ref/grpc/Connector/list#List) request. ||
|#

## operation.Operation {#yandex.cloud.operation.Operation}

```json
{
  "id": "string",
  "description": "string",
  "created_at": "google.protobuf.Timestamp",
  "created_by": "string",
  "modified_at": "google.protobuf.Timestamp",
  "done": "bool",
  "metadata": {
    "cluster_id": "string",
    "connector_name": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "name": "string",
    "tasks_max": "google.protobuf.Int64Value",
    "properties": "map<string, string>",
    "health": "Health",
    "status": "Status",
    "cluster_id": "string",
    // Includes only one of the fields `connector_config_mirrormaker`, `connector_config_s3_sink`
    "connector_config_mirrormaker": {
      "source_cluster": {
        "alias": "string",
        // Includes only one of the fields `this_cluster`, `external_cluster`
        "this_cluster": "ThisCluster",
        "external_cluster": {
          "bootstrap_servers": "string",
          "sasl_username": "string",
          "sasl_mechanism": "string",
          "security_protocol": "string"
        }
        // end of the list of possible fields
      },
      "target_cluster": {
        "alias": "string",
        // Includes only one of the fields `this_cluster`, `external_cluster`
        "this_cluster": "ThisCluster",
        "external_cluster": {
          "bootstrap_servers": "string",
          "sasl_username": "string",
          "sasl_mechanism": "string",
          "security_protocol": "string"
        }
        // end of the list of possible fields
      },
      "topics": "string",
      "replication_factor": "google.protobuf.Int64Value"
    },
    "connector_config_s3_sink": {
      "topics": "string",
      "file_compression_type": "string",
      "file_max_records": "google.protobuf.Int64Value",
      "s3_connection": {
        "bucket_name": "string",
        // Includes only one of the fields `external_s3`
        "external_s3": {
          "access_key_id": "string",
          "endpoint": "string",
          "region": "string"
        }
        // end of the list of possible fields
      }
    }
    // end of the list of possible fields
  }
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).

#|
||Field | Description ||
|| id | **string**

ID of the operation. ||
|| description | **string**

Description of the operation. 0-256 characters long. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| created_by | **string**

ID of the user or service account who initiated the operation. ||
|| modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[ResumeConnectorMetadata](#yandex.cloud.mdb.kafka.v1.ResumeConnectorMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **[Connector](#yandex.cloud.mdb.kafka.v1.Connector)**

The normal response of the operation in case of success.
If the original method returns no data on success, such as Delete,
the response is [google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty).
If the original method is the standard Create/Update,
the response should be the target resource of the operation.
Any method that returns a long-running operation should document the response type, if any.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|#

## ResumeConnectorMetadata {#yandex.cloud.mdb.kafka.v1.ResumeConnectorMetadata}

#|
||Field | Description ||
|| cluster_id | **string**

ID of the Apache Kafka® cluster the connector is being resumed in. ||
|| connector_name | **string**

Required field. Name of the Apache Kafka® connector that is beign resumed. ||
|#

## Connector {#yandex.cloud.mdb.kafka.v1.Connector}

#|
||Field | Description ||
|| name | **string**

Name of the connector. ||
|| tasks_max | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Maximum number of connector tasks. Default value is the number of brokers. ||
|| properties | **object** (map<**string**, **string**>)

A set of properties passed to Managed Service for Apache Kafka® with the connector configuration.
Example: `sync.topics.config.enabled: true`. ||
|| health | enum **Health**

Connector health.

- `HEALTH_UNKNOWN`: Health of the connector is unknown.
- `ALIVE`: Connector is running.
- `DEAD`: Connector has failed to start. ||
|| status | enum **Status**

Current status of the connector.

- `STATUS_UNKNOWN`: Connector state is unknown.
- `RUNNING`: Connector is running normally.
- `ERROR`: Connector has encountered a problem and cannot operate.
- `PAUSED`: Connector is paused. ||
|| cluster_id | **string**

ID of the Apache Kafka® cluster that the connector belongs to. ||
|| connector_config_mirrormaker | **[ConnectorConfigMirrorMaker](#yandex.cloud.mdb.kafka.v1.ConnectorConfigMirrorMaker)**

Configuration of the MirrorMaker connector.

Includes only one of the fields `connector_config_mirrormaker`, `connector_config_s3_sink`.

Additional settings for the connector. ||
|| connector_config_s3_sink | **[ConnectorConfigS3Sink](#yandex.cloud.mdb.kafka.v1.ConnectorConfigS3Sink)**

Configuration of S3-Sink connector.

Includes only one of the fields `connector_config_mirrormaker`, `connector_config_s3_sink`.

Additional settings for the connector. ||
|#

## ConnectorConfigMirrorMaker {#yandex.cloud.mdb.kafka.v1.ConnectorConfigMirrorMaker}

#|
||Field | Description ||
|| source_cluster | **[ClusterConnection](#yandex.cloud.mdb.kafka.v1.ClusterConnection)**

Source cluster connection configuration. ||
|| target_cluster | **[ClusterConnection](#yandex.cloud.mdb.kafka.v1.ClusterConnection)**

Target cluster connection configuration. ||
|| topics | **string**

List of Kafka topics, separated by `,`. ||
|| replication_factor | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Replication factor for automatically created topics. ||
|#

## ClusterConnection {#yandex.cloud.mdb.kafka.v1.ClusterConnection}

#|
||Field | Description ||
|| alias | **string**

Alias of cluster connection configuration.
Examples: `source`, `target`. ||
|| this_cluster | **[ThisCluster](#yandex.cloud.mdb.kafka.v1.ThisCluster)**

Connection configuration of the cluster the connector belongs to. As all credentials are already known, leave this parameter empty.

Includes only one of the fields `this_cluster`, `external_cluster`.

Type of connection to Apache Kafka® cluster. ||
|| external_cluster | **[ExternalClusterConnection](#yandex.cloud.mdb.kafka.v1.ExternalClusterConnection)**

Configuration of connection to an external cluster with all the necessary credentials.

Includes only one of the fields `this_cluster`, `external_cluster`.

Type of connection to Apache Kafka® cluster. ||
|#

## ThisCluster {#yandex.cloud.mdb.kafka.v1.ThisCluster}

#|
||Field | Description ||
|| Empty | > ||
|#

## ExternalClusterConnection {#yandex.cloud.mdb.kafka.v1.ExternalClusterConnection}

#|
||Field | Description ||
|| bootstrap_servers | **string**

List of bootstrap servers of the cluster, separated by `,`. ||
|| sasl_username | **string**

SASL username to use for connection to the cluster. ||
|| sasl_mechanism | **string**

SASL mechanism to use for connection to the cluster. ||
|| security_protocol | **string**

Security protocol to use for connection to the cluster. ||
|#

## ConnectorConfigS3Sink {#yandex.cloud.mdb.kafka.v1.ConnectorConfigS3Sink}

An Apache Kafka® S3-Sink
connector resource.

#|
||Field | Description ||
|| topics | **string**

List of Kafka topics, separated by ','. ||
|| file_compression_type | **string**

The compression type used for files put on GCS.
The supported values are: `gzip`, `snappy`, `zstd`, `none`.
Optional, the default is `none`. ||
|| file_max_records | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Max records per file. ||
|| s3_connection | **[S3Connection](#yandex.cloud.mdb.kafka.v1.S3Connection)**

Credentials for connecting to S3 storage. ||
|#

## S3Connection {#yandex.cloud.mdb.kafka.v1.S3Connection}

Resource for S3Connection -
settings of connection to AWS-compatible S3 storage, that
are source or target of Kafka S3-connectors.
YC Object Storage is AWS-compatible.

#|
||Field | Description ||
|| bucket_name | **string** ||
|| external_s3 | **[ExternalS3Storage](#yandex.cloud.mdb.kafka.v1.ExternalS3Storage)**

Includes only one of the fields `external_s3`. ||
|#

## ExternalS3Storage {#yandex.cloud.mdb.kafka.v1.ExternalS3Storage}

#|
||Field | Description ||
|| access_key_id | **string** ||
|| endpoint | **string** ||
|| region | **string**

Default is 'us-east-1' ||
|#