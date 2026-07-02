[Документация Yandex Cloud](../../../index.md) > [Yandex Managed Service for YTsaurus](../../index.md) > Справочник API > [REST (англ.)](../index.md) > [Cluster](index.md) > Update

# Ytsaurus API, REST: Cluster.Update

Updates the specified cluster.

## HTTP request

```
PATCH https://ytsaurus.api.cloud.yandex.net/ytsaurus/v1/clusters
```

## Body parameters {#yandex.cloud.ytsaurus.v1.UpdateClusterRequest}

```json
{
  "clusterId": "string",
  "updateMask": "string",
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
|| clusterId | **string**

Required field. ID of the cluster to update.

The maximum string length in characters is 50. ||
|| updateMask | **string** (field-mask)

A comma-separated names off ALL fields to be updated.
Only the specified fields will be changed. The others will be left untouched.
If the field is specified in `` updateMask `` and no value for that field was sent in the request,
the field's value will be reset to the default. The default value for most fields is null or 0.

If `` updateMask `` is not sent in the request, all fields' values will be updated.
Fields specified in the request will be updated to provided values.
The rest of the fields will be reset to the default. ||
|| name | **string**

New name for the cluster.
The name must be unique within the folder. ||
|| description | **string**

New description for the cluster. ||
|| labels | **object** (map<**string**, **string**>)

Cluster labels as `key:value` pairs.
Existing set of labels is completely replaced by the provided set, so if you just want
to add or remove a label:
1. Get the current set of labels with a [ClusterService.Get](../../../ytsaurus/api-ref/Cluster/get#Get) request.
2. Add or remove a label in this set.
3. Send the new set in this field. ||
|| subnetId | **string**

New subnet for the cluster. ||
|| securityGroupIds[] | **string**

New security groups for the cluster. ||
|| spec | **[ClusterSpec](#yandex.cloud.ytsaurus.v1.ClusterSpec)**

New cluster specification. ||
|| maintenanceWindow | **[MaintenanceWindow](#yandex.cloud.ytsaurus.v1.MaintenanceWindow)**

New cluster maintenance window ||
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

An Operation resource. For more information, see [Operation](../../../api-design-guide/concepts/operation.md).

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