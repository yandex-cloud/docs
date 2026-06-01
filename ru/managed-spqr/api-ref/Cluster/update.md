---
editable: false
apiPlayground:
  - url: https://{{ api-host-mdb }}/managed-spqr/v1/clusters/{clusterId}
    method: patch
    path:
      type: object
      properties:
        clusterId:
          description: |-
            **string**
            Required field. ID of the SPQR Cluster resource to update.
            To get the SPQR cluster ID use a [ClusterService.List](/docs/managed-spqr/api-ref/Cluster/list#List) request.
            The maximum string length in characters is 50.
          type: string
      required:
        - clusterId
      additionalProperties: false
    query: null
    body:
      type: object
      properties:
        updateMask:
          description: |-
            **string** (field-mask)
            A comma-separated names off ALL fields to be updated.
            Only the specified fields will be changed. The others will be left untouched.
            If the field is specified in `` updateMask `` and no value for that field was sent in the request,
            the field's value will be reset to the default. The default value for most fields is null or 0.
            If `` updateMask `` is not sent in the request, all fields' values will be updated.
            Fields specified in the request will be updated to provided values.
            The rest of the fields will be reset to the default.
          type: string
          format: field-mask
        name:
          description: |-
            **string**
            New name for the cluster.
            The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
          pattern: '[a-zA-Z0-9_-]*'
          type: string
        description:
          description: |-
            **string**
            New description of the SPQR cluster.
            The maximum string length in characters is 256.
          type: string
        labels:
          description: |-
            **object** (map<**string**, **string**>)
            Custom labels for the SPQR cluster as `` key:value `` pairs. Maximum 64 per resource.
            For example, "project": "mvp" or "source": "dictionary".
            The new set of labels will completely replace the old ones. To add a label, request the current
            set with the [ClusterService.Get](/docs/managed-spqr/api-ref/Cluster/get#Get) method, then send an [ClusterService.Update](#Update) request with the new label added to the set.
            The maximum string length in characters for each value is 63. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_./\@0-9a-z]* `. Each value must match the regular expression ` [-_./\@0-9a-z]* `. No more than 64 per resource.
          type: object
          additionalProperties:
            type: string
            pattern: '[-_./\@0-9a-z]*'
            maxLength: 63
          propertyNames:
            type: string
            pattern: '[a-z][-_./\@0-9a-z]*'
            maxLength: 63
            minLength: 1
          maxProperties: 64
        configSpec:
          description: |-
            **[ConfigSpec](#yandex.cloud.mdb.spqr.v1.ConfigSpec)**
            New configuration and resources for hosts in the cluster.
          $ref: '#/definitions/ConfigSpec'
        maintenanceWindow:
          description: |-
            **[MaintenanceWindow](#yandex.cloud.mdb.spqr.v1.MaintenanceWindow)**
            New maintenance window settings for the cluster.
          $ref: '#/definitions/MaintenanceWindow'
        securityGroupIds:
          description: |-
            **string**
            User security groups
          type: array
          items:
            type: string
        deletionProtection:
          description: |-
            **boolean**
            Deletion Protection inhibits deletion of the cluster
          type: boolean
        networkId:
          description: |-
            **string**
            ID of the network to move the cluster to.
            The maximum string length in characters is 150.
          type: string
      additionalProperties: false
    definitions:
      RouterSettings:
        type: object
        properties:
          showNoticeMessages:
            description: '**boolean**'
            type: boolean
          timeQuantiles:
            description: '**string**'
            type: array
            items:
              type: string
          defaultRouteBehavior:
            description: |-
              **enum** (DefaultRouteBehavior)
              - `BLOCK`
              - `ALLOW`
            type: string
            enum:
              - DEFAULT_ROUTE_BEHAVIOR_UNSPECIFIED
              - BLOCK
              - ALLOW
          preferSameAvailabilityZone:
            description: '**boolean**'
            type: boolean
          enhancedMultishardProcessing:
            description: '**boolean**'
            type: boolean
          defaultTargetSessionAttrs:
            description: |-
              **enum** (TargetSessionAttrs)
              - `READ_WRITE`
              - `SMART_READ_WRITE`
              - `READ_ONLY`
              - `PREFER_STANDBY`
              - `ANY`
            type: string
            enum:
              - TARGET_SESSION_ATTRS_UNSPECIFIED
              - READ_WRITE
              - SMART_READ_WRITE
              - READ_ONLY
              - PREFER_STANDBY
              - ANY
          defaultCommitStrategy:
            description: |-
              **enum** (CommitStrategy)
              - `BEST_EFFORT`
              - `ONE_PC`
              - `TWO_PC`
            type: string
            enum:
              - COMMIT_STRATEGY_UNSPECIFIED
              - BEST_EFFORT
              - ONE_PC
              - TWO_PC
      Resources:
        type: object
        properties:
          resourcePresetId:
            description: |-
              **string**
              ID of the preset for computational resources available to a host (CPU, memory etc.).
              All available presets are listed in the [documentation](/docs/managed-spqr/concepts/instance-types).
            type: string
          diskSize:
            description: |-
              **string** (int64)
              Volume of the storage available to a host, in bytes.
            type: string
            format: int64
          diskTypeId:
            description: |-
              **string**
              Type of the storage environment for the host.
              Possible values:
              * network-hdd - network HDD drive,
              * network-ssd - network SSD drive,
              * local-ssd - local SSD storage.
            type: string
      Router:
        type: object
        properties:
          config:
            description: |-
              **[RouterSettings](#yandex.cloud.mdb.spqr.v1.RouterSettings)**
              Configuration for router hosts.
            $ref: '#/definitions/RouterSettings'
          resources:
            description: |-
              **[Resources](#yandex.cloud.mdb.spqr.v1.Resources)**
              Resources allocated to each host.
            $ref: '#/definitions/Resources'
      CoordinatorSettings:
        type: object
        properties: {}
      Coordinator:
        type: object
        properties:
          config:
            description: |-
              **object**
              Configuration for coordinator hosts.
            $ref: '#/definitions/CoordinatorSettings'
          resources:
            description: |-
              **[Resources](#yandex.cloud.mdb.spqr.v1.Resources)**
              Resources allocated to each host.
            $ref: '#/definitions/Resources'
      PostgreSQLSettings:
        type: object
        properties: {}
      PostgreSQL:
        type: object
        properties:
          config:
            description: |-
              **object**
              Configuration for PostgreSQL hosts.
            $ref: '#/definitions/PostgreSQLSettings'
          resources:
            description: |-
              **[Resources](#yandex.cloud.mdb.spqr.v1.Resources)**
              Resources allocated to each host.
            $ref: '#/definitions/Resources'
      Infra:
        type: object
        properties:
          resources:
            description: |-
              **[Resources](#yandex.cloud.mdb.spqr.v1.Resources)**
              Resources allocated to each host
            $ref: '#/definitions/Resources'
          router:
            description: |-
              **[RouterSettings](#yandex.cloud.mdb.spqr.v1.RouterSettings)**
              Router related configuration
            $ref: '#/definitions/RouterSettings'
          coordinator:
            description: |-
              **object**
              Coordinator related configuration
            $ref: '#/definitions/CoordinatorSettings'
      BalancerSettings:
        type: object
        properties:
          cpuThreshold:
            description: '**number** (double)'
            type: number
            format: double
          spaceThreshold:
            description: '**number** (double)'
            type: number
            format: double
          statIntervalSec:
            description: '**string** (int64)'
            type: string
            format: int64
          maxMoveCount:
            description: '**string** (int64)'
            type: string
            format: int64
          keysPerMove:
            description: '**string** (int64)'
            type: string
            format: int64
          timeout:
            description: '**string** (int64)'
            type: string
            format: int64
      SpqrSpec:
        type: object
        properties:
          router:
            description: |-
              **[Router](#yandex.cloud.mdb.spqr.v1.SpqrSpec.Router)**
              Configuration and resource allocation for SPQR Router hosts.
            $ref: '#/definitions/Router'
          coordinator:
            description: |-
              **[Coordinator](#yandex.cloud.mdb.spqr.v1.SpqrSpec.Coordinator)**
              Configuration and resource allocation for SPQR Coordinator hosts.
            $ref: '#/definitions/Coordinator'
          postgresql:
            description: |-
              **[PostgreSQL](#yandex.cloud.mdb.spqr.v1.SpqrSpec.PostgreSQL)**
              Configuration and resource allocation for PostgreSQL hosts.
            $ref: '#/definitions/PostgreSQL'
          infra:
            description: |-
              **[Infra](#yandex.cloud.mdb.spqr.v1.SpqrSpec.Infra)**
              Configuration and resource allocation for SPQR Infra (router+coordinator) hosts.
            $ref: '#/definitions/Infra'
          consolePassword:
            description: |-
              **string**
              Password of the SPQR console.
            type: string
          logLevel:
            description: |-
              **enum** (LogLevel)
              - `DEBUG`
              - `INFO`
              - `WARNING`
              - `ERROR`
              - `FATAL`
            type: string
            enum:
              - LOG_LEVEL_UNSPECIFIED
              - DEBUG
              - INFO
              - WARNING
              - ERROR
              - FATAL
          balancer:
            description: |-
              **[BalancerSettings](#yandex.cloud.mdb.spqr.v1.BalancerSettings)**
              Configuration for SPQR Balancer.
            $ref: '#/definitions/BalancerSettings'
      TimeOfDay:
        type: object
        properties:
          hours:
            description: |-
              **integer** (int32)
              Hours of day in 24 hour format. Should be from 0 to 23. An API may choose
              to allow the value "24:00:00" for scenarios like business closing time.
            type: integer
            format: int32
          minutes:
            description: |-
              **integer** (int32)
              Minutes of hour of day. Must be from 0 to 59.
            type: integer
            format: int32
          seconds:
            description: |-
              **integer** (int32)
              Seconds of minutes of the time. Must normally be from 0 to 59. An API may
              allow the value 60 if it allows leap-seconds.
            type: integer
            format: int32
          nanos:
            description: |-
              **integer** (int32)
              Fractions of seconds in nanoseconds. Must be from 0 to 999,999,999.
            type: integer
            format: int32
      Access:
        type: object
        properties:
          dataLens:
            description: |-
              **boolean**
              Allow access for DataLens.
            type: boolean
          webSql:
            description: |-
              **boolean**
              Allow access for Web SQL.
            type: boolean
          dataTransfer:
            description: |-
              **boolean**
              Allow access for DataTransfer.
            type: boolean
          serverless:
            description: |-
              **boolean**
              Allow access for Serverless.
              NOTE: Do not propagate to public API until Serverless integration is required.
            type: boolean
      ConfigSpec:
        type: object
        properties:
          spqrSpec:
            description: |-
              **[SpqrSpec](#yandex.cloud.mdb.spqr.v1.SpqrSpec)**
              Configuration and resource allocation for a SPQR Beta cluster.
            $ref: '#/definitions/SpqrSpec'
          backupWindowStart:
            description: |-
              **[TimeOfDay](#google.type.TimeOfDay)**
              Time to start the daily backup, in the UTC timezone.
            $ref: '#/definitions/TimeOfDay'
          backupRetainPeriodDays:
            description: |-
              **string** (int64)
              Retain period of automatically created backup in days
            type: string
            format: int64
          access:
            description: |-
              **[Access](#yandex.cloud.mdb.spqr.v1.Access)**
              Access policy to DB
            $ref: '#/definitions/Access'
          soxAudit:
            description: '**boolean**'
            type: boolean
      AnytimeMaintenanceWindow:
        type: object
        properties: {}
      WeeklyMaintenanceWindow:
        type: object
        properties:
          day:
            description: |-
              **enum** (WeekDay)
              Day of the week (in `DDD` format).
              - `MON`
              - `TUE`
              - `WED`
              - `THU`
              - `FRI`
              - `SAT`
              - `SUN`
            type: string
            enum:
              - WEEK_DAY_UNSPECIFIED
              - MON
              - TUE
              - WED
              - THU
              - FRI
              - SAT
              - SUN
          hour:
            description: |-
              **string** (int64)
              Hour of the day in UTC (in `HH` format).
              Acceptable values are 1 to 24, inclusive.
            type: string
            format: int64
      MaintenanceWindow:
        type: object
        properties:
          anytime:
            description: |-
              **object**
              Maintenance operation can be scheduled anytime.
              Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`.
              The maintenance policy in effect.
            $ref: '#/definitions/AnytimeMaintenanceWindow'
          weeklyMaintenanceWindow:
            description: |-
              **[WeeklyMaintenanceWindow](#yandex.cloud.mdb.spqr.v1.WeeklyMaintenanceWindow)**
              Maintenance operation can be scheduled on a weekly basis.
              Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`.
              The maintenance policy in effect.
            $ref: '#/definitions/WeeklyMaintenanceWindow'
        oneOf:
          - required:
              - anytime
          - required:
              - weeklyMaintenanceWindow
---

# Managed Service for SPQR API, REST: Cluster.Update

Updates the specified SPQR cluster.

## HTTP request

```
PATCH https://{{ api-host-mdb }}/managed-spqr/v1/clusters/{clusterId}
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the SPQR Cluster resource to update.
To get the SPQR cluster ID use a [ClusterService.List](/docs/managed-spqr/api-ref/Cluster/list#List) request.

The maximum string length in characters is 50. ||
|#

## Body parameters {#yandex.cloud.mdb.spqr.v1.UpdateClusterRequest}

```json
{
  "updateMask": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "configSpec": {
    "spqrSpec": {
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
          "defaultCommitStrategy": "string"
        },
        "resources": {
          "resourcePresetId": "string",
          "diskSize": "string",
          "diskTypeId": "string"
        }
      },
      "coordinator": {
        "config": "object",
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
          "defaultCommitStrategy": "string"
        },
        "coordinator": "object"
      },
      "consolePassword": "string",
      "logLevel": "string",
      "balancer": {
        "cpuThreshold": "number",
        "spaceThreshold": "number",
        "statIntervalSec": "string",
        "maxMoveCount": "string",
        "keysPerMove": "string",
        "timeout": "string"
      }
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
  "maintenanceWindow": {
    // Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`
    "anytime": "object",
    "weeklyMaintenanceWindow": {
      "day": "string",
      "hour": "string"
    }
    // end of the list of possible fields
  },
  "securityGroupIds": [
    "string"
  ],
  "deletionProtection": "boolean",
  "networkId": "string"
}
```

#|
||Field | Description ||
|| updateMask | **string** (field-mask)

A comma-separated names off ALL fields to be updated.
Only the specified fields will be changed. The others will be left untouched.
If the field is specified in `` updateMask `` and no value for that field was sent in the request,
the field's value will be reset to the default. The default value for most fields is null or 0.

If `` updateMask `` is not sent in the request, all fields' values will be updated.
Fields specified in the request will be updated to provided values.
The rest of the fields will be reset to the default. ||
|| name | **string**

New name for the cluster.

The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `. ||
|| description | **string**

New description of the SPQR cluster.

The maximum string length in characters is 256. ||
|| labels | **object** (map<**string**, **string**>)

Custom labels for the SPQR cluster as `` key:value `` pairs. Maximum 64 per resource.
For example, "project": "mvp" or "source": "dictionary".
The new set of labels will completely replace the old ones. To add a label, request the current
set with the [ClusterService.Get](/docs/managed-spqr/api-ref/Cluster/get#Get) method, then send an [ClusterService.Update](#Update) request with the new label added to the set.

The maximum string length in characters for each value is 63. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_./\@0-9a-z]* `. Each value must match the regular expression ` [-_./\@0-9a-z]* `. No more than 64 per resource. ||
|| configSpec | **[ConfigSpec](#yandex.cloud.mdb.spqr.v1.ConfigSpec)**

New configuration and resources for hosts in the cluster. ||
|| maintenanceWindow | **[MaintenanceWindow](#yandex.cloud.mdb.spqr.v1.MaintenanceWindow)**

New maintenance window settings for the cluster. ||
|| securityGroupIds[] | **string**

User security groups ||
|| deletionProtection | **boolean**

Deletion Protection inhibits deletion of the cluster ||
|| networkId | **string**

ID of the network to move the cluster to.

The maximum string length in characters is 150. ||
|#

## ConfigSpec {#yandex.cloud.mdb.spqr.v1.ConfigSpec}

#|
||Field | Description ||
|| spqrSpec | **[SpqrSpec](#yandex.cloud.mdb.spqr.v1.SpqrSpec)**

Configuration and resource allocation for a SPQR Beta cluster. ||
|| backupWindowStart | **[TimeOfDay](#google.type.TimeOfDay)**

Time to start the daily backup, in the UTC timezone. ||
|| backupRetainPeriodDays | **string** (int64)

Retain period of automatically created backup in days ||
|| access | **[Access](#yandex.cloud.mdb.spqr.v1.Access)**

Access policy to DB ||
|| soxAudit | **boolean** ||
|#

## SpqrSpec {#yandex.cloud.mdb.spqr.v1.SpqrSpec}

#|
||Field | Description ||
|| router | **[Router](#yandex.cloud.mdb.spqr.v1.SpqrSpec.Router)**

Configuration and resource allocation for SPQR Router hosts. ||
|| coordinator | **[Coordinator](#yandex.cloud.mdb.spqr.v1.SpqrSpec.Coordinator)**

Configuration and resource allocation for SPQR Coordinator hosts. ||
|| postgresql | **[PostgreSQL](#yandex.cloud.mdb.spqr.v1.SpqrSpec.PostgreSQL)**

Configuration and resource allocation for PostgreSQL hosts. ||
|| infra | **[Infra](#yandex.cloud.mdb.spqr.v1.SpqrSpec.Infra)**

Configuration and resource allocation for SPQR Infra (router+coordinator) hosts. ||
|| consolePassword | **string**

Password of the SPQR console. ||
|| logLevel | **enum** (LogLevel)

- `DEBUG`
- `INFO`
- `WARNING`
- `ERROR`
- `FATAL` ||
|| balancer | **[BalancerSettings](#yandex.cloud.mdb.spqr.v1.BalancerSettings)**

Configuration for SPQR Balancer. ||
|#

## Router {#yandex.cloud.mdb.spqr.v1.SpqrSpec.Router}

#|
||Field | Description ||
|| config | **[RouterSettings](#yandex.cloud.mdb.spqr.v1.RouterSettings)**

Configuration for router hosts. ||
|| resources | **[Resources](#yandex.cloud.mdb.spqr.v1.Resources)**

Resources allocated to each host. ||
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

## Coordinator {#yandex.cloud.mdb.spqr.v1.SpqrSpec.Coordinator}

#|
||Field | Description ||
|| config | **object**

Configuration for coordinator hosts. ||
|| resources | **[Resources](#yandex.cloud.mdb.spqr.v1.Resources)**

Resources allocated to each host. ||
|#

## PostgreSQL {#yandex.cloud.mdb.spqr.v1.SpqrSpec.PostgreSQL}

#|
||Field | Description ||
|| config | **object**

Configuration for PostgreSQL hosts. ||
|| resources | **[Resources](#yandex.cloud.mdb.spqr.v1.Resources)**

Resources allocated to each host. ||
|#

## Infra {#yandex.cloud.mdb.spqr.v1.SpqrSpec.Infra}

#|
||Field | Description ||
|| resources | **[Resources](#yandex.cloud.mdb.spqr.v1.Resources)**

Resources allocated to each host ||
|| router | **[RouterSettings](#yandex.cloud.mdb.spqr.v1.RouterSettings)**

Router related configuration ||
|| coordinator | **object**

Coordinator related configuration ||
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
  "metadata": "object",
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": "object"
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
|| metadata | **object**

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
|| response | **object**

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