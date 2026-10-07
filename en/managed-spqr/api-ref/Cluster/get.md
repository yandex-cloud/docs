---
editable: false
apiPlayground:
  - url: https://{{ api-host-mdb }}/managed-spqr/v1/clusters/{clusterId}
    method: get
    path:
      type: object
      properties:
        clusterId:
          description: |-
            **string**
            Required field. ID of the SPQR Cluster resource to return.
            To get the cluster ID, use a [ClusterService.List](/docs/managed-spqr/api-ref/Cluster/list#List) request.
            The maximum string length in characters is 50.
          type: string
      required:
        - clusterId
      additionalProperties: false
    query: null
    body: null
    definitions: null
---

# Managed Service for SPQR API, REST: Cluster.Get

Returns the specified SPQR Cluster resource.
To get the list of available SPQR Cluster resources, make a [List](/docs/managed-spqr/api-ref/Cluster/list#List) request.

## HTTP request

```
GET https://{{ api-host-mdb }}/managed-spqr/v1/clusters/{clusterId}
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the SPQR Cluster resource to return.
To get the cluster ID, use a [ClusterService.List](/docs/managed-spqr/api-ref/Cluster/list#List) request.

The maximum string length in characters is 50. ||
|#

## Response {#yandex.cloud.mdb.spqr.v1.Cluster}

**HTTP Code: 200 - OK**

```json
{
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
    "spqrConfig": {
      "router": {
        "config": {
          "showNoticeMessages": "boolean",
          "timeQuantiles": [
            "string"
          ],
          "defaultRouteBehavior": "string",
          "preferSameAvailabilityZone": "boolean",
          "enhancedMultishardProcessing": "boolean",
          "defaultTargetSessionAttrs": "string",
          "defaultCommitStrategy": "string",
          "allowPostprocessing": "boolean",
          "autoRouteRoOnStandby": "boolean"
        },
        "resources": {
          "resourcePresetId": "string",
          "diskSize": "string",
          "diskTypeId": "string"
        }
      },
      "coordinator": {
        "config": {
          "iterationTimeout": "string",
          "lockIterationTimeout": "string",
          "routerKeepaliveTime": "string",
          "routerKeepaliveTimeout": "string",
          "etcdMaxSendBytes": "string",
          "etcdMaxTxnOps": "string"
        },
        "resources": {
          "resourcePresetId": "string",
          "diskSize": "string",
          "diskTypeId": "string"
        }
      },
      "postgresql": {
        "config": "object",
        "resources": {
          "resourcePresetId": "string",
          "diskSize": "string",
          "diskTypeId": "string"
        }
      },
      "infra": {
        "resources": {
          "resourcePresetId": "string",
          "diskSize": "string",
          "diskTypeId": "string"
        },
        "router": {
          "showNoticeMessages": "boolean",
          "timeQuantiles": [
            "string"
          ],
          "defaultRouteBehavior": "string",
          "preferSameAvailabilityZone": "boolean",
          "enhancedMultishardProcessing": "boolean",
          "defaultTargetSessionAttrs": "string",
          "defaultCommitStrategy": "string",
          "allowPostprocessing": "boolean",
          "autoRouteRoOnStandby": "boolean"
        },
        "coordinator": {
          "iterationTimeout": "string",
          "lockIterationTimeout": "string",
          "routerKeepaliveTime": "string",
          "routerKeepaliveTimeout": "string",
          "etcdMaxSendBytes": "string",
          "etcdMaxTxnOps": "string"
        }
      },
      "balancer": {
        "cpuThreshold": "number",
        "spaceThreshold": "number",
        "statIntervalSec": "string",
        "maxMoveCount": "string",
        "keysPerMove": "string",
        "timeout": "string"
      },
      "logLevel": "string",
      "useSpqrguard": "boolean",
      "forbidDirectShardQueries": "boolean"
    },
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
      "serverless": "boolean"
    },
    "soxAudit": "boolean"
  },
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
    "delayedUntil": "string",
    "latestMaintenanceTime": "string",
    "nextMaintenanceWindowTime": "string"
  },
  "securityGroupIds": [
    "string"
  ],
  "deletionProtection": "boolean",
  "hostGroupIds": [
    "string"
  ],
  "maintenanceWindows": {
    // Includes only one of the fields `anytime`, `weeklyMaintenanceSchedule`
    "anytime": "object",
    "weeklyMaintenanceSchedule": {
      "slots": [
        {
          "day": "string",
          "startTime": {
            "hours": "integer",
            "minutes": "integer",
            "seconds": "integer",
            "nanos": "integer"
          },
          "duration": "string",
          "allowTemporaryUnavailability": "boolean"
        }
      ]
    }
    // end of the list of possible fields
  },
  "isHa": "boolean"
}
```

A managed SPQR cluster. For more information, see the [documentation](/docs/managed-spqr/concepts).

#|
||Field | Description ||
|| id | **string**

ID of the SPQR cluster.
This ID is assigned by MDB at creation time. ||
|| folderId | **string**

ID of the folder that the SPQR cluster belongs to. ||
|| createdAt | **string** (date-time)

Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| name | **string**

Name of the SPQR cluster.
The name is unique within the folder. 1-63 characters long. ||
|| description | **string**

Description of the SPQR cluster. 0-256 characters long. ||
|| labels | **object** (map<**string**, **string**>)

Custom labels for the SPQR cluster as `` key:value `` pairs. Maximum 64 per resource. ||
|| environment | **enum** (Environment)

Deployment environment of the SPQR cluster.

- `PRODUCTION`: Stable environment with a conservative update policy: only hotfixes
are applied during regular maintenance.
- `PRESTABLE`: Environment with a more aggressive update policy: new versions
are rolled out irrespective of backward compatibility. ||
|| monitoring[] | **[Monitoring](#yandex.cloud.mdb.spqr.v1.Monitoring)**

Description of monitoring systems relevant to the SPQR cluster. ||
|| config | **[ClusterConfig](#yandex.cloud.mdb.spqr.v1.ClusterConfig)**

Configuration of the SPQR cluster. ||
|| networkId | **string**

ID of the network that the cluster belongs to. ||
|| health | **enum** (Health)

Aggregated cluster health.

- `HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](/docs/managed-spqr/api-ref/Cluster/listHosts#yandex.cloud.mdb.spqr.v1.Host) for every host in the cluster is UNKNOWN).
- `ALIVE`: Cluster is alive and well ([Host.health](/docs/managed-spqr/api-ref/Cluster/listHosts#yandex.cloud.mdb.spqr.v1.Host) for every host in the cluster is ALIVE).
- `DEAD`: Cluster is inoperable ([Host.health](/docs/managed-spqr/api-ref/Cluster/listHosts#yandex.cloud.mdb.spqr.v1.Host) for every host in the cluster is DEAD).
- `DEGRADED`: Cluster is working below capacity ([Host.health](/docs/managed-spqr/api-ref/Cluster/listHosts#yandex.cloud.mdb.spqr.v1.Host) for at least one host in the cluster is not ALIVE). ||
|| status | **enum** (Status)

Current state of the cluster.

- `STATUS_UNKNOWN`: Cluster state is unknown.
- `CREATING`: Cluster is being created.
- `RUNNING`: Cluster is running normally.
- `ERROR`: Cluster encountered a problem and cannot operate.
- `UPDATING`: Cluster is being updated.
- `STOPPING`: Cluster is stopping.
- `STOPPED`: Cluster stopped.
- `STARTING`: Cluster is starting. ||
|| maintenanceWindow | **[MaintenanceWindow](#yandex.cloud.mdb.spqr.v1.MaintenanceWindow)**

Deprecated. Use maintenance_windows instead.
Maintenance window for the cluster. ||
|| plannedOperation | **[MaintenanceOperation](#yandex.cloud.mdb.spqr.v1.MaintenanceOperation)**

Planned maintenance operation to be started for the cluster within the nearest `maintenanceWindow`. ||
|| securityGroupIds[] | **string**

User security groups ||
|| deletionProtection | **boolean**

Deletion Protection inhibits deletion of the cluster ||
|| hostGroupIds[] | **string**

Host groups hosting VMs of the cluster. ||
|| maintenanceWindows | **[MaintenanceWindows](#yandex.cloud.mdb.v1.MaintenanceWindows)**

Maintenance windows for the cluster. ||
|| isHa | **boolean**

Indicates whether the cluster topology is highly available as defined by the Yandex Cloud SLA for managed databases. ||
|#

## Monitoring {#yandex.cloud.mdb.spqr.v1.Monitoring}

Monitoring system.

#|
||Field | Description ||
|| name | **string**

Name of the monitoring system. ||
|| description | **string**

Description of the monitoring system. ||
|| link | **string**

Link to the monitoring system charts for the SPQR cluster. ||
|#

## ClusterConfig {#yandex.cloud.mdb.spqr.v1.ClusterConfig}

#|
||Field | Description ||
|| spqrConfig | **[SPQRConfig](#yandex.cloud.mdb.spqr.v1.SPQRConfig)**

Configuration for SPQR servers in the cluster. ||
|| backupWindowStart | **[TimeOfDay](#google.type.TimeOfDay)**

Time to start the daily backup, in the UTC timezone. ||
|| backupRetainPeriodDays | **string** (int64)

Retain period of automatically created backup in days ||
|| access | **[Access](#yandex.cloud.mdb.spqr.v1.Access)**

Access policy to DB ||
|| soxAudit | **boolean**

Configuration setting which enables/disables SOX audit. ||
|#

## SPQRConfig {#yandex.cloud.mdb.spqr.v1.SPQRConfig}

#|
||Field | Description ||
|| router | **[RouterConfig](#yandex.cloud.mdb.spqr.v1.RouterConfig)**

SPQR router settings. ||
|| coordinator | **[CoordinatorConfig](#yandex.cloud.mdb.spqr.v1.CoordinatorConfig)**

SPQR coordinator settings. ||
|| postgresql | **[PostgreSQLConfig](#yandex.cloud.mdb.spqr.v1.PostgreSQLConfig)**

PostgreSQL settings. ||
|| infra | **[InfraConfig](#yandex.cloud.mdb.spqr.v1.InfraConfig)**

SPQR Infra (router+coordinator) settings. ||
|| balancer | **[BalancerSettings](#yandex.cloud.mdb.spqr.v1.BalancerSettings)**

SPQR Balancer settings. ||
|| logLevel | **enum** (LogLevel)

SPQR default log level

- `DEBUG`
- `INFO`
- `WARNING`
- `ERROR`
- `FATAL` ||
|| useSpqrguard | **boolean** ||
|| forbidDirectShardQueries | **boolean** ||
|#

## RouterConfig {#yandex.cloud.mdb.spqr.v1.RouterConfig}

#|
||Field | Description ||
|| config | **[RouterSettings](#yandex.cloud.mdb.spqr.v1.RouterSettings)** ||
|| resources | **[Resources](#yandex.cloud.mdb.spqr.v1.Resources)** ||
|#

## RouterSettings {#yandex.cloud.mdb.spqr.v1.RouterSettings}

Configuration of a SPQR router.

#|
||Field | Description ||
|| showNoticeMessages | **boolean** ||
|| timeQuantiles[] | **string** ||
|| defaultRouteBehavior | **enum** (DefaultRouteBehavior)

- `BLOCK`
- `ALLOW` ||
|| preferSameAvailabilityZone | **boolean** ||
|| enhancedMultishardProcessing | **boolean** ||
|| defaultTargetSessionAttrs | **enum** (TargetSessionAttrs)

- `READ_WRITE`
- `SMART_READ_WRITE`
- `READ_ONLY`
- `PREFER_STANDBY`
- `ANY` ||
|| defaultCommitStrategy | **enum** (CommitStrategy)

- `BEST_EFFORT`
- `ONE_PC`
- `TWO_PC` ||
|| allowPostprocessing | **boolean** ||
|| autoRouteRoOnStandby | **boolean** ||
|#

## Resources {#yandex.cloud.mdb.spqr.v1.Resources}

#|
||Field | Description ||
|| resourcePresetId | **string**

ID of the preset for computational resources available to a host (CPU, memory etc.).
All available presets are listed in the [documentation](/docs/managed-spqr/concepts/instance-types). ||
|| diskSize | **string** (int64)

Volume of the storage available to a host, in bytes. ||
|| diskTypeId | **string**

Type of the storage environment for the host.
Possible values:
* network-hdd - network HDD drive,
* network-ssd - network SSD drive,
* local-ssd - local SSD storage. ||
|#

## CoordinatorConfig {#yandex.cloud.mdb.spqr.v1.CoordinatorConfig}

#|
||Field | Description ||
|| config | **[CoordinatorSettings](#yandex.cloud.mdb.spqr.v1.CoordinatorSettings)** ||
|| resources | **[Resources](#yandex.cloud.mdb.spqr.v1.Resources)** ||
|#

## CoordinatorSettings {#yandex.cloud.mdb.spqr.v1.CoordinatorSettings}

Configuration of a SPQR coordinator.

#|
||Field | Description ||
|| iterationTimeout | **string** (duration) ||
|| lockIterationTimeout | **string** (duration) ||
|| routerKeepaliveTime | **string** (duration) ||
|| routerKeepaliveTimeout | **string** (duration) ||
|| etcdMaxSendBytes | **string** (int64) ||
|| etcdMaxTxnOps | **string** (int64) ||
|#

## PostgreSQLConfig {#yandex.cloud.mdb.spqr.v1.PostgreSQLConfig}

#|
||Field | Description ||
|| config | **object** ||
|| resources | **[Resources](#yandex.cloud.mdb.spqr.v1.Resources)** ||
|#

## InfraConfig {#yandex.cloud.mdb.spqr.v1.InfraConfig}

#|
||Field | Description ||
|| resources | **[Resources](#yandex.cloud.mdb.spqr.v1.Resources)** ||
|| router | **[RouterSettings](#yandex.cloud.mdb.spqr.v1.RouterSettings)** ||
|| coordinator | **[CoordinatorSettings](#yandex.cloud.mdb.spqr.v1.CoordinatorSettings)** ||
|#

## BalancerSettings {#yandex.cloud.mdb.spqr.v1.BalancerSettings}

#|
||Field | Description ||
|| cpuThreshold | **number** (double) ||
|| spaceThreshold | **number** (double) ||
|| statIntervalSec | **string** (int64) ||
|| maxMoveCount | **string** (int64) ||
|| keysPerMove | **string** (int64) ||
|| timeout | **string** (int64) ||
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

## Access {#yandex.cloud.mdb.spqr.v1.Access}

#|
||Field | Description ||
|| dataLens | **boolean**

Allow access for DataLens. ||
|| webSql | **boolean**

Allow access for Web SQL. ||
|| dataTransfer | **boolean**

Allow access for DataTransfer. ||
|| serverless | **boolean**

Allow access for Serverless.
NOTE: Do not propagate to public API until Serverless integration is required. ||
|#

## MaintenanceWindow {#yandex.cloud.mdb.spqr.v1.MaintenanceWindow}

A maintenance window settings.

#|
||Field | Description ||
|| anytime | **object**

Maintenance operation can be scheduled anytime.

Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`.

The maintenance policy in effect. ||
|| weeklyMaintenanceWindow | **[WeeklyMaintenanceWindow](#yandex.cloud.mdb.spqr.v1.WeeklyMaintenanceWindow)**

Maintenance operation can be scheduled on a weekly basis.

Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`.

The maintenance policy in effect. ||
|#

## WeeklyMaintenanceWindow {#yandex.cloud.mdb.spqr.v1.WeeklyMaintenanceWindow}

Weelky maintenance window settings.

#|
||Field | Description ||
|| day | **enum** (WeekDay)

Day of the week (in `DDD` format).

- `MON`
- `TUE`
- `WED`
- `THU`
- `FRI`
- `SAT`
- `SUN` ||
|| hour | **string** (int64)

Hour of the day in UTC (in `HH` format).

Acceptable values are 1 to 24, inclusive. ||
|#

## MaintenanceOperation {#yandex.cloud.mdb.spqr.v1.MaintenanceOperation}

A planned maintenance operation.

#|
||Field | Description ||
|| info | **string**

Information about this maintenance operation.

The maximum string length in characters is 256. ||
|| delayedUntil | **string** (date-time)

Time until which this maintenance operation is delayed.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| latestMaintenanceTime | **string** (date-time)

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| nextMaintenanceWindowTime | **string** (date-time)

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|#

## MaintenanceWindows {#yandex.cloud.mdb.v1.MaintenanceWindows}

Maintenance windows shared by all managed database services.

#|
||Field | Description ||
|| anytime | **object**

Maintenance operations can be scheduled anytime.

Includes only one of the fields `anytime`, `weeklyMaintenanceSchedule`. ||
|| weeklyMaintenanceSchedule | **[WeeklyMaintenanceSchedule](#yandex.cloud.mdb.v1.WeeklyMaintenanceSchedule)**

Maintenance operations can be scheduled during the specified weekly slots.

Includes only one of the fields `anytime`, `weeklyMaintenanceSchedule`. ||
|#

## WeeklyMaintenanceSchedule {#yandex.cloud.mdb.v1.WeeklyMaintenanceSchedule}

#|
||Field | Description ||
|| slots[] | **[MaintenanceWindowSlot](#yandex.cloud.mdb.v1.MaintenanceWindowSlot)**

Weekly time slots during which maintenance operations can be scheduled.
At least one slot is required.

The number of elements must be greater than 0. ||
|#

## MaintenanceWindowSlot {#yandex.cloud.mdb.v1.MaintenanceWindowSlot}

#|
||Field | Description ||
|| day | **enum** (DayOfWeek)

Day of the week.

- `MONDAY`: The day-of-week of Monday.
- `TUESDAY`: The day-of-week of Tuesday.
- `WEDNESDAY`: The day-of-week of Wednesday.
- `THURSDAY`: The day-of-week of Thursday.
- `FRIDAY`: The day-of-week of Friday.
- `SATURDAY`: The day-of-week of Saturday.
- `SUNDAY`: The day-of-week of Sunday. ||
|| startTime | **[TimeOfDay](#google.type.TimeOfDay)**

Required field. Start time in UTC. ||
|| duration | **string** (duration)

Required field. Slot duration. ||
|| allowTemporaryUnavailability | **boolean**

Allows maintenance operations that may cause temporary write unavailability. ||
|#