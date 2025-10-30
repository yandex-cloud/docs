---
editable: false
apiPlayground:
  - url: https://airflow.{{ api-host }}/managed-airflow/v1/clusters/{clusterId}
    method: patch
    path:
      type: object
      properties:
        clusterId:
          description: |-
            **string**
            Required field. ID of the Apache Airflow Cluster resource to update.
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
            New name of the cluster.
          pattern: '|[a-z][-a-z0-9]{1,61}[a-z0-9]'
          type: string
        description:
          description: |-
            **string**
            New description of the Apache Airflow cluster.
          type: string
        labels:
          description: |-
            **object** (map<**string**, **string**>)
            Custom labels for the Apache Airflow cluster as `` key:value `` pairs. For example, "env": "prod".
            The new set of labels will completely replace the old ones. To add a label, request the current
            set with the [ClusterService.Get](/docs/managed-airflow/api-ref/Cluster/get#Get) method, then send an [ClusterService.Update](#Update) request with the new label added to the set.
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
        configSpec:
          description: |-
            **[UpdateClusterConfigSpec](#yandex.cloud.airflow.v1.UpdateClusterConfigSpec)**
            Configuration of Apache Airflow components.
          $ref: '#/definitions/UpdateClusterConfigSpec'
        codeSync:
          description: |-
            **[CodeSyncConfig](#yandex.cloud.airflow.v1.CodeSyncConfig)**
            Parameters of the location and access to the code that will be executed in the cluster.
          $ref: '#/definitions/CodeSyncConfig'
        networkSpec:
          description: |-
            **[UpdateNetworkConfigSpec](#yandex.cloud.airflow.v1.UpdateNetworkConfigSpec)**
            Network related configuration options.
          $ref: '#/definitions/UpdateNetworkConfigSpec'
        deletionProtection:
          description: |-
            **boolean**
            Deletion Protection inhibits deletion of the cluster
          type: boolean
        serviceAccountId:
          description: |-
            **string**
            Service account used to access Cloud resources.
            For more information, see [documentation](/docs/managed-airflow/concepts/impersonation).
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
            type: string
            format: int64
          resources:
            description: |-
              **[Resources](#yandex.cloud.airflow.v1.Resources)**
              Resources allocated to scheduler instances.
            $ref: '#/definitions/Resources'
      TriggererConfig:
        type: object
        properties:
          count:
            description: |-
              **string** (int64)
              The number of triggerer instances in the cluster.
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
            type: string
            format: int64
          maxCount:
            description: |-
              **string** (int64)
              The maximum number of worker instances in the cluster.
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
      DagProcessorConfig:
        type: object
        properties:
          count:
            description: |-
              **string** (int64)
              The number of dag-processor instances in the cluster.
            type: string
            format: int64
          resources:
            description: |-
              **[Resources](#yandex.cloud.airflow.v1.Resources)**
              Resources allocated to dag-processor instances.
            $ref: '#/definitions/Resources'
      UpdateClusterConfigSpec:
        type: object
        properties:
          airflow:
            description: |-
              **[AirflowConfig](#yandex.cloud.airflow.v1.AirflowConfig)**
              Configuration of the Apache Airflow application itself.
            $ref: '#/definitions/AirflowConfig'
          webserver:
            description: |-
              **[WebserverConfig](#yandex.cloud.airflow.v1.WebserverConfig)**
              Configuration of webserver instances.
            $ref: '#/definitions/WebserverConfig'
          scheduler:
            description: |-
              **[SchedulerConfig](#yandex.cloud.airflow.v1.SchedulerConfig)**
              Configuration of scheduler instances.
            $ref: '#/definitions/SchedulerConfig'
          triggerer:
            description: |-
              **[TriggererConfig](#yandex.cloud.airflow.v1.TriggererConfig)**
              Configuration of triggerer instances.
            $ref: '#/definitions/TriggererConfig'
          worker:
            description: |-
              **[WorkerConfig](#yandex.cloud.airflow.v1.WorkerConfig)**
              Configuration of worker instances.
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
          dagProcessor:
            description: |-
              **[DagProcessorConfig](#yandex.cloud.airflow.v1.DagProcessorConfig)**
              Configuration of dag-processor instances.
            $ref: '#/definitions/DagProcessorConfig'
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
              Includes only one of the fields `s3`, `gitSync`.
            $ref: '#/definitions/S3Config'
          gitSync:
            description: |-
              **[GitSyncConfig](#yandex.cloud.airflow.v1.GitSyncConfig)**
              Includes only one of the fields `s3`, `gitSync`.
            $ref: '#/definitions/GitSyncConfig'
        oneOf:
          - required:
              - s3
          - required:
              - gitSync
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
      LoggingConfig:
        type: object
        properties:
          enabled:
            description: |-
              **boolean**
              Logs generated by the Airflow components are delivered to Cloud Logging.
            type: boolean
          folderId:
            description: |-
              **string**
              Logs should be written to default log group for specified folder.
              Includes only one of the fields `folderId`, `logGroupId`.
              Destination of log records.
            pattern: ([a-zA-Z][-a-zA-Z0-9_.]{0,63})?
            type: string
          logGroupId:
            description: |-
              **string**
              Logs should be written to log group resolved by ID.
              Includes only one of the fields `folderId`, `logGroupId`.
              Destination of log records.
            pattern: ([a-zA-Z][-a-zA-Z0-9_.]{0,63})?
            type: string
          minLevel:
            description: |-
              **enum** (Level)
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
sourcePath: en/_api-ref/airflow/v1/api-ref/Cluster/update.md
---

# Managed Service for Apache Airflow™ API, REST: Cluster.Update

Updates the specified Apache Airflow cluster.

## HTTP request

```
PATCH https://airflow.{{ api-host }}/managed-airflow/v1/clusters/{clusterId}
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the Apache Airflow Cluster resource to update. ||
|#

## Body parameters {#yandex.cloud.airflow.v1.UpdateClusterRequest}

```json
{
  "updateMask": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "configSpec": {
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
    "dagProcessor": {
      "count": "string",
      "resources": {
        "resourcePresetId": "string"
      }
    }
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
  "networkSpec": {
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
|| updateMask | **string** (field-mask)

A comma-separated names off ALL fields to be updated.
Only the specified fields will be changed. The others will be left untouched.
If the field is specified in `` updateMask `` and no value for that field was sent in the request,
the field's value will be reset to the default. The default value for most fields is null or 0.

If `` updateMask `` is not sent in the request, all fields' values will be updated.
Fields specified in the request will be updated to provided values.
The rest of the fields will be reset to the default. ||
|| name | **string**

New name of the cluster. ||
|| description | **string**

New description of the Apache Airflow cluster. ||
|| labels | **object** (map<**string**, **string**>)

Custom labels for the Apache Airflow cluster as `` key:value `` pairs. For example, "env": "prod".

The new set of labels will completely replace the old ones. To add a label, request the current
set with the [ClusterService.Get](/docs/managed-airflow/api-ref/Cluster/get#Get) method, then send an [ClusterService.Update](#Update) request with the new label added to the set. ||
|| configSpec | **[UpdateClusterConfigSpec](#yandex.cloud.airflow.v1.UpdateClusterConfigSpec)**

Configuration of Apache Airflow components. ||
|| codeSync | **[CodeSyncConfig](#yandex.cloud.airflow.v1.CodeSyncConfig)**

Parameters of the location and access to the code that will be executed in the cluster. ||
|| networkSpec | **[UpdateNetworkConfigSpec](#yandex.cloud.airflow.v1.UpdateNetworkConfigSpec)**

Network related configuration options. ||
|| deletionProtection | **boolean**

Deletion Protection inhibits deletion of the cluster ||
|| serviceAccountId | **string**

Service account used to access Cloud resources.
For more information, see [documentation](/docs/managed-airflow/concepts/impersonation). ||
|| logging | **[LoggingConfig](#yandex.cloud.airflow.v1.LoggingConfig)**

Cloud Logging configuration. ||
|| maintenanceWindow | **[MaintenanceWindow](#yandex.cloud.airflow.v1.MaintenanceWindow)**

Window of maintenance operations. ||
|#

## UpdateClusterConfigSpec {#yandex.cloud.airflow.v1.UpdateClusterConfigSpec}

#|
||Field | Description ||
|| airflow | **[AirflowConfig](#yandex.cloud.airflow.v1.AirflowConfig)**

Configuration of the Apache Airflow application itself. ||
|| webserver | **[WebserverConfig](#yandex.cloud.airflow.v1.WebserverConfig)**

Configuration of webserver instances. ||
|| scheduler | **[SchedulerConfig](#yandex.cloud.airflow.v1.SchedulerConfig)**

Configuration of scheduler instances. ||
|| triggerer | **[TriggererConfig](#yandex.cloud.airflow.v1.TriggererConfig)**

Configuration of triggerer instances. ||
|| worker | **[WorkerConfig](#yandex.cloud.airflow.v1.WorkerConfig)**

Configuration of worker instances. ||
|| dependencies | **[Dependencies](#yandex.cloud.airflow.v1.Dependencies)**

The list of additional packages installed in the cluster. ||
|| lockbox | **[LockboxConfig](#yandex.cloud.airflow.v1.LockboxConfig)**

Configuration of Lockbox Secret Backend. ||
|| airflowVersion | **string**

Apache Airflow version. Format: "Major.Minor" ||
|| pythonVersion | **string**

Python version. Format: "Major.Minor" ||
|| dagProcessor | **[DagProcessorConfig](#yandex.cloud.airflow.v1.DagProcessorConfig)**

Configuration of dag-processor instances. ||
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

The number of webserver instances in the cluster. ||
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

The number of scheduler instances in the cluster. ||
|| resources | **[Resources](#yandex.cloud.airflow.v1.Resources)**

Resources allocated to scheduler instances. ||
|#

## TriggererConfig {#yandex.cloud.airflow.v1.TriggererConfig}

#|
||Field | Description ||
|| count | **string** (int64)

The number of triggerer instances in the cluster. ||
|| resources | **[Resources](#yandex.cloud.airflow.v1.Resources)**

Resources allocated to triggerer instances. ||
|#

## WorkerConfig {#yandex.cloud.airflow.v1.WorkerConfig}

#|
||Field | Description ||
|| minCount | **string** (int64)

The minimum number of worker instances in the cluster. ||
|| maxCount | **string** (int64)

The maximum number of worker instances in the cluster. ||
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

## DagProcessorConfig {#yandex.cloud.airflow.v1.DagProcessorConfig}

#|
||Field | Description ||
|| count | **string** (int64)

The number of dag-processor instances in the cluster. ||
|| resources | **[Resources](#yandex.cloud.airflow.v1.Resources)**

Resources allocated to dag-processor instances. ||
|#

## CodeSyncConfig {#yandex.cloud.airflow.v1.CodeSyncConfig}

#|
||Field | Description ||
|| s3 | **[S3Config](#yandex.cloud.airflow.v1.S3Config)**

Includes only one of the fields `s3`, `gitSync`. ||
|| gitSync | **[GitSyncConfig](#yandex.cloud.airflow.v1.GitSyncConfig)**

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

## UpdateNetworkConfigSpec {#yandex.cloud.airflow.v1.UpdateNetworkConfigSpec}

#|
||Field | Description ||
|| securityGroupIds[] | **string**

User security groups. ||
|#

## LoggingConfig {#yandex.cloud.airflow.v1.LoggingConfig}

#|
||Field | Description ||
|| enabled | **boolean**

Logs generated by the Airflow components are delivered to Cloud Logging. ||
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
      "dagProcessor": {
        "count": "string",
        "resources": {
          "resourcePresetId": "string"
        }
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
    "webserverUrl": "string",
    "serviceAccountId": "string",
    "logging": {
      "enabled": "boolean",
      // Includes only one of the fields `folderId`, `logGroupId`
      "folderId": "string",
      "logGroupId": "string",
      // end of the list of possible fields
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
|| metadata | **[UpdateClusterMetadata](#yandex.cloud.airflow.v1.UpdateClusterMetadata)**

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
|| response | **[Cluster](#yandex.cloud.airflow.v1.Cluster)**

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

## UpdateClusterMetadata {#yandex.cloud.airflow.v1.UpdateClusterMetadata}

#|
||Field | Description ||
|| clusterId | **string**

ID of the Apache Airflow Cluster resource that is being updated. ||
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

## Cluster {#yandex.cloud.airflow.v1.Cluster}

Apache Airflow cluster.

#|
||Field | Description ||
|| id | **string**

Unique ID of the Apache Airflow cluster.
This ID is assigned by Cloud during cluster creation. ||
|| folderId | **string**

ID of the folder that the Apache Airflow cluster belongs to. ||
|| createdAt | **string** (date-time)

The time when the Apache Airflow cluster was created.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| name | **string**

Name of the Apache Airflow cluster.
The name is unique within the folder. 1-64 characters long. ||
|| description | **string**

Description of the Apache Airflow cluster. 0-256 characters long. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs. Maximum of 64 per resource. ||
|| monitoring[] | **[Monitoring](#yandex.cloud.airflow.v1.Monitoring)**

Monitoring systems relevant to the Apache Airflow cluster. ||
|| config | **[ClusterConfig](#yandex.cloud.airflow.v1.ClusterConfig)**

Configuration of Apache Airflow components. ||
|| health | **enum** (Health)

Aggregated cluster health.

- `HEALTH_UNKNOWN`: Cluster is in unknown state (we have no data).
- `ALIVE`: Cluster is alive and well.
- `DEAD`: Cluster is inoperable (it cannot perform any of its essential functions).
- `DEGRADED`: Cluster is partially alive (it can perform some of its essential functions). ||
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
|| network | **[NetworkConfig](#yandex.cloud.airflow.v1.NetworkConfig)**

Network related configuration options. ||
|| codeSync | **[CodeSyncConfig](#yandex.cloud.airflow.v1.CodeSyncConfig2)**

Parameters of the location and access to the code that will be executed in the cluster. ||
|| deletionProtection | **boolean**

Deletion Protection inhibits deletion of the cluster. ||
|| webserverUrl | **string**

Address of Apache Airflow web UI. ||
|| serviceAccountId | **string**

Service account used to access Cloud resources.
For more information, see [documentation](/docs/managed-airflow/concepts/impersonation). ||
|| logging | **[LoggingConfig](#yandex.cloud.airflow.v1.LoggingConfig2)**

Cloud Logging configuration. ||
|| maintenanceWindow | **[MaintenanceWindow](#yandex.cloud.airflow.v1.MaintenanceWindow2)**

Window of maintenance operations. ||
|| plannedOperation | **[MaintenanceOperation](#yandex.cloud.airflow.v1.MaintenanceOperation)**

Maintenance operation planned at nearest maintenance_window. ||
|#

## Monitoring {#yandex.cloud.airflow.v1.Monitoring}

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

## ClusterConfig {#yandex.cloud.airflow.v1.ClusterConfig}

#|
||Field | Description ||
|| versionId | **string**

Version of Apache Airflow that runs on the cluster.
Use `airflow_version` instead. ||
|| airflow | **[AirflowConfig](#yandex.cloud.airflow.v1.AirflowConfig2)**

Configuration of the Apache Airflow application itself. ||
|| webserver | **[WebserverConfig](#yandex.cloud.airflow.v1.WebserverConfig2)**

Required field. Configuration of webserver instances. ||
|| scheduler | **[SchedulerConfig](#yandex.cloud.airflow.v1.SchedulerConfig2)**

Required field. Configuration of scheduler instances. ||
|| triggerer | **[TriggererConfig](#yandex.cloud.airflow.v1.TriggererConfig2)**

Configuration of triggerer instances. ||
|| worker | **[WorkerConfig](#yandex.cloud.airflow.v1.WorkerConfig2)**

Required field. Configuration of worker instances. ||
|| dependencies | **[Dependencies](#yandex.cloud.airflow.v1.Dependencies2)**

The list of additional packages installed in the cluster. ||
|| lockbox | **[LockboxConfig](#yandex.cloud.airflow.v1.LockboxConfig2)**

Configuration of Lockbox Secret Backend. ||
|| airflowVersion | **string**

Apache Airflow version. Format: "Major.Minor" ||
|| pythonVersion | **string**

Python version. Format: "Major.Minor" ||
|| dagProcessor | **[DagProcessorConfig](#yandex.cloud.airflow.v1.DagProcessorConfig2)**

Configuration of dag-processor instances. ||
|#

## AirflowConfig {#yandex.cloud.airflow.v1.AirflowConfig2}

#|
||Field | Description ||
|| config | **object** (map<**string**, **string**>)

Properties to be passed to Apache Airflow configuration file. ||
|#

## WebserverConfig {#yandex.cloud.airflow.v1.WebserverConfig2}

#|
||Field | Description ||
|| count | **string** (int64)

The number of webserver instances in the cluster. ||
|| resources | **[Resources](#yandex.cloud.airflow.v1.Resources2)**

Resources allocated to webserver instances. ||
|#

## Resources {#yandex.cloud.airflow.v1.Resources2}

#|
||Field | Description ||
|| resourcePresetId | **string**

ID of the preset for computational resources available to an instance (CPU, memory etc.). ||
|#

## SchedulerConfig {#yandex.cloud.airflow.v1.SchedulerConfig2}

#|
||Field | Description ||
|| count | **string** (int64)

The number of scheduler instances in the cluster. ||
|| resources | **[Resources](#yandex.cloud.airflow.v1.Resources2)**

Resources allocated to scheduler instances. ||
|#

## TriggererConfig {#yandex.cloud.airflow.v1.TriggererConfig2}

#|
||Field | Description ||
|| count | **string** (int64)

The number of triggerer instances in the cluster. ||
|| resources | **[Resources](#yandex.cloud.airflow.v1.Resources2)**

Resources allocated to triggerer instances. ||
|#

## WorkerConfig {#yandex.cloud.airflow.v1.WorkerConfig2}

#|
||Field | Description ||
|| minCount | **string** (int64)

The minimum number of worker instances in the cluster. ||
|| maxCount | **string** (int64)

The maximum number of worker instances in the cluster. ||
|| resources | **[Resources](#yandex.cloud.airflow.v1.Resources2)**

Resources allocated to worker instances. ||
|#

## Dependencies {#yandex.cloud.airflow.v1.Dependencies2}

#|
||Field | Description ||
|| pipPackages[] | **string**

Python packages that are installed in the cluster. ||
|| debPackages[] | **string**

System packages that are installed in the cluster. ||
|#

## LockboxConfig {#yandex.cloud.airflow.v1.LockboxConfig2}

#|
||Field | Description ||
|| enabled | **boolean**

The setting allows to enable Lockbox Secret Backend. ||
|#

## DagProcessorConfig {#yandex.cloud.airflow.v1.DagProcessorConfig2}

#|
||Field | Description ||
|| count | **string** (int64)

The number of dag-processor instances in the cluster. ||
|| resources | **[Resources](#yandex.cloud.airflow.v1.Resources2)**

Resources allocated to dag-processor instances. ||
|#

## NetworkConfig {#yandex.cloud.airflow.v1.NetworkConfig}

#|
||Field | Description ||
|| subnetIds[] | **string**

IDs of VPC network subnets where instances of the cluster are attached. ||
|| securityGroupIds[] | **string**

User security groups. ||
|#

## CodeSyncConfig {#yandex.cloud.airflow.v1.CodeSyncConfig2}

#|
||Field | Description ||
|| s3 | **[S3Config](#yandex.cloud.airflow.v1.S3Config2)**

Includes only one of the fields `s3`, `gitSync`. ||
|| gitSync | **[GitSyncConfig](#yandex.cloud.airflow.v1.GitSyncConfig2)**

Includes only one of the fields `s3`, `gitSync`. ||
|#

## S3Config {#yandex.cloud.airflow.v1.S3Config2}

#|
||Field | Description ||
|| bucket | **string**

The name of the Object Storage bucket that stores DAG files used in the cluster. ||
|#

## GitSyncConfig {#yandex.cloud.airflow.v1.GitSyncConfig2}

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

## LoggingConfig {#yandex.cloud.airflow.v1.LoggingConfig2}

#|
||Field | Description ||
|| enabled | **boolean**

Logs generated by the Airflow components are delivered to Cloud Logging. ||
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

## MaintenanceWindow {#yandex.cloud.airflow.v1.MaintenanceWindow2}

#|
||Field | Description ||
|| anytime | **object**

Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`. ||
|| weeklyMaintenanceWindow | **[WeeklyMaintenanceWindow](#yandex.cloud.airflow.v1.WeeklyMaintenanceWindow2)**

Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`. ||
|#

## WeeklyMaintenanceWindow {#yandex.cloud.airflow.v1.WeeklyMaintenanceWindow2}

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

## MaintenanceOperation {#yandex.cloud.airflow.v1.MaintenanceOperation}

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