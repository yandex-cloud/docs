# Managed Service for Apache Kafka® API, gRPC: ConnectorService.Create

Creates a new Apache Kafka® connector in a cluster.

## gRPC request

**rpc Create ([CreateConnectorRequest](#yandex.cloud.mdb.kafka.v1.CreateConnectorRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## CreateConnectorRequest {#yandex.cloud.mdb.kafka.v1.CreateConnectorRequest}

```json
{
  "cluster_id": "string",
  "connector_spec": {
    "name": "string",
    "tasks_max": "google.protobuf.Int64Value",
    "properties": "map<string, string>",
    // Includes only one of the fields `connector_config_mirrormaker`, `connector_config_s3_sink`, `connector_config_iceberg_sink`
    "connector_config_mirrormaker": {
      "source_cluster": {
        "alias": "string",
        // Includes only one of the fields `this_cluster`, `external_cluster`
        "this_cluster": "ThisClusterSpec",
        "external_cluster": {
          "bootstrap_servers": "string",
          "sasl_username": "string",
          "sasl_password": "string",
          "sasl_mechanism": "string",
          "security_protocol": "string",
          "ssl_truststore_certificates": "string"
        }
        // end of the list of possible fields
      },
      "target_cluster": {
        "alias": "string",
        // Includes only one of the fields `this_cluster`, `external_cluster`
        "this_cluster": "ThisClusterSpec",
        "external_cluster": {
          "bootstrap_servers": "string",
          "sasl_username": "string",
          "sasl_password": "string",
          "sasl_mechanism": "string",
          "security_protocol": "string",
          "ssl_truststore_certificates": "string"
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
          "secret_access_key": "string",
          "endpoint": "string",
          "region": "string"
        }
        // end of the list of possible fields
      }
    },
    "connector_config_iceberg_sink": {
      // Includes only one of the fields `topics`, `topics_regex`
      "topics": "string",
      "topics_regex": "string",
      // end of the list of possible fields
      "control_topic": "string",
      "metastore_connection": {
        "catalog_uri": "string",
        "warehouse": "string"
      },
      "s3_connection": {
        // Includes only one of the fields `external_s3`
        "external_s3": {
          "access_key_id": "string",
          "secret_access_key": "string",
          "endpoint": "string",
          "region": "string"
        }
        // end of the list of possible fields
      },
      // Includes only one of the fields `static_tables`, `dynamic_tables`
      "static_tables": {
        "tables": "string"
      },
      "dynamic_tables": {
        "route_field": "string"
      },
      // end of the list of possible fields
      "tables_config": {
        "default_commit_branch": "string",
        "default_id_columns": "string",
        "default_partition_by": "string",
        "evolve_schema_enabled": "bool",
        "schema_force_optional": "bool",
        "schema_case_insensitive": "bool"
      },
      "control_config": {
        "group_id_prefix": "string",
        "commit_interval_ms": "google.protobuf.Int64Value",
        "commit_timeout_ms": "google.protobuf.Int64Value",
        "commit_threads": "google.protobuf.Int64Value",
        "transactional_prefix": "string"
      }
    }
    // end of the list of possible fields
  }
}
```

#|
||Field | Description ||
|| cluster_id | **string**

Required field. ID of the Apache Kafka® cluster to create the connector in.
To get this ID, make a [ClusterService.List](../Cluster/list.md#List) request.

The maximum string length in characters is 50. ||
|| connector_spec | **[ConnectorSpec](#yandex.cloud.mdb.kafka.v1.ConnectorSpec)**

Required field. Configuration of the connector to create. ||
|#

## ConnectorSpec {#yandex.cloud.mdb.kafka.v1.ConnectorSpec}

An object that represents an Apache Kafka® connector.
See [the documentation](../../../concepts/connectors.md) for details.

#|
||Field | Description ||
|| name | **string**

Name of the connector. ||
|| tasks_max | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Maximum number of connector tasks. Default value is the number of brokers. ||
|| properties | **object** (map<**string**, **string**>)

A set of properties passed to Managed Service for Apache Kafka® with the connector configuration.
Example: `sync.topics.config.enabled: true`. ||
|| connector_config_mirrormaker | **[ConnectorConfigMirrorMakerSpec](#yandex.cloud.mdb.kafka.v1.ConnectorConfigMirrorMakerSpec)**

Configuration of the MirrorMaker connector.

Includes only one of the fields `connector_config_mirrormaker`, `connector_config_s3_sink`, `connector_config_iceberg_sink`.

Additional settings for the connector. ||
|| connector_config_s3_sink | **[ConnectorConfigS3SinkSpec](#yandex.cloud.mdb.kafka.v1.ConnectorConfigS3SinkSpec)**

Configuration of S3-Sink connector.

Includes only one of the fields `connector_config_mirrormaker`, `connector_config_s3_sink`, `connector_config_iceberg_sink`.

Additional settings for the connector. ||
|| connector_config_iceberg_sink | **[ConnectorConfigIcebergSinkSpec](#yandex.cloud.mdb.kafka.v1.ConnectorConfigIcebergSinkSpec)**

Configuration of Iceberg Sink connector.

Includes only one of the fields `connector_config_mirrormaker`, `connector_config_s3_sink`, `connector_config_iceberg_sink`.

Additional settings for the connector. ||
|#

## ConnectorConfigMirrorMakerSpec {#yandex.cloud.mdb.kafka.v1.ConnectorConfigMirrorMakerSpec}

#|
||Field | Description ||
|| source_cluster | **[ClusterConnectionSpec](#yandex.cloud.mdb.kafka.v1.ClusterConnectionSpec)**

Source cluster configuration for the MirrorMaker connector. ||
|| target_cluster | **[ClusterConnectionSpec](#yandex.cloud.mdb.kafka.v1.ClusterConnectionSpec)**

Target cluster configuration for the MirrorMaker connector. ||
|| topics | **string**

List of Kafka topics, separated by `,`. ||
|| replication_factor | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Replication factor for automatically created topics. ||
|#

## ClusterConnectionSpec {#yandex.cloud.mdb.kafka.v1.ClusterConnectionSpec}

#|
||Field | Description ||
|| alias | **string**

Alias of cluster connection configuration.
Examples: `source`, `target`. ||
|| this_cluster | **[ThisClusterSpec](#yandex.cloud.mdb.kafka.v1.ThisClusterSpec)**

Connection configuration of the cluster the connector belongs to. As all credentials are already known, leave this parameter empty.

Includes only one of the fields `this_cluster`, `external_cluster`.

Type of connection to Apache Kafka® cluster. ||
|| external_cluster | **[ExternalClusterConnectionSpec](#yandex.cloud.mdb.kafka.v1.ExternalClusterConnectionSpec)**

Configuration of connection to an external cluster with all the necessary credentials.

Includes only one of the fields `this_cluster`, `external_cluster`.

Type of connection to Apache Kafka® cluster. ||
|#

## ThisClusterSpec {#yandex.cloud.mdb.kafka.v1.ThisClusterSpec}

#|
||Field | Description ||
|| Empty | > ||
|#

## ExternalClusterConnectionSpec {#yandex.cloud.mdb.kafka.v1.ExternalClusterConnectionSpec}

#|
||Field | Description ||
|| bootstrap_servers | **string**

List of bootstrap servers of the cluster, separated by `,`. ||
|| sasl_username | **string**

SASL username to use for connection to the cluster. ||
|| sasl_password | **string**

SASL password to use for connection to the cluster. ||
|| sasl_mechanism | **string**

SASL mechanism to use for connection to the cluster. ||
|| security_protocol | **string**

Security protocol to use for connection to the cluster. ||
|| ssl_truststore_certificates | **string**

CA in PEM format to connect to external cluster.
Lines of certificate separated by '\n' symbol. ||
|#

## ConnectorConfigS3SinkSpec {#yandex.cloud.mdb.kafka.v1.ConnectorConfigS3SinkSpec}

Specification for Kafka S3-Sink Connector.

#|
||Field | Description ||
|| topics | **string**

Required field. List of Kafka topics, separated by ','. ||
|| file_compression_type | **string**

The compression type used for files put on GCS.
The supported values are: `gzip`, `snappy`, `zstd`, `none`.
Optional, the default is `none`. ||
|| file_max_records | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Max records per file. ||
|| s3_connection | **[S3ConnectionSpec](#yandex.cloud.mdb.kafka.v1.S3ConnectionSpec)**

Required field. Credentials for connecting to S3 storage. ||
|#

## S3ConnectionSpec {#yandex.cloud.mdb.kafka.v1.S3ConnectionSpec}

Specification for S3Connection -
settings of connection to AWS-compatible S3 storage, that
are source or target of Kafka S3-connectors.
YC Object Storage is AWS-compatible.

#|
||Field | Description ||
|| bucket_name | **string**

Name of the bucket. ||
|| external_s3 | **[ExternalS3StorageSpec](#yandex.cloud.mdb.kafka.v1.ExternalS3StorageSpec)**

Configuration for connection to S3 storage.

Includes only one of the fields `external_s3`. ||
|#

## ExternalS3StorageSpec {#yandex.cloud.mdb.kafka.v1.ExternalS3StorageSpec}

#|
||Field | Description ||
|| access_key_id | **string**

ID of the AWS access key. ||
|| secret_access_key | **string**

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

Includes only one of the fields `topics`, `topics_regex`. ||
|| topics_regex | **string**

Regex of Kafka topics.

Includes only one of the fields `topics`, `topics_regex`. ||
|| control_topic | **string**

Required field. Control topic name for Iceberg connector. ||
|| metastore_connection | **[MetastoreConnectionSpec](#yandex.cloud.mdb.kafka.v1.MetastoreConnectionSpec)**

Required field. Credentials for connecting to Managed Hive Metastore. ||
|| s3_connection | **[IcebergS3ConnectionSpec](#yandex.cloud.mdb.kafka.v1.IcebergS3ConnectionSpec)**

Required field. Credentials for connecting to S3 storage. ||
|| static_tables | **[StaticTablesSpec](#yandex.cloud.mdb.kafka.v1.StaticTablesSpec)**

Static table routing

Includes only one of the fields `static_tables`, `dynamic_tables`.

Table routing strategy ||
|| dynamic_tables | **[DynamicTablesSpec](#yandex.cloud.mdb.kafka.v1.DynamicTablesSpec)**

Dynamic table routing

Includes only one of the fields `static_tables`, `dynamic_tables`.

Table routing strategy ||
|| tables_config | **[IcebergTablesConfigSpec](#yandex.cloud.mdb.kafka.v1.IcebergTablesConfigSpec)**

Optional table settings ||
|| control_config | **[IcebergControlSpec](#yandex.cloud.mdb.kafka.v1.IcebergControlSpec)**

Optional control settings ||
|#

## MetastoreConnectionSpec {#yandex.cloud.mdb.kafka.v1.MetastoreConnectionSpec}

#|
||Field | Description ||
|| catalog_uri | **string**

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
|| external_s3 | **[ExternalIcebergS3StorageSpec](#yandex.cloud.mdb.kafka.v1.ExternalIcebergS3StorageSpec)**

Configuration for connection to S3 storage.

Includes only one of the fields `external_s3`. ||
|#

## ExternalIcebergS3StorageSpec {#yandex.cloud.mdb.kafka.v1.ExternalIcebergS3StorageSpec}

#|
||Field | Description ||
|| access_key_id | **string**

ID of the AWS access key. ||
|| secret_access_key | **string**

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
|| route_field | **string**

Field in the message to define the target table
The iceberg.tables.dynamic-enabled field is set to true ||
|#

## IcebergTablesConfigSpec {#yandex.cloud.mdb.kafka.v1.IcebergTablesConfigSpec}

#|
||Field | Description ||
|| default_commit_branch | **string**

Default Git-like branch name for Iceberg commits.
Default: "main" ||
|| default_id_columns | **string**

List of columns used as identifiers for upsert operations, separated by ','. ||
|| default_partition_by | **string**

Comma-separated list of columns or transform expressions for table partitioning.
Defines physical data layout for query optimization.
Examples:
- "date"
- "year,month"
- "year(timestamp),month(timestamp)"
- "days(timestamp)"
- "bucket(16,user_id)" ||
|| evolve_schema_enabled | **bool**

Enable automatic schema evolution.
Default: false ||
|| schema_force_optional | **bool**

Force all columns to be nullable (optional).
Default: false ||
|| schema_case_insensitive | **bool**

Enable case-insensitive field name matching.
Default: false ||
|#

## IcebergControlSpec {#yandex.cloud.mdb.kafka.v1.IcebergControlSpec}

#|
||Field | Description ||
|| group_id_prefix | **string**

Consumer group ID prefix for control topic.
Default: "cg-control" ||
|| commit_interval_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Interval between commits in milliseconds.
Default: 300000 (5 minutes) ||
|| commit_timeout_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Commit operation timeout in milliseconds.
Default: 30000 (30 seconds) ||
|| commit_threads | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Number of threads for commit operations.
Default: cores * 2 ||
|| transactional_prefix | **string**

Prefix for transactional operations.
Default: "" ||
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
  "metadata": "google.protobuf.Any",
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": "google.protobuf.Any"
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](../../../../api-design-guide/concepts/operation.md).

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
|| metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**

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
|| response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**

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