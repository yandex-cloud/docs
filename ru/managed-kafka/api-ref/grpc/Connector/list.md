---
editable: false
sourcePath: en/_api-ref-grpc/mdb/kafka/v1/api-ref/grpc/Connector/list.md
---

# Managed Service for Apache Kafka® API, gRPC: ConnectorService.List

Retrieves the list of Apache Kafka® connectors in a cluster.

## gRPC request

**rpc List ([ListConnectorsRequest](#yandex.cloud.mdb.kafka.v1.ListConnectorsRequest)) returns ([ListConnectorsResponse](#yandex.cloud.mdb.kafka.v1.ListConnectorsResponse))**

## ListConnectorsRequest {#yandex.cloud.mdb.kafka.v1.ListConnectorsRequest}

```json
{
  "cluster_id": "string",
  "page_size": "int64",
  "page_token": "string"
}
```

#|
||Field | Description ||
|| cluster_id | **string**

Required field. ID of the Apache Kafka® cluster to list connectors in.

To get this ID, make a [ClusterService.List](/docs/managed-kafka/api-ref/grpc/Cluster/list#List) request. ||
|| page_size | **int64**

The maximum number of results per page to return.

If the number of available results is larger than `page_size`, the API returns a [ListConnectorsResponse.next_page_token](#yandex.cloud.mdb.kafka.v1.ListConnectorsResponse) that can be used to get the next page of results in the subsequent [ConnectorService.List](#List) requests. ||
|| page_token | **string**

Page token that can be used to iterate through multiple pages of results.

To get the next page of results, set `page_token` to the [ListConnectorsResponse.next_page_token](#yandex.cloud.mdb.kafka.v1.ListConnectorsResponse) returned by the previous [ConnectorService.List](#List) request. ||
|#

## ListConnectorsResponse {#yandex.cloud.mdb.kafka.v1.ListConnectorsResponse}

```json
{
  "connectors": [
    {
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
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| connectors[] | **[Connector](#yandex.cloud.mdb.kafka.v1.Connector)**

List of Apache Kafka® Connectors. ||
|| next_page_token | **string**

The token that can be used to get the next page of results.

If the number of results is larger than [ListConnectorsRequest.page_size](#yandex.cloud.mdb.kafka.v1.ListConnectorsRequest), use the `next_page_token` as the value for the [ListConnectorsRequest.page_token](#yandex.cloud.mdb.kafka.v1.ListConnectorsRequest) in the subsequent [ConnectorService.List](#List) request to iterate through multiple pages of results. ||
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