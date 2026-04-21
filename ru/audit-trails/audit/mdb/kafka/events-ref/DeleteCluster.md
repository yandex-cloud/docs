---
editable: false
---

# Managed Service for Apache Kafka® Audit Trails Events: DeleteCluster

## Event JSON schema {#yandex.cloud.audit.mdb.kafka.DeleteCluster2-schema}

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
    "cluster": {
      "id": "string",
      "folderId": "string",
      "createdAt": "string",
      "name": "string",
      "description": "string",
      "labels": "object",
      "environment": "string",
      "monitoring": [
        {
          "name": "string",
          "description": "string",
          "link": "string"
        }
      ],
      "config": {
        "version": "string",
        "kafka": {
          "resources": {
            "resourcePresetId": "string",
            "diskSize": "string",
            "diskTypeId": "string"
          },
          // Includes only one of the fields `kafkaConfig_2_8`, `kafkaConfig_3`, `kafkaConfig_4`
          "kafkaConfig_2_8": {
            "compressionType": "string",
            "logFlushIntervalMessages": "string",
            "logFlushIntervalMs": "string",
            "logFlushSchedulerIntervalMs": "string",
            "logRetentionBytes": "string",
            "logRetentionHours": "string",
            "logRetentionMinutes": "string",
            "logRetentionMs": "string",
            "logSegmentBytes": "string",
            "logPreallocate": "boolean",
            "socketSendBufferBytes": "string",
            "socketReceiveBufferBytes": "string",
            "autoCreateTopicsEnable": "boolean",
            "numPartitions": "string",
            "defaultReplicationFactor": "string",
            "messageMaxBytes": "string",
            "replicaFetchMaxBytes": "string",
            "sslCipherSuites": [
              "string"
            ],
            "offsetsRetentionMinutes": "string",
            "saslEnabledMechanisms": [
              "string"
            ]
          },
          "kafkaConfig_3": {
            "compressionType": "string",
            "logFlushIntervalMessages": "string",
            "logFlushIntervalMs": "string",
            "logFlushSchedulerIntervalMs": "string",
            "logRetentionBytes": "string",
            "logRetentionHours": "string",
            "logRetentionMinutes": "string",
            "logRetentionMs": "string",
            "logSegmentBytes": "string",
            "logPreallocate": "boolean",
            "socketSendBufferBytes": "string",
            "socketReceiveBufferBytes": "string",
            "autoCreateTopicsEnable": "boolean",
            "numPartitions": "string",
            "defaultReplicationFactor": "string",
            "messageMaxBytes": "string",
            "replicaFetchMaxBytes": "string",
            "sslCipherSuites": [
              "string"
            ],
            "offsetsRetentionMinutes": "string",
            "saslEnabledMechanisms": [
              "string"
            ]
          },
          "kafkaConfig_4": {
            "compressionType": "string",
            "logFlushIntervalMessages": "string",
            "logFlushIntervalMs": "string",
            "logFlushSchedulerIntervalMs": "string",
            "logRetentionBytes": "string",
            "logRetentionHours": "string",
            "logRetentionMinutes": "string",
            "logRetentionMs": "string",
            "logSegmentBytes": "string",
            "socketSendBufferBytes": "string",
            "socketReceiveBufferBytes": "string",
            "autoCreateTopicsEnable": "boolean",
            "numPartitions": "string",
            "defaultReplicationFactor": "string",
            "messageMaxBytes": "string",
            "replicaFetchMaxBytes": "string",
            "sslCipherSuites": [
              "string"
            ],
            "offsetsRetentionMinutes": "string",
            "saslEnabledMechanisms": [
              "string"
            ]
          }
          // end of the list of possible fields
        },
        "zookeeper": {
          "resources": {
            "resourcePresetId": "string",
            "diskSize": "string",
            "diskTypeId": "string"
          }
        },
        "zoneId": [
          "string"
        ],
        "brokersCount": "string",
        "assignPublicIp": "boolean",
        "unmanagedTopics": "boolean",
        "schemaRegistry": "boolean",
        "access": {
          "dataTransfer": "boolean"
        },
        "restApiConfig": {
          "enabled": "boolean"
        },
        "diskSizeAutoscaling": {
          "plannedUsageThreshold": "string",
          "emergencyUsageThreshold": "string",
          "diskSizeLimit": "string"
        },
        "kraft": {
          "resources": {
            "resourcePresetId": "string",
            "diskSize": "string",
            "diskTypeId": "string"
          }
        },
        "kafkaUiConfig": {
          "enabled": "boolean"
        },
        "patchVersion": "string"
      },
      "networkId": "string",
      "health": "string",
      "status": "string",
      "securityGroupIds": [
        "string"
      ],
      "hostGroupIds": [
        "string"
      ],
      "deletionProtection": "boolean",
      "maintenanceWindow": {
        // Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`
        "anytime": "object",
        "weeklyMaintenanceWindow": {
          "day": "string",
          "hour": "string"
        }
        // end of the list of possible fields
      },
      "plannedOperation": {
        "info": "string",
        "delayedUntil": "string"
      },
      "kafkaUi": {
        "url": "string"
      },
      "diskEncryptionKeyId": "string"
    }
  },
  "requestParameters": "object",
  "response": "object"
}
```

## Field description {#yandex.cloud.audit.mdb.kafka.DeleteCluster2}

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
|| details | **[ClusterEventDetails](#yandex.cloud.audit.mdb.kafka.ClusterEventDetails)** ||
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

## ClusterEventDetails {#yandex.cloud.audit.mdb.kafka.ClusterEventDetails}

#|
||Field | Description ||
|| clusterId | **string**

The maximum string length in characters is 50. ||
|| clusterName | **string**

The maximum string length in characters is 63. ||
|| cluster | **[Cluster](#yandex.cloud.mdb.kafka.v1.Cluster)** ||
|#

## Cluster {#yandex.cloud.mdb.kafka.v1.Cluster}

#|
||Field | Description ||
|| id | **string** ||
|| folderId | **string** ||
|| createdAt | **string** (date-time)

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| name | **string** ||
|| description | **string** ||
|| labels | **object** (map<**string**, **string**>) ||
|| environment | **enum** (Environment)

- `PRODUCTION`
- `PRESTABLE` ||
|| monitoring[] | **[Monitoring](#yandex.cloud.mdb.kafka.v1.Monitoring)** ||
|| config | **[ConfigSpec](#yandex.cloud.mdb.kafka.v1.ConfigSpec)** ||
|| networkId | **string** ||
|| health | **enum** (Health)

- `HEALTH_UNKNOWN`
- `ALIVE`
- `DEAD`
- `DEGRADED` ||
|| status | **enum** (Status)

- `STATUS_UNKNOWN`
- `CREATING`
- `RUNNING`
- `ERROR`
- `UPDATING`
- `STOPPING`
- `STOPPED`
- `STARTING` ||
|| securityGroupIds[] | **string** ||
|| hostGroupIds[] | **string** ||
|| deletionProtection | **boolean** ||
|| maintenanceWindow | **[MaintenanceWindow](#yandex.cloud.mdb.kafka.v1.MaintenanceWindow)** ||
|| plannedOperation | **[MaintenanceOperation](#yandex.cloud.mdb.kafka.v1.MaintenanceOperation)** ||
|| kafkaUi | **[KafkaUI](#yandex.cloud.mdb.kafka.v1.Cluster.KafkaUI)** ||
|| diskEncryptionKeyId | **string** ||
|#

## Monitoring {#yandex.cloud.mdb.kafka.v1.Monitoring}

#|
||Field | Description ||
|| name | **string** ||
|| description | **string** ||
|| link | **string** ||
|#

## ConfigSpec {#yandex.cloud.mdb.kafka.v1.ConfigSpec}

#|
||Field | Description ||
|| version | **string** ||
|| kafka | **[Kafka](#yandex.cloud.mdb.kafka.v1.ConfigSpec.Kafka)** ||
|| zookeeper | **[Zookeeper](#yandex.cloud.mdb.kafka.v1.ConfigSpec.Zookeeper)** ||
|| zoneId[] | **string** ||
|| brokersCount | **string** (int64) ||
|| assignPublicIp | **boolean** ||
|| unmanagedTopics | **boolean** ||
|| schemaRegistry | **boolean** ||
|| access | **[Access](#yandex.cloud.mdb.kafka.v1.Access)** ||
|| restApiConfig | **[RestAPIConfig](#yandex.cloud.mdb.kafka.v1.ConfigSpec.RestAPIConfig)** ||
|| diskSizeAutoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.kafka.v1.DiskSizeAutoscaling)** ||
|| kraft | **[KRaft](#yandex.cloud.mdb.kafka.v1.ConfigSpec.KRaft)** ||
|| kafkaUiConfig | **[KafkaUIConfig](#yandex.cloud.mdb.kafka.v1.ConfigSpec.KafkaUIConfig)** ||
|| patchVersion | **string** ||
|#

## Kafka {#yandex.cloud.mdb.kafka.v1.ConfigSpec.Kafka}

#|
||Field | Description ||
|| resources | **[Resources](#yandex.cloud.mdb.kafka.v1.Resources)** ||
|| kafkaConfig_2_8 | **[KafkaConfig2_8](#yandex.cloud.mdb.kafka.v1.KafkaConfig2_8)**

Includes only one of the fields `kafkaConfig_2_8`, `kafkaConfig_3`, `kafkaConfig_4`. ||
|| kafkaConfig_3 | **[KafkaConfig3](#yandex.cloud.mdb.kafka.v1.KafkaConfig3)**

Includes only one of the fields `kafkaConfig_2_8`, `kafkaConfig_3`, `kafkaConfig_4`. ||
|| kafkaConfig_4 | **[KafkaConfig4](#yandex.cloud.mdb.kafka.v1.KafkaConfig4)**

Includes only one of the fields `kafkaConfig_2_8`, `kafkaConfig_3`, `kafkaConfig_4`. ||
|#

## Resources {#yandex.cloud.mdb.kafka.v1.Resources}

#|
||Field | Description ||
|| resourcePresetId | **string** ||
|| diskSize | **string** (int64) ||
|| diskTypeId | **string** ||
|#

## KafkaConfig2_8 {#yandex.cloud.mdb.kafka.v1.KafkaConfig2_8}

#|
||Field | Description ||
|| compressionType | **enum** (CompressionType)

- `COMPRESSION_TYPE_UNCOMPRESSED`
- `COMPRESSION_TYPE_ZSTD`
- `COMPRESSION_TYPE_LZ4`
- `COMPRESSION_TYPE_SNAPPY`
- `COMPRESSION_TYPE_GZIP`
- `COMPRESSION_TYPE_PRODUCER` ||
|| logFlushIntervalMessages | **string** (int64) ||
|| logFlushIntervalMs | **string** (int64) ||
|| logFlushSchedulerIntervalMs | **string** (int64) ||
|| logRetentionBytes | **string** (int64) ||
|| logRetentionHours | **string** (int64) ||
|| logRetentionMinutes | **string** (int64) ||
|| logRetentionMs | **string** (int64) ||
|| logSegmentBytes | **string** (int64) ||
|| logPreallocate | **boolean** ||
|| socketSendBufferBytes | **string** (int64) ||
|| socketReceiveBufferBytes | **string** (int64) ||
|| autoCreateTopicsEnable | **boolean** ||
|| numPartitions | **string** (int64) ||
|| defaultReplicationFactor | **string** (int64) ||
|| messageMaxBytes | **string** (int64) ||
|| replicaFetchMaxBytes | **string** (int64) ||
|| sslCipherSuites[] | **string** ||
|| offsetsRetentionMinutes | **string** (int64) ||
|| saslEnabledMechanisms[] | **enum** (SaslMechanism)

- `SASL_MECHANISM_SCRAM_SHA_256`
- `SASL_MECHANISM_SCRAM_SHA_512` ||
|#

## KafkaConfig3 {#yandex.cloud.mdb.kafka.v1.KafkaConfig3}

#|
||Field | Description ||
|| compressionType | **enum** (CompressionType)

- `COMPRESSION_TYPE_UNCOMPRESSED`
- `COMPRESSION_TYPE_ZSTD`
- `COMPRESSION_TYPE_LZ4`
- `COMPRESSION_TYPE_SNAPPY`
- `COMPRESSION_TYPE_GZIP`
- `COMPRESSION_TYPE_PRODUCER` ||
|| logFlushIntervalMessages | **string** (int64) ||
|| logFlushIntervalMs | **string** (int64) ||
|| logFlushSchedulerIntervalMs | **string** (int64) ||
|| logRetentionBytes | **string** (int64) ||
|| logRetentionHours | **string** (int64) ||
|| logRetentionMinutes | **string** (int64) ||
|| logRetentionMs | **string** (int64) ||
|| logSegmentBytes | **string** (int64) ||
|| logPreallocate | **boolean** ||
|| socketSendBufferBytes | **string** (int64) ||
|| socketReceiveBufferBytes | **string** (int64) ||
|| autoCreateTopicsEnable | **boolean** ||
|| numPartitions | **string** (int64) ||
|| defaultReplicationFactor | **string** (int64) ||
|| messageMaxBytes | **string** (int64) ||
|| replicaFetchMaxBytes | **string** (int64) ||
|| sslCipherSuites[] | **string** ||
|| offsetsRetentionMinutes | **string** (int64) ||
|| saslEnabledMechanisms[] | **enum** (SaslMechanism)

- `SASL_MECHANISM_SCRAM_SHA_256`
- `SASL_MECHANISM_SCRAM_SHA_512` ||
|#

## KafkaConfig4 {#yandex.cloud.mdb.kafka.v1.KafkaConfig4}

#|
||Field | Description ||
|| compressionType | **enum** (CompressionType)

- `COMPRESSION_TYPE_UNCOMPRESSED`
- `COMPRESSION_TYPE_ZSTD`
- `COMPRESSION_TYPE_LZ4`
- `COMPRESSION_TYPE_SNAPPY`
- `COMPRESSION_TYPE_GZIP`
- `COMPRESSION_TYPE_PRODUCER` ||
|| logFlushIntervalMessages | **string** (int64) ||
|| logFlushIntervalMs | **string** (int64) ||
|| logFlushSchedulerIntervalMs | **string** (int64) ||
|| logRetentionBytes | **string** (int64) ||
|| logRetentionHours | **string** (int64) ||
|| logRetentionMinutes | **string** (int64) ||
|| logRetentionMs | **string** (int64) ||
|| logSegmentBytes | **string** (int64) ||
|| socketSendBufferBytes | **string** (int64) ||
|| socketReceiveBufferBytes | **string** (int64) ||
|| autoCreateTopicsEnable | **boolean** ||
|| numPartitions | **string** (int64) ||
|| defaultReplicationFactor | **string** (int64) ||
|| messageMaxBytes | **string** (int64) ||
|| replicaFetchMaxBytes | **string** (int64) ||
|| sslCipherSuites[] | **string** ||
|| offsetsRetentionMinutes | **string** (int64) ||
|| saslEnabledMechanisms[] | **enum** (SaslMechanism)

- `SASL_MECHANISM_SCRAM_SHA_256`
- `SASL_MECHANISM_SCRAM_SHA_512` ||
|#

## Zookeeper {#yandex.cloud.mdb.kafka.v1.ConfigSpec.Zookeeper}

#|
||Field | Description ||
|| resources | **[Resources](#yandex.cloud.mdb.kafka.v1.Resources)** ||
|#

## Access {#yandex.cloud.mdb.kafka.v1.Access}

#|
||Field | Description ||
|| dataTransfer | **boolean** ||
|#

## RestAPIConfig {#yandex.cloud.mdb.kafka.v1.ConfigSpec.RestAPIConfig}

#|
||Field | Description ||
|| enabled | **boolean** ||
|#

## DiskSizeAutoscaling {#yandex.cloud.mdb.kafka.v1.DiskSizeAutoscaling}

#|
||Field | Description ||
|| plannedUsageThreshold | **string** (int64)

Acceptable values are 0 to 100, inclusive. ||
|| emergencyUsageThreshold | **string** (int64)

Acceptable values are 0 to 100, inclusive. ||
|| diskSizeLimit | **string** (int64) ||
|#

## KRaft {#yandex.cloud.mdb.kafka.v1.ConfigSpec.KRaft}

#|
||Field | Description ||
|| resources | **[Resources](#yandex.cloud.mdb.kafka.v1.Resources)** ||
|#

## KafkaUIConfig {#yandex.cloud.mdb.kafka.v1.ConfigSpec.KafkaUIConfig}

#|
||Field | Description ||
|| enabled | **boolean** ||
|#

## MaintenanceWindow {#yandex.cloud.mdb.kafka.v1.MaintenanceWindow}

#|
||Field | Description ||
|| anytime | **object**

Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`. ||
|| weeklyMaintenanceWindow | **[WeeklyMaintenanceWindow](#yandex.cloud.mdb.kafka.v1.WeeklyMaintenanceWindow)**

Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`. ||
|#

## WeeklyMaintenanceWindow {#yandex.cloud.mdb.kafka.v1.WeeklyMaintenanceWindow}

#|
||Field | Description ||
|| day | **enum** (WeekDay)

- `MON`
- `TUE`
- `WED`
- `THU`
- `FRI`
- `SAT`
- `SUN` ||
|| hour | **string** (int64)

Acceptable values are 1 to 24, inclusive. ||
|#

## MaintenanceOperation {#yandex.cloud.mdb.kafka.v1.MaintenanceOperation}

#|
||Field | Description ||
|| info | **string**

The maximum string length in characters is 256. ||
|| delayedUntil | **string** (date-time)

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|#

## KafkaUI {#yandex.cloud.mdb.kafka.v1.Cluster.KafkaUI}

#|
||Field | Description ||
|| url | **string** ||
|#