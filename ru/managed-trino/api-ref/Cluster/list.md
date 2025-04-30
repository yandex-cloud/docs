---
editable: false
sourcePath: en/_api-ref/trino/v1/api-ref/Cluster/list.md
---

# Managed Service for Trino API, REST: Cluster.List

Retrieves a list of Trino Cluster resources.

## HTTP request

```
GET https://trino.{{ api-host }}/managed-trino/v1/clusters
```

## Query parameters {#yandex.cloud.trino.v1.ListClustersRequest}

#|
||Field | Description ||
|| folderId | **string**

Required field. ID of the folder to list Trino clusters in. ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`, the service returns a [ListClustersResponse.nextPageToken](#yandex.cloud.trino.v1.ListClustersResponse)
that can be used to get the next page of results in subsequent list requests. ||
|| pageToken | **string**

Page token. To get the next page of results, set `pageToken` to the [ListClustersResponse.nextPageToken](#yandex.cloud.trino.v1.ListClustersResponse)
returned by the previous list request. ||
|| filter | **string**

A filter expression that filters resources listed in the response.
The expression must specify:
1. The field name. Currently you can only use filtering with the [Cluster.name](#yandex.cloud.trino.v1.Cluster) field.
2. An `=` operator.
3. The value in double quotes (`"`). Must be 1-63 characters long and match the regular expression `[a-zA-Z0-9_-]+`. ||
|#

## Response {#yandex.cloud.trino.v1.ListClustersResponse}

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
      "monitoring": [
        {
          "name": "string",
          "description": "string",
          "link": "string"
        }
      ],
      "trino": {
        "coordinatorConfig": {
          "resources": {
            "resourcePresetId": "string"
          }
        },
        "workerConfig": {
          "resources": {
            "resourcePresetId": "string"
          },
          "scalePolicy": {
            // Includes only one of the fields `fixedScale`, `autoScale`
            "fixedScale": {
              "count": "string"
            },
            "autoScale": {
              "minCount": "string",
              "maxCount": "string"
            }
            // end of the list of possible fields
          }
        },
        "version": "string",
        "retryPolicy": {
          "policy": "string",
          "exchangeManager": {
            "additionalProperties": "object",
            "storage": {
              // Includes only one of the fields `serviceS3`
              "serviceS3": "object"
              // end of the list of possible fields
            }
          },
          "additionalProperties": "object"
        }
      },
      "health": "string",
      "status": "string",
      "network": {
        "subnetIds": [
          "string"
        ],
        "securityGroupIds": [
          "string"
        ]
      },
      "deletionProtection": "boolean",
      "serviceAccountId": "string",
      "logging": {
        "enabled": "boolean",
        // Includes only one of the fields `folderId`, `logGroupId`
        "folderId": "string",
        "logGroupId": "string",
        // end of the list of possible fields
        "minLevel": "string"
      },
      "coordinatorUrl": "string",
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
      }
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| clusters[] | **[Cluster](#yandex.cloud.trino.v1.Cluster)**

List of Trino Cluster resources. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListClustersRequest.pageSize](#yandex.cloud.trino.v1.ListClustersRequest), use the `nextPageToken` as the value
for the [ListClustersRequest.pageToken](#yandex.cloud.trino.v1.ListClustersRequest) parameter in the next list request. Each subsequent
list request will have its own `nextPageToken` to continue paging through the results. ||
|#

## Cluster {#yandex.cloud.trino.v1.Cluster}

Trino cluster.

#|
||Field | Description ||
|| id | **string**

Unique ID of the Trino cluster.
This ID is assigned by Cloud in the process of creating a Trino cluster. ||
|| folderId | **string**

ID of the folder that the Trino cluster belongs to. ||
|| createdAt | **string** (date-time)

The time when the Trino cluster was created.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
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
|| health | **enum** (Health)

Aggregated cluster health.

- `HEALTH_UNKNOWN`: Object is in unknown state (we have no data)
- `ALIVE`: Object is alive and well (all hosts are alive)
- `DEAD`: Object is inoperable (it cannot perform any of its essential functions)
- `DEGRADED`: Object is partially alive (it can perform some of its essential functions) ||
|| status | **enum** (Status)

Cluster status.

- `STATUS_UNKNOWN`: Cluster state is unknown.
- `CREATING`: Cluster is being created.
- `RUNNING`: Cluster is running normally.
- `ERROR`: Cluster encountered a problem and cannot operate.
- `STOPPING`: Cluster is stopping.
- `STOPPED`: Cluster is stopped.
- `STARTING`: Cluster is starting.
- `UPDATING`: Cluster is being updated. ||
|| network | **[NetworkConfig](#yandex.cloud.trino.v1.NetworkConfig)**

Network related configuration options. ||
|| deletionProtection | **boolean**

Deletion Protection inhibits deletion of the cluster. ||
|| serviceAccountId | **string**

Service account used to access Cloud resources. ||
|| logging | **[LoggingConfig](#yandex.cloud.trino.v1.LoggingConfig)**

Cloud logging configuration. ||
|| coordinatorUrl | **string**

Address of Trino Coordinator. ||
|| maintenanceWindow | **[MaintenanceWindow](#yandex.cloud.trino.v1.MaintenanceWindow)**

Window of maintenance operations. ||
|| plannedOperation | **[MaintenanceOperation](#yandex.cloud.trino.v1.MaintenanceOperation)**

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
|| coordinatorConfig | **[CoordinatorConfig](#yandex.cloud.trino.v1.CoordinatorConfig)**

Required field. Configuration for the coordinator, specifying computational resources and other settings. ||
|| workerConfig | **[WorkerConfig](#yandex.cloud.trino.v1.WorkerConfig)**

Required field. Configuration for worker nodes, including scaling policy and computational resources. ||
|| version | **string**

Version of Trino. ||
|| retryPolicy | **[RetryPolicyConfig](#yandex.cloud.trino.v1.RetryPolicyConfig)**

Configuration for retry policy, specifying the spooling storage destination and other settings. ||
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
|| resourcePresetId | **string**

Required field. ID of the preset for computational resources allocated to a instance (e.g., CPU, memory, etc.). ||
|#

## WorkerConfig {#yandex.cloud.trino.v1.WorkerConfig}

#|
||Field | Description ||
|| resources | **[Resources](#yandex.cloud.trino.v1.Resources)**

Required field. Configuration for computational resources for worker instances. ||
|| scalePolicy | **[WorkerScalePolicy](#yandex.cloud.trino.v1.WorkerConfig.WorkerScalePolicy)**

Required field. Configuration for scaling policy for worker instances. ||
|#

## WorkerScalePolicy {#yandex.cloud.trino.v1.WorkerConfig.WorkerScalePolicy}

#|
||Field | Description ||
|| fixedScale | **[FixedScalePolicy](#yandex.cloud.trino.v1.FixedScalePolicy)**

A fixed scaling policy that specifies a fixed number of worker instances.

Includes only one of the fields `fixedScale`, `autoScale`.

Defines the scaling type for worker instances.
Only one type of scaling can be specified at a time. ||
|| autoScale | **[AutoScalePolicy](#yandex.cloud.trino.v1.AutoScalePolicy)**

A scaling policy that dynamically adjusts the number of worker instances
based on the cluster's workload. The system automatically increases or
decreases the number of instances within the defined range.

Includes only one of the fields `fixedScale`, `autoScale`.

Defines the scaling type for worker instances.
Only one type of scaling can be specified at a time. ||
|#

## FixedScalePolicy {#yandex.cloud.trino.v1.FixedScalePolicy}

#|
||Field | Description ||
|| count | **string** (int64)

Specifies the number of worker instances. ||
|#

## AutoScalePolicy {#yandex.cloud.trino.v1.AutoScalePolicy}

#|
||Field | Description ||
|| minCount | **string** (int64) ||
|| maxCount | **string** (int64) ||
|#

## RetryPolicyConfig {#yandex.cloud.trino.v1.RetryPolicyConfig}

#|
||Field | Description ||
|| policy | **enum** (RetryPolicy)

Retry policy level.

- `RETRY_POLICY_UNSPECIFIED`
- `QUERY`
- `TASK` ||
|| exchangeManager | **[ExchangeManagerConfig](#yandex.cloud.trino.v1.ExchangeManagerConfig)**

Configuration for exchange manager. ||
|| additionalProperties | **object** (map<**string**, **string**>)

Additional properties. ||
|#

## ExchangeManagerConfig {#yandex.cloud.trino.v1.ExchangeManagerConfig}

#|
||Field | Description ||
|| additionalProperties | **object** (map<**string**, **string**>)

Additional properties. ||
|| storage | **[ExchangeManagerStorage](#yandex.cloud.trino.v1.ExchangeManagerStorage)** ||
|#

## ExchangeManagerStorage {#yandex.cloud.trino.v1.ExchangeManagerStorage}

#|
||Field | Description ||
|| serviceS3 | **object**

Use service side s3 bucket for exchange manager.

Includes only one of the fields `serviceS3`. ||
|#

## NetworkConfig {#yandex.cloud.trino.v1.NetworkConfig}

#|
||Field | Description ||
|| subnetIds[] | **string**

IDs of VPC network subnets where instances of the cluster are attached. ||
|| securityGroupIds[] | **string**

User security groups. ||
|#

## LoggingConfig {#yandex.cloud.trino.v1.LoggingConfig}

#|
||Field | Description ||
|| enabled | **boolean**

Logs generated by the Trino components are delivered to Cloud Logging. ||
|| folderId | **string**

Logs should be written to default log group for specified folder.

Includes only one of the fields `folderId`, `logGroupId`.

Destination of log records. ||
|| logGroupId | **string**

Logs should be written to log group resolved by ID.

Includes only one of the fields `folderId`, `logGroupId`.

Destination of log records. ||
|| minLevel | **enum** (Level)

Minimum log entry level.

See [LogLevel.Level](/docs/logging/api-ref/Export/run#yandex.cloud.logging.v1.LogLevel.Level) for details.

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
|| anytime | **object**

Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`. ||
|| weeklyMaintenanceWindow | **[WeeklyMaintenanceWindow](#yandex.cloud.trino.v1.WeeklyMaintenanceWindow)**

Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`. ||
|#

## WeeklyMaintenanceWindow {#yandex.cloud.trino.v1.WeeklyMaintenanceWindow}

#|
||Field | Description ||
|| day | **enum** (WeekDay)

- `WEEK_DAY_UNSPECIFIED`
- `MON`
- `TUE`
- `WED`
- `THU`
- `FRI`
- `SAT`
- `SUN` ||
|| hour | **string** (int64)

Hour of the day in UTC. ||
|#

## MaintenanceOperation {#yandex.cloud.trino.v1.MaintenanceOperation}

#|
||Field | Description ||
|| info | **string** ||
|| delayedUntil | **string** (date-time)

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