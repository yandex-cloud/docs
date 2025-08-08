---
editable: false
apiPlayground:
  - url: https://metastore.{{ api-host }}/managed-metastore/v1/clusters/{clusterId}
    method: patch
    path:
      type: object
      properties:
        clusterId:
          description: |-
            **string**
            Required field. ID of the Metastore Cluster to update.
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
            New name of the Metastore Cluster.
          pattern: '[a-zA-Z0-9_-]*'
          type: string
        description:
          description: |-
            **string**
            New description of the Metastore Cluster.
          type: string
        labels:
          description: |-
            **object** (map<**string**, **string**>)
            Custom labels for the Metastore Cluster as `` key:value `` pairs.
            For example: {"env": "prod"}.
          pattern: '[a-z][-_0-9a-z]*'
          type: string
        deletionProtection:
          description: |-
            **boolean**
            Deletion Protection prevents deletion of the cluster.
          type: boolean
        serviceAccountId:
          description: |-
            **string**
            Service account used to access Cloud resources.
          type: string
        logging:
          description: |-
            **[LoggingConfig](/docs/managed-metastore/api-ref/Cluster/get#yandex.cloud.metastore.v1.LoggingConfig)**
            Cloud logging configuration.
          oneOf:
            - type: object
              properties:
                folderId:
                  description: |-
                    **string**
                    Logs will be written to the default log group of the specified folder.
                    Includes only one of the fields `folderId`, `logGroupId`.
                    Destination of log records.
                  pattern: ([a-zA-Z][-a-zA-Z0-9_.]{0,63})?
                  type: string
                logGroupId:
                  description: |-
                    **string**
                    Logs will be written to the log group specified by its ID.
                    Includes only one of the fields `folderId`, `logGroupId`.
                    Destination of log records.
                  pattern: ([a-zA-Z][-a-zA-Z0-9_.]{0,63})?
                  type: string
        networkSpec:
          description: |-
            **[UpdateNetworkConfigSpec](/docs/managed-metastore/api-ref/Cluster/update#yandex.cloud.metastore.v1.UpdateNetworkConfigSpec)**
            Network-related configuration options.
          $ref: '#/definitions/UpdateNetworkConfigSpec'
        configSpec:
          description: |-
            **[UpdateClusterConfigSpec](/docs/managed-metastore/api-ref/Cluster/update#yandex.cloud.metastore.v1.UpdateClusterConfigSpec)**
            Metastore Cluster configuration.
          $ref: '#/definitions/UpdateClusterConfigSpec'
        maintenanceWindow:
          description: |-
            **[MaintenanceWindow](/docs/managed-metastore/api-ref/Cluster/get#yandex.cloud.metastore.v1.MaintenanceWindow)**
            Maintenance window.
          oneOf:
            - type: object
              properties:
                anytime:
                  description: |-
                    **object**
                    Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`.
                  $ref: '#/definitions/AnytimeMaintenanceWindow'
                weeklyMaintenanceWindow:
                  description: |-
                    **[WeeklyMaintenanceWindow](/docs/managed-metastore/api-ref/Cluster/get#yandex.cloud.metastore.v1.WeeklyMaintenanceWindow)**
                    Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`.
                  $ref: '#/definitions/WeeklyMaintenanceWindow'
        version:
          description: |-
            **string**
            Metastore server version.
          type: string
      additionalProperties: false
    definitions:
      UpdateNetworkConfigSpec:
        type: object
        properties:
          securityGroupIds:
            description: |-
              **string**
              User security groups.
            type: array
            items:
              type: string
      Resources:
        type: object
        properties:
          resourcePresetId:
            description: |-
              **string**
              Required field. ID of the preset for computational resources allocated to an instance (e.g., CPU, memory, etc.).
            type: string
        required:
          - resourcePresetId
      UpdateClusterConfigSpec:
        type: object
        properties:
          resources:
            description: |-
              **[Resources](/docs/managed-metastore/api-ref/Cluster/get#yandex.cloud.metastore.v1.Resources)**
              Configuration for computational resources for Metastore server instances.
            $ref: '#/definitions/Resources'
      AnytimeMaintenanceWindow:
        type: object
        properties: {}
      WeeklyMaintenanceWindow:
        type: object
        properties:
          day:
            description: |-
              **enum** (WeekDay)
              - `WEEK_DAY_UNSPECIFIED`
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
              Hour of the day in UTC.
            type: string
            format: int64
sourcePath: en/_api-ref/metastore/v1/api-ref/Cluster/update.md
---

# Managed Service for Hive Metastore™ API, REST: Cluster.Update

Updates the configuration of the specified Metastore Cluster.

## HTTP request

```
PATCH https://metastore.{{ api-host }}/managed-metastore/v1/clusters/{clusterId}
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the Metastore Cluster to update. ||
|#

## Body parameters {#yandex.cloud.metastore.v1.UpdateClusterRequest}

```json
{
  "updateMask": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
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
  "networkSpec": {
    "securityGroupIds": [
      "string"
    ]
  },
  "configSpec": {
    "resources": {
      "resourcePresetId": "string"
    }
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
  "version": "string"
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

New name of the Metastore Cluster. ||
|| description | **string**

New description of the Metastore Cluster. ||
|| labels | **object** (map<**string**, **string**>)

Custom labels for the Metastore Cluster as `` key:value `` pairs.
For example: {"env": "prod"}. ||
|| deletionProtection | **boolean**

Deletion Protection prevents deletion of the cluster. ||
|| serviceAccountId | **string**

Service account used to access Cloud resources. ||
|| logging | **[LoggingConfig](#yandex.cloud.metastore.v1.LoggingConfig)**

Cloud logging configuration. ||
|| networkSpec | **[UpdateNetworkConfigSpec](#yandex.cloud.metastore.v1.UpdateNetworkConfigSpec)**

Network-related configuration options. ||
|| configSpec | **[UpdateClusterConfigSpec](#yandex.cloud.metastore.v1.UpdateClusterConfigSpec)**

Metastore Cluster configuration. ||
|| maintenanceWindow | **[MaintenanceWindow](#yandex.cloud.metastore.v1.MaintenanceWindow)**

Maintenance window. ||
|| version | **string**

Metastore server version. ||
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

## UpdateNetworkConfigSpec {#yandex.cloud.metastore.v1.UpdateNetworkConfigSpec}

#|
||Field | Description ||
|| securityGroupIds[] | **string**

User security groups. ||
|#

## UpdateClusterConfigSpec {#yandex.cloud.metastore.v1.UpdateClusterConfigSpec}

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
    "clusterId": "string"
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
|| metadata | **[UpdateClusterMetadata](#yandex.cloud.metastore.v1.UpdateClusterMetadata)**

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
|| response | **[Cluster](#yandex.cloud.metastore.v1.Cluster)**

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

## UpdateClusterMetadata {#yandex.cloud.metastore.v1.UpdateClusterMetadata}

#|
||Field | Description ||
|| clusterId | **string**

ID of the Metastore Cluster that is being updated. ||
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
|| logging | **[LoggingConfig](#yandex.cloud.metastore.v1.LoggingConfig2)**

Cloud logging configuration. ||
|| network | **[NetworkConfig](#yandex.cloud.metastore.v1.NetworkConfig)**

Network-related configuration options. ||
|| maintenanceWindow | **[MaintenanceWindow](#yandex.cloud.metastore.v1.MaintenanceWindow2)**

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
|| resources | **[Resources](#yandex.cloud.metastore.v1.Resources2)**

Configuration for computational resources for Metastore server instances. ||
|#

## Resources {#yandex.cloud.metastore.v1.Resources2}

#|
||Field | Description ||
|| resourcePresetId | **string**

Required field. ID of the preset for computational resources allocated to an instance (e.g., CPU, memory, etc.). ||
|#

## LoggingConfig {#yandex.cloud.metastore.v1.LoggingConfig2}

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

## MaintenanceWindow {#yandex.cloud.metastore.v1.MaintenanceWindow2}

#|
||Field | Description ||
|| anytime | **object**

Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`. ||
|| weeklyMaintenanceWindow | **[WeeklyMaintenanceWindow](#yandex.cloud.metastore.v1.WeeklyMaintenanceWindow2)**

Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`. ||
|#

## WeeklyMaintenanceWindow {#yandex.cloud.metastore.v1.WeeklyMaintenanceWindow2}

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