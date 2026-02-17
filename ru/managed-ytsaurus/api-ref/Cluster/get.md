---
editable: false
apiPlayground:
  - url: https://ytsaurus.{{ api-host }}/ytsaurus/v1/clusters/{clusterId}
    method: get
    path:
      type: object
      properties:
        clusterId:
          description: |-
            **string**
            Required field. ID of the cluster to return.
            The maximum string length in characters is 50.
          type: string
      required:
        - clusterId
      additionalProperties: false
    query: null
    body: null
    definitions: null
---

# Ytsaurus API, REST: Cluster.Get

Returns the specified cluster.

## HTTP request

```
GET https://ytsaurus.{{ api-host }}/ytsaurus/v1/clusters/{clusterId}
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the cluster to return.

The maximum string length in characters is 50. ||
|#

## Response {#yandex.cloud.ytsaurus.v1.Cluster}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
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
            "maxSize": "string"
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
      "serviceAccountId": "string",
      // Includes only one of the fields `logGroupId`, `folderId`
      "logGroupId": "string",
      "folderId": "string",
      // end of the list of possible fields
      "auditLogsEnabled": "boolean"
    }
  },
  "createdAt": "string",
  "createdBy": "string",
  "updatedAt": "string",
  "updatedBy": "string",
  "status": "string",
  "health": "string",
  "endpoints": {
    "ui": "string",
    "externalHttpProxyBalancer": "string",
    "internalHttpProxyAlias": "string",
    "internalRpcProxyAlias": "string"
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
|| id | **string**

ID of the cluster. Generated at creation time. ||
|| folderId | **string**

ID of the folder that the cluster belongs to. ||
|| zoneId | **string**

ID of the availability zone where the cluster resides. ||
|| name | **string**

Name of the cluster.
The name is unique within the folder. ||
|| description | **string**

Description of the cluster. ||
|| labels | **object** (map<**string**, **string**>)

Cluster labels as `key:value` pairs. ||
|| subnetId | **string**

ID of the subnet where the cluster resides. ||
|| securityGroupIds[] | **string**

Network interfaces security groups. ||
|| spec | **[ClusterSpec](#yandex.cloud.ytsaurus.v1.ClusterSpec)**

Cluster specification. ||
|| createdAt | **string** (date-time)

Time when the cluster was created.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| createdBy | **string**

User who created the cluster. ||
|| updatedAt | **string** (date-time)

Time when the cluster was last updated.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| updatedBy | **string**

User who last updated the cluster. ||
|| status | **enum** (Status)

Status of the cluster.

- `STATUS_UNKNOWN`: Unknown status.
- `CREATING`: Cluster is being created.
- `RUNNING`: Cluster is running.
- `ERROR`: Cluster encountered a problem and cannot operate.
- `STOPPING`: Cluster is being stopped.
- `STOPPED`: Cluster stopped.
- `STARTING`: Cluster is being started.
- `UPDATING`: Cluster is being updated.
- `DELETING`: Cluster is being deleted. ||
|| health | **enum** (Health)

Health of the cluster.

- `HEALTH_UNKNOWN`: Unknown health.
- `ALIVE`: Cluster is alive.
- `DEAD`: Cluster is dead.
- `DEGRADED`: Cluster is degraded. ||
|| endpoints | **[Endpoints](#yandex.cloud.ytsaurus.v1.Cluster.Endpoints)**

Endpoints of the cluster. ||
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
|| serviceAccountId | **string**

ID of Service account used for write logs. ||
|| logGroupId | **string**

ID of cloud logging group.

Includes only one of the fields `logGroupId`, `folderId`.

Destination of cloud logging group. ||
|| folderId | **string**

ID of cloud logging folder. Used default loging group.

Includes only one of the fields `logGroupId`, `folderId`.

Destination of cloud logging group. ||
|| auditLogsEnabled | **boolean**

Enable audit logs. ||
|#

## Endpoints {#yandex.cloud.ytsaurus.v1.Cluster.Endpoints}

#|
||Field | Description ||
|| ui | **string**

https://CID.ytsaurus.yandexcloud.net ||
|| externalHttpProxyBalancer | **string**

https://proxy.CID.ytsaurus.yandexcloud.net ||
|| internalHttpProxyAlias | **string**

https://hp.CID.ytsaurus.mdb.yandexcloud.net:PORT ||
|| internalRpcProxyAlias | **string**

rp.CID.ytsaurus.mdb.yandexcloud.net:PORT ||
|#

## CidrBlocks {#yandex.cloud.ytsaurus.v1.CidrBlocks}

#|
||Field | Description ||
|| v4CidrBlocks[] | **string**

IPv4 CIDR blocks. ||
|#