---
editable: false
---

# Managed Service for ValKey Audit Trails Events: EnableClusterSharding

## Event JSON schema {#yandex.cloud.audit.mdb.redis.EnableClusterSharding2-schema}

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
        // Includes only one of the fields `redisConfig_5_0`, `redisConfig_6_0`, `redisConfig_6_2`, `redisConfig_7_0`
        "redisConfig_5_0": {
          "effectiveConfig": {
            "maxmemoryPolicy": "string",
            "timeout": "string",
            "password": "string",
            "databases": "string",
            "slowlogLogSlowerThan": "string",
            "slowlogMaxLen": "string",
            "notifyKeyspaceEvents": "string",
            "clientOutputBufferLimitPubsub": {
              "hardLimit": "string",
              "softLimit": "string",
              "softSeconds": "string"
            },
            "clientOutputBufferLimitNormal": {
              "hardLimit": "string",
              "softLimit": "string",
              "softSeconds": "string"
            }
          },
          "userConfig": {
            "maxmemoryPolicy": "string",
            "timeout": "string",
            "password": "string",
            "databases": "string",
            "slowlogLogSlowerThan": "string",
            "slowlogMaxLen": "string",
            "notifyKeyspaceEvents": "string",
            "clientOutputBufferLimitPubsub": {
              "hardLimit": "string",
              "softLimit": "string",
              "softSeconds": "string"
            },
            "clientOutputBufferLimitNormal": {
              "hardLimit": "string",
              "softLimit": "string",
              "softSeconds": "string"
            }
          },
          "defaultConfig": {
            "maxmemoryPolicy": "string",
            "timeout": "string",
            "password": "string",
            "databases": "string",
            "slowlogLogSlowerThan": "string",
            "slowlogMaxLen": "string",
            "notifyKeyspaceEvents": "string",
            "clientOutputBufferLimitPubsub": {
              "hardLimit": "string",
              "softLimit": "string",
              "softSeconds": "string"
            },
            "clientOutputBufferLimitNormal": {
              "hardLimit": "string",
              "softLimit": "string",
              "softSeconds": "string"
            }
          }
        },
        "redisConfig_6_0": {
          "effectiveConfig": {
            "maxmemoryPolicy": "string",
            "timeout": "string",
            "password": "string",
            "databases": "string",
            "slowlogLogSlowerThan": "string",
            "slowlogMaxLen": "string",
            "notifyKeyspaceEvents": "string",
            "clientOutputBufferLimitPubsub": {
              "hardLimit": "string",
              "softLimit": "string",
              "softSeconds": "string"
            },
            "clientOutputBufferLimitNormal": {
              "hardLimit": "string",
              "softLimit": "string",
              "softSeconds": "string"
            }
          },
          "userConfig": {
            "maxmemoryPolicy": "string",
            "timeout": "string",
            "password": "string",
            "databases": "string",
            "slowlogLogSlowerThan": "string",
            "slowlogMaxLen": "string",
            "notifyKeyspaceEvents": "string",
            "clientOutputBufferLimitPubsub": {
              "hardLimit": "string",
              "softLimit": "string",
              "softSeconds": "string"
            },
            "clientOutputBufferLimitNormal": {
              "hardLimit": "string",
              "softLimit": "string",
              "softSeconds": "string"
            }
          },
          "defaultConfig": {
            "maxmemoryPolicy": "string",
            "timeout": "string",
            "password": "string",
            "databases": "string",
            "slowlogLogSlowerThan": "string",
            "slowlogMaxLen": "string",
            "notifyKeyspaceEvents": "string",
            "clientOutputBufferLimitPubsub": {
              "hardLimit": "string",
              "softLimit": "string",
              "softSeconds": "string"
            },
            "clientOutputBufferLimitNormal": {
              "hardLimit": "string",
              "softLimit": "string",
              "softSeconds": "string"
            }
          }
        },
        "redisConfig_6_2": {
          "effectiveConfig": {
            "maxmemoryPolicy": "string",
            "timeout": "string",
            "password": "string",
            "databases": "string",
            "slowlogLogSlowerThan": "string",
            "slowlogMaxLen": "string",
            "notifyKeyspaceEvents": "string",
            "clientOutputBufferLimitPubsub": {
              "hardLimit": "string",
              "softLimit": "string",
              "softSeconds": "string"
            },
            "clientOutputBufferLimitNormal": {
              "hardLimit": "string",
              "softLimit": "string",
              "softSeconds": "string"
            },
            "maxmemoryPercent": "string"
          },
          "userConfig": {
            "maxmemoryPolicy": "string",
            "timeout": "string",
            "password": "string",
            "databases": "string",
            "slowlogLogSlowerThan": "string",
            "slowlogMaxLen": "string",
            "notifyKeyspaceEvents": "string",
            "clientOutputBufferLimitPubsub": {
              "hardLimit": "string",
              "softLimit": "string",
              "softSeconds": "string"
            },
            "clientOutputBufferLimitNormal": {
              "hardLimit": "string",
              "softLimit": "string",
              "softSeconds": "string"
            },
            "maxmemoryPercent": "string"
          },
          "defaultConfig": {
            "maxmemoryPolicy": "string",
            "timeout": "string",
            "password": "string",
            "databases": "string",
            "slowlogLogSlowerThan": "string",
            "slowlogMaxLen": "string",
            "notifyKeyspaceEvents": "string",
            "clientOutputBufferLimitPubsub": {
              "hardLimit": "string",
              "softLimit": "string",
              "softSeconds": "string"
            },
            "clientOutputBufferLimitNormal": {
              "hardLimit": "string",
              "softLimit": "string",
              "softSeconds": "string"
            },
            "maxmemoryPercent": "string"
          }
        },
        "redisConfig_7_0": {
          "effectiveConfig": {
            "maxmemoryPolicy": "string",
            "timeout": "string",
            "password": "string",
            "databases": "string",
            "slowlogLogSlowerThan": "string",
            "slowlogMaxLen": "string",
            "notifyKeyspaceEvents": "string",
            "clientOutputBufferLimitPubsub": {
              "hardLimit": "string",
              "softLimit": "string",
              "softSeconds": "string"
            },
            "clientOutputBufferLimitNormal": {
              "hardLimit": "string",
              "softLimit": "string",
              "softSeconds": "string"
            },
            "maxmemoryPercent": "string"
          },
          "userConfig": {
            "maxmemoryPolicy": "string",
            "timeout": "string",
            "password": "string",
            "databases": "string",
            "slowlogLogSlowerThan": "string",
            "slowlogMaxLen": "string",
            "notifyKeyspaceEvents": "string",
            "clientOutputBufferLimitPubsub": {
              "hardLimit": "string",
              "softLimit": "string",
              "softSeconds": "string"
            },
            "clientOutputBufferLimitNormal": {
              "hardLimit": "string",
              "softLimit": "string",
              "softSeconds": "string"
            },
            "maxmemoryPercent": "string"
          },
          "defaultConfig": {
            "maxmemoryPolicy": "string",
            "timeout": "string",
            "password": "string",
            "databases": "string",
            "slowlogLogSlowerThan": "string",
            "slowlogMaxLen": "string",
            "notifyKeyspaceEvents": "string",
            "clientOutputBufferLimitPubsub": {
              "hardLimit": "string",
              "softLimit": "string",
              "softSeconds": "string"
            },
            "clientOutputBufferLimitNormal": {
              "hardLimit": "string",
              "softLimit": "string",
              "softSeconds": "string"
            },
            "maxmemoryPercent": "string"
          }
        },
        // end of the list of possible fields
        "resources": {
          "resourcePresetId": "string",
          "diskSize": "string",
          "diskTypeId": "string"
        },
        "backupWindowStart": {
          "hours": "integer",
          "minutes": "integer",
          "seconds": "integer",
          "nanos": "integer"
        },
        "access": {
          "dataLens": "boolean",
          "webSql": "boolean"
        },
        "redis": {
          "effectiveConfig": {
            "maxmemoryPolicy": "string",
            "timeout": "string",
            "password": "string",
            "databases": "string",
            "slowlogLogSlowerThan": "string",
            "slowlogMaxLen": "string",
            "notifyKeyspaceEvents": "string",
            "clientOutputBufferLimitPubsub": {
              "hardLimit": "string",
              "softLimit": "string",
              "softSeconds": "string"
            },
            "clientOutputBufferLimitNormal": {
              "hardLimit": "string",
              "softLimit": "string",
              "softSeconds": "string"
            },
            "maxmemoryPercent": "string",
            "luaTimeLimit": "string",
            "replBacklogSizePercent": "string",
            "clusterRequireFullCoverage": "boolean",
            "clusterAllowReadsWhenDown": "boolean",
            "clusterAllowPubsubshardWhenDown": "boolean",
            "lfuDecayTime": "string",
            "lfuLogFactor": "string",
            "turnBeforeSwitchover": "boolean",
            "allowDataLoss": "boolean",
            "useLuajit": "boolean",
            "ioThreadsAllowed": "boolean",
            "zsetMaxListpackEntries": "string",
            "aofMaxSizePercent": "string",
            "activedefrag": "boolean"
          },
          "userConfig": {
            "maxmemoryPolicy": "string",
            "timeout": "string",
            "password": "string",
            "databases": "string",
            "slowlogLogSlowerThan": "string",
            "slowlogMaxLen": "string",
            "notifyKeyspaceEvents": "string",
            "clientOutputBufferLimitPubsub": {
              "hardLimit": "string",
              "softLimit": "string",
              "softSeconds": "string"
            },
            "clientOutputBufferLimitNormal": {
              "hardLimit": "string",
              "softLimit": "string",
              "softSeconds": "string"
            },
            "maxmemoryPercent": "string",
            "luaTimeLimit": "string",
            "replBacklogSizePercent": "string",
            "clusterRequireFullCoverage": "boolean",
            "clusterAllowReadsWhenDown": "boolean",
            "clusterAllowPubsubshardWhenDown": "boolean",
            "lfuDecayTime": "string",
            "lfuLogFactor": "string",
            "turnBeforeSwitchover": "boolean",
            "allowDataLoss": "boolean",
            "useLuajit": "boolean",
            "ioThreadsAllowed": "boolean",
            "zsetMaxListpackEntries": "string",
            "aofMaxSizePercent": "string",
            "activedefrag": "boolean"
          },
          "defaultConfig": {
            "maxmemoryPolicy": "string",
            "timeout": "string",
            "password": "string",
            "databases": "string",
            "slowlogLogSlowerThan": "string",
            "slowlogMaxLen": "string",
            "notifyKeyspaceEvents": "string",
            "clientOutputBufferLimitPubsub": {
              "hardLimit": "string",
              "softLimit": "string",
              "softSeconds": "string"
            },
            "clientOutputBufferLimitNormal": {
              "hardLimit": "string",
              "softLimit": "string",
              "softSeconds": "string"
            },
            "maxmemoryPercent": "string",
            "luaTimeLimit": "string",
            "replBacklogSizePercent": "string",
            "clusterRequireFullCoverage": "boolean",
            "clusterAllowReadsWhenDown": "boolean",
            "clusterAllowPubsubshardWhenDown": "boolean",
            "lfuDecayTime": "string",
            "lfuLogFactor": "string",
            "turnBeforeSwitchover": "boolean",
            "allowDataLoss": "boolean",
            "useLuajit": "boolean",
            "ioThreadsAllowed": "boolean",
            "zsetMaxListpackEntries": "string",
            "aofMaxSizePercent": "string",
            "activedefrag": "boolean"
          }
        },
        "diskSizeAutoscaling": {
          "plannedUsageThreshold": "string",
          "emergencyUsageThreshold": "string",
          "diskSizeLimit": "string"
        },
        "backupRetainPeriodDays": "string",
        "modules": {
          "valkeySearch": {
            "enabled": "boolean",
            "readerThreads": "string",
            "writerThreads": "string"
          },
          "valkeyJson": {
            "enabled": "boolean"
          },
          "valkeyBloom": {
            "enabled": "boolean"
          }
        },
        "fullVersion": "string"
      },
      "networkId": "string",
      "health": "string",
      "status": "string",
      "sharded": "boolean",
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
      "securityGroupIds": [
        "string"
      ],
      "tlsEnabled": "boolean",
      "deletionProtection": "boolean",
      "persistenceMode": "string",
      "announceHostnames": "boolean",
      "authSentinel": "boolean",
      "diskEncryptionKeyId": "string"
    }
  },
  "requestParameters": "object",
  "response": "object"
}
```

## Field description {#yandex.cloud.audit.mdb.redis.EnableClusterSharding2}

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
|| details | **[ClusterEventDetails](#yandex.cloud.audit.mdb.redis.ClusterEventDetails)** ||
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

## ClusterEventDetails {#yandex.cloud.audit.mdb.redis.ClusterEventDetails}

#|
||Field | Description ||
|| clusterId | **string** ||
|| cluster | **[Cluster](#yandex.cloud.mdb.redis.v1.Cluster)** ||
|#

## Cluster {#yandex.cloud.mdb.redis.v1.Cluster}

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
|| monitoring[] | **[Monitoring](#yandex.cloud.mdb.redis.v1.Monitoring)** ||
|| config | **[ClusterConfig](#yandex.cloud.mdb.redis.v1.ClusterConfig)** ||
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
|| sharded | **boolean** ||
|| maintenanceWindow | **[MaintenanceWindow](#yandex.cloud.mdb.redis.v1.MaintenanceWindow)** ||
|| plannedOperation | **[MaintenanceOperation](#yandex.cloud.mdb.redis.v1.MaintenanceOperation)** ||
|| securityGroupIds[] | **string** ||
|| tlsEnabled | **boolean** ||
|| deletionProtection | **boolean** ||
|| persistenceMode | **enum** (PersistenceMode)

- `ON`
- `OFF`
- `ON_REPLICAS` ||
|| announceHostnames | **boolean** ||
|| authSentinel | **boolean** ||
|| diskEncryptionKeyId | **string** ||
|#

## Monitoring {#yandex.cloud.mdb.redis.v1.Monitoring}

#|
||Field | Description ||
|| name | **string** ||
|| description | **string** ||
|| link | **string** ||
|#

## ClusterConfig {#yandex.cloud.mdb.redis.v1.ClusterConfig}

#|
||Field | Description ||
|| version | **string** ||
|| redisConfig_5_0 | **[RedisConfigSet5_0](#yandex.cloud.mdb.redis.v1.config.RedisConfigSet5_0)**

Includes only one of the fields `redisConfig_5_0`, `redisConfig_6_0`, `redisConfig_6_2`, `redisConfig_7_0`. ||
|| redisConfig_6_0 | **[RedisConfigSet6_0](#yandex.cloud.mdb.redis.v1.config.RedisConfigSet6_0)**

Includes only one of the fields `redisConfig_5_0`, `redisConfig_6_0`, `redisConfig_6_2`, `redisConfig_7_0`. ||
|| redisConfig_6_2 | **[RedisConfigSet6_2](#yandex.cloud.mdb.redis.v1.config.RedisConfigSet6_2)**

Includes only one of the fields `redisConfig_5_0`, `redisConfig_6_0`, `redisConfig_6_2`, `redisConfig_7_0`. ||
|| redisConfig_7_0 | **[RedisConfigSet7_0](#yandex.cloud.mdb.redis.v1.config.RedisConfigSet7_0)**

Includes only one of the fields `redisConfig_5_0`, `redisConfig_6_0`, `redisConfig_6_2`, `redisConfig_7_0`. ||
|| resources | **[Resources](#yandex.cloud.mdb.redis.v1.Resources)** ||
|| backupWindowStart | **[TimeOfDay](#google.type.TimeOfDay)** ||
|| access | **[Access](#yandex.cloud.mdb.redis.v1.Access)** ||
|| redis | **[RedisConfigSet](#yandex.cloud.mdb.redis.v1.config.RedisConfigSet)** ||
|| diskSizeAutoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.redis.v1.DiskSizeAutoscaling)** ||
|| backupRetainPeriodDays | **string** (int64) ||
|| modules | **[ValkeyModules](#yandex.cloud.mdb.redis.v1.ValkeyModules)** ||
|| fullVersion | **string** ||
|#

## RedisConfigSet5_0 {#yandex.cloud.mdb.redis.v1.config.RedisConfigSet5_0}

#|
||Field | Description ||
|| effectiveConfig | **[RedisConfig5_0](#yandex.cloud.mdb.redis.v1.config.RedisConfig5_0)** ||
|| userConfig | **[RedisConfig5_0](#yandex.cloud.mdb.redis.v1.config.RedisConfig5_0)** ||
|| defaultConfig | **[RedisConfig5_0](#yandex.cloud.mdb.redis.v1.config.RedisConfig5_0)** ||
|#

## RedisConfig5_0 {#yandex.cloud.mdb.redis.v1.config.RedisConfig5_0}

#|
||Field | Description ||
|| maxmemoryPolicy | **enum** (MaxmemoryPolicy)

- `VOLATILE_LRU`
- `ALLKEYS_LRU`
- `VOLATILE_LFU`
- `ALLKEYS_LFU`
- `VOLATILE_RANDOM`
- `ALLKEYS_RANDOM`
- `VOLATILE_TTL`
- `NOEVICTION` ||
|| timeout | **string** (int64) ||
|| password | **string**

Value must match the regular expression ` [a-zA-Z0-9@=+?*.,!&#$^<>_-]{8,128} `. ||
|| databases | **string** (int64)

Value must be greater than 0. ||
|| slowlogLogSlowerThan | **string** (int64)

The minimum value is 0. ||
|| slowlogMaxLen | **string** (int64)

The minimum value is 0. ||
|| notifyKeyspaceEvents | **string**

Value must match the regular expression ` [KEg$lshzxeAtm]{0,12} `. ||
|| clientOutputBufferLimitPubsub | **[ClientOutputBufferLimit](#yandex.cloud.mdb.redis.v1.config.RedisConfig5_0.ClientOutputBufferLimit)** ||
|| clientOutputBufferLimitNormal | **[ClientOutputBufferLimit](#yandex.cloud.mdb.redis.v1.config.RedisConfig5_0.ClientOutputBufferLimit)** ||
|#

## ClientOutputBufferLimit {#yandex.cloud.mdb.redis.v1.config.RedisConfig5_0.ClientOutputBufferLimit}

#|
||Field | Description ||
|| hardLimit | **string** (int64)

The minimum value is 0. ||
|| softLimit | **string** (int64)

The minimum value is 0. ||
|| softSeconds | **string** (int64)

The minimum value is 0. ||
|#

## RedisConfigSet6_0 {#yandex.cloud.mdb.redis.v1.config.RedisConfigSet6_0}

#|
||Field | Description ||
|| effectiveConfig | **[RedisConfig6_0](#yandex.cloud.mdb.redis.v1.config.RedisConfig6_0)** ||
|| userConfig | **[RedisConfig6_0](#yandex.cloud.mdb.redis.v1.config.RedisConfig6_0)** ||
|| defaultConfig | **[RedisConfig6_0](#yandex.cloud.mdb.redis.v1.config.RedisConfig6_0)** ||
|#

## RedisConfig6_0 {#yandex.cloud.mdb.redis.v1.config.RedisConfig6_0}

#|
||Field | Description ||
|| maxmemoryPolicy | **enum** (MaxmemoryPolicy)

- `VOLATILE_LRU`
- `ALLKEYS_LRU`
- `VOLATILE_LFU`
- `ALLKEYS_LFU`
- `VOLATILE_RANDOM`
- `ALLKEYS_RANDOM`
- `VOLATILE_TTL`
- `NOEVICTION` ||
|| timeout | **string** (int64) ||
|| password | **string**

Value must match the regular expression ` [a-zA-Z0-9@=+?*.,!&#$^<>_-]{8,128} `. ||
|| databases | **string** (int64)

Value must be greater than 0. ||
|| slowlogLogSlowerThan | **string** (int64)

The minimum value is 0. ||
|| slowlogMaxLen | **string** (int64)

The minimum value is 0. ||
|| notifyKeyspaceEvents | **string**

Value must match the regular expression ` [KEg$lshzxeAtm]{0,13} `. ||
|| clientOutputBufferLimitPubsub | **[ClientOutputBufferLimit](#yandex.cloud.mdb.redis.v1.config.RedisConfig6_0.ClientOutputBufferLimit)** ||
|| clientOutputBufferLimitNormal | **[ClientOutputBufferLimit](#yandex.cloud.mdb.redis.v1.config.RedisConfig6_0.ClientOutputBufferLimit)** ||
|#

## ClientOutputBufferLimit {#yandex.cloud.mdb.redis.v1.config.RedisConfig6_0.ClientOutputBufferLimit}

#|
||Field | Description ||
|| hardLimit | **string** (int64)

The minimum value is 0. ||
|| softLimit | **string** (int64)

The minimum value is 0. ||
|| softSeconds | **string** (int64)

The minimum value is 0. ||
|#

## RedisConfigSet6_2 {#yandex.cloud.mdb.redis.v1.config.RedisConfigSet6_2}

#|
||Field | Description ||
|| effectiveConfig | **[RedisConfig6_2](#yandex.cloud.mdb.redis.v1.config.RedisConfig6_2)** ||
|| userConfig | **[RedisConfig6_2](#yandex.cloud.mdb.redis.v1.config.RedisConfig6_2)** ||
|| defaultConfig | **[RedisConfig6_2](#yandex.cloud.mdb.redis.v1.config.RedisConfig6_2)** ||
|#

## RedisConfig6_2 {#yandex.cloud.mdb.redis.v1.config.RedisConfig6_2}

#|
||Field | Description ||
|| maxmemoryPolicy | **enum** (MaxmemoryPolicy)

- `VOLATILE_LRU`
- `ALLKEYS_LRU`
- `VOLATILE_LFU`
- `ALLKEYS_LFU`
- `VOLATILE_RANDOM`
- `ALLKEYS_RANDOM`
- `VOLATILE_TTL`
- `NOEVICTION` ||
|| timeout | **string** (int64) ||
|| password | **string**

Value must match the regular expression ` [a-zA-Z0-9@=+?*.,!&#$^<>_-]{8,128} `. ||
|| databases | **string** (int64)

Value must be greater than 0. ||
|| slowlogLogSlowerThan | **string** (int64)

The minimum value is 0. ||
|| slowlogMaxLen | **string** (int64)

The minimum value is 0. ||
|| notifyKeyspaceEvents | **string**

Value must match the regular expression ` [KEg$lshzxeAtm]{0,13} `. ||
|| clientOutputBufferLimitPubsub | **[ClientOutputBufferLimit](#yandex.cloud.mdb.redis.v1.config.RedisConfig6_2.ClientOutputBufferLimit)** ||
|| clientOutputBufferLimitNormal | **[ClientOutputBufferLimit](#yandex.cloud.mdb.redis.v1.config.RedisConfig6_2.ClientOutputBufferLimit)** ||
|| maxmemoryPercent | **string** (int64)

Acceptable values are 1 to 75, inclusive. ||
|#

## ClientOutputBufferLimit {#yandex.cloud.mdb.redis.v1.config.RedisConfig6_2.ClientOutputBufferLimit}

#|
||Field | Description ||
|| hardLimit | **string** (int64)

The minimum value is 0. ||
|| softLimit | **string** (int64)

The minimum value is 0. ||
|| softSeconds | **string** (int64)

The minimum value is 0. ||
|#

## RedisConfigSet7_0 {#yandex.cloud.mdb.redis.v1.config.RedisConfigSet7_0}

#|
||Field | Description ||
|| effectiveConfig | **[RedisConfig7_0](#yandex.cloud.mdb.redis.v1.config.RedisConfig7_0)** ||
|| userConfig | **[RedisConfig7_0](#yandex.cloud.mdb.redis.v1.config.RedisConfig7_0)** ||
|| defaultConfig | **[RedisConfig7_0](#yandex.cloud.mdb.redis.v1.config.RedisConfig7_0)** ||
|#

## RedisConfig7_0 {#yandex.cloud.mdb.redis.v1.config.RedisConfig7_0}

#|
||Field | Description ||
|| maxmemoryPolicy | **enum** (MaxmemoryPolicy)

- `VOLATILE_LRU`
- `ALLKEYS_LRU`
- `VOLATILE_LFU`
- `ALLKEYS_LFU`
- `VOLATILE_RANDOM`
- `ALLKEYS_RANDOM`
- `VOLATILE_TTL`
- `NOEVICTION` ||
|| timeout | **string** (int64) ||
|| password | **string**

Value must match the regular expression ` [a-zA-Z0-9@=+?*.,!&#$^<>_-]{8,128} `. ||
|| databases | **string** (int64)

Value must be greater than 0. ||
|| slowlogLogSlowerThan | **string** (int64)

The minimum value is 0. ||
|| slowlogMaxLen | **string** (int64)

The minimum value is 0. ||
|| notifyKeyspaceEvents | **string**

Value must match the regular expression ` [KEg$lshzxeAtm]{0,13} `. ||
|| clientOutputBufferLimitPubsub | **[ClientOutputBufferLimit](#yandex.cloud.mdb.redis.v1.config.RedisConfig7_0.ClientOutputBufferLimit)** ||
|| clientOutputBufferLimitNormal | **[ClientOutputBufferLimit](#yandex.cloud.mdb.redis.v1.config.RedisConfig7_0.ClientOutputBufferLimit)** ||
|| maxmemoryPercent | **string** (int64)

Acceptable values are 1 to 75, inclusive. ||
|#

## ClientOutputBufferLimit {#yandex.cloud.mdb.redis.v1.config.RedisConfig7_0.ClientOutputBufferLimit}

#|
||Field | Description ||
|| hardLimit | **string** (int64)

The minimum value is 0. ||
|| softLimit | **string** (int64)

The minimum value is 0. ||
|| softSeconds | **string** (int64)

The minimum value is 0. ||
|#

## Resources {#yandex.cloud.mdb.redis.v1.Resources}

#|
||Field | Description ||
|| resourcePresetId | **string** ||
|| diskSize | **string** (int64) ||
|| diskTypeId | **string** ||
|#

## TimeOfDay {#google.type.TimeOfDay}

#|
||Field | Description ||
|| hours | **integer** (int32) ||
|| minutes | **integer** (int32) ||
|| seconds | **integer** (int32) ||
|| nanos | **integer** (int32) ||
|#

## Access {#yandex.cloud.mdb.redis.v1.Access}

#|
||Field | Description ||
|| dataLens | **boolean** ||
|| webSql | **boolean** ||
|#

## RedisConfigSet {#yandex.cloud.mdb.redis.v1.config.RedisConfigSet}

#|
||Field | Description ||
|| effectiveConfig | **[RedisConfig](#yandex.cloud.mdb.redis.v1.config.RedisConfig)** ||
|| userConfig | **[RedisConfig](#yandex.cloud.mdb.redis.v1.config.RedisConfig)** ||
|| defaultConfig | **[RedisConfig](#yandex.cloud.mdb.redis.v1.config.RedisConfig)** ||
|#

## RedisConfig {#yandex.cloud.mdb.redis.v1.config.RedisConfig}

#|
||Field | Description ||
|| maxmemoryPolicy | **enum** (MaxmemoryPolicy)

- `VOLATILE_LRU`
- `ALLKEYS_LRU`
- `VOLATILE_LFU`
- `ALLKEYS_LFU`
- `VOLATILE_RANDOM`
- `ALLKEYS_RANDOM`
- `VOLATILE_TTL`
- `NOEVICTION` ||
|| timeout | **string** (int64) ||
|| password | **string**

Value must match the regular expression ` [a-zA-Z0-9@=+?*.,!&#$^<>_-]{8,128} `. ||
|| databases | **string** (int64)

Value must be greater than 0. ||
|| slowlogLogSlowerThan | **string** (int64)

The minimum value is 0. ||
|| slowlogMaxLen | **string** (int64)

The minimum value is 0. ||
|| notifyKeyspaceEvents | **string**

Value must match the regular expression ` [KEg$lshzxeAtm]{0,13} `. ||
|| clientOutputBufferLimitPubsub | **[ClientOutputBufferLimit](#yandex.cloud.mdb.redis.v1.config.RedisConfig.ClientOutputBufferLimit)** ||
|| clientOutputBufferLimitNormal | **[ClientOutputBufferLimit](#yandex.cloud.mdb.redis.v1.config.RedisConfig.ClientOutputBufferLimit)** ||
|| maxmemoryPercent | **string** (int64)

Acceptable values are 1 to 75, inclusive. ||
|| luaTimeLimit | **string** (int64)

The minimum value is 0. ||
|| replBacklogSizePercent | **string** (int64)

Value must be greater than 0. ||
|| clusterRequireFullCoverage | **boolean** ||
|| clusterAllowReadsWhenDown | **boolean** ||
|| clusterAllowPubsubshardWhenDown | **boolean** ||
|| lfuDecayTime | **string** (int64)

The minimum value is 0. ||
|| lfuLogFactor | **string** (int64)

The minimum value is 0. ||
|| turnBeforeSwitchover | **boolean** ||
|| allowDataLoss | **boolean** ||
|| useLuajit | **boolean** ||
|| ioThreadsAllowed | **boolean** ||
|| zsetMaxListpackEntries | **string** (int64)

Acceptable values are 32 to 2048, inclusive. ||
|| aofMaxSizePercent | **string** (int64)

Acceptable values are 1 to 99, inclusive. ||
|| activedefrag | **boolean** ||
|#

## ClientOutputBufferLimit {#yandex.cloud.mdb.redis.v1.config.RedisConfig.ClientOutputBufferLimit}

#|
||Field | Description ||
|| hardLimit | **string** (int64)

The minimum value is 0. ||
|| softLimit | **string** (int64)

The minimum value is 0. ||
|| softSeconds | **string** (int64)

The minimum value is 0. ||
|#

## DiskSizeAutoscaling {#yandex.cloud.mdb.redis.v1.DiskSizeAutoscaling}

#|
||Field | Description ||
|| plannedUsageThreshold | **string** (int64)

Acceptable values are 0 to 100, inclusive. ||
|| emergencyUsageThreshold | **string** (int64)

Acceptable values are 0 to 100, inclusive. ||
|| diskSizeLimit | **string** (int64) ||
|#

## ValkeyModules {#yandex.cloud.mdb.redis.v1.ValkeyModules}

#|
||Field | Description ||
|| valkeySearch | **[ValkeySearch](#yandex.cloud.mdb.redis.v1.ValkeySearch)** ||
|| valkeyJson | **[ValkeyJson](#yandex.cloud.mdb.redis.v1.ValkeyJson)** ||
|| valkeyBloom | **[ValkeyBloom](#yandex.cloud.mdb.redis.v1.ValkeyBloom)** ||
|#

## ValkeySearch {#yandex.cloud.mdb.redis.v1.ValkeySearch}

#|
||Field | Description ||
|| enabled | **boolean** ||
|| readerThreads | **string** (int64)

The minimum value is 0. ||
|| writerThreads | **string** (int64)

The minimum value is 0. ||
|#

## ValkeyJson {#yandex.cloud.mdb.redis.v1.ValkeyJson}

#|
||Field | Description ||
|| enabled | **boolean** ||
|#

## ValkeyBloom {#yandex.cloud.mdb.redis.v1.ValkeyBloom}

#|
||Field | Description ||
|| enabled | **boolean** ||
|#

## MaintenanceWindow {#yandex.cloud.mdb.redis.v1.MaintenanceWindow}

#|
||Field | Description ||
|| anytime | **object**

Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`. ||
|| weeklyMaintenanceWindow | **[WeeklyMaintenanceWindow](#yandex.cloud.mdb.redis.v1.WeeklyMaintenanceWindow)**

Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`. ||
|#

## WeeklyMaintenanceWindow {#yandex.cloud.mdb.redis.v1.WeeklyMaintenanceWindow}

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

## MaintenanceOperation {#yandex.cloud.mdb.redis.v1.MaintenanceOperation}

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