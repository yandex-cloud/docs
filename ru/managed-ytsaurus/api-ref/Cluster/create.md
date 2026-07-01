---
editable: false
apiPlayground:
  - url: https://ytsaurus.{{ api-host }}/ytsaurus/v1/clusters
    method: post
    path: null
    query: null
    body:
      type: object
      properties:
        folderId:
          description: |-
            **string**
            Required field. ID of the folder to create the cluster in.
          type: string
        zoneId:
          description: |-
            **string**
            Required field. ID of the availability zone where the cluster resides.
          type: string
        name:
          description: |-
            **string**
            Name of the cluster.
            The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9040104510410-044f]\S{1,61}[a-zA-Z0-9040104510410-044f] `.
          pattern: '[a-zA-Z0-9040104510410-044f]\S{1,61}[a-zA-Z0-9040104510410-044f]'
          type: string
        description:
          description: |-
            **string**
            Description of the cluster.
          type: string
        labels:
          description: |-
            **object** (map<**string**, **string**>)
            Cluster labels as `key:value` pairs.
          type: object
          additionalProperties:
            type: string
        subnetId:
          description: |-
            **string**
            Required field. ID of the subnet to create the cluster in.
          type: string
        securityGroupIds:
          description: |-
            **string**
            IDs of the security groups to attach to the cluster.
          type: array
          items:
            type: string
        spec:
          description: |-
            **[ClusterSpec](#yandex.cloud.ytsaurus.v1.ClusterSpec)**
            Cluster specification.
          $ref: '#/definitions/ClusterSpec'
        maintenanceWindow:
          description: |-
            **[MaintenanceWindow](#yandex.cloud.ytsaurus.v1.MaintenanceWindow)**
            Cluster maintenance window
          $ref: '#/definitions/MaintenanceWindow'
        cidrBlocksWhitelist:
          description: |-
            **[CidrBlocks](#yandex.cloud.ytsaurus.v1.CidrBlocks)**
            CIDRs whitelist.
          $ref: '#/definitions/CidrBlocks'
      required:
        - folderId
        - zoneId
        - subnetId
      additionalProperties: false
    definitions:
      HddSpec:
        type: object
        properties:
          sizeGb:
            description: |-
              **string** (int64)
              Size of a single HDD disk in GB.
            type: string
            format: int64
          count:
            description: |-
              **string** (int64)
              Total amount of HDD disks.
            type: string
            format: int64
      Changelogs:
        type: object
        properties:
          sizeGb:
            description: |-
              **string** (int64)
              Size of changelogs disk in GB.
            type: string
            format: int64
      SsdSpec:
        type: object
        properties:
          sizeGb:
            description: |-
              **string** (int64)
              Size of a single SSD disk in GB.
            type: string
            format: int64
          type:
            description: |-
              **string**
              Type of a SSD disk.
            type: string
          count:
            description: |-
              **string** (int64)
              Total amount of SSD disks.
            type: string
            format: int64
          changelogs:
            description: |-
              **[Changelogs](#yandex.cloud.ytsaurus.v1.StorageSpec.SsdSpec.Changelogs)**
              Configuration of dynamic table changelogs.
            $ref: '#/definitions/Changelogs'
      StorageSpec:
        type: object
        properties:
          hdd:
            description: |-
              **[HddSpec](#yandex.cloud.ytsaurus.v1.StorageSpec.HddSpec)**
              Configuration of cluster HDD strorage.
            $ref: '#/definitions/HddSpec'
          ssd:
            description: |-
              **[SsdSpec](#yandex.cloud.ytsaurus.v1.StorageSpec.SsdSpec)**
              Configuration of cluster SSD strorage
            $ref: '#/definitions/SsdSpec'
      DiskSpec:
        type: object
        properties:
          type:
            description: |-
              **string**
              Type of a disk.
            type: string
          sizeGb:
            description: |-
              **string** (int64)
              Size of a single disk in GB.
            type: string
            format: int64
          locations:
            description: |-
              **string**
              Locations on a disk.
            type: array
            items:
              type: string
          locationQuotasGb:
            description: |-
              **string** (int64)
              Quotas for each location. Must be the same length as locations or empty. Zero value will disable quota for location.
            type: array
            items:
              type: string
              format: int64
      FixedScale:
        type: object
        properties:
          size:
            description: |-
              **string** (int64)
              Amount of exec nodes.
            type: string
            format: int64
      LinearScalingStrategy:
        type: object
        properties:
          cooldownInterval:
            description: |-
              **string** (duration)
              Cooldown interval.
            type: string
            format: duration
          statisticsInterval:
            description: |-
              **string** (duration)
              Statistics interval.
            type: string
            format: duration
          overloadCoefficient:
            description: |-
              **string**
              Overload coefficient.
            type: string
          underloadCoefficient:
            description: |-
              **string**
              Underload coefficient.
            type: string
      AutoScale:
        type: object
        properties:
          minSize:
            description: |-
              **string** (int64)
              Minimal amount of exec nodes.
            type: string
            format: int64
          maxSize:
            description: |-
              **string** (int64)
              Maximum amount of exec nodes.
            type: string
            format: int64
          initialSize:
            description: |-
              **string** (int64)
              Initial amount of exec nodes.
            type: string
            format: int64
          linear:
            description: |-
              **[LinearScalingStrategy](#yandex.cloud.ytsaurus.v1.LinearScalingStrategy)**
              Linear scaling strategy.
              Includes only one of the fields `linear`.
            $ref: '#/definitions/LinearScalingStrategy'
        oneOf:
          - required:
              - linear
      ScalePolicy:
        type: object
        properties:
          fixed:
            description: |-
              **[FixedScale](#yandex.cloud.ytsaurus.v1.ComputeSpec.ScalePolicy.FixedScale)**
              Scale policy that doesn't change number of running exec nodes over time.
              Includes only one of the fields `fixed`, `auto`.
            $ref: '#/definitions/FixedScale'
          auto:
            description: |-
              **[AutoScale](#yandex.cloud.ytsaurus.v1.ComputeSpec.ScalePolicy.AutoScale)**
              Scale policy that can adjust number of running exec nodes within specified range based on some criteria.
              Includes only one of the fields `fixed`, `auto`.
            $ref: '#/definitions/AutoScale'
        oneOf:
          - required:
              - fixed
          - required:
              - auto
      ComputeSpec:
        type: object
        properties:
          preset:
            description: |-
              **string**
              VM configuration preset name.
            type: string
          disks:
            description: |-
              **[DiskSpec](#yandex.cloud.ytsaurus.v1.ComputeSpec.DiskSpec)**
              Configuration of exec node strorage.
            type: array
            items:
              $ref: '#/definitions/DiskSpec'
          scalePolicy:
            description: |-
              **[ScalePolicy](#yandex.cloud.ytsaurus.v1.ComputeSpec.ScalePolicy)**
              Exec nodes scaling policy.
            $ref: '#/definitions/ScalePolicy'
          name:
            description: |-
              **string**
              Name for exec pool.
            type: string
      TabletSpec:
        type: object
        properties:
          preset:
            description: |-
              **string**
              VM configuration preset name.
            type: string
          count:
            description: |-
              **string** (int64)
              Total amount of tablet nodes.
            type: string
            format: int64
      HttpProxySpec:
        type: object
        properties:
          count:
            description: |-
              **string** (int64)
              Total amount of HTTP proxies.
            type: string
            format: int64
      RpcProxySpec:
        type: object
        properties:
          count:
            description: |-
              **string** (int64)
              Total amount of RPC proxies.
            type: string
            format: int64
      TaskProxySpec:
        type: object
        properties:
          count:
            description: |-
              **string** (int64)
              Total amount of task proxies.
            type: string
            format: int64
      ProxySpec:
        type: object
        properties:
          http:
            description: |-
              **[HttpProxySpec](#yandex.cloud.ytsaurus.v1.HttpProxySpec)**
              Configuration of HTTP proxies.
            $ref: '#/definitions/HttpProxySpec'
          rpc:
            description: |-
              **[RpcProxySpec](#yandex.cloud.ytsaurus.v1.RpcProxySpec)**
              Configuration of rpc proxies.
            $ref: '#/definitions/RpcProxySpec'
          task:
            description: |-
              **[TaskProxySpec](#yandex.cloud.ytsaurus.v1.TaskProxySpec)**
              Configuration of task proxies.
            $ref: '#/definitions/TaskProxySpec'
      OdinSpec:
        type: object
        properties:
          checksTtl:
            description: |-
              **string** (duration)
              TTL of Odin check samples.
            type: string
            format: duration
      ClearTmpCronSpec:
        type: object
        properties:
          interval:
            description: |-
              **string** (duration)
              Script starting interval.
            type: string
            format: duration
          accountUsageRatioSaveTotal:
            description: |-
              **string**
              Total max space usage ratio.
            type: string
          accountUsageRatioSavePerOwner:
            description: |-
              **string**
              Per account max space usage ratio.
            type: string
          maxDirNodeCount:
            description: |-
              **string** (int64)
              Max nodes in every directory.
            type: string
            format: int64
      CronSpec:
        type: object
        properties:
          clearTmp:
            description: |-
              **[ClearTmpCronSpec](#yandex.cloud.ytsaurus.v1.ClearTmpCronSpec)**
              Cluster regular tmp-account cleaning settings.
            $ref: '#/definitions/ClearTmpCronSpec'
      ClientLogging:
        type: object
        properties:
          logGroupId:
            description: |-
              **string**
              ID of cloud logging group.
              Includes only one of the fields `logGroupId`, `folderId`.
              Destination of cloud logging group.
            type: string
          folderId:
            description: |-
              **string**
              ID of cloud logging folder. Used default loging group.
              Includes only one of the fields `logGroupId`, `folderId`.
              Destination of cloud logging group.
            type: string
          serviceAccountId:
            description: |-
              **string**
              ID of Service account used for write logs.
            type: string
          auditLogsEnabled:
            description: |-
              **boolean**
              Enable audit logs.
            type: boolean
        oneOf:
          - required:
              - logGroupId
          - required:
              - folderId
      ExcelSpec:
        type: object
        properties:
          enabled:
            description: |-
              **boolean**
              Enable Excel.
            type: boolean
      ClusterSpec:
        type: object
        properties:
          storage:
            description: |-
              **[StorageSpec](#yandex.cloud.ytsaurus.v1.StorageSpec)**
              Cluster storage configuration.
            $ref: '#/definitions/StorageSpec'
          compute:
            description: |-
              **[ComputeSpec](#yandex.cloud.ytsaurus.v1.ComputeSpec)**
              Cluster exec nodes configuration.
            type: array
            items:
              $ref: '#/definitions/ComputeSpec'
          tablet:
            description: |-
              **[TabletSpec](#yandex.cloud.ytsaurus.v1.TabletSpec)**
              Cluster tablet nodes configuration.
            $ref: '#/definitions/TabletSpec'
          proxy:
            description: |-
              **[ProxySpec](#yandex.cloud.ytsaurus.v1.ProxySpec)**
              Cluster proxies configuration.
            $ref: '#/definitions/ProxySpec'
          odin:
            description: |-
              **[OdinSpec](#yandex.cloud.ytsaurus.v1.OdinSpec)**
              Odin configuration.
            $ref: '#/definitions/OdinSpec'
          flavor:
            description: |-
              **enum** (Flavor)
              Cluster flavor (type).
              - `DEMO`: Demo cluster configuration with minimal system resources. Not fault-tolerant, not for production use.
            type: string
            enum:
              - FLAVOR_UNSPECIFIED
              - DEMO
          cron:
            description: |-
              **[CronSpec](#yandex.cloud.ytsaurus.v1.CronSpec)**
              Cluster regular processing settings.
            $ref: '#/definitions/CronSpec'
          clientLogging:
            description: |-
              **[ClientLogging](#yandex.cloud.ytsaurus.v1.ClientLogging)**
              Client Cloud logging configuration.
            $ref: '#/definitions/ClientLogging'
          excel:
            description: |-
              **[ExcelSpec](#yandex.cloud.ytsaurus.v1.ExcelSpec)**
              Cluster Excel configuration.
            $ref: '#/definitions/ExcelSpec'
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
              Maintenance can be scheduled anytime.
              Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`.
            $ref: '#/definitions/AnytimeMaintenanceWindow'
          weeklyMaintenanceWindow:
            description: |-
              **[WeeklyMaintenanceWindow](#yandex.cloud.ytsaurus.v1.WeeklyMaintenanceWindow)**
              Maintenance is allowed only within the specified weekly window.
              Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`.
            $ref: '#/definitions/WeeklyMaintenanceWindow'
        oneOf:
          - required:
              - anytime
          - required:
              - weeklyMaintenanceWindow
      CidrBlocks:
        type: object
        properties:
          v4CidrBlocks:
            description: |-
              **string**
              IPv4 CIDR blocks.
            type: array
            items:
              type: string
---

# Ytsaurus API, REST: Cluster.Create

Creates a cluster in the specified folder.

## HTTP request

```
POST https://ytsaurus.{{ api-host }}/ytsaurus/v1/clusters
```

## Body parameters {#yandex.cloud.ytsaurus.v1.CreateClusterRequest}

```json
{
  "folderId": "string",
  "zoneId": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "subnetId": "string",
  "securityGroupIds": [
    "string"
  ],
  "spec": {
    "storage": {
      "hdd": {
        "sizeGb": "string",
        "count": "string"
      },
      "ssd": {
        "sizeGb": "string",
        "type": "string",
        "count": "string",
        "changelogs": {
          "sizeGb": "string"
        }
      }
    },
    "compute": [
      {
        "preset": "string",
        "disks": [
          {
            "type": "string",
            "sizeGb": "string",
            "locations": [
              "string"
            ],
            "locationQuotasGb": [
              "string"
            ]
          }
        ],
        "scalePolicy": {
          // Includes only one of the fields `fixed`, `auto`
          "fixed": {
            "size": "string"
          },
          "auto": {
            "minSize": "string",
            "maxSize": "string",
            "initialSize": "string",
            // Includes only one of the fields `linear`
            "linear": {
              "cooldownInterval": "string",
              "statisticsInterval": "string",
              "overloadCoefficient": "string",
              "underloadCoefficient": "string"
            }
            // end of the list of possible fields
          }
          // end of the list of possible fields
        },
        "name": "string"
      }
    ],
    "tablet": {
      "preset": "string",
      "count": "string"
    },
    "proxy": {
      "http": {
        "count": "string"
      },
      "rpc": {
        "count": "string"
      },
      "task": {
        "count": "string"
      }
    },
    "odin": {
      "checksTtl": "string"
    },
    "flavor": "string",
    "cron": {
      "clearTmp": {
        "interval": "string",
        "accountUsageRatioSaveTotal": "string",
        "accountUsageRatioSavePerOwner": "string",
        "maxDirNodeCount": "string"
      }
    },
    "clientLogging": {
      // Includes only one of the fields `logGroupId`, `folderId`
      "logGroupId": "string",
      "folderId": "string",
      // end of the list of possible fields
      "serviceAccountId": "string",
      "auditLogsEnabled": "boolean"
    },
    "excel": {
      "enabled": "boolean"
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
  "cidrBlocksWhitelist": {
    "v4CidrBlocks": [
      "string"
    ]
  }
}
```

#|
||Field | Description ||
|| folderId | **string**

Required field. ID of the folder to create the cluster in. ||
|| zoneId | **string**

Required field. ID of the availability zone where the cluster resides. ||
|| name | **string**

Name of the cluster.

The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9040104510410-044f]\S{1,61}[a-zA-Z0-9040104510410-044f] `. ||
|| description | **string**

Description of the cluster. ||
|| labels | **object** (map<**string**, **string**>)

Cluster labels as `key:value` pairs. ||
|| subnetId | **string**

Required field. ID of the subnet to create the cluster in. ||
|| securityGroupIds[] | **string**

IDs of the security groups to attach to the cluster. ||
|| spec | **[ClusterSpec](#yandex.cloud.ytsaurus.v1.ClusterSpec)**

Cluster specification. ||
|| maintenanceWindow | **[MaintenanceWindow](#yandex.cloud.ytsaurus.v1.MaintenanceWindow)**

Cluster maintenance window ||
|| cidrBlocksWhitelist | **[CidrBlocks](#yandex.cloud.ytsaurus.v1.CidrBlocks)**

CIDRs whitelist. ||
|#

## ClusterSpec {#yandex.cloud.ytsaurus.v1.ClusterSpec}

#|
||Field | Description ||
|| storage | **[StorageSpec](#yandex.cloud.ytsaurus.v1.StorageSpec)**

Cluster storage configuration. ||
|| compute[] | **[ComputeSpec](#yandex.cloud.ytsaurus.v1.ComputeSpec)**

Cluster exec nodes configuration. ||
|| tablet | **[TabletSpec](#yandex.cloud.ytsaurus.v1.TabletSpec)**

Cluster tablet nodes configuration. ||
|| proxy | **[ProxySpec](#yandex.cloud.ytsaurus.v1.ProxySpec)**

Cluster proxies configuration. ||
|| odin | **[OdinSpec](#yandex.cloud.ytsaurus.v1.OdinSpec)**

Odin configuration. ||
|| flavor | **enum** (Flavor)

Cluster flavor (type).

- `DEMO`: Demo cluster configuration with minimal system resources. Not fault-tolerant, not for production use. ||
|| cron | **[CronSpec](#yandex.cloud.ytsaurus.v1.CronSpec)**

Cluster regular processing settings. ||
|| clientLogging | **[ClientLogging](#yandex.cloud.ytsaurus.v1.ClientLogging)**

Client Cloud logging configuration. ||
|| excel | **[ExcelSpec](#yandex.cloud.ytsaurus.v1.ExcelSpec)**

Cluster Excel configuration. ||
|#

## StorageSpec {#yandex.cloud.ytsaurus.v1.StorageSpec}

#|
||Field | Description ||
|| hdd | **[HddSpec](#yandex.cloud.ytsaurus.v1.StorageSpec.HddSpec)**

Configuration of cluster HDD strorage. ||
|| ssd | **[SsdSpec](#yandex.cloud.ytsaurus.v1.StorageSpec.SsdSpec)**

Configuration of cluster SSD strorage ||
|#

## HddSpec {#yandex.cloud.ytsaurus.v1.StorageSpec.HddSpec}

#|
||Field | Description ||
|| sizeGb | **string** (int64)

Size of a single HDD disk in GB. ||
|| count | **string** (int64)

Total amount of HDD disks. ||
|#

## SsdSpec {#yandex.cloud.ytsaurus.v1.StorageSpec.SsdSpec}

#|
||Field | Description ||
|| sizeGb | **string** (int64)

Size of a single SSD disk in GB. ||
|| type | **string**

Type of a SSD disk. ||
|| count | **string** (int64)

Total amount of SSD disks. ||
|| changelogs | **[Changelogs](#yandex.cloud.ytsaurus.v1.StorageSpec.SsdSpec.Changelogs)**

Configuration of dynamic table changelogs. ||
|#

## Changelogs {#yandex.cloud.ytsaurus.v1.StorageSpec.SsdSpec.Changelogs}

#|
||Field | Description ||
|| sizeGb | **string** (int64)

Size of changelogs disk in GB. ||
|#

## ComputeSpec {#yandex.cloud.ytsaurus.v1.ComputeSpec}

#|
||Field | Description ||
|| preset | **string**

VM configuration preset name. ||
|| disks[] | **[DiskSpec](#yandex.cloud.ytsaurus.v1.ComputeSpec.DiskSpec)**

Configuration of exec node strorage. ||
|| scalePolicy | **[ScalePolicy](#yandex.cloud.ytsaurus.v1.ComputeSpec.ScalePolicy)**

Exec nodes scaling policy. ||
|| name | **string**

Name for exec pool. ||
|#

## DiskSpec {#yandex.cloud.ytsaurus.v1.ComputeSpec.DiskSpec}

#|
||Field | Description ||
|| type | **string**

Type of a disk. ||
|| sizeGb | **string** (int64)

Size of a single disk in GB. ||
|| locations[] | **string**

Locations on a disk. ||
|| locationQuotasGb[] | **string** (int64)

Quotas for each location. Must be the same length as locations or empty. Zero value will disable quota for location. ||
|#

## ScalePolicy {#yandex.cloud.ytsaurus.v1.ComputeSpec.ScalePolicy}

#|
||Field | Description ||
|| fixed | **[FixedScale](#yandex.cloud.ytsaurus.v1.ComputeSpec.ScalePolicy.FixedScale)**

Scale policy that doesn't change number of running exec nodes over time.

Includes only one of the fields `fixed`, `auto`. ||
|| auto | **[AutoScale](#yandex.cloud.ytsaurus.v1.ComputeSpec.ScalePolicy.AutoScale)**

Scale policy that can adjust number of running exec nodes within specified range based on some criteria.

Includes only one of the fields `fixed`, `auto`. ||
|#

## FixedScale {#yandex.cloud.ytsaurus.v1.ComputeSpec.ScalePolicy.FixedScale}

#|
||Field | Description ||
|| size | **string** (int64)

Amount of exec nodes. ||
|#

## AutoScale {#yandex.cloud.ytsaurus.v1.ComputeSpec.ScalePolicy.AutoScale}

#|
||Field | Description ||
|| minSize | **string** (int64)

Minimal amount of exec nodes. ||
|| maxSize | **string** (int64)

Maximum amount of exec nodes. ||
|| initialSize | **string** (int64)

Initial amount of exec nodes. ||
|| linear | **[LinearScalingStrategy](#yandex.cloud.ytsaurus.v1.LinearScalingStrategy)**

Linear scaling strategy.

Includes only one of the fields `linear`. ||
|#

## LinearScalingStrategy {#yandex.cloud.ytsaurus.v1.LinearScalingStrategy}

#|
||Field | Description ||
|| cooldownInterval | **string** (duration)

Cooldown interval. ||
|| statisticsInterval | **string** (duration)

Statistics interval. ||
|| overloadCoefficient | **string**

Overload coefficient. ||
|| underloadCoefficient | **string**

Underload coefficient. ||
|#

## TabletSpec {#yandex.cloud.ytsaurus.v1.TabletSpec}

#|
||Field | Description ||
|| preset | **string**

VM configuration preset name. ||
|| count | **string** (int64)

Total amount of tablet nodes. ||
|#

## ProxySpec {#yandex.cloud.ytsaurus.v1.ProxySpec}

#|
||Field | Description ||
|| http | **[HttpProxySpec](#yandex.cloud.ytsaurus.v1.HttpProxySpec)**

Configuration of HTTP proxies. ||
|| rpc | **[RpcProxySpec](#yandex.cloud.ytsaurus.v1.RpcProxySpec)**

Configuration of rpc proxies. ||
|| task | **[TaskProxySpec](#yandex.cloud.ytsaurus.v1.TaskProxySpec)**

Configuration of task proxies. ||
|#

## HttpProxySpec {#yandex.cloud.ytsaurus.v1.HttpProxySpec}

#|
||Field | Description ||
|| count | **string** (int64)

Total amount of HTTP proxies. ||
|#

## RpcProxySpec {#yandex.cloud.ytsaurus.v1.RpcProxySpec}

#|
||Field | Description ||
|| count | **string** (int64)

Total amount of RPC proxies. ||
|#

## TaskProxySpec {#yandex.cloud.ytsaurus.v1.TaskProxySpec}

#|
||Field | Description ||
|| count | **string** (int64)

Total amount of task proxies. ||
|#

## OdinSpec {#yandex.cloud.ytsaurus.v1.OdinSpec}

#|
||Field | Description ||
|| checksTtl | **string** (duration)

TTL of Odin check samples. ||
|#

## CronSpec {#yandex.cloud.ytsaurus.v1.CronSpec}

#|
||Field | Description ||
|| clearTmp | **[ClearTmpCronSpec](#yandex.cloud.ytsaurus.v1.ClearTmpCronSpec)**

Cluster regular tmp-account cleaning settings. ||
|#

## ClearTmpCronSpec {#yandex.cloud.ytsaurus.v1.ClearTmpCronSpec}

#|
||Field | Description ||
|| interval | **string** (duration)

Script starting interval. ||
|| accountUsageRatioSaveTotal | **string**

Total max space usage ratio. ||
|| accountUsageRatioSavePerOwner | **string**

Per account max space usage ratio. ||
|| maxDirNodeCount | **string** (int64)

Max nodes in every directory. ||
|#

## ClientLogging {#yandex.cloud.ytsaurus.v1.ClientLogging}

#|
||Field | Description ||
|| logGroupId | **string**

ID of cloud logging group.

Includes only one of the fields `logGroupId`, `folderId`.

Destination of cloud logging group. ||
|| folderId | **string**

ID of cloud logging folder. Used default loging group.

Includes only one of the fields `logGroupId`, `folderId`.

Destination of cloud logging group. ||
|| serviceAccountId | **string**

ID of Service account used for write logs. ||
|| auditLogsEnabled | **boolean**

Enable audit logs. ||
|#

## ExcelSpec {#yandex.cloud.ytsaurus.v1.ExcelSpec}

#|
||Field | Description ||
|| enabled | **boolean**

Enable Excel. ||
|#

## MaintenanceWindow {#yandex.cloud.ytsaurus.v1.MaintenanceWindow}

#|
||Field | Description ||
|| anytime | **object**

Maintenance can be scheduled anytime.

Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`. ||
|| weeklyMaintenanceWindow | **[WeeklyMaintenanceWindow](#yandex.cloud.ytsaurus.v1.WeeklyMaintenanceWindow)**

Maintenance is allowed only within the specified weekly window.

Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`. ||
|#

## WeeklyMaintenanceWindow {#yandex.cloud.ytsaurus.v1.WeeklyMaintenanceWindow}

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

## CidrBlocks {#yandex.cloud.ytsaurus.v1.CidrBlocks}

#|
||Field | Description ||
|| v4CidrBlocks[] | **string**

IPv4 CIDR blocks. ||
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