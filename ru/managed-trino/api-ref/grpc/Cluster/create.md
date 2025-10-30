---
editable: false
sourcePath: en/_api-ref-grpc/trino/v1/api-ref/grpc/Cluster/create.md
---

# Managed Service for Trino API, gRPC: ClusterService.Create

Creates a Trino Cluster resource.

## gRPC request

**rpc Create ([CreateClusterRequest](#yandex.cloud.trino.v1.CreateClusterRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## CreateClusterRequest {#yandex.cloud.trino.v1.CreateClusterRequest}

```json
{
  "folder_id": "string",
  "name": "string",
  "description": "string",
  "labels": "map<string, string>",
  "trino": {
    "catalogs": [
      {
        "name": "string",
        "connector": {
          // Includes only one of the fields `hive`, `iceberg`, `delta_lake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`, `hudi`
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
          }
          // end of the list of possible fields
        },
        "description": "string",
        "labels": "map<string, string>"
      }
    ],
    "coordinator_config": {
      "resources": {
        "resource_preset_id": "string"
      }
    },
    "worker_config": {
      "resources": {
        "resource_preset_id": "string"
      },
      "scale_policy": {
        // Includes only one of the fields `fixed_scale`, `auto_scale`
        "fixed_scale": {
          "count": "int64"
        },
        "auto_scale": {
          "min_count": "int64",
          "max_count": "int64"
        }
        // end of the list of possible fields
      }
    },
    "retry_policy": {
      "policy": "RetryPolicy",
      "exchange_manager": {
        "additional_properties": "map<string, string>",
        "storage": {
          // Includes only one of the fields `service_s3`
          "service_s3": "ServiceS3"
          // end of the list of possible fields
        }
      },
      "additional_properties": "map<string, string>"
    },
    "version": "string",
    "access_control": {
      "catalogs": [
        {
          "users": [
            "string"
          ],
          "groups": [
            "string"
          ],
          "catalog": {
            // Includes only one of the fields `name_regexp`, `ids`, `names`
            "name_regexp": "string",
            "ids": {
              "any": [
                "string"
              ]
            },
            "names": {
              "any": [
                "string"
              ]
            }
            // end of the list of possible fields
          },
          "permission": "Permission",
          "description": "string"
        }
      ],
      "schemas": [
        {
          "users": [
            "string"
          ],
          "groups": [
            "string"
          ],
          "catalog": {
            // Includes only one of the fields `name_regexp`, `ids`, `names`
            "name_regexp": "string",
            "ids": {
              "any": [
                "string"
              ]
            },
            "names": {
              "any": [
                "string"
              ]
            }
            // end of the list of possible fields
          },
          "schema": {
            // Includes only one of the fields `name_regexp`, `names`
            "name_regexp": "string",
            "names": {
              "any": [
                "string"
              ]
            }
            // end of the list of possible fields
          },
          "owner": "Owner",
          "description": "string"
        }
      ],
      "tables": [
        {
          "users": [
            "string"
          ],
          "groups": [
            "string"
          ],
          "catalog": {
            // Includes only one of the fields `name_regexp`, `ids`, `names`
            "name_regexp": "string",
            "ids": {
              "any": [
                "string"
              ]
            },
            "names": {
              "any": [
                "string"
              ]
            }
            // end of the list of possible fields
          },
          "schema": {
            // Includes only one of the fields `name_regexp`, `names`
            "name_regexp": "string",
            "names": {
              "any": [
                "string"
              ]
            }
            // end of the list of possible fields
          },
          "table": {
            // Includes only one of the fields `name_regexp`, `names`
            "name_regexp": "string",
            "names": {
              "any": [
                "string"
              ]
            }
            // end of the list of possible fields
          },
          "privileges": [
            "Privilege"
          ],
          "columns": [
            {
              "name": "string",
              "access": "AccessMode",
              "mask": "string"
            }
          ],
          "filter": "string",
          "description": "string"
        }
      ],
      "functions": [
        {
          "users": [
            "string"
          ],
          "groups": [
            "string"
          ],
          "catalog": {
            // Includes only one of the fields `name_regexp`, `ids`, `names`
            "name_regexp": "string",
            "ids": {
              "any": [
                "string"
              ]
            },
            "names": {
              "any": [
                "string"
              ]
            }
            // end of the list of possible fields
          },
          "schema": {
            // Includes only one of the fields `name_regexp`, `names`
            "name_regexp": "string",
            "names": {
              "any": [
                "string"
              ]
            }
            // end of the list of possible fields
          },
          "function": {
            // Includes only one of the fields `name_regexp`, `names`
            "name_regexp": "string",
            "names": {
              "any": [
                "string"
              ]
            }
            // end of the list of possible fields
          },
          "privileges": [
            "Privilege"
          ],
          "description": "string"
        }
      ],
      "procedures": [
        {
          "users": [
            "string"
          ],
          "groups": [
            "string"
          ],
          "catalog": {
            // Includes only one of the fields `name_regexp`, `ids`, `names`
            "name_regexp": "string",
            "ids": {
              "any": [
                "string"
              ]
            },
            "names": {
              "any": [
                "string"
              ]
            }
            // end of the list of possible fields
          },
          "schema": {
            // Includes only one of the fields `name_regexp`, `names`
            "name_regexp": "string",
            "names": {
              "any": [
                "string"
              ]
            }
            // end of the list of possible fields
          },
          "procedure": {
            // Includes only one of the fields `name_regexp`, `names`
            "name_regexp": "string",
            "names": {
              "any": [
                "string"
              ]
            }
            // end of the list of possible fields
          },
          "privileges": [
            "Privilege"
          ],
          "description": "string"
        }
      ],
      "queries": [
        {
          "users": [
            "string"
          ],
          "groups": [
            "string"
          ],
          "query_owners": [
            "string"
          ],
          "privileges": [
            "Privilege"
          ],
          "description": "string"
        }
      ],
      "system_session_properties": [
        {
          "users": [
            "string"
          ],
          "groups": [
            "string"
          ],
          "property": {
            // Includes only one of the fields `name_regexp`, `names`
            "name_regexp": "string",
            "names": {
              "any": [
                "string"
              ]
            }
            // end of the list of possible fields
          },
          "allow": "Allow",
          "description": "string"
        }
      ],
      "catalog_session_properties": [
        {
          "users": [
            "string"
          ],
          "groups": [
            "string"
          ],
          "catalog": {
            // Includes only one of the fields `name_regexp`, `ids`, `names`
            "name_regexp": "string",
            "ids": {
              "any": [
                "string"
              ]
            },
            "names": {
              "any": [
                "string"
              ]
            }
            // end of the list of possible fields
          },
          "property": {
            // Includes only one of the fields `name_regexp`, `names`
            "name_regexp": "string",
            "names": {
              "any": [
                "string"
              ]
            }
            // end of the list of possible fields
          },
          "allow": "Allow",
          "description": "string"
        }
      ]
    },
    "tls": {
      "trusted_certificates": [
        "string"
      ]
    }
  },
  "network": {
    "subnet_ids": [
      "string"
    ],
    "security_group_ids": [
      "string"
    ]
  },
  "deletion_protection": "bool",
  "service_account_id": "string",
  "logging": {
    "enabled": "bool",
    // Includes only one of the fields `folder_id`, `log_group_id`
    "folder_id": "string",
    "log_group_id": "string",
    // end of the list of possible fields
    "min_level": "Level"
  },
  "maintenance_window": {
    // Includes only one of the fields `anytime`, `weekly_maintenance_window`
    "anytime": "AnytimeMaintenanceWindow",
    "weekly_maintenance_window": {
      "day": "WeekDay",
      "hour": "int64"
    }
    // end of the list of possible fields
  }
}
```

#|
||Field | Description ||
|| folder_id | **string**

Required field. ID of the folder to create Trino cluster in. ||
|| name | **string**

Required field. Name of the Trino cluster. The name must be unique within the folder. ||
|| description | **string**

Description of the Trino cluster. ||
|| labels | **object** (map<**string**, **string**>)

Custom labels for the Trino cluster as `` key:value `` pairs.
For example: {"env": "prod"}. ||
|| trino | **[TrinoConfigSpec](#yandex.cloud.trino.v1.TrinoConfigSpec)**

Required field. Configuration of Trino components. ||
|| network | **[NetworkConfig](#yandex.cloud.trino.v1.NetworkConfig)**

Required field. Network related configuration options. ||
|| deletion_protection | **bool**

Deletion Protection inhibits deletion of the cluster. ||
|| service_account_id | **string**

Required field. Service account used to access Cloud resources. ||
|| logging | **[LoggingConfig](#yandex.cloud.trino.v1.LoggingConfig)**

Cloud logging configuration. ||
|| maintenance_window | **[MaintenanceWindow](#yandex.cloud.trino.v1.MaintenanceWindow)**

Window of maintenance operations. ||
|#

## TrinoConfigSpec {#yandex.cloud.trino.v1.TrinoConfigSpec}

#|
||Field | Description ||
|| catalogs[] | **[CatalogSpec](#yandex.cloud.trino.v1.CatalogSpec)**

List of catalogs that enable integration with various data sources.
Each catalog defines a connection to an external data source that Trino can query. ||
|| coordinator_config | **[CoordinatorConfig](#yandex.cloud.trino.v1.CoordinatorConfig)**

Required field. Configuration for the coordinator, specifying computational resources and other settings. ||
|| worker_config | **[WorkerConfig](#yandex.cloud.trino.v1.WorkerConfig)**

Required field. Configuration for worker nodes, including scaling policy and computational resources. ||
|| retry_policy | **[RetryPolicyConfig](#yandex.cloud.trino.v1.RetryPolicyConfig)**

Configuration for retry policy, specifying the spooling storage destination and other settings. ||
|| version | **string**

Trino version.
Format: "Number". ||
|| access_control | **[AccessControlConfig](#yandex.cloud.trino.v1.AccessControlConfig)**

Configuration for access control, specifying the fine-grained access rules. ||
|| tls | **[TLSConfig](#yandex.cloud.trino.v1.TLSConfig)**

Configuration for TLS. ||
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

Includes only one of the fields `hive`, `iceberg`, `delta_lake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`, `hudi`. ||
|| iceberg | **[IcebergConnector](#yandex.cloud.trino.v1.IcebergConnector)**

Iceberg connector configuration.

Includes only one of the fields `hive`, `iceberg`, `delta_lake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`, `hudi`. ||
|| delta_lake | **[DeltaLakeConnector](#yandex.cloud.trino.v1.DeltaLakeConnector)**

Delta Lake connector configuration.

Includes only one of the fields `hive`, `iceberg`, `delta_lake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`, `hudi`. ||
|| postgresql | **[PostgresqlConnector](#yandex.cloud.trino.v1.PostgresqlConnector)**

PostgreSQL connector configuration.

Includes only one of the fields `hive`, `iceberg`, `delta_lake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`, `hudi`. ||
|| clickhouse | **[ClickhouseConnector](#yandex.cloud.trino.v1.ClickhouseConnector)**

ClickHouse connector configuration.

Includes only one of the fields `hive`, `iceberg`, `delta_lake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`, `hudi`. ||
|| tpch | **[TPCHConnector](#yandex.cloud.trino.v1.TPCHConnector)**

TPC-H connector for synthetic benchmarking.

Includes only one of the fields `hive`, `iceberg`, `delta_lake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`, `hudi`. ||
|| tpcds | **[TPCDSConnector](#yandex.cloud.trino.v1.TPCDSConnector)**

TPC-DS connector for synthetic benchmarking.

Includes only one of the fields `hive`, `iceberg`, `delta_lake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`, `hudi`. ||
|| oracle | **[OracleConnector](#yandex.cloud.trino.v1.OracleConnector)**

Oracle connector configuration for connecting to Oracle Database instances.

Includes only one of the fields `hive`, `iceberg`, `delta_lake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`, `hudi`. ||
|| sqlserver | **[SQLServerConnector](#yandex.cloud.trino.v1.SQLServerConnector)**

SQLServer connector configuration for connecting to SQLServer Database instances.

Includes only one of the fields `hive`, `iceberg`, `delta_lake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`, `hudi`. ||
|| hudi | **[HudiConnector](#yandex.cloud.trino.v1.HudiConnector)**

Hudi connector configuration.

Includes only one of the fields `hive`, `iceberg`, `delta_lake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`, `hudi`. ||
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

## HudiConnector {#yandex.cloud.trino.v1.HudiConnector}

#|
||Field | Description ||
|| metastore | **[Metastore](#yandex.cloud.trino.v1.Metastore)**

Required field. Metastore configuration. ||
|| filesystem | **[FileSystem](#yandex.cloud.trino.v1.FileSystem)**

Required field. File system configuration. ||
|| additional_properties | **object** (map<**string**, **string**>)

Additional properties. ||
|#

## CoordinatorConfig {#yandex.cloud.trino.v1.CoordinatorConfig}

#|
||Field | Description ||
|| resources | **[Resources](#yandex.cloud.trino.v1.Resources)**

Required field. Configuration for computational resources assigned to the coordinator instance. ||
|#

## Resources {#yandex.cloud.trino.v1.Resources}

#|
||Field | Description ||
|| resource_preset_id | **string**

Required field. ID of the preset for computational resources allocated to a instance (e.g., CPU, memory, etc.). ||
|#

## WorkerConfig {#yandex.cloud.trino.v1.WorkerConfig}

#|
||Field | Description ||
|| resources | **[Resources](#yandex.cloud.trino.v1.Resources)**

Required field. Configuration for computational resources for worker instances. ||
|| scale_policy | **[WorkerScalePolicy](#yandex.cloud.trino.v1.WorkerConfig.WorkerScalePolicy)**

Required field. Configuration for scaling policy for worker instances. ||
|#

## WorkerScalePolicy {#yandex.cloud.trino.v1.WorkerConfig.WorkerScalePolicy}

#|
||Field | Description ||
|| fixed_scale | **[FixedScalePolicy](#yandex.cloud.trino.v1.FixedScalePolicy)**

A fixed scaling policy that specifies a fixed number of worker instances.

Includes only one of the fields `fixed_scale`, `auto_scale`.

Defines the scaling type for worker instances.
Only one type of scaling can be specified at a time. ||
|| auto_scale | **[AutoScalePolicy](#yandex.cloud.trino.v1.AutoScalePolicy)**

A scaling policy that dynamically adjusts the number of worker instances
based on the cluster's workload. The system automatically increases or
decreases the number of instances within the defined range.

Includes only one of the fields `fixed_scale`, `auto_scale`.

Defines the scaling type for worker instances.
Only one type of scaling can be specified at a time. ||
|#

## FixedScalePolicy {#yandex.cloud.trino.v1.FixedScalePolicy}

#|
||Field | Description ||
|| count | **int64**

Specifies the number of worker instances. ||
|#

## AutoScalePolicy {#yandex.cloud.trino.v1.AutoScalePolicy}

#|
||Field | Description ||
|| min_count | **int64** ||
|| max_count | **int64** ||
|#

## RetryPolicyConfig {#yandex.cloud.trino.v1.RetryPolicyConfig}

#|
||Field | Description ||
|| policy | enum **RetryPolicy**

Retry policy level.

- `RETRY_POLICY_UNSPECIFIED`
- `QUERY`
- `TASK` ||
|| exchange_manager | **[ExchangeManagerConfig](#yandex.cloud.trino.v1.ExchangeManagerConfig)**

Configuration for exchange manager. ||
|| additional_properties | **object** (map<**string**, **string**>)

Additional properties. ||
|#

## ExchangeManagerConfig {#yandex.cloud.trino.v1.ExchangeManagerConfig}

#|
||Field | Description ||
|| additional_properties | **object** (map<**string**, **string**>)

Additional properties. ||
|| storage | **[ExchangeManagerStorage](#yandex.cloud.trino.v1.ExchangeManagerStorage)** ||
|#

## ExchangeManagerStorage {#yandex.cloud.trino.v1.ExchangeManagerStorage}

#|
||Field | Description ||
|| service_s3 | **[ServiceS3](#yandex.cloud.trino.v1.ExchangeManagerStorage.ServiceS3)**

Use service side s3 bucket for exchange manager.

Includes only one of the fields `service_s3`. ||
|#

## ServiceS3 {#yandex.cloud.trino.v1.ExchangeManagerStorage.ServiceS3}

#|
||Field | Description ||
|| Empty | > ||
|#

## AccessControlConfig {#yandex.cloud.trino.v1.AccessControlConfig}

#|
||Field | Description ||
|| catalogs[] | **[CatalogAccessRule](#yandex.cloud.trino.v1.CatalogAccessRule)**

Catalog access control rules. ||
|| schemas[] | **[SchemaAccessRule](#yandex.cloud.trino.v1.SchemaAccessRule)**

Schema access control rules. ||
|| tables[] | **[TableAccessRule](#yandex.cloud.trino.v1.TableAccessRule)**

Table access control rules. ||
|| functions[] | **[FunctionAccessRule](#yandex.cloud.trino.v1.FunctionAccessRule)**

Function access control rules. ||
|| procedures[] | **[ProcedureAccessRule](#yandex.cloud.trino.v1.ProcedureAccessRule)**

Procedures access control rules. ||
|| queries[] | **[QueryAccessRule](#yandex.cloud.trino.v1.QueryAccessRule)**

Queries access control rules. ||
|| system_session_properties[] | **[SystemSessionPropertyAccessRule](#yandex.cloud.trino.v1.SystemSessionPropertyAccessRule)**

System session property access control rules. ||
|| catalog_session_properties[] | **[CatalogSessionPropertyAccessRule](#yandex.cloud.trino.v1.CatalogSessionPropertyAccessRule)**

Catalog session property access control rules. ||
|#

## CatalogAccessRule {#yandex.cloud.trino.v1.CatalogAccessRule}

#|
||Field | Description ||
|| users[] | **string**

IAM user IDs the rule is applied to. ||
|| groups[] | **string**

IAM group IDs the rule is applied to. ||
|| catalog | **[CatalogAccessRuleMatcher](#yandex.cloud.trino.v1.CatalogAccessRuleMatcher)**

Catalog matcher specifying what catalogs the rule is applied to. ||
|| permission | enum **Permission**

Required field. Permission granted by the rule.

- `PERMISSION_UNSPECIFIED`
- `NONE`: Denies all operations on the catalog entities.
- `ALL`: Allows all operations on catalog entities.
- `READ_ONLY`: Allows only read operations on catalog entities. ||
|| description | **string**

Rule description. ||
|#

## CatalogAccessRuleMatcher {#yandex.cloud.trino.v1.CatalogAccessRuleMatcher}

#|
||Field | Description ||
|| name_regexp | **string**

Catalog name regexp the rule is applied to.

Includes only one of the fields `name_regexp`, `ids`, `names`. ||
|| ids | **[CatalogIds](#yandex.cloud.trino.v1.CatalogAccessRuleMatcher.CatalogIds)**

Catalog IDs rule is applied to.

Includes only one of the fields `name_regexp`, `ids`, `names`. ||
|| names | **[CatalogNames](#yandex.cloud.trino.v1.CatalogAccessRuleMatcher.CatalogNames)**

Catalog names rule is applied to.

Includes only one of the fields `name_regexp`, `ids`, `names`. ||
|#

## CatalogIds {#yandex.cloud.trino.v1.CatalogAccessRuleMatcher.CatalogIds}

#|
||Field | Description ||
|| any[] | **string** ||
|#

## CatalogNames {#yandex.cloud.trino.v1.CatalogAccessRuleMatcher.CatalogNames}

#|
||Field | Description ||
|| any[] | **string** ||
|#

## SchemaAccessRule {#yandex.cloud.trino.v1.SchemaAccessRule}

#|
||Field | Description ||
|| users[] | **string**

IAM user IDs the rule is applied to. ||
|| groups[] | **string**

IAM group IDs the rule is applied to. ||
|| catalog | **[CatalogAccessRuleMatcher](#yandex.cloud.trino.v1.CatalogAccessRuleMatcher)**

Catalog matcher specifying what catalogs the rule is applied to. ||
|| schema | **[SchemaAccessRuleMatcher](#yandex.cloud.trino.v1.SchemaAccessRuleMatcher)**

Schema matcher specifying what schemas the rule is applied to. ||
|| owner | enum **Owner**

Required field. Ownership granted by the rule.

- `OWNER_UNSPECIFIED`
- `NO`: User is not considered an owner of the schema.
- `YES`: User is considered an owner of the schema. ||
|| description | **string**

Rule description. ||
|#

## SchemaAccessRuleMatcher {#yandex.cloud.trino.v1.SchemaAccessRuleMatcher}

#|
||Field | Description ||
|| name_regexp | **string**

Schema name regexp the rule is applied to.

Includes only one of the fields `name_regexp`, `names`. ||
|| names | **[SchemaNames](#yandex.cloud.trino.v1.SchemaAccessRuleMatcher.SchemaNames)**

Schema names the rule is applied to.

Includes only one of the fields `name_regexp`, `names`. ||
|#

## SchemaNames {#yandex.cloud.trino.v1.SchemaAccessRuleMatcher.SchemaNames}

#|
||Field | Description ||
|| any[] | **string** ||
|#

## TableAccessRule {#yandex.cloud.trino.v1.TableAccessRule}

#|
||Field | Description ||
|| users[] | **string**

IAM user IDs the rule is applied to. ||
|| groups[] | **string**

IAM group IDs the rule is applied to. ||
|| catalog | **[CatalogAccessRuleMatcher](#yandex.cloud.trino.v1.CatalogAccessRuleMatcher)**

Catalog matcher specifying what catalogs the rule is applied to. ||
|| schema | **[SchemaAccessRuleMatcher](#yandex.cloud.trino.v1.SchemaAccessRuleMatcher)**

Schema matcher specifying what schemas the rule is applied to. ||
|| table | **[TableAccessRuleMatcher](#yandex.cloud.trino.v1.TableAccessRuleMatcher)**

Table matcher specifying what tables the rule is applied to. ||
|| privileges[] | enum **Privilege**

Permission granted by the rule.

- `PRIVILEGE_UNSPECIFIED`
- `SELECT`: Allows SELECT statements on the table.
- `INSERT`: Allows INSERT statements on the table.
- `DELETE`: Allows DELETE statements on the table.
- `UPDATE`: Allows UPDATE statements on the table.
- `OWNERSHIP`: Allows CREATE, DROP, COMMENT ON and ALTER statements on the table.
- `GRANT_SELECT`: Allows SELECT statements on the table while creating view. ||
|| columns[] | **[Column](#yandex.cloud.trino.v1.TableAccessRule.Column)**

Column rules. ||
|| filter | **string**

Boolean SQL expression to filter table rows for particular user. ||
|| description | **string**

Rule description. ||
|#

## TableAccessRuleMatcher {#yandex.cloud.trino.v1.TableAccessRuleMatcher}

#|
||Field | Description ||
|| name_regexp | **string**

Table name regexp the rule is applied to.

Includes only one of the fields `name_regexp`, `names`. ||
|| names | **[TableNames](#yandex.cloud.trino.v1.TableAccessRuleMatcher.TableNames)**

Table names the rule is applied to.

Includes only one of the fields `name_regexp`, `names`. ||
|#

## TableNames {#yandex.cloud.trino.v1.TableAccessRuleMatcher.TableNames}

#|
||Field | Description ||
|| any[] | **string** ||
|#

## Column {#yandex.cloud.trino.v1.TableAccessRule.Column}

#|
||Field | Description ||
|| name | **string**

Required field. Column name. ||
|| access | enum **AccessMode**

Required field. Column access mode.

- `ACCESS_MODE_UNSPECIFIED`
- `NONE`: Access to column is denied.
- `ALL`: Access to column is allowed. ||
|| mask | **string**

SQL expression mask to evaluate instead of original column values.
Mask should have the same type as original column. ||
|#

## FunctionAccessRule {#yandex.cloud.trino.v1.FunctionAccessRule}

#|
||Field | Description ||
|| users[] | **string**

IAM user IDs the rule is applied to. ||
|| groups[] | **string**

IAM group IDs the rule is applied to. ||
|| catalog | **[CatalogAccessRuleMatcher](#yandex.cloud.trino.v1.CatalogAccessRuleMatcher)**

Catalog matcher specifying what catalogs the rule is applied to. ||
|| schema | **[SchemaAccessRuleMatcher](#yandex.cloud.trino.v1.SchemaAccessRuleMatcher)**

Schema matcher specifying what schema the rule is applied to. ||
|| function | **[FunctionAccessRuleMatcher](#yandex.cloud.trino.v1.FunctionAccessRuleMatcher)**

Function matcher specifying what functions the rule is applied to. ||
|| privileges[] | enum **Privilege**

Privileges granted by the rule.

- `PRIVILEGE_UNSPECIFIED`
- `EXECUTE`: Allows to execute the function.
- `GRANT_EXECUTE`: Allows to use the function while view creation.
- `OWNERSHIP`: Allows to CREATE and DROP the function. ||
|| description | **string**

Rule description. ||
|#

## FunctionAccessRuleMatcher {#yandex.cloud.trino.v1.FunctionAccessRuleMatcher}

#|
||Field | Description ||
|| name_regexp | **string**

Function name regexp the rule is applied to.

Includes only one of the fields `name_regexp`, `names`. ||
|| names | **[FunctionNames](#yandex.cloud.trino.v1.FunctionAccessRuleMatcher.FunctionNames)**

Function names the rule is applied to.

Includes only one of the fields `name_regexp`, `names`. ||
|#

## FunctionNames {#yandex.cloud.trino.v1.FunctionAccessRuleMatcher.FunctionNames}

#|
||Field | Description ||
|| any[] | **string** ||
|#

## ProcedureAccessRule {#yandex.cloud.trino.v1.ProcedureAccessRule}

#|
||Field | Description ||
|| users[] | **string**

IAM user IDs the rule is applied to. ||
|| groups[] | **string**

IAM group IDs the rule is applied to. ||
|| catalog | **[CatalogAccessRuleMatcher](#yandex.cloud.trino.v1.CatalogAccessRuleMatcher)**

Catalog matcher specifying what catalogs the rule is applied to. ||
|| schema | **[SchemaAccessRuleMatcher](#yandex.cloud.trino.v1.SchemaAccessRuleMatcher)**

Schema matcher specifying what schema the rule is applied to. ||
|| procedure | **[ProcedureAccessRuleMatcher](#yandex.cloud.trino.v1.ProcedureAccessRuleMatcher)**

Procedure matcher specifying what functions the rule is applied to. ||
|| privileges[] | enum **Privilege**

Privileges granted by the rule.

- `PRIVILEGE_UNSPECIFIED`
- `EXECUTE`: Allows to execute the procedure. ||
|| description | **string**

Rule description. ||
|#

## ProcedureAccessRuleMatcher {#yandex.cloud.trino.v1.ProcedureAccessRuleMatcher}

#|
||Field | Description ||
|| name_regexp | **string**

Procedure name regexp the rule is applied to.

Includes only one of the fields `name_regexp`, `names`. ||
|| names | **[ProcedureNames](#yandex.cloud.trino.v1.ProcedureAccessRuleMatcher.ProcedureNames)**

Procedure names the rule is applied to.

Includes only one of the fields `name_regexp`, `names`. ||
|#

## ProcedureNames {#yandex.cloud.trino.v1.ProcedureAccessRuleMatcher.ProcedureNames}

#|
||Field | Description ||
|| any[] | **string** ||
|#

## QueryAccessRule {#yandex.cloud.trino.v1.QueryAccessRule}

#|
||Field | Description ||
|| users[] | **string**

IAM user IDs the rule is applied to. ||
|| groups[] | **string**

IAM group IDs the rule is applied to. ||
|| query_owners[] | **string**

Owners of queries the rule is applied to.
Cannot be combined with EXECUTE privilege. ||
|| privileges[] | enum **Privilege**

Privileges granted by the user.

- `PRIVILEGE_UNSPECIFIED`
- `VIEW`: Allows to view the query.
- `EXECUTE`: Allows to execute the query.
- `KILL`: Allows to kill the query. ||
|| description | **string**

Rule description. ||
|#

## SystemSessionPropertyAccessRule {#yandex.cloud.trino.v1.SystemSessionPropertyAccessRule}

#|
||Field | Description ||
|| users[] | **string**

IAM user IDs the rule is applied to. ||
|| groups[] | **string**

IAM group IDs the rule is applied to. ||
|| property | **[PropertyAccessRuleMatcher](#yandex.cloud.trino.v1.PropertyAccessRuleMatcher)**

Property matcher specifying what properties the rule is applied to. ||
|| allow | enum **Allow**

Required field. Whether the rule allows setting the property.

- `ALLOW_UNSPECIFIED`
- `NO`: Denies setting the system session property.
- `YES`: Allows to set the system session property. ||
|| description | **string**

Rule description. ||
|#

## PropertyAccessRuleMatcher {#yandex.cloud.trino.v1.PropertyAccessRuleMatcher}

#|
||Field | Description ||
|| name_regexp | **string**

Property name regexp the rule is applied to.

Includes only one of the fields `name_regexp`, `names`. ||
|| names | **[PropertyNames](#yandex.cloud.trino.v1.PropertyAccessRuleMatcher.PropertyNames)**

Property names the rule is applied to.

Includes only one of the fields `name_regexp`, `names`. ||
|#

## PropertyNames {#yandex.cloud.trino.v1.PropertyAccessRuleMatcher.PropertyNames}

#|
||Field | Description ||
|| any[] | **string** ||
|#

## CatalogSessionPropertyAccessRule {#yandex.cloud.trino.v1.CatalogSessionPropertyAccessRule}

#|
||Field | Description ||
|| users[] | **string**

IAM user IDs the rule is applied to. ||
|| groups[] | **string**

IAM group IDs the rule is applied to. ||
|| catalog | **[CatalogAccessRuleMatcher](#yandex.cloud.trino.v1.CatalogAccessRuleMatcher)**

Catalog matcher specifying what catalogs the rule is applied to. ||
|| property | **[PropertyAccessRuleMatcher](#yandex.cloud.trino.v1.PropertyAccessRuleMatcher)**

Property matcher specifying what properties the rule is applied to. ||
|| allow | enum **Allow**

Required field. Whether the rule allows setting the property.

- `ALLOW_UNSPECIFIED`
- `NO`: Denies setting the catalog session property.
- `YES`: Allows to set the catalog session property. ||
|| description | **string**

Rule description. ||
|#

## TLSConfig {#yandex.cloud.trino.v1.TLSConfig}

#|
||Field | Description ||
|| trusted_certificates[] | **string**

Trusted CA-certificates. Each element should contain single self-signed CA-certificate or
chain of CA-certificates where first certificate is the leaf and last certificate is the self-signed root. ||
|#

## NetworkConfig {#yandex.cloud.trino.v1.NetworkConfig}

#|
||Field | Description ||
|| subnet_ids[] | **string**

IDs of VPC network subnets where instances of the cluster are attached. ||
|| security_group_ids[] | **string**

User security groups. ||
|#

## LoggingConfig {#yandex.cloud.trino.v1.LoggingConfig}

#|
||Field | Description ||
|| enabled | **bool**

Logs generated by the Trino components are delivered to Cloud Logging. ||
|| folder_id | **string**

Logs should be written to default log group for specified folder.

Includes only one of the fields `folder_id`, `log_group_id`.

Destination of log records. ||
|| log_group_id | **string**

Logs should be written to log group resolved by ID.

Includes only one of the fields `folder_id`, `log_group_id`.

Destination of log records. ||
|| min_level | enum **Level**

Minimum log entry level.

See [LogLevel.Level](/docs/logging/api-ref/grpc/Export/run#yandex.cloud.logging.v1.LogLevel.Level) for details.

- `LEVEL_UNSPECIFIED`: Default log level.

  Equivalent to not specifying log level at all.
- `TRACE`: Trace log level.

  Possible use case: verbose logging of some business logic.
- `DEBUG`: Debug log level.

  Possible use case: debugging special cases in application logic.
- `INFO`: Info log level.

  Mostly used for information messages.
- `WARN`: Warn log level.

  May be used to alert about significant events.
- `ERROR`: Error log level.

  May be used to alert about errors in infrastructure, logic, etc.
- `FATAL`: Fatal log level.

  May be used to alert about unrecoverable failures and events. ||
|#

## MaintenanceWindow {#yandex.cloud.trino.v1.MaintenanceWindow}

#|
||Field | Description ||
|| anytime | **[AnytimeMaintenanceWindow](#yandex.cloud.trino.v1.AnytimeMaintenanceWindow)**

Includes only one of the fields `anytime`, `weekly_maintenance_window`. ||
|| weekly_maintenance_window | **[WeeklyMaintenanceWindow](#yandex.cloud.trino.v1.WeeklyMaintenanceWindow)**

Includes only one of the fields `anytime`, `weekly_maintenance_window`. ||
|#

## AnytimeMaintenanceWindow {#yandex.cloud.trino.v1.AnytimeMaintenanceWindow}

#|
||Field | Description ||
|| Empty | > ||
|#

## WeeklyMaintenanceWindow {#yandex.cloud.trino.v1.WeeklyMaintenanceWindow}

#|
||Field | Description ||
|| day | enum **WeekDay**

- `WEEK_DAY_UNSPECIFIED`
- `MON`
- `TUE`
- `WED`
- `THU`
- `FRI`
- `SAT`
- `SUN` ||
|| hour | **int64**

Hour of the day in UTC. ||
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
    "cluster_id": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "string",
    "folder_id": "string",
    "created_at": "google.protobuf.Timestamp",
    "name": "string",
    "description": "string",
    "labels": "map<string, string>",
    "monitoring": [
      {
        "name": "string",
        "description": "string",
        "link": "string"
      }
    ],
    "trino": {
      "coordinator_config": {
        "resources": {
          "resource_preset_id": "string"
        }
      },
      "worker_config": {
        "resources": {
          "resource_preset_id": "string"
        },
        "scale_policy": {
          // Includes only one of the fields `fixed_scale`, `auto_scale`
          "fixed_scale": {
            "count": "int64"
          },
          "auto_scale": {
            "min_count": "int64",
            "max_count": "int64"
          }
          // end of the list of possible fields
        }
      },
      "version": "string",
      "retry_policy": {
        "policy": "RetryPolicy",
        "exchange_manager": {
          "additional_properties": "map<string, string>",
          "storage": {
            // Includes only one of the fields `service_s3`
            "service_s3": "ServiceS3"
            // end of the list of possible fields
          }
        },
        "additional_properties": "map<string, string>"
      },
      "access_control": {
        "catalogs": [
          {
            "users": [
              "string"
            ],
            "groups": [
              "string"
            ],
            "catalog": {
              // Includes only one of the fields `name_regexp`, `ids`, `names`
              "name_regexp": "string",
              "ids": {
                "any": [
                  "string"
                ]
              },
              "names": {
                "any": [
                  "string"
                ]
              }
              // end of the list of possible fields
            },
            "permission": "Permission",
            "description": "string"
          }
        ],
        "schemas": [
          {
            "users": [
              "string"
            ],
            "groups": [
              "string"
            ],
            "catalog": {
              // Includes only one of the fields `name_regexp`, `ids`, `names`
              "name_regexp": "string",
              "ids": {
                "any": [
                  "string"
                ]
              },
              "names": {
                "any": [
                  "string"
                ]
              }
              // end of the list of possible fields
            },
            "schema": {
              // Includes only one of the fields `name_regexp`, `names`
              "name_regexp": "string",
              "names": {
                "any": [
                  "string"
                ]
              }
              // end of the list of possible fields
            },
            "owner": "Owner",
            "description": "string"
          }
        ],
        "tables": [
          {
            "users": [
              "string"
            ],
            "groups": [
              "string"
            ],
            "catalog": {
              // Includes only one of the fields `name_regexp`, `ids`, `names`
              "name_regexp": "string",
              "ids": {
                "any": [
                  "string"
                ]
              },
              "names": {
                "any": [
                  "string"
                ]
              }
              // end of the list of possible fields
            },
            "schema": {
              // Includes only one of the fields `name_regexp`, `names`
              "name_regexp": "string",
              "names": {
                "any": [
                  "string"
                ]
              }
              // end of the list of possible fields
            },
            "table": {
              // Includes only one of the fields `name_regexp`, `names`
              "name_regexp": "string",
              "names": {
                "any": [
                  "string"
                ]
              }
              // end of the list of possible fields
            },
            "privileges": [
              "Privilege"
            ],
            "columns": [
              {
                "name": "string",
                "access": "AccessMode",
                "mask": "string"
              }
            ],
            "filter": "string",
            "description": "string"
          }
        ],
        "functions": [
          {
            "users": [
              "string"
            ],
            "groups": [
              "string"
            ],
            "catalog": {
              // Includes only one of the fields `name_regexp`, `ids`, `names`
              "name_regexp": "string",
              "ids": {
                "any": [
                  "string"
                ]
              },
              "names": {
                "any": [
                  "string"
                ]
              }
              // end of the list of possible fields
            },
            "schema": {
              // Includes only one of the fields `name_regexp`, `names`
              "name_regexp": "string",
              "names": {
                "any": [
                  "string"
                ]
              }
              // end of the list of possible fields
            },
            "function": {
              // Includes only one of the fields `name_regexp`, `names`
              "name_regexp": "string",
              "names": {
                "any": [
                  "string"
                ]
              }
              // end of the list of possible fields
            },
            "privileges": [
              "Privilege"
            ],
            "description": "string"
          }
        ],
        "procedures": [
          {
            "users": [
              "string"
            ],
            "groups": [
              "string"
            ],
            "catalog": {
              // Includes only one of the fields `name_regexp`, `ids`, `names`
              "name_regexp": "string",
              "ids": {
                "any": [
                  "string"
                ]
              },
              "names": {
                "any": [
                  "string"
                ]
              }
              // end of the list of possible fields
            },
            "schema": {
              // Includes only one of the fields `name_regexp`, `names`
              "name_regexp": "string",
              "names": {
                "any": [
                  "string"
                ]
              }
              // end of the list of possible fields
            },
            "procedure": {
              // Includes only one of the fields `name_regexp`, `names`
              "name_regexp": "string",
              "names": {
                "any": [
                  "string"
                ]
              }
              // end of the list of possible fields
            },
            "privileges": [
              "Privilege"
            ],
            "description": "string"
          }
        ],
        "queries": [
          {
            "users": [
              "string"
            ],
            "groups": [
              "string"
            ],
            "query_owners": [
              "string"
            ],
            "privileges": [
              "Privilege"
            ],
            "description": "string"
          }
        ],
        "system_session_properties": [
          {
            "users": [
              "string"
            ],
            "groups": [
              "string"
            ],
            "property": {
              // Includes only one of the fields `name_regexp`, `names`
              "name_regexp": "string",
              "names": {
                "any": [
                  "string"
                ]
              }
              // end of the list of possible fields
            },
            "allow": "Allow",
            "description": "string"
          }
        ],
        "catalog_session_properties": [
          {
            "users": [
              "string"
            ],
            "groups": [
              "string"
            ],
            "catalog": {
              // Includes only one of the fields `name_regexp`, `ids`, `names`
              "name_regexp": "string",
              "ids": {
                "any": [
                  "string"
                ]
              },
              "names": {
                "any": [
                  "string"
                ]
              }
              // end of the list of possible fields
            },
            "property": {
              // Includes only one of the fields `name_regexp`, `names`
              "name_regexp": "string",
              "names": {
                "any": [
                  "string"
                ]
              }
              // end of the list of possible fields
            },
            "allow": "Allow",
            "description": "string"
          }
        ]
      },
      "tls": {
        "trusted_certificates": [
          "string"
        ]
      }
    },
    "health": "Health",
    "status": "Status",
    "network": {
      "subnet_ids": [
        "string"
      ],
      "security_group_ids": [
        "string"
      ]
    },
    "deletion_protection": "bool",
    "service_account_id": "string",
    "logging": {
      "enabled": "bool",
      // Includes only one of the fields `folder_id`, `log_group_id`
      "folder_id": "string",
      "log_group_id": "string",
      // end of the list of possible fields
      "min_level": "Level"
    },
    "coordinator_url": "string",
    "maintenance_window": {
      // Includes only one of the fields `anytime`, `weekly_maintenance_window`
      "anytime": "AnytimeMaintenanceWindow",
      "weekly_maintenance_window": {
        "day": "WeekDay",
        "hour": "int64"
      }
      // end of the list of possible fields
    },
    "planned_operation": {
      "info": "string",
      "delayed_until": "google.protobuf.Timestamp",
      "latest_maintenance_time": "google.protobuf.Timestamp",
      "next_maintenance_window_time": "google.protobuf.Timestamp"
    }
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
|| metadata | **[CreateClusterMetadata](#yandex.cloud.trino.v1.CreateClusterMetadata)**

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
|| response | **[Cluster](#yandex.cloud.trino.v1.Cluster)**

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

## CreateClusterMetadata {#yandex.cloud.trino.v1.CreateClusterMetadata}

#|
||Field | Description ||
|| cluster_id | **string**

ID of the Trino cluster that is being created. ||
|#

## Cluster {#yandex.cloud.trino.v1.Cluster}

Trino cluster.

#|
||Field | Description ||
|| id | **string**

Unique ID of the Trino cluster.
This ID is assigned by Cloud in the process of creating a Trino cluster. ||
|| folder_id | **string**

ID of the folder that the Trino cluster belongs to. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Trino cluster was created. ||
|| name | **string**

Name of the Trino cluster.
The name is unique within the folder. 1-64 characters long. ||
|| description | **string**

Description of the Trino cluster. 0-256 characters long. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs. Maximum of 64 per resource. ||
|| monitoring[] | **[Monitoring](#yandex.cloud.trino.v1.Monitoring)**

Monitoring systems relevant to the Trino cluster. ||
|| trino | **[TrinoConfig](#yandex.cloud.trino.v1.TrinoConfig)**

Configuration of the Trino cluster. ||
|| health | enum **Health**

Aggregated cluster health.

- `HEALTH_UNKNOWN`: Object is in unknown state (we have no data)
- `ALIVE`: Object is alive and well (all hosts are alive)
- `DEAD`: Object is inoperable (it cannot perform any of its essential functions)
- `DEGRADED`: Object is partially alive (it can perform some of its essential functions) ||
|| status | enum **Status**

Cluster status.

- `STATUS_UNKNOWN`: Cluster state is unknown.
- `CREATING`: Cluster is being created.
- `RUNNING`: Cluster is running normally.
- `ERROR`: Cluster encountered a problem and cannot operate.
- `STOPPING`: Cluster is stopping.
- `STOPPED`: Cluster is stopped.
- `STARTING`: Cluster is starting.
- `UPDATING`: Cluster is being updated. ||
|| network | **[NetworkConfig](#yandex.cloud.trino.v1.NetworkConfig2)**

Network related configuration options. ||
|| deletion_protection | **bool**

Deletion Protection inhibits deletion of the cluster. ||
|| service_account_id | **string**

Service account used to access Cloud resources. ||
|| logging | **[LoggingConfig](#yandex.cloud.trino.v1.LoggingConfig2)**

Cloud logging configuration. ||
|| coordinator_url | **string**

Address of Trino Coordinator. ||
|| maintenance_window | **[MaintenanceWindow](#yandex.cloud.trino.v1.MaintenanceWindow2)**

Window of maintenance operations. ||
|| planned_operation | **[MaintenanceOperation](#yandex.cloud.trino.v1.MaintenanceOperation)**

Maintenance operation planned at nearest maintenance_window. ||
|#

## Monitoring {#yandex.cloud.trino.v1.Monitoring}

Monitoring system.

#|
||Field | Description ||
|| name | **string**

Name of the monitoring system. ||
|| description | **string**

Description of the monitoring system. ||
|| link | **string**

Link to the monitoring system. ||
|#

## TrinoConfig {#yandex.cloud.trino.v1.TrinoConfig}

#|
||Field | Description ||
|| coordinator_config | **[CoordinatorConfig](#yandex.cloud.trino.v1.CoordinatorConfig2)**

Required field. Configuration for the coordinator, specifying computational resources and other settings. ||
|| worker_config | **[WorkerConfig](#yandex.cloud.trino.v1.WorkerConfig2)**

Required field. Configuration for worker nodes, including scaling policy and computational resources. ||
|| version | **string**

Version of Trino. ||
|| retry_policy | **[RetryPolicyConfig](#yandex.cloud.trino.v1.RetryPolicyConfig2)**

Configuration for retry policy, specifying the spooling storage destination and other settings. ||
|| access_control | **[AccessControlConfig](#yandex.cloud.trino.v1.AccessControlConfig2)**

Configuration for access control, specifying the fine-grained rules of accesses. ||
|| tls | **[TLSConfig](#yandex.cloud.trino.v1.TLSConfig2)**

Configuration for TLS. ||
|#

## CoordinatorConfig {#yandex.cloud.trino.v1.CoordinatorConfig2}

#|
||Field | Description ||
|| resources | **[Resources](#yandex.cloud.trino.v1.Resources2)**

Required field. Configuration for computational resources assigned to the coordinator instance. ||
|#

## Resources {#yandex.cloud.trino.v1.Resources2}

#|
||Field | Description ||
|| resource_preset_id | **string**

Required field. ID of the preset for computational resources allocated to a instance (e.g., CPU, memory, etc.). ||
|#

## WorkerConfig {#yandex.cloud.trino.v1.WorkerConfig2}

#|
||Field | Description ||
|| resources | **[Resources](#yandex.cloud.trino.v1.Resources2)**

Required field. Configuration for computational resources for worker instances. ||
|| scale_policy | **[WorkerScalePolicy](#yandex.cloud.trino.v1.WorkerConfig.WorkerScalePolicy2)**

Required field. Configuration for scaling policy for worker instances. ||
|#

## WorkerScalePolicy {#yandex.cloud.trino.v1.WorkerConfig.WorkerScalePolicy2}

#|
||Field | Description ||
|| fixed_scale | **[FixedScalePolicy](#yandex.cloud.trino.v1.FixedScalePolicy2)**

A fixed scaling policy that specifies a fixed number of worker instances.

Includes only one of the fields `fixed_scale`, `auto_scale`.

Defines the scaling type for worker instances.
Only one type of scaling can be specified at a time. ||
|| auto_scale | **[AutoScalePolicy](#yandex.cloud.trino.v1.AutoScalePolicy2)**

A scaling policy that dynamically adjusts the number of worker instances
based on the cluster's workload. The system automatically increases or
decreases the number of instances within the defined range.

Includes only one of the fields `fixed_scale`, `auto_scale`.

Defines the scaling type for worker instances.
Only one type of scaling can be specified at a time. ||
|#

## FixedScalePolicy {#yandex.cloud.trino.v1.FixedScalePolicy2}

#|
||Field | Description ||
|| count | **int64**

Specifies the number of worker instances. ||
|#

## AutoScalePolicy {#yandex.cloud.trino.v1.AutoScalePolicy2}

#|
||Field | Description ||
|| min_count | **int64** ||
|| max_count | **int64** ||
|#

## RetryPolicyConfig {#yandex.cloud.trino.v1.RetryPolicyConfig2}

#|
||Field | Description ||
|| policy | enum **RetryPolicy**

Retry policy level.

- `RETRY_POLICY_UNSPECIFIED`
- `QUERY`
- `TASK` ||
|| exchange_manager | **[ExchangeManagerConfig](#yandex.cloud.trino.v1.ExchangeManagerConfig2)**

Configuration for exchange manager. ||
|| additional_properties | **object** (map<**string**, **string**>)

Additional properties. ||
|#

## ExchangeManagerConfig {#yandex.cloud.trino.v1.ExchangeManagerConfig2}

#|
||Field | Description ||
|| additional_properties | **object** (map<**string**, **string**>)

Additional properties. ||
|| storage | **[ExchangeManagerStorage](#yandex.cloud.trino.v1.ExchangeManagerStorage2)** ||
|#

## ExchangeManagerStorage {#yandex.cloud.trino.v1.ExchangeManagerStorage2}

#|
||Field | Description ||
|| service_s3 | **[ServiceS3](#yandex.cloud.trino.v1.ExchangeManagerStorage.ServiceS32)**

Use service side s3 bucket for exchange manager.

Includes only one of the fields `service_s3`. ||
|#

## ServiceS3 {#yandex.cloud.trino.v1.ExchangeManagerStorage.ServiceS32}

#|
||Field | Description ||
|| Empty | > ||
|#

## AccessControlConfig {#yandex.cloud.trino.v1.AccessControlConfig2}

#|
||Field | Description ||
|| catalogs[] | **[CatalogAccessRule](#yandex.cloud.trino.v1.CatalogAccessRule2)**

Catalog access control rules. ||
|| schemas[] | **[SchemaAccessRule](#yandex.cloud.trino.v1.SchemaAccessRule2)**

Schema access control rules. ||
|| tables[] | **[TableAccessRule](#yandex.cloud.trino.v1.TableAccessRule2)**

Table access control rules. ||
|| functions[] | **[FunctionAccessRule](#yandex.cloud.trino.v1.FunctionAccessRule2)**

Function access control rules. ||
|| procedures[] | **[ProcedureAccessRule](#yandex.cloud.trino.v1.ProcedureAccessRule2)**

Procedures access control rules. ||
|| queries[] | **[QueryAccessRule](#yandex.cloud.trino.v1.QueryAccessRule2)**

Queries access control rules. ||
|| system_session_properties[] | **[SystemSessionPropertyAccessRule](#yandex.cloud.trino.v1.SystemSessionPropertyAccessRule2)**

System session property access control rules. ||
|| catalog_session_properties[] | **[CatalogSessionPropertyAccessRule](#yandex.cloud.trino.v1.CatalogSessionPropertyAccessRule2)**

Catalog session property access control rules. ||
|#

## CatalogAccessRule {#yandex.cloud.trino.v1.CatalogAccessRule2}

#|
||Field | Description ||
|| users[] | **string**

IAM user IDs the rule is applied to. ||
|| groups[] | **string**

IAM group IDs the rule is applied to. ||
|| catalog | **[CatalogAccessRuleMatcher](#yandex.cloud.trino.v1.CatalogAccessRuleMatcher2)**

Catalog matcher specifying what catalogs the rule is applied to. ||
|| permission | enum **Permission**

Required field. Permission granted by the rule.

- `PERMISSION_UNSPECIFIED`
- `NONE`: Denies all operations on the catalog entities.
- `ALL`: Allows all operations on catalog entities.
- `READ_ONLY`: Allows only read operations on catalog entities. ||
|| description | **string**

Rule description. ||
|#

## CatalogAccessRuleMatcher {#yandex.cloud.trino.v1.CatalogAccessRuleMatcher2}

#|
||Field | Description ||
|| name_regexp | **string**

Catalog name regexp the rule is applied to.

Includes only one of the fields `name_regexp`, `ids`, `names`. ||
|| ids | **[CatalogIds](#yandex.cloud.trino.v1.CatalogAccessRuleMatcher.CatalogIds2)**

Catalog IDs rule is applied to.

Includes only one of the fields `name_regexp`, `ids`, `names`. ||
|| names | **[CatalogNames](#yandex.cloud.trino.v1.CatalogAccessRuleMatcher.CatalogNames2)**

Catalog names rule is applied to.

Includes only one of the fields `name_regexp`, `ids`, `names`. ||
|#

## CatalogIds {#yandex.cloud.trino.v1.CatalogAccessRuleMatcher.CatalogIds2}

#|
||Field | Description ||
|| any[] | **string** ||
|#

## CatalogNames {#yandex.cloud.trino.v1.CatalogAccessRuleMatcher.CatalogNames2}

#|
||Field | Description ||
|| any[] | **string** ||
|#

## SchemaAccessRule {#yandex.cloud.trino.v1.SchemaAccessRule2}

#|
||Field | Description ||
|| users[] | **string**

IAM user IDs the rule is applied to. ||
|| groups[] | **string**

IAM group IDs the rule is applied to. ||
|| catalog | **[CatalogAccessRuleMatcher](#yandex.cloud.trino.v1.CatalogAccessRuleMatcher2)**

Catalog matcher specifying what catalogs the rule is applied to. ||
|| schema | **[SchemaAccessRuleMatcher](#yandex.cloud.trino.v1.SchemaAccessRuleMatcher2)**

Schema matcher specifying what schemas the rule is applied to. ||
|| owner | enum **Owner**

Required field. Ownership granted by the rule.

- `OWNER_UNSPECIFIED`
- `NO`: User is not considered an owner of the schema.
- `YES`: User is considered an owner of the schema. ||
|| description | **string**

Rule description. ||
|#

## SchemaAccessRuleMatcher {#yandex.cloud.trino.v1.SchemaAccessRuleMatcher2}

#|
||Field | Description ||
|| name_regexp | **string**

Schema name regexp the rule is applied to.

Includes only one of the fields `name_regexp`, `names`. ||
|| names | **[SchemaNames](#yandex.cloud.trino.v1.SchemaAccessRuleMatcher.SchemaNames2)**

Schema names the rule is applied to.

Includes only one of the fields `name_regexp`, `names`. ||
|#

## SchemaNames {#yandex.cloud.trino.v1.SchemaAccessRuleMatcher.SchemaNames2}

#|
||Field | Description ||
|| any[] | **string** ||
|#

## TableAccessRule {#yandex.cloud.trino.v1.TableAccessRule2}

#|
||Field | Description ||
|| users[] | **string**

IAM user IDs the rule is applied to. ||
|| groups[] | **string**

IAM group IDs the rule is applied to. ||
|| catalog | **[CatalogAccessRuleMatcher](#yandex.cloud.trino.v1.CatalogAccessRuleMatcher2)**

Catalog matcher specifying what catalogs the rule is applied to. ||
|| schema | **[SchemaAccessRuleMatcher](#yandex.cloud.trino.v1.SchemaAccessRuleMatcher2)**

Schema matcher specifying what schemas the rule is applied to. ||
|| table | **[TableAccessRuleMatcher](#yandex.cloud.trino.v1.TableAccessRuleMatcher2)**

Table matcher specifying what tables the rule is applied to. ||
|| privileges[] | enum **Privilege**

Permission granted by the rule.

- `PRIVILEGE_UNSPECIFIED`
- `SELECT`: Allows SELECT statements on the table.
- `INSERT`: Allows INSERT statements on the table.
- `DELETE`: Allows DELETE statements on the table.
- `UPDATE`: Allows UPDATE statements on the table.
- `OWNERSHIP`: Allows CREATE, DROP, COMMENT ON and ALTER statements on the table.
- `GRANT_SELECT`: Allows SELECT statements on the table while creating view. ||
|| columns[] | **[Column](#yandex.cloud.trino.v1.TableAccessRule.Column2)**

Column rules. ||
|| filter | **string**

Boolean SQL expression to filter table rows for particular user. ||
|| description | **string**

Rule description. ||
|#

## TableAccessRuleMatcher {#yandex.cloud.trino.v1.TableAccessRuleMatcher2}

#|
||Field | Description ||
|| name_regexp | **string**

Table name regexp the rule is applied to.

Includes only one of the fields `name_regexp`, `names`. ||
|| names | **[TableNames](#yandex.cloud.trino.v1.TableAccessRuleMatcher.TableNames2)**

Table names the rule is applied to.

Includes only one of the fields `name_regexp`, `names`. ||
|#

## TableNames {#yandex.cloud.trino.v1.TableAccessRuleMatcher.TableNames2}

#|
||Field | Description ||
|| any[] | **string** ||
|#

## Column {#yandex.cloud.trino.v1.TableAccessRule.Column2}

#|
||Field | Description ||
|| name | **string**

Required field. Column name. ||
|| access | enum **AccessMode**

Required field. Column access mode.

- `ACCESS_MODE_UNSPECIFIED`
- `NONE`: Access to column is denied.
- `ALL`: Access to column is allowed. ||
|| mask | **string**

SQL expression mask to evaluate instead of original column values.
Mask should have the same type as original column. ||
|#

## FunctionAccessRule {#yandex.cloud.trino.v1.FunctionAccessRule2}

#|
||Field | Description ||
|| users[] | **string**

IAM user IDs the rule is applied to. ||
|| groups[] | **string**

IAM group IDs the rule is applied to. ||
|| catalog | **[CatalogAccessRuleMatcher](#yandex.cloud.trino.v1.CatalogAccessRuleMatcher2)**

Catalog matcher specifying what catalogs the rule is applied to. ||
|| schema | **[SchemaAccessRuleMatcher](#yandex.cloud.trino.v1.SchemaAccessRuleMatcher2)**

Schema matcher specifying what schema the rule is applied to. ||
|| function | **[FunctionAccessRuleMatcher](#yandex.cloud.trino.v1.FunctionAccessRuleMatcher2)**

Function matcher specifying what functions the rule is applied to. ||
|| privileges[] | enum **Privilege**

Privileges granted by the rule.

- `PRIVILEGE_UNSPECIFIED`
- `EXECUTE`: Allows to execute the function.
- `GRANT_EXECUTE`: Allows to use the function while view creation.
- `OWNERSHIP`: Allows to CREATE and DROP the function. ||
|| description | **string**

Rule description. ||
|#

## FunctionAccessRuleMatcher {#yandex.cloud.trino.v1.FunctionAccessRuleMatcher2}

#|
||Field | Description ||
|| name_regexp | **string**

Function name regexp the rule is applied to.

Includes only one of the fields `name_regexp`, `names`. ||
|| names | **[FunctionNames](#yandex.cloud.trino.v1.FunctionAccessRuleMatcher.FunctionNames2)**

Function names the rule is applied to.

Includes only one of the fields `name_regexp`, `names`. ||
|#

## FunctionNames {#yandex.cloud.trino.v1.FunctionAccessRuleMatcher.FunctionNames2}

#|
||Field | Description ||
|| any[] | **string** ||
|#

## ProcedureAccessRule {#yandex.cloud.trino.v1.ProcedureAccessRule2}

#|
||Field | Description ||
|| users[] | **string**

IAM user IDs the rule is applied to. ||
|| groups[] | **string**

IAM group IDs the rule is applied to. ||
|| catalog | **[CatalogAccessRuleMatcher](#yandex.cloud.trino.v1.CatalogAccessRuleMatcher2)**

Catalog matcher specifying what catalogs the rule is applied to. ||
|| schema | **[SchemaAccessRuleMatcher](#yandex.cloud.trino.v1.SchemaAccessRuleMatcher2)**

Schema matcher specifying what schema the rule is applied to. ||
|| procedure | **[ProcedureAccessRuleMatcher](#yandex.cloud.trino.v1.ProcedureAccessRuleMatcher2)**

Procedure matcher specifying what functions the rule is applied to. ||
|| privileges[] | enum **Privilege**

Privileges granted by the rule.

- `PRIVILEGE_UNSPECIFIED`
- `EXECUTE`: Allows to execute the procedure. ||
|| description | **string**

Rule description. ||
|#

## ProcedureAccessRuleMatcher {#yandex.cloud.trino.v1.ProcedureAccessRuleMatcher2}

#|
||Field | Description ||
|| name_regexp | **string**

Procedure name regexp the rule is applied to.

Includes only one of the fields `name_regexp`, `names`. ||
|| names | **[ProcedureNames](#yandex.cloud.trino.v1.ProcedureAccessRuleMatcher.ProcedureNames2)**

Procedure names the rule is applied to.

Includes only one of the fields `name_regexp`, `names`. ||
|#

## ProcedureNames {#yandex.cloud.trino.v1.ProcedureAccessRuleMatcher.ProcedureNames2}

#|
||Field | Description ||
|| any[] | **string** ||
|#

## QueryAccessRule {#yandex.cloud.trino.v1.QueryAccessRule2}

#|
||Field | Description ||
|| users[] | **string**

IAM user IDs the rule is applied to. ||
|| groups[] | **string**

IAM group IDs the rule is applied to. ||
|| query_owners[] | **string**

Owners of queries the rule is applied to.
Cannot be combined with EXECUTE privilege. ||
|| privileges[] | enum **Privilege**

Privileges granted by the user.

- `PRIVILEGE_UNSPECIFIED`
- `VIEW`: Allows to view the query.
- `EXECUTE`: Allows to execute the query.
- `KILL`: Allows to kill the query. ||
|| description | **string**

Rule description. ||
|#

## SystemSessionPropertyAccessRule {#yandex.cloud.trino.v1.SystemSessionPropertyAccessRule2}

#|
||Field | Description ||
|| users[] | **string**

IAM user IDs the rule is applied to. ||
|| groups[] | **string**

IAM group IDs the rule is applied to. ||
|| property | **[PropertyAccessRuleMatcher](#yandex.cloud.trino.v1.PropertyAccessRuleMatcher2)**

Property matcher specifying what properties the rule is applied to. ||
|| allow | enum **Allow**

Required field. Whether the rule allows setting the property.

- `ALLOW_UNSPECIFIED`
- `NO`: Denies setting the system session property.
- `YES`: Allows to set the system session property. ||
|| description | **string**

Rule description. ||
|#

## PropertyAccessRuleMatcher {#yandex.cloud.trino.v1.PropertyAccessRuleMatcher2}

#|
||Field | Description ||
|| name_regexp | **string**

Property name regexp the rule is applied to.

Includes only one of the fields `name_regexp`, `names`. ||
|| names | **[PropertyNames](#yandex.cloud.trino.v1.PropertyAccessRuleMatcher.PropertyNames2)**

Property names the rule is applied to.

Includes only one of the fields `name_regexp`, `names`. ||
|#

## PropertyNames {#yandex.cloud.trino.v1.PropertyAccessRuleMatcher.PropertyNames2}

#|
||Field | Description ||
|| any[] | **string** ||
|#

## CatalogSessionPropertyAccessRule {#yandex.cloud.trino.v1.CatalogSessionPropertyAccessRule2}

#|
||Field | Description ||
|| users[] | **string**

IAM user IDs the rule is applied to. ||
|| groups[] | **string**

IAM group IDs the rule is applied to. ||
|| catalog | **[CatalogAccessRuleMatcher](#yandex.cloud.trino.v1.CatalogAccessRuleMatcher2)**

Catalog matcher specifying what catalogs the rule is applied to. ||
|| property | **[PropertyAccessRuleMatcher](#yandex.cloud.trino.v1.PropertyAccessRuleMatcher2)**

Property matcher specifying what properties the rule is applied to. ||
|| allow | enum **Allow**

Required field. Whether the rule allows setting the property.

- `ALLOW_UNSPECIFIED`
- `NO`: Denies setting the catalog session property.
- `YES`: Allows to set the catalog session property. ||
|| description | **string**

Rule description. ||
|#

## TLSConfig {#yandex.cloud.trino.v1.TLSConfig2}

#|
||Field | Description ||
|| trusted_certificates[] | **string**

Trusted CA-certificates. Each element should contain single self-signed CA-certificate or
chain of CA-certificates where first certificate is the leaf and last certificate is the self-signed root. ||
|#

## NetworkConfig {#yandex.cloud.trino.v1.NetworkConfig2}

#|
||Field | Description ||
|| subnet_ids[] | **string**

IDs of VPC network subnets where instances of the cluster are attached. ||
|| security_group_ids[] | **string**

User security groups. ||
|#

## LoggingConfig {#yandex.cloud.trino.v1.LoggingConfig2}

#|
||Field | Description ||
|| enabled | **bool**

Logs generated by the Trino components are delivered to Cloud Logging. ||
|| folder_id | **string**

Logs should be written to default log group for specified folder.

Includes only one of the fields `folder_id`, `log_group_id`.

Destination of log records. ||
|| log_group_id | **string**

Logs should be written to log group resolved by ID.

Includes only one of the fields `folder_id`, `log_group_id`.

Destination of log records. ||
|| min_level | enum **Level**

Minimum log entry level.

See [LogLevel.Level](/docs/logging/api-ref/grpc/Export/run#yandex.cloud.logging.v1.LogLevel.Level) for details.

- `LEVEL_UNSPECIFIED`: Default log level.

  Equivalent to not specifying log level at all.
- `TRACE`: Trace log level.

  Possible use case: verbose logging of some business logic.
- `DEBUG`: Debug log level.

  Possible use case: debugging special cases in application logic.
- `INFO`: Info log level.

  Mostly used for information messages.
- `WARN`: Warn log level.

  May be used to alert about significant events.
- `ERROR`: Error log level.

  May be used to alert about errors in infrastructure, logic, etc.
- `FATAL`: Fatal log level.

  May be used to alert about unrecoverable failures and events. ||
|#

## MaintenanceWindow {#yandex.cloud.trino.v1.MaintenanceWindow2}

#|
||Field | Description ||
|| anytime | **[AnytimeMaintenanceWindow](#yandex.cloud.trino.v1.AnytimeMaintenanceWindow2)**

Includes only one of the fields `anytime`, `weekly_maintenance_window`. ||
|| weekly_maintenance_window | **[WeeklyMaintenanceWindow](#yandex.cloud.trino.v1.WeeklyMaintenanceWindow2)**

Includes only one of the fields `anytime`, `weekly_maintenance_window`. ||
|#

## AnytimeMaintenanceWindow {#yandex.cloud.trino.v1.AnytimeMaintenanceWindow2}

#|
||Field | Description ||
|| Empty | > ||
|#

## WeeklyMaintenanceWindow {#yandex.cloud.trino.v1.WeeklyMaintenanceWindow2}

#|
||Field | Description ||
|| day | enum **WeekDay**

- `WEEK_DAY_UNSPECIFIED`
- `MON`
- `TUE`
- `WED`
- `THU`
- `FRI`
- `SAT`
- `SUN` ||
|| hour | **int64**

Hour of the day in UTC. ||
|#

## MaintenanceOperation {#yandex.cloud.trino.v1.MaintenanceOperation}

#|
||Field | Description ||
|| info | **string** ||
|| delayed_until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|| latest_maintenance_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|| next_maintenance_window_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|#