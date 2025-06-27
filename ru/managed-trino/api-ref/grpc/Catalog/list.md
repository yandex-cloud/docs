---
editable: false
sourcePath: en/_api-ref-grpc/trino/v1/api-ref/grpc/Catalog/list.md
---

# Managed Service for Trino API, gRPC: CatalogService.List

Retrieves a list of Trino Catalog resources.

## gRPC request

**rpc List ([ListCatalogsRequest](#yandex.cloud.trino.v1.ListCatalogsRequest)) returns ([ListCatalogsResponse](#yandex.cloud.trino.v1.ListCatalogsResponse))**

## ListCatalogsRequest {#yandex.cloud.trino.v1.ListCatalogsRequest}

```json
{
  "cluster_id": "string",
  "page_size": "int64",
  "page_token": "string",
  "filter": "string"
}
```

#|
||Field | Description ||
|| cluster_id | **string**

Required field. ID of the cluster to list Trino Catalogs in. ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `page_size`, the service returns a [ListCatalogsResponse.next_page_token](#yandex.cloud.trino.v1.ListCatalogsResponse)
that can be used to get the next page of results in subsequent list requests. ||
|| page_token | **string**

Page token. To get the next page of results, set `page_token` to the [ListCatalogsResponse.next_page_token](#yandex.cloud.trino.v1.ListCatalogsResponse)
returned by the previous list request. ||
|| filter | **string**

A filter expression that filters resources listed in the response.
The expression must specify:
1. The field name. Currently you can only use filtering with the [Catalog.name](#yandex.cloud.trino.v1.Catalog) field.
2. An `=` operator.
3. The value in double quotes (`"`). Must be 1-63 characters long and match the regular expression `[a-zA-Z0-9_-]+`. ||
|#

## ListCatalogsResponse {#yandex.cloud.trino.v1.ListCatalogsResponse}

```json
{
  "catalogs": [
    {
      "id": "string",
      "name": "string",
      "connector": {
        // Includes only one of the fields `hive`, `iceberg`, `delta_lake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`
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
        }
        // end of the list of possible fields
      },
      "description": "string",
      "labels": "map<string, string>"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| catalogs[] | **[Catalog](#yandex.cloud.trino.v1.Catalog)**

List of Trino Catalog resources. ||
|| next_page_token | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListCatalogsRequest.page_size](#yandex.cloud.trino.v1.ListCatalogsRequest), use the `next_page_token` as the value
for the [ListCatalogsRequest.page_token](#yandex.cloud.trino.v1.ListCatalogsRequest) parameter in the next list request. Each subsequent
list request will have its own `next_page_token` to continue paging through the results. ||
|#

## Catalog {#yandex.cloud.trino.v1.Catalog}

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

Includes only one of the fields `hive`, `iceberg`, `delta_lake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`. ||
|| iceberg | **[IcebergConnector](#yandex.cloud.trino.v1.IcebergConnector)**

Iceberg connector configuration.

Includes only one of the fields `hive`, `iceberg`, `delta_lake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`. ||
|| delta_lake | **[DeltaLakeConnector](#yandex.cloud.trino.v1.DeltaLakeConnector)**

Delta Lake connector configuration.

Includes only one of the fields `hive`, `iceberg`, `delta_lake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`. ||
|| postgresql | **[PostgresqlConnector](#yandex.cloud.trino.v1.PostgresqlConnector)**

PostgreSQL connector configuration.

Includes only one of the fields `hive`, `iceberg`, `delta_lake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`. ||
|| clickhouse | **[ClickhouseConnector](#yandex.cloud.trino.v1.ClickhouseConnector)**

ClickHouse connector configuration.

Includes only one of the fields `hive`, `iceberg`, `delta_lake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`. ||
|| tpch | **[TPCHConnector](#yandex.cloud.trino.v1.TPCHConnector)**

TPC-H connector for synthetic benchmarking.

Includes only one of the fields `hive`, `iceberg`, `delta_lake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`. ||
|| tpcds | **[TPCDSConnector](#yandex.cloud.trino.v1.TPCDSConnector)**

TPC-DS connector for synthetic benchmarking.

Includes only one of the fields `hive`, `iceberg`, `delta_lake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`. ||
|| oracle | **[OracleConnector](#yandex.cloud.trino.v1.OracleConnector)**

Oracle connector configuration for connecting to Oracle Database instances.

Includes only one of the fields `hive`, `iceberg`, `delta_lake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`. ||
|| sqlserver | **[SQLServerConnector](#yandex.cloud.trino.v1.SQLServerConnector)**

SQLServer connector configuration for connecting to SQLServer Database instances.

Includes only one of the fields `hive`, `iceberg`, `delta_lake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`. ||
|#

## HiveConnector {#yandex.cloud.trino.v1.HiveConnector}

#|
||Field | Description ||
|| metastore | **[Metastore](#yandex.cloud.trino.v1.Metastore)**

Required field. Metastore configuration. ||
|| filesystem | **[FileSystem](#yandex.cloud.trino.v1.FileSystem)**

Required field. File system configuration. ||
|| additional_properties | **object** (map<**string**, **string**>)

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
|| s3 | **[S3FileSystem](#yandex.cloud.trino.v1.FileSystem.S3FileSystem)**

Includes only one of the fields `s3`, `external_s3`. ||
|| external_s3 | **[ExternalS3FileSystem](#yandex.cloud.trino.v1.FileSystem.ExternalS3FileSystem)**

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

Required field.  ||
|| aws_secret_key | **string**

Required field.  ||
|| aws_endpoint | **string**

Required field.  ||
|| aws_region | **string**

Required field.  ||
|#

## IcebergConnector {#yandex.cloud.trino.v1.IcebergConnector}

#|
||Field | Description ||
|| metastore | **[Metastore](#yandex.cloud.trino.v1.Metastore)**

Required field. Metastore configuration. ||
|| filesystem | **[FileSystem](#yandex.cloud.trino.v1.FileSystem)**

Required field. File system configuration. ||
|| additional_properties | **object** (map<**string**, **string**>)

Additional properties. ||
|#

## DeltaLakeConnector {#yandex.cloud.trino.v1.DeltaLakeConnector}

#|
||Field | Description ||
|| metastore | **[Metastore](#yandex.cloud.trino.v1.Metastore)**

Required field. Metastore configuration. ||
|| filesystem | **[FileSystem](#yandex.cloud.trino.v1.FileSystem)**

Required field. File system configuration. ||
|| additional_properties | **object** (map<**string**, **string**>)

Additional properties. ||
|#

## PostgresqlConnector {#yandex.cloud.trino.v1.PostgresqlConnector}

#|
||Field | Description ||
|| connection | **[PostgresqlConnection](#yandex.cloud.trino.v1.PostgresqlConnection)**

Connection configuration. ||
|| additional_properties | **object** (map<**string**, **string**>)

Additional properties. ||
|#

## PostgresqlConnection {#yandex.cloud.trino.v1.PostgresqlConnection}

#|
||Field | Description ||
|| on_premise | **[OnPremise](#yandex.cloud.trino.v1.PostgresqlConnection.OnPremise)**

Includes only one of the fields `on_premise`, `connection_manager`. ||
|| connection_manager | **[ConnectionManager](#yandex.cloud.trino.v1.PostgresqlConnection.ConnectionManager)**

Includes only one of the fields `on_premise`, `connection_manager`. ||
|#

## OnPremise {#yandex.cloud.trino.v1.PostgresqlConnection.OnPremise}

#|
||Field | Description ||
|| connection_url | **string**

Required field. Connection to the Postgresql. ||
|| user_name | **string**

Required field. Name of the Postgresql user. ||
|| password | **string**

Required field. Password of the Postgresql user. ||
|#

## ConnectionManager {#yandex.cloud.trino.v1.PostgresqlConnection.ConnectionManager}

#|
||Field | Description ||
|| connection_id | **string**

Required field. Connection ID. ||
|| database | **string**

Required field. Database. ||
|| connection_properties | **object** (map<**string**, **string**>)

Additional connection properties. ||
|#

## ClickhouseConnector {#yandex.cloud.trino.v1.ClickhouseConnector}

#|
||Field | Description ||
|| connection | **[ClickhouseConnection](#yandex.cloud.trino.v1.ClickhouseConnection)**

Connection configuration. ||
|| additional_properties | **object** (map<**string**, **string**>)

Additional properties. ||
|#

## ClickhouseConnection {#yandex.cloud.trino.v1.ClickhouseConnection}

#|
||Field | Description ||
|| on_premise | **[OnPremise](#yandex.cloud.trino.v1.ClickhouseConnection.OnPremise)**

Includes only one of the fields `on_premise`, `connection_manager`. ||
|| connection_manager | **[ConnectionManager](#yandex.cloud.trino.v1.ClickhouseConnection.ConnectionManager)**

Includes only one of the fields `on_premise`, `connection_manager`. ||
|#

## OnPremise {#yandex.cloud.trino.v1.ClickhouseConnection.OnPremise}

#|
||Field | Description ||
|| connection_url | **string**

Required field. Connection to the Clickhouse. ||
|| user_name | **string**

Required field. Name of the Clickhouse user. ||
|| password | **string**

Required field. Password of the Clickhouse user. ||
|#

## ConnectionManager {#yandex.cloud.trino.v1.ClickhouseConnection.ConnectionManager}

#|
||Field | Description ||
|| connection_id | **string**

Required field. Connection ID. ||
|| database | **string**

Required field. Database. ||
|| connection_properties | **object** (map<**string**, **string**>)

Additional connection properties. ||
|#

## TPCHConnector {#yandex.cloud.trino.v1.TPCHConnector}

#|
||Field | Description ||
|| additional_properties | **object** (map<**string**, **string**>)

Additional properties. ||
|#

## TPCDSConnector {#yandex.cloud.trino.v1.TPCDSConnector}

#|
||Field | Description ||
|| additional_properties | **object** (map<**string**, **string**>)

Additional properties. ||
|#

## OracleConnector {#yandex.cloud.trino.v1.OracleConnector}

#|
||Field | Description ||
|| connection | **[OracleConnection](#yandex.cloud.trino.v1.OracleConnection)**

Connection configuration. ||
|| additional_properties | **object** (map<**string**, **string**>)

Additional properties. ||
|#

## OracleConnection {#yandex.cloud.trino.v1.OracleConnection}

#|
||Field | Description ||
|| on_premise | **[OnPremise](#yandex.cloud.trino.v1.OracleConnection.OnPremise)**

Includes only one of the fields `on_premise`. ||
|#

## OnPremise {#yandex.cloud.trino.v1.OracleConnection.OnPremise}

#|
||Field | Description ||
|| connection_url | **string**

Required field. Connection to the Oracle. ||
|| user_name | **string**

Required field. Name of the Oracle user. ||
|| password | **string**

Required field. Password of the Oracle user. ||
|#

## SQLServerConnector {#yandex.cloud.trino.v1.SQLServerConnector}

#|
||Field | Description ||
|| connection | **[SQLServerConnection](#yandex.cloud.trino.v1.SQLServerConnection)**

Connection configuration. ||
|| additional_properties | **object** (map<**string**, **string**>)

Additional properties. ||
|#

## SQLServerConnection {#yandex.cloud.trino.v1.SQLServerConnection}

#|
||Field | Description ||
|| on_premise | **[OnPremise](#yandex.cloud.trino.v1.SQLServerConnection.OnPremise)**

Includes only one of the fields `on_premise`. ||
|#

## OnPremise {#yandex.cloud.trino.v1.SQLServerConnection.OnPremise}

#|
||Field | Description ||
|| connection_url | **string**

Required field. Connection to the SQLServer. ||
|| user_name | **string**

Required field. Name of the SQLServer user. ||
|| password | **string**

Required field. Password of the SQLServer user. ||
|#