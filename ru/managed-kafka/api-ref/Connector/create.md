---
editable: false
apiPlayground:
  - url: https://{{ api-host-mdb }}/managed-kafka/v1/clusters/{clusterId}/connectors
    method: post
    path:
      type: object
      properties:
        clusterId:
          description: |-
            **string**
            Required field. ID of the Apache Kafka® cluster to create the connector in.
            To get this ID, make a [ClusterService.List](/docs/managed-kafka/api-ref/Cluster/list#List) request.
            The maximum string length in characters is 50.
          type: string
      required:
        - clusterId
      additionalProperties: false
    query: null
    body:
      type: object
      properties:
        connectorSpec:
          description: |-
            **[ConnectorSpec](#yandex.cloud.mdb.kafka.v1.ConnectorSpec)**
            Required field. Configuration of the connector to create.
          $ref: '#/definitions/ConnectorSpec'
      required:
        - connectorSpec
      additionalProperties: false
    definitions:
      ThisClusterSpec:
        type: object
        properties: {}
      ExternalClusterConnectionSpec:
        type: object
        properties:
          bootstrapServers:
            description: |-
              **string**
              List of bootstrap servers of the cluster, separated by `,`.
            type: string
          saslUsername:
            description: |-
              **string**
              SASL username to use for connection to the cluster.
            type: string
          saslPassword:
            description: |-
              **string**
              SASL password to use for connection to the cluster.
            type: string
          saslMechanism:
            description: |-
              **string**
              SASL mechanism to use for connection to the cluster.
            type: string
          securityProtocol:
            description: |-
              **string**
              Security protocol to use for connection to the cluster.
            type: string
          sslTruststoreCertificates:
            description: |-
              **string**
              CA in PEM format to connect to external cluster.
              Lines of certificate separated by '\n' symbol.
            type: string
      ClusterConnectionSpec:
        type: object
        properties:
          alias:
            description: |-
              **string**
              Alias of cluster connection configuration.
              Examples: `source`, `target`.
            type: string
          thisCluster:
            description: |-
              **object**
              Connection configuration of the cluster the connector belongs to. As all credentials are already known, leave this parameter empty.
              Includes only one of the fields `thisCluster`, `externalCluster`.
              Type of connection to Apache Kafka® cluster.
            $ref: '#/definitions/ThisClusterSpec'
          externalCluster:
            description: |-
              **[ExternalClusterConnectionSpec](#yandex.cloud.mdb.kafka.v1.ExternalClusterConnectionSpec)**
              Configuration of connection to an external cluster with all the necessary credentials.
              Includes only one of the fields `thisCluster`, `externalCluster`.
              Type of connection to Apache Kafka® cluster.
            $ref: '#/definitions/ExternalClusterConnectionSpec'
        oneOf:
          - required:
              - thisCluster
          - required:
              - externalCluster
      ConnectorConfigMirrorMakerSpec:
        type: object
        properties:
          sourceCluster:
            description: |-
              **[ClusterConnectionSpec](#yandex.cloud.mdb.kafka.v1.ClusterConnectionSpec)**
              Source cluster configuration for the MirrorMaker connector.
            $ref: '#/definitions/ClusterConnectionSpec'
          targetCluster:
            description: |-
              **[ClusterConnectionSpec](#yandex.cloud.mdb.kafka.v1.ClusterConnectionSpec)**
              Target cluster configuration for the MirrorMaker connector.
            $ref: '#/definitions/ClusterConnectionSpec'
          topics:
            description: |-
              **string**
              List of Kafka topics, separated by `,`.
            type: string
          replicationFactor:
            description: |-
              **string** (int64)
              Replication factor for automatically created topics.
            type: string
            format: int64
      ExternalS3StorageSpec:
        type: object
        properties:
          accessKeyId:
            description: |-
              **string**
              ID of the AWS access key.
            type: string
          secretAccessKey:
            description: |-
              **string**
              Secret access key for the AWS access key.
            type: string
          endpoint:
            description: |-
              **string**
              S3 endpoint.
            type: string
          region:
            description: |-
              **string**
              AWS region. Default is 'us-east-1'.
            type: string
      S3ConnectionSpec:
        type: object
        properties:
          bucketName:
            description: |-
              **string**
              Name of the bucket.
            type: string
          externalS3:
            description: |-
              **[ExternalS3StorageSpec](#yandex.cloud.mdb.kafka.v1.ExternalS3StorageSpec)**
              Configuration for connection to S3 storage.
              Includes only one of the fields `externalS3`.
            $ref: '#/definitions/ExternalS3StorageSpec'
        oneOf:
          - required:
              - externalS3
      ConnectorConfigS3SinkSpec:
        type: object
        properties:
          topics:
            description: |-
              **string**
              Required field. List of Kafka topics, separated by ','.
            type: string
          fileCompressionType:
            description: |-
              **string**
              The compression type used for files put on GCS.
              The supported values are: `gzip`, `snappy`, `zstd`, `none`.
              Optional, the default is `none`.
            type: string
          fileMaxRecords:
            description: |-
              **string** (int64)
              Max records per file.
            type: string
            format: int64
          s3Connection:
            description: |-
              **[S3ConnectionSpec](#yandex.cloud.mdb.kafka.v1.S3ConnectionSpec)**
              Required field. Credentials for connecting to S3 storage.
            $ref: '#/definitions/S3ConnectionSpec'
        required:
          - topics
          - s3Connection
      MetastoreConnectionSpec:
        type: object
        properties:
          catalogUri:
            description: |-
              **string**
              Thrift URI of Hive Metastore
              Format: "thrift://host:9083"
            type: string
          warehouse:
            description: |-
              **string**
              Warehouse root directory in S3
              Format: "s3a://bucket-name/path/to/warehouse"
              Can be any path within the bucket, not necessarily "/warehouse"
            type: string
      ExternalIcebergS3StorageSpec:
        type: object
        properties:
          accessKeyId:
            description: |-
              **string**
              ID of the AWS access key.
            type: string
          secretAccessKey:
            description: |-
              **string**
              Secret access key for the AWS access key.
            type: string
          endpoint:
            description: |-
              **string**
              S3 endpoint.
            type: string
          region:
            description: |-
              **string**
              AWS region. Default is 'us-east-1'.
            type: string
      IcebergS3ConnectionSpec:
        type: object
        properties:
          externalS3:
            description: |-
              **[ExternalIcebergS3StorageSpec](#yandex.cloud.mdb.kafka.v1.ExternalIcebergS3StorageSpec)**
              Configuration for connection to S3 storage.
              Includes only one of the fields `externalS3`.
            $ref: '#/definitions/ExternalIcebergS3StorageSpec'
        oneOf:
          - required:
              - externalS3
      StaticTablesSpec:
        type: object
        properties:
          tables:
            description: |-
              **string**
              List of tables, separated by ','.
            type: string
      DynamicTablesSpec:
        type: object
        properties:
          routeField:
            description: |-
              **string**
              Field in the message to define the target table
              The iceberg.tables.dynamic-enabled field is set to true
            type: string
      IcebergTablesConfigSpec:
        type: object
        properties:
          defaultCommitBranch:
            description: |-
              **string**
              Default Git-like branch name for Iceberg commits.
              Default: "main"
            default: main
            type: string
          defaultIdColumns:
            description: |-
              **string**
              List of columns used as identifiers for upsert operations, separated by ','.
            type: string
          defaultPartitionBy:
            description: |-
              **string**
              Comma-separated list of columns or transform expressions for table partitioning.
              Defines physical data layout for query optimization.
              Examples:
              - "date"
              - "year,month"
              - "year(timestamp),month(timestamp)"
              - "days(timestamp)"
              - "bucket(16,user_id)"
            type: string
          evolveSchemaEnabled:
            description: |-
              **boolean**
              Enable automatic schema evolution.
              Default: false
            default: false
            type: boolean
          schemaForceOptional:
            description: |-
              **boolean**
              Force all columns to be nullable (optional).
              Default: false
            default: false
            type: boolean
          schemaCaseInsensitive:
            description: |-
              **boolean**
              Enable case-insensitive field name matching.
              Default: false
            default: false
            type: boolean
      IcebergControlSpec:
        type: object
        properties:
          groupIdPrefix:
            description: |-
              **string**
              Consumer group ID prefix for control topic.
              Default: "cg-control"
            default: cg-control
            type: string
          commitIntervalMs:
            description: |-
              **string** (int64)
              Interval between commits in milliseconds.
              Default: 300000 (5 minutes)
            default: 300000 (5 minutes)
            type: string
            format: int64
          commitTimeoutMs:
            description: |-
              **string** (int64)
              Commit operation timeout in milliseconds.
              Default: 30000 (30 seconds)
            default: 30000 (30 seconds)
            type: string
            format: int64
          commitThreads:
            description: |-
              **string** (int64)
              Number of threads for commit operations.
              Default: cores * 2
            default: cores * 2
            type: string
            format: int64
          transactionalPrefix:
            description: |-
              **string**
              Prefix for transactional operations.
              Default: ""
            default: ''
            type: string
      ConnectorConfigIcebergSinkSpec:
        type: object
        properties:
          topics:
            description: |-
              **string**
              List of Kafka topics, separated by ','.
              Includes only one of the fields `topics`, `topicsRegex`.
            type: string
          topicsRegex:
            description: |-
              **string**
              Regex of Kafka topics.
              Includes only one of the fields `topics`, `topicsRegex`.
            type: string
          controlTopic:
            description: |-
              **string**
              Required field. Control topic name for Iceberg connector.
            type: string
          metastoreConnection:
            description: |-
              **[MetastoreConnectionSpec](#yandex.cloud.mdb.kafka.v1.MetastoreConnectionSpec)**
              Required field. Credentials for connecting to Managed Hive Metastore.
            $ref: '#/definitions/MetastoreConnectionSpec'
          s3Connection:
            description: |-
              **[IcebergS3ConnectionSpec](#yandex.cloud.mdb.kafka.v1.IcebergS3ConnectionSpec)**
              Required field. Credentials for connecting to S3 storage.
            $ref: '#/definitions/IcebergS3ConnectionSpec'
          staticTables:
            description: |-
              **[StaticTablesSpec](#yandex.cloud.mdb.kafka.v1.StaticTablesSpec)**
              Static table routing
              Includes only one of the fields `staticTables`, `dynamicTables`.
              Table routing strategy
            $ref: '#/definitions/StaticTablesSpec'
          dynamicTables:
            description: |-
              **[DynamicTablesSpec](#yandex.cloud.mdb.kafka.v1.DynamicTablesSpec)**
              Dynamic table routing
              Includes only one of the fields `staticTables`, `dynamicTables`.
              Table routing strategy
            $ref: '#/definitions/DynamicTablesSpec'
          tablesConfig:
            description: |-
              **[IcebergTablesConfigSpec](#yandex.cloud.mdb.kafka.v1.IcebergTablesConfigSpec)**
              Optional table settings
            $ref: '#/definitions/IcebergTablesConfigSpec'
          controlConfig:
            description: |-
              **[IcebergControlSpec](#yandex.cloud.mdb.kafka.v1.IcebergControlSpec)**
              Optional control settings
            $ref: '#/definitions/IcebergControlSpec'
        required:
          - controlTopic
          - metastoreConnection
          - s3Connection
        allOf:
          - oneOf:
              - required:
                  - topics
              - required:
                  - topicsRegex
          - oneOf:
              - required:
                  - staticTables
              - required:
                  - dynamicTables
      ConnectorSpec:
        type: object
        properties:
          name:
            description: |-
              **string**
              Name of the connector.
            type: string
          tasksMax:
            description: |-
              **string** (int64)
              Maximum number of connector tasks. Default value is the number of brokers.
            type: string
            format: int64
          properties:
            description: |-
              **object** (map<**string**, **string**>)
              A set of properties passed to Managed Service for Apache Kafka® with the connector configuration.
              Example: `sync.topics.config.enabled: true`.
            type: object
            additionalProperties:
              type: string
          connectorConfigMirrormaker:
            description: |-
              **[ConnectorConfigMirrorMakerSpec](#yandex.cloud.mdb.kafka.v1.ConnectorConfigMirrorMakerSpec)**
              Configuration of the MirrorMaker connector.
              Includes only one of the fields `connectorConfigMirrormaker`, `connectorConfigS3Sink`, `connectorConfigIcebergSink`.
              Additional settings for the connector.
            $ref: '#/definitions/ConnectorConfigMirrorMakerSpec'
          connectorConfigS3Sink:
            description: |-
              **[ConnectorConfigS3SinkSpec](#yandex.cloud.mdb.kafka.v1.ConnectorConfigS3SinkSpec)**
              Configuration of S3-Sink connector.
              Includes only one of the fields `connectorConfigMirrormaker`, `connectorConfigS3Sink`, `connectorConfigIcebergSink`.
              Additional settings for the connector.
            $ref: '#/definitions/ConnectorConfigS3SinkSpec'
          connectorConfigIcebergSink:
            description: |-
              **[ConnectorConfigIcebergSinkSpec](#yandex.cloud.mdb.kafka.v1.ConnectorConfigIcebergSinkSpec)**
              Configuration of Iceberg Sink connector.
              Includes only one of the fields `connectorConfigMirrormaker`, `connectorConfigS3Sink`, `connectorConfigIcebergSink`.
              Additional settings for the connector.
            $ref: '#/definitions/ConnectorConfigIcebergSinkSpec'
        oneOf:
          - required:
              - connectorConfigMirrormaker
          - required:
              - connectorConfigS3Sink
          - required:
              - connectorConfigIcebergSink
---

# Managed Service for Apache Kafka® API, REST: Connector.Create

Creates a new Apache Kafka® connector in a cluster.

## HTTP request

```
POST https://{{ api-host-mdb }}/managed-kafka/v1/clusters/{clusterId}/connectors
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the Apache Kafka® cluster to create the connector in.
To get this ID, make a [ClusterService.List](/docs/managed-kafka/api-ref/Cluster/list#List) request.

The maximum string length in characters is 50. ||
|#

## Body parameters {#yandex.cloud.mdb.kafka.v1.CreateConnectorRequest}

```json
{
  "connectorSpec": {
    "name": "string",
    "tasksMax": "string",
    "properties": "object",
    // Includes only one of the fields `connectorConfigMirrormaker`, `connectorConfigS3Sink`, `connectorConfigIcebergSink`
    "connectorConfigMirrormaker": {
      "sourceCluster": {
        "alias": "string",
        // Includes only one of the fields `thisCluster`, `externalCluster`
        "thisCluster": "object",
        "externalCluster": {
          "bootstrapServers": "string",
          "saslUsername": "string",
          "saslPassword": "string",
          "saslMechanism": "string",
          "securityProtocol": "string",
          "sslTruststoreCertificates": "string"
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
          "saslPassword": "string",
          "saslMechanism": "string",
          "securityProtocol": "string",
          "sslTruststoreCertificates": "string"
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
          "secretAccessKey": "string",
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
          "secretAccessKey": "string",
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
}
```

#|
||Field | Description ||
|| connectorSpec | **[ConnectorSpec](#yandex.cloud.mdb.kafka.v1.ConnectorSpec)**

Required field. Configuration of the connector to create. ||
|#

## ConnectorSpec {#yandex.cloud.mdb.kafka.v1.ConnectorSpec}

An object that represents an Apache Kafka® connector.
See [the documentation](/docs/managed-kafka/concepts/connectors) for details.

#|
||Field | Description ||
|| name | **string**

Name of the connector. ||
|| tasksMax | **string** (int64)

Maximum number of connector tasks. Default value is the number of brokers. ||
|| properties | **object** (map<**string**, **string**>)

A set of properties passed to Managed Service for Apache Kafka® with the connector configuration.
Example: `sync.topics.config.enabled: true`. ||
|| connectorConfigMirrormaker | **[ConnectorConfigMirrorMakerSpec](#yandex.cloud.mdb.kafka.v1.ConnectorConfigMirrorMakerSpec)**

Configuration of the MirrorMaker connector.

Includes only one of the fields `connectorConfigMirrormaker`, `connectorConfigS3Sink`, `connectorConfigIcebergSink`.

Additional settings for the connector. ||
|| connectorConfigS3Sink | **[ConnectorConfigS3SinkSpec](#yandex.cloud.mdb.kafka.v1.ConnectorConfigS3SinkSpec)**

Configuration of S3-Sink connector.

Includes only one of the fields `connectorConfigMirrormaker`, `connectorConfigS3Sink`, `connectorConfigIcebergSink`.

Additional settings for the connector. ||
|| connectorConfigIcebergSink | **[ConnectorConfigIcebergSinkSpec](#yandex.cloud.mdb.kafka.v1.ConnectorConfigIcebergSinkSpec)**

Configuration of Iceberg Sink connector.

Includes only one of the fields `connectorConfigMirrormaker`, `connectorConfigS3Sink`, `connectorConfigIcebergSink`.

Additional settings for the connector. ||
|#

## ConnectorConfigMirrorMakerSpec {#yandex.cloud.mdb.kafka.v1.ConnectorConfigMirrorMakerSpec}

#|
||Field | Description ||
|| sourceCluster | **[ClusterConnectionSpec](#yandex.cloud.mdb.kafka.v1.ClusterConnectionSpec)**

Source cluster configuration for the MirrorMaker connector. ||
|| targetCluster | **[ClusterConnectionSpec](#yandex.cloud.mdb.kafka.v1.ClusterConnectionSpec)**

Target cluster configuration for the MirrorMaker connector. ||
|| topics | **string**

List of Kafka topics, separated by `,`. ||
|| replicationFactor | **string** (int64)

Replication factor for automatically created topics. ||
|#

## ClusterConnectionSpec {#yandex.cloud.mdb.kafka.v1.ClusterConnectionSpec}

#|
||Field | Description ||
|| alias | **string**

Alias of cluster connection configuration.
Examples: `source`, `target`. ||
|| thisCluster | **object**

Connection configuration of the cluster the connector belongs to. As all credentials are already known, leave this parameter empty.

Includes only one of the fields `thisCluster`, `externalCluster`.

Type of connection to Apache Kafka® cluster. ||
|| externalCluster | **[ExternalClusterConnectionSpec](#yandex.cloud.mdb.kafka.v1.ExternalClusterConnectionSpec)**

Configuration of connection to an external cluster with all the necessary credentials.

Includes only one of the fields `thisCluster`, `externalCluster`.

Type of connection to Apache Kafka® cluster. ||
|#

## ExternalClusterConnectionSpec {#yandex.cloud.mdb.kafka.v1.ExternalClusterConnectionSpec}

#|
||Field | Description ||
|| bootstrapServers | **string**

List of bootstrap servers of the cluster, separated by `,`. ||
|| saslUsername | **string**

SASL username to use for connection to the cluster. ||
|| saslPassword | **string**

SASL password to use for connection to the cluster. ||
|| saslMechanism | **string**

SASL mechanism to use for connection to the cluster. ||
|| securityProtocol | **string**

Security protocol to use for connection to the cluster. ||
|| sslTruststoreCertificates | **string**

CA in PEM format to connect to external cluster.
Lines of certificate separated by '\n' symbol. ||
|#

## ConnectorConfigS3SinkSpec {#yandex.cloud.mdb.kafka.v1.ConnectorConfigS3SinkSpec}

Specification for Kafka S3-Sink Connector.

#|
||Field | Description ||
|| topics | **string**

Required field. List of Kafka topics, separated by ','. ||
|| fileCompressionType | **string**

The compression type used for files put on GCS.
The supported values are: `gzip`, `snappy`, `zstd`, `none`.
Optional, the default is `none`. ||
|| fileMaxRecords | **string** (int64)

Max records per file. ||
|| s3Connection | **[S3ConnectionSpec](#yandex.cloud.mdb.kafka.v1.S3ConnectionSpec)**

Required field. Credentials for connecting to S3 storage. ||
|#

## S3ConnectionSpec {#yandex.cloud.mdb.kafka.v1.S3ConnectionSpec}

Specification for S3Connection -
settings of connection to AWS-compatible S3 storage, that
are source or target of Kafka S3-connectors.
YC Object Storage is AWS-compatible.

#|
||Field | Description ||
|| bucketName | **string**

Name of the bucket. ||
|| externalS3 | **[ExternalS3StorageSpec](#yandex.cloud.mdb.kafka.v1.ExternalS3StorageSpec)**

Configuration for connection to S3 storage.

Includes only one of the fields `externalS3`. ||
|#

## ExternalS3StorageSpec {#yandex.cloud.mdb.kafka.v1.ExternalS3StorageSpec}

#|
||Field | Description ||
|| accessKeyId | **string**

ID of the AWS access key. ||
|| secretAccessKey | **string**

Secret access key for the AWS access key. ||
|| endpoint | **string**

S3 endpoint. ||
|| region | **string**

AWS region. Default is 'us-east-1'. ||
|#

## ConnectorConfigIcebergSinkSpec {#yandex.cloud.mdb.kafka.v1.ConnectorConfigIcebergSinkSpec}

Specification for Kafka Iceberg Sink Connector.

#|
||Field | Description ||
|| topics | **string**

List of Kafka topics, separated by ','.

Includes only one of the fields `topics`, `topicsRegex`. ||
|| topicsRegex | **string**

Regex of Kafka topics.

Includes only one of the fields `topics`, `topicsRegex`. ||
|| controlTopic | **string**

Required field. Control topic name for Iceberg connector. ||
|| metastoreConnection | **[MetastoreConnectionSpec](#yandex.cloud.mdb.kafka.v1.MetastoreConnectionSpec)**

Required field. Credentials for connecting to Managed Hive Metastore. ||
|| s3Connection | **[IcebergS3ConnectionSpec](#yandex.cloud.mdb.kafka.v1.IcebergS3ConnectionSpec)**

Required field. Credentials for connecting to S3 storage. ||
|| staticTables | **[StaticTablesSpec](#yandex.cloud.mdb.kafka.v1.StaticTablesSpec)**

Static table routing

Includes only one of the fields `staticTables`, `dynamicTables`.

Table routing strategy ||
|| dynamicTables | **[DynamicTablesSpec](#yandex.cloud.mdb.kafka.v1.DynamicTablesSpec)**

Dynamic table routing

Includes only one of the fields `staticTables`, `dynamicTables`.

Table routing strategy ||
|| tablesConfig | **[IcebergTablesConfigSpec](#yandex.cloud.mdb.kafka.v1.IcebergTablesConfigSpec)**

Optional table settings ||
|| controlConfig | **[IcebergControlSpec](#yandex.cloud.mdb.kafka.v1.IcebergControlSpec)**

Optional control settings ||
|#

## MetastoreConnectionSpec {#yandex.cloud.mdb.kafka.v1.MetastoreConnectionSpec}

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

## IcebergS3ConnectionSpec {#yandex.cloud.mdb.kafka.v1.IcebergS3ConnectionSpec}

Specification for IcebergS3Connection -
settings of connection to AWS-compatible S3 storage, that
are target of Kafka Iceberg-connectors.
YC Object Storage is AWS-compatible.

#|
||Field | Description ||
|| externalS3 | **[ExternalIcebergS3StorageSpec](#yandex.cloud.mdb.kafka.v1.ExternalIcebergS3StorageSpec)**

Configuration for connection to S3 storage.

Includes only one of the fields `externalS3`. ||
|#

## ExternalIcebergS3StorageSpec {#yandex.cloud.mdb.kafka.v1.ExternalIcebergS3StorageSpec}

#|
||Field | Description ||
|| accessKeyId | **string**

ID of the AWS access key. ||
|| secretAccessKey | **string**

Secret access key for the AWS access key. ||
|| endpoint | **string**

S3 endpoint. ||
|| region | **string**

AWS region. Default is 'us-east-1'. ||
|#

## StaticTablesSpec {#yandex.cloud.mdb.kafka.v1.StaticTablesSpec}

#|
||Field | Description ||
|| tables | **string**

List of tables, separated by ','. ||
|#

## DynamicTablesSpec {#yandex.cloud.mdb.kafka.v1.DynamicTablesSpec}

#|
||Field | Description ||
|| routeField | **string**

Field in the message to define the target table
The iceberg.tables.dynamic-enabled field is set to true ||
|#

## IcebergTablesConfigSpec {#yandex.cloud.mdb.kafka.v1.IcebergTablesConfigSpec}

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

## IcebergControlSpec {#yandex.cloud.mdb.kafka.v1.IcebergControlSpec}

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
  "metadata": "object",
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": "object"
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
|| metadata | **object**

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
|| response | **object**

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