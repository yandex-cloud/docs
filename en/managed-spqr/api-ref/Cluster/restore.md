---
editable: false
apiPlayground:
  - url: https://{{ api-host-mdb }}/managed-spqr/v1/clusters:restore
    method: post
    path: null
    query: null
    body:
      type: object
      properties:
        backupId:
          description: |-
            **string**
            Required field. ID of the backup to create a cluster from.
            To get the backup ID, use a [ClusterService.ListBackups](/docs/managed-spqr/api-ref/Cluster/listBackups#ListBackups) request.
          type: string
        name:
          description: |-
            **string**
            Required field. Name of the new SPQR cluster. The name must be unique within the folder.
            The name can't be changed after the SPQR cluster is created.
          pattern: '[a-zA-Z0-9_-]*'
          type: string
        description:
          description: |-
            **string**
            Description of the new SPQR cluster.
          type: string
        labels:
          description: |-
            **object** (map<**string**, **string**>)
            Custom labels for the SPQR cluster as `` key:value `` pairs. Maximum 64 per resource.
            For example, "project": "mvp" or "source": "dictionary".
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
        environment:
          description: |-
            **enum** (Environment)
            Required field. Deployment environment of the new SPQR cluster.
            - `ENVIRONMENT_UNSPECIFIED`
            - `PRODUCTION`: Stable environment with a conservative update policy: only hotfixes
            are applied during regular maintenance.
            - `PRESTABLE`: Environment with more aggressive update policy: new versions
            are rolled out irrespective of backward compatibility.
          type: string
          enum:
            - ENVIRONMENT_UNSPECIFIED
            - PRODUCTION
            - PRESTABLE
        configSpec:
          description: |-
            **[ConfigSpec](#yandex.cloud.mdb.spqr.v1.ConfigSpec)**
            Required field. Configuration for the SPQR cluster to be created.
          $ref: '#/definitions/ConfigSpec'
        hostSpecs:
          description: |-
            **[HostSpec](#yandex.cloud.mdb.spqr.v1.HostSpec)**
            Configurations for SPQR hosts that should be created for
            the cluster that is being created from the backup.
          type: array
          items:
            $ref: '#/definitions/HostSpec'
        networkId:
          description: |-
            **string**
            Required field. ID of the network to create the SPQR cluster in.
          type: string
        folderId:
          description: |-
            **string**
            Required. ID of the folder to create the SPQR cluster in.
          type: string
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
        time:
          description: |-
            **string** (date-time)
            Timestamp of the moment to which the SPQR cluster should be restored.
            String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
            `0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.
            To work with values in this field, use the APIs described in the
            [Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
            In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).
          type: string
          format: date-time
        timeInclusive:
          description: |-
            **boolean**
            Flag that indicates whether a database should be restored to the first backup point
            available just after the timestamp specified in the `time` field instead of just before.
            Possible values:
            * false (default) - the restore point refers to the first backup moment before `time`.
            * true - the restore point refers to the first backup point after `time`.
          type: boolean
      required:
        - backupId
        - name
        - environment
        - configSpec
        - networkId
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
              - `DEFAULT_ROUTE_BEHAVIOR_UNSPECIFIED`
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
              - `LOG_LEVEL_UNSPECIFIED`
              - `DEBUG`
              - `INFO`
              - `WARNING`
              - `ERROR`
              - `FATAL`
              - `PANIC`
            type: string
            enum:
              - LOG_LEVEL_UNSPECIFIED
              - DEBUG
              - INFO
              - WARNING
              - ERROR
              - FATAL
              - PANIC
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
      MDBPostgreSQL:
        type: object
        properties:
          clusterId:
            description: |-
              **string**
              Required field. 
            type: string
        required:
          - clusterId
      HostSpec:
        type: object
        properties:
          zoneId:
            description: |-
              **string**
              ID of the availability zone where the host resides.
              To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/api-ref/Zone/list#List) request.
            type: string
          subnetId:
            description: |-
              **string**
              ID of the subnet that the host should belong to. This subnet should be a part
              of the network that the cluster belongs to.
              The network ID is set in the [Cluster.networkId](#yandex.cloud.mdb.spqr.v1.Cluster) field.
            type: string
          assignPublicIp:
            description: |-
              **boolean**
              Whether the host should get a public IP address on creation.
              After a host has been created, this setting cannot be changed. To remove an assigned public IP, or to assign
              a public IP to a host without one, recreate the host with [assignPublicIp](/docs/managed-spqr/api-ref/Cluster/updateHosts#yandex.cloud.mdb.spqr.v1.UpdateHostSpec) set as needed.
              Possible values:
              * false - don't assign a public IP to the host.
              * true - the host should have a public IP address.
            type: boolean
          type:
            description: |-
              **enum** (Type)
              Required field. Type of the host to be deployed.
              - `TYPE_UNSPECIFIED`
              - `ROUTER`: A SPQR Router host.
              - `COORDINATOR`: A SPQR Coordinator host.
              - `INFRA`: A SPQR Infra host (router+coordinator)
              - `POSTGRESQL`: A PostgreSQL host.
              - `EXTERNAL_POSTGRESQL`: An External PostgreSQL host.
              - `MDB_POSTGRESQL`: A Managed PostgreSQL host
            type: string
            enum:
              - TYPE_UNSPECIFIED
              - ROUTER
              - COORDINATOR
              - INFRA
              - POSTGRESQL
              - EXTERNAL_POSTGRESQL
              - MDB_POSTGRESQL
          shardName:
            description: |-
              **string**
              Name of the shard that the host belongs to.
              If empty, host doesn't belong to any shard
            pattern: '[a-zA-Z0-9_-]*'
            type: string
          mdbPostgresql:
            description: '**[MDBPostgreSQL](#yandex.cloud.mdb.spqr.v1.MDBPostgreSQL)**'
            $ref: '#/definitions/MDBPostgreSQL'
        required:
          - type
sourcePath: en/_api-ref/mdb/spqr/v1/api-ref/Cluster/restore.md
---

# Managed Service for SPQR API, REST: Cluster.Restore

Creates a new SPQR cluster using the specified backup.

## HTTP request

```
POST https://{{ api-host-mdb }}/managed-spqr/v1/clusters:restore
```

## Body parameters {#yandex.cloud.mdb.spqr.v1.RestoreClusterRequest}

```json
{
  "backupId": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "environment": "string",
  "configSpec": {
    "spqrSpec": {
      "router": {
        "config": {
          "showNoticeMessages": "boolean",
          "timeQuantiles": [
            "string"
          ],
          "defaultRouteBehavior": "string",
          "preferSameAvailabilityZone": "boolean"
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
          "preferSameAvailabilityZone": "boolean"
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
  "hostSpecs": [
    {
      "zoneId": "string",
      "subnetId": "string",
      "assignPublicIp": "boolean",
      "type": "string",
      "shardName": "string",
      "mdbPostgresql": {
        "clusterId": "string"
      }
    }
  ],
  "networkId": "string",
  "folderId": "string",
  "securityGroupIds": [
    "string"
  ],
  "deletionProtection": "boolean",
  "time": "string",
  "timeInclusive": "boolean"
}
```

#|
||Field | Description ||
|| backupId | **string**

Required field. ID of the backup to create a cluster from.
To get the backup ID, use a [ClusterService.ListBackups](/docs/managed-spqr/api-ref/Cluster/listBackups#ListBackups) request. ||
|| name | **string**

Required field. Name of the new SPQR cluster. The name must be unique within the folder.
The name can't be changed after the SPQR cluster is created. ||
|| description | **string**

Description of the new SPQR cluster. ||
|| labels | **object** (map<**string**, **string**>)

Custom labels for the SPQR cluster as `` key:value `` pairs. Maximum 64 per resource.
For example, "project": "mvp" or "source": "dictionary". ||
|| environment | **enum** (Environment)

Required field. Deployment environment of the new SPQR cluster.

- `ENVIRONMENT_UNSPECIFIED`
- `PRODUCTION`: Stable environment with a conservative update policy: only hotfixes
are applied during regular maintenance.
- `PRESTABLE`: Environment with more aggressive update policy: new versions
are rolled out irrespective of backward compatibility. ||
|| configSpec | **[ConfigSpec](#yandex.cloud.mdb.spqr.v1.ConfigSpec)**

Required field. Configuration for the SPQR cluster to be created. ||
|| hostSpecs[] | **[HostSpec](#yandex.cloud.mdb.spqr.v1.HostSpec)**

Configurations for SPQR hosts that should be created for
the cluster that is being created from the backup. ||
|| networkId | **string**

Required field. ID of the network to create the SPQR cluster in. ||
|| folderId | **string**

Required. ID of the folder to create the SPQR cluster in. ||
|| securityGroupIds[] | **string**

User security groups ||
|| deletionProtection | **boolean**

Deletion Protection inhibits deletion of the cluster ||
|| time | **string** (date-time)

Timestamp of the moment to which the SPQR cluster should be restored.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| timeInclusive | **boolean**

Flag that indicates whether a database should be restored to the first backup point
available just after the timestamp specified in the `time` field instead of just before.

Possible values:
* false (default) - the restore point refers to the first backup moment before `time`.
* true - the restore point refers to the first backup point after `time`. ||
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

- `LOG_LEVEL_UNSPECIFIED`
- `DEBUG`
- `INFO`
- `WARNING`
- `ERROR`
- `FATAL`
- `PANIC` ||
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

- `DEFAULT_ROUTE_BEHAVIOR_UNSPECIFIED`
- `BLOCK`
- `ALLOW` ||
|| preferSameAvailabilityZone | **boolean** ||
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

## HostSpec {#yandex.cloud.mdb.spqr.v1.HostSpec}

#|
||Field | Description ||
|| zoneId | **string**

ID of the availability zone where the host resides.
To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/api-ref/Zone/list#List) request. ||
|| subnetId | **string**

ID of the subnet that the host should belong to. This subnet should be a part
of the network that the cluster belongs to.
The network ID is set in the [Cluster.networkId](#yandex.cloud.mdb.spqr.v1.Cluster) field. ||
|| assignPublicIp | **boolean**

Whether the host should get a public IP address on creation.

After a host has been created, this setting cannot be changed. To remove an assigned public IP, or to assign
a public IP to a host without one, recreate the host with `assignPublicIp` set as needed.

Possible values:
* false - don't assign a public IP to the host.
* true - the host should have a public IP address. ||
|| type | **enum** (Type)

Required field. Type of the host to be deployed.

- `TYPE_UNSPECIFIED`
- `ROUTER`: A SPQR Router host.
- `COORDINATOR`: A SPQR Coordinator host.
- `INFRA`: A SPQR Infra host (router+coordinator)
- `POSTGRESQL`: A PostgreSQL host.
- `EXTERNAL_POSTGRESQL`: An External PostgreSQL host.
- `MDB_POSTGRESQL`: A Managed PostgreSQL host ||
|| shardName | **string**

Name of the shard that the host belongs to.
If empty, host doesn't belong to any shard ||
|| mdbPostgresql | **[MDBPostgreSQL](#yandex.cloud.mdb.spqr.v1.MDBPostgreSQL)** ||
|#

## MDBPostgreSQL {#yandex.cloud.mdb.spqr.v1.MDBPostgreSQL}

TODO move to hosts.proto when it's created
Configuration for MDB PostgreSQL host

#|
||Field | Description ||
|| clusterId | **string**

Required field.  ||
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
    "backupId": "string"
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
            "preferSameAvailabilityZone": "boolean"
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
            "preferSameAvailabilityZone": "boolean"
          },
          "coordinator": "object"
        },
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
    "deletionProtection": "boolean"
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
|| metadata | **[RestoreClusterMetadata](#yandex.cloud.mdb.spqr.v1.RestoreClusterMetadata)**

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
|| response | **[Cluster](#yandex.cloud.mdb.spqr.v1.Cluster)**

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

## RestoreClusterMetadata {#yandex.cloud.mdb.spqr.v1.RestoreClusterMetadata}

#|
||Field | Description ||
|| clusterId | **string**

ID of the new SPQR cluster that is being created from a backup. ||
|| backupId | **string**

ID of the backup that is being used for creating a cluster. ||
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

## Cluster {#yandex.cloud.mdb.spqr.v1.Cluster}

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

- `ENVIRONMENT_UNSPECIFIED`
- `PRODUCTION`: Stable environment with a conservative update policy: only hotfixes
are applied during regular maintenance.
- `PRESTABLE`: Environment with more aggressive update policy: new versions
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

Maintenance window for the cluster. ||
|| plannedOperation | **[MaintenanceOperation](#yandex.cloud.mdb.spqr.v1.MaintenanceOperation)**

Planned maintenance operation to be started for the cluster within the nearest `maintenanceWindow`. ||
|| securityGroupIds[] | **string**

User security groups ||
|| deletionProtection | **boolean**

Deletion Protection inhibits deletion of the cluster ||
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
|| backupWindowStart | **[TimeOfDay](#google.type.TimeOfDay2)**

Time to start the daily backup, in the UTC timezone. ||
|| backupRetainPeriodDays | **string** (int64)

Retain period of automatically created backup in days ||
|| access | **[Access](#yandex.cloud.mdb.spqr.v1.Access2)**

Access policy to DB ||
|| soxAudit | **boolean** ||
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
|| logLevel | **enum** (LogLevel)

SPQR default log level

- `LOG_LEVEL_UNSPECIFIED`
- `DEBUG`
- `INFO`
- `WARNING`
- `ERROR`
- `FATAL`
- `PANIC` ||
|| balancer | **[BalancerSettings](#yandex.cloud.mdb.spqr.v1.BalancerSettings2)**

SPQR Balancer settings. ||
|#

## RouterConfig {#yandex.cloud.mdb.spqr.v1.RouterConfig}

#|
||Field | Description ||
|| config | **[RouterSettings](#yandex.cloud.mdb.spqr.v1.RouterSettings2)** ||
|| resources | **[Resources](#yandex.cloud.mdb.spqr.v1.Resources2)** ||
|#

## RouterSettings {#yandex.cloud.mdb.spqr.v1.RouterSettings2}

Configuration of a SPQR router.

#|
||Field | Description ||
|| showNoticeMessages | **boolean** ||
|| timeQuantiles[] | **string** ||
|| defaultRouteBehavior | **enum** (DefaultRouteBehavior)

- `DEFAULT_ROUTE_BEHAVIOR_UNSPECIFIED`
- `BLOCK`
- `ALLOW` ||
|| preferSameAvailabilityZone | **boolean** ||
|#

## Resources {#yandex.cloud.mdb.spqr.v1.Resources2}

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
|| config | **object** ||
|| resources | **[Resources](#yandex.cloud.mdb.spqr.v1.Resources2)** ||
|#

## PostgreSQLConfig {#yandex.cloud.mdb.spqr.v1.PostgreSQLConfig}

#|
||Field | Description ||
|| config | **object** ||
|| resources | **[Resources](#yandex.cloud.mdb.spqr.v1.Resources2)** ||
|#

## InfraConfig {#yandex.cloud.mdb.spqr.v1.InfraConfig}

#|
||Field | Description ||
|| resources | **[Resources](#yandex.cloud.mdb.spqr.v1.Resources2)** ||
|| router | **[RouterSettings](#yandex.cloud.mdb.spqr.v1.RouterSettings2)** ||
|| coordinator | **object** ||
|#

## BalancerSettings {#yandex.cloud.mdb.spqr.v1.BalancerSettings2}

#|
||Field | Description ||
|| cpuThreshold | **number** (double) ||
|| spaceThreshold | **number** (double) ||
|| statIntervalSec | **string** (int64) ||
|| maxMoveCount | **string** (int64) ||
|| keysPerMove | **string** (int64) ||
|| timeout | **string** (int64) ||
|#

## TimeOfDay {#google.type.TimeOfDay2}

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

## Access {#yandex.cloud.mdb.spqr.v1.Access2}

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

- `WEEK_DAY_UNSPECIFIED`
- `MON`
- `TUE`
- `WED`
- `THU`
- `FRI`
- `SAT`
- `SUN` ||
|| hour | **string** (int64)

Hour of the day in UTC (in `HH` format). ||
|#

## MaintenanceOperation {#yandex.cloud.mdb.spqr.v1.MaintenanceOperation}

A planned maintenance operation.

#|
||Field | Description ||
|| info | **string**

Information about this maintenance operation. ||
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