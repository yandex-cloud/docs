---
editable: false
apiPlayground:
  - url: https://{{ api-host-mdb }}/managed-spqr/v1/clusters
    method: get
    path: null
    query:
      type: object
      properties:
        folderId:
          description: |-
            **string**
            Required field. ID of the folder to list SPQR clusters in.
            To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/Folder/list#List) request.
          type: string
        pageSize:
          description: |-
            **string** (int64)
            The maximum number of results per page to return. If the number of available
            results is larger than `pageSize`, the service returns a [ListClustersResponse.nextPageToken](#yandex.cloud.mdb.spqr.v1.ListClustersResponse)
            that can be used to get the next page of results in subsequent list requests.
            Acceptable values are 0 to 1000, inclusive. Default value: 100.
          default: '100'
          type: string
          format: int64
        pageToken:
          description: |-
            **string**
            Page token. To get the next page of results, set `pageToken`
            to the [ListClustersResponse.nextPageToken](#yandex.cloud.mdb.spqr.v1.ListClustersResponse) returned by the previous list request.
          type: string
        filter:
          description: |-
            **string**
            A filter expression that filters resources listed in the response.
            The expression must specify:
            1. The field name. Currently you can only use filtering with the [Cluster.name](#yandex.cloud.mdb.spqr.v1.Cluster) field.
            2. An `=` operator.
            3. The value in double quotes (`"`). Must be 1-63 characters long and match the regular expression `[a-zA-Z0-9_-]+`.
          type: string
      required:
        - folderId
      additionalProperties: false
    body: null
    definitions: null
---

# Managed Service for SPQR API, REST: Cluster.List

Retrieves the list of SPQR Cluster resources that belong
to the specified folder.

## HTTP request

```
GET https://{{ api-host-mdb }}/managed-spqr/v1/clusters
```

## Query parameters {#yandex.cloud.mdb.spqr.v1.ListClustersRequest}

#|
||Field | Description ||
|| folderId | **string**

Required field. ID of the folder to list SPQR clusters in.
To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/Folder/list#List) request. ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`, the service returns a [ListClustersResponse.nextPageToken](#yandex.cloud.mdb.spqr.v1.ListClustersResponse)
that can be used to get the next page of results in subsequent list requests.
Acceptable values are 0 to 1000, inclusive. Default value: 100. ||
|| pageToken | **string**

Page token. To get the next page of results, set `pageToken`
to the [ListClustersResponse.nextPageToken](#yandex.cloud.mdb.spqr.v1.ListClustersResponse) returned by the previous list request. ||
|| filter | **string**

A filter expression that filters resources listed in the response.
The expression must specify:
1. The field name. Currently you can only use filtering with the [Cluster.name](#yandex.cloud.mdb.spqr.v1.Cluster) field.
2. An `=` operator.
3. The value in double quotes (`"`). Must be 1-63 characters long and match the regular expression `[a-zA-Z0-9_-]+`. ||
|#

## Response {#yandex.cloud.mdb.spqr.v1.ListClustersResponse}

**HTTP Code: 200 - OK**

```json
{
  "clusters": [
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
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| clusters[] | **[Cluster](#yandex.cloud.mdb.spqr.v1.Cluster)**

List of SPQR Cluster resources. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListClustersRequest.pageSize](#yandex.cloud.mdb.spqr.v1.ListClustersRequest), use the `nextPageToken` as the value
for the [ListClustersRequest.pageToken](#yandex.cloud.mdb.spqr.v1.ListClustersRequest) parameter in the next list request. Each subsequent
list request will have its own `nextPageToken` to continue paging through the results. ||
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
|| backupWindowStart | **[TimeOfDay](#google.type.TimeOfDay)**

Time to start the daily backup, in the UTC timezone. ||
|| backupRetainPeriodDays | **string** (int64)

Retain period of automatically created backup in days ||
|| access | **[Access](#yandex.cloud.mdb.spqr.v1.Access)**

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
|| balancer | **[BalancerSettings](#yandex.cloud.mdb.spqr.v1.BalancerSettings)**

SPQR Balancer settings. ||
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

## CoordinatorConfig {#yandex.cloud.mdb.spqr.v1.CoordinatorConfig}

#|
||Field | Description ||
|| config | **object** ||
|| resources | **[Resources](#yandex.cloud.mdb.spqr.v1.Resources)** ||
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
|| coordinator | **object** ||
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