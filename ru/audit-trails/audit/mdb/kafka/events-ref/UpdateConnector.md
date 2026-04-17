---
editable: false
---

# Managed Service for Apache Kafka® Audit Trails Events: UpdateConnector

## Event JSON schema {#yandex.cloud.audit.mdb.kafka.UpdateConnector2-schema}

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
    "connectorName": "string",
    "clusterName": "string",
    "connector": {
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
  },
  "requestParameters": "object",
  "response": "object"
}
```

## Field description {#yandex.cloud.audit.mdb.kafka.UpdateConnector2}

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
|| details | **[ConnectorEventDetails](#yandex.cloud.audit.mdb.kafka.ConnectorEventDetails)** ||
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

## ConnectorEventDetails {#yandex.cloud.audit.mdb.kafka.ConnectorEventDetails}

#|
||Field | Description ||
|| clusterId | **string**

The maximum string length in characters is 50. ||
|| connectorName | **string**

The maximum string length in characters is 256. ||
|| clusterName | **string**

The maximum string length in characters is 63. ||
|| connector | **[Connector](#yandex.cloud.mdb.kafka.v1.Connector)** ||
|#

## Connector {#yandex.cloud.mdb.kafka.v1.Connector}

#|
||Field | Description ||
|| name | **string** ||
|| tasksMax | **string** (int64) ||
|| properties | **object** (map<**string**, **string**>) ||
|| health | **enum** (Health)

- `HEALTH_UNKNOWN`
- `ALIVE`
- `DEAD` ||
|| status | **enum** (Status)

- `STATUS_UNKNOWN`
- `RUNNING`
- `ERROR`
- `PAUSED` ||
|| clusterId | **string** ||
|| connectorConfigMirrormaker | **[ConnectorConfigMirrorMaker](#yandex.cloud.mdb.kafka.v1.ConnectorConfigMirrorMaker)**

Includes only one of the fields `connectorConfigMirrormaker`, `connectorConfigS3Sink`, `connectorConfigIcebergSink`. ||
|| connectorConfigS3Sink | **[ConnectorConfigS3Sink](#yandex.cloud.mdb.kafka.v1.ConnectorConfigS3Sink)**

Includes only one of the fields `connectorConfigMirrormaker`, `connectorConfigS3Sink`, `connectorConfigIcebergSink`. ||
|| connectorConfigIcebergSink | **[ConnectorConfigIcebergSink](#yandex.cloud.mdb.kafka.v1.ConnectorConfigIcebergSink)**

Includes only one of the fields `connectorConfigMirrormaker`, `connectorConfigS3Sink`, `connectorConfigIcebergSink`. ||
|#

## ConnectorConfigMirrorMaker {#yandex.cloud.mdb.kafka.v1.ConnectorConfigMirrorMaker}

#|
||Field | Description ||
|| sourceCluster | **[ClusterConnection](#yandex.cloud.mdb.kafka.v1.ClusterConnection)** ||
|| targetCluster | **[ClusterConnection](#yandex.cloud.mdb.kafka.v1.ClusterConnection)** ||
|| topics | **string** ||
|| replicationFactor | **string** (int64) ||
|#

## ClusterConnection {#yandex.cloud.mdb.kafka.v1.ClusterConnection}

#|
||Field | Description ||
|| alias | **string** ||
|| thisCluster | **object**

Includes only one of the fields `thisCluster`, `externalCluster`. ||
|| externalCluster | **[ExternalClusterConnection](#yandex.cloud.mdb.kafka.v1.ExternalClusterConnection)**

Includes only one of the fields `thisCluster`, `externalCluster`. ||
|#

## ExternalClusterConnection {#yandex.cloud.mdb.kafka.v1.ExternalClusterConnection}

#|
||Field | Description ||
|| bootstrapServers | **string** ||
|| saslUsername | **string** ||
|| saslMechanism | **string** ||
|| securityProtocol | **string** ||
|#

## ConnectorConfigS3Sink {#yandex.cloud.mdb.kafka.v1.ConnectorConfigS3Sink}

#|
||Field | Description ||
|| topics | **string** ||
|| fileCompressionType | **string** ||
|| fileMaxRecords | **string** (int64) ||
|| s3Connection | **[S3Connection](#yandex.cloud.mdb.kafka.v1.S3Connection)** ||
|#

## S3Connection {#yandex.cloud.mdb.kafka.v1.S3Connection}

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
|| region | **string** ||
|#

## ConnectorConfigIcebergSink {#yandex.cloud.mdb.kafka.v1.ConnectorConfigIcebergSink}

#|
||Field | Description ||
|| topics | **string**

Includes only one of the fields `topics`, `topicsRegex`. ||
|| topicsRegex | **string**

Includes only one of the fields `topics`, `topicsRegex`. ||
|| controlTopic | **string** ||
|| metastoreConnection | **[MetastoreConnection](#yandex.cloud.mdb.kafka.v1.MetastoreConnection)** ||
|| s3Connection | **[IcebergS3Connection](#yandex.cloud.mdb.kafka.v1.IcebergS3Connection)** ||
|| staticTables | **[StaticTables](#yandex.cloud.mdb.kafka.v1.StaticTables)**

Includes only one of the fields `staticTables`, `dynamicTables`. ||
|| dynamicTables | **[DynamicTables](#yandex.cloud.mdb.kafka.v1.DynamicTables)**

Includes only one of the fields `staticTables`, `dynamicTables`. ||
|| tablesConfig | **[IcebergTablesConfig](#yandex.cloud.mdb.kafka.v1.IcebergTablesConfig)** ||
|| controlConfig | **[IcebergControl](#yandex.cloud.mdb.kafka.v1.IcebergControl)** ||
|#

## MetastoreConnection {#yandex.cloud.mdb.kafka.v1.MetastoreConnection}

#|
||Field | Description ||
|| catalogUri | **string** ||
|| warehouse | **string** ||
|#

## IcebergS3Connection {#yandex.cloud.mdb.kafka.v1.IcebergS3Connection}

#|
||Field | Description ||
|| externalS3 | **[ExternalIcebergS3Storage](#yandex.cloud.mdb.kafka.v1.ExternalIcebergS3Storage)**

Includes only one of the fields `externalS3`. ||
|#

## ExternalIcebergS3Storage {#yandex.cloud.mdb.kafka.v1.ExternalIcebergS3Storage}

#|
||Field | Description ||
|| accessKeyId | **string** ||
|| endpoint | **string** ||
|| region | **string** ||
|#

## StaticTables {#yandex.cloud.mdb.kafka.v1.StaticTables}

#|
||Field | Description ||
|| tables | **string** ||
|#

## DynamicTables {#yandex.cloud.mdb.kafka.v1.DynamicTables}

#|
||Field | Description ||
|| routeField | **string** ||
|#

## IcebergTablesConfig {#yandex.cloud.mdb.kafka.v1.IcebergTablesConfig}

#|
||Field | Description ||
|| defaultCommitBranch | **string** ||
|| defaultIdColumns | **string** ||
|| defaultPartitionBy | **string** ||
|| evolveSchemaEnabled | **boolean** ||
|| schemaForceOptional | **boolean** ||
|| schemaCaseInsensitive | **boolean** ||
|#

## IcebergControl {#yandex.cloud.mdb.kafka.v1.IcebergControl}

#|
||Field | Description ||
|| groupIdPrefix | **string** ||
|| commitIntervalMs | **string** (int64) ||
|| commitTimeoutMs | **string** (int64) ||
|| commitThreads | **string** (int64) ||
|| transactionalPrefix | **string** ||
|#