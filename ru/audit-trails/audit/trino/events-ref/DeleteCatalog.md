---
editable: false
---

# Managed Service for Trino Audit Trails Events: DeleteCatalog

## Event JSON schema {#yandex.cloud.audit.trino.DeleteCatalog2-schema}

```json
{
  "eventId": "string",
  "eventSource": "string",
  "eventType": "string",
  "eventTime": "string",
  "authentication": {
    "authenticated": "boolean",
    // Includes only one of the fields `subjectType`
    "subjectType": "string",
    // end of the list of possible fields
    // Includes only one of the fields `subjectId`
    "subjectId": "string",
    // end of the list of possible fields
    // Includes only one of the fields `subjectName`
    "subjectName": "string",
    // end of the list of possible fields
    // Includes only one of the fields `federationId`
    "federationId": "string",
    // end of the list of possible fields
    // Includes only one of the fields `federationName`
    "federationName": "string",
    // end of the list of possible fields
    // Includes only one of the fields `federationType`
    "federationType": "string",
    // end of the list of possible fields
    "tokenInfo": {
      "maskedIamToken": "string",
      // Includes only one of the fields `iamTokenId`
      "iamTokenId": "string",
      // end of the list of possible fields
      // Includes only one of the fields `impersonatorId`
      "impersonatorId": "string",
      // end of the list of possible fields
      // Includes only one of the fields `impersonatorType`
      "impersonatorType": "string",
      // end of the list of possible fields
      // Includes only one of the fields `impersonatorName`
      "impersonatorName": "string",
      // end of the list of possible fields
      // Includes only one of the fields `impersonatorFederationId`
      "impersonatorFederationId": "string",
      // end of the list of possible fields
      // Includes only one of the fields `impersonatorFederationName`
      "impersonatorFederationName": "string",
      // end of the list of possible fields
      // Includes only one of the fields `impersonatorFederationType`
      "impersonatorFederationType": "string"
      // end of the list of possible fields
    }
  },
  "authorization": {
    "authorized": "boolean"
  },
  "resourceMetadata": {
    "path": [
      {
        "resourceType": "string",
        "resourceId": "string",
        // Includes only one of the fields `resourceName`
        "resourceName": "string"
        // end of the list of possible fields
      }
    ]
  },
  "requestMetadata": {
    "remoteAddress": "string",
    "userAgent": "string",
    "requestId": "string",
    // Includes only one of the fields `remotePort`
    "remotePort": "string"
    // end of the list of possible fields
  },
  "eventStatus": "string",
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "details": {
    "clusterId": "string",
    "clusterName": "string",
    "catalogId": "string",
    "catalogName": "string",
    "catalog": {
      "id": "string",
      "name": "string",
      "connector": {
        // Includes only one of the fields `hive`, `iceberg`, `deltaLake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`, `hudi`, `mysql`, `greenplum`
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
        "mysql": {
          "connection": {
            // Includes only one of the fields `onPremise`, `connectionManager`
            "onPremise": {
              "connectionUrl": "string",
              "userName": "string",
              "password": "string"
            },
            "connectionManager": {
              "connectionId": "string",
              "connectionProperties": "object"
            }
            // end of the list of possible fields
          },
          "additionalProperties": "object"
        },
        "greenplum": {
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
        }
        // end of the list of possible fields
      },
      "description": "string",
      "labels": "object"
    }
  },
  "requestParameters": "object",
  "response": "object"
}
```

## Field description {#yandex.cloud.audit.trino.DeleteCatalog2}

#|
||Field | Description ||
|| eventId | **string** ||
|| eventSource | **string** ||
|| eventType | **string** ||
|| eventTime | **string** (date-time)

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| authentication | **[IamAuthentication](#yandex.cloud.audit.IamAuthentication)** ||
|| authorization | **[Authorization](#yandex.cloud.audit.Authorization)** ||
|| resourceMetadata | **[ResourceMetadata](#yandex.cloud.audit.ResourceMetadata)** ||
|| requestMetadata | **[RequestMetadata](#yandex.cloud.audit.RequestMetadata)** ||
|| eventStatus | **enum** (EventStatus)

- `STARTED`
- `ERROR`
- `DONE`
- `CANCELLED`
- `RUNNING` ||
|| error | **[Status](#google.rpc.Status)**

The error result of the operation in case of failure or cancellation. ||
|| details | **[CatalogEventDetails](#yandex.cloud.audit.trino.CatalogEventDetails)** ||
|| requestParameters | **object** ||
|| response | **object** ||
|#

## IamAuthentication {#yandex.cloud.audit.IamAuthentication}

#|
||Field | Description ||
|| authenticated | **boolean** ||
|| subjectType | **enum** (IamSubjectType)

Includes only one of the fields `subjectType`.

- `YANDEX_PASSPORT_USER_ACCOUNT`
- `SERVICE_ACCOUNT`
- `FEDERATED_USER_ACCOUNT`
- `SSH_USER`
- `KUBERNETES_USER` ||
|| subjectId | **string**

Includes only one of the fields `subjectId`. ||
|| subjectName | **string**

Includes only one of the fields `subjectName`. ||
|| federationId | **string**

Includes only one of the fields `federationId`. ||
|| federationName | **string**

Includes only one of the fields `federationName`. ||
|| federationType | **enum** (FederationType)

Includes only one of the fields `federationType`.

- `GLOBAL_FEDERATION`
- `PRIVATE_FEDERATION` ||
|| tokenInfo | **[IamTokenInfo](#yandex.cloud.audit.IamAuthentication.IamTokenInfo)** ||
|#

## IamTokenInfo {#yandex.cloud.audit.IamAuthentication.IamTokenInfo}

#|
||Field | Description ||
|| maskedIamToken | **string** ||
|| iamTokenId | **string**

Includes only one of the fields `iamTokenId`. ||
|| impersonatorId | **string**

Includes only one of the fields `impersonatorId`. ||
|| impersonatorType | **enum** (IamSubjectType)

Includes only one of the fields `impersonatorType`.

- `YANDEX_PASSPORT_USER_ACCOUNT`
- `SERVICE_ACCOUNT`
- `FEDERATED_USER_ACCOUNT`
- `SSH_USER`
- `KUBERNETES_USER` ||
|| impersonatorName | **string**

Includes only one of the fields `impersonatorName`. ||
|| impersonatorFederationId | **string**

Includes only one of the fields `impersonatorFederationId`. ||
|| impersonatorFederationName | **string**

Includes only one of the fields `impersonatorFederationName`. ||
|| impersonatorFederationType | **enum** (FederationType)

Includes only one of the fields `impersonatorFederationType`.

- `GLOBAL_FEDERATION`
- `PRIVATE_FEDERATION` ||
|#

## Authorization {#yandex.cloud.audit.Authorization}

#|
||Field | Description ||
|| authorized | **boolean** ||
|#

## ResourceMetadata {#yandex.cloud.audit.ResourceMetadata}

#|
||Field | Description ||
|| path[] | **[Resource](#yandex.cloud.audit.Resource)** ||
|#

## Resource {#yandex.cloud.audit.Resource}

#|
||Field | Description ||
|| resourceType | **string** ||
|| resourceId | **string** ||
|| resourceName | **string**

Includes only one of the fields `resourceName`. ||
|#

## RequestMetadata {#yandex.cloud.audit.RequestMetadata}

#|
||Field | Description ||
|| remoteAddress | **string** ||
|| userAgent | **string** ||
|| requestId | **string** ||
|| remotePort | **string** (int64)

Includes only one of the fields `remotePort`. ||
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

## CatalogEventDetails {#yandex.cloud.audit.trino.CatalogEventDetails}

#|
||Field | Description ||
|| clusterId | **string** ||
|| clusterName | **string** ||
|| catalogId | **string** ||
|| catalogName | **string** ||
|| catalog | **[Catalog](#yandex.cloud.trino.v1.Catalog)** ||
|#

## Catalog {#yandex.cloud.trino.v1.Catalog}

#|
||Field | Description ||
|| id | **string** ||
|| name | **string** ||
|| connector | **[Connector](#yandex.cloud.trino.v1.Connector)** ||
|| description | **string** ||
|| labels | **object** (map<**string**, **string**>) ||
|#

## Connector {#yandex.cloud.trino.v1.Connector}

#|
||Field | Description ||
|| hive | **[HiveConnector](#yandex.cloud.trino.v1.HiveConnector)**

Includes only one of the fields `hive`, `iceberg`, `deltaLake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`, `hudi`, `mysql`, `greenplum`. ||
|| iceberg | **[IcebergConnector](#yandex.cloud.trino.v1.IcebergConnector)**

Includes only one of the fields `hive`, `iceberg`, `deltaLake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`, `hudi`, `mysql`, `greenplum`. ||
|| deltaLake | **[DeltaLakeConnector](#yandex.cloud.trino.v1.DeltaLakeConnector)**

Includes only one of the fields `hive`, `iceberg`, `deltaLake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`, `hudi`, `mysql`, `greenplum`. ||
|| postgresql | **[PostgresqlConnector](#yandex.cloud.trino.v1.PostgresqlConnector)**

Includes only one of the fields `hive`, `iceberg`, `deltaLake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`, `hudi`, `mysql`, `greenplum`. ||
|| clickhouse | **[ClickhouseConnector](#yandex.cloud.trino.v1.ClickhouseConnector)**

Includes only one of the fields `hive`, `iceberg`, `deltaLake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`, `hudi`, `mysql`, `greenplum`. ||
|| tpch | **[TPCHConnector](#yandex.cloud.trino.v1.TPCHConnector)**

Includes only one of the fields `hive`, `iceberg`, `deltaLake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`, `hudi`, `mysql`, `greenplum`. ||
|| tpcds | **[TPCDSConnector](#yandex.cloud.trino.v1.TPCDSConnector)**

Includes only one of the fields `hive`, `iceberg`, `deltaLake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`, `hudi`, `mysql`, `greenplum`. ||
|| oracle | **[OracleConnector](#yandex.cloud.trino.v1.OracleConnector)**

Includes only one of the fields `hive`, `iceberg`, `deltaLake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`, `hudi`, `mysql`, `greenplum`. ||
|| sqlserver | **[SQLServerConnector](#yandex.cloud.trino.v1.SQLServerConnector)**

Includes only one of the fields `hive`, `iceberg`, `deltaLake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`, `hudi`, `mysql`, `greenplum`. ||
|| hudi | **[HudiConnector](#yandex.cloud.trino.v1.HudiConnector)**

Includes only one of the fields `hive`, `iceberg`, `deltaLake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`, `hudi`, `mysql`, `greenplum`. ||
|| mysql | **[MysqlConnector](#yandex.cloud.trino.v1.MysqlConnector)**

Includes only one of the fields `hive`, `iceberg`, `deltaLake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`, `hudi`, `mysql`, `greenplum`. ||
|| greenplum | **[GreenplumConnector](#yandex.cloud.trino.v1.GreenplumConnector)**

Includes only one of the fields `hive`, `iceberg`, `deltaLake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`, `hudi`, `mysql`, `greenplum`. ||
|#

## HiveConnector {#yandex.cloud.trino.v1.HiveConnector}

#|
||Field | Description ||
|| metastore | **[Metastore](#yandex.cloud.trino.v1.Metastore)** ||
|| filesystem | **[FileSystem](#yandex.cloud.trino.v1.FileSystem)** ||
|| additionalProperties | **object** (map<**string**, **string**>)

No more than 256 per resource. The maximum string length in characters for each value is 128. Each value must match the regular expression ` [-_0-9a-zA-Z.,:\/_ *]* `. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-z][-_0-9a-z.]* `. ||
|#

## Metastore {#yandex.cloud.trino.v1.Metastore}

#|
||Field | Description ||
|| hive | **[HiveMetastore](#yandex.cloud.trino.v1.Metastore.HiveMetastore)**

Includes only one of the fields `hive`. ||
|#

## HiveMetastore {#yandex.cloud.trino.v1.Metastore.HiveMetastore}

#|
||Field | Description ||
|| uri | **string**

Includes only one of the fields `uri`. ||
|#

## FileSystem {#yandex.cloud.trino.v1.FileSystem}

#|
||Field | Description ||
|| s3 | **object**

Includes only one of the fields `s3`, `externalS3`. ||
|| externalS3 | **[ExternalS3FileSystem](#yandex.cloud.trino.v1.FileSystem.ExternalS3FileSystem)**

Includes only one of the fields `s3`, `externalS3`. ||
|#

## ExternalS3FileSystem {#yandex.cloud.trino.v1.FileSystem.ExternalS3FileSystem}

#|
||Field | Description ||
|| awsAccessKey | **string** ||
|| awsSecretKey | **string** ||
|| awsEndpoint | **string** ||
|| awsRegion | **string** ||
|#

## IcebergConnector {#yandex.cloud.trino.v1.IcebergConnector}

#|
||Field | Description ||
|| metastore | **[Metastore](#yandex.cloud.trino.v1.Metastore)** ||
|| filesystem | **[FileSystem](#yandex.cloud.trino.v1.FileSystem)** ||
|| additionalProperties | **object** (map<**string**, **string**>)

No more than 256 per resource. The maximum string length in characters for each value is 128. Each value must match the regular expression ` [-_0-9a-zA-Z.,:\/_ *]* `. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-z][-_0-9a-z.]* `. ||
|#

## DeltaLakeConnector {#yandex.cloud.trino.v1.DeltaLakeConnector}

#|
||Field | Description ||
|| metastore | **[Metastore](#yandex.cloud.trino.v1.Metastore)** ||
|| filesystem | **[FileSystem](#yandex.cloud.trino.v1.FileSystem)** ||
|| additionalProperties | **object** (map<**string**, **string**>)

No more than 256 per resource. The maximum string length in characters for each value is 128. Each value must match the regular expression ` [-_0-9a-zA-Z.,:\/_ *]* `. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-z][-_0-9a-z.]* `. ||
|#

## PostgresqlConnector {#yandex.cloud.trino.v1.PostgresqlConnector}

#|
||Field | Description ||
|| connection | **[PostgresqlConnection](#yandex.cloud.trino.v1.PostgresqlConnection)** ||
|| additionalProperties | **object** (map<**string**, **string**>)

No more than 256 per resource. The maximum string length in characters for each value is 128. Each value must match the regular expression ` [-_0-9a-zA-Z.,:\/_ *]* `. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-z][-_0-9a-z.]* `. ||
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

Value must match the regular expression ` ^jdbc:postgresql://(?:.+:\d+)/(?:.*)$ `. ||
|| userName | **string**

The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `. ||
|| password | **string**

The string length in characters must be 0-128. ||
|#

## ConnectionManager {#yandex.cloud.trino.v1.PostgresqlConnection.ConnectionManager}

#|
||Field | Description ||
|| connectionId | **string**

The string length in characters must be 1-50. ||
|| database | **string**

The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `. ||
|| connectionProperties | **object** (map<**string**, **string**>)

No more than 256 per resource. The maximum string length in characters for each value is 128. Each value must match the regular expression ` [-_0-9a-zA-Z.,:\/_]* `. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-zA-Z]* `. ||
|#

## ClickhouseConnector {#yandex.cloud.trino.v1.ClickhouseConnector}

#|
||Field | Description ||
|| connection | **[ClickhouseConnection](#yandex.cloud.trino.v1.ClickhouseConnection)** ||
|| additionalProperties | **object** (map<**string**, **string**>)

No more than 256 per resource. The maximum string length in characters for each value is 128. Each value must match the regular expression ` [-_0-9a-zA-Z.,:\/_ *]* `. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-z][-_0-9a-z.]* `. ||
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

Value must match the regular expression ` ^jdbc:clickhouse://(?:.+:\d+)/(?:.*)$ `. ||
|| userName | **string**

The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `. ||
|| password | **string**

The string length in characters must be 0-128. ||
|#

## ConnectionManager {#yandex.cloud.trino.v1.ClickhouseConnection.ConnectionManager}

#|
||Field | Description ||
|| connectionId | **string**

The string length in characters must be 1-50. ||
|| database | **string**

The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `. ||
|| connectionProperties | **object** (map<**string**, **string**>)

No more than 256 per resource. The maximum string length in characters for each value is 128. Each value must match the regular expression ` [-_0-9a-zA-Z.,:\/_]* `. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-zA-Z_]* `. ||
|#

## TPCHConnector {#yandex.cloud.trino.v1.TPCHConnector}

#|
||Field | Description ||
|| additionalProperties | **object** (map<**string**, **string**>)

No more than 256 per resource. The maximum string length in characters for each value is 128. Each value must match the regular expression ` [-_0-9a-zA-Z.,:\/_ *]* `. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-z][-_0-9a-z.]* `. ||
|#

## TPCDSConnector {#yandex.cloud.trino.v1.TPCDSConnector}

#|
||Field | Description ||
|| additionalProperties | **object** (map<**string**, **string**>)

No more than 256 per resource. The maximum string length in characters for each value is 128. Each value must match the regular expression ` [-_0-9a-zA-Z.,:\/_ *]* `. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-z][-_0-9a-z.]* `. ||
|#

## OracleConnector {#yandex.cloud.trino.v1.OracleConnector}

#|
||Field | Description ||
|| connection | **[OracleConnection](#yandex.cloud.trino.v1.OracleConnection)** ||
|| additionalProperties | **object** (map<**string**, **string**>)

No more than 256 per resource. The maximum string length in characters for each value is 128. Each value must match the regular expression ` [-_0-9a-zA-Z.,:\/_ *]* `. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-z][-_0-9a-z.]* `. ||
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

Value must match the regular expression ` ^jdbc:oracle:(?s:.*)$ `. ||
|| userName | **string**

The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `. ||
|| password | **string**

The string length in characters must be 0-128. ||
|#

## SQLServerConnector {#yandex.cloud.trino.v1.SQLServerConnector}

#|
||Field | Description ||
|| connection | **[SQLServerConnection](#yandex.cloud.trino.v1.SQLServerConnection)** ||
|| additionalProperties | **object** (map<**string**, **string**>)

No more than 256 per resource. The maximum string length in characters for each value is 128. Each value must match the regular expression ` [-_0-9a-zA-Z.,:\/_ *]* `. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-z][-_0-9a-z.]* `. ||
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

Value must match the regular expression ` ^jdbc:sqlserver:(?s:.*)$ `. ||
|| userName | **string**

The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `. ||
|| password | **string**

The string length in characters must be 0-128. ||
|#

## HudiConnector {#yandex.cloud.trino.v1.HudiConnector}

#|
||Field | Description ||
|| metastore | **[Metastore](#yandex.cloud.trino.v1.Metastore)** ||
|| filesystem | **[FileSystem](#yandex.cloud.trino.v1.FileSystem)** ||
|| additionalProperties | **object** (map<**string**, **string**>)

No more than 256 per resource. The maximum string length in characters for each value is 128. Each value must match the regular expression ` [-_0-9a-zA-Z.,:\/_ *]* `. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-z][-_0-9a-z.]* `. ||
|#

## MysqlConnector {#yandex.cloud.trino.v1.MysqlConnector}

#|
||Field | Description ||
|| connection | **[MysqlConnection](#yandex.cloud.trino.v1.MysqlConnection)** ||
|| additionalProperties | **object** (map<**string**, **string**>)

No more than 256 per resource. The maximum string length in characters for each value is 128. Each value must match the regular expression ` [-_0-9a-zA-Z.,:\/_ *]* `. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-z][-_0-9a-z.]* `. ||
|#

## MysqlConnection {#yandex.cloud.trino.v1.MysqlConnection}

#|
||Field | Description ||
|| onPremise | **[OnPremise](#yandex.cloud.trino.v1.MysqlConnection.OnPremise)**

Includes only one of the fields `onPremise`, `connectionManager`. ||
|| connectionManager | **[ConnectionManager](#yandex.cloud.trino.v1.MysqlConnection.ConnectionManager)**

Includes only one of the fields `onPremise`, `connectionManager`. ||
|#

## OnPremise {#yandex.cloud.trino.v1.MysqlConnection.OnPremise}

#|
||Field | Description ||
|| connectionUrl | **string**

Value must match the regular expression ` ^jdbc:mysql://(?:.+:\d+)(?:/?.*)$ `. ||
|| userName | **string**

The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `. ||
|| password | **string**

The string length in characters must be 0-128. ||
|#

## ConnectionManager {#yandex.cloud.trino.v1.MysqlConnection.ConnectionManager}

#|
||Field | Description ||
|| connectionId | **string**

The string length in characters must be 1-50. ||
|| connectionProperties | **object** (map<**string**, **string**>)

No more than 256 per resource. The maximum string length in characters for each value is 128. Each value must match the regular expression ` [-_0-9a-zA-Z.,:\/_]* `. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-zA-Z_]* `. ||
|#

## GreenplumConnector {#yandex.cloud.trino.v1.GreenplumConnector}

#|
||Field | Description ||
|| connection | **[GreenplumConnection](#yandex.cloud.trino.v1.GreenplumConnection)** ||
|| additionalProperties | **object** (map<**string**, **string**>)

No more than 256 per resource. The maximum string length in characters for each value is 128. Each value must match the regular expression ` [-_0-9a-zA-Z.,:\/_ *]* `. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-z][-_0-9a-z.]* `. ||
|#

## GreenplumConnection {#yandex.cloud.trino.v1.GreenplumConnection}

#|
||Field | Description ||
|| onPremise | **[OnPremise](#yandex.cloud.trino.v1.GreenplumConnection.OnPremise)**

Includes only one of the fields `onPremise`, `connectionManager`. ||
|| connectionManager | **[ConnectionManager](#yandex.cloud.trino.v1.GreenplumConnection.ConnectionManager)**

Includes only one of the fields `onPremise`, `connectionManager`. ||
|#

## OnPremise {#yandex.cloud.trino.v1.GreenplumConnection.OnPremise}

#|
||Field | Description ||
|| connectionUrl | **string**

Value must match the regular expression ` ^jdbc:postgresql://(?:.+:\d+)/(?:.*)$ `. ||
|| userName | **string**

The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `. ||
|| password | **string**

The string length in characters must be 0-128. ||
|#

## ConnectionManager {#yandex.cloud.trino.v1.GreenplumConnection.ConnectionManager}

#|
||Field | Description ||
|| connectionId | **string**

The string length in characters must be 1-50. ||
|| database | **string**

The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `. ||
|| connectionProperties | **object** (map<**string**, **string**>)

No more than 256 per resource. The maximum string length in characters for each value is 128. Each value must match the regular expression ` [-_0-9a-zA-Z.,:\/_]* `. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-zA-Z]* `. ||
|#