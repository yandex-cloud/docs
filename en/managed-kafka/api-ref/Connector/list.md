---
editable: false
sourcePath: en/_api-ref/mdb/kafka/v1/api-ref/Connector/list.md
---

# Managed Service for Apache Kafka® API, REST: Connector.List

Retrieves the list of Apache Kafka® connectors in a cluster.

## HTTP request

```
GET https://{{ api-host-mdb }}/managed-kafka/v1/clusters/{clusterId}/connectors
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the Apache Kafka® cluster to list connectors in.

To get this ID, make a [ClusterService.List](/docs/managed-kafka/api-ref/Cluster/list#List) request. ||
|#

## Query parameters {#yandex.cloud.mdb.kafka.v1.ListConnectorsRequest}

#|
||Field | Description ||
|| pageSize | **string** (int64)

The maximum number of results per page to return.

If the number of available results is larger than `pageSize`, the API returns a [ListConnectorsResponse.nextPageToken](#yandex.cloud.mdb.kafka.v1.ListConnectorsResponse) that can be used to get the next page of results in the subsequent [ConnectorService.List](#List) requests. ||
|| pageToken | **string**

Page token that can be used to iterate through multiple pages of results.

To get the next page of results, set `pageToken` to the [ListConnectorsResponse.nextPageToken](#yandex.cloud.mdb.kafka.v1.ListConnectorsResponse) returned by the previous [ConnectorService.List](#List) request. ||
|#

## Response {#yandex.cloud.mdb.kafka.v1.ListConnectorsResponse}

**HTTP Code: 200 - OK**

```json
{
  "connectors": [
    {
      "name": "string",
      "tasksMax": "string",
      "properties": "object",
      "health": "string",
      "status": "string",
      "clusterId": "string",
      // Includes only one of the fields `connectorConfigMirrormaker`, `connectorConfigS3Sink`
      "connectorConfigMirrormaker": {
        "sourceCluster": {
          "alias": "string",
          // Includes only one of the fields `thisCluster`, `externalCluster`
          "thisCluster": "object",
          "externalCluster": {
            "bootstrapServers": "string",
            "saslUsername": "string",
            "saslMechanism": "string",
            "securityProtocol": "string"
          }
          // end of the list of possible fields
        },
        "targetCluster": {
          "alias": "string",
          // Includes only one of the fields `thisCluster`, `externalCluster`
          "thisCluster": "object",
          "externalCluster": {
            "bootstrapServers": "string",
            "saslUsername": "string",
            "saslMechanism": "string",
            "securityProtocol": "string"
          }
          // end of the list of possible fields
        },
        "topics": "string",
        "replicationFactor": "string"
      },
      "connectorConfigS3Sink": {
        "topics": "string",
        "fileCompressionType": "string",
        "fileMaxRecords": "string",
        "s3Connection": {
          "bucketName": "string",
          // Includes only one of the fields `externalS3`
          "externalS3": {
            "accessKeyId": "string",
            "endpoint": "string",
            "region": "string"
          }
          // end of the list of possible fields
        }
      }
      // end of the list of possible fields
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| connectors[] | **[Connector](#yandex.cloud.mdb.kafka.v1.Connector)**

List of Apache Kafka® Connectors. ||
|| nextPageToken | **string**

The token that can be used to get the next page of results.

If the number of results is larger than [ListConnectorsRequest.pageSize](#yandex.cloud.mdb.kafka.v1.ListConnectorsRequest), use the `nextPageToken` as the value for the [ListConnectorsRequest.pageToken](#yandex.cloud.mdb.kafka.v1.ListConnectorsRequest) in the subsequent [ConnectorService.List](#List) request to iterate through multiple pages of results. ||
|#

## Connector {#yandex.cloud.mdb.kafka.v1.Connector}

#|
||Field | Description ||
|| name | **string**

Name of the connector. ||
|| tasksMax | **string** (int64)

Maximum number of connector tasks. Default value is the number of brokers. ||
|| properties | **object** (map<**string**, **string**>)

A set of properties passed to Managed Service for Apache Kafka® with the connector configuration.
Example: `sync.topics.config.enabled: true`. ||
|| health | **enum** (Health)

Connector health.

- `HEALTH_UNKNOWN`: Health of the connector is unknown.
- `ALIVE`: Connector is running.
- `DEAD`: Connector has failed to start. ||
|| status | **enum** (Status)

Current status of the connector.

- `STATUS_UNKNOWN`: Connector state is unknown.
- `RUNNING`: Connector is running normally.
- `ERROR`: Connector has encountered a problem and cannot operate.
- `PAUSED`: Connector is paused. ||
|| clusterId | **string**

ID of the Apache Kafka® cluster that the connector belongs to. ||
|| connectorConfigMirrormaker | **[ConnectorConfigMirrorMaker](#yandex.cloud.mdb.kafka.v1.ConnectorConfigMirrorMaker)**

Configuration of the MirrorMaker connector.

Includes only one of the fields `connectorConfigMirrormaker`, `connectorConfigS3Sink`.

Additional settings for the connector. ||
|| connectorConfigS3Sink | **[ConnectorConfigS3Sink](#yandex.cloud.mdb.kafka.v1.ConnectorConfigS3Sink)**

Configuration of S3-Sink connector.

Includes only one of the fields `connectorConfigMirrormaker`, `connectorConfigS3Sink`.

Additional settings for the connector. ||
|#

## ConnectorConfigMirrorMaker {#yandex.cloud.mdb.kafka.v1.ConnectorConfigMirrorMaker}

#|
||Field | Description ||
|| sourceCluster | **[ClusterConnection](#yandex.cloud.mdb.kafka.v1.ClusterConnection)**

Source cluster connection configuration. ||
|| targetCluster | **[ClusterConnection](#yandex.cloud.mdb.kafka.v1.ClusterConnection)**

Target cluster connection configuration. ||
|| topics | **string**

List of Kafka topics, separated by `,`. ||
|| replicationFactor | **string** (int64)

Replication factor for automatically created topics. ||
|#

## ClusterConnection {#yandex.cloud.mdb.kafka.v1.ClusterConnection}

#|
||Field | Description ||
|| alias | **string**

Alias of cluster connection configuration.
Examples: `source`, `target`. ||
|| thisCluster | **object**

Connection configuration of the cluster the connector belongs to. As all credentials are already known, leave this parameter empty.

Includes only one of the fields `thisCluster`, `externalCluster`.

Type of connection to Apache Kafka® cluster. ||
|| externalCluster | **[ExternalClusterConnection](#yandex.cloud.mdb.kafka.v1.ExternalClusterConnection)**

Configuration of connection to an external cluster with all the necessary credentials.

Includes only one of the fields `thisCluster`, `externalCluster`.

Type of connection to Apache Kafka® cluster. ||
|#

## ExternalClusterConnection {#yandex.cloud.mdb.kafka.v1.ExternalClusterConnection}

#|
||Field | Description ||
|| bootstrapServers | **string**

List of bootstrap servers of the cluster, separated by `,`. ||
|| saslUsername | **string**

SASL username to use for connection to the cluster. ||
|| saslMechanism | **string**

SASL mechanism to use for connection to the cluster. ||
|| securityProtocol | **string**

Security protocol to use for connection to the cluster. ||
|#

## ConnectorConfigS3Sink {#yandex.cloud.mdb.kafka.v1.ConnectorConfigS3Sink}

An Apache Kafka® S3-Sink
connector resource.

#|
||Field | Description ||
|| topics | **string**

List of Kafka topics, separated by ','. ||
|| fileCompressionType | **string**

The compression type used for files put on GCS.
The supported values are: `gzip`, `snappy`, `zstd`, `none`.
Optional, the default is `none`. ||
|| fileMaxRecords | **string** (int64)

Max records per file. ||
|| s3Connection | **[S3Connection](#yandex.cloud.mdb.kafka.v1.S3Connection)**

Credentials for connecting to S3 storage. ||
|#

## S3Connection {#yandex.cloud.mdb.kafka.v1.S3Connection}

Resource for S3Connection -
settings of connection to AWS-compatible S3 storage, that
are source or target of Kafka S3-connectors.
YC Object Storage is AWS-compatible.

#|
||Field | Description ||
|| bucketName | **string** ||
|| externalS3 | **[ExternalS3Storage](#yandex.cloud.mdb.kafka.v1.ExternalS3Storage)**

Includes only one of the fields `externalS3`. ||
|#

## ExternalS3Storage {#yandex.cloud.mdb.kafka.v1.ExternalS3Storage}

#|
||Field | Description ||
|| accessKeyId | **string** ||
|| endpoint | **string** ||
|| region | **string**

Default is 'us-east-1' ||
|#