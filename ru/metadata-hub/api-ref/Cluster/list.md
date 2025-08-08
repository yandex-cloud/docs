---
editable: false
apiPlayground:
  - url: https://metastore.{{ api-host }}/managed-metastore/v1/clusters
    method: get
    path: null
    query:
      type: object
      properties:
        folderId:
          description: |-
            **string**
            Required field. ID of the folder to list Metastore Clusters in.
          type: string
        pageSize:
          description: |-
            **string** (int64)
            The maximum number of results per page to return. If the number of available
            results is larger than `pageSize`, the service returns a [ListClustersResponse.nextPageToken](/docs/managed-metastore/api-ref/Cluster/list#yandex.cloud.metastore.v1.ListClustersResponse)
            that can be used to get the next page of results in subsequent list requests.
          type: string
          format: int64
        pageToken:
          description: |-
            **string**
            Page token. To get the next page of results, set `pageToken` to the [ListClustersResponse.nextPageToken](/docs/managed-metastore/api-ref/Cluster/list#yandex.cloud.metastore.v1.ListClustersResponse)
            returned by a previous list request.
          type: string
        filter:
          description: |-
            **string**
            A filter expression that filters resources listed in the response.
            The expression must specify:
            1. The field name. Currently you can only use filtering with the [Cluster.name](/docs/managed-metastore/api-ref/Cluster/get#yandex.cloud.metastore.v1.Cluster) field.
            2. An `=` operator.
            3. The value in double quotes (`"`). Must be 1-63 characters long and match the regular expression `[a-zA-Z0-9_-]+`.
          type: string
      required:
        - folderId
      additionalProperties: false
    body: null
    definitions: null
sourcePath: en/_api-ref/metastore/v1/api-ref/Cluster/list.md
---

# Managed Service for Hive Metastore™ API, REST: Cluster.List

Retrieves a list of Metastore Clusters.

## HTTP request

```
GET https://metastore.{{ api-host }}/managed-metastore/v1/clusters
```

## Query parameters {#yandex.cloud.metastore.v1.ListClustersRequest}

#|
||Field | Description ||
|| folderId | **string**

Required field. ID of the folder to list Metastore Clusters in. ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`, the service returns a [ListClustersResponse.nextPageToken](#yandex.cloud.metastore.v1.ListClustersResponse)
that can be used to get the next page of results in subsequent list requests. ||
|| pageToken | **string**

Page token. To get the next page of results, set `pageToken` to the [ListClustersResponse.nextPageToken](#yandex.cloud.metastore.v1.ListClustersResponse)
returned by a previous list request. ||
|| filter | **string**

A filter expression that filters resources listed in the response.
The expression must specify:
1. The field name. Currently you can only use filtering with the [Cluster.name](#yandex.cloud.metastore.v1.Cluster) field.
2. An `=` operator.
3. The value in double quotes (`"`). Must be 1-63 characters long and match the regular expression `[a-zA-Z0-9_-]+`. ||
|#

## Response {#yandex.cloud.metastore.v1.ListClustersResponse}

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
      "health": "string",
      "status": "string",
      "deletionProtection": "boolean",
      "version": "string",
      "networkId": "string",
      "endpointIp": "string",
      "clusterConfig": {
        "resources": {
          "resourcePresetId": "string"
        }
      },
      "serviceAccountId": "string",
      "logging": {
        "enabled": "boolean",
        // Includes only one of the fields `folderId`, `logGroupId`
        "folderId": "string",
        "logGroupId": "string",
        // end of the list of possible fields
        "minLevel": "string"
      },
      "network": {
        "subnetIds": [
          "string"
        ],
        "securityGroupIds": [
          "string"
        ]
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
|| clusters[] | **[Cluster](#yandex.cloud.metastore.v1.Cluster)**

List of Metastore Clusters. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListClustersRequest.pageSize](#yandex.cloud.metastore.v1.ListClustersRequest), use the `nextPageToken` as the value
for the [ListClustersRequest.pageToken](#yandex.cloud.metastore.v1.ListClustersRequest) parameter in the next list request. Each subsequent
list request will have its own `nextPageToken` to continue paging through the results. ||
|#

## Cluster {#yandex.cloud.metastore.v1.Cluster}

Metastore Cluster.

#|
||Field | Description ||
|| id | **string**

Unique ID of the Metastore Cluster.
This ID is assigned by Cloud in the process of creating a Trino cluster. ||
|| folderId | **string**

ID of the folder that the Metastore Cluster belongs to. ||
|| createdAt | **string** (date-time)

The time the Metastore Cluster was created at.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| name | **string**

Name of the Metastore Cluster.
The name is unique within the folder. ||
|| description | **string**

Description of the Metastore Cluster. ||
|| labels | **object** (map<**string**, **string**>)

Custom labels for the Metastore Cluster as `` key:value `` pairs. ||
|| monitoring[] | **[Monitoring](#yandex.cloud.metastore.v1.Monitoring)**

Monitoring systems relevant to the Metastore Cluster. ||
|| health | **enum** (Health)

Aggregated cluster health.

- `HEALTH_UNKNOWN`: Cluster is in unknown state (we have no data).
- `ALIVE`: Cluster is alive and operates properly.
- `DEAD`: Cluster is inoperable (it cannot perform any of its essential functions).
- `DEGRADED`: Cluster is partially alive (it can perform some of its essential functions). ||
|| status | **enum** (Status)

Cluster status.

- `STATUS_UNKNOWN`: Cluster state is unknown.
- `CREATING`: Cluster is being created.
- `RUNNING`: Cluster is running normally.
- `ERROR`: Cluster encountered a problem and cannot operate.
- `UPDATING`: Cluster is being updated.
- `STOPPING`: Cluster is stopping.
- `STOPPED`: Cluster stopped.
- `STARTING`: Cluster is starting. ||
|| deletionProtection | **boolean**

Deletion Protection prevents deletion of the cluster. ||
|| version | **string**

Metastore server version. ||
|| networkId | **string**

Metastore network ID. ||
|| endpointIp | **string**

IP address of the Metastore server load balancer. ||
|| clusterConfig | **[ClusterConfig](#yandex.cloud.metastore.v1.ClusterConfig)**

Configuration of the Metastore Cluster. ||
|| serviceAccountId | **string**

Service account used to access Cloud resources. ||
|| logging | **[LoggingConfig](#yandex.cloud.metastore.v1.LoggingConfig)**

Cloud logging configuration. ||
|| network | **[NetworkConfig](#yandex.cloud.metastore.v1.NetworkConfig)**

Network-related configuration options. ||
|| maintenanceWindow | **[MaintenanceWindow](#yandex.cloud.metastore.v1.MaintenanceWindow)**

Maintenance window. ||
|| plannedOperation | **[MaintenanceOperation](#yandex.cloud.metastore.v1.MaintenanceOperation)**

Maintenance operation scheduled for the nearest maintenance window. ||
|#

## Monitoring {#yandex.cloud.metastore.v1.Monitoring}

#|
||Field | Description ||
|| name | **string**

Name of the monitoring system. ||
|| description | **string**

Description of the monitoring system. ||
|| link | **string**

Link to the monitoring system. ||
|#

## ClusterConfig {#yandex.cloud.metastore.v1.ClusterConfig}

#|
||Field | Description ||
|| resources | **[Resources](#yandex.cloud.metastore.v1.Resources)**

Configuration for computational resources for Metastore server instances. ||
|#

## Resources {#yandex.cloud.metastore.v1.Resources}

#|
||Field | Description ||
|| resourcePresetId | **string**

Required field. ID of the preset for computational resources allocated to an instance (e.g., CPU, memory, etc.). ||
|#

## LoggingConfig {#yandex.cloud.metastore.v1.LoggingConfig}

#|
||Field | Description ||
|| enabled | **boolean**

Logs generated by the Metastore server are delivered to Cloud Logging. ||
|| folderId | **string**

Logs will be written to the default log group of the specified folder.

Includes only one of the fields `folderId`, `logGroupId`.

Destination of log records. ||
|| logGroupId | **string**

Logs will be written to the log group specified by its ID.

Includes only one of the fields `folderId`, `logGroupId`.

Destination of log records. ||
|| minLevel | **enum** (Level)

Minimum severity level for log entries.

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

## NetworkConfig {#yandex.cloud.metastore.v1.NetworkConfig}

#|
||Field | Description ||
|| subnetIds[] | **string**

IDs of VPC network subnets where instances of the cluster are attached. ||
|| securityGroupIds[] | **string**

User security groups. ||
|#

## MaintenanceWindow {#yandex.cloud.metastore.v1.MaintenanceWindow}

#|
||Field | Description ||
|| anytime | **object**

Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`. ||
|| weeklyMaintenanceWindow | **[WeeklyMaintenanceWindow](#yandex.cloud.metastore.v1.WeeklyMaintenanceWindow)**

Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`. ||
|#

## WeeklyMaintenanceWindow {#yandex.cloud.metastore.v1.WeeklyMaintenanceWindow}

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

## MaintenanceOperation {#yandex.cloud.metastore.v1.MaintenanceOperation}

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