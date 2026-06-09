# Managed Service for Apache Kafka® API, REST: Connector.Resume

Resumes an Apache Kafka® connector.

## HTTP request

```
POST https://{{ api-host-mdb }}/managed-kafka/v1/clusters/{clusterId}/connectors/resume/{connectorName}
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the Apache Kafka® cluster to resume the connector in.

To get this ID, make a [ClusterService.List](../Cluster/list.md#List) request.

The maximum string length in characters is 50. ||
|| connectorName | **string**

Required field. Name of the Apache Kafka® connector to resume.

To get this name, make a [ConnectorService.List](list.md#List) request.

The maximum string length in characters is 256. Value must match the regular expression ` [-_.a-zA-Z0-9]* `. ||
|#

## Response {#yandex.cloud.operation.Operation}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": "boolean",
  "metadata": {
    "clusterId": "string",
    "connectorName": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": {
    "name": "string",
    "tasksMax": "string",
    "properties": "object",
    "health": "string",
    "status": "string",
    "clusterId": "string",
    // Includes only one of the fields `connectorConfigMirrormaker`, `connectorConfigS3Sink`, `connectorConfigIcebergSink`
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
    },
    "connectorConfigIcebergSink": {
      // Includes only one of the fields `topics`, `topicsRegex`
      "topics": "string",
      "topicsRegex": "string",
      // end of the list of possible fields
      "controlTopic": "string",
      "metastoreConnection": {
        "catalogUri": "string",
        "warehouse": "string"
      },
      "s3Connection": {
        // Includes only one of the fields `externalS3`
        "externalS3": {
          "accessKeyId": "string",
          "endpoint": "string",
          "region": "string"
        }
        // end of the list of possible fields
      },
      // Includes only one of the fields `staticTables`, `dynamicTables`
      "staticTables": {
        "tables": "string"
      },
      "dynamicTables": {
        "routeField": "string"
      },
      // end of the list of possible fields
      "tablesConfig": {
        "defaultCommitBranch": "string",
        "defaultIdColumns": "string",
        "defaultPartitionBy": "string",
        "evolveSchemaEnabled": "boolean",
        "schemaForceOptional": "boolean",
        "schemaCaseInsensitive": "boolean"
      },
      "controlConfig": {
        "groupIdPrefix": "string",
        "commitIntervalMs": "string",
        "commitTimeoutMs": "string",
        "commitThreads": "string",
        "transactionalPrefix": "string"
      }
    }
    // end of the list of possible fields
  }
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](../../../api-design-guide/concepts/operation.md).

#|
||Field | Description ||
|| id | **string**

ID of the operation. ||
|| description | **string**

Description of the operation. 0-256 characters long. ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **string** (date-time)

The time when the Operation resource was last modified.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| done | **boolean**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[ResumeConnectorMetadata](#yandex.cloud.mdb.kafka.v1.ResumeConnectorMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[Status](#google.rpc.Status)**

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
|| clusterId | **string**

ID of the Apache Kafka® cluster the connector is being resumed in. ||
|| connectorName | **string**

Required field. Name of the Apache Kafka® connector that is beign resumed.

The maximum string length in characters is 256. Value must match the regular expression ` [-_.a-zA-Z0-9]* `. ||
|#

## Status {#google.rpc.Status}

The error result of the operation in case of failure or cancellation.

#|
||Field | Description ||
|| code | **integer** (int32)

Error code. An enum value of [google.rpc.Code](https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto). ||
|| message | **string**

An error message. ||
|| details[] | **object**

A list of messages that carry the error details. ||
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

Includes only one of the fields `connectorConfigMirrormaker`, `connectorConfigS3Sink`, `connectorConfigIcebergSink`.

Additional settings for the connector. ||
|| connectorConfigS3Sink | **[ConnectorConfigS3Sink](#yandex.cloud.mdb.kafka.v1.ConnectorConfigS3Sink)**

Configuration of S3-Sink connector.

Includes only one of the fields `connectorConfigMirrormaker`, `connectorConfigS3Sink`, `connectorConfigIcebergSink`.

Additional settings for the connector. ||
|| connectorConfigIcebergSink | **[ConnectorConfigIcebergSink](#yandex.cloud.mdb.kafka.v1.ConnectorConfigIcebergSink)**

Configuration of Iceberg Sink connector.

Includes only one of the fields `connectorConfigMirrormaker`, `connectorConfigS3Sink`, `connectorConfigIcebergSink`.

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
|| bucketName | **string**

Name of the bucket. ||
|| externalS3 | **[ExternalS3Storage](#yandex.cloud.mdb.kafka.v1.ExternalS3Storage)**

Configuration for connection to S3 storage.

Includes only one of the fields `externalS3`. ||
|#

## ExternalS3Storage {#yandex.cloud.mdb.kafka.v1.ExternalS3Storage}

#|
||Field | Description ||
|| accessKeyId | **string**

ID of the AWS access key. ||
|| endpoint | **string**

S3 endpoint. ||
|| region | **string**

AWS region. Default is 'us-east-1'. ||
|#

## ConnectorConfigIcebergSink {#yandex.cloud.mdb.kafka.v1.ConnectorConfigIcebergSink}

Resource for Kafka Iceberg Sink Connector.

#|
||Field | Description ||
|| topics | **string**

List of Kafka topics, separated by ','.

Includes only one of the fields `topics`, `topicsRegex`. ||
|| topicsRegex | **string**

Regex of Kafka topics.

Includes only one of the fields `topics`, `topicsRegex`. ||
|| controlTopic | **string**

Control topic name for Iceberg connector. ||
|| metastoreConnection | **[MetastoreConnection](#yandex.cloud.mdb.kafka.v1.MetastoreConnection)**

Credentials for connecting to Managed Hive Metastore. ||
|| s3Connection | **[IcebergS3Connection](#yandex.cloud.mdb.kafka.v1.IcebergS3Connection)**

Credentials for connecting to S3 storage. ||
|| staticTables | **[StaticTables](#yandex.cloud.mdb.kafka.v1.StaticTables)**

Static table routing

Includes only one of the fields `staticTables`, `dynamicTables`.

Table routing strategy ||
|| dynamicTables | **[DynamicTables](#yandex.cloud.mdb.kafka.v1.DynamicTables)**

Dynamic table routing

Includes only one of the fields `staticTables`, `dynamicTables`.

Table routing strategy ||
|| tablesConfig | **[IcebergTablesConfig](#yandex.cloud.mdb.kafka.v1.IcebergTablesConfig)**

Optional table settings ||
|| controlConfig | **[IcebergControl](#yandex.cloud.mdb.kafka.v1.IcebergControl)**

Optional control settings ||
|#

## MetastoreConnection {#yandex.cloud.mdb.kafka.v1.MetastoreConnection}

#|
||Field | Description ||
|| catalogUri | **string**

Thrift URI of Hive Metastore
Format: "thrift://host:9083" ||
|| warehouse | **string**

Warehouse root directory in S3
Format: "s3a://bucket-name/path/to/warehouse"
Can be any path within the bucket, not necessarily "/warehouse" ||
|#

## IcebergS3Connection {#yandex.cloud.mdb.kafka.v1.IcebergS3Connection}

Resource for IcebergS3Connection -
settings of connection to AWS-compatible S3 storage, that
are target of Kafka Iceberg-connectors.
YC Object Storage is AWS-compatible.

#|
||Field | Description ||
|| externalS3 | **[ExternalIcebergS3Storage](#yandex.cloud.mdb.kafka.v1.ExternalIcebergS3Storage)**

Configuration for connection to S3 storage.

Includes only one of the fields `externalS3`. ||
|#

## ExternalIcebergS3Storage {#yandex.cloud.mdb.kafka.v1.ExternalIcebergS3Storage}

#|
||Field | Description ||
|| accessKeyId | **string**

ID of the AWS access key. ||
|| endpoint | **string**

S3 endpoint. ||
|| region | **string**

AWS region. Default is 'us-east-1'. ||
|#

## StaticTables {#yandex.cloud.mdb.kafka.v1.StaticTables}

#|
||Field | Description ||
|| tables | **string**

List of tables, separated by ','. ||
|#

## DynamicTables {#yandex.cloud.mdb.kafka.v1.DynamicTables}

#|
||Field | Description ||
|| routeField | **string**

Field in the message to define the target table
The iceberg.tables.dynamic-enabled field is set to true ||
|#

## IcebergTablesConfig {#yandex.cloud.mdb.kafka.v1.IcebergTablesConfig}

#|
||Field | Description ||
|| defaultCommitBranch | **string**

Default Git-like branch name for Iceberg commits.
Default: "main" ||
|| defaultIdColumns | **string**

List of columns used as identifiers for upsert operations, separated by ','. ||
|| defaultPartitionBy | **string**

Comma-separated list of columns or transform expressions for table partitioning.
Defines physical data layout for query optimization.
Examples:
- "date"
- "year,month"
- "year(timestamp),month(timestamp)"
- "days(timestamp)"
- "bucket(16,user_id)" ||
|| evolveSchemaEnabled | **boolean**

Enable automatic schema evolution.
Default: false ||
|| schemaForceOptional | **boolean**

Force all columns to be nullable (optional).
Default: false ||
|| schemaCaseInsensitive | **boolean**

Enable case-insensitive field name matching.
Default: false ||
|#

## IcebergControl {#yandex.cloud.mdb.kafka.v1.IcebergControl}

#|
||Field | Description ||
|| groupIdPrefix | **string**

Consumer group ID prefix for control topic.
Default: "cg-control" ||
|| commitIntervalMs | **string** (int64)

Interval between commits in milliseconds.
Default: 300000 (5 minutes) ||
|| commitTimeoutMs | **string** (int64)

Commit operation timeout in milliseconds.
Default: 30000 (30 seconds) ||
|| commitThreads | **string** (int64)

Number of threads for commit operations.
Default: cores * 2 ||
|| transactionalPrefix | **string**

Prefix for transactional operations.
Default: "" ||
|#