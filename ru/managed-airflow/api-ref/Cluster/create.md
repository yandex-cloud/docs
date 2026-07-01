---
editable: false
apiPlayground:
  - url: https://airflow.{{ api-host }}/managed-airflow/v1/clusters
    method: post
    path: null
    query: null
    body:
      type: object
      properties:
        folderId:
          description: |-
            **string**
            Required field. ID of the folder to create Apache Airflow cluster in.
            The maximum string length in characters is 50.
          type: string
        name:
          description: |-
            **string**
            Required field. Name of the Apache Airflow cluster. The name must be unique within the folder.
            The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
          pattern: '[a-zA-Z0-9_-]*'
          type: string
        description:
          description: |-
            **string**
            Description of the Apache Airflow cluster.
            The maximum string length in characters is 256.
          type: string
        labels:
          description: |-
            **object** (map<**string**, **string**>)
            Custom labels for the Apache Airflow cluster as `` key:value `` pairs. For example, "env": "prod".
            The maximum string length in characters for each value is 63. The maximum string length in characters for each key is 63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `. Each value must match the regular expression ` [-_0-9a-z]* `. No more than 64 per resource.
          type: object
          additionalProperties:
            type: string
            pattern: '[-_0-9a-z]*'
            maxLength: 63
          propertyNames:
            type: string
            pattern: '[a-z][-_0-9a-z]*'
          maxProperties: 64
        config:
          description: |-
            **[ClusterConfig](#yandex.cloud.airflow.v1.ClusterConfig)**
            Required field. Configuration of Apache Airflow components.
          $ref: '#/definitions/ClusterConfig'
        network:
          description: |-
            **[NetworkConfig](#yandex.cloud.airflow.v1.NetworkConfig)**
            Network related configuration options.
          $ref: '#/definitions/NetworkConfig'
        codeSync:
          description: |-
            **[CodeSyncConfig](#yandex.cloud.airflow.v1.CodeSyncConfig)**
            Parameters of the location and access to the code that will be executed in the cluster.
          $ref: '#/definitions/CodeSyncConfig'
        deletionProtection:
          description: |-
            **boolean**
            Deletion Protection inhibits deletion of the cluster.
          type: boolean
        serviceAccountId:
          description: |-
            **string**
            Service account used to access Cloud resources.
            For more information, see [documentation](/docs/managed-airflow/concepts/impersonation).
            The maximum string length in characters is 50.
          type: string
        logging:
          description: |-
            **[LoggingConfig](#yandex.cloud.airflow.v1.LoggingConfig)**
            Cloud Logging configuration.
          $ref: '#/definitions/LoggingConfig'
        maintenanceWindow:
          description: |-
            **[MaintenanceWindow](#yandex.cloud.airflow.v1.MaintenanceWindow)**
            Window of maintenance operations.
          $ref: '#/definitions/MaintenanceWindow'
        adminPassword:
          description: |-
            **string**
            Required field. Password of user `admin`.
            The string length in characters must be 8-128.
          type: string
      required:
        - folderId
        - name
        - config
        - adminPassword
      additionalProperties: false
    definitions:
      AirflowConfig:
        type: object
        properties:
          config:
            description: |-
              **object** (map<**string**, **string**>)
              Properties to be passed to Apache Airflow configuration file.
            type: object
            additionalProperties:
              type: string
      Resources:
        type: object
        properties:
          resourcePresetId:
            description: |-
              **string**
              ID of the preset for computational resources available to an instance (CPU, memory etc.).
            type: string
      WebserverConfig:
        type: object
        properties:
          count:
            description: |-
              **string** (int64)
              The number of webserver instances in the cluster.
              Acceptable values are 1 to 512, inclusive.
            type: string
            format: int64
          resources:
            description: |-
              **[Resources](#yandex.cloud.airflow.v1.Resources)**
              Resources allocated to webserver instances.
            $ref: '#/definitions/Resources'
      SchedulerConfig:
        type: object
        properties:
          count:
            description: |-
              **string** (int64)
              The number of scheduler instances in the cluster.
              Acceptable values are 1 to 512, inclusive.
            type: string
            format: int64
          resources:
            description: |-
              **[Resources](#yandex.cloud.airflow.v1.Resources)**
              Resources allocated to scheduler instances.
            $ref: '#/definitions/Resources'
      DagProcessorConfig:
        type: object
        properties:
          count:
            description: |-
              **string** (int64)
              The number of dag-processor instances in the cluster.
              Acceptable values are 1 to 512, inclusive.
            type: string
            format: int64
          resources:
            description: |-
              **[Resources](#yandex.cloud.airflow.v1.Resources)**
              Resources allocated to dag-processor instances.
            $ref: '#/definitions/Resources'
      TriggererConfig:
        type: object
        properties:
          count:
            description: |-
              **string** (int64)
              The number of triggerer instances in the cluster.
              Acceptable values are 0 to 512, inclusive.
            type: string
            format: int64
          resources:
            description: |-
              **[Resources](#yandex.cloud.airflow.v1.Resources)**
              Resources allocated to triggerer instances.
            $ref: '#/definitions/Resources'
      WorkerConfig:
        type: object
        properties:
          minCount:
            description: |-
              **string** (int64)
              The minimum number of worker instances in the cluster.
              Acceptable values are 0 to 512, inclusive.
            type: string
            format: int64
          maxCount:
            description: |-
              **string** (int64)
              The maximum number of worker instances in the cluster.
              Acceptable values are 1 to 512, inclusive.
            type: string
            format: int64
          resources:
            description: |-
              **[Resources](#yandex.cloud.airflow.v1.Resources)**
              Resources allocated to worker instances.
            $ref: '#/definitions/Resources'
      Dependencies:
        type: object
        properties:
          pipPackages:
            description: |-
              **string**
              Python packages that are installed in the cluster.
            type: array
            items:
              type: string
          debPackages:
            description: |-
              **string**
              System packages that are installed in the cluster.
            type: array
            items:
              type: string
      LockboxConfig:
        type: object
        properties:
          enabled:
            description: |-
              **boolean**
              The setting allows to enable Lockbox Secret Backend.
            type: boolean
      DatacatalogConfig:
        type: object
        properties:
          enabled:
            description: |-
              **boolean**
              The setting allows to enable sending data to Datacatalog Backend.
            type: boolean
      ClusterConfig:
        type: object
        properties:
          versionId:
            description: |-
              **string**
              Version of Apache Airflow that runs on the cluster.
              Use `airflow_version` instead.
            deprecated: true
            type: string
          airflow:
            description: |-
              **[AirflowConfig](#yandex.cloud.airflow.v1.AirflowConfig)**
              Configuration of the Apache Airflow application itself.
            $ref: '#/definitions/AirflowConfig'
          webserver:
            description: |-
              **[WebserverConfig](#yandex.cloud.airflow.v1.WebserverConfig)**
              Required field. Configuration of webserver instances.
            $ref: '#/definitions/WebserverConfig'
          scheduler:
            description: |-
              **[SchedulerConfig](#yandex.cloud.airflow.v1.SchedulerConfig)**
              Required field. Configuration of scheduler instances.
            $ref: '#/definitions/SchedulerConfig'
          dagProcessor:
            description: |-
              **[DagProcessorConfig](#yandex.cloud.airflow.v1.DagProcessorConfig)**
              Configuration of dag-processor instances.
            $ref: '#/definitions/DagProcessorConfig'
          triggerer:
            description: |-
              **[TriggererConfig](#yandex.cloud.airflow.v1.TriggererConfig)**
              Configuration of triggerer instances.
            $ref: '#/definitions/TriggererConfig'
          worker:
            description: |-
              **[WorkerConfig](#yandex.cloud.airflow.v1.WorkerConfig)**
              Required field. Configuration of worker instances.
            $ref: '#/definitions/WorkerConfig'
          dependencies:
            description: |-
              **[Dependencies](#yandex.cloud.airflow.v1.Dependencies)**
              The list of additional packages installed in the cluster.
            $ref: '#/definitions/Dependencies'
          lockbox:
            description: |-
              **[LockboxConfig](#yandex.cloud.airflow.v1.LockboxConfig)**
              Configuration of Lockbox Secret Backend.
            $ref: '#/definitions/LockboxConfig'
          airflowVersion:
            description: |-
              **string**
              Apache Airflow version. Format: "Major.Minor"
            type: string
          pythonVersion:
            description: |-
              **string**
              Python version. Format: "Major.Minor"
            type: string
          datacatalog:
            description: |-
              **[DatacatalogConfig](#yandex.cloud.airflow.v1.DatacatalogConfig)**
              Configuration for datacatalog integration.
            $ref: '#/definitions/DatacatalogConfig'
        required:
          - webserver
          - scheduler
          - worker
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
      S3Config:
        type: object
        properties:
          bucket:
            description: |-
              **string**
              The name of the Object Storage bucket that stores DAG files used in the cluster.
            type: string
      GitSyncConfig:
        type: object
        properties:
          repo:
            description: |-
              **string**
              Required field. Git repository URL.
            type: string
          branch:
            description: |-
              **string**
              Required field. Git branch name to sync from.
            type: string
          subPath:
            description: |-
              **string**
              Subdirectory path within the repository containing DAG files.
            type: string
          sshKey:
            description: |-
              **string**
              SSH private key for repository authentication.
            type: string
        required:
          - repo
          - branch
      CodeSyncConfig:
        type: object
        properties:
          s3:
            description: |-
              **[S3Config](#yandex.cloud.airflow.v1.S3Config)**
              Configuration for s3 folder for dags
              Includes only one of the fields `s3`, `gitSync`.
            $ref: '#/definitions/S3Config'
          gitSync:
            description: |-
              **[GitSyncConfig](#yandex.cloud.airflow.v1.GitSyncConfig)**
              Configuration for git repository for dags
              Includes only one of the fields `s3`, `gitSync`.
            $ref: '#/definitions/GitSyncConfig'
        oneOf:
          - required:
              - s3
          - required:
              - gitSync
      LoggingConfig:
        type: object
        properties:
          folderId:
            description: |-
              **string**
              Logs should be written to default log group for specified folder.
              Value must match the regular expression ` ([a-zA-Z][-a-zA-Z0-9_.]{0,63})? `.
              Includes only one of the fields `folderId`, `logGroupId`.
              Destination of log records.
            pattern: ([a-zA-Z][-a-zA-Z0-9_.]{0,63})?
            type: string
          logGroupId:
            description: |-
              **string**
              Logs should be written to log group resolved by ID.
              Value must match the regular expression ` ([a-zA-Z][-a-zA-Z0-9_.]{0,63})? `.
              Includes only one of the fields `folderId`, `logGroupId`.
              Destination of log records.
            pattern: ([a-zA-Z][-a-zA-Z0-9_.]{0,63})?
            type: string
          enabled:
            description: |-
              **boolean**
              Logs generated by the Airflow components are delivered to Cloud Logging.
            type: boolean
          minLevel:
            description: |-
              **enum** (Level)
              Minimum log entry level.
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
      AnytimeMaintenanceWindow:
        type: object
        properties: {}
      WeeklyMaintenanceWindow:
        type: object
        properties:
          day:
            description: |-
              **enum** (WeekDay)
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
              Acceptable values are 1 to 24, inclusive.
            type: string
            format: int64
      MaintenanceWindow:
        type: object
        properties:
          anytime:
            description: |-
              **object**
              Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`.
            $ref: '#/definitions/AnytimeMaintenanceWindow'
          weeklyMaintenanceWindow:
            description: |-
              **[WeeklyMaintenanceWindow](#yandex.cloud.airflow.v1.WeeklyMaintenanceWindow)**
              Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`.
            $ref: '#/definitions/WeeklyMaintenanceWindow'
        oneOf:
          - required:
              - anytime
          - required:
              - weeklyMaintenanceWindow
---

# Managed Service for Apache Airflow™ API, REST: Cluster.Create

Creates an Apache Airflow cluster.

## HTTP request

```
POST https://airflow.{{ api-host }}/managed-airflow/v1/clusters
```

## Body parameters {#yandex.cloud.airflow.v1.CreateClusterRequest}

```json
{
  "folderId": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "config": {
    "versionId": "string",
    "airflow": {
      "config": "object"
    },
    "webserver": {
      "count": "string",
      "resources": {
        "resourcePresetId": "string"
      }
    },
    "scheduler": {
      "count": "string",
      "resources": {
        "resourcePresetId": "string"
      }
    },
    "dagProcessor": {
      "count": "string",
      "resources": {
        "resourcePresetId": "string"
      }
    },
    "triggerer": {
      "count": "string",
      "resources": {
        "resourcePresetId": "string"
      }
    },
    "worker": {
      "minCount": "string",
      "maxCount": "string",
      "resources": {
        "resourcePresetId": "string"
      }
    },
    "dependencies": {
      "pipPackages": [
        "string"
      ],
      "debPackages": [
        "string"
      ]
    },
    "lockbox": {
      "enabled": "boolean"
    },
    "airflowVersion": "string",
    "pythonVersion": "string",
    "datacatalog": {
      "enabled": "boolean"
    }
  },
  "network": {
    "subnetIds": [
      "string"
    ],
    "securityGroupIds": [
      "string"
    ]
  },
  "codeSync": {
    // Includes only one of the fields `s3`, `gitSync`
    "s3": {
      "bucket": "string"
    },
    "gitSync": {
      "repo": "string",
      "branch": "string",
      "subPath": "string",
      "sshKey": "string"
    }
    // end of the list of possible fields
  },
  "deletionProtection": "boolean",
  "serviceAccountId": "string",
  "logging": {
    // Includes only one of the fields `folderId`, `logGroupId`
    "folderId": "string",
    "logGroupId": "string",
    // end of the list of possible fields
    "enabled": "boolean",
    "minLevel": "string"
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
  "adminPassword": "string"
}
```

#|
||Field | Description ||
|| folderId | **string**

Required field. ID of the folder to create Apache Airflow cluster in.

The maximum string length in characters is 50. ||
|| name | **string**

Required field. Name of the Apache Airflow cluster. The name must be unique within the folder.

The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `. ||
|| description | **string**

Description of the Apache Airflow cluster.

The maximum string length in characters is 256. ||
|| labels | **object** (map<**string**, **string**>)

Custom labels for the Apache Airflow cluster as `` key:value `` pairs. For example, "env": "prod".

The maximum string length in characters for each value is 63. The maximum string length in characters for each key is 63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `. Each value must match the regular expression ` [-_0-9a-z]* `. No more than 64 per resource. ||
|| config | **[ClusterConfig](#yandex.cloud.airflow.v1.ClusterConfig)**

Required field. Configuration of Apache Airflow components. ||
|| network | **[NetworkConfig](#yandex.cloud.airflow.v1.NetworkConfig)**

Network related configuration options. ||
|| codeSync | **[CodeSyncConfig](#yandex.cloud.airflow.v1.CodeSyncConfig)**

Parameters of the location and access to the code that will be executed in the cluster. ||
|| deletionProtection | **boolean**

Deletion Protection inhibits deletion of the cluster. ||
|| serviceAccountId | **string**

Service account used to access Cloud resources.
For more information, see [documentation](/docs/managed-airflow/concepts/impersonation).

The maximum string length in characters is 50. ||
|| logging | **[LoggingConfig](#yandex.cloud.airflow.v1.LoggingConfig)**

Cloud Logging configuration. ||
|| maintenanceWindow | **[MaintenanceWindow](#yandex.cloud.airflow.v1.MaintenanceWindow)**

Window of maintenance operations. ||
|| adminPassword | **string**

Required field. Password of user `admin`.

The string length in characters must be 8-128. ||
|#

## ClusterConfig {#yandex.cloud.airflow.v1.ClusterConfig}

#|
||Field | Description ||
|| versionId | **string**

Version of Apache Airflow that runs on the cluster.
Use `airflow_version` instead. ||
|| airflow | **[AirflowConfig](#yandex.cloud.airflow.v1.AirflowConfig)**

Configuration of the Apache Airflow application itself. ||
|| webserver | **[WebserverConfig](#yandex.cloud.airflow.v1.WebserverConfig)**

Required field. Configuration of webserver instances. ||
|| scheduler | **[SchedulerConfig](#yandex.cloud.airflow.v1.SchedulerConfig)**

Required field. Configuration of scheduler instances. ||
|| dagProcessor | **[DagProcessorConfig](#yandex.cloud.airflow.v1.DagProcessorConfig)**

Configuration of dag-processor instances. ||
|| triggerer | **[TriggererConfig](#yandex.cloud.airflow.v1.TriggererConfig)**

Configuration of triggerer instances. ||
|| worker | **[WorkerConfig](#yandex.cloud.airflow.v1.WorkerConfig)**

Required field. Configuration of worker instances. ||
|| dependencies | **[Dependencies](#yandex.cloud.airflow.v1.Dependencies)**

The list of additional packages installed in the cluster. ||
|| lockbox | **[LockboxConfig](#yandex.cloud.airflow.v1.LockboxConfig)**

Configuration of Lockbox Secret Backend. ||
|| airflowVersion | **string**

Apache Airflow version. Format: "Major.Minor" ||
|| pythonVersion | **string**

Python version. Format: "Major.Minor" ||
|| datacatalog | **[DatacatalogConfig](#yandex.cloud.airflow.v1.DatacatalogConfig)**

Configuration for datacatalog integration. ||
|#

## AirflowConfig {#yandex.cloud.airflow.v1.AirflowConfig}

#|
||Field | Description ||
|| config | **object** (map<**string**, **string**>)

Properties to be passed to Apache Airflow configuration file. ||
|#

## WebserverConfig {#yandex.cloud.airflow.v1.WebserverConfig}

#|
||Field | Description ||
|| count | **string** (int64)

The number of webserver instances in the cluster.

Acceptable values are 1 to 512, inclusive. ||
|| resources | **[Resources](#yandex.cloud.airflow.v1.Resources)**

Resources allocated to webserver instances. ||
|#

## Resources {#yandex.cloud.airflow.v1.Resources}

#|
||Field | Description ||
|| resourcePresetId | **string**

ID of the preset for computational resources available to an instance (CPU, memory etc.). ||
|#

## SchedulerConfig {#yandex.cloud.airflow.v1.SchedulerConfig}

#|
||Field | Description ||
|| count | **string** (int64)

The number of scheduler instances in the cluster.

Acceptable values are 1 to 512, inclusive. ||
|| resources | **[Resources](#yandex.cloud.airflow.v1.Resources)**

Resources allocated to scheduler instances. ||
|#

## DagProcessorConfig {#yandex.cloud.airflow.v1.DagProcessorConfig}

#|
||Field | Description ||
|| count | **string** (int64)

The number of dag-processor instances in the cluster.

Acceptable values are 1 to 512, inclusive. ||
|| resources | **[Resources](#yandex.cloud.airflow.v1.Resources)**

Resources allocated to dag-processor instances. ||
|#

## TriggererConfig {#yandex.cloud.airflow.v1.TriggererConfig}

#|
||Field | Description ||
|| count | **string** (int64)

The number of triggerer instances in the cluster.

Acceptable values are 0 to 512, inclusive. ||
|| resources | **[Resources](#yandex.cloud.airflow.v1.Resources)**

Resources allocated to triggerer instances. ||
|#

## WorkerConfig {#yandex.cloud.airflow.v1.WorkerConfig}

#|
||Field | Description ||
|| minCount | **string** (int64)

The minimum number of worker instances in the cluster.

Acceptable values are 0 to 512, inclusive. ||
|| maxCount | **string** (int64)

The maximum number of worker instances in the cluster.

Acceptable values are 1 to 512, inclusive. ||
|| resources | **[Resources](#yandex.cloud.airflow.v1.Resources)**

Resources allocated to worker instances. ||
|#

## Dependencies {#yandex.cloud.airflow.v1.Dependencies}

#|
||Field | Description ||
|| pipPackages[] | **string**

Python packages that are installed in the cluster. ||
|| debPackages[] | **string**

System packages that are installed in the cluster. ||
|#

## LockboxConfig {#yandex.cloud.airflow.v1.LockboxConfig}

#|
||Field | Description ||
|| enabled | **boolean**

The setting allows to enable Lockbox Secret Backend. ||
|#

## DatacatalogConfig {#yandex.cloud.airflow.v1.DatacatalogConfig}

#|
||Field | Description ||
|| enabled | **boolean**

The setting allows to enable sending data to Datacatalog Backend. ||
|#

## NetworkConfig {#yandex.cloud.airflow.v1.NetworkConfig}

#|
||Field | Description ||
|| subnetIds[] | **string**

IDs of VPC network subnets where instances of the cluster are attached. ||
|| securityGroupIds[] | **string**

User security groups. ||
|#

## CodeSyncConfig {#yandex.cloud.airflow.v1.CodeSyncConfig}

#|
||Field | Description ||
|| s3 | **[S3Config](#yandex.cloud.airflow.v1.S3Config)**

Configuration for s3 folder for dags

Includes only one of the fields `s3`, `gitSync`. ||
|| gitSync | **[GitSyncConfig](#yandex.cloud.airflow.v1.GitSyncConfig)**

Configuration for git repository for dags

Includes only one of the fields `s3`, `gitSync`. ||
|#

## S3Config {#yandex.cloud.airflow.v1.S3Config}

#|
||Field | Description ||
|| bucket | **string**

The name of the Object Storage bucket that stores DAG files used in the cluster. ||
|#

## GitSyncConfig {#yandex.cloud.airflow.v1.GitSyncConfig}

#|
||Field | Description ||
|| repo | **string**

Required field. Git repository URL. ||
|| branch | **string**

Required field. Git branch name to sync from. ||
|| subPath | **string**

Subdirectory path within the repository containing DAG files. ||
|| sshKey | **string**

SSH private key for repository authentication. ||
|#

## LoggingConfig {#yandex.cloud.airflow.v1.LoggingConfig}

#|
||Field | Description ||
|| folderId | **string**

Logs should be written to default log group for specified folder.

Value must match the regular expression ` ([a-zA-Z][-a-zA-Z0-9_.]{0,63})? `.

Includes only one of the fields `folderId`, `logGroupId`.

Destination of log records. ||
|| logGroupId | **string**

Logs should be written to log group resolved by ID.

Value must match the regular expression ` ([a-zA-Z][-a-zA-Z0-9_.]{0,63})? `.

Includes only one of the fields `folderId`, `logGroupId`.

Destination of log records. ||
|| enabled | **boolean**

Logs generated by the Airflow components are delivered to Cloud Logging. ||
|| minLevel | **enum** (Level)

Minimum log entry level.
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

## MaintenanceWindow {#yandex.cloud.airflow.v1.MaintenanceWindow}

#|
||Field | Description ||
|| anytime | **object**

Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`. ||
|| weeklyMaintenanceWindow | **[WeeklyMaintenanceWindow](#yandex.cloud.airflow.v1.WeeklyMaintenanceWindow)**

Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`. ||
|#

## WeeklyMaintenanceWindow {#yandex.cloud.airflow.v1.WeeklyMaintenanceWindow}

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

Hour of the day in UTC.

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