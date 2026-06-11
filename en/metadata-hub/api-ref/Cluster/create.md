---
editable: false
apiPlayground:
  - url: https://metastore.{{ api-host }}/managed-metastore/v1/clusters
    method: post
    path: null
    query: null
    body:
      type: object
      properties:
        folderId:
          description: |-
            **string**
            Required field. ID of the folder to create the Metastore Cluster in.
            The maximum string length in characters is 50.
          type: string
        name:
          description: |-
            **string**
            Required field. Name of the Metastore Cluster.
            The name must be unique within the folder.
            The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
          pattern: '[a-zA-Z0-9_-]*'
          type: string
        description:
          description: |-
            **string**
            Description of the Metastore Cluster.
            The maximum string length in characters is 256.
          type: string
        labels:
          description: |-
            **object** (map<**string**, **string**>)
            Custom labels for the Metastore Cluster as `` key:value `` pairs.
            For example: {"env": "prod"}.
            The maximum string length in characters for each value is 63. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `. Each value must match the regular expression ` [-_0-9a-z]* `. No more than 64 per resource.
          type: object
          additionalProperties:
            type: string
            pattern: '[-_0-9a-z]*'
            maxLength: 63
          propertyNames:
            type: string
            pattern: '[a-z][-_0-9a-z]*'
            maxLength: 63
            minLength: 1
          maxProperties: 64
        deletionProtection:
          description: |-
            **boolean**
            Deletion Protection prevents deletion of the cluster.
          type: boolean
        version:
          description: |-
            **string**
            Metastore server version.
          type: string
        configSpec:
          description: |-
            **[ConfigSpec](#yandex.cloud.metastore.v1.ConfigSpec)**
            Configuration of the Metastore Cluster.
          $ref: '#/definitions/ConfigSpec'
        serviceAccountId:
          description: |-
            **string**
            Required field. Service account used to access Cloud resources.
            The maximum string length in characters is 50.
          type: string
        logging:
          description: |-
            **[LoggingConfig](#yandex.cloud.metastore.v1.LoggingConfig)**
            Cloud logging configuration.
          $ref: '#/definitions/LoggingConfig'
        network:
          description: |-
            **[NetworkConfig](#yandex.cloud.metastore.v1.NetworkConfig)**
            Network-related configuration options.
          $ref: '#/definitions/NetworkConfig'
        maintenanceWindow:
          description: |-
            **[MaintenanceWindow](#yandex.cloud.metastore.v1.MaintenanceWindow)**
            Maintenance window.
          $ref: '#/definitions/MaintenanceWindow'
      required:
        - folderId
        - name
        - serviceAccountId
      additionalProperties: false
    definitions:
      Resources:
        type: object
        properties:
          resourcePresetId:
            description: |-
              **string**
              Required field. ID of the preset for computational resources allocated to an instance (e.g., CPU, memory, etc.).
              The maximum string length in characters is 50.
            type: string
        required:
          - resourcePresetId
      S3Warehouse:
        type: object
        properties:
          bucket:
            description: |-
              **string**
              Required field. Bucket name to use.
            type: string
          path:
            description: |-
              **string**
              Path within the bucket to use.
              Value must match the regular expression ` ([a-zA-Z0-9/][-a-zA-Z0-9_./]{0,512})? `.
            pattern: ([a-zA-Z0-9/][-a-zA-Z0-9_./]{0,512})?
            type: string
        required:
          - bucket
      WarehouseConfig:
        type: object
        properties:
          s3:
            description: |-
              **[S3Warehouse](#yandex.cloud.metastore.v1.WarehouseConfig.S3Warehouse)**
              Yandex Cloud Object Storage.
              Includes only one of the fields `s3`.
            $ref: '#/definitions/S3Warehouse'
        oneOf:
          - required:
              - s3
      ConfigSpec:
        type: object
        properties:
          resources:
            description: |-
              **[Resources](#yandex.cloud.metastore.v1.Resources)**
              Configuration for computational resources for Metastore server instances.
            $ref: '#/definitions/Resources'
          warehouse:
            description: |-
              **[WarehouseConfig](#yandex.cloud.metastore.v1.WarehouseConfig)**
              Required field. Configuration of warehouse.
            $ref: '#/definitions/WarehouseConfig'
        required:
          - warehouse
      LoggingConfig:
        type: object
        properties:
          folderId:
            description: |-
              **string**
              Logs will be written to the default log group of the specified folder.
              Value must match the regular expression ` ([a-zA-Z][-a-zA-Z0-9_.]{0,63})? `.
              Includes only one of the fields `folderId`, `logGroupId`.
              Destination of log records.
            pattern: ([a-zA-Z][-a-zA-Z0-9_.]{0,63})?
            type: string
          logGroupId:
            description: |-
              **string**
              Logs will be written to the log group specified by its ID.
              Value must match the regular expression ` ([a-zA-Z][-a-zA-Z0-9_.]{0,63})? `.
              Includes only one of the fields `folderId`, `logGroupId`.
              Destination of log records.
            pattern: ([a-zA-Z][-a-zA-Z0-9_.]{0,63})?
            type: string
          enabled:
            description: |-
              **boolean**
              Logs generated by the Metastore server are delivered to Cloud Logging.
            type: boolean
          minLevel:
            description: |-
              **enum** (Level)
              Minimum severity level for log entries.
              See [LogLevel.Level](/docs/logging/api-ref/Export/get#yandex.cloud.logging.v1.LogLevel.Level) for details.
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
              May be used to alert about unrecoverable failures and events.
            type: string
            enum:
              - LEVEL_UNSPECIFIED
              - TRACE
              - DEBUG
              - INFO
              - WARN
              - ERROR
              - FATAL
        oneOf:
          - required:
              - folderId
          - required:
              - logGroupId
      NetworkConfig:
        type: object
        properties:
          subnetIds:
            description: |-
              **string**
              IDs of VPC network subnets where instances of the cluster are attached.
            type: array
            items:
              type: string
          securityGroupIds:
            description: |-
              **string**
              User security groups.
            type: array
            items:
              type: string
      AnytimeMaintenanceWindow:
        type: object
        properties: {}
      WeeklyMaintenanceWindow:
        type: object
        properties:
          day:
            description: |-
              **enum** (WeekDay)
              Day of the week when maintenance can occur.
              - `MON`: Monday.
              - `TUE`: Tuesday.
              - `WED`: Wednesday.
              - `THU`: Thursday.
              - `FRI`: Friday.
              - `SAT`: Saturday.
              - `SUN`: Sunday.
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
              Hour of the day in UTC when the maintenance window starts.
              Acceptable values are 1 to 24, inclusive.
            type: string
            format: int64
      MaintenanceWindow:
        type: object
        properties:
          anytime:
            description: |-
              **object**
              The cluster may be restarted for maintenance at any time.
              Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`.
            $ref: '#/definitions/AnytimeMaintenanceWindow'
          weeklyMaintenanceWindow:
            description: |-
              **[WeeklyMaintenanceWindow](#yandex.cloud.metastore.v1.WeeklyMaintenanceWindow)**
              Maintenance is allowed only within the specified weekly window.
              Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`.
            $ref: '#/definitions/WeeklyMaintenanceWindow'
        oneOf:
          - required:
              - anytime
          - required:
              - weeklyMaintenanceWindow
---

# Managed Service for Hive Metastore™ API, REST: Cluster.Create

Creates a Metastore Cluster.

## HTTP request

```
POST https://metastore.{{ api-host }}/managed-metastore/v1/clusters
```

## Body parameters {#yandex.cloud.metastore.v1.CreateClusterRequest}

```json
{
  "folderId": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "deletionProtection": "boolean",
  "version": "string",
  "configSpec": {
    "resources": {
      "resourcePresetId": "string"
    },
    "warehouse": {
      // Includes only one of the fields `s3`
      "s3": {
        "bucket": "string",
        "path": "string"
      }
      // end of the list of possible fields
    }
  },
  "serviceAccountId": "string",
  "logging": {
    // Includes only one of the fields `folderId`, `logGroupId`
    "folderId": "string",
    "logGroupId": "string",
    // end of the list of possible fields
    "enabled": "boolean",
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
  }
}
```

#|
||Field | Description ||
|| folderId | **string**

Required field. ID of the folder to create the Metastore Cluster in.

The maximum string length in characters is 50. ||
|| name | **string**

Required field. Name of the Metastore Cluster.
The name must be unique within the folder.

The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `. ||
|| description | **string**

Description of the Metastore Cluster.

The maximum string length in characters is 256. ||
|| labels | **object** (map<**string**, **string**>)

Custom labels for the Metastore Cluster as `` key:value `` pairs.
For example: {"env": "prod"}.

The maximum string length in characters for each value is 63. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `. Each value must match the regular expression ` [-_0-9a-z]* `. No more than 64 per resource. ||
|| deletionProtection | **boolean**

Deletion Protection prevents deletion of the cluster. ||
|| version | **string**

Metastore server version. ||
|| configSpec | **[ConfigSpec](#yandex.cloud.metastore.v1.ConfigSpec)**

Configuration of the Metastore Cluster. ||
|| serviceAccountId | **string**

Required field. Service account used to access Cloud resources.

The maximum string length in characters is 50. ||
|| logging | **[LoggingConfig](#yandex.cloud.metastore.v1.LoggingConfig)**

Cloud logging configuration. ||
|| network | **[NetworkConfig](#yandex.cloud.metastore.v1.NetworkConfig)**

Network-related configuration options. ||
|| maintenanceWindow | **[MaintenanceWindow](#yandex.cloud.metastore.v1.MaintenanceWindow)**

Maintenance window. ||
|#

## ConfigSpec {#yandex.cloud.metastore.v1.ConfigSpec}

#|
||Field | Description ||
|| resources | **[Resources](#yandex.cloud.metastore.v1.Resources)**

Configuration for computational resources for Metastore server instances. ||
|| warehouse | **[WarehouseConfig](#yandex.cloud.metastore.v1.WarehouseConfig)**

Required field. Configuration of warehouse. ||
|#

## Resources {#yandex.cloud.metastore.v1.Resources}

#|
||Field | Description ||
|| resourcePresetId | **string**

Required field. ID of the preset for computational resources allocated to an instance (e.g., CPU, memory, etc.).

The maximum string length in characters is 50. ||
|#

## WarehouseConfig {#yandex.cloud.metastore.v1.WarehouseConfig}

#|
||Field | Description ||
|| s3 | **[S3Warehouse](#yandex.cloud.metastore.v1.WarehouseConfig.S3Warehouse)**

Yandex Cloud Object Storage.

Includes only one of the fields `s3`. ||
|#

## S3Warehouse {#yandex.cloud.metastore.v1.WarehouseConfig.S3Warehouse}

#|
||Field | Description ||
|| bucket | **string**

Required field. Bucket name to use. ||
|| path | **string**

Path within the bucket to use.

Value must match the regular expression ` ([a-zA-Z0-9/][-a-zA-Z0-9_./]{0,512})? `. ||
|#

## LoggingConfig {#yandex.cloud.metastore.v1.LoggingConfig}

#|
||Field | Description ||
|| folderId | **string**

Logs will be written to the default log group of the specified folder.

Value must match the regular expression ` ([a-zA-Z][-a-zA-Z0-9_.]{0,63})? `.

Includes only one of the fields `folderId`, `logGroupId`.

Destination of log records. ||
|| logGroupId | **string**

Logs will be written to the log group specified by its ID.

Value must match the regular expression ` ([a-zA-Z][-a-zA-Z0-9_.]{0,63})? `.

Includes only one of the fields `folderId`, `logGroupId`.

Destination of log records. ||
|| enabled | **boolean**

Logs generated by the Metastore server are delivered to Cloud Logging. ||
|| minLevel | **enum** (Level)

Minimum severity level for log entries.
See [LogLevel.Level](/docs/logging/api-ref/Export/get#yandex.cloud.logging.v1.LogLevel.Level) for details.

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

The cluster may be restarted for maintenance at any time.

Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`. ||
|| weeklyMaintenanceWindow | **[WeeklyMaintenanceWindow](#yandex.cloud.metastore.v1.WeeklyMaintenanceWindow)**

Maintenance is allowed only within the specified weekly window.

Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`. ||
|#

## WeeklyMaintenanceWindow {#yandex.cloud.metastore.v1.WeeklyMaintenanceWindow}

#|
||Field | Description ||
|| day | **enum** (WeekDay)

Day of the week when maintenance can occur.

- `MON`: Monday.
- `TUE`: Tuesday.
- `WED`: Wednesday.
- `THU`: Thursday.
- `FRI`: Friday.
- `SAT`: Saturday.
- `SUN`: Sunday. ||
|| hour | **string** (int64)

Hour of the day in UTC when the maintenance window starts.

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