---
editable: false
sourcePath: en/_api-ref/trino/v1/api-ref/Catalog/create.md
---

# Managed Service for Trino API, REST: Catalog.Create

Creates a new Trino Catalog.

## HTTP request

```
POST https://trino.{{ api-host }}/managed-trino/v1/clusters/{clusterId}/catalogs
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the Trino Cluster where the catalog should be created. ||
|#

## Body parameters {#yandex.cloud.trino.v1.CreateCatalogRequest}

```json
{
  "catalog": {
    "name": "string",
    "connector": {
      // Includes only one of the fields `hive`, `iceberg`, `deltaLake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`
      "hive": {
        "metastore": {
          // Includes only one of the fields `hive`
          "hive": {
            // Includes only one of the fields `uri`
            "uri": "string"
            // end of the list of possible fields
          }
          // end of the list of possible fields
        },
        "filesystem": {
          // Includes only one of the fields `s3`, `externalS3`
          "s3": "object",
          "externalS3": {
            "awsAccessKey": "string",
            "awsSecretKey": "string",
            "awsEndpoint": "string",
            "awsRegion": "string"
          }
          // end of the list of possible fields
        },
        "additionalProperties": "object"
      },
      "iceberg": {
        "metastore": {
          // Includes only one of the fields `hive`
          "hive": {
            // Includes only one of the fields `uri`
            "uri": "string"
            // end of the list of possible fields
          }
          // end of the list of possible fields
        },
        "filesystem": {
          // Includes only one of the fields `s3`, `externalS3`
          "s3": "object",
          "externalS3": {
            "awsAccessKey": "string",
            "awsSecretKey": "string",
            "awsEndpoint": "string",
            "awsRegion": "string"
          }
          // end of the list of possible fields
        },
        "additionalProperties": "object"
      },
      "deltaLake": {
        "metastore": {
          // Includes only one of the fields `hive`
          "hive": {
            // Includes only one of the fields `uri`
            "uri": "string"
            // end of the list of possible fields
          }
          // end of the list of possible fields
        },
        "filesystem": {
          // Includes only one of the fields `s3`, `externalS3`
          "s3": "object",
          "externalS3": {
            "awsAccessKey": "string",
            "awsSecretKey": "string",
            "awsEndpoint": "string",
            "awsRegion": "string"
          }
          // end of the list of possible fields
        },
        "additionalProperties": "object"
      },
      "postgresql": {
        "connection": {
          // Includes only one of the fields `onPremise`, `connectionManager`
          "onPremise": {
            "connectionUrl": "string",
            "userName": "string",
            "password": "string"
          },
          "connectionManager": {
            "connectionId": "string",
            "database": "string",
            "connectionProperties": "object"
          }
          // end of the list of possible fields
        },
        "additionalProperties": "object"
      },
      "clickhouse": {
        "connection": {
          // Includes only one of the fields `onPremise`, `connectionManager`
          "onPremise": {
            "connectionUrl": "string",
            "userName": "string",
            "password": "string"
          },
          "connectionManager": {
            "connectionId": "string",
            "database": "string",
            "connectionProperties": "object"
          }
          // end of the list of possible fields
        },
        "additionalProperties": "object"
      },
      "tpch": {
        "additionalProperties": "object"
      },
      "tpcds": {
        "additionalProperties": "object"
      },
      "oracle": {
        "connection": {
          // Includes only one of the fields `onPremise`
          "onPremise": {
            "connectionUrl": "string",
            "userName": "string",
            "password": "string"
          }
          // end of the list of possible fields
        },
        "additionalProperties": "object"
      },
      "sqlserver": {
        "connection": {
          // Includes only one of the fields `onPremise`
          "onPremise": {
            "connectionUrl": "string",
            "userName": "string",
            "password": "string"
          }
          // end of the list of possible fields
        },
        "additionalProperties": "object"
      }
      // end of the list of possible fields
    },
    "description": "string",
    "labels": "object"
  }
}
```

#|
||Field | Description ||
|| catalog | **[CatalogSpec](#yandex.cloud.trino.v1.CatalogSpec)**

Required field. Specification of the catalog to be created. ||
|#

## CatalogSpec {#yandex.cloud.trino.v1.CatalogSpec}

CatalogSpec defines the desired state of a new catalog.

#|
||Field | Description ||
|| name | **string**

Required field. Name of the catalog.
Must be unique within a Trino cluster. ||
|| connector | **[Connector](#yandex.cloud.trino.v1.Connector)**

Required field. Connector backing this catalog. ||
|| description | **string**

Description of the catalog. ||
|| labels | **object** (map<**string**, **string**>)

Labels associated with the catalog. ||
|#

## Connector {#yandex.cloud.trino.v1.Connector}

Connector configuration. Exactly one connector type must be specified.

#|
||Field | Description ||
|| hive | **[HiveConnector](#yandex.cloud.trino.v1.HiveConnector)**

Hive connector configuration.

Includes only one of the fields `hive`, `iceberg`, `deltaLake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`. ||
|| iceberg | **[IcebergConnector](#yandex.cloud.trino.v1.IcebergConnector)**

Iceberg connector configuration.

Includes only one of the fields `hive`, `iceberg`, `deltaLake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`. ||
|| deltaLake | **[DeltaLakeConnector](#yandex.cloud.trino.v1.DeltaLakeConnector)**

Delta Lake connector configuration.

Includes only one of the fields `hive`, `iceberg`, `deltaLake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`. ||
|| postgresql | **[PostgresqlConnector](#yandex.cloud.trino.v1.PostgresqlConnector)**

PostgreSQL connector configuration.

Includes only one of the fields `hive`, `iceberg`, `deltaLake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`. ||
|| clickhouse | **[ClickhouseConnector](#yandex.cloud.trino.v1.ClickhouseConnector)**

ClickHouse connector configuration.

Includes only one of the fields `hive`, `iceberg`, `deltaLake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`. ||
|| tpch | **[TPCHConnector](#yandex.cloud.trino.v1.TPCHConnector)**

TPC-H connector for synthetic benchmarking.

Includes only one of the fields `hive`, `iceberg`, `deltaLake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`. ||
|| tpcds | **[TPCDSConnector](#yandex.cloud.trino.v1.TPCDSConnector)**

TPC-DS connector for synthetic benchmarking.

Includes only one of the fields `hive`, `iceberg`, `deltaLake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`. ||
|| oracle | **[OracleConnector](#yandex.cloud.trino.v1.OracleConnector)**

Oracle connector configuration for connecting to Oracle Database instances.

Includes only one of the fields `hive`, `iceberg`, `deltaLake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`. ||
|| sqlserver | **[SQLServerConnector](#yandex.cloud.trino.v1.SQLServerConnector)**

SQLServer connector configuration for connecting to SQLServer Database instances.

Includes only one of the fields `hive`, `iceberg`, `deltaLake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`. ||
|#

## HiveConnector {#yandex.cloud.trino.v1.HiveConnector}

#|
||Field | Description ||
|| metastore | **[Metastore](#yandex.cloud.trino.v1.Metastore)**

Required field. Metastore configuration. ||
|| filesystem | **[FileSystem](#yandex.cloud.trino.v1.FileSystem)**

Required field. File system configuration. ||
|| additionalProperties | **object** (map<**string**, **string**>)

Additional properties. ||
|#

## Metastore {#yandex.cloud.trino.v1.Metastore}

Metastore configuration.

#|
||Field | Description ||
|| hive | **[HiveMetastore](#yandex.cloud.trino.v1.Metastore.HiveMetastore)**

Includes only one of the fields `hive`. ||
|#

## HiveMetastore {#yandex.cloud.trino.v1.Metastore.HiveMetastore}

Configuration of Hive's metastore type.

#|
||Field | Description ||
|| uri | **string**

URI or cluster ID of the Hive Metastore.

Includes only one of the fields `uri`. ||
|#

## FileSystem {#yandex.cloud.trino.v1.FileSystem}

Configuration of file system used by a connector.

#|
||Field | Description ||
|| s3 | **object**

Includes only one of the fields `s3`, `externalS3`. ||
|| externalS3 | **[ExternalS3FileSystem](#yandex.cloud.trino.v1.FileSystem.ExternalS3FileSystem)**

Includes only one of the fields `s3`, `externalS3`. ||
|#

## ExternalS3FileSystem {#yandex.cloud.trino.v1.FileSystem.ExternalS3FileSystem}

Describes External S3 compatible file system.

#|
||Field | Description ||
|| awsAccessKey | **string**

Required field.  ||
|| awsSecretKey | **string**

Required field.  ||
|| awsEndpoint | **string**

Required field.  ||
|| awsRegion | **string**

Required field.  ||
|#

## IcebergConnector {#yandex.cloud.trino.v1.IcebergConnector}

#|
||Field | Description ||
|| metastore | **[Metastore](#yandex.cloud.trino.v1.Metastore)**

Required field. Metastore configuration. ||
|| filesystem | **[FileSystem](#yandex.cloud.trino.v1.FileSystem)**

Required field. File system configuration. ||
|| additionalProperties | **object** (map<**string**, **string**>)

Additional properties. ||
|#

## DeltaLakeConnector {#yandex.cloud.trino.v1.DeltaLakeConnector}

#|
||Field | Description ||
|| metastore | **[Metastore](#yandex.cloud.trino.v1.Metastore)**

Required field. Metastore configuration. ||
|| filesystem | **[FileSystem](#yandex.cloud.trino.v1.FileSystem)**

Required field. File system configuration. ||
|| additionalProperties | **object** (map<**string**, **string**>)

Additional properties. ||
|#

## PostgresqlConnector {#yandex.cloud.trino.v1.PostgresqlConnector}

#|
||Field | Description ||
|| connection | **[PostgresqlConnection](#yandex.cloud.trino.v1.PostgresqlConnection)**

Connection configuration. ||
|| additionalProperties | **object** (map<**string**, **string**>)

Additional properties. ||
|#

## PostgresqlConnection {#yandex.cloud.trino.v1.PostgresqlConnection}

#|
||Field | Description ||
|| onPremise | **[OnPremise](#yandex.cloud.trino.v1.PostgresqlConnection.OnPremise)**

Includes only one of the fields `onPremise`, `connectionManager`. ||
|| connectionManager | **[ConnectionManager](#yandex.cloud.trino.v1.PostgresqlConnection.ConnectionManager)**

Includes only one of the fields `onPremise`, `connectionManager`. ||
|#

## OnPremise {#yandex.cloud.trino.v1.PostgresqlConnection.OnPremise}

#|
||Field | Description ||
|| connectionUrl | **string**

Required field. Connection to the Postgresql. ||
|| userName | **string**

Required field. Name of the Postgresql user. ||
|| password | **string**

Required field. Password of the Postgresql user. ||
|#

## ConnectionManager {#yandex.cloud.trino.v1.PostgresqlConnection.ConnectionManager}

#|
||Field | Description ||
|| connectionId | **string**

Required field. Connection ID. ||
|| database | **string**

Required field. Database. ||
|| connectionProperties | **object** (map<**string**, **string**>)

Additional connection properties. ||
|#

## ClickhouseConnector {#yandex.cloud.trino.v1.ClickhouseConnector}

#|
||Field | Description ||
|| connection | **[ClickhouseConnection](#yandex.cloud.trino.v1.ClickhouseConnection)**

Connection configuration. ||
|| additionalProperties | **object** (map<**string**, **string**>)

Additional properties. ||
|#

## ClickhouseConnection {#yandex.cloud.trino.v1.ClickhouseConnection}

#|
||Field | Description ||
|| onPremise | **[OnPremise](#yandex.cloud.trino.v1.ClickhouseConnection.OnPremise)**

Includes only one of the fields `onPremise`, `connectionManager`. ||
|| connectionManager | **[ConnectionManager](#yandex.cloud.trino.v1.ClickhouseConnection.ConnectionManager)**

Includes only one of the fields `onPremise`, `connectionManager`. ||
|#

## OnPremise {#yandex.cloud.trino.v1.ClickhouseConnection.OnPremise}

#|
||Field | Description ||
|| connectionUrl | **string**

Required field. Connection to the Clickhouse. ||
|| userName | **string**

Required field. Name of the Clickhouse user. ||
|| password | **string**

Required field. Password of the Clickhouse user. ||
|#

## ConnectionManager {#yandex.cloud.trino.v1.ClickhouseConnection.ConnectionManager}

#|
||Field | Description ||
|| connectionId | **string**

Required field. Connection ID. ||
|| database | **string**

Required field. Database. ||
|| connectionProperties | **object** (map<**string**, **string**>)

Additional connection properties. ||
|#

## TPCHConnector {#yandex.cloud.trino.v1.TPCHConnector}

#|
||Field | Description ||
|| additionalProperties | **object** (map<**string**, **string**>)

Additional properties. ||
|#

## TPCDSConnector {#yandex.cloud.trino.v1.TPCDSConnector}

#|
||Field | Description ||
|| additionalProperties | **object** (map<**string**, **string**>)

Additional properties. ||
|#

## OracleConnector {#yandex.cloud.trino.v1.OracleConnector}

#|
||Field | Description ||
|| connection | **[OracleConnection](#yandex.cloud.trino.v1.OracleConnection)**

Connection configuration. ||
|| additionalProperties | **object** (map<**string**, **string**>)

Additional properties. ||
|#

## OracleConnection {#yandex.cloud.trino.v1.OracleConnection}

#|
||Field | Description ||
|| onPremise | **[OnPremise](#yandex.cloud.trino.v1.OracleConnection.OnPremise)**

Includes only one of the fields `onPremise`. ||
|#

## OnPremise {#yandex.cloud.trino.v1.OracleConnection.OnPremise}

#|
||Field | Description ||
|| connectionUrl | **string**

Required field. Connection to the Oracle. ||
|| userName | **string**

Required field. Name of the Oracle user. ||
|| password | **string**

Required field. Password of the Oracle user. ||
|#

## SQLServerConnector {#yandex.cloud.trino.v1.SQLServerConnector}

#|
||Field | Description ||
|| connection | **[SQLServerConnection](#yandex.cloud.trino.v1.SQLServerConnection)**

Connection configuration. ||
|| additionalProperties | **object** (map<**string**, **string**>)

Additional properties. ||
|#

## SQLServerConnection {#yandex.cloud.trino.v1.SQLServerConnection}

#|
||Field | Description ||
|| onPremise | **[OnPremise](#yandex.cloud.trino.v1.SQLServerConnection.OnPremise)**

Includes only one of the fields `onPremise`. ||
|#

## OnPremise {#yandex.cloud.trino.v1.SQLServerConnection.OnPremise}

#|
||Field | Description ||
|| connectionUrl | **string**

Required field. Connection to the SQLServer. ||
|| userName | **string**

Required field. Name of the SQLServer user. ||
|| password | **string**

Required field. Password of the SQLServer user. ||
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
    "catalogId": "string"
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
    "id": "string",
    "name": "string",
    "connector": {
      // Includes only one of the fields `hive`, `iceberg`, `deltaLake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`
      "hive": {
        "metastore": {
          // Includes only one of the fields `hive`
          "hive": {
            // Includes only one of the fields `uri`
            "uri": "string"
            // end of the list of possible fields
          }
          // end of the list of possible fields
        },
        "filesystem": {
          // Includes only one of the fields `s3`, `externalS3`
          "s3": "object",
          "externalS3": {
            "awsAccessKey": "string",
            "awsSecretKey": "string",
            "awsEndpoint": "string",
            "awsRegion": "string"
          }
          // end of the list of possible fields
        },
        "additionalProperties": "object"
      },
      "iceberg": {
        "metastore": {
          // Includes only one of the fields `hive`
          "hive": {
            // Includes only one of the fields `uri`
            "uri": "string"
            // end of the list of possible fields
          }
          // end of the list of possible fields
        },
        "filesystem": {
          // Includes only one of the fields `s3`, `externalS3`
          "s3": "object",
          "externalS3": {
            "awsAccessKey": "string",
            "awsSecretKey": "string",
            "awsEndpoint": "string",
            "awsRegion": "string"
          }
          // end of the list of possible fields
        },
        "additionalProperties": "object"
      },
      "deltaLake": {
        "metastore": {
          // Includes only one of the fields `hive`
          "hive": {
            // Includes only one of the fields `uri`
            "uri": "string"
            // end of the list of possible fields
          }
          // end of the list of possible fields
        },
        "filesystem": {
          // Includes only one of the fields `s3`, `externalS3`
          "s3": "object",
          "externalS3": {
            "awsAccessKey": "string",
            "awsSecretKey": "string",
            "awsEndpoint": "string",
            "awsRegion": "string"
          }
          // end of the list of possible fields
        },
        "additionalProperties": "object"
      },
      "postgresql": {
        "connection": {
          // Includes only one of the fields `onPremise`, `connectionManager`
          "onPremise": {
            "connectionUrl": "string",
            "userName": "string",
            "password": "string"
          },
          "connectionManager": {
            "connectionId": "string",
            "database": "string",
            "connectionProperties": "object"
          }
          // end of the list of possible fields
        },
        "additionalProperties": "object"
      },
      "clickhouse": {
        "connection": {
          // Includes only one of the fields `onPremise`, `connectionManager`
          "onPremise": {
            "connectionUrl": "string",
            "userName": "string",
            "password": "string"
          },
          "connectionManager": {
            "connectionId": "string",
            "database": "string",
            "connectionProperties": "object"
          }
          // end of the list of possible fields
        },
        "additionalProperties": "object"
      },
      "tpch": {
        "additionalProperties": "object"
      },
      "tpcds": {
        "additionalProperties": "object"
      },
      "oracle": {
        "connection": {
          // Includes only one of the fields `onPremise`
          "onPremise": {
            "connectionUrl": "string",
            "userName": "string",
            "password": "string"
          }
          // end of the list of possible fields
        },
        "additionalProperties": "object"
      },
      "sqlserver": {
        "connection": {
          // Includes only one of the fields `onPremise`
          "onPremise": {
            "connectionUrl": "string",
            "userName": "string",
            "password": "string"
          }
          // end of the list of possible fields
        },
        "additionalProperties": "object"
      }
      // end of the list of possible fields
    },
    "description": "string",
    "labels": "object"
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
|| metadata | **[CreateCatalogMetadata](#yandex.cloud.trino.v1.CreateCatalogMetadata)**

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
|| response | **[Catalog](#yandex.cloud.trino.v1.Catalog)**

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

## CreateCatalogMetadata {#yandex.cloud.trino.v1.CreateCatalogMetadata}

#|
||Field | Description ||
|| clusterId | **string**

ID of the Trino cluster where a catalog is being created. ||
|| catalogId | **string**

ID of the catalog that is being created. ||
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

## Catalog {#yandex.cloud.trino.v1.Catalog}

Catalog is a logical Trino catalog backed by a specific connector.

#|
||Field | Description ||
|| id | **string**

ID of the catalog. ||
|| name | **string**

Name of the catalog. ||
|| connector | **[Connector](#yandex.cloud.trino.v1.Connector2)**

Connector backing this catalog. ||
|| description | **string**

Description of the catalog. ||
|| labels | **object** (map<**string**, **string**>)

Labels associated with the catalog. ||
|#

## Connector {#yandex.cloud.trino.v1.Connector2}

Connector configuration. Exactly one connector type must be specified.

#|
||Field | Description ||
|| hive | **[HiveConnector](#yandex.cloud.trino.v1.HiveConnector2)**

Hive connector configuration.

Includes only one of the fields `hive`, `iceberg`, `deltaLake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`. ||
|| iceberg | **[IcebergConnector](#yandex.cloud.trino.v1.IcebergConnector2)**

Iceberg connector configuration.

Includes only one of the fields `hive`, `iceberg`, `deltaLake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`. ||
|| deltaLake | **[DeltaLakeConnector](#yandex.cloud.trino.v1.DeltaLakeConnector2)**

Delta Lake connector configuration.

Includes only one of the fields `hive`, `iceberg`, `deltaLake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`. ||
|| postgresql | **[PostgresqlConnector](#yandex.cloud.trino.v1.PostgresqlConnector2)**

PostgreSQL connector configuration.

Includes only one of the fields `hive`, `iceberg`, `deltaLake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`. ||
|| clickhouse | **[ClickhouseConnector](#yandex.cloud.trino.v1.ClickhouseConnector2)**

ClickHouse connector configuration.

Includes only one of the fields `hive`, `iceberg`, `deltaLake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`. ||
|| tpch | **[TPCHConnector](#yandex.cloud.trino.v1.TPCHConnector2)**

TPC-H connector for synthetic benchmarking.

Includes only one of the fields `hive`, `iceberg`, `deltaLake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`. ||
|| tpcds | **[TPCDSConnector](#yandex.cloud.trino.v1.TPCDSConnector2)**

TPC-DS connector for synthetic benchmarking.

Includes only one of the fields `hive`, `iceberg`, `deltaLake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`. ||
|| oracle | **[OracleConnector](#yandex.cloud.trino.v1.OracleConnector2)**

Oracle connector configuration for connecting to Oracle Database instances.

Includes only one of the fields `hive`, `iceberg`, `deltaLake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`. ||
|| sqlserver | **[SQLServerConnector](#yandex.cloud.trino.v1.SQLServerConnector2)**

SQLServer connector configuration for connecting to SQLServer Database instances.

Includes only one of the fields `hive`, `iceberg`, `deltaLake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`. ||
|#

## HiveConnector {#yandex.cloud.trino.v1.HiveConnector2}

#|
||Field | Description ||
|| metastore | **[Metastore](#yandex.cloud.trino.v1.Metastore2)**

Required field. Metastore configuration. ||
|| filesystem | **[FileSystem](#yandex.cloud.trino.v1.FileSystem2)**

Required field. File system configuration. ||
|| additionalProperties | **object** (map<**string**, **string**>)

Additional properties. ||
|#

## Metastore {#yandex.cloud.trino.v1.Metastore2}

Metastore configuration.

#|
||Field | Description ||
|| hive | **[HiveMetastore](#yandex.cloud.trino.v1.Metastore.HiveMetastore2)**

Includes only one of the fields `hive`. ||
|#

## HiveMetastore {#yandex.cloud.trino.v1.Metastore.HiveMetastore2}

Configuration of Hive's metastore type.

#|
||Field | Description ||
|| uri | **string**

URI or cluster ID of the Hive Metastore.

Includes only one of the fields `uri`. ||
|#

## FileSystem {#yandex.cloud.trino.v1.FileSystem2}

Configuration of file system used by a connector.

#|
||Field | Description ||
|| s3 | **object**

Includes only one of the fields `s3`, `externalS3`. ||
|| externalS3 | **[ExternalS3FileSystem](#yandex.cloud.trino.v1.FileSystem.ExternalS3FileSystem2)**

Includes only one of the fields `s3`, `externalS3`. ||
|#

## ExternalS3FileSystem {#yandex.cloud.trino.v1.FileSystem.ExternalS3FileSystem2}

Describes External S3 compatible file system.

#|
||Field | Description ||
|| awsAccessKey | **string**

Required field.  ||
|| awsSecretKey | **string**

Required field.  ||
|| awsEndpoint | **string**

Required field.  ||
|| awsRegion | **string**

Required field.  ||
|#

## IcebergConnector {#yandex.cloud.trino.v1.IcebergConnector2}

#|
||Field | Description ||
|| metastore | **[Metastore](#yandex.cloud.trino.v1.Metastore2)**

Required field. Metastore configuration. ||
|| filesystem | **[FileSystem](#yandex.cloud.trino.v1.FileSystem2)**

Required field. File system configuration. ||
|| additionalProperties | **object** (map<**string**, **string**>)

Additional properties. ||
|#

## DeltaLakeConnector {#yandex.cloud.trino.v1.DeltaLakeConnector2}

#|
||Field | Description ||
|| metastore | **[Metastore](#yandex.cloud.trino.v1.Metastore2)**

Required field. Metastore configuration. ||
|| filesystem | **[FileSystem](#yandex.cloud.trino.v1.FileSystem2)**

Required field. File system configuration. ||
|| additionalProperties | **object** (map<**string**, **string**>)

Additional properties. ||
|#

## PostgresqlConnector {#yandex.cloud.trino.v1.PostgresqlConnector2}

#|
||Field | Description ||
|| connection | **[PostgresqlConnection](#yandex.cloud.trino.v1.PostgresqlConnection2)**

Connection configuration. ||
|| additionalProperties | **object** (map<**string**, **string**>)

Additional properties. ||
|#

## PostgresqlConnection {#yandex.cloud.trino.v1.PostgresqlConnection2}

#|
||Field | Description ||
|| onPremise | **[OnPremise](#yandex.cloud.trino.v1.PostgresqlConnection.OnPremise2)**

Includes only one of the fields `onPremise`, `connectionManager`. ||
|| connectionManager | **[ConnectionManager](#yandex.cloud.trino.v1.PostgresqlConnection.ConnectionManager2)**

Includes only one of the fields `onPremise`, `connectionManager`. ||
|#

## OnPremise {#yandex.cloud.trino.v1.PostgresqlConnection.OnPremise2}

#|
||Field | Description ||
|| connectionUrl | **string**

Required field. Connection to the Postgresql. ||
|| userName | **string**

Required field. Name of the Postgresql user. ||
|| password | **string**

Required field. Password of the Postgresql user. ||
|#

## ConnectionManager {#yandex.cloud.trino.v1.PostgresqlConnection.ConnectionManager2}

#|
||Field | Description ||
|| connectionId | **string**

Required field. Connection ID. ||
|| database | **string**

Required field. Database. ||
|| connectionProperties | **object** (map<**string**, **string**>)

Additional connection properties. ||
|#

## ClickhouseConnector {#yandex.cloud.trino.v1.ClickhouseConnector2}

#|
||Field | Description ||
|| connection | **[ClickhouseConnection](#yandex.cloud.trino.v1.ClickhouseConnection2)**

Connection configuration. ||
|| additionalProperties | **object** (map<**string**, **string**>)

Additional properties. ||
|#

## ClickhouseConnection {#yandex.cloud.trino.v1.ClickhouseConnection2}

#|
||Field | Description ||
|| onPremise | **[OnPremise](#yandex.cloud.trino.v1.ClickhouseConnection.OnPremise2)**

Includes only one of the fields `onPremise`, `connectionManager`. ||
|| connectionManager | **[ConnectionManager](#yandex.cloud.trino.v1.ClickhouseConnection.ConnectionManager2)**

Includes only one of the fields `onPremise`, `connectionManager`. ||
|#

## OnPremise {#yandex.cloud.trino.v1.ClickhouseConnection.OnPremise2}

#|
||Field | Description ||
|| connectionUrl | **string**

Required field. Connection to the Clickhouse. ||
|| userName | **string**

Required field. Name of the Clickhouse user. ||
|| password | **string**

Required field. Password of the Clickhouse user. ||
|#

## ConnectionManager {#yandex.cloud.trino.v1.ClickhouseConnection.ConnectionManager2}

#|
||Field | Description ||
|| connectionId | **string**

Required field. Connection ID. ||
|| database | **string**

Required field. Database. ||
|| connectionProperties | **object** (map<**string**, **string**>)

Additional connection properties. ||
|#

## TPCHConnector {#yandex.cloud.trino.v1.TPCHConnector2}

#|
||Field | Description ||
|| additionalProperties | **object** (map<**string**, **string**>)

Additional properties. ||
|#

## TPCDSConnector {#yandex.cloud.trino.v1.TPCDSConnector2}

#|
||Field | Description ||
|| additionalProperties | **object** (map<**string**, **string**>)

Additional properties. ||
|#

## OracleConnector {#yandex.cloud.trino.v1.OracleConnector2}

#|
||Field | Description ||
|| connection | **[OracleConnection](#yandex.cloud.trino.v1.OracleConnection2)**

Connection configuration. ||
|| additionalProperties | **object** (map<**string**, **string**>)

Additional properties. ||
|#

## OracleConnection {#yandex.cloud.trino.v1.OracleConnection2}

#|
||Field | Description ||
|| onPremise | **[OnPremise](#yandex.cloud.trino.v1.OracleConnection.OnPremise2)**

Includes only one of the fields `onPremise`. ||
|#

## OnPremise {#yandex.cloud.trino.v1.OracleConnection.OnPremise2}

#|
||Field | Description ||
|| connectionUrl | **string**

Required field. Connection to the Oracle. ||
|| userName | **string**

Required field. Name of the Oracle user. ||
|| password | **string**

Required field. Password of the Oracle user. ||
|#

## SQLServerConnector {#yandex.cloud.trino.v1.SQLServerConnector2}

#|
||Field | Description ||
|| connection | **[SQLServerConnection](#yandex.cloud.trino.v1.SQLServerConnection2)**

Connection configuration. ||
|| additionalProperties | **object** (map<**string**, **string**>)

Additional properties. ||
|#

## SQLServerConnection {#yandex.cloud.trino.v1.SQLServerConnection2}

#|
||Field | Description ||
|| onPremise | **[OnPremise](#yandex.cloud.trino.v1.SQLServerConnection.OnPremise2)**

Includes only one of the fields `onPremise`. ||
|#

## OnPremise {#yandex.cloud.trino.v1.SQLServerConnection.OnPremise2}

#|
||Field | Description ||
|| connectionUrl | **string**

Required field. Connection to the SQLServer. ||
|| userName | **string**

Required field. Name of the SQLServer user. ||
|| password | **string**

Required field. Password of the SQLServer user. ||
|#