---
editable: false
apiPlayground:
  - url: https://{{ api-host-mdb }}/managed-opensearch/v1/clusters
    method: post
    path: null
    query: null
    body:
      type: object
      properties:
        folderId:
          description: |-
            **string**
            Required field. ID of the folder to create the OpenSearch cluster in.
          type: string
        name:
          description: |-
            **string**
            Required field. Name of the OpenSearch cluster. The name must be unique within the folder.
          pattern: '[a-zA-Z0-9_-]*'
          type: string
        description:
          description: |-
            **string**
            Description of the OpenSearch cluster.
          type: string
        labels:
          description: |-
            **object** (map<**string**, **string**>)
            Custom labels for the OpenSearch cluster as `key:value` pairs.
            For example, `"project": "mvp"` or `"source": "dictionary"`.
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
        environment:
          description: |-
            **enum** (Environment)
            Deployment environment of the OpenSearch cluster.
            - `ENVIRONMENT_UNSPECIFIED`
            - `PRODUCTION`: Stable environment with a conservative update policy:
            only hotfixes are applied during regular maintenance.
            - `PRESTABLE`: Environment with more aggressive update policy: new versions
            are rolled out irrespective of backward compatibility.
          type: string
          enum:
            - ENVIRONMENT_UNSPECIFIED
            - PRODUCTION
            - PRESTABLE
        configSpec:
          description: |-
            **[ConfigCreateSpec](#yandex.cloud.mdb.opensearch.v1.ConfigCreateSpec)**
            Required field. OpenSearch cluster configuration.
          $ref: '#/definitions/ConfigCreateSpec'
        networkId:
          description: |-
            **string**
            Required field. ID of the network to create the cluster in.
          type: string
        securityGroupIds:
          description: |-
            **string**
            User security groups.
          type: array
          items:
            type: string
        serviceAccountId:
          description: |-
            **string**
            ID of the service account used to access Object Storage.
          type: string
        deletionProtection:
          description: |-
            **boolean**
            Determines whether the cluster is protected from being deleted.
          type: boolean
        maintenanceWindow:
          description: |-
            **[MaintenanceWindow](#yandex.cloud.mdb.opensearch.v1.MaintenanceWindow)**
            Cluster maintenance window. Should be defined by either one of the two options.
          $ref: '#/definitions/MaintenanceWindow'
        diskEncryptionKeyId:
          description: |-
            **string**
            ID of the key to encrypt cluster disks.
          type: string
      required:
        - folderId
        - name
        - configSpec
        - networkId
      additionalProperties: false
    definitions:
      Resources:
        type: object
        properties:
          resourcePresetId:
            description: |-
              **string**
              ID of the preset for computational resources allocated to a host.
            type: string
          diskSize:
            description: |-
              **string** (int64)
              Volume of the storage used by the host, in bytes.
            type: string
            format: int64
          diskTypeId:
            description: |-
              **string**
              Type of the storage used by the host: `network-hdd`, `network-ssd` or `local-ssd`.
            type: string
      DiskSizeAutoscaling:
        type: object
        properties:
          plannedUsageThreshold:
            description: |-
              **string** (int64)
              Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent.
            type: string
            format: int64
          emergencyUsageThreshold:
            description: |-
              **string** (int64)
              Amount of used storage for immediately  automatic disk scaling, 0 means disabled, in percent.
            type: string
            format: int64
          diskSizeLimit:
            description: |-
              **string** (int64)
              Limit on how large the storage for database instances can automatically grow, in bytes.
            type: string
            format: int64
      NodeGroup:
        type: object
        properties:
          name:
            description: |-
              **string**
              Required field. Name of the group.
            pattern: '[a-zA-Z0-9_-]*'
            type: string
          resources:
            description: |-
              **[Resources](#yandex.cloud.mdb.opensearch.v1.Resources)**
              Resources allocated to the hosts.
            $ref: '#/definitions/Resources'
          hostsCount:
            description: |-
              **string** (int64)
              Number of hosts in the group.
            type: string
            format: int64
          zoneIds:
            description: |-
              **string**
              IDs of the availability zones the hosts belong to.
            type: array
            items:
              type: string
          subnetIds:
            description: |-
              **string**
              IDs of the subnets that the hosts belong to.
            type: array
            items:
              type: string
          assignPublicIp:
            description: |-
              **boolean**
              Determines whether a public IP is assigned to the hosts in the group.
            type: boolean
          roles:
            description: |-
              **enum** (GroupRole)
              Roles of the hosts in the group.
              - `GROUP_ROLE_UNSPECIFIED`
              - `DATA`
              - `MANAGER`
            type: array
            items:
              type: string
              enum:
                - GROUP_ROLE_UNSPECIFIED
                - DATA
                - MANAGER
          diskSizeAutoscaling:
            description: |-
              **[DiskSizeAutoscaling](#yandex.cloud.mdb.opensearch.v1.DiskSizeAutoscaling)**
              Disk size autoscaling settings
            $ref: '#/definitions/DiskSizeAutoscaling'
        required:
          - name
      OpenSearchConfig2:
        type: object
        properties:
          maxClauseCount:
            description: |-
              **string** (int64)
              the maximum number of allowed boolean clauses in a query
            type: string
            format: int64
          fielddataCacheSize:
            description: |-
              **string**
              the percentage or absolute value (10%, 512mb) of heap space that is allocated to fielddata
            type: string
          reindexRemoteWhitelist:
            description: '**string**'
            type: string
      KeystoreSetting:
        type: object
        properties:
          name:
            description: |-
              **string**
              Keystore entry name.
            type: string
          value:
            description: |-
              **string**
              Keystore entry value.
            type: string
      OpenSearchCreateSpec:
        type: object
        properties:
          plugins:
            description: |-
              **string**
              Names of the cluster plugins.
            type: array
            items:
              type: string
          nodeGroups:
            description: |-
              **[NodeGroup](#yandex.cloud.mdb.opensearch.v1.OpenSearchCreateSpec.NodeGroup)**
              OpenSearch type host groups of the cluster.
            type: array
            items:
              $ref: '#/definitions/NodeGroup'
          opensearchConfig_2:
            description: |-
              **[OpenSearchConfig2](#yandex.cloud.mdb.opensearch.v1.config.OpenSearchConfig2)**
              Includes only one of the fields `opensearchConfig_2`.
            $ref: '#/definitions/OpenSearchConfig2'
          keystoreSettings:
            description: |-
              **[KeystoreSetting](#yandex.cloud.mdb.opensearch.v1.KeystoreSetting)**
              Initial cluster keystore settings.
            type: array
            items:
              $ref: '#/definitions/KeystoreSetting'
        oneOf:
          - required:
              - opensearchConfig_2
      DashboardsCreateSpec:
        type: object
        properties:
          nodeGroups:
            description: |-
              **[NodeGroup](#yandex.cloud.mdb.opensearch.v1.OpenSearchCreateSpec.NodeGroup)**
              Dashboards type host groups of the cluster.
            type: array
            items:
              $ref: '#/definitions/NodeGroup'
      Access:
        type: object
        properties:
          dataTransfer:
            description: |-
              **boolean**
              Determines whether the access to Data Transfer is allowed.
            type: boolean
          serverless:
            description: |-
              **boolean**
              Determines whether the access to Serverless is allowed.
            type: boolean
      HourlySnapshotSchedule:
        type: object
        properties:
          minute:
            description: |-
              **string** (int64)
              The minute of the hour at which the backup should be created.
            type: string
            format: int64
      DailySnapshotSchedule:
        type: object
        properties:
          hour:
            description: |-
              **string** (int64)
              The hour of the day in UTC timezone at which the backup should be created.
            type: string
            format: int64
          minute:
            description: |-
              **string** (int64)
              The minute of the hour at which the backup should be created.
            type: string
            format: int64
      WeeklySnapshotSchedule:
        type: object
        properties:
          day:
            description: |-
              **enum** (WeekDay)
              Day of the week
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
              The hour of the day in UTC timezone at which the backup should be created.
            type: string
            format: int64
          minute:
            description: |-
              **string** (int64)
              The minute of the hour at which the backup should be created.
            type: string
            format: int64
      SnapshotSchedule:
        type: object
        properties:
          hourlySnapshotSchedule:
            description: |-
              **[HourlySnapshotSchedule](#yandex.cloud.mdb.opensearch.v1.HourlySnapshotSchedule)**
              Hourly based snapshot schedule
              Includes only one of the fields `hourlySnapshotSchedule`, `dailySnapshotSchedule`, `weeklySnapshotSchedule`.
            $ref: '#/definitions/HourlySnapshotSchedule'
          dailySnapshotSchedule:
            description: |-
              **[DailySnapshotSchedule](#yandex.cloud.mdb.opensearch.v1.DailySnapshotSchedule)**
              Daily based snapshot schedule
              Includes only one of the fields `hourlySnapshotSchedule`, `dailySnapshotSchedule`, `weeklySnapshotSchedule`.
            $ref: '#/definitions/DailySnapshotSchedule'
          weeklySnapshotSchedule:
            description: |-
              **[WeeklySnapshotSchedule](#yandex.cloud.mdb.opensearch.v1.WeeklySnapshotSchedule)**
              Weekly based snapshot schedule
              Includes only one of the fields `hourlySnapshotSchedule`, `dailySnapshotSchedule`, `weeklySnapshotSchedule`.
            $ref: '#/definitions/WeeklySnapshotSchedule'
        oneOf:
          - required:
              - hourlySnapshotSchedule
          - required:
              - dailySnapshotSchedule
          - required:
              - weeklySnapshotSchedule
      SnapshotManagement:
        type: object
        properties:
          snapshotSchedule:
            description: |-
              **[SnapshotSchedule](#yandex.cloud.mdb.opensearch.v1.SnapshotSchedule)**
              Snapshot creation schedule
            $ref: '#/definitions/SnapshotSchedule'
          snapshotMaxAgeDays:
            description: |-
              **string** (int64)
              Snapshot max age in days
            type: string
            format: int64
      ConfigCreateSpec:
        type: object
        properties:
          version:
            description: |-
              **string**
              OpenSearch version.
            type: string
          adminPassword:
            description: |-
              **string**
              Required field. OpenSearch admin password.
            type: string
          opensearchSpec:
            description: |-
              **[OpenSearchCreateSpec](#yandex.cloud.mdb.opensearch.v1.OpenSearchCreateSpec)**
              OpenSearch configuration.
            $ref: '#/definitions/OpenSearchCreateSpec'
          dashboardsSpec:
            description: |-
              **[DashboardsCreateSpec](#yandex.cloud.mdb.opensearch.v1.DashboardsCreateSpec)**
              Dashboards configuration.
            $ref: '#/definitions/DashboardsCreateSpec'
          access:
            description: |-
              **[Access](#yandex.cloud.mdb.opensearch.v1.Access)**
              Access policy for external services.
            $ref: '#/definitions/Access'
          snapshotManagement:
            description: |-
              **[SnapshotManagement](#yandex.cloud.mdb.opensearch.v1.SnapshotManagement)**
              Snapshot management configuration
            $ref: '#/definitions/SnapshotManagement'
        required:
          - adminPassword
      AnytimeMaintenanceWindow:
        type: object
        properties: {}
      WeeklyMaintenanceWindow:
        type: object
        properties:
          day:
            description: |-
              **enum** (WeekDay)
              Day of the week.
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
              Hour of the day in the UTC timezone.
            type: string
            format: int64
      MaintenanceWindow:
        type: object
        properties:
          anytime:
            description: |-
              **object**
              An any-time maintenance window.
              Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`.
            $ref: '#/definitions/AnytimeMaintenanceWindow'
          weeklyMaintenanceWindow:
            description: |-
              **[WeeklyMaintenanceWindow](#yandex.cloud.mdb.opensearch.v1.WeeklyMaintenanceWindow)**
              A weekly maintenance window.
              Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`.
            $ref: '#/definitions/WeeklyMaintenanceWindow'
        oneOf:
          - required:
              - anytime
          - required:
              - weeklyMaintenanceWindow
sourcePath: en/_api-ref/mdb/opensearch/v1/api-ref/Cluster/create.md
---

# Managed Service for OpenSearch API, REST: Cluster.Create

Creates an OpenSearch cluster in the specified folder.

## HTTP request

```
POST https://{{ api-host-mdb }}/managed-opensearch/v1/clusters
```

## Body parameters {#yandex.cloud.mdb.opensearch.v1.CreateClusterRequest}

```json
{
  "folderId": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "environment": "string",
  "configSpec": {
    "version": "string",
    "adminPassword": "string",
    "opensearchSpec": {
      "plugins": [
        "string"
      ],
      "nodeGroups": [
        {
          "name": "string",
          "resources": {
            "resourcePresetId": "string",
            "diskSize": "string",
            "diskTypeId": "string"
          },
          "hostsCount": "string",
          "zoneIds": [
            "string"
          ],
          "subnetIds": [
            "string"
          ],
          "assignPublicIp": "boolean",
          "roles": [
            "string"
          ],
          "diskSizeAutoscaling": {
            "plannedUsageThreshold": "string",
            "emergencyUsageThreshold": "string",
            "diskSizeLimit": "string"
          }
        }
      ],
      // Includes only one of the fields `opensearchConfig_2`
      "opensearchConfig_2": {
        "maxClauseCount": "string",
        "fielddataCacheSize": "string",
        "reindexRemoteWhitelist": "string"
      },
      // end of the list of possible fields
      "keystoreSettings": [
        {
          "name": "string",
          "value": "string"
        }
      ]
    },
    "dashboardsSpec": {
      "nodeGroups": [
        {
          "name": "string",
          "resources": {
            "resourcePresetId": "string",
            "diskSize": "string",
            "diskTypeId": "string"
          },
          "hostsCount": "string",
          "zoneIds": [
            "string"
          ],
          "subnetIds": [
            "string"
          ],
          "assignPublicIp": "boolean",
          "diskSizeAutoscaling": {
            "plannedUsageThreshold": "string",
            "emergencyUsageThreshold": "string",
            "diskSizeLimit": "string"
          }
        }
      ]
    },
    "access": {
      "dataTransfer": "boolean",
      "serverless": "boolean"
    },
    "snapshotManagement": {
      "snapshotSchedule": {
        // Includes only one of the fields `hourlySnapshotSchedule`, `dailySnapshotSchedule`, `weeklySnapshotSchedule`
        "hourlySnapshotSchedule": {
          "minute": "string"
        },
        "dailySnapshotSchedule": {
          "hour": "string",
          "minute": "string"
        },
        "weeklySnapshotSchedule": {
          "day": "string",
          "hour": "string",
          "minute": "string"
        }
        // end of the list of possible fields
      },
      "snapshotMaxAgeDays": "string"
    }
  },
  "networkId": "string",
  "securityGroupIds": [
    "string"
  ],
  "serviceAccountId": "string",
  "deletionProtection": "boolean",
  "maintenanceWindow": {
    // Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`
    "anytime": "object",
    "weeklyMaintenanceWindow": {
      "day": "string",
      "hour": "string"
    }
    // end of the list of possible fields
  },
  "diskEncryptionKeyId": "string"
}
```

#|
||Field | Description ||
|| folderId | **string**

Required field. ID of the folder to create the OpenSearch cluster in. ||
|| name | **string**

Required field. Name of the OpenSearch cluster. The name must be unique within the folder. ||
|| description | **string**

Description of the OpenSearch cluster. ||
|| labels | **object** (map<**string**, **string**>)

Custom labels for the OpenSearch cluster as `key:value` pairs.
For example, `"project": "mvp"` or `"source": "dictionary"`. ||
|| environment | **enum** (Environment)

Deployment environment of the OpenSearch cluster.

- `ENVIRONMENT_UNSPECIFIED`
- `PRODUCTION`: Stable environment with a conservative update policy:
only hotfixes are applied during regular maintenance.
- `PRESTABLE`: Environment with more aggressive update policy: new versions
are rolled out irrespective of backward compatibility. ||
|| configSpec | **[ConfigCreateSpec](#yandex.cloud.mdb.opensearch.v1.ConfigCreateSpec)**

Required field. OpenSearch cluster configuration. ||
|| networkId | **string**

Required field. ID of the network to create the cluster in. ||
|| securityGroupIds[] | **string**

User security groups. ||
|| serviceAccountId | **string**

ID of the service account used to access Object Storage. ||
|| deletionProtection | **boolean**

Determines whether the cluster is protected from being deleted. ||
|| maintenanceWindow | **[MaintenanceWindow](#yandex.cloud.mdb.opensearch.v1.MaintenanceWindow)**

Cluster maintenance window. Should be defined by either one of the two options. ||
|| diskEncryptionKeyId | **string**

ID of the key to encrypt cluster disks. ||
|#

## ConfigCreateSpec {#yandex.cloud.mdb.opensearch.v1.ConfigCreateSpec}

#|
||Field | Description ||
|| version | **string**

OpenSearch version. ||
|| adminPassword | **string**

Required field. OpenSearch admin password. ||
|| opensearchSpec | **[OpenSearchCreateSpec](#yandex.cloud.mdb.opensearch.v1.OpenSearchCreateSpec)**

OpenSearch configuration. ||
|| dashboardsSpec | **[DashboardsCreateSpec](#yandex.cloud.mdb.opensearch.v1.DashboardsCreateSpec)**

Dashboards configuration. ||
|| access | **[Access](#yandex.cloud.mdb.opensearch.v1.Access)**

Access policy for external services. ||
|| snapshotManagement | **[SnapshotManagement](#yandex.cloud.mdb.opensearch.v1.SnapshotManagement)**

Snapshot management configuration ||
|#

## OpenSearchCreateSpec {#yandex.cloud.mdb.opensearch.v1.OpenSearchCreateSpec}

OpenSearch create-time configuration.

#|
||Field | Description ||
|| plugins[] | **string**

Names of the cluster plugins. ||
|| nodeGroups[] | **[NodeGroup](#yandex.cloud.mdb.opensearch.v1.OpenSearchCreateSpec.NodeGroup)**

OpenSearch type host groups of the cluster. ||
|| opensearchConfig_2 | **[OpenSearchConfig2](#yandex.cloud.mdb.opensearch.v1.config.OpenSearchConfig2)**

Includes only one of the fields `opensearchConfig_2`. ||
|| keystoreSettings[] | **[KeystoreSetting](#yandex.cloud.mdb.opensearch.v1.KeystoreSetting)**

Initial cluster keystore settings. ||
|#

## NodeGroup {#yandex.cloud.mdb.opensearch.v1.OpenSearchCreateSpec.NodeGroup}

Configuration of the host group.

#|
||Field | Description ||
|| name | **string**

Required field. Name of the group. ||
|| resources | **[Resources](#yandex.cloud.mdb.opensearch.v1.Resources)**

Resources allocated to the hosts. ||
|| hostsCount | **string** (int64)

Number of hosts in the group. ||
|| zoneIds[] | **string**

IDs of the availability zones the hosts belong to. ||
|| subnetIds[] | **string**

IDs of the subnets that the hosts belong to. ||
|| assignPublicIp | **boolean**

Determines whether a public IP is assigned to the hosts in the group. ||
|| roles[] | **enum** (GroupRole)

Roles of the hosts in the group.

- `GROUP_ROLE_UNSPECIFIED`
- `DATA`
- `MANAGER` ||
|| diskSizeAutoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.opensearch.v1.DiskSizeAutoscaling)**

Disk size autoscaling settings ||
|#

## Resources {#yandex.cloud.mdb.opensearch.v1.Resources}

A list of computational resources allocated to a host.

#|
||Field | Description ||
|| resourcePresetId | **string**

ID of the preset for computational resources allocated to a host. ||
|| diskSize | **string** (int64)

Volume of the storage used by the host, in bytes. ||
|| diskTypeId | **string**

Type of the storage used by the host: `network-hdd`, `network-ssd` or `local-ssd`. ||
|#

## DiskSizeAutoscaling {#yandex.cloud.mdb.opensearch.v1.DiskSizeAutoscaling}

#|
||Field | Description ||
|| plannedUsageThreshold | **string** (int64)

Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent. ||
|| emergencyUsageThreshold | **string** (int64)

Amount of used storage for immediately  automatic disk scaling, 0 means disabled, in percent. ||
|| diskSizeLimit | **string** (int64)

Limit on how large the storage for database instances can automatically grow, in bytes. ||
|#

## OpenSearchConfig2 {#yandex.cloud.mdb.opensearch.v1.config.OpenSearchConfig2}

#|
||Field | Description ||
|| maxClauseCount | **string** (int64)

the maximum number of allowed boolean clauses in a query ||
|| fielddataCacheSize | **string**

the percentage or absolute value (10%, 512mb) of heap space that is allocated to fielddata ||
|| reindexRemoteWhitelist | **string** ||
|#

## KeystoreSetting {#yandex.cloud.mdb.opensearch.v1.KeystoreSetting}

Single keystore entry.

#|
||Field | Description ||
|| name | **string**

Keystore entry name. ||
|| value | **string**

Keystore entry value. ||
|#

## DashboardsCreateSpec {#yandex.cloud.mdb.opensearch.v1.DashboardsCreateSpec}

Dashboards create-time configuration.

#|
||Field | Description ||
|| nodeGroups[] | **[NodeGroup](#yandex.cloud.mdb.opensearch.v1.DashboardsCreateSpec.NodeGroup)**

Dashboards type host groups of the cluster. ||
|#

## NodeGroup {#yandex.cloud.mdb.opensearch.v1.DashboardsCreateSpec.NodeGroup}

#|
||Field | Description ||
|| name | **string**

Required field. Name of the group. ||
|| resources | **[Resources](#yandex.cloud.mdb.opensearch.v1.Resources)**

Resources allocated to the hosts. ||
|| hostsCount | **string** (int64)

Number of hosts in the group. ||
|| zoneIds[] | **string**

IDs of the availability zones the hosts belong to. ||
|| subnetIds[] | **string**

IDs of the subnets that the hosts belong to. ||
|| assignPublicIp | **boolean**

Determines whether a public IP is assigned to the hosts in the group. ||
|| diskSizeAutoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.opensearch.v1.DiskSizeAutoscaling)**

Disk size autoscaling settings ||
|#

## Access {#yandex.cloud.mdb.opensearch.v1.Access}

Access policy for external services.

#|
||Field | Description ||
|| dataTransfer | **boolean**

Determines whether the access to Data Transfer is allowed. ||
|| serverless | **boolean**

Determines whether the access to Serverless is allowed. ||
|#

## SnapshotManagement {#yandex.cloud.mdb.opensearch.v1.SnapshotManagement}

Snapshot management configuration

#|
||Field | Description ||
|| snapshotSchedule | **[SnapshotSchedule](#yandex.cloud.mdb.opensearch.v1.SnapshotSchedule)**

Snapshot creation schedule ||
|| snapshotMaxAgeDays | **string** (int64)

Snapshot max age in days ||
|#

## SnapshotSchedule {#yandex.cloud.mdb.opensearch.v1.SnapshotSchedule}

Snapshot creation schedule

#|
||Field | Description ||
|| hourlySnapshotSchedule | **[HourlySnapshotSchedule](#yandex.cloud.mdb.opensearch.v1.HourlySnapshotSchedule)**

Hourly based snapshot schedule

Includes only one of the fields `hourlySnapshotSchedule`, `dailySnapshotSchedule`, `weeklySnapshotSchedule`. ||
|| dailySnapshotSchedule | **[DailySnapshotSchedule](#yandex.cloud.mdb.opensearch.v1.DailySnapshotSchedule)**

Daily based snapshot schedule

Includes only one of the fields `hourlySnapshotSchedule`, `dailySnapshotSchedule`, `weeklySnapshotSchedule`. ||
|| weeklySnapshotSchedule | **[WeeklySnapshotSchedule](#yandex.cloud.mdb.opensearch.v1.WeeklySnapshotSchedule)**

Weekly based snapshot schedule

Includes only one of the fields `hourlySnapshotSchedule`, `dailySnapshotSchedule`, `weeklySnapshotSchedule`. ||
|#

## HourlySnapshotSchedule {#yandex.cloud.mdb.opensearch.v1.HourlySnapshotSchedule}

Hourly based snapshot schedule

#|
||Field | Description ||
|| minute | **string** (int64)

The minute of the hour at which the backup should be created. ||
|#

## DailySnapshotSchedule {#yandex.cloud.mdb.opensearch.v1.DailySnapshotSchedule}

Daily based snapshot schedule

#|
||Field | Description ||
|| hour | **string** (int64)

The hour of the day in UTC timezone at which the backup should be created. ||
|| minute | **string** (int64)

The minute of the hour at which the backup should be created. ||
|#

## WeeklySnapshotSchedule {#yandex.cloud.mdb.opensearch.v1.WeeklySnapshotSchedule}

Weekly based snapshot schedule

#|
||Field | Description ||
|| day | **enum** (WeekDay)

Day of the week

- `WEEK_DAY_UNSPECIFIED`
- `MON`
- `TUE`
- `WED`
- `THU`
- `FRI`
- `SAT`
- `SUN` ||
|| hour | **string** (int64)

The hour of the day in UTC timezone at which the backup should be created. ||
|| minute | **string** (int64)

The minute of the hour at which the backup should be created. ||
|#

## MaintenanceWindow {#yandex.cloud.mdb.opensearch.v1.MaintenanceWindow}

An OpenSearch cluster maintenance window. Should be defined by either one of the two options.

#|
||Field | Description ||
|| anytime | **object**

An any-time maintenance window.

Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`. ||
|| weeklyMaintenanceWindow | **[WeeklyMaintenanceWindow](#yandex.cloud.mdb.opensearch.v1.WeeklyMaintenanceWindow)**

A weekly maintenance window.

Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`. ||
|#

## WeeklyMaintenanceWindow {#yandex.cloud.mdb.opensearch.v1.WeeklyMaintenanceWindow}

A weekly maintenance window.

#|
||Field | Description ||
|| day | **enum** (WeekDay)

Day of the week.

- `WEEK_DAY_UNSPECIFIED`
- `MON`: Monday
- `TUE`: Tuesday
- `WED`: Wednesday
- `THU`: Thursday
- `FRI`: Friday
- `SAT`: Saturday
- `SUN`: Sunday ||
|| hour | **string** (int64)

Hour of the day in the UTC timezone. ||
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
    "operationLog": {
      "entities": [
        {
          "clusterId": "string",
          "action": "string",
          "startedAt": "string",
          "hosts": [
            {
              "fqdn": "string",
              "action": "string",
              "startedAt": "string"
            }
          ]
        }
      ]
    }
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
      "version": "string",
      "opensearch": {
        "plugins": [
          "string"
        ],
        "nodeGroups": [
          {
            "name": "string",
            "resources": {
              "resourcePresetId": "string",
              "diskSize": "string",
              "diskTypeId": "string"
            },
            "hostsCount": "string",
            "zoneIds": [
              "string"
            ],
            "subnetIds": [
              "string"
            ],
            "assignPublicIp": "boolean",
            "roles": [
              "string"
            ],
            "diskSizeAutoscaling": {
              "plannedUsageThreshold": "string",
              "emergencyUsageThreshold": "string",
              "diskSizeLimit": "string"
            }
          }
        ],
        // Includes only one of the fields `opensearchConfigSet_2`
        "opensearchConfigSet_2": {
          "effectiveConfig": {
            "maxClauseCount": "string",
            "fielddataCacheSize": "string",
            "reindexRemoteWhitelist": "string"
          },
          "userConfig": {
            "maxClauseCount": "string",
            "fielddataCacheSize": "string",
            "reindexRemoteWhitelist": "string"
          },
          "defaultConfig": {
            "maxClauseCount": "string",
            "fielddataCacheSize": "string",
            "reindexRemoteWhitelist": "string"
          }
        },
        // end of the list of possible fields
        "keystoreSettings": [
          "string"
        ]
      },
      "dashboards": {
        "nodeGroups": [
          {
            "name": "string",
            "resources": {
              "resourcePresetId": "string",
              "diskSize": "string",
              "diskTypeId": "string"
            },
            "hostsCount": "string",
            "zoneIds": [
              "string"
            ],
            "subnetIds": [
              "string"
            ],
            "assignPublicIp": "boolean",
            "diskSizeAutoscaling": {
              "plannedUsageThreshold": "string",
              "emergencyUsageThreshold": "string",
              "diskSizeLimit": "string"
            }
          }
        ]
      },
      "access": {
        "dataTransfer": "boolean",
        "serverless": "boolean"
      },
      "snapshotManagement": {
        "snapshotSchedule": {
          // Includes only one of the fields `hourlySnapshotSchedule`, `dailySnapshotSchedule`, `weeklySnapshotSchedule`
          "hourlySnapshotSchedule": {
            "minute": "string"
          },
          "dailySnapshotSchedule": {
            "hour": "string",
            "minute": "string"
          },
          "weeklySnapshotSchedule": {
            "day": "string",
            "hour": "string",
            "minute": "string"
          }
          // end of the list of possible fields
        },
        "snapshotMaxAgeDays": "string"
      }
    },
    "networkId": "string",
    "health": "string",
    "status": "string",
    "securityGroupIds": [
      "string"
    ],
    "serviceAccountId": "string",
    "deletionProtection": "boolean",
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
    "diskEncryptionKeyId": "string"
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
|| metadata | **[CreateClusterMetadata](#yandex.cloud.mdb.opensearch.v1.CreateClusterMetadata)**

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
|| response | **[Cluster](#yandex.cloud.mdb.opensearch.v1.Cluster)**

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

## CreateClusterMetadata {#yandex.cloud.mdb.opensearch.v1.CreateClusterMetadata}

#|
||Field | Description ||
|| clusterId | **string**

ID of the OpenSearch cluster that is being created. ||
|| operationLog | **[OperationLog](#yandex.cloud.mdb.operationlog.v1.OperationLog)**

Log of actions during operation ||
|#

## OperationLog {#yandex.cloud.mdb.operationlog.v1.OperationLog}

#|
||Field | Description ||
|| entities[] | **[ClusterEntity](#yandex.cloud.mdb.operationlog.v1.ClusterEntity)** ||
|#

## ClusterEntity {#yandex.cloud.mdb.operationlog.v1.ClusterEntity}

#|
||Field | Description ||
|| clusterId | **string** ||
|| action | **string** ||
|| startedAt | **string** (date-time)

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| hosts[] | **[HostEntity](#yandex.cloud.mdb.operationlog.v1.HostEntity)** ||
|#

## HostEntity {#yandex.cloud.mdb.operationlog.v1.HostEntity}

#|
||Field | Description ||
|| fqdn | **string** ||
|| action | **string** ||
|| startedAt | **string** (date-time)

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
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

## Cluster {#yandex.cloud.mdb.opensearch.v1.Cluster}

An OpenSearch cluster resource.

#|
||Field | Description ||
|| id | **string**

ID of the OpenSearch cluster.
This ID is assigned by the platform at the moment of cluster creation. ||
|| folderId | **string**

ID of the folder that the OpenSearch cluster belongs to. ||
|| createdAt | **string** (date-time)

Time when the cluster was created.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| name | **string**

Name of the OpenSearch cluster.
The name is unique within the folder. 1-63 characters long. ||
|| description | **string**

Description of the OpenSearch cluster. 0-256 characters long. ||
|| labels | **object** (map<**string**, **string**>)

Custom labels for the OpenSearch cluster as `key:value` pairs.
Maximum 64 labels per resource. ||
|| environment | **enum** (Environment)

Deployment environment of the OpenSearch cluster.

- `ENVIRONMENT_UNSPECIFIED`
- `PRODUCTION`: Stable environment with a conservative update policy:
only hotfixes are applied during regular maintenance.
- `PRESTABLE`: Environment with more aggressive update policy: new versions
are rolled out irrespective of backward compatibility. ||
|| monitoring[] | **[Monitoring](#yandex.cloud.mdb.opensearch.v1.Monitoring)**

Description of monitoring systems relevant to the OpenSearch cluster. ||
|| config | **[ClusterConfig](#yandex.cloud.mdb.opensearch.v1.ClusterConfig)**

Configuration of the OpenSearch cluster. ||
|| networkId | **string**

ID of the cloud network that the cluster belongs to. ||
|| health | **enum** (Health)

Aggregated cluster health.

- `HEALTH_UNKNOWN`: Health of the cluster is unknown ([Host.health](/docs/managed-opensearch/api-ref/Cluster/listHosts#yandex.cloud.mdb.opensearch.v1.Host) for every host in the cluster is UNKNOWN).
- `ALIVE`: Cluster is working normally ([Host.health](/docs/managed-opensearch/api-ref/Cluster/listHosts#yandex.cloud.mdb.opensearch.v1.Host) for every host in the cluster is ALIVE).
- `DEAD`: Cluster is inoperable ([Host.health](/docs/managed-opensearch/api-ref/Cluster/listHosts#yandex.cloud.mdb.opensearch.v1.Host) for every host in the cluster is DEAD).
- `DEGRADED`: Cluster is working below capacity ([Host.health](/docs/managed-opensearch/api-ref/Cluster/listHosts#yandex.cloud.mdb.opensearch.v1.Host) for at least one host in the cluster is not ALIVE). ||
|| status | **enum** (Status)

Current state of the cluster.

- `STATUS_UNKNOWN`: Cluster state is unknown.
- `CREATING`: Cluster is being created.
- `RUNNING`: Cluster is running normally.
- `ERROR`: Cluster has encountered a problem and cannot operate.
- `UPDATING`: Cluster is being updated.
- `STOPPING`: Cluster is stopping.
- `STOPPED`: Cluster has stopped.
- `STARTING`: Cluster is starting. ||
|| securityGroupIds[] | **string**

User security groups. ||
|| serviceAccountId | **string**

ID of the service account used to access Object Storage. ||
|| deletionProtection | **boolean**

Determines whether the cluster is protected from being deleted. ||
|| maintenanceWindow | **[MaintenanceWindow](#yandex.cloud.mdb.opensearch.v1.MaintenanceWindow2)**

Cluster maintenance window. Should be defined by either one of the two options. ||
|| plannedOperation | **[MaintenanceOperation](#yandex.cloud.mdb.opensearch.v1.MaintenanceOperation)**

Maintenance operation planned at nearest `maintenanceWindow`. ||
|| diskEncryptionKeyId | **string**

ID of the key to encrypt cluster disks. ||
|#

## Monitoring {#yandex.cloud.mdb.opensearch.v1.Monitoring}

Monitoring system metadata.

#|
||Field | Description ||
|| name | **string**

Name of the monitoring system. ||
|| description | **string**

Description of the monitoring system. ||
|| link | **string**

Link to the monitoring system charts for the OpenSearch cluster. ||
|#

## ClusterConfig {#yandex.cloud.mdb.opensearch.v1.ClusterConfig}

The OpenSearch cluster configuration.

#|
||Field | Description ||
|| version | **string**

Version of the OpenSearch server software. ||
|| opensearch | **[OpenSearch](#yandex.cloud.mdb.opensearch.v1.OpenSearch)**

OpenSearch configuration. ||
|| dashboards | **[Dashboards](#yandex.cloud.mdb.opensearch.v1.Dashboards)**

Dashboards configuration. ||
|| access | **[Access](#yandex.cloud.mdb.opensearch.v1.Access2)**

Access policy for external services. ||
|| snapshotManagement | **[SnapshotManagement](#yandex.cloud.mdb.opensearch.v1.SnapshotManagement2)**

Snapshot management configuration ||
|#

## OpenSearch {#yandex.cloud.mdb.opensearch.v1.OpenSearch}

The OpenSearch host group type configuration.

#|
||Field | Description ||
|| plugins[] | **string**

Names of the cluster plugins. ||
|| nodeGroups[] | **[NodeGroup](#yandex.cloud.mdb.opensearch.v1.OpenSearch.NodeGroup)**

Host groups of the OpenSearch type. ||
|| opensearchConfigSet_2 | **[OpenSearchConfigSet2](#yandex.cloud.mdb.opensearch.v1.config.OpenSearchConfigSet2)**

Includes only one of the fields `opensearchConfigSet_2`. ||
|| keystoreSettings[] | **string**

Keystore entries names. ||
|#

## NodeGroup {#yandex.cloud.mdb.opensearch.v1.OpenSearch.NodeGroup}

Configuration of the host group.

#|
||Field | Description ||
|| name | **string**

Name of the group. Must be 1-63 characters long. ||
|| resources | **[Resources](#yandex.cloud.mdb.opensearch.v1.Resources2)**

Resources allocated to the hosts. ||
|| hostsCount | **string** (int64)

Number of hosts in the group. ||
|| zoneIds[] | **string**

IDs of the availability zones the hosts belong to. ||
|| subnetIds[] | **string**

IDs of the subnets that the hosts belong to. ||
|| assignPublicIp | **boolean**

Determines whether a public IP is assigned to the hosts in the group. ||
|| roles[] | **enum** (GroupRole)

Roles of the host group.

- `GROUP_ROLE_UNSPECIFIED`
- `DATA`
- `MANAGER` ||
|| diskSizeAutoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.opensearch.v1.DiskSizeAutoscaling2)**

Disk size autoscaling settings ||
|#

## Resources {#yandex.cloud.mdb.opensearch.v1.Resources2}

A list of computational resources allocated to a host.

#|
||Field | Description ||
|| resourcePresetId | **string**

ID of the preset for computational resources allocated to a host. ||
|| diskSize | **string** (int64)

Volume of the storage used by the host, in bytes. ||
|| diskTypeId | **string**

Type of the storage used by the host: `network-hdd`, `network-ssd` or `local-ssd`. ||
|#

## DiskSizeAutoscaling {#yandex.cloud.mdb.opensearch.v1.DiskSizeAutoscaling2}

#|
||Field | Description ||
|| plannedUsageThreshold | **string** (int64)

Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent. ||
|| emergencyUsageThreshold | **string** (int64)

Amount of used storage for immediately  automatic disk scaling, 0 means disabled, in percent. ||
|| diskSizeLimit | **string** (int64)

Limit on how large the storage for database instances can automatically grow, in bytes. ||
|#

## OpenSearchConfigSet2 {#yandex.cloud.mdb.opensearch.v1.config.OpenSearchConfigSet2}

#|
||Field | Description ||
|| effectiveConfig | **[OpenSearchConfig2](#yandex.cloud.mdb.opensearch.v1.config.OpenSearchConfig22)**

Required field.  ||
|| userConfig | **[OpenSearchConfig2](#yandex.cloud.mdb.opensearch.v1.config.OpenSearchConfig22)** ||
|| defaultConfig | **[OpenSearchConfig2](#yandex.cloud.mdb.opensearch.v1.config.OpenSearchConfig22)** ||
|#

## OpenSearchConfig2 {#yandex.cloud.mdb.opensearch.v1.config.OpenSearchConfig22}

#|
||Field | Description ||
|| maxClauseCount | **string** (int64)

the maximum number of allowed boolean clauses in a query ||
|| fielddataCacheSize | **string**

the percentage or absolute value (10%, 512mb) of heap space that is allocated to fielddata ||
|| reindexRemoteWhitelist | **string** ||
|#

## Dashboards {#yandex.cloud.mdb.opensearch.v1.Dashboards}

The Dashboards host group type configuration.

#|
||Field | Description ||
|| nodeGroups[] | **[NodeGroup](#yandex.cloud.mdb.opensearch.v1.Dashboards.NodeGroup)**

Host groups of the Dashboards type. ||
|#

## NodeGroup {#yandex.cloud.mdb.opensearch.v1.Dashboards.NodeGroup}

#|
||Field | Description ||
|| name | **string**

Name of the group. 1-63 characters long. ||
|| resources | **[Resources](#yandex.cloud.mdb.opensearch.v1.Resources2)**

Resources allocated to the hosts. ||
|| hostsCount | **string** (int64)

Number of hosts in the group. ||
|| zoneIds[] | **string**

IDs of the availability zones the hosts belong to. ||
|| subnetIds[] | **string**

IDs of the subnets that the hosts belong to. ||
|| assignPublicIp | **boolean**

Determines whether a public IP is assigned to the hosts in the group. ||
|| diskSizeAutoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.opensearch.v1.DiskSizeAutoscaling2)**

Disk size autoscaling settings ||
|#

## Access {#yandex.cloud.mdb.opensearch.v1.Access2}

Access policy for external services.

#|
||Field | Description ||
|| dataTransfer | **boolean**

Determines whether the access to Data Transfer is allowed. ||
|| serverless | **boolean**

Determines whether the access to Serverless is allowed. ||
|#

## SnapshotManagement {#yandex.cloud.mdb.opensearch.v1.SnapshotManagement2}

Snapshot management configuration

#|
||Field | Description ||
|| snapshotSchedule | **[SnapshotSchedule](#yandex.cloud.mdb.opensearch.v1.SnapshotSchedule2)**

Snapshot creation schedule ||
|| snapshotMaxAgeDays | **string** (int64)

Snapshot max age in days ||
|#

## SnapshotSchedule {#yandex.cloud.mdb.opensearch.v1.SnapshotSchedule2}

Snapshot creation schedule

#|
||Field | Description ||
|| hourlySnapshotSchedule | **[HourlySnapshotSchedule](#yandex.cloud.mdb.opensearch.v1.HourlySnapshotSchedule2)**

Hourly based snapshot schedule

Includes only one of the fields `hourlySnapshotSchedule`, `dailySnapshotSchedule`, `weeklySnapshotSchedule`. ||
|| dailySnapshotSchedule | **[DailySnapshotSchedule](#yandex.cloud.mdb.opensearch.v1.DailySnapshotSchedule2)**

Daily based snapshot schedule

Includes only one of the fields `hourlySnapshotSchedule`, `dailySnapshotSchedule`, `weeklySnapshotSchedule`. ||
|| weeklySnapshotSchedule | **[WeeklySnapshotSchedule](#yandex.cloud.mdb.opensearch.v1.WeeklySnapshotSchedule2)**

Weekly based snapshot schedule

Includes only one of the fields `hourlySnapshotSchedule`, `dailySnapshotSchedule`, `weeklySnapshotSchedule`. ||
|#

## HourlySnapshotSchedule {#yandex.cloud.mdb.opensearch.v1.HourlySnapshotSchedule2}

Hourly based snapshot schedule

#|
||Field | Description ||
|| minute | **string** (int64)

The minute of the hour at which the backup should be created. ||
|#

## DailySnapshotSchedule {#yandex.cloud.mdb.opensearch.v1.DailySnapshotSchedule2}

Daily based snapshot schedule

#|
||Field | Description ||
|| hour | **string** (int64)

The hour of the day in UTC timezone at which the backup should be created. ||
|| minute | **string** (int64)

The minute of the hour at which the backup should be created. ||
|#

## WeeklySnapshotSchedule {#yandex.cloud.mdb.opensearch.v1.WeeklySnapshotSchedule2}

Weekly based snapshot schedule

#|
||Field | Description ||
|| day | **enum** (WeekDay)

Day of the week

- `WEEK_DAY_UNSPECIFIED`
- `MON`
- `TUE`
- `WED`
- `THU`
- `FRI`
- `SAT`
- `SUN` ||
|| hour | **string** (int64)

The hour of the day in UTC timezone at which the backup should be created. ||
|| minute | **string** (int64)

The minute of the hour at which the backup should be created. ||
|#

## MaintenanceWindow {#yandex.cloud.mdb.opensearch.v1.MaintenanceWindow2}

An OpenSearch cluster maintenance window. Should be defined by either one of the two options.

#|
||Field | Description ||
|| anytime | **object**

An any-time maintenance window.

Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`. ||
|| weeklyMaintenanceWindow | **[WeeklyMaintenanceWindow](#yandex.cloud.mdb.opensearch.v1.WeeklyMaintenanceWindow2)**

A weekly maintenance window.

Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`. ||
|#

## WeeklyMaintenanceWindow {#yandex.cloud.mdb.opensearch.v1.WeeklyMaintenanceWindow2}

A weekly maintenance window.

#|
||Field | Description ||
|| day | **enum** (WeekDay)

Day of the week.

- `WEEK_DAY_UNSPECIFIED`
- `MON`: Monday
- `TUE`: Tuesday
- `WED`: Wednesday
- `THU`: Thursday
- `FRI`: Friday
- `SAT`: Saturday
- `SUN`: Sunday ||
|| hour | **string** (int64)

Hour of the day in the UTC timezone. ||
|#

## MaintenanceOperation {#yandex.cloud.mdb.opensearch.v1.MaintenanceOperation}

#|
||Field | Description ||
|| info | **string**

The description of the operation. ||
|| delayedUntil | **string** (date-time)

Delay time for the maintenance operation.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| latestMaintenanceTime | **string** (date-time)

Time of the last maintenance window.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| nextMaintenanceWindowTime | **string** (date-time)

Time of the next maintenance window.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|#