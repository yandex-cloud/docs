---
editable: false
---

# Ytsaurus API, gRPC: ClusterService.List

Retrieves the list of clusters in the specified folder.

## gRPC request

**rpc List ([ListClustersRequest](#yandex.cloud.ytsaurus.v1.ListClustersRequest)) returns ([ListClustersResponse](#yandex.cloud.ytsaurus.v1.ListClustersResponse))**

## ListClustersRequest {#yandex.cloud.ytsaurus.v1.ListClustersRequest}

```json
{
  "folder_id": "string",
  "page_size": "int64",
  "page_token": "string",
  "filter": [
    "string"
  ]
}
```

#|
||Field | Description ||
|| folder_id | **string**

Required field. ID of the folder to list clusters in. ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `page_size`, the service returns a [ListClustersResponse.next_page_token](#yandex.cloud.ytsaurus.v1.ListClustersResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100. ||
|| page_token | **string**

Page token. To get the next page of results, set `page_token` to the
[ListClustersResponse.next_page_token](#yandex.cloud.ytsaurus.v1.ListClustersResponse) returned by a previous list request. ||
|| filter[] | **string**

A filter expression that filters clusters listed in the response. ||
|#

## ListClustersResponse {#yandex.cloud.ytsaurus.v1.ListClustersResponse}

```json
{
  "clusters": [
    {
      "id": "string",
      "folder_id": "string",
      "zone_id": "string",
      "name": "string",
      "description": "string",
      "labels": "map<string, string>",
      "subnet_id": "string",
      "security_group_ids": [
        "string"
      ],
      "spec": {
        "storage": {
          "hdd": {
            "size_gb": "int64",
            "count": "int64"
          },
          "ssd": {
            "size_gb": "int64",
            "type": "string",
            "count": "int64",
            "changelogs": {
              "size_gb": "int64"
            }
          }
        },
        "compute": [
          {
            "preset": "string",
            "disks": [
              {
                "type": "string",
                "size_gb": "int64",
                "locations": [
                  "string"
                ]
              }
            ],
            "scale_policy": {
              // Includes only one of the fields `fixed`, `auto`
              "fixed": {
                "size": "int64"
              },
              "auto": {
                "min_size": "int64",
                "max_size": "int64"
              }
              // end of the list of possible fields
            },
            "name": "string"
          }
        ],
        "tablet": {
          "preset": "string",
          "count": "int64"
        },
        "proxy": {
          "http": {
            "count": "int64"
          },
          "rpc": {
            "count": "int64"
          }
        },
        "odin": {
          "checks_ttl": "google.protobuf.Duration"
        },
        "flavor": "Flavor",
        "cron": {
          "clear_tmp": {
            "interval": "google.protobuf.Duration",
            "account_usage_ratio_save_total": "double",
            "account_usage_ratio_save_per_owner": "double",
            "max_dir_node_count": "int64"
          }
        },
        "client_logging": {
          "service_account_id": "string",
          // Includes only one of the fields `log_group_id`, `folder_id`
          "log_group_id": "string",
          "folder_id": "string",
          // end of the list of possible fields
          "audit_logs_enabled": "bool"
        }
      },
      "created_at": "google.protobuf.Timestamp",
      "created_by": "string",
      "updated_at": "google.protobuf.Timestamp",
      "updated_by": "string",
      "status": "Status",
      "health": "Health",
      "endpoints": {
        "ui": "string",
        "external_http_proxy_balancer": "string",
        "internal_http_proxy_alias": "string",
        "internal_rpc_proxy_alias": "string"
      },
      "cidr_blocks_whitelist": {
        "v4_cidr_blocks": [
          "string"
        ]
      }
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| clusters[] | **[Cluster](#yandex.cloud.ytsaurus.v1.Cluster)**

List of clusters in the specified folder. ||
|| next_page_token | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListClustersRequest.page_size](#yandex.cloud.ytsaurus.v1.ListClustersRequest), use the `next_page_token` as the value
for the [ListClustersRequest.page_token](#yandex.cloud.ytsaurus.v1.ListClustersRequest) query parameter in the next list request.
Each subsequent list request will have its own `next_page_token` to continue paging through the results. ||
|#

## Cluster {#yandex.cloud.ytsaurus.v1.Cluster}

#|
||Field | Description ||
|| id | **string**

ID of the cluster. Generated at creation time. ||
|| folder_id | **string**

ID of the folder that the cluster belongs to. ||
|| zone_id | **string**

ID of the availability zone where the cluster resides. ||
|| name | **string**

Name of the cluster.
The name is unique within the folder. ||
|| description | **string**

Description of the cluster. ||
|| labels | **object** (map<**string**, **string**>)

Cluster labels as `key:value` pairs. ||
|| subnet_id | **string**

ID of the subnet where the cluster resides. ||
|| security_group_ids[] | **string**

Network interfaces security groups. ||
|| spec | **[ClusterSpec](#yandex.cloud.ytsaurus.v1.ClusterSpec)**

Cluster specification. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time when the cluster was created. ||
|| created_by | **string**

User who created the cluster. ||
|| updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time when the cluster was last updated. ||
|| updated_by | **string**

User who last updated the cluster. ||
|| status | enum **Status**

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
|| health | enum **Health**

Health of the cluster.

- `HEALTH_UNKNOWN`: Unknown health.
- `ALIVE`: Cluster is alive.
- `DEAD`: Cluster is dead.
- `DEGRADED`: Cluster is degraded. ||
|| endpoints | **[Endpoints](#yandex.cloud.ytsaurus.v1.Cluster.Endpoints)**

Endpoints of the cluster. ||
|| cidr_blocks_whitelist | **[CidrBlocks](#yandex.cloud.ytsaurus.v1.CidrBlocks)**

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
|| flavor | enum **Flavor**

Cluster flavor (type).

- `DEMO`: Demo cluster configuration with minimal system resources. Not fault-tolerant, not for production use. ||
|| cron | **[CronSpec](#yandex.cloud.ytsaurus.v1.CronSpec)**

Cluster regular processing settings. ||
|| client_logging | **[ClientLogging](#yandex.cloud.ytsaurus.v1.ClientLogging)**

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
|| size_gb | **int64**

Size of a single HDD disk in GB. ||
|| count | **int64**

Total amount of HDD disks. ||
|#

## SsdSpec {#yandex.cloud.ytsaurus.v1.StorageSpec.SsdSpec}

#|
||Field | Description ||
|| size_gb | **int64**

Size of a single SSD disk in GB. ||
|| type | **string**

Type of a SSD disk. ||
|| count | **int64**

Total amount of SSD disks. ||
|| changelogs | **[Changelogs](#yandex.cloud.ytsaurus.v1.StorageSpec.SsdSpec.Changelogs)**

Configuration of dynamic table changelogs. ||
|#

## Changelogs {#yandex.cloud.ytsaurus.v1.StorageSpec.SsdSpec.Changelogs}

#|
||Field | Description ||
|| size_gb | **int64**

Size of changelogs disk in GB. ||
|#

## ComputeSpec {#yandex.cloud.ytsaurus.v1.ComputeSpec}

#|
||Field | Description ||
|| preset | **string**

VM configuration preset name. ||
|| disks[] | **[DiskSpec](#yandex.cloud.ytsaurus.v1.ComputeSpec.DiskSpec)**

Configuration of exec node strorage. ||
|| scale_policy | **[ScalePolicy](#yandex.cloud.ytsaurus.v1.ComputeSpec.ScalePolicy)**

Exec nodes scaling policy. ||
|| name | **string**

Name for exec pool. ||
|#

## DiskSpec {#yandex.cloud.ytsaurus.v1.ComputeSpec.DiskSpec}

#|
||Field | Description ||
|| type | **string**

Type of a disk. ||
|| size_gb | **int64**

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
|| size | **int64**

Amount of exec nodes. ||
|#

## AutoScale {#yandex.cloud.ytsaurus.v1.ComputeSpec.ScalePolicy.AutoScale}

#|
||Field | Description ||
|| min_size | **int64**

Minimal amount of exec nodes. ||
|| max_size | **int64**

Maximum amount of exec nodes. ||
|#

## TabletSpec {#yandex.cloud.ytsaurus.v1.TabletSpec}

#|
||Field | Description ||
|| preset | **string**

VM configuration preset name. ||
|| count | **int64**

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
|| count | **int64**

Total amount of HTTP proxies. ||
|#

## RpcProxySpec {#yandex.cloud.ytsaurus.v1.RpcProxySpec}

#|
||Field | Description ||
|| count | **int64**

Total amount of RPC proxies. ||
|#

## OdinSpec {#yandex.cloud.ytsaurus.v1.OdinSpec}

#|
||Field | Description ||
|| checks_ttl | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

TTL of Odin check samples. ||
|#

## CronSpec {#yandex.cloud.ytsaurus.v1.CronSpec}

#|
||Field | Description ||
|| clear_tmp | **[ClearTmpCronSpec](#yandex.cloud.ytsaurus.v1.ClearTmpCronSpec)**

Cluster regular tmp-account cleaning settings. ||
|#

## ClearTmpCronSpec {#yandex.cloud.ytsaurus.v1.ClearTmpCronSpec}

#|
||Field | Description ||
|| interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Script starting interval. ||
|| account_usage_ratio_save_total | **double**

Total max space usage ratio. ||
|| account_usage_ratio_save_per_owner | **double**

Per account max space usage ratio. ||
|| max_dir_node_count | **int64**

Max nodes in every directory. ||
|#

## ClientLogging {#yandex.cloud.ytsaurus.v1.ClientLogging}

#|
||Field | Description ||
|| service_account_id | **string**

ID of Service account used for write logs. ||
|| log_group_id | **string**

ID of cloud logging group.

Includes only one of the fields `log_group_id`, `folder_id`.

Destination of cloud logging group. ||
|| folder_id | **string**

ID of cloud logging folder. Used default loging group.

Includes only one of the fields `log_group_id`, `folder_id`.

Destination of cloud logging group. ||
|| audit_logs_enabled | **bool**

Enable audit logs. ||
|#

## Endpoints {#yandex.cloud.ytsaurus.v1.Cluster.Endpoints}

#|
||Field | Description ||
|| ui | **string**

https://CID.ytsaurus.yandexcloud.net ||
|| external_http_proxy_balancer | **string**

https://proxy.CID.ytsaurus.yandexcloud.net ||
|| internal_http_proxy_alias | **string**

https://hp.CID.ytsaurus.mdb.yandexcloud.net:PORT ||
|| internal_rpc_proxy_alias | **string**

rp.CID.ytsaurus.mdb.yandexcloud.net:PORT ||
|#

## CidrBlocks {#yandex.cloud.ytsaurus.v1.CidrBlocks}

#|
||Field | Description ||
|| v4_cidr_blocks[] | **string**

IPv4 CIDR blocks. ||
|#