---
editable: false
---

# Managed Service for Trino API, gRPC: CatalogService.Get

Returns the specified Trino Catalog resource.

## gRPC request

**rpc Get ([GetCatalogRequest](#yandex.cloud.trino.v1.GetCatalogRequest)) returns ([Catalog](#yandex.cloud.trino.v1.Catalog))**

## GetCatalogRequest {#yandex.cloud.trino.v1.GetCatalogRequest}

```json
{
  "cluster_id": "string",
  "catalog_id": "string"
}
```

#|
||Field | Description ||
|| cluster_id | **string**

Required field. ID of the Trino Cluster resource which contains the requested catalog.

The maximum string length in characters is 50. ||
|| catalog_id | **string**

Required field. ID of the Trino Catalog resource.

The maximum string length in characters is 50. ||
|#

## Catalog {#yandex.cloud.trino.v1.Catalog}

```json
{
  "id": "string",
  "name": "string",
  "connector": {
    // Includes only one of the fields `hive`, `iceberg`, `delta_lake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`, `hudi`, `mysql`, `greenplum`
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
        // Includes only one of the fields `s3`, `external_s3`
        "s3": "S3FileSystem",
        "external_s3": {
          "aws_access_key": "string",
          "aws_secret_key": "string",
          "aws_endpoint": "string",
          "aws_region": "string"
        }
        // end of the list of possible fields
      },
      "additional_properties": "map<string, string>"
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
        // Includes only one of the fields `s3`, `external_s3`
        "s3": "S3FileSystem",
        "external_s3": {
          "aws_access_key": "string",
          "aws_secret_key": "string",
          "aws_endpoint": "string",
          "aws_region": "string"
        }
        // end of the list of possible fields
      },
      "additional_properties": "map<string, string>"
    },
    "delta_lake": {
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
        // Includes only one of the fields `s3`, `external_s3`
        "s3": "S3FileSystem",
        "external_s3": {
          "aws_access_key": "string",
          "aws_secret_key": "string",
          "aws_endpoint": "string",
          "aws_region": "string"
        }
        // end of the list of possible fields
      },
      "additional_properties": "map<string, string>"
    },
    "postgresql": {
      "connection": {
        // Includes only one of the fields `on_premise`, `connection_manager`
        "on_premise": {
          "connection_url": "string",
          "user_name": "string",
          "password": "string"
        },
        "connection_manager": {
          "connection_id": "string",
          "database": "string",
          "connection_properties": "map<string, string>"
        }
        // end of the list of possible fields
      },
      "additional_properties": "map<string, string>"
    },
    "clickhouse": {
      "connection": {
        // Includes only one of the fields `on_premise`, `connection_manager`
        "on_premise": {
          "connection_url": "string",
          "user_name": "string",
          "password": "string"
        },
        "connection_manager": {
          "connection_id": "string",
          "database": "string",
          "connection_properties": "map<string, string>"
        }
        // end of the list of possible fields
      },
      "additional_properties": "map<string, string>"
    },
    "tpch": {
      "additional_properties": "map<string, string>"
    },
    "tpcds": {
      "additional_properties": "map<string, string>"
    },
    "oracle": {
      "connection": {
        // Includes only one of the fields `on_premise`
        "on_premise": {
          "connection_url": "string",
          "user_name": "string",
          "password": "string"
        }
        // end of the list of possible fields
      },
      "additional_properties": "map<string, string>"
    },
    "sqlserver": {
      "connection": {
        // Includes only one of the fields `on_premise`
        "on_premise": {
          "connection_url": "string",
          "user_name": "string",
          "password": "string"
        }
        // end of the list of possible fields
      },
      "additional_properties": "map<string, string>"
    },
    "hudi": {
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
        // Includes only one of the fields `s3`, `external_s3`
        "s3": "S3FileSystem",
        "external_s3": {
          "aws_access_key": "string",
          "aws_secret_key": "string",
          "aws_endpoint": "string",
          "aws_region": "string"
        }
        // end of the list of possible fields
      },
      "additional_properties": "map<string, string>"
    },
    "mysql": {
      "connection": {
        // Includes only one of the fields `on_premise`, `connection_manager`
        "on_premise": {
          "connection_url": "string",
          "user_name": "string",
          "password": "string"
        },
        "connection_manager": {
          "connection_id": "string",
          "connection_properties": "map<string, string>"
        }
        // end of the list of possible fields
      },
      "additional_properties": "map<string, string>"
    },
    "greenplum": {
      "connection": {
        // Includes only one of the fields `on_premise`, `connection_manager`
        "on_premise": {
          "connection_url": "string",
          "user_name": "string",
          "password": "string"
        },
        "connection_manager": {
          "connection_id": "string",
          "database": "string",
          "connection_properties": "map<string, string>"
        }
        // end of the list of possible fields
      },
      "additional_properties": "map<string, string>"
    }
    // end of the list of possible fields
  },
  "description": "string",
  "labels": "map<string, string>"
}
```

Catalog is a logical Trino catalog backed by a specific connector.

#|
||Field | Description ||
|| id | **string**

ID of the catalog. ||
|| name | **string**

Name of the catalog. ||
|| connector | **[Connector](#yandex.cloud.trino.v1.Connector)**

Connector backing this catalog. ||
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

Includes only one of the fields `hive`, `iceberg`, `delta_lake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`, `hudi`, `mysql`, `greenplum`. ||
|| iceberg | **[IcebergConnector](#yandex.cloud.trino.v1.IcebergConnector)**

Iceberg connector configuration.

Includes only one of the fields `hive`, `iceberg`, `delta_lake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`, `hudi`, `mysql`, `greenplum`. ||
|| delta_lake | **[DeltaLakeConnector](#yandex.cloud.trino.v1.DeltaLakeConnector)**

Delta Lake connector configuration.

Includes only one of the fields `hive`, `iceberg`, `delta_lake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`, `hudi`, `mysql`, `greenplum`. ||
|| postgresql | **[PostgresqlConnector](#yandex.cloud.trino.v1.PostgresqlConnector)**

PostgreSQL connector configuration.

Includes only one of the fields `hive`, `iceberg`, `delta_lake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`, `hudi`, `mysql`, `greenplum`. ||
|| clickhouse | **[ClickhouseConnector](#yandex.cloud.trino.v1.ClickhouseConnector)**

ClickHouse connector configuration.

Includes only one of the fields `hive`, `iceberg`, `delta_lake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`, `hudi`, `mysql`, `greenplum`. ||
|| tpch | **[TPCHConnector](#yandex.cloud.trino.v1.TPCHConnector)**

TPC-H connector for synthetic benchmarking.

Includes only one of the fields `hive`, `iceberg`, `delta_lake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`, `hudi`, `mysql`, `greenplum`. ||
|| tpcds | **[TPCDSConnector](#yandex.cloud.trino.v1.TPCDSConnector)**

TPC-DS connector for synthetic benchmarking.

Includes only one of the fields `hive`, `iceberg`, `delta_lake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`, `hudi`, `mysql`, `greenplum`. ||
|| oracle | **[OracleConnector](#yandex.cloud.trino.v1.OracleConnector)**

Oracle connector configuration for connecting to Oracle Database instances.

Includes only one of the fields `hive`, `iceberg`, `delta_lake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`, `hudi`, `mysql`, `greenplum`. ||
|| sqlserver | **[SQLServerConnector](#yandex.cloud.trino.v1.SQLServerConnector)**

SQLServer connector configuration for connecting to SQLServer Database instances.

Includes only one of the fields `hive`, `iceberg`, `delta_lake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`, `hudi`, `mysql`, `greenplum`. ||
|| hudi | **[HudiConnector](#yandex.cloud.trino.v1.HudiConnector)**

Hudi connector configuration.

Includes only one of the fields `hive`, `iceberg`, `delta_lake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`, `hudi`, `mysql`, `greenplum`. ||
|| mysql | **[MysqlConnector](#yandex.cloud.trino.v1.MysqlConnector)**

MySQL connector configuration for connecting to MySQL Database instances.

Includes only one of the fields `hive`, `iceberg`, `delta_lake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`, `hudi`, `mysql`, `greenplum`. ||
|| greenplum | **[GreenplumConnector](#yandex.cloud.trino.v1.GreenplumConnector)**

Greenplum connector configuration for connecting to Greenplum or Cloudberry Database instances.

Includes only one of the fields `hive`, `iceberg`, `delta_lake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`, `hudi`, `mysql`, `greenplum`. ||
|#

## HiveConnector {#yandex.cloud.trino.v1.HiveConnector}

#|
||Field | Description ||
|| metastore | **[Metastore](#yandex.cloud.trino.v1.Metastore)**

Required field. Metastore configuration. ||
|| filesystem | **[FileSystem](#yandex.cloud.trino.v1.FileSystem)**

Required field. File system configuration. ||
|| additional_properties | **object** (map<**string**, **string**>)

Additional properties.

No more than 256 per resource. The maximum string length in characters for each value is 128. Each value must match the regular expression ` [-_0-9a-zA-Z.,:\/_ ]* `. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-z][-_0-9a-z.]* `. ||
|#

## Metastore {#yandex.cloud.trino.v1.Metastore}

Metastore configuration.

#|
||Field | Description ||
|| hive | **[HiveMetastore](#yandex.cloud.trino.v1.Metastore.HiveMetastore)**

Apache Hive Metastore.

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
|| s3 | **[S3FileSystem](#yandex.cloud.trino.v1.FileSystem.S3FileSystem)**

Yandex Cloud S3 filesystem.

Includes only one of the fields `s3`, `external_s3`. ||
|| external_s3 | **[ExternalS3FileSystem](#yandex.cloud.trino.v1.FileSystem.ExternalS3FileSystem)**

External S3 filesystem.

Includes only one of the fields `s3`, `external_s3`. ||
|#

## S3FileSystem {#yandex.cloud.trino.v1.FileSystem.S3FileSystem}

Describes YandexCloud native S3 file system.
Currently does not require configuration.

#|
||Field | Description ||
|| Empty | > ||
|#

## ExternalS3FileSystem {#yandex.cloud.trino.v1.FileSystem.ExternalS3FileSystem}

Describes External S3 compatible file system.

#|
||Field | Description ||
|| aws_access_key | **string**

Required field. AWS access key. ||
|| aws_secret_key | **string**

Required field. AWS secret key. ||
|| aws_endpoint | **string**

Required field. AWS endpoint. ||
|| aws_region | **string**

Required field. AWS region. ||
|#

## IcebergConnector {#yandex.cloud.trino.v1.IcebergConnector}

#|
||Field | Description ||
|| metastore | **[Metastore](#yandex.cloud.trino.v1.Metastore)**

Required field. Metastore configuration. ||
|| filesystem | **[FileSystem](#yandex.cloud.trino.v1.FileSystem)**

Required field. File system configuration. ||
|| additional_properties | **object** (map<**string**, **string**>)

Additional properties.

No more than 256 per resource. The maximum string length in characters for each value is 128. Each value must match the regular expression ` [-_0-9a-zA-Z.,:\/_ ]* `. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-z][-_0-9a-z.]* `. ||
|#

## DeltaLakeConnector {#yandex.cloud.trino.v1.DeltaLakeConnector}

#|
||Field | Description ||
|| metastore | **[Metastore](#yandex.cloud.trino.v1.Metastore)**

Required field. Metastore configuration. ||
|| filesystem | **[FileSystem](#yandex.cloud.trino.v1.FileSystem)**

Required field. File system configuration. ||
|| additional_properties | **object** (map<**string**, **string**>)

Additional properties.

No more than 256 per resource. The maximum string length in characters for each value is 128. Each value must match the regular expression ` [-_0-9a-zA-Z.,:\/_ ]* `. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-z][-_0-9a-z.]* `. ||
|#

## PostgresqlConnector {#yandex.cloud.trino.v1.PostgresqlConnector}

#|
||Field | Description ||
|| connection | **[PostgresqlConnection](#yandex.cloud.trino.v1.PostgresqlConnection)**

Connection configuration. ||
|| additional_properties | **object** (map<**string**, **string**>)

Additional properties.

No more than 256 per resource. The maximum string length in characters for each value is 128. Each value must match the regular expression ` [-_0-9a-zA-Z.,:\/_ ]* `. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-z][-_0-9a-z.]* `. ||
|#

## PostgresqlConnection {#yandex.cloud.trino.v1.PostgresqlConnection}

#|
||Field | Description ||
|| on_premise | **[OnPremise](#yandex.cloud.trino.v1.PostgresqlConnection.OnPremise)**

Connection configured manually.

Includes only one of the fields `on_premise`, `connection_manager`. ||
|| connection_manager | **[ConnectionManager](#yandex.cloud.trino.v1.PostgresqlConnection.ConnectionManager)**

Connection configured using Yandex Cloud Connection Manager.

Includes only one of the fields `on_premise`, `connection_manager`. ||
|#

## OnPremise {#yandex.cloud.trino.v1.PostgresqlConnection.OnPremise}

#|
||Field | Description ||
|| connection_url | **string**

Required field. Connection to the Postgresql.

Value must match the regular expression ` ^jdbc:postgresql://(?:.+:\d+)/(?:.*)$ `. ||
|| user_name | **string**

Required field. Name of the Postgresql user.

The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `. ||
|| password | **string**

Required field. Password of the Postgresql user.

The string length in characters must be 0-128. ||
|#

## ConnectionManager {#yandex.cloud.trino.v1.PostgresqlConnection.ConnectionManager}

#|
||Field | Description ||
|| connection_id | **string**

Required field. Connection ID.

The string length in characters must be 1-50. ||
|| database | **string**

Required field. Database.

The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `. ||
|| connection_properties | **object** (map<**string**, **string**>)

Additional connection properties.

No more than 256 per resource. The maximum string length in characters for each value is 128. Each value must match the regular expression ` [-_0-9a-zA-Z.,:\/_]* `. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-zA-Z]* `. ||
|#

## ClickhouseConnector {#yandex.cloud.trino.v1.ClickhouseConnector}

#|
||Field | Description ||
|| connection | **[ClickhouseConnection](#yandex.cloud.trino.v1.ClickhouseConnection)**

Connection configuration. ||
|| additional_properties | **object** (map<**string**, **string**>)

Additional properties.

No more than 256 per resource. The maximum string length in characters for each value is 128. Each value must match the regular expression ` [-_0-9a-zA-Z.,:\/_ ]* `. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-z][-_0-9a-z.]* `. ||
|#

## ClickhouseConnection {#yandex.cloud.trino.v1.ClickhouseConnection}

#|
||Field | Description ||
|| on_premise | **[OnPremise](#yandex.cloud.trino.v1.ClickhouseConnection.OnPremise)**

Connection configured manually.

Includes only one of the fields `on_premise`, `connection_manager`. ||
|| connection_manager | **[ConnectionManager](#yandex.cloud.trino.v1.ClickhouseConnection.ConnectionManager)**

Connection configured using Yandex Cloud Connection Manager.

Includes only one of the fields `on_premise`, `connection_manager`. ||
|#

## OnPremise {#yandex.cloud.trino.v1.ClickhouseConnection.OnPremise}

#|
||Field | Description ||
|| connection_url | **string**

Required field. Connection to the Clickhouse.

Value must match the regular expression ` ^jdbc:clickhouse://(?:.+:\d+)/(?:.*)$ `. ||
|| user_name | **string**

Required field. Name of the Clickhouse user.

The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `. ||
|| password | **string**

Required field. Password of the Clickhouse user.

The string length in characters must be 0-128. ||
|#

## ConnectionManager {#yandex.cloud.trino.v1.ClickhouseConnection.ConnectionManager}

#|
||Field | Description ||
|| connection_id | **string**

Required field. Connection ID.

The string length in characters must be 1-50. ||
|| database | **string**

Required field. Database.

The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `. ||
|| connection_properties | **object** (map<**string**, **string**>)

Additional connection properties.

No more than 256 per resource. The maximum string length in characters for each value is 128. Each value must match the regular expression ` [-_0-9a-zA-Z.,:\/_]* `. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-zA-Z_]* `. ||
|#

## TPCHConnector {#yandex.cloud.trino.v1.TPCHConnector}

#|
||Field | Description ||
|| additional_properties | **object** (map<**string**, **string**>)

Additional properties.

No more than 256 per resource. The maximum string length in characters for each value is 128. Each value must match the regular expression ` [-_0-9a-zA-Z.,:\/_ ]* `. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-z][-_0-9a-z.]* `. ||
|#

## TPCDSConnector {#yandex.cloud.trino.v1.TPCDSConnector}

#|
||Field | Description ||
|| additional_properties | **object** (map<**string**, **string**>)

Additional properties.

No more than 256 per resource. The maximum string length in characters for each value is 128. Each value must match the regular expression ` [-_0-9a-zA-Z.,:\/_ ]* `. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-z][-_0-9a-z.]* `. ||
|#

## OracleConnector {#yandex.cloud.trino.v1.OracleConnector}

#|
||Field | Description ||
|| connection | **[OracleConnection](#yandex.cloud.trino.v1.OracleConnection)**

Connection configuration. ||
|| additional_properties | **object** (map<**string**, **string**>)

Additional properties.

No more than 256 per resource. The maximum string length in characters for each value is 128. Each value must match the regular expression ` [-_0-9a-zA-Z.,:\/_ ]* `. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-z][-_0-9a-z.]* `. ||
|#

## OracleConnection {#yandex.cloud.trino.v1.OracleConnection}

#|
||Field | Description ||
|| on_premise | **[OnPremise](#yandex.cloud.trino.v1.OracleConnection.OnPremise)**

Connection configured manually.

Includes only one of the fields `on_premise`. ||
|#

## OnPremise {#yandex.cloud.trino.v1.OracleConnection.OnPremise}

#|
||Field | Description ||
|| connection_url | **string**

Required field. Connection to the Oracle.

Value must match the regular expression ` ^jdbc:oracle:(?s:.*)$ `. ||
|| user_name | **string**

Required field. Name of the Oracle user.

The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `. ||
|| password | **string**

Required field. Password of the Oracle user.

The string length in characters must be 0-128. ||
|#

## SQLServerConnector {#yandex.cloud.trino.v1.SQLServerConnector}

#|
||Field | Description ||
|| connection | **[SQLServerConnection](#yandex.cloud.trino.v1.SQLServerConnection)**

Connection configuration. ||
|| additional_properties | **object** (map<**string**, **string**>)

Additional properties.

No more than 256 per resource. The maximum string length in characters for each value is 128. Each value must match the regular expression ` [-_0-9a-zA-Z.,:\/_ ]* `. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-z][-_0-9a-z.]* `. ||
|#

## SQLServerConnection {#yandex.cloud.trino.v1.SQLServerConnection}

#|
||Field | Description ||
|| on_premise | **[OnPremise](#yandex.cloud.trino.v1.SQLServerConnection.OnPremise)**

Connection configured manually.

Includes only one of the fields `on_premise`. ||
|#

## OnPremise {#yandex.cloud.trino.v1.SQLServerConnection.OnPremise}

#|
||Field | Description ||
|| connection_url | **string**

Required field. Connection to the SQLServer.

Value must match the regular expression ` ^jdbc:sqlserver:(?s:.*)$ `. ||
|| user_name | **string**

Required field. Name of the SQLServer user.

The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `. ||
|| password | **string**

Required field. Password of the SQLServer user.

The string length in characters must be 0-128. ||
|#

## HudiConnector {#yandex.cloud.trino.v1.HudiConnector}

#|
||Field | Description ||
|| metastore | **[Metastore](#yandex.cloud.trino.v1.Metastore)**

Required field. Metastore configuration. ||
|| filesystem | **[FileSystem](#yandex.cloud.trino.v1.FileSystem)**

Required field. File system configuration. ||
|| additional_properties | **object** (map<**string**, **string**>)

Additional properties.

No more than 256 per resource. The maximum string length in characters for each value is 128. Each value must match the regular expression ` [-_0-9a-zA-Z.,:\/_ ]* `. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-z][-_0-9a-z.]* `. ||
|#

## MysqlConnector {#yandex.cloud.trino.v1.MysqlConnector}

#|
||Field | Description ||
|| connection | **[MysqlConnection](#yandex.cloud.trino.v1.MysqlConnection)**

Connection configuration. ||
|| additional_properties | **object** (map<**string**, **string**>)

Additional properties.

No more than 256 per resource. The maximum string length in characters for each value is 128. Each value must match the regular expression ` [-_0-9a-zA-Z.,:\/_ ]* `. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-z][-_0-9a-z.]* `. ||
|#

## MysqlConnection {#yandex.cloud.trino.v1.MysqlConnection}

#|
||Field | Description ||
|| on_premise | **[OnPremise](#yandex.cloud.trino.v1.MysqlConnection.OnPremise)**

Connection configured manually.

Includes only one of the fields `on_premise`, `connection_manager`. ||
|| connection_manager | **[ConnectionManager](#yandex.cloud.trino.v1.MysqlConnection.ConnectionManager)**

Connection configured using Yandex Cloud Connection Manager.

Includes only one of the fields `on_premise`, `connection_manager`. ||
|#

## OnPremise {#yandex.cloud.trino.v1.MysqlConnection.OnPremise}

#|
||Field | Description ||
|| connection_url | **string**

Required field. Connection to the MySQL.

Value must match the regular expression ` ^jdbc:mysql://(?:.+:\d+)(?:/?.*)$ `. ||
|| user_name | **string**

Required field. Name of the MySQL user.

The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `. ||
|| password | **string**

Required field. Password of the MySQL user.

The string length in characters must be 0-128. ||
|#

## ConnectionManager {#yandex.cloud.trino.v1.MysqlConnection.ConnectionManager}

#|
||Field | Description ||
|| connection_id | **string**

Required field. Connection ID.

The string length in characters must be 1-50. ||
|| connection_properties | **object** (map<**string**, **string**>)

Additional connection properties.

No more than 256 per resource. The maximum string length in characters for each value is 128. Each value must match the regular expression ` [-_0-9a-zA-Z.,:\/_]* `. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-zA-Z_]* `. ||
|#

## GreenplumConnector {#yandex.cloud.trino.v1.GreenplumConnector}

#|
||Field | Description ||
|| connection | **[GreenplumConnection](#yandex.cloud.trino.v1.GreenplumConnection)**

Connection configuration ||
|| additional_properties | **object** (map<**string**, **string**>)

Additional properties.

No more than 256 per resource. The maximum string length in characters for each value is 128. Each value must match the regular expression ` [-_0-9a-zA-Z.,:\/_ ]* `. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-z][-_0-9a-z.]* `. ||
|#

## GreenplumConnection {#yandex.cloud.trino.v1.GreenplumConnection}

#|
||Field | Description ||
|| on_premise | **[OnPremise](#yandex.cloud.trino.v1.GreenplumConnection.OnPremise)**

Connection configured manually.

Includes only one of the fields `on_premise`, `connection_manager`. ||
|| connection_manager | **[ConnectionManager](#yandex.cloud.trino.v1.GreenplumConnection.ConnectionManager)**

Connection configured using Yandex Cloud Connection Manager.

Includes only one of the fields `on_premise`, `connection_manager`. ||
|#

## OnPremise {#yandex.cloud.trino.v1.GreenplumConnection.OnPremise}

#|
||Field | Description ||
|| connection_url | **string**

Required field. Connection to the Greenplum/Cloudberry.

Value must match the regular expression ` ^jdbc:postgresql://(?:.+:\d+)/(?:.*)$ `. ||
|| user_name | **string**

Required field. Name of the Greenplum/Cloudberry user.

The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `. ||
|| password | **string**

Required field. Password of the Greenplum/Cloudberry user.

The string length in characters must be 0-128. ||
|#

## ConnectionManager {#yandex.cloud.trino.v1.GreenplumConnection.ConnectionManager}

#|
||Field | Description ||
|| connection_id | **string**

Required field. Connection ID.

The string length in characters must be 1-50. ||
|| database | **string**

Required field. Database.

The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `. ||
|| connection_properties | **object** (map<**string**, **string**>)

Additional connection properties.

No more than 256 per resource. The maximum string length in characters for each value is 128. Each value must match the regular expression ` [-_0-9a-zA-Z.,:\/_]* `. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-zA-Z]* `. ||
|#