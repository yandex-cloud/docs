---
editable: false
apiPlayground:
  - url: https://{{ api-host-mdb }}/managed-greenplum/v1/clusters/{clusterId}:move
    method: post
    path:
      type: object
      properties:
        clusterId:
          description: |-
            **string**
            Required field. ID of the Greenplum® cluster to move.
          type: string
      required:
        - clusterId
      additionalProperties: false
    query: null
    body:
      type: object
      properties:
        destinationFolderId:
          description: |-
            **string**
            Required field. ID of the destination folder.
          type: string
      required:
        - destinationFolderId
      additionalProperties: false
    definitions: null
sourcePath: en/_api-ref/mdb/greenplum/v1/api-ref/Cluster/move.md
---

# Managed Service for Greenplum® API, REST: Cluster.Move

Moves the specified Greenplum® cluster to the specified folder.

## HTTP request

```
POST https://{{ api-host-mdb }}/managed-greenplum/v1/clusters/{clusterId}:move
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the Greenplum® cluster to move. ||
|#

## Body parameters {#yandex.cloud.mdb.greenplum.v1.MoveClusterRequest}

```json
{
  "destinationFolderId": "string"
}
```

#|
||Field | Description ||
|| destinationFolderId | **string**

Required field. ID of the destination folder. ||
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
    "sourceFolderId": "string",
    "destinationFolderId": "string"
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
    "folderId": "string",
    "createdAt": "string",
    "name": "string",
    "config": {
      "version": "string",
      "backupWindowStart": {
        "hours": "integer",
        "minutes": "integer",
        "seconds": "integer",
        "nanos": "integer"
      },
      "backupRetainPeriodDays": "string",
      "access": {
        "dataLens": "boolean",
        "webSql": "boolean",
        "dataTransfer": "boolean",
        "yandexQuery": "boolean"
      },
      "zoneId": "string",
      "subnetId": "string",
      "assignPublicIp": "boolean"
    },
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
    "masterConfig": {
      "resources": {
        "resourcePresetId": "string",
        "diskSize": "string",
        "diskTypeId": "string"
      }
    },
    "segmentConfig": {
      "resources": {
        "resourcePresetId": "string",
        "diskSize": "string",
        "diskTypeId": "string"
      }
    },
    "masterHostCount": "string",
    "segmentHostCount": "string",
    "segmentInHost": "string",
    "networkId": "string",
    "health": "string",
    "status": "string",
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
    "userName": "string",
    "deletionProtection": "boolean",
    "hostGroupIds": [
      "string"
    ],
    "clusterConfig": {
      // Includes only one of the fields `greenplumConfigSet_6_17`, `greenplumConfigSet_6_19`, `greenplumConfigSet_6_21`, `greenplumConfigSet_6_22`, `greenplumConfigSet_6`
      "greenplumConfigSet_6_17": {
        "effectiveConfig": {
          "maxConnections": "string",
          "maxSlotWalKeepSize": "string",
          "gpWorkfileLimitPerSegment": "string",
          "gpWorkfileLimitPerQuery": "string",
          "gpWorkfileLimitFilesPerQuery": "string",
          "maxPreparedTransactions": "string",
          "gpWorkfileCompression": "boolean"
        },
        "userConfig": {
          "maxConnections": "string",
          "maxSlotWalKeepSize": "string",
          "gpWorkfileLimitPerSegment": "string",
          "gpWorkfileLimitPerQuery": "string",
          "gpWorkfileLimitFilesPerQuery": "string",
          "maxPreparedTransactions": "string",
          "gpWorkfileCompression": "boolean"
        },
        "defaultConfig": {
          "maxConnections": "string",
          "maxSlotWalKeepSize": "string",
          "gpWorkfileLimitPerSegment": "string",
          "gpWorkfileLimitPerQuery": "string",
          "gpWorkfileLimitFilesPerQuery": "string",
          "maxPreparedTransactions": "string",
          "gpWorkfileCompression": "boolean"
        }
      },
      "greenplumConfigSet_6_19": {
        "effectiveConfig": {
          "maxConnections": "string",
          "maxSlotWalKeepSize": "string",
          "gpWorkfileLimitPerSegment": "string",
          "gpWorkfileLimitPerQuery": "string",
          "gpWorkfileLimitFilesPerQuery": "string",
          "maxPreparedTransactions": "string",
          "gpWorkfileCompression": "boolean",
          "maxStatementMem": "string",
          "logStatement": "string"
        },
        "userConfig": {
          "maxConnections": "string",
          "maxSlotWalKeepSize": "string",
          "gpWorkfileLimitPerSegment": "string",
          "gpWorkfileLimitPerQuery": "string",
          "gpWorkfileLimitFilesPerQuery": "string",
          "maxPreparedTransactions": "string",
          "gpWorkfileCompression": "boolean",
          "maxStatementMem": "string",
          "logStatement": "string"
        },
        "defaultConfig": {
          "maxConnections": "string",
          "maxSlotWalKeepSize": "string",
          "gpWorkfileLimitPerSegment": "string",
          "gpWorkfileLimitPerQuery": "string",
          "gpWorkfileLimitFilesPerQuery": "string",
          "maxPreparedTransactions": "string",
          "gpWorkfileCompression": "boolean",
          "maxStatementMem": "string",
          "logStatement": "string"
        }
      },
      "greenplumConfigSet_6_21": {
        "effectiveConfig": {
          "maxConnections": "string",
          "maxSlotWalKeepSize": "string",
          "gpWorkfileLimitPerSegment": "string",
          "gpWorkfileLimitPerQuery": "string",
          "gpWorkfileLimitFilesPerQuery": "string",
          "maxPreparedTransactions": "string",
          "gpWorkfileCompression": "boolean",
          "maxStatementMem": "string",
          "logStatement": "string",
          "gpAddColumnInheritsTableSetting": "boolean"
        },
        "userConfig": {
          "maxConnections": "string",
          "maxSlotWalKeepSize": "string",
          "gpWorkfileLimitPerSegment": "string",
          "gpWorkfileLimitPerQuery": "string",
          "gpWorkfileLimitFilesPerQuery": "string",
          "maxPreparedTransactions": "string",
          "gpWorkfileCompression": "boolean",
          "maxStatementMem": "string",
          "logStatement": "string",
          "gpAddColumnInheritsTableSetting": "boolean"
        },
        "defaultConfig": {
          "maxConnections": "string",
          "maxSlotWalKeepSize": "string",
          "gpWorkfileLimitPerSegment": "string",
          "gpWorkfileLimitPerQuery": "string",
          "gpWorkfileLimitFilesPerQuery": "string",
          "maxPreparedTransactions": "string",
          "gpWorkfileCompression": "boolean",
          "maxStatementMem": "string",
          "logStatement": "string",
          "gpAddColumnInheritsTableSetting": "boolean"
        }
      },
      "greenplumConfigSet_6_22": {
        "effectiveConfig": {
          "maxConnections": "string",
          "maxSlotWalKeepSize": "string",
          "gpWorkfileLimitPerSegment": "string",
          "gpWorkfileLimitPerQuery": "string",
          "gpWorkfileLimitFilesPerQuery": "string",
          "maxPreparedTransactions": "string",
          "gpWorkfileCompression": "boolean",
          "maxStatementMem": "string",
          "logStatement": "string",
          "gpAddColumnInheritsTableSetting": "boolean"
        },
        "userConfig": {
          "maxConnections": "string",
          "maxSlotWalKeepSize": "string",
          "gpWorkfileLimitPerSegment": "string",
          "gpWorkfileLimitPerQuery": "string",
          "gpWorkfileLimitFilesPerQuery": "string",
          "maxPreparedTransactions": "string",
          "gpWorkfileCompression": "boolean",
          "maxStatementMem": "string",
          "logStatement": "string",
          "gpAddColumnInheritsTableSetting": "boolean"
        },
        "defaultConfig": {
          "maxConnections": "string",
          "maxSlotWalKeepSize": "string",
          "gpWorkfileLimitPerSegment": "string",
          "gpWorkfileLimitPerQuery": "string",
          "gpWorkfileLimitFilesPerQuery": "string",
          "maxPreparedTransactions": "string",
          "gpWorkfileCompression": "boolean",
          "maxStatementMem": "string",
          "logStatement": "string",
          "gpAddColumnInheritsTableSetting": "boolean"
        }
      },
      "greenplumConfigSet_6": {
        "effectiveConfig": {
          "maxConnections": "string",
          "maxSlotWalKeepSize": "string",
          "gpWorkfileLimitPerSegment": "string",
          "gpWorkfileLimitPerQuery": "string",
          "gpWorkfileLimitFilesPerQuery": "string",
          "maxPreparedTransactions": "string",
          "gpWorkfileCompression": "boolean",
          "maxStatementMem": "string",
          "logStatement": "string",
          "gpAddColumnInheritsTableSetting": "boolean",
          "gpEnableGlobalDeadlockDetector": "boolean",
          "gpGlobalDeadlockDetectorPeriod": "string"
        },
        "userConfig": {
          "maxConnections": "string",
          "maxSlotWalKeepSize": "string",
          "gpWorkfileLimitPerSegment": "string",
          "gpWorkfileLimitPerQuery": "string",
          "gpWorkfileLimitFilesPerQuery": "string",
          "maxPreparedTransactions": "string",
          "gpWorkfileCompression": "boolean",
          "maxStatementMem": "string",
          "logStatement": "string",
          "gpAddColumnInheritsTableSetting": "boolean",
          "gpEnableGlobalDeadlockDetector": "boolean",
          "gpGlobalDeadlockDetectorPeriod": "string"
        },
        "defaultConfig": {
          "maxConnections": "string",
          "maxSlotWalKeepSize": "string",
          "gpWorkfileLimitPerSegment": "string",
          "gpWorkfileLimitPerQuery": "string",
          "gpWorkfileLimitFilesPerQuery": "string",
          "maxPreparedTransactions": "string",
          "gpWorkfileCompression": "boolean",
          "maxStatementMem": "string",
          "logStatement": "string",
          "gpAddColumnInheritsTableSetting": "boolean",
          "gpEnableGlobalDeadlockDetector": "boolean",
          "gpGlobalDeadlockDetectorPeriod": "string"
        }
      },
      // end of the list of possible fields
      "pool": {
        "effectiveConfig": {
          "mode": "string",
          "size": "string",
          "clientIdleTimeout": "string"
        },
        "userConfig": {
          "mode": "string",
          "size": "string",
          "clientIdleTimeout": "string"
        },
        "defaultConfig": {
          "mode": "string",
          "size": "string",
          "clientIdleTimeout": "string"
        }
      },
      "backgroundActivities": {
        "tableSizes": {
          "starts": [
            {
              "hours": "string",
              "minutes": "string"
            }
          ]
        },
        "analyzeAndVacuum": {
          "start": {
            "hours": "string",
            "minutes": "string"
          },
          "analyzeTimeout": "string",
          "vacuumTimeout": "string"
        },
        "queryKillerScripts": {
          "idle": {
            "enable": "boolean",
            "maxAge": "string",
            "ignoreUsers": [
              "string"
            ]
          },
          "idleInTransaction": {
            "enable": "boolean",
            "maxAge": "string",
            "ignoreUsers": [
              "string"
            ]
          },
          "longRunning": {
            "enable": "boolean",
            "maxAge": "string",
            "ignoreUsers": [
              "string"
            ]
          }
        }
      },
      "pxfConfig": {
        "effectiveConfig": {
          "connectionTimeout": "string",
          "uploadTimeout": "string",
          "maxThreads": "string",
          "poolAllowCoreThreadTimeout": "boolean",
          "poolCoreSize": "string",
          "poolQueueCapacity": "string",
          "poolMaxSize": "string",
          "xmx": "string",
          "xms": "string"
        },
        "userConfig": {
          "connectionTimeout": "string",
          "uploadTimeout": "string",
          "maxThreads": "string",
          "poolAllowCoreThreadTimeout": "boolean",
          "poolCoreSize": "string",
          "poolQueueCapacity": "string",
          "poolMaxSize": "string",
          "xmx": "string",
          "xms": "string"
        },
        "defaultConfig": {
          "connectionTimeout": "string",
          "uploadTimeout": "string",
          "maxThreads": "string",
          "poolAllowCoreThreadTimeout": "boolean",
          "poolCoreSize": "string",
          "poolQueueCapacity": "string",
          "poolMaxSize": "string",
          "xmx": "string",
          "xms": "string"
        }
      }
    },
    "cloudStorage": {
      "enable": "boolean"
    },
    "masterHostGroupIds": [
      "string"
    ],
    "segmentHostGroupIds": [
      "string"
    ],
    "serviceAccountId": "string",
    "logging": {
      "enabled": "boolean",
      // Includes only one of the fields `folderId`, `logGroupId`
      "folderId": "string",
      "logGroupId": "string",
      // end of the list of possible fields
      "commandCenterEnabled": "boolean",
      "greenplumEnabled": "boolean",
      "poolerEnabled": "boolean"
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
|| metadata | **[MoveClusterMetadata](#yandex.cloud.mdb.greenplum.v1.MoveClusterMetadata)**

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
|| response | **[Cluster](#yandex.cloud.mdb.greenplum.v1.Cluster)**

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

## MoveClusterMetadata {#yandex.cloud.mdb.greenplum.v1.MoveClusterMetadata}

#|
||Field | Description ||
|| clusterId | **string**

ID of the Greenplum® cluster being moved. ||
|| sourceFolderId | **string**

ID of the source folder. ||
|| destinationFolderId | **string**

ID of the destination folder. ||
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

## Cluster {#yandex.cloud.mdb.greenplum.v1.Cluster}

A Greenplum® cluster resource.

#|
||Field | Description ||
|| id | **string**

ID of the Greenplum® cluster.
This ID is assigned by the platform at the moment of cluster creation. ||
|| folderId | **string**

ID of the folder that the Greenplum® cluster belongs to. ||
|| createdAt | **string** (date-time)

Time when the cluster was created.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| name | **string**

Required field. Name of the Greenplum® cluster.
The name is unique within the folder. ||
|| config | **[GreenplumConfig](#yandex.cloud.mdb.greenplum.v1.GreenplumConfig)**

Greenplum® cluster configuration. ||
|| description | **string**

Description of the Greenplum® cluster. ||
|| labels | **object** (map<**string**, **string**>)

Custom labels for the Greenplum® cluster as `key:value` pairs. Maximum 64 labels per resource. ||
|| environment | **enum** (Environment)

Deployment environment of the Greenplum® cluster.

- `ENVIRONMENT_UNSPECIFIED`
- `PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.
- `PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility. ||
|| monitoring[] | **[Monitoring](#yandex.cloud.mdb.greenplum.v1.Monitoring)**

Description of monitoring systems relevant to the Greenplum® cluster. ||
|| masterConfig | **[MasterSubclusterConfig](#yandex.cloud.mdb.greenplum.v1.MasterSubclusterConfig)**

Configuration of the Greenplum® master subcluster. ||
|| segmentConfig | **[SegmentSubclusterConfig](#yandex.cloud.mdb.greenplum.v1.SegmentSubclusterConfig)**

Configuration of the Greenplum® segment subcluster. ||
|| masterHostCount | **string** (int64)

Number of hosts in the master subcluster. ||
|| segmentHostCount | **string** (int64)

Number of hosts in the segment subcluster. ||
|| segmentInHost | **string** (int64)

Number of segments per host. ||
|| networkId | **string**

ID of the cloud network that the cluster belongs to. ||
|| health | **enum** (Health)

Aggregated cluster health.

- `HEALTH_UNKNOWN`: Health of the cluster is unknown ([Host.health](/docs/managed-greenplum/api-ref/Cluster/listMasterHosts#yandex.cloud.mdb.greenplum.v1.Host) for every host in the cluster is UNKNOWN).
- `ALIVE`: Cluster is working normally ([Host.health](/docs/managed-greenplum/api-ref/Cluster/listMasterHosts#yandex.cloud.mdb.greenplum.v1.Host) for every host in the cluster is ALIVE).
- `DEAD`: Cluster is inoperable ([Host.health](/docs/managed-greenplum/api-ref/Cluster/listMasterHosts#yandex.cloud.mdb.greenplum.v1.Host) for every host in the cluster is DEAD).
- `DEGRADED`: Cluster is working below capacity ([Host.health](/docs/managed-greenplum/api-ref/Cluster/listMasterHosts#yandex.cloud.mdb.greenplum.v1.Host) for at least one host in the cluster is not ALIVE).
- `UNBALANCED`: Cluster is working below capacity ([Host.health](/docs/managed-greenplum/api-ref/Cluster/listMasterHosts#yandex.cloud.mdb.greenplum.v1.Host) for at least one host in the cluster is UNBALANCED). ||
|| status | **enum** (Status)

Current state of the cluster.

- `STATUS_UNKNOWN`: Cluster state is unknown.
- `CREATING`: Cluster is being created.
- `RUNNING`: Cluster is running normally.
- `ERROR`: Cluster has encountered a problem and cannot operate.
- `UPDATING`: Cluster is being updated.
- `STOPPING`: Cluster is stopping.
- `STOPPED`: Cluster has stopped.
- `STARTING`: Cluster is starting. ||
|| maintenanceWindow | **[MaintenanceWindow](#yandex.cloud.mdb.greenplum.v1.MaintenanceWindow)**

A Greenplum® cluster maintenance window. Should be defined by either one of the two options. ||
|| plannedOperation | **[MaintenanceOperation](#yandex.cloud.mdb.greenplum.v1.MaintenanceOperation)**

Maintenance operation planned at nearest `maintenanceWindow`. ||
|| securityGroupIds[] | **string**

User security groups. ||
|| userName | **string**

Owner user name. ||
|| deletionProtection | **boolean**

Determines whether the cluster is protected from being deleted. ||
|| hostGroupIds[] | **string**

Host groups hosting VMs of the cluster. ||
|| clusterConfig | **[ClusterConfigSet](#yandex.cloud.mdb.greenplum.v1.ClusterConfigSet)**

Greenplum® and Odyssey® configuration. ||
|| cloudStorage | **[CloudStorage](#yandex.cloud.mdb.greenplum.v1.CloudStorage)**

Cloud storage settings ||
|| masterHostGroupIds[] | **string**

Host groups hosting VMs of the master subcluster. ||
|| segmentHostGroupIds[] | **string**

Host groups hosting VMs of the segment subcluster. ||
|| serviceAccountId | **string**

Service account that will be used to access a Yandex Cloud resources ||
|| logging | **[LoggingConfig](#yandex.cloud.mdb.greenplum.v1.LoggingConfig)**

Cloud logging configuration ||
|#

## GreenplumConfig {#yandex.cloud.mdb.greenplum.v1.GreenplumConfig}

#|
||Field | Description ||
|| version | **string**

Version of the Greenplum® server software. ||
|| backupWindowStart | **[TimeOfDay](#google.type.TimeOfDay)**

Time to start the daily backup, in the UTC timezone. ||
|| backupRetainPeriodDays | **string** (int64)

Retention policy of automated backups. ||
|| access | **[Access](#yandex.cloud.mdb.greenplum.v1.Access)**

Access policy for external services. ||
|| zoneId | **string**

ID of the availability zone the cluster belongs to.
To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/api-ref/Zone/list#List) request. ||
|| subnetId | **string**

ID of the subnet the cluster belongs to. This subnet should be a part of the cloud network the cluster belongs to (see [Cluster.networkId](#yandex.cloud.mdb.greenplum.v1.Cluster)). ||
|| assignPublicIp | **boolean**

Determines whether the cluster has a public IP address.

After the cluster has been created, this setting cannot be changed. ||
|#

## TimeOfDay {#google.type.TimeOfDay}

Represents a time of day. The date and time zone are either not significant
or are specified elsewhere. An API may choose to allow leap seconds. Related
types are [google.type.Date](https://github.com/googleapis/googleapis/blob/master/google/type/date.proto) and [google.protobuf.Timestamp](https://github.com/protocolbuffers/protobuf/blob/master/src/google/protobuf/timestamp.proto).

#|
||Field | Description ||
|| hours | **integer** (int32)

Hours of day in 24 hour format. Should be from 0 to 23. An API may choose
to allow the value "24:00:00" for scenarios like business closing time. ||
|| minutes | **integer** (int32)

Minutes of hour of day. Must be from 0 to 59. ||
|| seconds | **integer** (int32)

Seconds of minutes of the time. Must normally be from 0 to 59. An API may
allow the value 60 if it allows leap-seconds. ||
|| nanos | **integer** (int32)

Fractions of seconds in nanoseconds. Must be from 0 to 999,999,999. ||
|#

## Access {#yandex.cloud.mdb.greenplum.v1.Access}

#|
||Field | Description ||
|| dataLens | **boolean**

Allows data export from the cluster to DataLens. ||
|| webSql | **boolean**

Allows SQL queries to the cluster databases from the management console. ||
|| dataTransfer | **boolean**

Allows access for DataTransfer. ||
|| yandexQuery | **boolean**

Allow access for YandexQuery. ||
|#

## Monitoring {#yandex.cloud.mdb.greenplum.v1.Monitoring}

Monitoring system metadata.

#|
||Field | Description ||
|| name | **string**

Name of the monitoring system. ||
|| description | **string**

Description of the monitoring system. ||
|| link | **string**

Link to the monitoring system charts for the Greenplum® cluster. ||
|#

## MasterSubclusterConfig {#yandex.cloud.mdb.greenplum.v1.MasterSubclusterConfig}

#|
||Field | Description ||
|| resources | **[Resources](#yandex.cloud.mdb.greenplum.v1.Resources)**

Computational resources allocated to Greenplum® master subcluster hosts. ||
|#

## Resources {#yandex.cloud.mdb.greenplum.v1.Resources}

#|
||Field | Description ||
|| resourcePresetId | **string**

ID of the preset for computational resources allocated to a host.

Available presets are listed in the [documentation](/docs/managed-greenplum/concepts/instance-types). ||
|| diskSize | **string** (int64)

Volume of the storage used by the host, in bytes. ||
|| diskTypeId | **string**

Type of the storage used by the host: `network-hdd`, `network-ssd` or `local-ssd`. ||
|#

## SegmentSubclusterConfig {#yandex.cloud.mdb.greenplum.v1.SegmentSubclusterConfig}

#|
||Field | Description ||
|| resources | **[Resources](#yandex.cloud.mdb.greenplum.v1.Resources)**

Computational resources allocated to Greenplum® segment subcluster hosts. ||
|#

## MaintenanceWindow {#yandex.cloud.mdb.greenplum.v1.MaintenanceWindow}

#|
||Field | Description ||
|| anytime | **object**

An any-time maintenance window.

Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`. ||
|| weeklyMaintenanceWindow | **[WeeklyMaintenanceWindow](#yandex.cloud.mdb.greenplum.v1.WeeklyMaintenanceWindow)**

A weekly maintenance window.

Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`. ||
|#

## WeeklyMaintenanceWindow {#yandex.cloud.mdb.greenplum.v1.WeeklyMaintenanceWindow}

A weekly maintenance window.

#|
||Field | Description ||
|| day | **enum** (WeekDay)

Day of the week.

- `WEEK_DAY_UNSPECIFIED`
- `MON`: Monday
- `TUE`: Tuesday
- `WED`: Wednesday
- `THU`: Thursday
- `FRI`: Friday
- `SAT`: Saturday
- `SUN`: Sunday ||
|| hour | **string** (int64)

Hour of the day in the UTC timezone. ||
|#

## MaintenanceOperation {#yandex.cloud.mdb.greenplum.v1.MaintenanceOperation}

#|
||Field | Description ||
|| info | **string**

The description of the operation. ||
|| delayedUntil | **string** (date-time)

Delay time for the maintenance operation.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|#

## ClusterConfigSet {#yandex.cloud.mdb.greenplum.v1.ClusterConfigSet}

#|
||Field | Description ||
|| greenplumConfigSet_6_17 | **[GreenplumConfigSet6_17](#yandex.cloud.mdb.greenplum.v1.GreenplumConfigSet6_17)**

Includes only one of the fields `greenplumConfigSet_6_17`, `greenplumConfigSet_6_19`, `greenplumConfigSet_6_21`, `greenplumConfigSet_6_22`, `greenplumConfigSet_6`. ||
|| greenplumConfigSet_6_19 | **[GreenplumConfigSet6_19](#yandex.cloud.mdb.greenplum.v1.GreenplumConfigSet6_19)**

Includes only one of the fields `greenplumConfigSet_6_17`, `greenplumConfigSet_6_19`, `greenplumConfigSet_6_21`, `greenplumConfigSet_6_22`, `greenplumConfigSet_6`. ||
|| greenplumConfigSet_6_21 | **[GreenplumConfigSet6_21](#yandex.cloud.mdb.greenplum.v1.GreenplumConfigSet6_21)**

Includes only one of the fields `greenplumConfigSet_6_17`, `greenplumConfigSet_6_19`, `greenplumConfigSet_6_21`, `greenplumConfigSet_6_22`, `greenplumConfigSet_6`. ||
|| greenplumConfigSet_6_22 | **[GreenplumConfigSet6_22](#yandex.cloud.mdb.greenplum.v1.GreenplumConfigSet6_22)**

Includes only one of the fields `greenplumConfigSet_6_17`, `greenplumConfigSet_6_19`, `greenplumConfigSet_6_21`, `greenplumConfigSet_6_22`, `greenplumConfigSet_6`. ||
|| greenplumConfigSet_6 | **[GreenplumConfigSet6](#yandex.cloud.mdb.greenplum.v1.GreenplumConfigSet6)**

Includes only one of the fields `greenplumConfigSet_6_17`, `greenplumConfigSet_6_19`, `greenplumConfigSet_6_21`, `greenplumConfigSet_6_22`, `greenplumConfigSet_6`. ||
|| pool | **[ConnectionPoolerConfigSet](#yandex.cloud.mdb.greenplum.v1.ConnectionPoolerConfigSet)**

Odyssey® pool settings. ||
|| backgroundActivities | **[BackgroundActivitiesConfig](#yandex.cloud.mdb.greenplum.v1.BackgroundActivitiesConfig)**

Managed Greenplum® background tasks configuration. ||
|| pxfConfig | **[PXFConfigSet](#yandex.cloud.mdb.greenplum.v1.PXFConfigSet)** ||
|#

## GreenplumConfigSet6_17 {#yandex.cloud.mdb.greenplum.v1.GreenplumConfigSet6_17}

Configuration settings version 6.17

#|
||Field | Description ||
|| effectiveConfig | **[GreenplumConfig6_17](#yandex.cloud.mdb.greenplum.v1.GreenplumConfig6_17)**

Required field. Effective settings for a Greenplum® cluster (a combination of settings defined in `userConfig` and `defaultConfig`). ||
|| userConfig | **[GreenplumConfig6_17](#yandex.cloud.mdb.greenplum.v1.GreenplumConfig6_17)**

User-defined settings for a Greenplum® cluster. ||
|| defaultConfig | **[GreenplumConfig6_17](#yandex.cloud.mdb.greenplum.v1.GreenplumConfig6_17)**

Default configuration for a Greenplum® cluster. ||
|#

## GreenplumConfig6_17 {#yandex.cloud.mdb.greenplum.v1.GreenplumConfig6_17}

#|
||Field | Description ||
|| maxConnections | **string** (int64)

Maximum number of inbound connections on master segment. ||
|| maxSlotWalKeepSize | **string** (int64)

The maximum size of WAL files that replication slots are allowed to retain in the `pg_wal` directory at checkpoint time.

More info in [PostgreSQL® documentation](https://www.postgresql.org/docs/current/runtime-config-replication.html). ||
|| gpWorkfileLimitPerSegment | **string** (int64)

The maximum total disk size that all running queries are allowed to use for creating temporary spill files at each segment.

The default value is 0 (no limit).

More info in [Greenplum® documentation](https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_limit_per_segment). ||
|| gpWorkfileLimitPerQuery | **string** (int64)

The maximum disk size that an individual query is allowed to use for creating temporary spill files at each segment.

The default value is 0 (no limit).

More info in [Greenplum® documentation](https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_limit_per_query). ||
|| gpWorkfileLimitFilesPerQuery | **string** (int64)

The maximum number of temporary spill files allowed per query at each segment.

Spill files, also known as workfiles, are created when a query requires more memory than there is allocated.

The current query is terminated if the limit is exceeded.

Set to zero to disable the limit.

Master session reloads if the parameter changes.

Default value is 10000.

More info in [Greenplum® documentation](https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_limit_files_per_query). ||
|| maxPreparedTransactions | **string** (int64)

The maximum number of transactions that can be in the `prepared` state simultaneously.

More info in [PostgreSQL® documentation](https://www.postgresql.org/docs/9.6/runtime-config-resource.html). ||
|| gpWorkfileCompression | **boolean**

Whether the spill files are compressed or not.

More info in [Greenplum® documentation](https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_compression). ||
|#

## GreenplumConfigSet6_19 {#yandex.cloud.mdb.greenplum.v1.GreenplumConfigSet6_19}

Configuration settings version 6.19

#|
||Field | Description ||
|| effectiveConfig | **[GreenplumConfig6_19](#yandex.cloud.mdb.greenplum.v1.GreenplumConfig6_19)**

Required field. Effective settings for a Greenplum® cluster (a combination of settings defined in `userConfig` and `defaultConfig`). ||
|| userConfig | **[GreenplumConfig6_19](#yandex.cloud.mdb.greenplum.v1.GreenplumConfig6_19)**

User-defined settings for a Greenplum® cluster. ||
|| defaultConfig | **[GreenplumConfig6_19](#yandex.cloud.mdb.greenplum.v1.GreenplumConfig6_19)**

Default configuration for a Greenplum® cluster. ||
|#

## GreenplumConfig6_19 {#yandex.cloud.mdb.greenplum.v1.GreenplumConfig6_19}

#|
||Field | Description ||
|| maxConnections | **string** (int64)

Maximum number of inbound connections on master segment. ||
|| maxSlotWalKeepSize | **string** (int64)

The maximum size of WAL files that replication slots are allowed to retain in the `pg_wal` directory at checkpoint time.

More info in [PostgreSQL® documentation](https://www.postgresql.org/docs/current/runtime-config-replication.html). ||
|| gpWorkfileLimitPerSegment | **string** (int64)

The maximum total disk size that all running queries are allowed to use for creating temporary spill files at each segment.

The default value is 0 (no limit).

More info in [Greenplum® documentation](https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_limit_per_segment). ||
|| gpWorkfileLimitPerQuery | **string** (int64)

The maximum disk size that an individual query is allowed to use for creating temporary spill files at each segment.

The default value is 0 (no limit).

More info in [Greenplum® documentation](https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_limit_per_query). ||
|| gpWorkfileLimitFilesPerQuery | **string** (int64)

The maximum number of temporary spill files allowed per query at each segment.

Spill files, also known as workfiles, are created when a query requires more memory than there is allocated.

The current query is terminated if the limit is exceeded.

Set to zero to disable the limit.

Master session reloads if the parameter changes.

Default value is 10000.

More info in [Greenplum® documentation](https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_limit_files_per_query). ||
|| maxPreparedTransactions | **string** (int64)

The maximum number of transactions that can be in the `prepared` state simultaneously.

More info in [PostgreSQL® documentation](https://www.postgresql.org/docs/9.6/runtime-config-resource.html). ||
|| gpWorkfileCompression | **boolean**

Whether the spill files are compressed or not.

More info in [Greenplum® documentation](https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_compression). ||
|| maxStatementMem | **string** (int64)

The maximum memory limit for a query, in bytes.

Helps to avoid out-of-memory errors on a segment host during query processing as a result of setting `statement_mem` too high.

Taking into account the configuration of a single segment host, calculate `maxStatementMem` as follows: `seghost_physical_memory` / `average_number_concurrent_queries`.

When changing both `maxStatementMem` and `statement_mem`, `maxStatementMem` must be changed first, or listed first in the `postgresql.conf` file.

Default value is 2097152000 (2000 MB).

More info in [Greenplum® documentation](https://greenplum.docs.pivotal.io/6-19/ref_guide/config_params/guc-list.html#max_statement_mem). ||
|| logStatement | **enum** (LogStatement)

Logged SQL statements.

`PREPARE` and `EXPLAIN ANALYZE` statements are also logged if their contained command belongs to an appropriate type.

More info in [Greenplum® documentation](https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#log_statement).

- `LOG_STATEMENT_UNSPECIFIED`
- `NONE`: None statements are logged.
- `DDL`: Logs all data definition commands like `CREATE`, `ALTER`, and `DROP`. Default value.
- `MOD`: Logs all `DDL` statements, plus `INSERT`, `UPDATE`, `DELETE`, `TRUNCATE`, and `COPY FROM`.
- `ALL`: Logs all statements. ||
|#

## GreenplumConfigSet6_21 {#yandex.cloud.mdb.greenplum.v1.GreenplumConfigSet6_21}

#|
||Field | Description ||
|| effectiveConfig | **[GreenplumConfig6_21](#yandex.cloud.mdb.greenplum.v1.GreenplumConfig6_21)**

Required field. Effective settings for a Greenplum®  cluster (a combination of settings defined in `userConfig` and `defaultConfig`). ||
|| userConfig | **[GreenplumConfig6_21](#yandex.cloud.mdb.greenplum.v1.GreenplumConfig6_21)**

User-defined settings for a Greenplum® cluster. ||
|| defaultConfig | **[GreenplumConfig6_21](#yandex.cloud.mdb.greenplum.v1.GreenplumConfig6_21)**

Default configuration for a Greenplum® cluster. ||
|#

## GreenplumConfig6_21 {#yandex.cloud.mdb.greenplum.v1.GreenplumConfig6_21}

#|
||Field | Description ||
|| maxConnections | **string** (int64)

Maximum number of inbound connections on master segment ||
|| maxSlotWalKeepSize | **string** (int64)

Specify the maximum size of WAL files that replication slots are allowed to retain in the pg_wal directory at checkpoint time.
https://www.postgresql.org/docs/current/runtime-config-replication.html ||
|| gpWorkfileLimitPerSegment | **string** (int64)

Sets the maximum total disk size that all running queries are allowed to use for creating temporary spill files at each segment.
The default value is 0, which means a limit is not enforced.
https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_limit_per_segment ||
|| gpWorkfileLimitPerQuery | **string** (int64)

Sets the maximum disk size an individual query is allowed to use for creating temporary spill files at each segment.
The default value is 0, which means a limit is not enforced.
https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_limit_per_query ||
|| gpWorkfileLimitFilesPerQuery | **string** (int64)

Sets the maximum number of temporary spill files (also known as workfiles) allowed per query per segment.
Spill files are created when executing a query that requires more memory than it is allocated.
The current query is terminated when the limit is exceeded.
Set the value to 0 (zero) to allow an unlimited number of spill files. master session reload
https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_limit_files_per_query
Default value is 10000 ||
|| maxPreparedTransactions | **string** (int64)

Sets the maximum number of transactions that can be in the "prepared" state simultaneously
https://www.postgresql.org/docs/9.6/runtime-config-resource.html ||
|| gpWorkfileCompression | **boolean**

Specifies whether the temporary files created, when a hash aggregation or hash join operation spills to disk, are compressed.
https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_compression ||
|| maxStatementMem | **string** (int64)

Sets the maximum memory limit for a query. Helps avoid out-of-memory errors on a segment host during query processing as a result of setting statement_mem too high.
Taking into account the configuration of a single segment host, calculate max_statement_mem as follows:
(seghost_physical_memory) / (average_number_concurrent_queries)
When changing both max_statement_mem and statement_mem, max_statement_mem must be changed first, or listed first in the postgresql.conf file.
https://greenplum.docs.pivotal.io/6-19/ref_guide/config_params/guc-list.html#max_statement_mem
Default value is 2097152000 (2000MB) ||
|| logStatement | **enum** (LogStatement)

Controls which SQL statements are logged. DDL logs all data definition commands like CREATE, ALTER, and DROP commands.
MOD logs all DDL statements, plus INSERT, UPDATE, DELETE, TRUNCATE, and COPY FROM.
PREPARE and EXPLAIN ANALYZE statements are also logged if their contained command is of an appropriate type.
https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#log_statement
Default value is ddl

- `LOG_STATEMENT_UNSPECIFIED`
- `NONE`: None statements are logged.
- `DDL`: Logs all data definition commands like `CREATE`, `ALTER`, and `DROP`. Default value.
- `MOD`: Logs all `DDL` statements, plus `INSERT`, `UPDATE`, `DELETE`, `TRUNCATE`, and `COPY FROM`.
- `ALL`: Logs all statements. ||
|| gpAddColumnInheritsTableSetting | **boolean**

https://docs.vmware.com/en/VMware-Tanzu-Greenplum/6/greenplum-database/GUID-ref_guide-config_params-guc-list.html#gp_add_column_inherits_table_setting ||
|#

## GreenplumConfigSet6_22 {#yandex.cloud.mdb.greenplum.v1.GreenplumConfigSet6_22}

#|
||Field | Description ||
|| effectiveConfig | **[GreenplumConfig6_22](#yandex.cloud.mdb.greenplum.v1.GreenplumConfig6_22)**

Required field. Effective settings for a Greenplum®  cluster (a combination of settings defined in `userConfig` and `defaultConfig`). ||
|| userConfig | **[GreenplumConfig6_22](#yandex.cloud.mdb.greenplum.v1.GreenplumConfig6_22)**

User-defined settings for a Greenplum® cluster. ||
|| defaultConfig | **[GreenplumConfig6_22](#yandex.cloud.mdb.greenplum.v1.GreenplumConfig6_22)**

Default configuration for a Greenplum® cluster. ||
|#

## GreenplumConfig6_22 {#yandex.cloud.mdb.greenplum.v1.GreenplumConfig6_22}

#|
||Field | Description ||
|| maxConnections | **string** (int64)

Maximum number of inbound connections on master segment ||
|| maxSlotWalKeepSize | **string** (int64)

Specify the maximum size of WAL files that replication slots are allowed to retain in the pg_wal directory at checkpoint time.
https://www.postgresql.org/docs/current/runtime-config-replication.html ||
|| gpWorkfileLimitPerSegment | **string** (int64)

Sets the maximum total disk size that all running queries are allowed to use for creating temporary spill files at each segment.
The default value is 0, which means a limit is not enforced.
https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_limit_per_segment ||
|| gpWorkfileLimitPerQuery | **string** (int64)

Sets the maximum disk size an individual query is allowed to use for creating temporary spill files at each segment.
The default value is 0, which means a limit is not enforced.
https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_limit_per_query ||
|| gpWorkfileLimitFilesPerQuery | **string** (int64)

Sets the maximum number of temporary spill files (also known as workfiles) allowed per query per segment.
Spill files are created when executing a query that requires more memory than it is allocated.
The current query is terminated when the limit is exceeded.
Set the value to 0 (zero) to allow an unlimited number of spill files. master session reload
https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_limit_files_per_query
Default value is 10000 ||
|| maxPreparedTransactions | **string** (int64)

Sets the maximum number of transactions that can be in the "prepared" state simultaneously
https://www.postgresql.org/docs/9.6/runtime-config-resource.html ||
|| gpWorkfileCompression | **boolean**

Specifies whether the temporary files created, when a hash aggregation or hash join operation spills to disk, are compressed.
https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_compression ||
|| maxStatementMem | **string** (int64)

Sets the maximum memory limit for a query. Helps avoid out-of-memory errors on a segment host during query processing as a result of setting statement_mem too high.
Taking into account the configuration of a single segment host, calculate max_statement_mem as follows:
(seghost_physical_memory) / (average_number_concurrent_queries)
When changing both max_statement_mem and statement_mem, max_statement_mem must be changed first, or listed first in the postgresql.conf file.
https://greenplum.docs.pivotal.io/6-19/ref_guide/config_params/guc-list.html#max_statement_mem
Default value is 2097152000 (2000MB) ||
|| logStatement | **enum** (LogStatement)

Controls which SQL statements are logged. DDL logs all data definition commands like CREATE, ALTER, and DROP commands.
MOD logs all DDL statements, plus INSERT, UPDATE, DELETE, TRUNCATE, and COPY FROM.
PREPARE and EXPLAIN ANALYZE statements are also logged if their contained command is of an appropriate type.
https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#log_statement
Default value is ddl

- `LOG_STATEMENT_UNSPECIFIED`
- `NONE`: None statements are logged.
- `DDL`: Logs all data definition commands like `CREATE`, `ALTER`, and `DROP`. Default value.
- `MOD`: Logs all `DDL` statements, plus `INSERT`, `UPDATE`, `DELETE`, `TRUNCATE`, and `COPY FROM`.
- `ALL`: Logs all statements. ||
|| gpAddColumnInheritsTableSetting | **boolean**

https://docs.vmware.com/en/VMware-Tanzu-Greenplum/6/greenplum-database/GUID-ref_guide-config_params-guc-list.html#gp_add_column_inherits_table_setting ||
|#

## GreenplumConfigSet6 {#yandex.cloud.mdb.greenplum.v1.GreenplumConfigSet6}

#|
||Field | Description ||
|| effectiveConfig | **[GreenplumConfig6](#yandex.cloud.mdb.greenplum.v1.GreenplumConfig6)**

Required field. Effective settings for a Greenplum (a combination of settings defined
in `userConfig` and `defaultConfig`). ||
|| userConfig | **[GreenplumConfig6](#yandex.cloud.mdb.greenplum.v1.GreenplumConfig6)**

User-defined settings for a Greenplum. ||
|| defaultConfig | **[GreenplumConfig6](#yandex.cloud.mdb.greenplum.v1.GreenplumConfig6)**

Default configuration for a Greenplum. ||
|#

## GreenplumConfig6 {#yandex.cloud.mdb.greenplum.v1.GreenplumConfig6}

#|
||Field | Description ||
|| maxConnections | **string** (int64)

Maximum number of inbound connections on master segment ||
|| maxSlotWalKeepSize | **string** (int64)

Specify the maximum size of WAL files that replication slots are allowed to retain in the pg_wal directory at checkpoint time.
https://www.postgresql.org/docs/current/runtime-config-replication.html ||
|| gpWorkfileLimitPerSegment | **string** (int64)

Sets the maximum total disk size that all running queries are allowed to use for creating temporary spill files at each segment.
The default value is 0, which means a limit is not enforced.
https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_per_segment ||
|| gpWorkfileLimitPerQuery | **string** (int64)

Sets the maximum disk size an individual query is allowed to use for creating temporary spill files at each segment.
The default value is 0, which means a limit is not enforced.
https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_per_query ||
|| gpWorkfileLimitFilesPerQuery | **string** (int64)

Sets the maximum number of temporary spill files (also known as workfiles) allowed per query per segment.
Spill files are created when executing a query that requires more memory than it is allocated.
The current query is terminated when the limit is exceeded.
Set the value to 0 (zero) to allow an unlimited number of spill files. master session reload
https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_files_per_query
Default value is 10000 ||
|| maxPreparedTransactions | **string** (int64)

Sets the maximum number of transactions that can be in the "prepared" state simultaneously
https://www.postgresql.org/docs/9.6/runtime-config-resource.html ||
|| gpWorkfileCompression | **boolean**

Specifies whether the temporary files created, when a hash aggregation or hash join operation spills to disk, are compressed.
https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_compression ||
|| maxStatementMem | **string** (int64)

Sets the maximum memory limit for a query. Helps avoid out-of-memory errors on a segment host during query processing as a result of setting statement_mem too high.
Taking into account the configuration of a single segment host, calculate max_statement_mem as follows:
(seghost_physical_memory) / (average_number_concurrent_queries)
When changing both max_statement_mem and statement_mem, max_statement_mem must be changed first, or listed first in the postgresql.conf file.
https://greenplum.docs.pivotal.io/6-19/ref_guide/config_params/guc-list.html#max_statement_mem
Default value is 2097152000 (2000MB) ||
|| logStatement | **enum** (LogStatement)

Controls which SQL statements are logged. DDL logs all data definition commands like CREATE, ALTER, and DROP commands.
MOD logs all DDL statements, plus INSERT, UPDATE, DELETE, TRUNCATE, and COPY FROM.
PREPARE and EXPLAIN ANALYZE statements are also logged if their contained command is of an appropriate type.
https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#log_statement
Default value is ddl

- `LOG_STATEMENT_UNSPECIFIED`
- `NONE`: None statements are logged.
- `DDL`: Logs all data definition commands like `CREATE`, `ALTER`, and `DROP`. Default value.
- `MOD`: Logs all `DDL` statements, plus `INSERT`, `UPDATE`, `DELETE`, `TRUNCATE`, and `COPY FROM`.
- `ALL`: Logs all statements. ||
|| gpAddColumnInheritsTableSetting | **boolean**

https://docs.vmware.com/en/VMware-Tanzu-Greenplum/6/greenplum-database/GUID-ref_guide-config_params-guc-list.html#gp_add_column_inherits_table_setting ||
|| gpEnableGlobalDeadlockDetector | **boolean**

Controls whether the Greenplum Database Global Deadlock Detector is enabled to manage concurrent UPDATE and DELETE operations on heap tables to improve performance. See Inserting, Updating, and Deleting Datain the Greenplum Database Administrator Guide. The default is off, the Global Deadlock Detector is deactivated.
If the Global Deadlock Detector is deactivated (the default), Greenplum Database runs concurrent update and delete operations on a heap table serially.
If the Global Deadlock Detector is enabled, concurrent updates are permitted and the Global Deadlock Detector determines when a deadlock exists, and breaks the deadlock by cancelling one or more backend processes associated with the youngest transaction(s) involved.
https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_enable_global_deadlock_detector ||
|| gpGlobalDeadlockDetectorPeriod | **string** (int64)

Specifies the executing interval (in seconds) of the global deadlock detector background worker process.
https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_global_deadlock_detector_period ||
|#

## ConnectionPoolerConfigSet {#yandex.cloud.mdb.greenplum.v1.ConnectionPoolerConfigSet}

#|
||Field | Description ||
|| effectiveConfig | **[ConnectionPoolerConfig](#yandex.cloud.mdb.greenplum.v1.ConnectionPoolerConfig)**

Required field. Effective settings for an Odyssey® pooler (a combination of settings defined in `ConnectionPoolerConfigSet.userConfig` and `ConnectionPoolerConfigSet.defaultConfig`). ||
|| userConfig | **[ConnectionPoolerConfig](#yandex.cloud.mdb.greenplum.v1.ConnectionPoolerConfig)**

User-defined settings for an Odyssey® pooler. ||
|| defaultConfig | **[ConnectionPoolerConfig](#yandex.cloud.mdb.greenplum.v1.ConnectionPoolerConfig)**

Default configuration for an Odyssey® pooler. ||
|#

## ConnectionPoolerConfig {#yandex.cloud.mdb.greenplum.v1.ConnectionPoolerConfig}

#|
||Field | Description ||
|| mode | **enum** (PoolMode)

Route server pool mode.

- `POOL_MODE_UNSPECIFIED`
- `SESSION`: Assign server connection to a client until it disconnects. Default value.
- `TRANSACTION`: Assign server connection to a client for a transaction processing. ||
|| size | **string** (int64)

The number of servers in the server pool. Clients are placed in a wait queue when all servers are busy.

Set to zero to disable the limit. ||
|| clientIdleTimeout | **string** (int64)

Server pool idle timeout, in seconds.

A server connection closes after being idle for the specified time.

Set to zero to disable the limit. ||
|#

## BackgroundActivitiesConfig {#yandex.cloud.mdb.greenplum.v1.BackgroundActivitiesConfig}

#|
||Field | Description ||
|| tableSizes | **[TableSizes](#yandex.cloud.mdb.greenplum.v1.TableSizes)**

Enables scripts that collects tables sizes to `*_sizes` tables in `mdb_toolkit` schema. ||
|| analyzeAndVacuum | **[AnalyzeAndVacuum](#yandex.cloud.mdb.greenplum.v1.AnalyzeAndVacuum)**

Configuration for `ANALYZE` and `VACUUM` operations. ||
|| queryKillerScripts | **[QueryKillerScripts](#yandex.cloud.mdb.greenplum.v1.QueryKillerScripts)**

Configuration for long running queries killer. ||
|#

## TableSizes {#yandex.cloud.mdb.greenplum.v1.TableSizes}

#|
||Field | Description ||
|| starts[] | **[BackgroundActivityStartAt](#yandex.cloud.mdb.greenplum.v1.BackgroundActivityStartAt)** ||
|#

## BackgroundActivityStartAt {#yandex.cloud.mdb.greenplum.v1.BackgroundActivityStartAt}

#|
||Field | Description ||
|| hours | **string** (int64) ||
|| minutes | **string** (int64) ||
|#

## AnalyzeAndVacuum {#yandex.cloud.mdb.greenplum.v1.AnalyzeAndVacuum}

#|
||Field | Description ||
|| start | **[BackgroundActivityStartAt](#yandex.cloud.mdb.greenplum.v1.BackgroundActivityStartAt)** ||
|| analyzeTimeout | **string** (int64)

Maximum duration of the `ANALYZE` operation, in seconds. The default value is `36000`. As soon as this period expires, the `ANALYZE` operation will be forced to terminate. ||
|| vacuumTimeout | **string** (int64)

Maximum duration of the `VACUUM` operation, in seconds. The default value is `36000`. As soon as this period expires, the `VACUUM` operation will be forced to terminate. ||
|#

## QueryKillerScripts {#yandex.cloud.mdb.greenplum.v1.QueryKillerScripts}

#|
||Field | Description ||
|| idle | **[QueryKiller](#yandex.cloud.mdb.greenplum.v1.QueryKiller)**

Configuration of script that kills long running queries that are in `idle` state. ||
|| idleInTransaction | **[QueryKiller](#yandex.cloud.mdb.greenplum.v1.QueryKiller)**

Configuration of script that kills long running queries that are in `idle in transaction` state. ||
|| longRunning | **[QueryKiller](#yandex.cloud.mdb.greenplum.v1.QueryKiller)**

Configuration of script that kills long running queries (in any state). ||
|#

## QueryKiller {#yandex.cloud.mdb.greenplum.v1.QueryKiller}

#|
||Field | Description ||
|| enable | **boolean** ||
|| maxAge | **string** (int64)

Maximum duration for this type of queries (in seconds). ||
|| ignoreUsers[] | **string**

Ignore these users when considering queries to terminate ||
|#

## PXFConfigSet {#yandex.cloud.mdb.greenplum.v1.PXFConfigSet}

#|
||Field | Description ||
|| effectiveConfig | **[PXFConfig](#yandex.cloud.mdb.greenplum.v1.PXFConfig)**

Required field.  ||
|| userConfig | **[PXFConfig](#yandex.cloud.mdb.greenplum.v1.PXFConfig)**

User-defined settings. ||
|| defaultConfig | **[PXFConfig](#yandex.cloud.mdb.greenplum.v1.PXFConfig)**

Default configuration. ||
|#

## PXFConfig {#yandex.cloud.mdb.greenplum.v1.PXFConfig}

#|
||Field | Description ||
|| connectionTimeout | **string** (int64)

Timeout for connection to the Apache Tomcat® server when making read requests.

Specify values in seconds. ||
|| uploadTimeout | **string** (int64)

Timeout for connection to the Apache Tomcat® server when making write requests.

Specify the values in seconds. ||
|| maxThreads | **string** (int64)

Maximum number of the Apache Tomcat® threads.

To prevent situations when requests get stuck or fail due to running out of memory or malfunctioning of the Java garbage collector, specify the number of the Apache Tomcat® threads. Learn more about adjusting the number of threads in the [VMware Greenplum® Platform Extension Framework](https://docs.vmware.com/en/VMware-Greenplum-Platform-Extension-Framework/6.9/greenplum-platform-extension-framework/cfg_mem.html) documentation. ||
|| poolAllowCoreThreadTimeout | **boolean**

Determines whether the timeout for core streaming threads is permitted. ||
|| poolCoreSize | **string** (int64)

Number of core streaming threads per pool. ||
|| poolQueueCapacity | **string** (int64)

Maximum number of requests you can add to a pool queue for core streaming threads.

If `0`, no pool queue is generated. ||
|| poolMaxSize | **string** (int64)

Maximum allowed number of core streaming threads. ||
|| xmx | **string** (int64)

Initial size, in megabytes, of the JVM heap for the PXF daemon. ||
|| xms | **string** (int64)

Maximum size, in megabytes, of the JVM heap for the PXF daemon. ||
|#

## CloudStorage {#yandex.cloud.mdb.greenplum.v1.CloudStorage}

Cloud Storage Settings

#|
||Field | Description ||
|| enable | **boolean**

enable Cloud Storage for cluster ||
|#

## LoggingConfig {#yandex.cloud.mdb.greenplum.v1.LoggingConfig}

#|
||Field | Description ||
|| enabled | **boolean** ||
|| folderId | **string**

Includes only one of the fields `folderId`, `logGroupId`. ||
|| logGroupId | **string**

Includes only one of the fields `folderId`, `logGroupId`. ||
|| commandCenterEnabled | **boolean**

send Yandex Command Center logs ||
|| greenplumEnabled | **boolean**

send Greenplum logs ||
|| poolerEnabled | **boolean**

send Pooler logs ||
|#